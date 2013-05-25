Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4D4A52C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 May 2013 08:44:43 +1000 (EST)
Message-ID: <1369521875.3557.7.camel@pasglop>
Subject: Re: [PATCH] ppc: remove unused devm_ioremap_prot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kyle McMartin <kyle@redhat.com>
Date: Sun, 26 May 2013 08:44:35 +1000
In-Reply-To: <20130525165425.GC30204@redacted.bos.redhat.com>
References: <20130525165425.GC30204@redacted.bos.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2013-05-25 at 12:54 -0400, Kyle McMartin wrote:
> Added in 2008, but has never had any in-tree users, and no other
> architectures provide it. Also remove the header includes that
> the commit b41e5fff added to asm/io.h, and add an include of mutex.h
> for asm/eeh.h, which relied on io.h including device.h to provide
> it.
> 
> Tested ppc64_defconfig in an xcompiler, and it passed... no promises
> I didn't introduce a header mess on some random variant though.
> 
> Signed-off-by: Kyle McMartin <kyle@redhat.com>

It's not used ... yet. It's needed if we ever are to implement
something like devm_ioremap_wc(). I suspect if things like framebuffer
or even IB drivers start using devm this will be needed.

Any specific reason why you want to take it out ?

Cheers,
Ben.

> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -23,6 +23,7 @@
>  
>  #include <linux/init.h>
>  #include <linux/list.h>
> +#include <linux/mutex.h>
>  #include <linux/string.h>
>  
>  struct pci_dev;
> diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
> index dd15e5e..ab503b6 100644
> --- a/arch/powerpc/include/asm/io.h
> +++ b/arch/powerpc/include/asm/io.h
> @@ -24,9 +24,6 @@ extern struct pci_dev *isa_bridge_pcidev;
>  #define arch_has_dev_port()	(isa_bridge_pcidev != NULL)
>  #endif
>  
> -#include <linux/device.h>
> -#include <linux/io.h>
> -
>  #include <linux/compiler.h>
>  #include <asm/page.h>
>  #include <asm/byteorder.h>
> @@ -791,9 +788,6 @@ static inline void * bus_to_virt(unsigned long address)
>  
>  #define clrsetbits_8(addr, clear, set) clrsetbits(8, addr, clear, set)
>  
> -void __iomem *devm_ioremap_prot(struct device *dev, resource_size_t offset,
> -				size_t size, unsigned long flags);
> -
>  #endif /* __KERNEL__ */
>  
>  #endif /* _ASM_POWERPC_IO_H */
> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> index 4504332..bda49b4 100644
> --- a/arch/powerpc/lib/Makefile
> +++ b/arch/powerpc/lib/Makefile
> @@ -12,7 +12,6 @@ CFLAGS_REMOVE_feature-fixups.o = -pg
>  obj-y			:= string.o alloc.o \
>  			   checksum_$(CONFIG_WORD_SIZE).o crtsavres.o
>  obj-$(CONFIG_PPC32)	+= div64.o copy_32.o
> -obj-$(CONFIG_HAS_IOMEM)	+= devres.o
>  
>  obj-$(CONFIG_PPC64)	+= copypage_64.o copyuser_64.o \
>  			   memcpy_64.o usercopy_64.o mem_64.o string.o \
> diff --git a/arch/powerpc/lib/devres.c b/arch/powerpc/lib/devres.c
> deleted file mode 100644
> index 8df55fc..0000000
> --- a/arch/powerpc/lib/devres.c
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -/*
> - * Copyright (C) 2008 Freescale Semiconductor, Inc.
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version
> - * 2 of the License, or (at your option) any later version.
> - */
> -
> -#include <linux/device.h>	/* devres_*(), devm_ioremap_release() */
> -#include <linux/gfp.h>
> -#include <linux/io.h>		/* ioremap_prot() */
> -#include <linux/export.h>	/* EXPORT_SYMBOL() */
> -
> -/**
> - * devm_ioremap_prot - Managed ioremap_prot()
> - * @dev: Generic device to remap IO address for
> - * @offset: BUS offset to map
> - * @size: Size of map
> - * @flags: Page flags
> - *
> - * Managed ioremap_prot().  Map is automatically unmapped on driver
> - * detach.
> - */
> -void __iomem *devm_ioremap_prot(struct device *dev, resource_size_t offset,
> -				 size_t size, unsigned long flags)
> -{
> -	void __iomem **ptr, *addr;
> -
> -	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
> -	if (!ptr)
> -		return NULL;
> -
> -	addr = ioremap_prot(offset, size, flags);
> -	if (addr) {
> -		*ptr = addr;
> -		devres_add(dev, ptr);
> -	} else
> -		devres_free(ptr);
> -
> -	return addr;
> -}
> -EXPORT_SYMBOL(devm_ioremap_prot);
