Return-Path: <Lee.Schermerhorn@hp.com>
Received: from g1t0028.austin.hp.com (g1t0028.austin.hp.com [15.216.28.35])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bastion.smtp.hp.com",
	Issuer "VeriSign Class 3 Secure Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BF8E2DDE9E
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 04:54:15 +1100 (EST)
Subject: Re: [PATCH] numactl: fix libnuma on big-endian 64-bit systems
From: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200812041834.45931.arnd@arndb.de>
References: <200812041834.45931.arnd@arndb.de>
Content-Type: text/plain
Date: Thu, 04 Dec 2008 12:46:56 -0500
Message-Id: <1228412816.6959.48.camel@lts-notebook>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Mijo Safradin <safradin@de.ibm.com>,
	Cliff Wickman <cpw@sgi.com>, Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-12-04 at 18:34 +0100, Arnd Bergmann wrote:
> The read-mask function assumes that it is running in 32-bit mode,
> by addressing the bitmask as a series of int values, instead of
> longs. This is broken as can easily be reproduced by running numademo
> on a bit-endian 64-bit system.
> 
> Changing the addressing to use 'long' values fixes the problem.

Hi, Arnd:

Not sure what you mean here.  If the patch below is a proposed fix [I
don't see a 'Signed-off-by:", but maybe not needed for libnuma
patches?], the description above doesn't match the code.  Looks like
you're changing the addressing FROM 'long' values to use 'int' values so
that the size is compatible between 32- and 64-bits.  Or is that a
reverse patch/diff below?

Lee


> Reported-by: Mijo Safradin <safradin@de.ibm.com>
> 
> ---
> 
> Note: the set_nodemask_size() function is broken as well, it seems
> to always set the nodemask size to "17" with the s2nbits implementation.
> The fallback path in there looks correct.
> 
> --- a/libnuma.c	2008-12-04 14:25:30.000000000 +0100
> +++ b/libnuma.c	2008-11-20 13:40:29.000000000 +0100
> @@ -392,9 +372,9 @@ read_mask(char *s, struct bitmask *bmp)
>  {
>  	char *end = s;
>  	char *prevend;
> -	unsigned long *start = bmp->maskp;
> -	unsigned long *p = start;
> -	unsigned long *q;
> +	unsigned int *start = (unsigned int *)bmp->maskp;
> +	unsigned int *p = start;
> +	unsigned int *q;
>  	unsigned int i;
>  	unsigned int n = 0;
>  
> @@ -431,14 +411,14 @@
>  	}
>  
>  	/* Poor mans fls() */
> -	for(i = sizeof(long) * 8 - 1; i >= 0; i--)
> +	for(i = 31; i >= 0; i--)
>  		if (test_bit(i, start + n))
>  			break;
>  
>  	/*
>  	 * Return the last bit set
>  	 */
> -	return ((sizeof(unsigned long)*8) * n) + i;
> +	return ((sizeof(unsigned int)*8) * n) + i;
>  }
>  
>  /*
