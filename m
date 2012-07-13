Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 42FCA2C0348
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 22:15:12 +1000 (EST)
Subject: Re: [PATCH v7 2/5] powerpc/85xx: add HOTPLUG_CPU support
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1341310879-5468-2-git-send-email-chenhui.zhao@freescale.com>
Date: Fri, 13 Jul 2012 07:15:06 -0500
Message-Id: <0090811B-107A-4496-ADF1-DD07081BF6B9@kernel.crashing.org>
References: <1341310879-5468-1-git-send-email-chenhui.zhao@freescale.com>
 <1341310879-5468-2-git-send-email-chenhui.zhao@freescale.com>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 3, 2012, at 5:21 AM, Zhao Chenhui wrote:

> From: Li Yang <leoli@freescale.com>
>=20
> Add support to disable and re-enable individual cores at runtime
> on MPC85xx/QorIQ SMP machines. Currently support e500v1/e500v2 core.
>=20
> MPC85xx machines use ePAPR spin-table in boot page for CPU kick-off.
> This patch uses the boot page from bootloader to boot core at runtime.
> It supports 32-bit and 36-bit physical address.
>=20
> Add generic_set_cpu_up() to set cpu_state as CPU_UP_PREPARE in =
kick_cpu().

Shouldn't the generic_setup_cpu_up() be a separate patch, and refactor =
smp_generic_kick_cpu() to use it.

Also, we should pull the conversion of the spintable from #defines to =
struct into a separate patch before this one.

