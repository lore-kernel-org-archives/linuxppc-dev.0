Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 62BF3DDEF3
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 02:43:02 +1000 (EST)
In-Reply-To: <11756161753280-git-send-email-timur@freescale.com>
References: <11756161753280-git-send-email-timur@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F4B76190-37C3-453C-B4F0-C1CB7CC0532E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: change rheap functions to use long integers
	instead of pointers
Date: Wed, 4 Apr 2007 11:42:17 -0500
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, tnt@246tNt.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 3, 2007, at 11:02 AM, Timur Tabi wrote:

> (This patch is currently for review only.  It is based on Paul's  
> for-2.6.22
> branch.  Please note that the code in this branch is missing many  
> fixes for
> 2.6.21, and so some code will not compile.  Specifially, ARCH=ppc  
> is very
> broken.)
>
> The rheap allocation functions are coded to return a pointer, but  
> the actual
> value returned is an offset into a buffer.  Callers of rheap_alloc 
> () typically
> cast the return value to an integer.  Similarly, rheap_free() took  
> a pointer
> as a parameter, when it should be an unsigned long.
>
> This patch changes all of the relevant rheap functions to use an  
> unsigned long
> instead of a pointer.  The allocation functions return a signed  
> long, where a
> negative number indicates error.
>
> All code which calls the rheap functions is updated accordingly.   
> Macros
> IS_MURAM_ERR() and IS_DPERR() have been deleted.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>

I'm concerned the error handling isn't correctly.  What happens if  
the rheap I'm managing has addresses at 0xf0000000.  When I compare  
offset to 0, its going to report as an error, even if the offset  
returned is valid.

- k
