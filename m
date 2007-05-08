Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp06.au.ibm.com (ausmtp06.au.ibm.com [202.81.18.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E2C54DDE37
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 10:16:12 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp06.au.ibm.com (8.13.8/8.13.8) with ESMTP id l480Hhl84247790
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 10:17:43 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l480Jc40174650
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 10:19:38 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l480G6jd022123
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 10:16:07 +1000
Date: Tue, 8 May 2007 10:16:04 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 7/7] Holly bootwrapper
Message-ID: <20070508001604.GC7449@localhost.localdomain>
References: <1178572962.2990.197.camel@zod.rchland.ibm.com>
	<1178573530.2990.214.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1178573530.2990.214.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 07, 2007 at 04:32:10PM -0500, Josh Boyer wrote:
> Add Holly/Hickory bootwrapper
> 
> Signed-off-by: Stephen Winiecki <stevewin@us.ibm.com>
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> ---
>  arch/powerpc/boot/Makefile |    9 ++++++++-
>  arch/powerpc/boot/holly.c  |   38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 1 deletion(-)
> 
> --- linux-2.6.orig/arch/powerpc/boot/Makefile
> +++ linux-2.6/arch/powerpc/boot/Makefile
> @@ -43,7 +43,7 @@ $(addprefix $(obj)/,$(zlib) gunzip_util.
>  src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
>  		ns16550.c serial.c simple_alloc.c div64.S util.S \
>  		gunzip_util.c elf_util.c $(zlib) devtree.c
> -src-plat := of.c cuboot-83xx.c cuboot-85xx.c
> +src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c
>  src-boot := $(src-wlib) $(src-plat) empty.c
>  
>  src-boot := $(addprefix $(obj)/, $(src-boot))
> @@ -129,6 +129,7 @@ image-$(CONFIG_PPC_CELLEB)		+= zImage.ps
>  image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
>  image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
>  image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
> +image-$(CONFIG_PPC_HOLLY)		+= zImage.holly-elf

Since ELF appears to be the standard image type, I'd suggest just
calling it zImage.holly.

>  image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
>  
>  ifneq ($(CONFIG_DEVICE_TREE),"")
> @@ -164,6 +165,12 @@ $(obj)/zImage.ps3: vmlinux
>  $(obj)/zImage.initrd.ps3: vmlinux
>  	@echo "  WARNING zImage.initrd.ps3 not supported (yet)"
>  
> +$(obj)/zImage.holly-elf: vmlinux $(wrapperbits)
> +	$(call if_changed,wrap,holly,$(obj)/dts/holly.dts,,)
> +
> +$(obj)/zImage.initrd.holly-elf: vmlinux $(wrapperbits) $(obj)/ramdisk.image.gz
> +	$(call if_changed,wrap,holly,$(obj)/dts/holly.dts,,$(obj)/ramdisk.image.gz)

Um.. won't this need corresponding changes to the wrapper script.  I
don't see them..

>  $(obj)/uImage: vmlinux $(wrapperbits)
>  	$(call if_changed,wrap,uboot)
>  
> --- /dev/null
> +++ linux-2.6/arch/powerpc/boot/holly.c
> @@ -0,0 +1,38 @@
> +/*
> + * Copyright 2007 IBM Corporation
> + *
> + * Stephen Winiecki <stevewin@us.ibm.com>
> + * Josh Boyer <jwboyer@linux.vnet.ibm.com>
> + *
> + * Based on earlier code:
> + * Copyright (C) Paul Mackerras 1997.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + */
> +#include <stdarg.h>
> +#include <stddef.h>
> +#include "types.h"
> +#include "elf.h"
> +#include "string.h"
> +#include "stdio.h"
> +#include "page.h"
> +#include "ops.h"
> +#include "io.h"
> +
> +extern char _start[];
> +extern char _end[];
> +extern char _dtb_start[];
> +extern char _dtb_end[];
> +
> +BSS_STACK(4096);
> +
> +void platform_init(unsigned long r3, unsigned long r4, unsigned long r5)
> +{
> +	u32 heapsize = 0x8000000 - (u32)_end; /* 128M */

Urg... careful here.  Can you guarantee that 128M are present at this
point?  I know I do this in Ebony; I need to fix that..

> +	simple_alloc_init(_end, heapsize, 32, 64);
> +	ft_init(_dtb_start, 0, 4);
> +	serial_console_init();
> +}
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