>=20
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Jin Qing <b24347@freescale.com>
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> ---
> v7:
> * removed CONFIG_85xx_TB_SYNC
> no change to the rest of the patch set
>=20
> arch/powerpc/Kconfig                  |    6 +-
> arch/powerpc/include/asm/cacheflush.h |    2 +
> arch/powerpc/include/asm/smp.h        |    2 +
> arch/powerpc/kernel/head_fsl_booke.S  |   28 +++++++
> arch/powerpc/kernel/smp.c             |   10 +++
> arch/powerpc/platforms/85xx/smp.c     |  137 =
++++++++++++++++++++++++---------
> 6 files changed, 146 insertions(+), 39 deletions(-)
>=20
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 38786c8..d6bacbe 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -220,7 +220,8 @@ config ARCH_HIBERNATION_POSSIBLE
> config ARCH_SUSPEND_POSSIBLE
> 	def_bool y
> 	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx || \
> -		   (PPC_85xx && !SMP) || PPC_86xx || PPC_PSERIES || 44x =
|| 40x
> +		   (PPC_85xx && !PPC_E500MC) || PPC_86xx || PPC_PSERIES =
\
> +		   || 44x || 40x
>=20
> config PPC_DCR_NATIVE
> 	bool
> @@ -331,7 +332,8 @@ config SWIOTLB
>=20
> config HOTPLUG_CPU
> 	bool "Support for enabling/disabling CPUs"
> -	depends on SMP && HOTPLUG && EXPERIMENTAL && (PPC_PSERIES || =
PPC_PMAC || PPC_POWERNV)
> +	depends on SMP && HOTPLUG && EXPERIMENTAL && (PPC_PSERIES || \
> +	PPC_PMAC || PPC_POWERNV || (PPC_85xx && !PPC_E500MC))
> 	---help---
> 	  Say Y here to be able to disable and re-enable individual
> 	  CPUs at runtime on SMP machines.
> diff --git a/arch/powerpc/include/asm/cacheflush.h =
b/arch/powerpc/include/asm/cacheflush.h
> index ab9e402..b843e35 100644
> --- a/arch/powerpc/include/asm/cacheflush.h
> +++ b/arch/powerpc/include/asm/cacheflush.h
> @@ -30,6 +30,8 @@ extern void flush_dcache_page(struct page *page);
> #define flush_dcache_mmap_lock(mapping)		do { } while (0)
> #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
>=20
> +extern void __flush_disable_L1(void);
> +
> extern void __flush_icache_range(unsigned long, unsigned long);
> static inline void flush_icache_range(unsigned long start, unsigned =
long stop)
> {
> diff --git a/arch/powerpc/include/asm/smp.h =
b/arch/powerpc/include/asm/smp.h
> index ebc24dc..e807e9d 100644
> --- a/arch/powerpc/include/asm/smp.h
> +++ b/arch/powerpc/include/asm/smp.h
> @@ -65,6 +65,7 @@ int generic_cpu_disable(void);
> void generic_cpu_die(unsigned int cpu);
> void generic_mach_cpu_die(void);
> void generic_set_cpu_dead(unsigned int cpu);
> +void generic_set_cpu_up(unsigned int cpu);
> int generic_check_cpu_restart(unsigned int cpu);
> #endif
>=20
> @@ -190,6 +191,7 @@ extern unsigned long __secondary_hold_spinloop;
> extern unsigned long __secondary_hold_acknowledge;
> extern char __secondary_hold;
>=20
> +extern void __early_start(void);
> #endif /* __ASSEMBLY__ */
>=20
> #endif /* __KERNEL__ */
> diff --git a/arch/powerpc/kernel/head_fsl_booke.S =
b/arch/powerpc/kernel/head_fsl_booke.S
> index de80e0f..be0261b 100644
> --- a/arch/powerpc/kernel/head_fsl_booke.S
> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> @@ -996,6 +996,34 @@ _GLOBAL(flush_dcache_L1)
>=20
> 	blr
>=20
> +/* Flush L1 d-cache, invalidate and disable d-cache and i-cache */
> +_GLOBAL(__flush_disable_L1)
> +	mflr	r10
> +	bl	flush_dcache_L1	/* Flush L1 d-cache */
> +	mtlr	r10
> +
> +	mfspr	r4, SPRN_L1CSR0	/* Invalidate and disable d-cache */
> +	li	r5, 2
> +	rlwimi	r4, r5, 0, 3
> +
> +	msync
> +	isync
> +	mtspr	SPRN_L1CSR0, r4
> +	isync
> +
> +1:	mfspr	r4, SPRN_L1CSR0	/* Wait for the invalidate to finish */
> +	andi.	r4, r4, 2
> +	bne	1b
> +
> +	mfspr	r4, SPRN_L1CSR1	/* Invalidate and disable i-cache */
> +	li	r5, 2
> +	rlwimi	r4, r5, 0, 3
> +
> +	mtspr	SPRN_L1CSR1, r4
> +	isync
> +
> +	blr
> +
> #ifdef CONFIG_SMP
> /* When we get here, r24 needs to hold the CPU # */
> 	.globl __secondary_start
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index d9f9441..e0ffe03 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -423,6 +423,16 @@ void generic_set_cpu_dead(unsigned int cpu)
> 	per_cpu(cpu_state, cpu) =3D CPU_DEAD;
> }
>=20
> +/*
> + * The cpu_state should be set to CPU_UP_PREPARE in kick_cpu(), =
otherwise
> + * the cpu_state is always CPU_DEAD after calling =
generic_set_cpu_dead(),
> + * which makes the delay in generic_cpu_die() not happen.
> + */
> +void generic_set_cpu_up(unsigned int cpu)
> +{
> +	per_cpu(cpu_state, cpu) =3D CPU_UP_PREPARE;
> +}
> +
> int generic_check_cpu_restart(unsigned int cpu)
> {
> 	return per_cpu(cpu_state, cpu) =3D=3D CPU_UP_PREPARE;
> diff --git a/arch/powerpc/platforms/85xx/smp.c =
b/arch/powerpc/platforms/85xx/smp.c
> index 2e65fe8..925e678 100644
> --- a/arch/powerpc/platforms/85xx/smp.c
> +++ b/arch/powerpc/platforms/85xx/smp.c
> @@ -2,7 +2,7 @@
>  * Author: Andy Fleming <afleming@freescale.com>
>  * 	   Kumar Gala <galak@kernel.crashing.org>
>  *
> - * Copyright 2006-2008, 2011 Freescale Semiconductor Inc.
> + * Copyright 2006-2008, 2011-2012 Freescale Semiconductor Inc.
>  *
>  * This program is free software; you can redistribute  it and/or =
modify it
>  * under  the terms of  the GNU General  Public License as published =
by the
> @@ -17,6 +17,7 @@
> #include <linux/of.h>
> #include <linux/kexec.h>
> #include <linux/highmem.h>
> +#include <linux/cpu.h>
>=20
> #include <asm/machdep.h>
> #include <asm/pgtable.h>
> @@ -30,18 +31,14 @@
> #include <sysdev/mpic.h>
> #include "smp.h"
>=20
> -extern void __early_start(void);
> -
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
> +struct epapr_spin_table {
> +	u32	addr_h;
> +	u32	addr_l;
> +	u32	r3_h;
> +	u32	r3_l;
> +	u32	reserved;
> +	u32	pir;
> +};
>=20
> static struct ccsr_guts __iomem *guts;
> static u64 timebase;
> @@ -101,15 +98,45 @@ static void mpc85xx_take_timebase(void)
> 	local_irq_restore(flags);
> }
>=20
> -static int __init
> -smp_85xx_kick_cpu(int nr)
> +#ifdef CONFIG_HOTPLUG_CPU
> +static void __cpuinit smp_85xx_mach_cpu_die(void)
> +{
> +	unsigned int cpu =3D smp_processor_id();
> +	u32 tmp;
> +
> +	local_irq_disable();
> +	idle_task_exit();
> +	generic_set_cpu_dead(cpu);
> +	mb();
> +
> +	mtspr(SPRN_TCR, 0);
> +
> +	__flush_disable_L1();
> +	tmp =3D (mfspr(SPRN_HID0) & ~(HID0_DOZE|HID0_SLEEP)) | HID0_NAP;
> +	mtspr(SPRN_HID0, tmp);
> +	isync();
> +
> +	/* Enter NAP mode. */
> +	tmp =3D mfmsr();
> +	tmp |=3D MSR_WE;
> +	mb();
> +	mtmsr(tmp);
> +	isync();
> +
> +	while (1)
> +		;
> +}
> +#endif
> +
> +static int __cpuinit smp_85xx_kick_cpu(int nr)
> {
> 	unsigned long flags;
> 	const u64 *cpu_rel_addr;
> -	__iomem u32 *bptr_vaddr;
> +	__iomem struct epapr_spin_table *spin_table;
> 	struct device_node *np;
> -	int n =3D 0, hw_cpu =3D get_hard_smp_processor_id(nr);
> +	int hw_cpu =3D get_hard_smp_processor_id(nr);
> 	int ioremappable;
> +	int ret =3D 0;
>=20
> 	WARN_ON(nr < 0 || nr >=3D NR_CPUS);
> 	WARN_ON(hw_cpu < 0 || hw_cpu >=3D NR_CPUS);
> @@ -134,46 +161,80 @@ smp_85xx_kick_cpu(int nr)
>=20
> 	/* Map the spin table */
> 	if (ioremappable)
> -		bptr_vaddr =3D ioremap(*cpu_rel_addr, SIZE_BOOT_ENTRY);
> +		spin_table =3D ioremap(*cpu_rel_addr,
> +				sizeof(struct epapr_spin_table));
> 	else
> -		bptr_vaddr =3D phys_to_virt(*cpu_rel_addr);
> +		spin_table =3D phys_to_virt(*cpu_rel_addr);
>=20
> 	local_irq_save(flags);
> -
> -	out_be32(bptr_vaddr + BOOT_ENTRY_PIR, hw_cpu);
> #ifdef CONFIG_PPC32
> -	out_be32(bptr_vaddr + BOOT_ENTRY_ADDR_LOWER, =
__pa(__early_start));
> +#ifdef CONFIG_HOTPLUG_CPU
> +	/* Corresponding to generic_set_cpu_dead() */
> +	generic_set_cpu_up(nr);
> +
> +	if (system_state =3D=3D SYSTEM_RUNNING) {
> +		out_be32(&spin_table->addr_l, 0);
> +
> +		/*
> +		 * We don't set the BPTR register here since it already =
points
> +		 * to the boot page properly.
> +		 */
> +		mpic_reset_core(hw_cpu);
> +
> +		/* wait until core is ready... */
> +		if (!spin_event_timeout(in_be32(&spin_table->addr_l) =3D=3D=
 1,
> +						10000, 100)) {
> +			pr_err("%s: timeout waiting for core %d to =
reset\n",
> +							__func__, =
hw_cpu);
> +			ret =3D -ENOENT;
> +			goto out;
> +		}
> +
> +		/*  clear the acknowledge status */
> +		__secondary_hold_acknowledge =3D -1;
> +	}
> +#endif
> +	out_be32(&spin_table->pir, hw_cpu);
> +	out_be32(&spin_table->addr_l, __pa(__early_start));
>=20
> 	if (!ioremappable)
> -		flush_dcache_range((ulong)bptr_vaddr,
> -				(ulong)(bptr_vaddr + SIZE_BOOT_ENTRY));
> +		flush_dcache_range((ulong)spin_table,
> +			(ulong)spin_table + sizeof(struct =
epapr_spin_table));
>=20
> 	/* Wait a bit for the CPU to ack. */
> -	while ((__secondary_hold_acknowledge !=3D hw_cpu) && (++n < =
1000))
> -		mdelay(1);
> +	if (!spin_event_timeout(__secondary_hold_acknowledge =3D=3D =
hw_cpu,
> +					10000, 100)) {
> +		pr_err("%s: timeout waiting for core %d to ack\n",
> +						__func__, hw_cpu);
> +		ret =3D -ENOENT;
> +		goto out;
> +	}
> +out:
> #else
> 	smp_generic_kick_cpu(nr);
>=20
> -	out_be64((u64 *)(bptr_vaddr + BOOT_ENTRY_ADDR_UPPER),
> -		__pa((u64)*((unsigned long long *) =
generic_secondary_smp_init)));
> +	out_be32(&spin_table->pir, hw_cpu);
> +	out_be64((u64 *)(&spin_table->addr_h),
> +	  __pa((u64)*((unsigned long long =
*)generic_secondary_smp_init)));
>=20
> 	if (!ioremappable)
> -		flush_dcache_range((ulong)bptr_vaddr,
> -				(ulong)(bptr_vaddr + SIZE_BOOT_ENTRY));
> +		flush_dcache_range((ulong)spin_table,
> +			(ulong)spin_table + sizeof(struct =
epapr_spin_table));
> #endif
> -
> 	local_irq_restore(flags);
>=20
> 	if (ioremappable)
> -		iounmap(bptr_vaddr);
> +		iounmap(spin_table);
>=20
> -	pr_debug("waited %d msecs for CPU #%d.\n", n, nr);
> -
> -	return 0;
> +	return ret;
> }
>=20
> struct smp_ops_t smp_85xx_ops =3D {
> 	.kick_cpu =3D smp_85xx_kick_cpu,
> +#ifdef CONFIG_HOTPLUG_CPU
> +	.cpu_disable	=3D generic_cpu_disable,
> +	.cpu_die	=3D generic_cpu_die,
> +#endif
> #ifdef CONFIG_KEXEC
> 	.give_timebase	=3D smp_generic_give_timebase,
> 	.take_timebase	=3D smp_generic_take_timebase,
> @@ -277,8 +338,7 @@ static void mpc85xx_smp_machine_kexec(struct =
kimage *image)
> }
> #endif /* CONFIG_KEXEC */
>=20
> -static void __init
> -smp_85xx_setup_cpu(int cpu_nr)
> +static void __cpuinit smp_85xx_setup_cpu(int cpu_nr)
> {
> 	if (smp_85xx_ops.probe =3D=3D smp_mpic_probe)
> 		mpic_setup_this_cpu();
> @@ -329,6 +389,9 @@ void __init mpc85xx_smp_init(void)
> 		}
> 		smp_85xx_ops.give_timebase =3D mpc85xx_give_timebase;
> 		smp_85xx_ops.take_timebase =3D mpc85xx_take_timebase;
> +#ifdef CONFIG_HOTPLUG_CPU
> +		ppc_md.cpu_die =3D smp_85xx_mach_cpu_die;
> +#endif
> 	}
>=20
> 	smp_ops =3D &smp_85xx_ops;
> --=20
> 1.6.4.1
>=20
