Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ADD0DDDDF4
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Feb 2008 19:45:50 +1100 (EST)
Subject: Re: [PATCH] Fix ext4 bitops
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bastian Blank <bastian@waldi.eu.org>
In-Reply-To: <20080201200240.GA28566@wavehammer.waldi.eu.org>
References: <20080201200240.GA28566@wavehammer.waldi.eu.org>
Content-Type: text/plain
Date: Sun, 03 Feb 2008 18:36:38 +1100
Message-Id: <1202024198.7208.9.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-02-01 at 21:02 +0100, Bastian Blank wrote:
> Fix ext4 bitops.

Please provide a better description, as it's not obvious at first sight.

> Signed-off-by: Bastian Blank <waldi@debian.org>
> 
> diff --git a/include/asm-powerpc/bitops.h b/include/asm-powerpc/bitops.h
> index 220d9a7..d0980df 100644
> --- a/include/asm-powerpc/bitops.h
> +++ b/include/asm-powerpc/bitops.h
> @@ -363,6 +363,8 @@ unsigned long generic_find_next_le_bit(const unsigned long *addr,
>  				    unsigned long size, unsigned long offset);
>  /* Bitmap functions for the ext2 filesystem */
>  
> +#include <asm-generic/bitops/le.h>

A comment would be useful to indicate that this defines the _le versions
of the bitops as it would be easy to mistake that for something else.

>  #define ext2_set_bit(nr,addr) \
>  	__test_and_set_le_bit((nr), (unsigned long*)addr)
>  #define ext2_clear_bit(nr, addr) \
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
