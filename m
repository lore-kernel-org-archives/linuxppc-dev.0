Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0112.outbound.protection.outlook.com [207.46.100.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EAEC21A0EF6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Aug 2015 12:49:40 +1000 (AEST)
Message-ID: <1438397340.19345.131.camel@freescale.com>
Subject: Re: [PATCH 4/4] powerpc: pm: support deep sleep feature on T104x
From: Scott Wood <scottwood@freescale.com>
To: Chenhui Zhao <chenhui.zhao@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <Jason.Jin@freescale.com>
Date: Fri, 31 Jul 2015 21:49:00 -0500
In-Reply-To: <1438347186-8462-4-git-send-email-chenhui.zhao@freescale.com>
References: <1438347186-8462-1-git-send-email-chenhui.zhao@freescale.com>
 <1438347186-8462-4-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-07-31 at 20:53 +0800, Chenhui Zhao wrote:
> diff --git a/arch/powerpc/kernel/fsl_booke_entry_mapping.S 
> b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> index f22e7e4..32ec426f 100644
> --- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> +++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> @@ -170,6 +170,10 @@ skpinv:  addi    r6,r6,1                         /* Increment */
>       lis     r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_64M, M_IF_SMP)@h
>       ori     r6,r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_64M, M_IF_SMP)@l
>       mtspr   SPRN_MAS2,r6
> +#ifdef ENTRY_DEEPSLEEP_SETUP
> +     LOAD_REG_IMMEDIATE(r8, MEMORY_START)
> +     ori     r8,r8,(MAS3_SX|MAS3_SW|MAS3_SR)
> +#endif
>       mtspr   SPRN_MAS3,r8
>       tlbwe
>  
> @@ -212,12 +216,18 @@ next_tlb_setup:
>       #error You need to specify the mapping or not use this at all.
>  #endif
>  
> +#ifdef ENTRY_DEEPSLEEP_SETUP
> +     LOAD_REG_ADDR(r6, 2f)
> +     mfmsr   r7
> +     rlwinm  r7,r7,0,~(MSR_IS|MSR_DS)
> +#else
>       lis     r7,MSR_KERNEL@h
>       ori     r7,r7,MSR_KERNEL@l
>       bl      1f                      /* Find our address */
>  1:   mflr    r9
>       rlwimi  r6,r9,0,20,31
>       addi    r6,r6,(2f - 1b)
> +#endif

Could you explain what's going on here?  What does the TLB look like before 
and after?

> +int fsl_dp_iomap(void)

I don't think this needs to be global (see the comment where it gets called), 
but if it must be, this name is too terse.

