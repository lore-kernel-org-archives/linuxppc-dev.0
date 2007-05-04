Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A68E2DDE3E
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 00:35:18 +1000 (EST)
Date: Fri, 4 May 2007 09:36:45 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 5/6] Support for the Ebony 440GP reference board in
	arch/powerpc
Message-ID: <20070504143645.GA10645@lixom.net>
References: <20070504055455.GA25922@localhost.localdomain>
	<20070504055733.8FB7EDDFFD@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070504055733.8FB7EDDFFD@ozlabs.org>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Not much actual board support code in here, nice and clean. :-) Seems
like most of this was boot wrapper enhancements.

Some comments below.


-Olof

On Fri, May 04, 2007 at 03:57:33PM +1000, David Gibson wrote:

> Index: working-2.6/arch/powerpc/kernel/head_44x.S
> ===================================================================
> --- working-2.6.orig/arch/powerpc/kernel/head_44x.S	2007-05-03 10:19:32.000000000 +1000
> +++ working-2.6/arch/powerpc/kernel/head_44x.S	2007-05-04 13:46:51.000000000 +1000
> @@ -709,16 +709,6 @@ _GLOBAL(giveup_fpu)
>  	blr
>  #endif
>  
> -/*
> - * extern void abort(void)
> - *
> - * At present, this routine just applies a system reset.
> - */
> -_GLOBAL(abort)
> -        mfspr   r13,SPRN_DBCR0
> -        oris    r13,r13,DBCR0_RST_SYSTEM@h
> -        mtspr   SPRN_DBCR0,r13
> -

Looks like this rename is really separate from the platform support. Maybe
post it as such in a patch before this one?

Also, I know it was just a rename but you might want to add a "b ."
after it, if for some reason the reset doesn't happen instantly to avoid
executing random code afterwards.

> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ working-2.6/arch/powerpc/platforms/44x/ebony.c	2007-05-04 13:46:51.000000000 +1000
> @@ -0,0 +1,73 @@
> +/*
> + * Ebony board specific routines
> + *
> + * Matt Porter <mporter@kernel.crashing.org>
> + * Copyright 2002-2005 MontaVista Software Inc.
> + *
> + * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
> + * Copyright (c) 2003-2005 Zultys Technologies
> + *
> + * Rewritten and ported to the merged powerpc tree:
> + * Copyright 2007 David Gibson <dwg@au1.ibm.com>, IBM Corporation.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/init.h>
> +#include <asm/machdep.h>
> +#include <asm/prom.h>
> +#include <asm/udbg.h>
> +#include <asm/time.h>
> +#include <asm/uic.h>
> +#include <asm/of_platform.h>
> +
> +#include "44x.h"
> +
> +static struct of_device_id ebony_of_bus[] = {
> +	{ .type = "ibm,plb", },
> +	{ .type = "ibm,opb", },
> +	{ .type = "ibm,ebc", },
> +	{},
> +};
> +
> +static int __init ebony_device_probe(void)
> +{
> +	if (! machine_is(ebony))

Extra space after !

> +		return 0;
> +
> +	of_platform_bus_probe(NULL, ebony_of_bus, NULL);
> +
> +	return 0;
> +}
> +device_initcall(ebony_device_probe);
> +
> +/*
> + * Called very early, MMU is off, device-tree isn't unflattened
> + */
> +static int __init ebony_probe(void)
> +{
> +	unsigned long root = of_get_flat_dt_root();
> +
> +	if (!of_flat_dt_is_compatible(root, "Ebony"))
> +		return 0;
> +
> +	return 1;
> +}
> +
> +static void __init ebony_setup_arch(void)
> +{
> +}
> +
> +define_machine(ebony) {
> +	.name			= "Ebony",
> +	.probe			= ebony_probe,
> +	.setup_arch		= ebony_setup_arch,
> +	.progress		= udbg_progress,
> +	.init_IRQ		= uic_init_tree,
> +	.get_irq		= uic_get_irq,
> +	.restart		= ppc44x_reset_system,
> +	.calibrate_decr		= generic_calibrate_decr,
> +};
> Index: working-2.6/arch/powerpc/platforms/44x/misc_44x.S
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ working-2.6/arch/powerpc/platforms/44x/misc_44x.S	2007-05-04 13:46:51.000000000 +1000
> @@ -0,0 +1,25 @@
> +/*
> + * This file contains miscellaneous low-level functions for PPC 44x.
> + *    Copyright 2007 David Gibson <dwg@au1.ibm.com>, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + *
> + */
> +
> +#include <asm/reg.h>
> +#include <asm/ppc_asm.h>
> +
> +	.text
> +
> +/*
> + * void ppc44x_reset_system(char *cmd)
> + *
> + * At present, this routine just applies a system reset.
> + */
> +_GLOBAL(ppc44x_reset_system)
> +        mfspr   r13,SPRN_DBCR0
> +        oris    r13,r13,DBCR0_RST_SYSTEM@h
> +        mtspr   SPRN_DBCR0,r13
> Index: working-2.6/arch/powerpc/platforms/44x/44x.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ working-2.6/arch/powerpc/platforms/44x/44x.h	2007-05-04 13:46:51.000000000 +1000
> @@ -0,0 +1,7 @@
> +#ifndef __POWERPC_PLATFORMS_44X_44X_H
> +#define __POWERPC_PLATFORMS_44X_44X_H
> +
> +extern void ppc44x_reset_system(char *cmd);
> +
> +#endif /* __POWERPC_PLATFORMS_44X_44X_H */
> +
> Index: working-2.6/arch/powerpc/platforms/44x/Kconfig
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ working-2.6/arch/powerpc/platforms/44x/Kconfig	2007-05-04 13:46:51.000000000 +1000
> @@ -0,0 +1,56 @@
> +#config BAMBOO
> +#	bool "Bamboo"
> +#	depends on 44x
> +#	default n
> +#	select 440EP
> +#	help
> +#	  This option enables support for the IBM PPC440EP evaluation board.
> +
> +config EBONY
> +	bool "Ebony"
> +	depends on 44x
> +	default y
> +	select 440GP
> +	help
> +	  This option enables support for the IBM PPC440GP evaluation board.
> +
> +#config LUAN
> +#	bool "Luan"
> +#	depends on 44x
> +#	default n
> +#	select 440SP
> +#	help
> +#	  This option enables support for the IBM PPC440SP evaluation board.
> +
> +#config OCOTEA
> +#	bool "Ocotea"
> +#	depends on 44x
> +#	default n
> +#	select 440GX
> +#	help
> +#	  This option enables support for the IBM PPC440GX evaluation board.

Any reason you add them commented out?

> +
> +# 44x specific CPU modules, selected based on the board above.
> +config 440EP
> +	bool
> +	select PPC_FPU
> +	select IBM440EP_ERR42
> +
> +config 440GP
> +	bool
> +	select IBM_NEW_EMAC_ZMII
> +
> +config 440GX
> +	bool
> +
> +config 440SP
> +	bool
> +
> +config 440A
> +	bool
> +	depends on 440GX
> +	default y
> +
> +# 44x errata/workaround config symbols, selected by the CPU models above
> +config IBM440EP_ERR42
> +	bool
> Index: working-2.6/arch/powerpc/platforms/Makefile
> ===================================================================
> --- working-2.6.orig/arch/powerpc/platforms/Makefile	2007-02-14 10:58:22.000000000 +1100
> +++ working-2.6/arch/powerpc/platforms/Makefile	2007-05-04 13:46:51.000000000 +1000
> @@ -6,7 +6,8 @@ obj-$(CONFIG_PPC_PMAC)		+= powermac/
>  endif
>  endif
>  obj-$(CONFIG_PPC_CHRP)		+= chrp/
> -obj-$(CONFIG_4xx)		+= 4xx/
> +#obj-$(CONFIG_4xx)		+= 4xx/

Hmm?

