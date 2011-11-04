Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (mail-va3.bigfish.com [216.32.180.10])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 2EE45B6F7F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Nov 2011 05:35:24 +1100 (EST)
Received: from mail153-va3 (localhost [127.0.0.1])	by
 mail153-va3-R.bigfish.com (Postfix) with ESMTP id A2B5A4802D5	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 18:35:45 +0000 (UTC)
Received: from VA3EHSMHS007.bigfish.com (unknown [10.7.14.248])	by
 mail153-va3.bigfish.com (Postfix) with ESMTP id 1C489300044	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 18:35:45 +0000 (UTC)
Message-ID: <4EB4305C.6030303@freescale.com>
Date: Fri, 4 Nov 2011 13:35:08 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH 2/7] powerpc/85xx: add HOTPLUG_CPU support
References: <1320409889-14408-1-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1320409889-14408-1-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/04/2011 07:31 AM, Zhao Chenhui wrote:
> From: Li Yang <leoli@freescale.com>
> 
> Add support to disable and re-enable individual cores at runtime
> on MPC85xx/QorIQ SMP machines. Currently support e500 core.
> 
> MPC85xx machines use ePAPR spin-table in boot page for CPU kick-off.
> This patch uses the boot page from bootloader to boot core at runtime.
> It supports 32-bit and 36-bit physical address.

Note that there is no guarantee that the bootloader can handle you
resetting a core.  In ePAPR the spin table is a one-time release
mechanism, not a core reset mechanism.  If this has a U-Boot dependency,
document that.