> +{
> +     struct device_node *np;
> +     int ret = 0;
> +     phys_addr_t ccsr_phy_addr, dcsr_phy_addr;
> +
> +     saved_law = NULL;
> +     ccsr_base = NULL;
> +     dcsr_base = NULL;
> +     pld_base = NULL;
> +
> +     ccsr_phy_addr = get_immrbase();
> +     if (ccsr_phy_addr == -1) {
> +             pr_err("%s: Can't get the address of CCSR\n", __func__);
> +             ret = -EINVAL;
> +             goto ccsr_err;
> +     }
> +     ccsr_base = ioremap(ccsr_phy_addr, SIZE_2MB);
> +     if (!ccsr_base) {
> +             ret = -ENOMEM;
> +             goto ccsr_err;
> +     }
> +
> +     dcsr_phy_addr = get_dcsrbase();
> +     if (dcsr_phy_addr == -1) {
> +             pr_err("%s: Can't get the address of DCSR\n", __func__);
> +             ret = -EINVAL;
> +             goto dcsr_err;
> +     }
> +     dcsr_base = ioremap(dcsr_phy_addr, SIZE_1MB);
> +     if (!dcsr_base) {
> +             ret = -ENOMEM;
> +             goto dcsr_err;
> +     }

Please just map the device tree nodes you need.

> +
> +     np = of_find_compatible_node(NULL, NULL, "fsl,tetra-fpga");
> +     if (np) {
> +             pld_flag = T1040QDS_TETRA_FLAG;
> +     } else {
> +             np = of_find_compatible_node(NULL, NULL, "fsl,deepsleep-cpld");

I've already rejected fsl,deepsleep-cpld multiple times when others tried to 
add it to a device tree.

> +{
> +     u32 ddr_buff_addr;
> +
> +     /*
> +      * DDR training initialization will break 128 bytes at the beginning
> +      * of DDR, therefore, save them so that the bootloader will restore
> +      * them. Assume that DDR is mapped to the address space started with
> +      * CONFIG_PAGE_OFFSET.
> +      */
> +     memcpy(ddr_buff, (void *)CONFIG_PAGE_OFFSET, DDR_BUF_SIZE);

That assumption may not be true in all relocatable scenarios.

It'd be a lot simpler to just mark that first page as reserved.

> +     /* assume ddr_buff is in the physical address space of 4GB */
> +     ddr_buff_addr = (u32)(__pa(ddr_buff) & 0xffffffff);
> +
> +     /*
> +      * the bootloader will restore the first 128 bytes of DDR from
> +      * the location indicated by the register SPARECR3
> +      */
> +     out_be32(ccsr_base + CCSR_SCFG_SPARECR3, ddr_buff_addr);

...yeah, please just mark it reserved.

> +}
> +
> +static void fsl_dp_mp_save(void *ccsr)
> +{
> +      struct fsl_bstr *dst = &saved_bstr;
> +
> +      dst->bstrh = in_be32(ccsr + LCC_BSTRH);
> +      dst->bstrl = in_be32(ccsr + LCC_BSTRL);
> +      dst->bstar = in_be32(ccsr + LCC_BSTAR);
> +      dst->cpu_mask = in_be32(ccsr + DCFG_BASE + DCFG_BRR);
> +}

What is "mp"?

> +static void fsl_dp_law_save(void *ccsr)
> +{
> +     int i;
> +     struct fsl_law *dst = saved_law;
> +     struct fsl_law *src = (void *)(ccsr + CCSR_LAW_BASE);
> +
> +     for (i = 0; i < num_laws; i++) {
> +             dst->lawbarh = in_be32(&src->lawbarh);
> +             dst->lawbarl = in_be32(&src->lawbarl);
> +             dst->lawar = in_be32(&src->lawar);
> +             dst++;
> +             src++;
> +     }
> +}

Why wouldn't U-Boot restore these the same way on resume as they are now?

> +int fsl_enter_epu_deepsleep(void)
> +{
> +     fsl_dp_ddr_save(ccsr_base);
> +
> +     fsl_dp_set_resume_pointer(ccsr_base);
> +
> +     fsl_dp_mp_save(ccsr_base);
> +     fsl_dp_law_save(ccsr_base);
> +     /*  enable Warm Device Reset request. */
> +     setbits32(ccsr_base + CCSR_SCFG_DPSLPCR, CCSR_SCFG_DPSLPCR_WDRR_EN);
> +
> +     /* set GPIO1_29 as an output pin (not open-drain), and output 0 */
> +     clrbits32(ccsr_base + CCSR_GPIO1_GPDAT, CCSR_GPIO1_GPDIR_29);
> +     clrbits32(ccsr_base + CCSR_GPIO1_GPODR, CCSR_GPIO1_GPDIR_29);
> +     setbits32(ccsr_base + CCSR_GPIO1_GPDIR, CCSR_GPIO1_GPDIR_29);
> +
> +     /*
> +      * Disable CPC speculation to avoid deep sleep hang, especially
> +      * in secure boot mode. This bit will be cleared automatically
> +      * when resuming from deep sleep.
> +      */
> +     setbits32(ccsr_base + CPC_CPCHDBCR0, CPC_CPCHDBCR0_SPEC_DIS);

Is there an erratum for this?

> +     fsl_epu_setup_default(dcsr_base + EPU_BLOCK_OFFSET);
> +     fsl_npc_setup_default(dcsr_base + NPC_BLOCK_OFFSET);
> +
> +     out_be32(dcsr_base + RCPM_BLOCK_OFFSET + CSTTACR0, 0x00001001);
> +     out_be32(dcsr_base + RCPM_BLOCK_OFFSET + CG1CR0, 0x00000001);

What is 0x1001 and 0x1 here?

> diff --git a/arch/powerpc/platforms/85xx/qoriq_pm.c 
> b/arch/powerpc/platforms/85xx/qoriq_pm.c
> index 27ec337..f65f6cf 100644
> --- a/arch/powerpc/platforms/85xx/qoriq_pm.c
> +++ b/arch/powerpc/platforms/85xx/qoriq_pm.c
> @@ -17,17 +17,68 @@
>  
>  #include <asm/fsl_pm.h>
>  
> +static suspend_state_t cur_pm_state;
> +
> +/**
> + * fsl_set_power_except - set which IP block is not powerdown when sleep or
> + * deep sleep, such as MAC, USB, etc.
> + *
> + * @dev: a pointer to the struct device of the device with wakeup 
> capability
> + * @on: if 1, do not power down; if 0, power down.
> + */
> +static void fsl_set_power_except(struct device *dev, int on)
> +{
> +     u32 value[2];
> +     int ret;
> +
> +     ret = of_property_read_u32_array(dev->of_node, "sleep", value, 2);
> +     if (ret)
> +             goto out;

This property is not defined in the binding for t1040, and was largely 
abandoned.  Nothing in the kernel currently uses it.

It might be better to do something with the clock API.  Then again, it might 
be an odd fit given the odd nature of this register.  Then again, it's an 
equally bad fit for the sleep property as currently documented (on the only 
85xx the binding supports, it's used for DEVDISR).  In any case, don't use 
this without a binding update.

This function will also crash if you pass it a device that doesn't have an 
of_node.

>       switch (state) {
>       case PM_SUSPEND_STANDBY:
> +
>               cur_cpu_spec->cpu_down_flush();
> +
>               ret = qoriq_pm_ops->plat_enter_sleep();
> +
> +             break;

Why are you adding these blank lines, particularly right after the case line?

> +     case PM_SUSPEND_MEM:
> +
> +             cpu = smp_processor_id();
> +             qoriq_pm_ops->irq_mask(cpu);

Should this be hard_smp_processor_id()?

> +static int qoriq_suspend_begin(suspend_state_t state)
> +{
> +     const int enable = 1;
> +
> +     cur_pm_state = state;
> +     dpm_for_each_dev((void *)&enable, qoriq_set_wakeup_source);

Unnecessary cast.

> +
> +     if (cur_pm_state == PM_SUSPEND_MEM)
> +             return fsl_dp_iomap();
> +
> +     return 0;
> +}
> +
> +static void qoriq_suspend_end(void)
> +{
> +     const int enable = 0;
> +
> +     dpm_for_each_dev((void *)&enable, qoriq_set_wakeup_source);
> +
> +     if (cur_pm_state == PM_SUSPEND_MEM)
> +             fsl_dp_iounmap();
> +}

Why are you mapping/unmapping on demand?  Just map it once at bootup.

 static int __init qoriq_suspend_init(void)
>  {
>       suspend_set_ops(&qoriq_suspend_ops);
> -
>       return 0;
>  }

Please don't make random whitespace changes, especially to code you're not 
otherwise touching.


>  arch_initcall(qoriq_suspend_init);
> diff --git a/arch/powerpc/platforms/85xx/t104x_deepsleep.S 
> b/arch/powerpc/platforms/85xx/t104x_deepsleep.S
> new file mode 100644
> index 0000000..773a9e4
> --- /dev/null
> +++ b/arch/powerpc/platforms/85xx/t104x_deepsleep.S
> @@ -0,0 +1,570 @@
> +/*
> + * Enter and resume from deep sleep state
> + *
> + * Copyright 2015 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute       it and/or modify it
> + * under  the terms of       the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <asm/page.h>
> +#include <asm/ppc_asm.h>
> +#include <asm/reg.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/fsl_pm.h>
> +#include <asm/mmu.h>
> +
> +/*
> + * the number of bytes occupied by one register
> + * the value of 8 is compatible with both 32-bit and 64-bit registers
> + */
> +#define STRIDE_SIZE          8
> +
> +/* GPR0 - GPR31 */
> +#define BOOKE_GPR0_OFF               0x0000
> +#define BOOKE_GPR_COUNT              32
> +/* IVOR0 - IVOR42 */
> +#define BOOKE_IVOR0_OFF         (BOOKE_GPR0_OFF + BOOKE_GPR_COUNT * STRIDE_SIZE)
> +#define BOOKE_IVOR_COUNT     43
> +/* SPRG0 - SPRG9 */
> +#define BOOKE_SPRG0_OFF         (BOOKE_IVOR0_OFF + BOOKE_IVOR_COUNT * 
> STRIDE_SIZE)
> +#define BOOKE_SPRG_COUNT     10
> +/* IVPR */
> +#define BOOKE_IVPR_OFF          (BOOKE_SPRG0_OFF + BOOKE_SPRG_COUNT * 
> STRIDE_SIZE)
> +
> +#define BOOKE_LR_OFF         (BOOKE_IVPR_OFF + STRIDE_SIZE)
> +#define BOOKE_MSR_OFF                (BOOKE_LR_OFF + STRIDE_SIZE)
> +#define BOOKE_TBU_OFF                (BOOKE_MSR_OFF + STRIDE_SIZE)
> +#define BOOKE_TBL_OFF                (BOOKE_TBU_OFF + STRIDE_SIZE)
> +#define BOOKE_EPCR_OFF               (BOOKE_TBL_OFF + STRIDE_SIZE)
> +#define BOOKE_HID0_OFF               (BOOKE_EPCR_OFF + STRIDE_SIZE)
> +#define BOOKE_PIR_OFF                (BOOKE_HID0_OFF + STRIDE_SIZE)
> +#define BOOKE_PID0_OFF               (BOOKE_PIR_OFF + STRIDE_SIZE)
> +#define BOOKE_BUCSR_OFF              (BOOKE_PID0_OFF + STRIDE_SIZE)
> +
> +#define BUFFER_SIZE          (BOOKE_BUCSR_OFF + STRIDE_SIZE)
> +
> +#undef SAVE_GPR
> +#define SAVE_GPR(gpr, offset) \
> +     PPC_STL gpr, offset(r10)
> +
> +#define RESTORE_GPR(gpr, offset) \
> +     PPC_LL gpr, offset(r10)
> +
> +#define SAVE_SPR(spr, offset) \
> +     mfspr   r0, spr ;\
> +     PPC_STL r0, offset(r10)
> +
> +#define RESTORE_SPR(spr, offset) \
> +     PPC_LL  r0, offset(r10) ;\
> +     mtspr   spr, r0

No space before ;

> +/* reset time base to prevent from overflow */
> +/*
> + * There are two kind of register maps, one for T1040QDS and
> + * the other for T104xRDB.
> + */

And then what happens on a custom board?  Is there any way this stuff can 
happen earlier, from C code?  In any case, please rework so that there's a 
function pointer for board-specific logic.

-Scott