> +obj-$(CONFIG_44x)		+= 44x/
>  obj-$(CONFIG_PPC_MPC52xx)	+= 52xx/
>  obj-$(CONFIG_PPC_8xx)		+= 8xx/
>  obj-$(CONFIG_PPC_82xx)		+= 82xx/
> Index: working-2.6/arch/powerpc/platforms/Kconfig
> ===================================================================
> --- working-2.6.orig/arch/powerpc/platforms/Kconfig	2007-05-01 10:04:59.000000000 +1000
> +++ working-2.6/arch/powerpc/platforms/Kconfig	2007-05-04 13:46:51.000000000 +1000
> @@ -42,6 +42,7 @@ source "arch/powerpc/platforms/83xx/Kcon
>  source "arch/powerpc/platforms/85xx/Kconfig"
>  source "arch/powerpc/platforms/86xx/Kconfig"
>  source "arch/powerpc/platforms/embedded6xx/Kconfig"
> +source "arch/powerpc/platforms/44x/Kconfig"
>  #source "arch/powerpc/platforms/4xx/Kconfig
>  
>  config PPC_NATIVE
> Index: working-2.6/arch/powerpc/Kconfig
> ===================================================================
> --- working-2.6.orig/arch/powerpc/Kconfig	2007-05-03 10:19:32.000000000 +1000
> +++ working-2.6/arch/powerpc/Kconfig	2007-05-04 13:46:51.000000000 +1000
> @@ -196,6 +196,7 @@ config 40x
>  config 44x
>  	bool "AMCC 44x"
>  	select PPC_DCR_NATIVE
> +	select WANT_DEVICE_TREE
>  
>  config E200
>  	bool "Freescale e200"
> @@ -260,9 +261,14 @@ config PPC_OF_PLATFORM_PCI
>  	depends on PPC64 # not supported on 32 bits yet
>  	default n
>  
> +config 4xx
> +	bool
> +	depends on 40x || 44x
> +	default y
> +
>  config BOOKE
>  	bool
> -	depends on E200 || E500
> +	depends on E200 || E500 || 44x
>  	default y
>  
>  config FSL_BOOKE
> Index: working-2.6/arch/powerpc/boot/44x.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ working-2.6/arch/powerpc/boot/44x.c	2007-05-04 13:46:51.000000000 +1000
> @@ -0,0 +1,37 @@
> +/*
> + * Copyright 2007 David Gibson, IBM Corporation.
> + *
> + * Based on earlier code:
> + * Copyright 2002-2005 MontaVista Software Inc.
> + * Copyright (c) 2003, 2004 Zultys Technologies
> +
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +#include <stddef.h>
> +#include "types.h"
> +#include "string.h"
> +#include "stdio.h"
> +#include "ops.h"
> +#include "reg.h"
> +#include "dcr.h"
> +
> +/* Read the 44x memory controller to get size of system memory. */
> +void ibm44x_fixup_memsize(void)
> +{
> +	int i;
> +	unsigned long memsize, bank_config;
> +
> +	memsize = 0;
> +	for (i = 0; i < ARRAY_SIZE(sdram_bxcr); i++) {
> +		mtdcr(DCRN_SDRAM0_CFGADDR, sdram_bxcr[i]);
> +		bank_config = mfdcr(DCRN_SDRAM0_CFGDATA);
> +
> +		if (bank_config & SDRAM_CONFIG_BANK_ENABLE)
> +			memsize += SDRAM_CONFIG_BANK_SIZE(bank_config);
> +	}
> +
> +	dt_fixup_memory(0, memsize);
> +}
> Index: working-2.6/arch/powerpc/boot/44x.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ working-2.6/arch/powerpc/boot/44x.h	2007-05-04 13:46:51.000000000 +1000
> @@ -0,0 +1,16 @@
> +/*
> + * PowerPC 44x related functions
> + *
> + * Copyright 2007 David Gibson, IBM Corporation.
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +#ifndef _PPC_BOOT_44X_H_
> +#define _PPC_BOOT_44X_H_
> +
> +void ibm44x_fixup_memsize(void);
> +void ebony_init(void *mac0, void *mac1);
> +
> +#endif /* _PPC_BOOT_44X_H_ */
> Index: working-2.6/arch/powerpc/boot/Makefile
> ===================================================================
> --- working-2.6.orig/arch/powerpc/boot/Makefile	2007-05-04 13:46:50.000000000 +1000
> +++ working-2.6/arch/powerpc/boot/Makefile	2007-05-04 13:46:51.000000000 +1000
> @@ -42,8 +42,9 @@ $(addprefix $(obj)/,$(zlib) main.o): $(a
>  
>  src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
>  		ns16550.c serial.c simple_alloc.c div64.S util.S \
> -		gunzip_util.c elf_util.c $(zlib) devtree.c
> -src-plat := of.c cuboot-83xx.c cuboot-85xx.c
> +		gunzip_util.c elf_util.c $(zlib) devtree.c \
> +		44x.c ebony.c
> +src-plat := of.c cuboot-83xx.c cuboot-85xx.c cuboot-ebony.c treeboot-ebony.c
>  src-boot := $(src-wlib) $(src-plat) empty.c
>  
>  src-boot := $(addprefix $(obj)/, $(src-boot))
> @@ -131,6 +132,7 @@ image-$(CONFIG_PPC_EFIKA)		+= zImage.chr
>  image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
>  image-$(CONFIG_PPC_83xx)		+= cuImage.83xx
>  image-$(CONFIG_PPC_85xx)		+= cuImage.85xx
> +image-$(CONFIG_EBONY)			+= treeImage.ebony cuImage.ebony
>  image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
>  
>  # For 32-bit powermacs, build the COFF and miboot images
> @@ -140,7 +142,8 @@ image-$(CONFIG_PPC_PMAC)	+= zImage.coff 
>  endif
>  
>  initrd-  := $(patsubst zImage%, zImage.initrd%, $(image-n) $(image-))
> -initrd-y := $(patsubst zImage%, zImage.initrd%, $(image-y))
> +initrd-y := $(patsubst zImage%, zImage.initrd%, \
> +		$(patsubst treeImage%, treeImage.initrd%, $(image-y)))
>  initrd-y := $(filter-out $(image-y), $(initrd-y))
>  targets	+= $(image-y) $(initrd-y)
>  
> @@ -170,6 +173,12 @@ dts = $(if $(shell echo $(CONFIG_DEVICE_
>  $(obj)/cuImage.%: vmlinux $(wrapperbits)
>  	$(call if_changed,wrap,cuboot-$*,$(dts))
>  
> +$(obj)/treeImage.%: vmlinux $(wrapperbits)
> +	$(call if_changed,wrap,treeboot-$*,$(dts))
> +
> +$(obj)/treeImage.initrd.%: vmlinux $(wrapperbits)
> +	$(call if_changed,wrap,treeboot-$*,$(dts),,$(obj)/ramdisk.image.gz)
> +
>  $(obj)/zImage:		$(addprefix $(obj)/, $(image-y))
>  	@rm -f $@; ln $< $@
>  $(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))
> @@ -179,7 +188,8 @@ install: $(CONFIGURE) $(addprefix $(obj)
>  	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $<
>  
>  # anything not in $(targets)
> -clean-files += $(image-) $(initrd-) zImage zImage.initrd cuImage.*
> +clean-files += $(image-) $(initrd-) zImage zImage.initrd cuImage.* \
> +	treeImage.*
>  
>  # clean up files cached by wrapper
>  clean-kernel := vmlinux.strip vmlinux.bin
> Index: working-2.6/arch/powerpc/boot/cuboot-ebony.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ working-2.6/arch/powerpc/boot/cuboot-ebony.c	2007-05-04 13:46:51.000000000 +1000
> @@ -0,0 +1,42 @@
> +/*
> + * Old U-boot compatibility for Ebony
> + *
> + * Author: David Gibson <david@gibson.dropbear.id.au>
> + *
> + * Copyright 2007 David Gibson, IBM Corporatio.
> + *   Based on cuboot-83xx.c, which is:
> + * Copyright (c) 2007 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + */
> +
> +#include "ops.h"
> +#include "stdio.h"
> +#include "44x.h"
> +
> +#define TARGET_44x
> +#include "ppcboot.h"
> +
> +static bd_t bd;
> +extern char _end[];
> +
> +BSS_STACK(4096);
> +
> +void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
> +                   unsigned long r6, unsigned long r7)
> +{
> +	unsigned long end_of_ram = bd.bi_memstart + bd.bi_memsize;
> +	unsigned long avail_ram = end_of_ram - (unsigned long)_end;
> +
> +	memcpy(&bd, (bd_t *)r3, sizeof(bd));
> +	loader_info.initrd_addr = r4;
> +	loader_info.initrd_size = r4 ? r5 : 0;
> +	loader_info.cmdline = (char *)r6;
> +	loader_info.cmdline_len = r7 - r6;
> +
> +	simple_alloc_init(_end, avail_ram, 32, 64);
> +
> +	ebony_init(&bd.bi_enetaddr, &bd.bi_enet1addr);
> +}
> Index: working-2.6/arch/powerpc/boot/dcr.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ working-2.6/arch/powerpc/boot/dcr.h	2007-05-04 13:46:51.000000000 +1000
> @@ -0,0 +1,85 @@
> +#ifndef _PPC_BOOT_DCR_H_
> +#define _PPC_BOOT_DCR_H_
> +
> +#define mfdcr(rn) \
> +	({	\
> +		unsigned long rval; \
> +		asm volatile("mfdcr %0,%1" : "=r"(rval) : "i"(rn)); \
> +		rval; \
> +	})
> +#define mtdcr(rn, val) \
> +	asm volatile("mtdcr %0,%1" : : "i"(rn), "r"(val))
> +
> +/* 440GP/440GX SDRAM controller DCRs */
> +#define DCRN_SDRAM0_CFGADDR				0x010
> +#define DCRN_SDRAM0_CFGDATA				0x011
> +
> +#define 	SDRAM0_B0CR				0x40
> +#define 	SDRAM0_B1CR				0x44
> +#define 	SDRAM0_B2CR				0x48
> +#define 	SDRAM0_B3CR				0x4c
> +
> +static const unsigned long sdram_bxcr[] = { SDRAM0_B0CR, SDRAM0_B1CR, SDRAM0_B2CR, SDRAM0_B3CR };
> +
> +#define			SDRAM_CONFIG_BANK_ENABLE        0x00000001
> +#define			SDRAM_CONFIG_SIZE_MASK          0x000e0000
> +#define			SDRAM_CONFIG_BANK_SIZE(reg)	\
> +	(0x00400000 << ((reg & SDRAM_CONFIG_SIZE_MASK) >> 17))

Lots of tabs here? Other powerpc code tends to use
<tab><space><space><space> for the register field defines indentation.

Same for below.

> +
> +/* 440GP Clock, PM, chip control */
> +#define DCRN_CPC0_SR					0x0b0
> +#define DCRN_CPC0_ER					0x0b1
> +#define DCRN_CPC0_FR					0x0b2
> +#define DCRN_CPC0_SYS0					0x0e0
> +#define		CPC0_SYS0_TUNE				0xffc00000
> +#define		CPC0_SYS0_FBDV_MASK			0x003c0000
> +#define		CPC0_SYS0_FBDV(reg)			\
> +	((((((reg) & CPC0_SYS0_FBDV_MASK) >> 18) - 1) & 0xf) + 1)

Would you mind a short comment about why the above math is needed?

> +#define		CPC0_SYS0_FWDVA_MASK			0x00038000
> +#define		CPC0_SYS0_FWDVA(reg)			\
> +	(8 - (((reg) & CPC0_SYS0_FWDVA_MASK) >> 15))
> +#define		CPC0_SYS0_FWDVB_MASK			0x00007000
> +#define		CPC0_SYS0_FWDVB(reg)			\
> +	(8 - (((reg) & CPC0_SYS0_FWDVB_MASK) >> 12))
> +#define		CPC0_SYS0_OPDV_MASK			0x00000c00
> +#define		CPC0_SYS0_OPDV(reg)			\
> +	((((reg) & CPC0_SYS0_OPDV_MASK) >> 10) + 1)
> +#define		CPC0_SYS0_EPDV_MASK			0x00000300
> +#define		CPC0_SYS0_EPDV(reg)			\
> +	((((reg) & CPC0_SYS0_EPDV_MASK) >> 8) + 1)
> +#define		CPC0_SYS0_EXTSL				0x00000080
> +#define		CPC0_SYS0_RW_MASK			0x00000060
> +#define		CPC0_SYS0_RL				0x00000010
> +#define		CPC0_SYS0_ZMIISL_MASK			0x0000000c
> +#define		CPC0_SYS0_BYPASS			0x00000002
> +#define		CPC0_SYS0_NTO1				0x00000001
> +#define DCRN_CPC0_SYS1					0x0e1
> +#define DCRN_CPC0_CUST0					0x0e2
> +#define DCRN_CPC0_CUST1					0x0e3
> +#define DCRN_CPC0_STRP0					0x0e4
> +#define DCRN_CPC0_STRP1					0x0e5
> +#define DCRN_CPC0_STRP2					0x0e6
> +#define DCRN_CPC0_STRP3					0x0e7
> +#define DCRN_CPC0_GPIO					0x0e8
> +#define DCRN_CPC0_PLB					0x0e9
> +#define DCRN_CPC0_CR1					0x0ea
> +#define DCRN_CPC0_CR0					0x0eb
> +#define		CPC0_CR0_SWE				0x80000000
> +#define		CPC0_CR0_CETE				0x40000000
> +#define		CPC0_CR0_U1FCS				0x20000000
> +#define		CPC0_CR0_U0DTE				0x10000000
> +#define		CPC0_CR0_U0DRE				0x08000000
> +#define		CPC0_CR0_U0DC				0x04000000
> +#define		CPC0_CR0_U1DTE				0x02000000
> +#define		CPC0_CR0_U1DRE				0x01000000
> +#define		CPC0_CR0_U1DC				0x00800000
> +#define		CPC0_CR0_U0EC				0x00400000
> +#define		CPC0_CR0_U1EC				0x00200000
> +#define		CPC0_CR0_UDIV_MASK			0x001f0000
> +#define		CPC0_CR0_UDIV(reg)			\
> +	((((reg) & CPC0_CR0_UDIV_MASK) >> 16) + 1)
> +#define DCRN_CPC0_MIRQ0					0x0ec
> +#define DCRN_CPC0_MIRQ1					0x0ed
> +#define DCRN_CPC0_JTAGID				0x0ef
> +
> +#endif	/* _PPC_BOOT_DCR_H_ */
> Index: working-2.6/arch/powerpc/boot/ebony.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ working-2.6/arch/powerpc/boot/ebony.c	2007-05-04 13:46:51.000000000 +1000
> @@ -0,0 +1,125 @@
> +/*
> + * Copyright 2007 David Gibson, IBM Corporation.
> + *
> + * Based on earlier code:
> + * Copyright (C) Paul Mackerras 1997.
> + * Copyright 2002-2005 MontaVista Software Inc.
> + * Copyright (c) 2003, 2004 Zultys Technologies
> +
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +#include <stdarg.h>
> +#include <stddef.h>
> +#include "types.h"
> +#include "elf.h"
> +#include "string.h"
> +#include "stdio.h"
> +#include "page.h"
> +#include "ops.h"
> +#include "reg.h"
> +#include "dcr.h"
> +#include "44x.h"
> +
> +extern char _dtb_start[];
> +extern char _dtb_end[];
> +
> +static u8 *ebony_mac0, *ebony_mac1;
> +
> +/* Calculate 440GP clocks */
> +void ibm440gp_fixup_clocks(unsigned int sysclk, unsigned int ser_clk)
> +{
> +	u32 sys0 = mfdcr(DCRN_CPC0_SYS0);
> +	u32 cr0 = mfdcr(DCRN_CPC0_CR0);
> +	u32 cpu, plb, opb, ebc, tb, uart0, uart1, m;
> +	u32 opdv = CPC0_SYS0_OPDV(sys0);
> +	u32 epdv = CPC0_SYS0_EPDV(sys0);
> +
> +	if (sys0 & CPC0_SYS0_BYPASS) {
> +		/* Bypass system PLL */
> +		cpu = plb = sysclk;
> +	} else {
> +		if (sys0 & CPC0_SYS0_EXTSL)
> +			/* PerClk */
> +			m = CPC0_SYS0_FWDVB(sys0) * opdv * epdv;
> +		else
> +			/* CPU clock */
> +			m = CPC0_SYS0_FBDV(sys0) * CPC0_SYS0_FWDVA(sys0);
> +		cpu = sysclk * m / CPC0_SYS0_FWDVA(sys0);
> +		plb = sysclk * m / CPC0_SYS0_FWDVB(sys0);
> +	}
> +
> +	opb = plb / opdv;
> +	ebc = opb / epdv;
> +
> +	/* FIXME: Check if this is for all 440GP, or just Ebony */
> +	if ((mfpvr() & 0xf0000fff) == 0x40000440)
> +		/* Rev. B 440GP, use external system clock */
> +		tb = sysclk;
> +	else
> +		/* Rev. C 440GP, errata force us to use internal clock */
> +		tb = cpu;
> +
> +	if (cr0 & CPC0_CR0_U0EC)
> +		/* External UART clock */
> +		uart0 = ser_clk;
> +	else
> +		/* Internal UART clock */
> +		uart0 = plb / CPC0_CR0_UDIV(cr0);
> +
> +	if (cr0 & CPC0_CR0_U1EC)
> +		/* External UART clock */
> +		uart1 = ser_clk;
> +	else
> +		/* Internal UART clock */
> +		uart1 = plb / CPC0_CR0_UDIV(cr0);
> +
> +	printf("PPC440GP: SysClk = %dMHz (%x)\n\r",
> +	       (sysclk + 500000) / 1000000, sysclk);
> +
> +	dt_fixup_cpu_clocks(cpu, tb, 0);
> +
> +	dt_fixup_clock("/plb", plb);
> +	dt_fixup_clock("/plb/opb", opb);
> +	dt_fixup_clock("/plb/opb/ebc", ebc);
> +	dt_fixup_clock("/plb/opb/serial@40000200", uart0);
> +	dt_fixup_clock("/plb/opb/serial@40000300", uart1);
> +}
> +
> +static void ebony_fixups(void)
> +{
> +	// FIXME: sysclk should be derived by reading the FPGA registers
> +	unsigned long sysclk = 33000000;
> +
> +	ibm440gp_fixup_clocks(sysclk, 6 * 1843200);
> +	ibm44x_fixup_memsize();
> +	dt_fixup_mac_addresses(ebony_mac0, ebony_mac1);
> +}
> +
> +#define SPRN_DBCR0		0x134
> +#define   DBCR0_RST_SYSTEM	0x30000000
> +
> +static void ebony_exit(void)
> +{
> +	unsigned long tmp;
> +
> +	asm volatile (
> +		"mfspr	%0,%1\n"
> +		"oris	%0,%0,%2@h\n"
> +		"mtspr	%1,%0"
> +		: "=&r"(tmp) : "i"(SPRN_DBCR0), "i"(DBCR0_RST_SYSTEM)

You don't have to pass in the constants here, you can specify them in
the asm. Makes it a little more readable.

> +		);
> +
> +}
> +
> +void ebony_init(void *mac0, void *mac1)
> +{
> +	platform_ops.fixups = ebony_fixups;
> +	platform_ops.exit = ebony_exit;
> +	ebony_mac0 = mac0;
> +	ebony_mac1 = mac1;
> +	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
> +	serial_console_init();
> +}
> Index: working-2.6/arch/powerpc/boot/mktree.c
> ===================================================================
> --- working-2.6.orig/arch/powerpc/boot/mktree.c	2007-01-24 12:01:17.000000000 +1100
> +++ working-2.6/arch/powerpc/boot/mktree.c	2007-05-04 13:46:51.000000000 +1000
> @@ -46,8 +46,8 @@ int main(int argc, char *argv[])
>  	struct	stat	st;
>  	boot_block_t	bt;
>  
> -	if (argc < 3) {
> -		fprintf(stderr, "usage: %s <zImage-file> <boot-image> [entry-point]\n",argv[0]);
> +	if (argc < 5) {
> +		fprintf(stderr, "usage: %s <zImage-file> <boot-image> <load address> <entry point>\n",argv[0]);
>  		exit(1);
>  	}
>  
> @@ -61,10 +61,8 @@ int main(int argc, char *argv[])
>  	bt.bb_magic = htonl(0x0052504F);
>  
>  	/* If we have the optional entry point parameter, use it */
> -	if (argc == 4)
> -		bt.bb_dest = bt.bb_entry_point = htonl(strtoul(argv[3], NULL, 0));
> -	else
> -		bt.bb_dest = bt.bb_entry_point = htonl(0x500000);
> +	bt.bb_dest = htonl(strtoul(argv[3], NULL, 0));
> +	bt.bb_entry_point = htonl(strtoul(argv[4], NULL, 0));
>  
>  	/* We know these from the linker command.
>  	 * ...and then move it up into memory a little more so the
> Index: working-2.6/arch/powerpc/boot/treeboot-ebony.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ working-2.6/arch/powerpc/boot/treeboot-ebony.c	2007-05-04 13:46:51.000000000 +1000
> @@ -0,0 +1,34 @@
> +/*
> + * Old U-boot compatibility for Ebony
> + *
> + * Author: David Gibson <david@gibson.dropbear.id.au>
> + *
> + * Copyright 2007 David Gibson, IBM Corporatio.
> + *   Based on cuboot-83xx.c, which is:
> + * Copyright (c) 2007 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + */
> +
> +#include "ops.h"
> +#include "stdio.h"
> +#include "44x.h"
> +
> +extern char _end[];
> +
> +BSS_STACK(4096);
> +
> +#define OPENBIOS_MAC_BASE	0xfffffe0c
> +#define OPENBIOS_MAC_OFFSET	0xc
> +
> +void platform_init(void)
> +{
> +	unsigned long end_of_ram = 0x8000000;
> +	unsigned long avail_ram = end_of_ram - (unsigned long)_end;
> +
> +	simple_alloc_init(_end, avail_ram, 32, 64);
> +	ebony_init((u8 *)OPENBIOS_MAC_BASE,
> +		   (u8 *)(OPENBIOS_MAC_BASE + OPENBIOS_MAC_OFFSET));
> +}
> Index: working-2.6/arch/powerpc/boot/wrapper
> ===================================================================
> --- working-2.6.orig/arch/powerpc/boot/wrapper	2007-05-03 10:19:32.000000000 +1000
> +++ working-2.6/arch/powerpc/boot/wrapper	2007-05-04 13:46:51.000000000 +1000
> @@ -231,4 +231,12 @@ cuboot*)
>      mkimage -A ppc -O linux -T kernel -C gzip -a "$base" -e "$entry" \
>              $uboot_version -d "$ofile".bin.gz "$ofile"
>      ;;
> +treeboot*)
> +    mv "$ofile" "$ofile.elf"
> +    $object/mktree "$ofile.elf" "$ofile" "$base" "$entry"
> +    if [ -z "$cacheit" ]; then
> +	rm -f "$ofile.elf"
> +    fi
> +    exit 0
> +    ;;
>  esac
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
