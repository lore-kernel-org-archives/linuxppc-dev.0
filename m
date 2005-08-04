Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1C93C67E8B
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Aug 2005 15:16:30 +1000 (EST)
Date: Wed, 3 Aug 2005 22:15:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@lst.de>
Message-Id: <20050803221517.21b54d7e.akpm@osdl.org>
In-Reply-To: <20050802095509.GA32585@lst.de>
References: <20050802095509.GA32585@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] fix gcc4 warning in asm-ppc/time.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Hellwig <hch@lst.de> wrote:
>
> A function must not return a const value, instead use
> __attribute_const__.
> 
> 
> Index: linux-2.6/include/asm/time.h
> ===================================================================
> --- linux-2.6.orig/include/asm/time.h	2005-04-30 10:17:19.000000000 +0200
> +++ linux-2.6/include/asm/time.h	2005-08-01 11:57:12.000000000 +0200
> @@ -10,6 +10,7 @@
>  #define __ASM_TIME_H__
>  
>  #include <linux/config.h>
> +#include <linux/compiler.h>
>  #include <linux/types.h>
>  #include <linux/rtc.h>
>  #include <linux/threads.h>
> @@ -58,7 +59,7 @@
>  /* Accessor functions for the timebase (RTC on 601) registers. */
>  /* If one day CONFIG_POWER is added just define __USE_RTC as 1 */
>  #ifdef CONFIG_6xx
> -extern __inline__ int const __USE_RTC(void) {
> +extern __inline__ int __attribute_const__ __USE_RTC(void) {
>  	return (mfspr(SPRN_PVR)>>16) == 1;
>  }
>  #else

Do we really want to do this?  The above implies that mfspr(SPRN_PVR) will
return the same value across the entire uptime of the kernel.  Is that
true?

Why is this function paying with const anyway?
