Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CC12367A3E
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 08:21:03 +1000 (EST)
Subject: Re: [PATCH] powerpc: Do a bit more cpu init cleanups
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20060627192206.GB5130@pb15.lixom.net>
References: <20060627192206.GB5130@pb15.lixom.net>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 08:20:48 +1000
Message-Id: <1151446849.2350.95.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-06-27 at 12:22 -0700, Olof Johansson wrote:
> Cleanup CPU inits a bit more, Geoff Levand already did some earlier.
> 
> * Rename cpu_setup_power4.S to cpu_setup_ppc970.S

> * Move CPU state save to cpu_setup, since cpu_setup is only ever done
>   on cpu 0 on 64-bit.

Nah, keep that one separate, will be needed as soon as we start doing
some sleep/wake stuff for ppc64

> * Rename __restore_cpu_setup to __restore_cpu_setup_ppc970 since it's
>   only actually doing anything there, and check before calling instead
>   of in the function (no check needed on powermac).

I'd like to keep a generic save/restore.. that or we put then in
cputable.

> * Same for __970_cpu_preinit
> * Rename pSeries_secondary_smp_init to generic_secondary_smp_init since
>   everyone but powermac and iSeries use it.

Ok.

> Build tested with all 64-bit defconfigs, boot tested on power5 and
> powermac.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> 
> Index: linux-2.6/arch/powerpc/kernel/Makefile
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/kernel/Makefile
> +++ linux-2.6/arch/powerpc/kernel/Makefile
> @@ -16,7 +16,7 @@ obj-y				:= semaphore.o cputable.o ptrac
>  obj-y				+= vdso32/
>  obj-$(CONFIG_PPC64)		+= setup_64.o binfmt_elf32.o sys_ppc32.o \
>  				   signal_64.o ptrace32.o \
> -				   paca.o cpu_setup_power4.o \
> +				   paca.o cpu_setup_ppc970.o \
>  				   firmware.o sysfs.o
>  obj-$(CONFIG_PPC64)		+= vdso64/
>  obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
> Index: linux-2.6/arch/powerpc/kernel/cpu_setup_power4.S
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/kernel/cpu_setup_power4.S
> +++ /dev/null
> @@ -1,216 +0,0 @@
> -/*
> - * This file contains low level CPU setup functions.
> - *    Copyright (C) 2003 Benjamin Herrenschmidt (benh@kernel.crashing.org)
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version
> - * 2 of the License, or (at your option) any later version.
> - *
> - */
> -
> -#include <linux/config.h>
> -#include <asm/processor.h>
> -#include <asm/page.h>
> -#include <asm/cputable.h>
> -#include <asm/ppc_asm.h>
> -#include <asm/asm-offsets.h>
> -#include <asm/cache.h>
> -
> -_GLOBAL(__970_cpu_preinit)
> -	/*
> -	 * Do nothing if not running in HV mode
> -	 */
> -	mfmsr	r0
> -	rldicl.	r0,r0,4,63
> -	beqlr
> -
> -	/*
> -	 * Deal only with PPC970 and PPC970FX.
> -	 */
> -	mfspr	r0,SPRN_PVR
> -	srwi	r0,r0,16
> -	cmpwi	r0,0x39
> -	beq	1f
> -	cmpwi	r0,0x3c
> -	beq	1f
> -	cmpwi	r0,0x44
> -	bnelr
> -1:
> -
> -	/* Make sure HID4:rm_ci is off before MMU is turned off, that large
> -	 * pages are enabled with HID4:61 and clear HID5:DCBZ_size and
> -	 * HID5:DCBZ32_ill
> -	 */
> -	li	r0,0
> -	mfspr	r3,SPRN_HID4
> -	rldimi	r3,r0,40,23	/* clear bit 23 (rm_ci) */
> -	rldimi	r3,r0,2,61	/* clear bit 61 (lg_pg_en) */
> -	sync
> -	mtspr	SPRN_HID4,r3
> -	isync
> -	sync
> -	mfspr	r3,SPRN_HID5
> -	rldimi	r3,r0,6,56	/* clear bits 56 & 57 (DCBZ*) */
> -	sync
> -	mtspr	SPRN_HID5,r3
> -	isync
> -	sync
> -
> -	/* Setup some basic HID1 features */
> -	mfspr	r0,SPRN_HID1
> -	li	r3,0x1200		/* enable i-fetch cacheability */
> -	sldi	r3,r3,44		/* and prefetch */
> -	or	r0,r0,r3
> -	mtspr	SPRN_HID1,r0
> -	mtspr	SPRN_HID1,r0
> -	isync
> -
> -	/* Clear HIOR */
> -	li	r0,0
> -	sync
> -	mtspr	SPRN_HIOR,0		/* Clear interrupt prefix */
> -	isync
> -	blr
> -
> -_GLOBAL(__setup_cpu_ppc970)
> -	mfspr	r0,SPRN_HID0
> -	li	r11,5			/* clear DOZE and SLEEP */
> -	rldimi	r0,r11,52,8		/* set NAP and DPM */
> -	mtspr	SPRN_HID0,r0
> -	mfspr	r0,SPRN_HID0
> -	mfspr	r0,SPRN_HID0
> -	mfspr	r0,SPRN_HID0
> -	mfspr	r0,SPRN_HID0
> -	mfspr	r0,SPRN_HID0
> -	mfspr	r0,SPRN_HID0
> -	sync
> -	isync
> -	blr
> -
> -/* Definitions for the table use to save CPU states */
> -#define CS_HID0		0
> -#define CS_HID1		8
> -#define	CS_HID4		16
> -#define CS_HID5		24
> -#define CS_SIZE		32
> -
> -	.data
> -	.balign	L1_CACHE_BYTES,0
> -cpu_state_storage:
> -	.space	CS_SIZE
> -	.balign	L1_CACHE_BYTES,0
> -	.text
> -
> -/* Called in normal context to backup CPU 0 state. This
> - * does not include cache settings. This function is also
> - * called for machine sleep. This does not include the MMU
> - * setup, BATs, etc... but rather the "special" registers
> - * like HID0, HID1, HID4, etc...
> - */
> -_GLOBAL(__save_cpu_setup)
> -	/* Some CR fields are volatile, we back it up all */
> -	mfcr	r7
> -
> -	/* Get storage ptr */
> -	LOAD_REG_IMMEDIATE(r5,cpu_state_storage)
> -
> -	/* We only deal with 970 for now */
> -	mfspr	r0,SPRN_PVR
> -	srwi	r0,r0,16
> -	cmpwi	r0,0x39
> -	beq	1f
> -	cmpwi	r0,0x3c
> -	beq	1f
> -	cmpwi	r0,0x44
> -	bne	2f
> -
> -1:	/* Save HID0,1,4 and 5 */
> -	mfspr	r3,SPRN_HID0
> -	std	r3,CS_HID0(r5)
> -	mfspr	r3,SPRN_HID1
> -	std	r3,CS_HID1(r5)
> -	mfspr	r3,SPRN_HID4
> -	std	r3,CS_HID4(r5)
> -	mfspr	r3,SPRN_HID5
> -	std	r3,CS_HID5(r5)
> -
> -2:
> -	mtcr	r7
> -	blr
> -
> -/* Called with no MMU context (typically MSR:IR/DR off) to
> - * restore CPU state as backed up by the previous
> - * function. This does not include cache setting
> - */
> -_GLOBAL(__restore_cpu_setup)
> -	/* Get storage ptr (FIXME when using anton reloc as we
> -	 * are running with translation disabled here
> -	 */
> -	LOAD_REG_IMMEDIATE(r5,cpu_state_storage)
> -
> -	/* We only deal with 970 for now */
> -	mfspr	r0,SPRN_PVR
> -	srwi	r0,r0,16
> -	cmpwi	r0,0x39
> -	beq	1f
> -	cmpwi	r0,0x3c
> -	beq	1f
> -	cmpwi	r0,0x44
> -	bnelr
> -
> -1:	/* Before accessing memory, we make sure rm_ci is clear */
> -	li	r0,0
> -	mfspr	r3,SPRN_HID4
> -	rldimi	r3,r0,40,23	/* clear bit 23 (rm_ci) */
> -	sync
> -	mtspr	SPRN_HID4,r3
> -	isync
> -	sync
> -
> -	/* Clear interrupt prefix */
> -	li	r0,0
> -	sync
> -	mtspr	SPRN_HIOR,0
> -	isync
> -
> -	/* Restore HID0 */
> -	ld	r3,CS_HID0(r5)
> -	sync
> -	isync
> -	mtspr	SPRN_HID0,r3
> -	mfspr	r3,SPRN_HID0
> -	mfspr	r3,SPRN_HID0
> -	mfspr	r3,SPRN_HID0
> -	mfspr	r3,SPRN_HID0
> -	mfspr	r3,SPRN_HID0
> -	mfspr	r3,SPRN_HID0
> -	sync
> -	isync
> -
> -	/* Restore HID1 */
> -	ld	r3,CS_HID1(r5)
> -	sync
> -	isync
> -	mtspr	SPRN_HID1,r3
> -	mtspr	SPRN_HID1,r3
> -	sync
> -	isync
> -
> -	/* Restore HID4 */
> -	ld	r3,CS_HID4(r5)
> -	sync
> -	isync
> -	mtspr	SPRN_HID4,r3
> -	sync
> -	isync
> -
> -	/* Restore HID5 */
> -	ld	r3,CS_HID5(r5)
> -	sync
> -	isync
> -	mtspr	SPRN_HID5,r3
> -	sync
> -	isync
> -	blr
> -
> Index: linux-2.6/arch/powerpc/kernel/cpu_setup_ppc970.S
> ===================================================================
> --- /dev/null
> +++ linux-2.6/arch/powerpc/kernel/cpu_setup_ppc970.S
> @@ -0,0 +1,175 @@
> +/*
> + * This file contains low level CPU setup functions.
> + *    Copyright (C) 2003 Benjamin Herrenschmidt (benh@kernel.crashing.org)
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + *
> + */
> +
> +#include <linux/config.h>
> +#include <asm/processor.h>
> +#include <asm/page.h>
> +#include <asm/cputable.h>
> +#include <asm/ppc_asm.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/cache.h>
> +
> +_GLOBAL(__cpu_preinit_ppc970)
> +	/* Do nothing if not running in HV mode */
> +	mfmsr	r0
> +	rldicl.	r0,r0,4,63
> +	beqlr
> +
> +	/* Make sure HID4:rm_ci is off before MMU is turned off, that large
> +	 * pages are enabled with HID4:61 and clear HID5:DCBZ_size and
> +	 * HID5:DCBZ32_ill
> +	 */
> +	li	r0,0
> +	mfspr	r3,SPRN_HID4
> +	rldimi	r3,r0,40,23	/* clear bit 23 (rm_ci) */
> +	rldimi	r3,r0,2,61	/* clear bit 61 (lg_pg_en) */
> +	sync
> +	mtspr	SPRN_HID4,r3
> +	isync
> +	sync
> +	mfspr	r3,SPRN_HID5
> +	rldimi	r3,r0,6,56	/* clear bits 56 & 57 (DCBZ*) */
> +	sync
> +	mtspr	SPRN_HID5,r3
> +	isync
> +	sync
> +
> +	/* Setup some basic HID1 features */
> +	mfspr	r0,SPRN_HID1
> +	li	r3,0x1200		/* enable i-fetch cacheability */
> +	sldi	r3,r3,44		/* and prefetch */
> +	or	r0,r0,r3
> +	mtspr	SPRN_HID1,r0
> +	mtspr	SPRN_HID1,r0
> +	isync
> +
> +	/* Clear HIOR */
> +	li	r0,0
> +	sync
> +	mtspr	SPRN_HIOR,0		/* Clear interrupt prefix */
> +	isync
> +	blr
> +
> +/* Definitions for the table use to save CPU states */
> +#define CS_HID0		0
> +#define CS_HID1		8
> +#define	CS_HID4		16
> +#define CS_HID5		24
> +#define CS_SIZE		32
> +
> +	.data
> +	.balign	L1_CACHE_BYTES,0
> +cpu_state_storage:
> +	.space	CS_SIZE
> +	.balign	L1_CACHE_BYTES,0
> +	.text
> +
> +
> +_GLOBAL(__setup_cpu_ppc970)
> +	/* Do nothing if not running in HV mode */
> +	mfmsr	r0
> +	rldicl.	r0,r0,4,63
> +	beqlr
> +
> +	mfspr	r0,SPRN_HID0
> +	li	r11,5			/* clear DOZE and SLEEP */
> +	rldimi	r0,r11,52,8		/* set NAP and DPM */
> +	mtspr	SPRN_HID0,r0
> +	mfspr	r0,SPRN_HID0
> +	mfspr	r0,SPRN_HID0
> +	mfspr	r0,SPRN_HID0
> +	mfspr	r0,SPRN_HID0
> +	mfspr	r0,SPRN_HID0
> +	mfspr	r0,SPRN_HID0
> +	sync
> +	isync
> +
> +	/* Save away cpu state */
> +	LOAD_REG_IMMEDIATE(r5,cpu_state_storage)
> +
> +	/* Save HID0,1,4 and 5 */
> +	mfspr	r3,SPRN_HID0
> +	std	r3,CS_HID0(r5)
> +	mfspr	r3,SPRN_HID1
> +	std	r3,CS_HID1(r5)
> +	mfspr	r3,SPRN_HID4
> +	std	r3,CS_HID4(r5)
> +	mfspr	r3,SPRN_HID5
> +	std	r3,CS_HID5(r5)
> +
> +	blr
> +
> +/* Called with no MMU context (typically MSR:IR/DR off) to
> + * restore CPU state as backed up by the previous
> + * function. This does not include cache setting
> + */
> +_GLOBAL(__restore_cpu_setup_ppc970)
> +	/* Do nothing if not running in HV mode */
> +	mfmsr	r0
> +	rldicl.	r0,r0,4,63
> +	beqlr
> +
> +	LOAD_REG_IMMEDIATE(r5,cpu_state_storage)
> +	/* Before accessing memory, we make sure rm_ci is clear */
> +	li	r0,0
> +	mfspr	r3,SPRN_HID4
> +	rldimi	r3,r0,40,23	/* clear bit 23 (rm_ci) */
> +	sync
> +	mtspr	SPRN_HID4,r3
> +	isync
> +	sync
> +
> +	/* Clear interrupt prefix */
> +	li	r0,0
> +	sync
> +	mtspr	SPRN_HIOR,0
> +	isync
> +
> +	/* Restore HID0 */
> +	ld	r3,CS_HID0(r5)
> +	sync
> +	isync
> +	mtspr	SPRN_HID0,r3
> +	mfspr	r3,SPRN_HID0
> +	mfspr	r3,SPRN_HID0
> +	mfspr	r3,SPRN_HID0
> +	mfspr	r3,SPRN_HID0
> +	mfspr	r3,SPRN_HID0
> +	mfspr	r3,SPRN_HID0
> +	sync
> +	isync
> +
> +	/* Restore HID1 */
> +	ld	r3,CS_HID1(r5)
> +	sync
> +	isync
> +	mtspr	SPRN_HID1,r3
> +	mtspr	SPRN_HID1,r3
> +	sync
> +	isync
> +
> +	/* Restore HID4 */
> +	ld	r3,CS_HID4(r5)
> +	sync
> +	isync
> +	mtspr	SPRN_HID4,r3
> +	sync
> +	isync
> +
> +	/* Restore HID5 */
> +	ld	r3,CS_HID5(r5)
> +	sync
> +	isync
> +	mtspr	SPRN_HID5,r3
> +	sync
> +	isync
> +	blr
> +
> Index: linux-2.6/arch/powerpc/kernel/head_64.S
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/kernel/head_64.S
> +++ linux-2.6/arch/powerpc/kernel/head_64.S
> @@ -152,7 +152,7 @@ _GLOBAL(__secondary_hold)
>  	bne	100b
>  
>  #if defined(CONFIG_SMP) || defined(CONFIG_KEXEC)
> -	LOAD_REG_IMMEDIATE(r4, .pSeries_secondary_smp_init)
> +	LOAD_REG_IMMEDIATE(r4, .generic_secondary_smp_init)
>  	mtctr	r4
>  	mr	r3,r24
>  	bctr
> @@ -1473,18 +1473,28 @@ fwnmi_data_area:
>          . = 0x8000
>  
>  /*
> - * On pSeries, secondary processors spin in the following code.
> + * On pSeries and most other platforms, secondary processors spin
> + * in the following code.
>   * At entry, r3 = this processor's number (physical cpu id)
>   */
> -_GLOBAL(pSeries_secondary_smp_init)
> +_GLOBAL(generic_secondary_smp_init)
>  	mr	r24,r3
>  	
>  	/* turn on 64-bit mode */
>  	bl	.enable_64b_mode
>  	isync
>  
> -	/* Copy some CPU settings from CPU 0 */
> -	bl	.__restore_cpu_setup
> +	/* Copy some CPU settings from CPU 0, only needed on PPC970{,FX,MP} */
> +	mfspr	r0,SPRN_PVR
> +	srwi	r0,r0,16
> +	cmpwi	r0,0x39		/* 970 */
> +	beq	1f
> +	cmpwi	r0,0x3c		/* 970FX */
> +	beq	1f
> +	cmpwi	r0,0x44		/* 970MP */
> +	bne	2f
> +1:	bl	.__restore_cpu_setup_ppc970
> +2:
>  
>  	/* Set up a paca value for this processor. Since we have the
>  	 * physical cpu id in r24, we need to search the pacas to find
> @@ -1600,7 +1610,16 @@ _GLOBAL(__start_initialization_multiplat
>  	bl	.enable_64b_mode
>  
>  	/* Setup some critical 970 SPRs before switching MMU off */
> -	bl	.__970_cpu_preinit
> +	mfspr	r0,SPRN_PVR
> +	srwi	r0,r0,16
> +	cmpwi	r0,0x39		/* 970 */
> +	beq	1f
> +	cmpwi	r0,0x3c		/* 970FX */
> +	beq	1f
> +	cmpwi	r0,0x44		/* 970MP */
> +	bne	2f
> +1:	bl	.__cpu_preinit_ppc970
> +2:
>  
>  	/* cpu # */
>  	li	r24,0
> @@ -1771,7 +1790,7 @@ _GLOBAL(pmac_secondary_start)
>  	isync
>  
>  	/* Copy some CPU settings from CPU 0 */
> -	bl	.__restore_cpu_setup
> +	bl	.__restore_cpu_setup_ppc970
>  
>  	/* pSeries do that early though I don't think we really need it */
>  	mfmsr	r3
> @@ -1921,12 +1940,6 @@ _STATIC(start_here_multiplatform)
>  	mr	r5,r26
>  	bl	.identify_cpu
>  
> -	/* Save some low level config HIDs of CPU0 to be copied to
> -	 * other CPUs later on, or used for suspend/resume
> -	 */
> -	bl	.__save_cpu_setup
> -	sync
> -
>  	/* Do very early kernel initializations, including initial hash table,
>  	 * stab and slb setup before we turn on relocation.	*/
>  
> Index: linux-2.6/arch/powerpc/platforms/cell/smp.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/platforms/cell/smp.c
> +++ linux-2.6/arch/powerpc/platforms/cell/smp.c
> @@ -58,7 +58,7 @@
>   */
>  static cpumask_t of_spin_map;
>  
> -extern void pSeries_secondary_smp_init(unsigned long);
> +extern void generic_secondary_smp_init(unsigned long);
>  
>  /**
>   * smp_startup_cpu() - start the given cpu
> @@ -75,7 +75,7 @@ static inline int __devinit smp_startup_
>  {
>  	int status;
>  	unsigned long start_here = __pa((u32)*((unsigned long *)
> -					       pSeries_secondary_smp_init));
> +					       generic_secondary_smp_init));
>  	unsigned int pcpu;
>  	int start_cpu;
>  
> Index: linux-2.6/arch/powerpc/platforms/pseries/smp.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/platforms/pseries/smp.c
> +++ linux-2.6/arch/powerpc/platforms/pseries/smp.c
> @@ -63,7 +63,7 @@
>   */
>  static cpumask_t of_spin_map;
>  
> -extern void pSeries_secondary_smp_init(unsigned long);
> +extern void generic_secondary_smp_init(unsigned long);
>  
>  #ifdef CONFIG_HOTPLUG_CPU
>  
> @@ -271,7 +271,7 @@ static inline int __devinit smp_startup_
>  {
>  	int status;
>  	unsigned long start_here = __pa((u32)*((unsigned long *)
> -					       pSeries_secondary_smp_init));
> +					       generic_secondary_smp_init));
>  	unsigned int pcpu;
>  	int start_cpu;
>  
