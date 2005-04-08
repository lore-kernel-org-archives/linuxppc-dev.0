Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 44A4D67B47
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Apr 2005 09:48:54 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20050408153407.GZ3396@smtp.west.cox.net>
References: <4240b916050404033230db0551@mail.gmail.com>
	<20050407171026.GO3396@smtp.west.cox.net>
	<4240b91605040803137e9e7ddc@mail.gmail.com>
	<20050408153407.GZ3396@smtp.west.cox.net>
Content-Type: text/plain
Date: Sat, 09 Apr 2005 09:47:20 +1000
Message-Id: <1113004040.9568.385.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 2.6.12-rc2] ppc32: Fix building 32bit kernel for 64bit
	machines (Was: Re: linux 2.6.12-rc1-bk5 compilation error)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Go for it i

> When building a ppc32 MULTIPLATFORM kernel for a 64bit pmac, we try and
> build certain files or use certain functions that make no sense in that
> context.  This catches the last of these.
> 
> Signed-off-by: Tom Rini <trini@kernel.crashing.org>
> 
> --- linux-2.6.orig/arch/ppc/platforms/pmac_cache.S
> +++ linux-2.6/arch/ppc/platforms/pmac_cache.S
> @@ -28,6 +28,9 @@
>   */
>  
>  _GLOBAL(flush_disable_caches)
> +#ifndef CONFIG_6xx
> +	blr
> +#else
>  BEGIN_FTR_SECTION
>  	b	flush_disable_745x
>  END_FTR_SECTION_IFSET(CPU_FTR_SPEC7450)
> @@ -323,3 +326,4 @@ END_FTR_SECTION_IFSET(CPU_FTR_L3CR)
>  	mtmsr	r11		/* restore DR and EE */
>  	isync
>  	blr
> +#endif	/* CONFIG_6xx */
> --- linux-2.6.orig/arch/ppc/boot/simple/Makefile
> +++ linux-2.6/arch/ppc/boot/simple/Makefile
> @@ -123,10 +123,13 @@ zimageinitrd-$(pcore)			:= zImage.initrd
>           end-$(pcore)			:= pcore
>     cacheflag-$(pcore)			:= -include $(clear_L2_L3)
>  
> +# Really only valid if CONFIG_6xx=y
>        zimage-$(CONFIG_PPC_PREP)		:= zImage-PPLUS
>  zimageinitrd-$(CONFIG_PPC_PREP)		:= zImage.initrd-PPLUS
> +ifeq ($(CONFIG_6xx),y)
>       extra.o-$(CONFIG_PPC_PREP)		:= prepmap.o
>          misc-$(CONFIG_PPC_PREP)		+= misc-prep.o mpc10x_memory.o
> +endif
>           end-$(CONFIG_PPC_PREP)		:= prep
>  
>           end-$(CONFIG_SANDPOINT)	:= sandpoint
> 
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
