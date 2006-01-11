Return-Path: <galak@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E9D6768A03
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jan 2006 09:37:32 +1100 (EST)
Date: Wed, 11 Jan 2006 16:31:08 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Andy Fleming <afleming@freescale.com>
In-Reply-To: <Pine.LNX.4.61.0601111538240.30214@ld0175-tx32.am.freescale.net>
Message-ID: <Pine.LNX.4.44.0601111630420.3411-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] Fix e500 oprofile support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 11 Jan 2006, Andy Fleming wrote:

> This patch needs to go in quickly to fix e500 oprofile support.  I didn't 
> realize the 7450 oprofile support patch had gone in, yet!
> 
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> 
> * Fixed oprofile support on e500 so it doesn't included 7450 support
> * Modified the SMP call of cpu_setup so that it passes in information
>   the e500 needs to program the counters
> * Moved all functions in perfmon_fsl_booke.c to op_model_fsl_booke.c
> * e500 oprofile code should now be SMP capable
> * Fixed a typo in rs64
> 
> ---
> commit 5ba626800295fdd0402db4535c9b8989365103b7
> tree 383a8f67ae5c31b991e09ebd549ffe84c1f200d7
> parent 44e22e7c3358c79517685e7b66ffae17da6f8399
> author Andrew Fleming <afleming@freescale.com> Wed, 11 Jan 2006 15:35:47 -0600
> committer Andrew Fleming <afleming@ld0175-tx32.(none)> Wed, 11 Jan 2006 15:35:47 -0600
> 
>  arch/powerpc/oprofile/Makefile             |    2 
>  arch/powerpc/oprofile/common.c             |    2 
>  arch/powerpc/oprofile/op_model_fsl_booke.c |  177 +++++++++++++++++++---
>  arch/powerpc/oprofile/op_model_rs64.c      |    2 
>  arch/ppc/kernel/Makefile                   |    3 
>  arch/ppc/kernel/perfmon_fsl_booke.c        |  222 ----------------------------
>  include/asm-powerpc/oprofile_impl.h        |    7 -
>  include/asm-powerpc/pmc.h                  |   13 --
>  8 files changed, 160 insertions(+), 268 deletions(-)
> 
> diff --git a/arch/powerpc/oprofile/Makefile b/arch/powerpc/oprofile/Makefile
> index 554cd7c..74db517 100644
> --- a/arch/powerpc/oprofile/Makefile
> +++ b/arch/powerpc/oprofile/Makefile
> @@ -9,4 +9,4 @@ DRIVER_OBJS := $(addprefix ../../../driv
>  oprofile-y := $(DRIVER_OBJS) common.o
>  oprofile-$(CONFIG_PPC64) += op_model_rs64.o op_model_power4.o
>  oprofile-$(CONFIG_FSL_BOOKE) += op_model_fsl_booke.o

Make this depend on CONFIG_CLASSIC32 instead of CONFIG_6xx.

> -oprofile-$(CONFIG_PPC32) += op_model_7450.o
> +oprofile-$(CONFIG_6xx) += op_model_7450.o
> diff --git a/arch/powerpc/oprofile/common.c b/arch/powerpc/oprofile/common.c
> index a370778..d7a5afe 100644
> --- a/arch/powerpc/oprofile/common.c
> +++ b/arch/powerpc/oprofile/common.c
> @@ -46,7 +46,7 @@ static int op_powerpc_setup(void)
>  	model->reg_setup(ctr, &sys, model->num_counters);
>  
>  	/* Configure the registers on all cpus.  */
> -	on_each_cpu(model->cpu_setup, NULL, 0, 1);
> +	on_each_cpu(model->cpu_setup, (void *)ctr, 0, 1);
>  
>  	return 0;
>  }
> diff --git a/arch/powerpc/oprofile/op_model_fsl_booke.c b/arch/powerpc/oprofile/op_model_fsl_booke.c
> index 26539cd..993147a 100644
> --- a/arch/powerpc/oprofile/op_model_fsl_booke.c
> +++ b/arch/powerpc/oprofile/op_model_fsl_booke.c
> @@ -1,5 +1,5 @@
>  /*
> - * oprofile/op_model_e500.c
> + * oprofile/op_model_fsl_booke.c
>   *
>   * Freescale Book-E oprofile support, based on ppc64 oprofile support
>   * Copyright (C) 2004 Anton Blanchard <anton@au.ibm.com>, IBM
> @@ -32,6 +32,70 @@ static unsigned long reset_value[OP_MAX_
>  static int num_counters;
>  static int oprofile_running;
>  
> +static inline u32 get_pmlca(int ctr)
> +{
> +	u32 pmlca;
> +
> +	switch (ctr) {
> +		case 0:
> +			pmlca = mfpmr(PMRN_PMLCA0);
> +			break;
> +		case 1:
> +			pmlca = mfpmr(PMRN_PMLCA1);
> +			break;
> +		case 2:
> +			pmlca = mfpmr(PMRN_PMLCA2);
> +			break;
> +		case 3:
> +			pmlca = mfpmr(PMRN_PMLCA3);
> +			break;
> +		default:
> +			panic("Bad ctr number\n");
> +	}
> +
> +	return pmlca;
> +}
> +
> +static inline void set_pmlca(int ctr, u32 pmlca)
> +{
> +	switch (ctr) {
> +		case 0:
> +			mtpmr(PMRN_PMLCA0, pmlca);
> +			break;
> +		case 1:
> +			mtpmr(PMRN_PMLCA1, pmlca);
> +			break;
> +		case 2:
> +			mtpmr(PMRN_PMLCA2, pmlca);
> +			break;
> +		case 3:
> +			mtpmr(PMRN_PMLCA3, pmlca);
> +			break;
> +		default:
> +			panic("Bad ctr number\n");
> +	}
> +}
> +
> +static inline void set_pmlcb(int ctr, u32 pmlcb)
> +{
> +	switch (ctr) {
> +		case 0:
> +			mtpmr(PMRN_PMLCB0, pmlcb);
> +			break;
> +		case 1:
> +			mtpmr(PMRN_PMLCB1, pmlcb);
> +			break;
> +		case 2:
> +			mtpmr(PMRN_PMLCB2, pmlcb);
> +			break;
> +		case 3:
> +			mtpmr(PMRN_PMLCB3, pmlcb);
> +			break;
> +		default:
> +			panic("Bad ctr number\n");
> +	}
> +}
> +
>  static inline unsigned int ctr_read(unsigned int i)
>  {
>  	switch(i) {
> @@ -68,6 +132,88 @@ static inline void ctr_write(unsigned in
>  	}
>  }
>  
> +#define PMLCA_INIT (PMLCA_FC | PMLCA_FCS | PMLCA_FCU | PMLCA_FCM1 | PMLCA_FCM0)
> +void configure_pmc(int ctr, int event, int user, int kernel)
> +{
> +	u32 pmlca;
> +
> +	/* Configure the config registers */
> +	pmlca = (PMLCA_INIT & ~PMLCA_EVENT_MASK) |
> +		((event << PMLCA_EVENT_SHIFT) &
> +		 PMLCA_EVENT_MASK);
> +
> +	if(user)
> +		pmlca &= ~PMLCA_FCU;
> +	else
> +		pmlca |= PMLCA_FCU;
> +
> +	if(kernel)
> +		pmlca &= ~PMLCA_FCS;
> +	else
> +		pmlca |= PMLCA_FCS;
> +
> +	set_pmlca(ctr, pmlca);
> +	set_pmlcb(ctr, 0);
> +}
> +
> +void pmc_enable_ctr(int ctr)
> +{
> +	u32 pmlca = get_pmlca(ctr);
> +
> +	pmlca &= ~(PMLCA_FC | PMLCA_FCM0);
> +
> +	pmlca |= PMLCA_CE;
> +
> +	set_pmlca(ctr, pmlca);
> +}
> +
> +void pmc_start_ctrs(void)
> +{
> +	u32 pmgc0 = mfpmr(PMRN_PMGC0);
> +
> +	pmgc0 &= ~PMGC0_FAC;
> +	pmgc0 |= (PMGC0_FCECE | PMGC0_PMIE);
> +
> +	mtpmr(PMRN_PMGC0, pmgc0);
> +}
> +
> +void pmc_stop_ctrs(void)
> +{
> +	u32 pmgc0 = mfpmr(PMRN_PMGC0);
> +
> +	pmgc0 |= PMGC0_FAC;
> +
> +	pmgc0 &= ~(PMGC0_PMIE | PMGC0_FCECE);
> +
> +	mtpmr(PMRN_PMGC0, pmgc0);
> +}
> +
> +void dump_pmcs(void)
> +{
> +	printk("pmgc0: %x\n", mfpmr(PMRN_PMGC0));
> +	printk("pmc\t\tpmlca\t\tpmlcb\n");
> +	printk("%8x\t%8x\t%8x\n", mfpmr(PMRN_PMC0),
> +			mfpmr(PMRN_PMLCA0), mfpmr(PMRN_PMLCB0));
> +	printk("%8x\t%8x\t%8x\n", mfpmr(PMRN_PMC1),
> +			mfpmr(PMRN_PMLCA1), mfpmr(PMRN_PMLCB1));
> +	printk("%8x\t%8x\t%8x\n", mfpmr(PMRN_PMC2),
> +			mfpmr(PMRN_PMLCA2), mfpmr(PMRN_PMLCB2));
> +	printk("%8x\t%8x\t%8x\n", mfpmr(PMRN_PMC3),
> +			mfpmr(PMRN_PMLCA3), mfpmr(PMRN_PMLCB3));
> +}
> +
> +static void fsl_booke_cpu_setup(void *info)
> +{
> +	int i;
> +	struct op_counter_config *ctr = (struct op_counter_config *)info;
> +
> +	/* freeze all counters */
> +	pmc_stop_ctrs();
> +
> +	for (i=0;i < num_counters; i++)
> +		configure_pmc(i, ctr[i].event, ctr[i].user, ctr[i].kernel);
> +}
> +
>  
>  static void fsl_booke_reg_setup(struct op_counter_config *ctr,
>  			     struct op_system_config *sys,
> @@ -77,23 +223,13 @@ static void fsl_booke_reg_setup(struct o
>  
>  	num_counters = num_ctrs;
>  
> -	/* freeze all counters */
> -	pmc_stop_ctrs();
> -
>  	/* Our counters count up, and "count" refers to
>  	 * how much before the next interrupt, and we interrupt
>  	 * on overflow.  So we calculate the starting value
>  	 * which will give us "count" until overflow.
>  	 * Then we set the events on the enabled counters */
> -	for (i = 0; i < num_counters; ++i) {
> +	for (i = 0; i < num_counters; ++i)
>  		reset_value[i] = 0x80000000UL - ctr[i].count;
> -
> -		init_pmc_stop(i);
> -
> -		set_pmc_event(i, ctr[i].event);
> -
> -		set_pmc_user_kernel(i, ctr[i].user, ctr[i].kernel);
> -	}
>  }
>  
>  static void fsl_booke_start(struct op_counter_config *ctr)
> @@ -105,22 +241,16 @@ static void fsl_booke_start(struct op_co
>  	for (i = 0; i < num_counters; ++i) {
>  		if (ctr[i].enabled) {
>  			ctr_write(i, reset_value[i]);
> -			/* Set Each enabled counterd to only
> -			 * count when the Mark bit is not set */
> -			set_pmc_marked(i, 1, 0);
> -			pmc_start_ctr(i, 1);
> -		} else {
> -			ctr_write(i, 0);
>  
> -			/* Set the ctr to be stopped */
> -			pmc_start_ctr(i, 0);
> -		}
> +			pmc_enable_ctr(i);
> +		} else
> +			ctr_write(i, 0);
>  	}
>  
>  	/* Clear the freeze bit, and enable the interrupt.
>  	 * The counters won't actually start until the rfi clears
>  	 * the PMM bit */
> -	pmc_start_ctrs(1);
> +	pmc_start_ctrs();
>  
>  	oprofile_running = 1;
>  
> @@ -172,11 +302,12 @@ static void fsl_booke_handle_interrupt(s
>  	/* Clear the freeze bit, and reenable the interrupt.
>  	 * The counters won't actually start until the rfi clears
>  	 * the PMM bit */
> -	pmc_start_ctrs(1);
> +	pmc_start_ctrs();
>  }
>  
>  struct op_powerpc_model op_model_fsl_booke = {
>  	.reg_setup		= fsl_booke_reg_setup,
> +	.cpu_setup		= fsl_booke_cpu_setup,
>  	.start			= fsl_booke_start,
>  	.stop			= fsl_booke_stop,
>  	.handle_interrupt	= fsl_booke_handle_interrupt,
> diff --git a/arch/powerpc/oprofile/op_model_rs64.c b/arch/powerpc/oprofile/op_model_rs64.c
> index e010b85..4aeb077 100644
> --- a/arch/powerpc/oprofile/op_model_rs64.c
> +++ b/arch/powerpc/oprofile/op_model_rs64.c
> @@ -148,7 +148,7 @@ static void rs64_start(struct op_counter
>  
>  	/*
>  	 * now clear the freeze bit, counting will not start until we
> -	 * rfid from this excetion, because only at that point will
> +	 * rfid from this exception, because only at that point will
>  	 * the PMM bit be cleared
>  	 */
>  	mmcr0 &= ~MMCR0_FC;
> diff --git a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
> index 0bb23fc..4d1bdce 100644
> --- a/arch/ppc/kernel/Makefile
> +++ b/arch/ppc/kernel/Makefile
> @@ -26,9 +26,6 @@ obj-$(CONFIG_RAPIDIO)		+= rio.o
>  obj-$(CONFIG_KGDB)		+= ppc-stub.o
>  obj-$(CONFIG_SMP)		+= smp.o smp-tbsync.o
>  obj-$(CONFIG_TAU)		+= temp.o
> -ifndef CONFIG_E200
> -obj-$(CONFIG_FSL_BOOKE)		+= perfmon_fsl_booke.o
> -endif
>  obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
>  
>  ifndef CONFIG_MATH_EMULATION
> diff --git a/arch/ppc/kernel/perfmon_fsl_booke.c b/arch/ppc/kernel/perfmon_fsl_booke.c
> deleted file mode 100644
> index 32455df..0000000
> --- a/arch/ppc/kernel/perfmon_fsl_booke.c
> +++ /dev/null
> @@ -1,222 +0,0 @@
> -/* kernel/perfmon_fsl_booke.c
> - * Freescale Book-E Performance Monitor code
> - *
> - * Author: Andy Fleming
> - * Copyright (c) 2004 Freescale Semiconductor, Inc
> - *
> - *  This program is free software; you can redistribute it and/or
> - *  modify it under the terms of the GNU General Public License
> - *  as published by the Free Software Foundation; either version
> - *  2 of the License, or (at your option) any later version.
> - */
> -
> -#include <linux/errno.h>
> -#include <linux/sched.h>
> -#include <linux/kernel.h>
> -#include <linux/mm.h>
> -#include <linux/stddef.h>
> -#include <linux/unistd.h>
> -#include <linux/ptrace.h>
> -#include <linux/slab.h>
> -#include <linux/user.h>
> -#include <linux/a.out.h>
> -#include <linux/interrupt.h>
> -#include <linux/config.h>
> -#include <linux/init.h>
> -#include <linux/module.h>
> -#include <linux/prctl.h>
> -
> -#include <asm/pgtable.h>
> -#include <asm/uaccess.h>
> -#include <asm/system.h>
> -#include <asm/io.h>
> -#include <asm/reg.h>
> -#include <asm/xmon.h>
> -#include <asm/pmc.h>
> -
> -static inline u32 get_pmlca(int ctr);
> -static inline void set_pmlca(int ctr, u32 pmlca);
> -
> -static inline u32 get_pmlca(int ctr)
> -{
> -	u32 pmlca;
> -
> -	switch (ctr) {
> -		case 0:
> -			pmlca = mfpmr(PMRN_PMLCA0);
> -			break;
> -		case 1:
> -			pmlca = mfpmr(PMRN_PMLCA1);
> -			break;
> -		case 2:
> -			pmlca = mfpmr(PMRN_PMLCA2);
> -			break;
> -		case 3:
> -			pmlca = mfpmr(PMRN_PMLCA3);
> -			break;
> -		default:
> -			panic("Bad ctr number\n");
> -	}
> -
> -	return pmlca;
> -}
> -
> -static inline void set_pmlca(int ctr, u32 pmlca)
> -{
> -	switch (ctr) {
> -		case 0:
> -			mtpmr(PMRN_PMLCA0, pmlca);
> -			break;
> -		case 1:
> -			mtpmr(PMRN_PMLCA1, pmlca);
> -			break;
> -		case 2:
> -			mtpmr(PMRN_PMLCA2, pmlca);
> -			break;
> -		case 3:
> -			mtpmr(PMRN_PMLCA3, pmlca);
> -			break;
> -		default:
> -			panic("Bad ctr number\n");
> -	}
> -}
> -
> -void init_pmc_stop(int ctr)
> -{
> -	u32 pmlca = (PMLCA_FC | PMLCA_FCS | PMLCA_FCU |
> -			PMLCA_FCM1 | PMLCA_FCM0);
> -	u32 pmlcb = 0;
> -
> -	switch (ctr) {
> -		case 0:
> -			mtpmr(PMRN_PMLCA0, pmlca);
> -			mtpmr(PMRN_PMLCB0, pmlcb);
> -			break;
> -		case 1:
> -			mtpmr(PMRN_PMLCA1, pmlca);
> -			mtpmr(PMRN_PMLCB1, pmlcb);
> -			break;
> -		case 2:
> -			mtpmr(PMRN_PMLCA2, pmlca);
> -			mtpmr(PMRN_PMLCB2, pmlcb);
> -			break;
> -		case 3:
> -			mtpmr(PMRN_PMLCA3, pmlca);
> -			mtpmr(PMRN_PMLCB3, pmlcb);
> -			break;
> -		default:
> -			panic("Bad ctr number!\n");
> -	}
> -}
> -
> -void set_pmc_event(int ctr, int event)
> -{
> -	u32 pmlca;
> -
> -	pmlca = get_pmlca(ctr);
> -
> -	pmlca = (pmlca & ~PMLCA_EVENT_MASK) |
> -		((event << PMLCA_EVENT_SHIFT) &
> -		 PMLCA_EVENT_MASK);
> -
> -	set_pmlca(ctr, pmlca);
> -}
> -
> -void set_pmc_user_kernel(int ctr, int user, int kernel)
> -{
> -	u32 pmlca;
> -
> -	pmlca = get_pmlca(ctr);
> -
> -	if(user)
> -		pmlca &= ~PMLCA_FCU;
> -	else
> -		pmlca |= PMLCA_FCU;
> -
> -	if(kernel)
> -		pmlca &= ~PMLCA_FCS;
> -	else
> -		pmlca |= PMLCA_FCS;
> -
> -	set_pmlca(ctr, pmlca);
> -}
> -
> -void set_pmc_marked(int ctr, int mark0, int mark1)
> -{
> -	u32 pmlca = get_pmlca(ctr);
> -
> -	if(mark0)
> -		pmlca &= ~PMLCA_FCM0;
> -	else
> -		pmlca |= PMLCA_FCM0;
> -
> -	if(mark1)
> -		pmlca &= ~PMLCA_FCM1;
> -	else
> -		pmlca |= PMLCA_FCM1;
> -
> -	set_pmlca(ctr, pmlca);
> -}
> -
> -void pmc_start_ctr(int ctr, int enable)
> -{
> -	u32 pmlca = get_pmlca(ctr);
> -
> -	pmlca &= ~PMLCA_FC;
> -
> -	if (enable)
> -		pmlca |= PMLCA_CE;
> -	else
> -		pmlca &= ~PMLCA_CE;
> -
> -	set_pmlca(ctr, pmlca);
> -}
> -
> -void pmc_start_ctrs(int enable)
> -{
> -	u32 pmgc0 = mfpmr(PMRN_PMGC0);
> -
> -	pmgc0 &= ~PMGC0_FAC;
> -	pmgc0 |= PMGC0_FCECE;
> -
> -	if (enable)
> -		pmgc0 |= PMGC0_PMIE;
> -	else
> -		pmgc0 &= ~PMGC0_PMIE;
> -
> -	mtpmr(PMRN_PMGC0, pmgc0);
> -}
> -
> -void pmc_stop_ctrs(void)
> -{
> -	u32 pmgc0 = mfpmr(PMRN_PMGC0);
> -
> -	pmgc0 |= PMGC0_FAC;
> -
> -	pmgc0 &= ~(PMGC0_PMIE | PMGC0_FCECE);
> -
> -	mtpmr(PMRN_PMGC0, pmgc0);
> -}
> -
> -void dump_pmcs(void)
> -{
> -	printk("pmgc0: %x\n", mfpmr(PMRN_PMGC0));
> -	printk("pmc\t\tpmlca\t\tpmlcb\n");
> -	printk("%8x\t%8x\t%8x\n", mfpmr(PMRN_PMC0),
> -			mfpmr(PMRN_PMLCA0), mfpmr(PMRN_PMLCB0));
> -	printk("%8x\t%8x\t%8x\n", mfpmr(PMRN_PMC1),
> -			mfpmr(PMRN_PMLCA1), mfpmr(PMRN_PMLCB1));
> -	printk("%8x\t%8x\t%8x\n", mfpmr(PMRN_PMC2),
> -			mfpmr(PMRN_PMLCA2), mfpmr(PMRN_PMLCB2));
> -	printk("%8x\t%8x\t%8x\n", mfpmr(PMRN_PMC3),
> -			mfpmr(PMRN_PMLCA3), mfpmr(PMRN_PMLCB3));
> -}
> -
> -EXPORT_SYMBOL(init_pmc_stop);
> -EXPORT_SYMBOL(set_pmc_event);
> -EXPORT_SYMBOL(set_pmc_user_kernel);
> -EXPORT_SYMBOL(set_pmc_marked);
> -EXPORT_SYMBOL(pmc_start_ctr);
> -EXPORT_SYMBOL(pmc_start_ctrs);
> -EXPORT_SYMBOL(pmc_stop_ctrs);
> -EXPORT_SYMBOL(dump_pmcs);
> diff --git a/include/asm-powerpc/oprofile_impl.h b/include/asm-powerpc/oprofile_impl.h
> index b48d35e..6cc7f16 100644
> --- a/include/asm-powerpc/oprofile_impl.h
> +++ b/include/asm-powerpc/oprofile_impl.h
> @@ -22,7 +22,8 @@ struct op_counter_config {
>  	unsigned long enabled;
>  	unsigned long event;
>  	unsigned long count;
> -	/* Classic doesn't support per-counter user/kernel selection */
> +	/* Classic PPC parts (both 64 and 32 bit) don't support
> +	 * per-counter user/kernel selection */
>  	unsigned long kernel;
>  	unsigned long user;
>  	unsigned long unit_mask;
> @@ -34,12 +35,10 @@ struct op_system_config {
>  	unsigned long mmcr0;
>  	unsigned long mmcr1;
>  	unsigned long mmcra;
> +	unsigned long backtrace_spinlocks;
>  #endif
>  	unsigned long enable_kernel;
>  	unsigned long enable_user;
> -#ifdef CONFIG_PPC64
> -	unsigned long backtrace_spinlocks;
> -#endif
>  };
>  
>  /* Per-arch configuration */
> diff --git a/include/asm-powerpc/pmc.h b/include/asm-powerpc/pmc.h
> index 5f41f3a..1f6643d 100644
> --- a/include/asm-powerpc/pmc.h
> +++ b/include/asm-powerpc/pmc.h
> @@ -31,17 +31,4 @@ void release_pmc_hardware(void);
>  void power4_enable_pmcs(void);
>  #endif
>  
> -#ifdef CONFIG_FSL_BOOKE
> -void init_pmc_stop(int ctr);
> -void set_pmc_event(int ctr, int event);
> -void set_pmc_user_kernel(int ctr, int user, int kernel);
> -void set_pmc_marked(int ctr, int mark0, int mark1);
> -void pmc_start_ctr(int ctr, int enable);
> -void pmc_start_ctrs(int enable);
> -void pmc_stop_ctrs(void);
> -void dump_pmcs(void);
> -
> -extern struct op_powerpc_model op_model_fsl_booke;
> -#endif
> -
>  #endif /* _POWERPC_PMC_H */
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