>  #ifdef CONFIG_SMP
>  /* When we get here, r24 needs to hold the CPU # */
>  	.globl __secondary_start
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 7bf2187..12a54f0 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -381,8 +381,14 @@ void generic_cpu_die(unsigned int cpu)
>  
>  	for (i = 0; i < 100; i++) {
>  		smp_rmb();
> -		if (per_cpu(cpu_state, cpu) == CPU_DEAD)
> +		if (per_cpu(cpu_state, cpu) == CPU_DEAD) {
> +			/*
> +			 * After another core sets cpu_state to CPU_DEAD,
> +			 * it needs some time to die.
> +			 */
> +			msleep(10);
>  			return;
> +		}
>  		msleep(100);

It would be better to do this as a call into platform-specific code than
can check registers to determine whether the core has checked out (in
our case, whether it has entered nap) -- or to do a suitable delay for
that platform if this isn't possible.

> diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
> index 9b0de9c..5a54fc1 100644
> --- a/arch/powerpc/platforms/85xx/smp.c
> +++ b/arch/powerpc/platforms/85xx/smp.c
> @@ -17,6 +17,7 @@
>  #include <linux/of.h>
>  #include <linux/kexec.h>
>  #include <linux/highmem.h>
> +#include <linux/cpu.h>
>  
>  #include <asm/machdep.h>
>  #include <asm/pgtable.h>
> @@ -30,26 +31,141 @@
>  
>  extern void __early_start(void);
>  
> -#define BOOT_ENTRY_ADDR_UPPER	0
> -#define BOOT_ENTRY_ADDR_LOWER	1
> -#define BOOT_ENTRY_R3_UPPER	2
> -#define BOOT_ENTRY_R3_LOWER	3
> -#define BOOT_ENTRY_RESV		4
> -#define BOOT_ENTRY_PIR		5
> -#define BOOT_ENTRY_R6_UPPER	6
> -#define BOOT_ENTRY_R6_LOWER	7
> -#define NUM_BOOT_ENTRY		8
> -#define SIZE_BOOT_ENTRY		(NUM_BOOT_ENTRY * sizeof(u32))
> -
> -static int __init
> -smp_85xx_kick_cpu(int nr)
> +#define MPC85xx_BPTR_OFF		0x00020
> +#define MPC85xx_BPTR_EN			0x80000000
> +#define MPC85xx_BPTR_BOOT_PAGE_MASK	0x00ffffff
> +#define MPC85xx_BRR_OFF			0xe0e4
> +#define MPC85xx_ECM_EEBPCR_OFF		0x01010
> +#define MPC85xx_PIC_PIR_OFF		0x41090
> +
> +struct epapr_entry {

ePAPR is more than just the spin table.  Call it something like
epapr_spin_table.

> +	u32	addr_h;
> +	u32	addr_l;
> +	u32	r3_h;
> +	u32	r3_l;
> +	u32	reserved;
> +	u32	pir;
> +	u32	r6_h;
> +	u32	r6_l;
> +};

Get rid of r6, it is not part of the ePAPR spin table.

> +static int is_corenet;
> +static void __cpuinit smp_85xx_setup_cpu(int cpu_nr);
> +
> +#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC32)

Why PPC32?

> +extern void flush_disable_L1(void);

If this isn't already in a header file, put it in one.

> +static void __cpuinit smp_85xx_mach_cpu_die(void)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	register u32 tmp;
> +
> +	local_irq_disable();
> +	idle_task_exit();
> +	generic_set_cpu_dead(cpu);
> +	smp_wmb();
> +
> +	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
> +	mtspr(SPRN_TCR, 0);

If clearing TSR matters at all (I'm not sure that it does), first clear
TCR, then TSR.

> +	flush_disable_L1();

You'll also need to take down L2 on e500mc.

> +	tmp = 0;
> +	if (cpu_has_feature(CPU_FTR_CAN_NAP))
> +		tmp = HID0_NAP;
> +	else if (cpu_has_feature(CPU_FTR_CAN_DOZE))
> +		tmp = HID0_DOZE;

Those FTR bits are for what we can do in idle, and can be cleared if the
user sets CONFIG_BDI_SWITCH.

On 85xx we always want to nap here, and at least on e500mc it seems to
be mandatory.  From the p5020 RM description of PIR:

> For proper system operation, a core should be reset in this way only if the core is already in nap or sleep
> state. Because a core in either state cannot perform the necessary write to cause a hard reset, a core cannot
> put itself into hard reset.

Note that on e500mc we don't use HID0/MSR_WE to enter nap, we need to
hit the CCSR register.  And unless you can somehow guarantee that only
one core at a time is doing this, we'll need some oher core to actually
place us in nap (since once we enter nap we're not running so can't
release a lock).

> +	if (tmp) {
> +		tmp |= mfspr(SPRN_HID0) & ~(HID0_DOZE|HID0_NAP|HID0_SLEEP);
> +
> +		smp_mb();

smp_mb()?  This is always SMP...  It looks like you meant some specific
sync instruction as part of an architected sequence, so just use that.

> +		isync();
> +		mtspr(SPRN_HID0, tmp);
> +		isync();
> +
> +		tmp = mfmsr();
> +		tmp |= MSR_WE;
> +		smp_mb();
> +		mtmsr(tmp);
> +		isync();
> +	}
> +
> +	for (;;);
> +}
> +
> +static void __cpuinit smp_85xx_reset_core(int nr)
> +{
> +	__iomem u32 *vaddr, *pir_vaddr;
> +	u32 val, cpu_mask;
> +
> +	/* If CoreNet platform, use BRR as release register. */
> +	if (is_corenet) {
> +		cpu_mask = 1 << nr;
> +		vaddr = ioremap(get_immrbase() + MPC85xx_BRR_OFF, 4);
> +	} else {
> +		cpu_mask = 1 << (24 + nr);
> +		vaddr = ioremap(get_immrbase() + MPC85xx_ECM_EEBPCR_OFF, 4);
> +	}

Please use the device tree node, not get_immrbase().

> +	val = in_be32(vaddr);
> +	if (!(val & cpu_mask)) {
> +		out_be32(vaddr, val | cpu_mask);
> +	} else {
> +		/* reset core */
> +		pir_vaddr = ioremap(get_immrbase() + MPC85xx_PIC_PIR_OFF, 4);
> +		val = in_be32(pir_vaddr);
> +		/* reset assert */
> +		val |= (1 << nr);
> +		out_be32(pir_vaddr, val);

Use setbits32().

> +		val = in_be32(pir_vaddr);
> +		val &= ~(1 << nr);
> +		/* reset negate */
> +		out_be32(pir_vaddr, val);

clrbits32().

Is there any amount of time we need to keep the reset pin asserted?

> +		iounmap(pir_vaddr);
> +	}
> +	iounmap(vaddr);
> +}
> +
> +static int __cpuinit smp_85xx_map_bootpg(u32 page)
> +{
> +	__iomem u32 *bootpg_ptr;
> +	u32 bptr;
> +
> +	/* Get the BPTR */
> +	bootpg_ptr = ioremap(get_immrbase() + MPC85xx_BPTR_OFF, 4);
> +
> +	/* Set the BPTR to the secondary boot page */
> +	bptr = MPC85xx_BPTR_EN | (page & MPC85xx_BPTR_BOOT_PAGE_MASK);
> +	out_be32(bootpg_ptr, bptr);
> +
> +	iounmap(bootpg_ptr);
> +	return 0;
> +}

Shouldn't the boot page already be set by U-Boot?

> +static int __cpuinit smp_85xx_kick_cpu(int nr)
>  {
>  	unsigned long flags;
>  	const u64 *cpu_rel_addr;
> -	__iomem u32 *bptr_vaddr;
> +	__iomem struct epapr_entry *epapr;
>  	struct device_node *np;
> -	int n = 0;
> +	int n = 0, hw_cpu = get_hard_smp_processor_id(nr);
>  	int ioremappable;
> +	int ret = 0;
>  
>  	WARN_ON (nr < 0 || nr >= NR_CPUS);
>  
> @@ -73,46 +189,79 @@ smp_85xx_kick_cpu(int nr)
>  
>  	/* Map the spin table */
>  	if (ioremappable)
> -		bptr_vaddr = ioremap(*cpu_rel_addr, SIZE_BOOT_ENTRY);
> +		epapr = ioremap(*cpu_rel_addr, sizeof(struct epapr_entry));
>  	else
> -		bptr_vaddr = phys_to_virt(*cpu_rel_addr);
> +		epapr = phys_to_virt(*cpu_rel_addr);
>  
>  	local_irq_save(flags);
>  
> -	out_be32(bptr_vaddr + BOOT_ENTRY_PIR, nr);
> +	out_be32(&epapr->pir, hw_cpu);
>  #ifdef CONFIG_PPC32
> -	out_be32(bptr_vaddr + BOOT_ENTRY_ADDR_LOWER, __pa(__early_start));
> +#ifdef CONFIG_HOTPLUG_CPU
> +	if (system_state == SYSTEM_RUNNING) {
> +		out_be32(&epapr->addr_l, 0);
> +		smp_85xx_map_bootpg((u32)(*cpu_rel_addr >> PAGE_SHIFT));

Why is this inside PPC32?

> +		smp_85xx_reset_core(hw_cpu);
> +
> +		/* wait until core is ready... */
> +		n = 0;
> +		while ((in_be32(&epapr->addr_l) != 1) && (++n < 1000))
> +			udelay(100);
> +		if (n > 1000) {

if (n == 1000)

or

if (in_be32(&epapr->addr_l) != 1)

> +			pr_err("timeout waiting for core%d to reset\n",	nr);
> +			ret = -ENOENT;
> +			goto out;
> +		}
> +		/*  clear the acknowledge status */
> +		__secondary_hold_acknowledge = -1;
> +
> +		smp_85xx_unmap_bootpg();
> +	}
> +#endif
> +	out_be32(&epapr->addr_l, __pa(__early_start));
>  
>  	if (!ioremappable)
> -		flush_dcache_range((ulong)bptr_vaddr,
> -				(ulong)(bptr_vaddr + SIZE_BOOT_ENTRY));
> +		flush_dcache_range((ulong)epapr,
> +				(ulong)epapr + sizeof(struct epapr_entry));
>  
>  	/* Wait a bit for the CPU to ack. */
> -	while ((__secondary_hold_acknowledge != nr) && (++n < 1000))
> +	n = 0;
> +	while ((__secondary_hold_acknowledge != hw_cpu) && (++n < 1000))
>  		mdelay(1);
> +	if (n > 1000) {

if (n == 1000)

or

if (__secondary_hold_acknowledge != hw_cpu)

> +		pr_err("timeout waiting for core%d to ack\n", nr);

pr_err("%s: timeout waiting for core %d to ack\n", __func__, nr);

Likewise elsewhere.  Maybe also/instead mention hw_cpu.

> +		ret = -ENOENT;
> +		goto out;
> +	}
> +out:
>  #else
>  	smp_generic_kick_cpu(nr);
>  
> -	out_be64((u64 *)(bptr_vaddr + BOOT_ENTRY_ADDR_UPPER),
> +	out_be64((u64 *)(&epapr->addr_h),
>  		__pa((u64)*((unsigned long long *) generic_secondary_smp_init)));
>  
>  	if (!ioremappable)
> -		flush_dcache_range((ulong)bptr_vaddr,
> -				(ulong)(bptr_vaddr + SIZE_BOOT_ENTRY));
> +		flush_dcache_range((ulong)epapr,
> +				(ulong)epapr + sizeof(struct epapr_entry));

We don't wait for the core to come up on 64-bit?

> @@ -228,14 +376,18 @@ void __init mpc85xx_smp_init(void)
>  {
>  	struct device_node *np;
>  
> -	smp_85xx_ops.setup_cpu = smp_85xx_setup_cpu;
> -
>  	np = of_find_node_by_type(NULL, "open-pic");
>  	if (np) {
>  		smp_85xx_ops.probe = smp_mpic_probe;
>  		smp_85xx_ops.message_pass = smp_mpic_message_pass;
>  	}
>  
> +	/* Check if the chip is based on CoreNet platform. */
> +	is_corenet = 0;
> +	np = of_find_compatible_node(NULL, NULL, "fsl,qoriq-device-config-1.0");
> +	if (np)
> +		is_corenet = 1;

Please also check for the non-corenet guts node.  If you don't find
either, disable the mechanism -- you're probably running under a hypervisor.

-Scott
