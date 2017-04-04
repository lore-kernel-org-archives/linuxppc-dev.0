Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vy8LM2s4czDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 23:03:55 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
 kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 06/12] powerpc/xive: Native exploitation of the XIVE
 interrupt controller
In-Reply-To: <20170320064914.4437-6-benh@kernel.crashing.org>
References: <20170320064914.4437-1-benh@kernel.crashing.org>
 <20170320064914.4437-6-benh@kernel.crashing.org>
Date: Tue, 04 Apr 2017 23:03:53 +1000
Message-ID: <87y3vgtjd2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> The XIVE interrupt controller is the new interrupt controller
> found in POWER9. It supports advanced virtualization capabilities
> among other things.
>
> Currently we use a set of firmware calls that simulate the old
> "XICS" interrupt controller but this is fairly inefficient.
>
> This adds the framework for using XIVE along with a native
> backend which OPAL for configuration. Later, a backend allowing
               ^
               calls?

> the use in a KVM or PowerVM guest will also be provided.
>
> This disables some fast path for interrupts in KVM when XIVE is
> enabled as these rely on the firmware emulation code which is no
> longer available when the XIVE is used natively by Linux.
>
> A latter patch will make KVM also directly exploit the XIVE, thus
> recovering the lost performance (and more).
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/include/asm/xive.h          |  116 +++
>  arch/powerpc/include/asm/xmon.h          |    2 +
>  arch/powerpc/platforms/powernv/Kconfig   |    2 +
>  arch/powerpc/platforms/powernv/setup.c   |   15 +-
>  arch/powerpc/platforms/powernv/smp.c     |   39 +-
>  arch/powerpc/sysdev/Kconfig              |    1 +
>  arch/powerpc/sysdev/Makefile             |    1 +
>  arch/powerpc/sysdev/xive/Kconfig         |    7 +
>  arch/powerpc/sysdev/xive/Makefile        |    4 +
>  arch/powerpc/sysdev/xive/common.c        | 1175 ++++++++++++++++++++++++++++++
>  arch/powerpc/sysdev/xive/native.c        |  604 +++++++++++++++
>  arch/powerpc/sysdev/xive/xive-internal.h |   51 ++
>  arch/powerpc/sysdev/xive/xive-regs.h     |   88 +++
>  arch/powerpc/xmon/xmon.c                 |   93 ++-
>  14 files changed, 2186 insertions(+), 12 deletions(-)

I'm not going to review this in one go, given it's 10:30pm already.

So just a few things that hit me straight away.

> diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
> new file mode 100644
> index 0000000..b1604b73
> --- /dev/null
> +++ b/arch/powerpc/include/asm/xive.h
> @@ -0,0 +1,116 @@

Copyright missing.

> +#ifndef _ASM_POWERPC_XIVE_H
> +#define _ASM_POWERPC_XIVE_H
> +
> +#define XIVE_INVALID_VP	0xffffffff
> +
> +#ifdef CONFIG_PPC_XIVE
> +
> +extern void __iomem *xive_tm_area;

I think Paul already commented on "tm" being an overly used acronym.

> +extern u32 xive_tm_offset;
> +
> +/*
> + * Per-irq data (irq_get_handler_data for normal IRQs), IPIs
> + * have it stored in the xive_cpu structure. We also cache
> + * for normal interrupts the current target CPU.
> + */
> +struct xive_irq_data {
> +	/* Setup by backend */
> +	u64 flags;
> +#define XIVE_IRQ_FLAG_STORE_EOI	0x01
> +#define XIVE_IRQ_FLAG_LSI	0x02
> +#define XIVE_IRQ_FLAG_SHIFT_BUG	0x04
> +#define XIVE_IRQ_FLAG_MASK_FW	0x08
> +#define XIVE_IRQ_FLAG_EOI_FW	0x10

I don't love that style, prefer them just prior to the struct.

> +	u64 eoi_page;
> +	void __iomem *eoi_mmio;
> +	u64 trig_page;
> +	void __iomem *trig_mmio;
> +	u32 esb_shift;
> +	int src_chip;

Why not space out the members like you do in xive_q below, I think that
looks better given you have the long __iomem lines.

> +
> +	/* Setup/used by frontend */
> +	int target;
> +	bool saved_p;
> +};
> +#define XIVE_INVALID_CHIP_ID	-1
> +
> +/* A queue tracking structure in a CPU */
> +struct xive_q {
> +	__be32 			*qpage;
> +	u32			msk;
> +	u32			idx;
> +	u32			toggle;
> +	u64			eoi_phys;
> +	void __iomem		*eoi_mmio;
> +	u32			esc_irq;
> +	atomic_t		count;
> +	atomic_t		pending_count;
> +};
> +
> +/*
> + * "magic" ESB MMIO offsets

What's an ESB?

> + */
> +#define XIVE_ESB_GET		0x800
> +#define XIVE_ESB_SET_PQ_00	0xc00
> +#define XIVE_ESB_SET_PQ_01	0xd00
> +#define XIVE_ESB_SET_PQ_10	0xe00
> +#define XIVE_ESB_SET_PQ_11	0xf00
> +#define XIVE_ESB_MASK		XIVE_ESB_SET_PQ_01
> +
> +extern bool __xive_enabled;
> +
> +static inline bool xive_enabled(void) { return __xive_enabled; }
> +
> +extern bool xive_native_init(void);
> +extern void xive_smp_probe(void);
> +extern int  xive_smp_prepare_cpu(unsigned int cpu);
> +extern void xive_smp_setup_cpu(void);
> +extern void xive_smp_disable_cpu(void);
> +extern void xive_kexec_teardown_cpu(int secondary);
> +extern void xive_shutdown(void);
> +extern void xive_flush_interrupt(void);
> +
> +/* xmon hook */
> +extern void xmon_xive_do_dump(int cpu);
> +
> +/* APIs used by KVM */
> +extern u32 xive_native_default_eq_shift(void);
> +extern u32 xive_native_alloc_vp_block(u32 max_vcpus);
> +extern void xive_native_free_vp_block(u32 vp_base);
> +extern int xive_native_populate_irq_data(u32 hw_irq,
> +					 struct xive_irq_data *data);
> +extern void xive_cleanup_irq_data(struct xive_irq_data *xd);
> +extern u32 xive_native_alloc_irq(void);
> +extern void xive_native_free_irq(u32 irq);
> +extern int xive_native_configure_irq(u32 hw_irq, u32 target, u8 prio, u32 sw_irq);
> +
> +extern int xive_native_configure_queue(u32 vp_id, struct xive_q *q, u8 prio,
> +				       __be32 *qpage, u32 order, bool can_escalate);
> +extern void xive_native_disable_queue(u32 vp_id, struct xive_q *q, u8 prio);
> +
> +extern bool __xive_irq_trigger(struct xive_irq_data *xd);
> +extern bool __xive_irq_retrigger(struct xive_irq_data *xd);
> +extern void xive_do_source_eoi(u32 hw_irq, struct xive_irq_data *xd);
> +
> +extern bool is_xive_irq(struct irq_chip *chip);
> +
> +#else
> +
> +static inline bool xive_enabled(void) { return false; }
> +
> +static inline bool xive_native_init(void) { return false; }
> +static inline void xive_smp_probe(void) { }
> +extern inline int  xive_smp_prepare_cpu(unsigned int cpu) { return -EINVAL; }
> +static inline void xive_smp_setup_cpu(void) { }
> +static inline void xive_smp_disable_cpu(void) { }
> +static inline void xive_kexec_teardown_cpu(int secondary) { }
> +static inline void xive_shutdown(void) { }
> +static inline void xive_flush_interrupt(void) { }
> +
> +static inline u32 xive_native_alloc_vp_block(u32 max_vcpus)
> +    { return XIVE_INVALID_VP; }
> +static inline void xive_native_free_vp_block(u32 vp_base) { }
> +
> +#endif
> +
> +#endif /* _ASM_POWERPC_XIVE_H */
> diff --git a/arch/powerpc/include/asm/xmon.h b/arch/powerpc/include/asm/xmon.h
> index 5eb8e59..eb42a0c 100644
> --- a/arch/powerpc/include/asm/xmon.h
> +++ b/arch/powerpc/include/asm/xmon.h
> @@ -29,5 +29,7 @@ static inline void xmon_register_spus(struct list_head *list) { };
>  extern int cpus_are_in_xmon(void);
>  #endif
>  
> +extern void xmon_printf(const char *format, ...);
> +
>  #endif /* __KERNEL __ */
>  #endif /* __ASM_POWERPC_XMON_H */
> diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
> index 3a07e4d..81ee2ed 100644
> --- a/arch/powerpc/platforms/powernv/Kconfig
> +++ b/arch/powerpc/platforms/powernv/Kconfig
> @@ -4,6 +4,8 @@ config PPC_POWERNV
>  	select PPC_NATIVE
>  	select PPC_XICS
>  	select PPC_ICP_NATIVE
> +	select PPC_XIVE
> +	select PPC_XIVE_NATIVE
>  	select PPC_P7_NAP
>  	select PCI
>  	select PCI_MSI
> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
> index d50c7d9..adceac9 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -32,6 +32,7 @@
>  #include <asm/machdep.h>
>  #include <asm/firmware.h>
>  #include <asm/xics.h>
> +#include <asm/xive.h>
>  #include <asm/opal.h>
>  #include <asm/kexec.h>
>  #include <asm/smp.h>
> @@ -76,7 +77,9 @@ static void __init pnv_init(void)
>  
>  static void __init pnv_init_IRQ(void)
>  {
> -	xics_init();
> +	/* Try using a XIVE if available, otherwise use a XICS */
> +	if (!xive_native_init())
> +		xics_init();
>  
>  	WARN_ON(!ppc_md.get_irq);
>  }
> @@ -218,10 +221,12 @@ static void pnv_kexec_wait_secondaries_down(void)
>  
>  static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)
>  {
> -	xics_kexec_teardown_cpu(secondary);
> +	if (xive_enabled())
> +		xive_kexec_teardown_cpu(secondary);
> +	else
> +		xics_kexec_teardown_cpu(secondary);
>  
>  	/* On OPAL, we return all CPUs to firmware */
> -
>  	if (!firmware_has_feature(FW_FEATURE_OPAL))
>  		return;
>  
> @@ -237,6 +242,10 @@ static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)
>  		/* Primary waits for the secondaries to have reached OPAL */
>  		pnv_kexec_wait_secondaries_down();
>  
> +		/* Switch XIVE back to emulation mode */
> +		if (xive_enabled())
> +			xive_shutdown();
> +
>  		/*
>  		 * We might be running as little-endian - now that interrupts
>  		 * are disabled, reset the HILE bit to big-endian so we don't
> diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
> index 8b67e1e..f571955 100644
> --- a/arch/powerpc/platforms/powernv/smp.c
> +++ b/arch/powerpc/platforms/powernv/smp.c
> @@ -29,6 +29,7 @@
>  #include <asm/vdso_datapage.h>
>  #include <asm/cputhreads.h>
>  #include <asm/xics.h>
> +#include <asm/xive.h>
>  #include <asm/opal.h>
>  #include <asm/runlatch.h>
>  #include <asm/code-patching.h>
> @@ -47,7 +48,9 @@
>  
>  static void pnv_smp_setup_cpu(int cpu)
>  {
> -	if (cpu != boot_cpuid)
> +	if (xive_enabled())
> +		xive_smp_setup_cpu();
> +	else if (cpu != boot_cpuid)
>  		xics_setup_cpu();
>  
>  #ifdef CONFIG_PPC_DOORBELL
> @@ -132,7 +135,10 @@ static int pnv_smp_cpu_disable(void)
>  	vdso_data->processorCount--;
>  	if (cpu == boot_cpuid)
>  		boot_cpuid = cpumask_any(cpu_online_mask);
> -	xics_migrate_irqs_away();
> +	if (xive_enabled())
> +		xive_smp_disable_cpu();
> +	else
> +		xics_migrate_irqs_away();
>  	return 0;
>  }
>  
> @@ -213,9 +219,12 @@ static void pnv_smp_cpu_kill_self(void)
>  		if (((srr1 & wmask) == SRR1_WAKEEE) ||
>  		    ((srr1 & wmask) == SRR1_WAKEHVI) ||
>  		    (local_paca->irq_happened & PACA_IRQ_EE)) {
> -			if (cpu_has_feature(CPU_FTR_ARCH_300))
> -				icp_opal_flush_interrupt();
> -			else
> +			if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> +				if (xive_enabled())
> +					xive_flush_interrupt();
> +				else
> +					icp_opal_flush_interrupt();
> +			} else
>  				icp_native_flush_interrupt();
>  		} else if ((srr1 & wmask) == SRR1_WAKEHDBELL) {
>  			unsigned long msg = PPC_DBELL_TYPE(PPC_DBELL_SERVER);
> @@ -252,10 +261,26 @@ static int pnv_cpu_bootable(unsigned int nr)
>  	return smp_generic_cpu_bootable(nr);
>  }
>  
> +static int pnv_smp_prepare_cpu(int cpu)
> +{
> +	if (xive_enabled())
> +		return xive_smp_prepare_cpu(cpu);
> +	return 0;
> +}
> +
> +static void __init pnv_smp_probe(void)
> +{
> +	if (xive_enabled())
> +		xive_smp_probe();
> +	else
> +		xics_smp_probe();
> +}
> +
>  static struct smp_ops_t pnv_smp_ops = {
>  	.message_pass	= smp_muxed_ipi_message_pass,
> -	.cause_ipi	= NULL,	/* Filled at runtime by xics_smp_probe() */
> -	.probe		= xics_smp_probe,
> +	.cause_ipi	= NULL, /* Filled at runtime by xi{cs,ve}_smp_probe() */
> +	.probe		= pnv_smp_probe,
> +	.prepare_cpu	= pnv_smp_prepare_cpu,
>  	.kick_cpu	= pnv_smp_kick_cpu,
>  	.setup_cpu	= pnv_smp_setup_cpu,
>  	.cpu_bootable	= pnv_cpu_bootable,
> diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
> index 52dc165..caf882e 100644
> --- a/arch/powerpc/sysdev/Kconfig
> +++ b/arch/powerpc/sysdev/Kconfig
> @@ -28,6 +28,7 @@ config PPC_MSI_BITMAP
>  	default y if PPC_POWERNV
>  
>  source "arch/powerpc/sysdev/xics/Kconfig"
> +source "arch/powerpc/sysdev/xive/Kconfig"
>  
>  config PPC_SCOM
>  	bool
> diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
> index a254824..c0ae11d 100644
> --- a/arch/powerpc/sysdev/Makefile
> +++ b/arch/powerpc/sysdev/Makefile
> @@ -71,5 +71,6 @@ obj-$(CONFIG_PPC_EARLY_DEBUG_MEMCONS)	+= udbg_memcons.o
>  subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
>  
>  obj-$(CONFIG_PPC_XICS)		+= xics/
> +obj-$(CONFIG_PPC_XIVE)		+= xive/
>  
>  obj-$(CONFIG_GE_FPGA)		+= ge/
> diff --git a/arch/powerpc/sysdev/xive/Kconfig b/arch/powerpc/sysdev/xive/Kconfig
> new file mode 100644
> index 0000000..c8816c8
> --- /dev/null
> +++ b/arch/powerpc/sysdev/xive/Kconfig
> @@ -0,0 +1,7 @@
> +config PPC_XIVE
> +       def_bool n
> +       select PPC_SMP_MUXED_IPI
> +       select HARDIRQS_SW_RESEND
> +
> +config PPC_XIVE_NATIVE
> +       def_bool n
> diff --git a/arch/powerpc/sysdev/xive/Makefile b/arch/powerpc/sysdev/xive/Makefile
> new file mode 100644
> index 0000000..3fab303
> --- /dev/null
> +++ b/arch/powerpc/sysdev/xive/Makefile
> @@ -0,0 +1,4 @@
> +subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
> +
> +obj-y				+= common.o
> +obj-$(CONFIG_PPC_XIVE_NATIVE)	+= native.o
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> new file mode 100644
> index 0000000..96037e0
> --- /dev/null
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -0,0 +1,1175 @@
> +/*
> + * Copyright 2016,2017 IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */

If here you put:

#define pr_fmt(fmt) "xive: " fmt

Then you can drop the prefix from every pr_xxx() in the whole file.

> +#include <linux/types.h>
> +#include <linux/threads.h>
> +#include <linux/kernel.h>
> +#include <linux/irq.h>
> +#include <linux/debugfs.h>

Unused?

> +#include <linux/smp.h>
> +#include <linux/interrupt.h>
> +#include <linux/seq_file.h>

Unused?

> +#include <linux/init.h>
> +#include <linux/cpu.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/msi.h>
> +
> +#include <asm/prom.h>
> +#include <asm/io.h>
> +#include <asm/smp.h>
> +#include <asm/machdep.h>
> +#include <asm/irq.h>
> +#include <asm/errno.h>
> +#include <asm/xive.h>
> +#include <asm/xmon.h>
> +
> +#include "xive-regs.h"
> +#include "xive-internal.h"
> +
> +#undef DEBUG_FLUSH
> +#undef DEBUG_ALL
> +
> +#define DBG(fmt...)		pr_devel("XIVE: " fmt)
> +
> +#ifdef DEBUG_ALL
> +#define DBG_VERBOSE(fmt...)	pr_devel("XIVE: " fmt)
> +#else
> +#define DBG_VERBOSE(fmt...)	do { } while(0)
> +#endif
> +
> +bool __xive_enabled;
> +bool xive_cmdline_disabled;
> +
> +/* We use only one priority for now */
> +static u8 xive_irq_priority;
> +
> +void __iomem *xive_tm_area;
> +u32 xive_tm_offset;
> +static const struct xive_ops *xive_ops;
> +static struct irq_domain *xive_irq_domain;
> +
> +/* The IPIs all use the same logical irq number */
> +static u32 xive_ipi_irq;
> +
> +/* Xive state for each CPU */
> +static DEFINE_PER_CPU(struct xive_cpu *, xive_cpu);
> +
> +/*
> + * A "disabled" interrupt should never fire, to catch problems
> + * we set its logical number to this
> + */
> +#define XIVE_BAD_IRQ		0x7fffffff

Can it be anything? How about 0x7fbadbad ?

> +#define XIVE_MAX_IRQ		(XIVE_BAD_IRQ - 1)
> +
> +/* An invalid CPU target */
> +#define XIVE_INVALID_TARGET	(-1)
> +
> +static u32 xive_read_eq(struct xive_q *q, u8 prio, bool just_peek)

Can it have a doc comment? And tell me what an EQ is?

> +{
> +	u32 cur;
> +
> +	if (!q->qpage)
> +		return 0;

A newline or ..

> +	cur = be32_to_cpup(q->qpage + q->idx);
> +	if ((cur >> 31) == q->toggle)
> +		return 0;

.. two wouldn't hurt here.

> +	if (!just_peek) {
> +		q->idx = (q->idx + 1) & q->msk;
> +		if (q->idx == 0)
> +			q->toggle ^= 1;
> +	}
> +	return cur & 0x7fffffff;

Is that XIVE_BAD_IRQ ?

> +}
> +
> +static u32 xive_scan_interrupts(struct xive_cpu *xc, bool just_peek)
> +{
> +	u32 hirq = 0;

Is that a hwirq or something different?

> +	u8 prio;
> +
> +	/* Find highest pending priority */
> +	while (xc->pending_prio != 0) {
> +		struct xive_q *q;
> +
> +		prio = ffs(xc->pending_prio) - 1;
> +		DBG_VERBOSE("scan_irq: trying prio %d\n", prio);
> +
> +		/* Try to fetch */
> +		hirq = xive_read_eq(&xc->queue[prio], prio, just_peek);
> +
> +		/* Found something ? That's it */
> +		if (hirq)
> +			break;
> +
> +		/* Clear pending bits */
> +		xc->pending_prio &= ~(1 << prio);
> +
> +		/*
> +		 * Check if the queue count needs adjusting due to
> +		 * interrupts being moved away.
> +		 */
> +		q = &xc->queue[prio];
> +		if (atomic_read(&q->pending_count)) {
> +			int p = atomic_xchg(&q->pending_count, 0);
> +			if (p) {
> +				WARN_ON(p > atomic_read(&q->count));
> +				atomic_sub(p, &q->count);

I am not sure what's going on there.

> +			}
> +		}
> +	}
> +
> +	/* If nothing was found, set CPPR to 0xff */

Would be nice to spell out CPPR somewhere.

> +	if (hirq == 0)
> +		prio = 0xff;
> +
> +	/* Update HW CPPR to match if necessary */
> +	if (prio != xc->cppr) {
> +		DBG_VERBOSE("scan_irq: adjusting CPPR to %d\n", prio);
> +		xc->cppr = prio;
> +		out_8(xive_tm_area + xive_tm_offset + TM_CPPR, prio);

What's the out_8() doing? I was expecting it to use xc, or something per-cpu.

> +	}
> +
> +	return hirq;
> +}
> +
> +#ifdef CONFIG_XMON
> +static void xive_dump_eq(const char *name, struct xive_q *q)
> +{
> +	u32 i0, i1, idx;
> +
> +	if (!q->qpage)
> +		return;
> +	idx = q->idx;
> +	i0 = be32_to_cpup(q->qpage + idx);
> +	idx = (idx + 1) & q->msk;
> +	i1 = be32_to_cpup(q->qpage + idx);
> +	xmon_printf("  %s Q T=%d %08x %08x ...\n", name,
> +		    q->toggle, i0, i1);
> +}
> +
> +void xmon_xive_do_dump(int cpu)
> +{
> +	struct xive_cpu *xc = per_cpu(xive_cpu, cpu);
> +	struct xive_irq_data *xd;
> +	uint64_t val, offset;

u64 ?

> +
> +	xmon_printf("XIVE state for CPU %d:\n", cpu);
> +	xmon_printf("  pp=%02x cppr=%02x\n", xc->pending_prio, xc->cppr);
> +	xive_dump_eq("IRQ", &xc->queue[xive_irq_priority]);
> +	xd = &xc->ipi_data;
> +	offset = 0x800;
> +	if (xd->flags & XIVE_IRQ_FLAG_SHIFT_BUG)
> +		offset |= offset << 4;
> +	val = in_be64(xd->eoi_mmio + offset);
> +	xmon_printf("  IPI state: %x:%c%c\n", xc->hw_ipi,
> +		    val & 2 ? 'P' : 'p',
> +		    val & 1 ? 'Q' : 'q');
> +}
> +#endif /* CONFIG_XMON */
> +
> +static void xive_update_pending_irqs(struct xive_cpu *xc)
> +{
> +	u8 he, cppr;
> +	u16 ack;
> +
> +	/* Perform the acknowledge hypervisor to register cycle */
> +	ack = be16_to_cpu(__raw_readw(xive_tm_area + TM_SPC_ACK_HV_REG));
> +
> +	/* Synchronize subsequent queue accesses */
> +	mb();
> +
> +	DBG_VERBOSE("CPU %d get_irq, ack=%04x\n", smp_processor_id(), ack);
> +
> +	/* Check the HE field */
> +	cppr = ack & 0xff;
> +	he = GETFIELD(TM_QW3_NSR_HE, (ack >> 8));
> +	switch(he) {
> +	case TM_QW3_NSR_HE_NONE:
> +		break;
> +	case TM_QW3_NSR_HE_PHYS:
> +		if (cppr == 0xff)
> +			return;
> +		xc->pending_prio |= 1 << cppr;
> +		if (cppr >= xc->cppr)
> +			pr_err("XIVE: CPU %d odd ack CPPR, got %d at %d\n",
> +			       smp_processor_id(), cppr, xc->cppr);
> +		xc->cppr = cppr;
> +		break;
> +	case TM_QW3_NSR_HE_POOL:
> +	case TM_QW3_NSR_HE_LSI:
> +		pr_err("XIVE: CPU %d got unexpected interrupt type HE=%d\n",
> +		       smp_processor_id(), he);
> +		return;
> +	}
> +}
> +
> +static unsigned int xive_get_irq(void)
> +{
> +	struct xive_cpu *xc = __this_cpu_read(xive_cpu);
> +	u32 hirq;
> +
> +	/*
> +	 * This can be called either as a result of a HW interrupt or
> +	 * as a "replay" because EOI decided there was still something
> +	 * in one of the queues.
> +	 *
> +	 * First we perform an ACK cycle in order to update our mask
> +	 * of pending priorities. This will also have the effect of
> +	 * updating the CPPR to the most favored pending interrupts.
> +	 *
> +	 * In the future, if we have a way to differenciate a first
> +	 * entry (on HW interrupt) from a replay triggered by EOI,
> +	 * we could skip this on replays unless we soft-mask tells us
> +	 * that a new HW interrupt occurred.
> +	 */
> +	xive_update_pending_irqs(xc);
> +
> +	DBG_VERBOSE("get_irq: pending=%02x\n", xc->pending_prio);
> +
> +	hirq = xive_scan_interrupts(xc, false);
> +
> +	DBG_VERBOSE("get_irq: got irq 0x%x, new pending=0x%02x\n",
> +	    hirq, xc->pending_prio);
> +
> +	/* Return pending interrupt if any */
> +	if (hirq == XIVE_BAD_IRQ)
> +		return 0;
> +	return hirq;
> +}
> +
> +
> +static void xive_do_queue_eoi(struct xive_cpu *xc)
> +{
> +	if (xive_scan_interrupts(xc, true) != 0) {
> +		DBG_VERBOSE("eoi: pending=0x%02x\n", xc->pending_prio);
> +		force_external_irq_replay();
> +	}
> +}
> +
> +static u8 xive_poke_esb(struct xive_irq_data *xd, u32 offset)
> +{
> +	u64 val;
> +
> +	if (xd->flags & XIVE_IRQ_FLAG_SHIFT_BUG)
> +		offset |= offset << 4;
> +
> +	val = in_be64(xd->eoi_mmio + offset);
> +
> +	return (u8)val;
> +}
> +
> +static void xive_do_source_eoi(u32 hw_irq, struct xive_irq_data *xd)
> +{
> +	/* If the XIVE supports the new "store EOI facility, use it */
> +	if (xd->flags & XIVE_IRQ_FLAG_STORE_EOI)
> +		out_be64(xd->eoi_mmio, 0);
> +	else if (hw_irq && xd->flags & XIVE_IRQ_FLAG_EOI_FW) {
> +		if (WARN_ON_ONCE(!xive_ops->eoi))
> +			return;
> +		xive_ops->eoi(hw_irq);
> +	} else {
> +		uint8_t eoi_val;

u8?

> +
> +		/*
> +		 * Otherwise for EOI, we use the special MMIO that does
> +		 * a clear of both P and Q and returns the old Q.
> +		 *
> +		 * This allows us to then do a re-trigger if Q was set
> +		 * rather than synthetizing an interrupt in software
> +		 */
> +		eoi_val = xive_poke_esb(xd, XIVE_ESB_SET_PQ_00);
> +		DBG_VERBOSE("eoi_val=%x\n", offset, eoi_val);
> +
> +		if ((xd->flags & XIVE_IRQ_FLAG_LSI) || !(eoi_val & 1))
> +			return;
> +
> +		/* Re-trigger */
> +		if (xd->trig_mmio)
> +			out_be64(xd->trig_mmio, 0);
> +	}
> +
> +}
> +
> +static void xive_irq_eoi(struct irq_data *d)
> +{
> +	struct xive_irq_data *xd = irq_data_get_irq_handler_data(d);
> +	struct xive_cpu *xc = __this_cpu_read(xive_cpu);
> +
> +	DBG_VERBOSE("eoi_irq: irq=%d [0x%lx] pending=%02x\n",
> +		    d->irq, irqd_to_hwirq(d), xc->pending_prio);
> +
> +	if (!irqd_irq_disabled(d))
> +		xive_do_source_eoi(irqd_to_hwirq(d), xd);
> +
> +	/*
> +	 * Clear saved_p to indicate that it's no longer occupying
> +	 * a queue slot on the target queue
> +	 */
> +	xd->saved_p = false;
> +
> +	xive_do_queue_eoi(xc);
> +}
> +
> +static void xive_do_source_set_mask(struct xive_irq_data *xd,
> +				    bool masked)
> +{
> +	if (masked)
> +		xive_poke_esb(xd, XIVE_ESB_SET_PQ_01);
> +	else
> +		xive_poke_esb(xd, XIVE_ESB_SET_PQ_00);
> +}
> +
> +static bool xive_try_pick_target(int cpu)
> +{
> +	struct xive_cpu *xc = per_cpu(xive_cpu, cpu);
> +	struct xive_q *q = &xc->queue[xive_irq_priority];
> +	int max;
> +
> +	/* Calculate max number of interrupts in that queue.
> +	 *
> +	 * We leave a gap of 1 just in case...
> +	 */
> +	max = (q->msk + 1) - 1;
> +	return !!atomic_add_unless(&q->count, 1, max);
> +}
> +
> +static void xive_dec_target_count(int cpu)
> +{
> +	struct xive_cpu *xc = per_cpu(xive_cpu, cpu);
> +	struct xive_q *q = &xc->queue[xive_irq_priority];
> +
> +	if (WARN_ON(cpu < 0))
> +		return;
> +
> +	/*
> +	 * We increment the "pending count" which will be used
> +	 * to decrement the target queue count whenever it's next
> +	 * processed and found empty. This ensure that we don't
> +	 * decrement while we still have the interrupt there
> +	 * occupying a slot.
> +	 */
> +	atomic_inc(&q->pending_count);
> +}
> +
> +static int xive_find_target_in_mask(const struct cpumask *mask,
> +				    unsigned int fuzz)
> +{
> +	int cpu, first, num, i;
> +
> +	/* Pick up a starting point CPU in the mask based on  fuzz */
> +	num = cpumask_weight(mask);
> +	first = (fuzz++) % num;
> +
> +	/* Locate it */
> +	cpu = cpumask_first(mask);
> +	for (i = 0; i < first; i++)
> +		cpu = cpumask_next(cpu, mask);
> +	first = cpu;
> +
> +	/*
> +	 * Now go through the entire mask until we find a valid
> +	 * target.
> +	 */
> +	for (;;) {
> +		/*
> +		 * We re-check online as the fallback case passes us
> +		 * an untested affinity mask
> +		 */
> +		if (cpu_online(cpu) && xive_try_pick_target(cpu))
> +			return cpu;
> +		cpu = cpumask_next(cpu, mask);
> +		if (cpu == first)
> +			break;
> +	}
> +	return -1;
> +}
> +
> +static int xive_pick_irq_target(struct irq_data *d,
> +				const struct cpumask *affinity)
> +{
> +	static unsigned int fuzz;
> +	struct xive_irq_data *xd = irq_data_get_irq_handler_data(d);
> +	cpumask_var_t mask;
> +	int cpu = -1;
> +
> +	/*
> +	 * Pick a target CPU for an interrupt. This is done at
> +	 * startup or if the affinity is changed in a way that
> +	 * invalidates the current target.
> +	 */
> +
> +	/* If we have chip IDs, first we try to build a mask of
> +	 * CPUs matching ther CPU and find a target in there
> +	 */
> +	if (xd->src_chip != XIVE_INVALID_CHIP_ID &&
> +		zalloc_cpumask_var(&mask, GFP_ATOMIC)) {
> +		/* Build a mask of matching chip IDs */
> +		for_each_cpu_and(cpu, affinity, cpu_online_mask) {
> +			struct xive_cpu *xc = per_cpu(xive_cpu, cpu);
> +			if (xc->chip_id == xd->src_chip)
> +				cpumask_set_cpu(cpu, mask);
> +		}
> +		/* Try to find a target */
> +		if (!cpumask_empty(mask))
> +			cpu = xive_find_target_in_mask(mask, fuzz++);
> +		free_cpumask_var(mask);
> +		if (cpu >= 0)
> +			return cpu;
> +		fuzz--;
> +	}
> +
> +	/* No chip IDs, fallback to using the affinity mask */
> +	return xive_find_target_in_mask(affinity, fuzz++);
> +}
> +
> +static unsigned int xive_irq_startup(struct irq_data *d)
> +{
> +	struct xive_irq_data *xd = irq_data_get_irq_handler_data(d);
> +	unsigned int hw_irq = (unsigned int)irqd_to_hwirq(d);
> +	int target, rc;
> +
> +	DBG("xive_irq_startup: irq %d [0x%x] data @%p\n",
> +	    d->irq, hw_irq, d);
> +
> +#ifdef CONFIG_PCI_MSI
> +	/*
> +	 * The generic MSI code returns with the interrupt disabled on the
> +	 * card, using the MSI mask bits. Firmware doesn't appear to unmask
> +	 * at that level, so we do it here by hand.
> +	 */
> +	if (irq_data_get_msi_desc(d))
> +		pci_msi_unmask_irq(d);
> +#endif
> +
> +	/* Pick a target */
> +	target = xive_pick_irq_target(d, irq_data_get_affinity_mask(d));
> +	if (target == XIVE_INVALID_TARGET) {
> +		/* Try again breaking affinity */
> +		target = xive_pick_irq_target(d, cpu_online_mask);
> +		if (target == XIVE_INVALID_TARGET)
> +			return -ENXIO;
> +		pr_warn("XIVE: irq %d started with broken affinity\n",
> +			d->irq);
> +	}
> +	xd->target = target;
> +
> +	/*
> +	 * Configure the logical number to be the Linux IRQ number
> +	 * and set the target queue
> +	 */
> +	rc = xive_ops->configure_irq(hw_irq,
> +				     get_hard_smp_processor_id(target),
> +				     xive_irq_priority, d->irq);
> +	if (rc)
> +		return rc;
> +
> +	/* Unmask the ESB */
> +	xive_do_source_set_mask(xd, false);
> +
> +	return 0;
> +}
> +
> +static void xive_irq_shutdown(struct irq_data *d)
> +{
> +	struct xive_irq_data *xd = irq_data_get_irq_handler_data(d);
> +	unsigned int hw_irq = (unsigned int)irqd_to_hwirq(d);
> +
> +	DBG("xive_irq_shutdown: irq %d [0x%x] data @%p\n",
> +	    d->irq, hw_irq, d);
> +
> +	if (WARN_ON(xd->target == XIVE_INVALID_TARGET))
> +		return;
> +
> +	/* Mask the interrupt at the source */
> +	xive_do_source_set_mask(xd, true);
> +
> +	/* Mask the interrupt in HW in the IVT/EAS */
> +	xive_ops->configure_irq(hw_irq,
> +				get_hard_smp_processor_id(xd->target),
> +				0xff, hw_irq);
> +
> +	xive_dec_target_count(xd->target);
> +	xd->target = XIVE_INVALID_TARGET;
> +}
> +
> +static void xive_irq_unmask(struct irq_data *d)
> +{
> +	struct xive_irq_data *xd = irq_data_get_irq_handler_data(d);
> +
> +	DBG("xive_irq_unmask: irq %d data @%p\n", d->irq, xd);
> +
> +	/*
> +	 * This is a workaround for PCI LSI problems on P9, for
> +	 * these, we call FW to set the mask. The problems might
> +	 * be fixed by P9 DD2.0, if that is the case, we will make
> +	 * this a DD1 workaround only
> +	 */
> +	if (xd->flags & XIVE_IRQ_FLAG_MASK_FW) {
> +		unsigned int hw_irq = (unsigned int)irqd_to_hwirq(d);
> +		xive_ops->configure_irq(hw_irq,
> +					get_hard_smp_processor_id(xd->target),
> +					xive_irq_priority, d->irq);
> +		return;
> +	}
> +
> +	xive_do_source_set_mask(xd, false);
> +}
> +
> +static void xive_irq_mask(struct irq_data *d)
> +{
> +	struct xive_irq_data *xd = irq_data_get_irq_handler_data(d);
> +
> +	DBG("xive_irq_mask: irq %d data @%p\n", d->irq, xd);
> +
> +	/*
> +	 * This is a workaround for PCI LSI problems on P9, for
> +	 * these, we call OPAL to set the mask. The problems might
> +	 * be fixed by P9 DD2.0, if that is the case, we will make
> +	 * this a DD1 workaround only
> +	 */
> +	if (xd->flags & XIVE_IRQ_FLAG_MASK_FW) {
> +		unsigned int hw_irq = (unsigned int)irqd_to_hwirq(d);
> +		xive_ops->configure_irq(hw_irq,
> +					get_hard_smp_processor_id(xd->target),
> +					0xff, d->irq);
> +		return;
> +	}
> +
> +	xive_do_source_set_mask(xd, true);
> +}
> +
> +static int xive_irq_set_affinity(struct irq_data *d,
> +				 const struct cpumask *cpumask,
> +				 bool force)
> +{
> +	struct xive_irq_data *xd = irq_data_get_irq_handler_data(d);
> +	unsigned int hw_irq = (unsigned int)irqd_to_hwirq(d);
> +	u32 target, old_target;
> +	int rc = 0;
> +
> +	DBG("xive_irq_set_affinity: irq %d\n", d->irq);
> +
> +	/* Is this valid ? */
> +	if (cpumask_any_and(cpumask, cpu_online_mask) >= nr_cpu_ids)
> +		return -EINVAL;
> +
> +	/* If existing target is already in the new mask, and is
> +	 * online then do nothing.
> +	 */
> +	if (cpu_online(xd->target) &&
> +	    cpumask_test_cpu(xd->target, cpumask))
> +		return IRQ_SET_MASK_OK;
> +
> +	/* Pick a new target */
> +	target = xive_pick_irq_target(d, cpumask);
> +
> +	/* No target found */
> +	if (target == XIVE_INVALID_TARGET)
> +		return -ENXIO;
> +
> +	old_target = xd->target;
> +
> +	/*
> +	 * Only configure the irq if it's not currently passed-through to
> +	 * a KVM guest
> +	 */
> +	rc = xive_ops->configure_irq(hw_irq,
> +				     get_hard_smp_processor_id(target),
> +				     xive_irq_priority, d->irq);
> +	if (rc < 0) {
> +		pr_err("XIVE: Error %d reconfiguring irq %d\n", rc, d->irq);
> +		return rc;
> +	}
> +
> +	DBG("  target: 0x%x\n", target);
> +	xd->target = target;
> +
> +	/* Give up previous target */
> +	if (old_target != XIVE_INVALID_TARGET)
> +	    xive_dec_target_count(old_target);
> +
> +	return IRQ_SET_MASK_OK;
> +}
> +
> +static int xive_irq_set_type(struct irq_data *d, unsigned int flow_type)
> +{
> +	struct xive_irq_data *xd = irq_data_get_irq_handler_data(d);
> +
> +	/*
> +	 * We only support these. This has really no effect other than setting
> +	 * the corresponding descriptor bits mind you but those will in turn
> +	 * affect the resend function when re-enabling an edge interrupt.
> +	 *
> +	 * Set set the default to edge as explained in map().
> +	 */
> +	if (flow_type == IRQ_TYPE_DEFAULT || flow_type == IRQ_TYPE_NONE)
> +		flow_type = IRQ_TYPE_EDGE_RISING;
> +
> +	if (flow_type != IRQ_TYPE_EDGE_RISING &&
> +	    flow_type != IRQ_TYPE_LEVEL_LOW)
> +		return -EINVAL;
> +
> +	irqd_set_trigger_type(d, flow_type);
> +
> +	/*
> +	 * Double check it matches what the FW thinks
> +	 *
> +	 * NOTE: We don't know yet if the PAPR interface will provide
> +	 * the LSI vs MSI information appart from the device-tree so
> +	 * this check might have to move into an optional backend call
> +	 * that is specific to the native backend
> +	 */
> +	if ((flow_type == IRQ_TYPE_LEVEL_LOW) !=
> +	    !!(xd->flags & XIVE_IRQ_FLAG_LSI))
> +		pr_warn("XIVE: Interrupt %d (HW 0x%x) type mismatch,"
> +			" Linux says %s, FW says %s\n",
> +			d->irq, (u32)irqd_to_hwirq(d),
> +			(flow_type == IRQ_TYPE_LEVEL_LOW) ? "Level" : "Edge",
> +			(xd->flags & XIVE_IRQ_FLAG_LSI) ? "Level" : "Edge");
> +
> +	return IRQ_SET_MASK_OK_NOCOPY;
> +}
> +
> +static int xive_irq_retrigger(struct irq_data *d)
> +{
> +	struct xive_irq_data *xd = irq_data_get_irq_handler_data(d);
> +
> +	/* This should be only for MSIs */
> +	if (WARN_ON(xd->flags & XIVE_IRQ_FLAG_LSI))
> +		return 0;
> +
> +	/*
> +	 * To perform a retrigger, we first set the PQ bits to
> +	 * 11, then perform an EOI.
> +	 */
> +	xive_poke_esb(xd, XIVE_ESB_SET_PQ_11);
> +
> +	/*
> +	 * Note: We pass "0" to the hw_irq argument in order to
> +	 * avoid calling into the backend EOI code which we don't
> +	 * want to do in the case of a re-trigger. Backends typically
> +	 * only do EOI for LSIs anyway.
> +	 */
> +	xive_do_source_eoi(0, xd);
> +
> +	return 1;
> +}
> +
> +static struct irq_chip xive_irq_chip = {
> +	.name = "XIVE-IRQ",
> +	.irq_startup = xive_irq_startup,
> +	.irq_shutdown = xive_irq_shutdown,
> +	.irq_eoi = xive_irq_eoi,
> +	.irq_mask = xive_irq_mask,
> +	.irq_unmask = xive_irq_unmask,
> +	.irq_set_affinity = xive_irq_set_affinity,
> +	.irq_set_type = xive_irq_set_type,
> +	.irq_retrigger = xive_irq_retrigger,
> +};
> +
> +bool is_xive_irq(struct irq_chip *chip)
> +{
> +	return chip == &xive_irq_chip;
> +}
> +
> +void xive_cleanup_irq_data(struct xive_irq_data *xd)
> +{
> +	if (xd->eoi_mmio) {
> +		iounmap(xd->eoi_mmio);
> +		if (xd->eoi_mmio == xd->trig_mmio)
> +			xd->trig_mmio = NULL;
> +		xd->eoi_mmio = NULL;
> +	}
> +	if (xd->trig_mmio) {
> +		iounmap(xd->trig_mmio);
> +		xd->trig_mmio = NULL;
> +	}
> +}
> +
> +static int xive_irq_alloc_data(unsigned int virq, irq_hw_number_t hw)
> +{
> +	struct xive_irq_data *xd;
> +	int rc;
> +
> +	xd = kzalloc(sizeof(struct xive_irq_data), GFP_KERNEL);
> +	if (!xd)
> +		return -ENOMEM;
> +	rc = xive_ops->populate_irq_data(hw, xd);
> +	if (rc) {
> +		kfree(xd);
> +		return rc;
> +	}
> +	xd->target = XIVE_INVALID_TARGET;
> +	irq_set_handler_data(virq, xd);
> +
> +	return 0;
> +}
> +
> +static void xive_irq_free_data(unsigned int virq)
> +{
> +	struct xive_irq_data *xd = irq_get_handler_data(virq);
> +
> +	if (!xd)
> +		return;
> +	irq_set_handler_data(virq, NULL);
> +	xive_cleanup_irq_data(xd);
> +	kfree(xd);
> +}
> +
> +#ifdef CONFIG_SMP
> +
> +static void xive_cause_ipi(int cpu, unsigned long msg)
> +{
> +	struct xive_cpu *xc;
> +	struct xive_irq_data *xd;
> +
> +	xc = per_cpu(xive_cpu, cpu);
> +
> +	DBG_VERBOSE("IPI msg#%ld CPU %d -> %d (HW IRQ 0x%x)\n",
> +		    msg, smp_processor_id(), cpu, xc->hw_ipi);
> +
> +	xd = &xc->ipi_data;
> +	if (WARN_ON(!xd->trig_mmio))
> +		return;
> +	out_be64(xd->trig_mmio, 0);
> +}
> +
> +static irqreturn_t xive_muxed_ipi_action(int irq, void *dev_id)
> +{
> +	return smp_ipi_demux();
> +}
> +
> +static void xive_ipi_eoi(struct irq_data *d)
> +{
> +	struct xive_cpu *xc = __this_cpu_read(xive_cpu);
> +
> +	/* Handle possible race with unplug and drop stale IPIs */
> +	if (!xc)
> +		return;
> +	xive_do_source_eoi(xc->hw_ipi, &xc->ipi_data);
> +	xive_do_queue_eoi(xc);
> +}
> +
> +static void xive_ipi_unmask(struct irq_data *d)
> +{
> +	/* Nothing to do, we never mask IPIs, but the callback
> +	 * must exist
> +	 */
> +}
> +
> +static void xive_ipi_mask(struct irq_data *d)
> +{
> +	/* Nothing to do, we never mask IPIs, but the callback
> +	 * must exist
> +	 */
> +}
> +
> +static struct irq_chip xive_ipi_chip = {
> +	.name = "XIVE-IPI",
> +	.irq_eoi = xive_ipi_eoi,
> +	.irq_mask = xive_ipi_mask,
> +	.irq_unmask = xive_ipi_unmask,
> +};
> +
> +static void __init xive_request_ipi(void)
> +{
> +	unsigned int virq;
> +
> +	/* Initialize it */
> +	virq = irq_create_mapping(xive_irq_domain, 0);
> +	xive_ipi_irq = virq;
> +
> +	BUG_ON(request_irq(virq, xive_muxed_ipi_action,
> +			   IRQF_PERCPU | IRQF_NO_THREAD, "IPI", NULL));
> +}
> +
> +static int xive_setup_cpu_ipi(unsigned int cpu)
> +{
> +	struct xive_cpu *xc;
> +	int rc;
> +
> +	pr_debug("XIVE: Setting up IPI for CPU %d\n", cpu);
> +
> +	xc = per_cpu(xive_cpu, cpu);
> +
> +	/* Check if we are already setup */
> +	if (xc->hw_ipi != 0)
> +		return 0;
> +
> +	/* Grab an IPI from the backend, this will populate xc->hw_ipi */
> +	if (xive_ops->get_ipi(cpu, xc))
> +		return -EIO;
> +
> +	/* Populate the IRQ data in the xive_cpu structure and
> +	 * configure the HW / enable the IPIs
> +	 */
> +	rc = xive_ops->populate_irq_data(xc->hw_ipi, &xc->ipi_data);
> +	if (rc) {
> +		pr_err("XIVE: Failed to populate IPI data on CPU %d\n", cpu);
> +		return -EIO;
> +	}
> +	rc = xive_ops->configure_irq(xc->hw_ipi,
> +				     get_hard_smp_processor_id(cpu),
> +				     xive_irq_priority, xive_ipi_irq);
> +	if (rc) {
> +		pr_err("XIVE: Failed to map IPI CPU %d\n", cpu);
> +		return -EIO;
> +	}
> +	DBG("XIVE: CPU %d HW IPI %x, virq %d, trig_mmio=%p\n", cpu,
> +	    xc->hw_ipi, xive_ipi_irq, xc->ipi_data.trig_mmio);
> +
> +	/* Unmask it */
> +	xive_do_source_set_mask(&xc->ipi_data, false);
> +
> +	return 0;
> +}
> +
> +static void xive_cleanup_cpu_ipi(unsigned int cpu, struct xive_cpu *xc)
> +{
> +	/* Disable the IPI and free the IRQ data */
> +
> +	/* Already cleaned up ? */
> +	if (xc->hw_ipi == 0)
> +		return;
> +
> +	/* Mask the IPI */
> +	xive_do_source_set_mask(&xc->ipi_data, true);
> +
> +	/*
> +	 * Note: We don't call xive_cleanup_irq_data() to free
> +	 * the mappings as this is called from an IPI on kexec
> +	 * which is not a safe environment to call iounmap()
> +	 */
> +
> +	/* Deconfigure/mask in the backend */
> +	xive_ops->configure_irq(xc->hw_ipi, hard_smp_processor_id(),
> +				0xff, xive_ipi_irq);
> +
> +	/* Free the IPIs in the backend */
> +	xive_ops->put_ipi(cpu, xc);
> +}
> +
> +void __init xive_smp_probe(void)
> +{
> +	smp_ops->cause_ipi = xive_cause_ipi;
> +
> +	/* Register the IPI */
> +	xive_request_ipi();
> +
> +	/* Allocate and setup IPI for the boot CPU */
> +	xive_setup_cpu_ipi(smp_processor_id());
> +}
> +
> +#endif /* CONFIG_SMP */
> +
> +static int xive_irq_domain_map(struct irq_domain *h, unsigned int virq,
> +			       irq_hw_number_t hw)
> +{
> +	int rc;
> +
> +	/*
> +	 * Mark interrupts as edge sensitive by default so that resend
> +	 * actually works. Will fix that up below if needed.
> +	 */
> +	irq_clear_status_flags(virq, IRQ_LEVEL);
> +
> +	/* IPIs are special and come up with HW number 0 */
> +	if (hw == 0) {
> +		/*
> +		 * IPIs are marked per-cpu. We use separate HW interrupts under
> +		 * the hood but associated with the same "linux" interrupt
> +		 */
> +		irq_set_chip_and_handler(virq, &xive_ipi_chip,
> +					 handle_percpu_irq);
> +		return 0;
> +	}
> +
> +	rc = xive_irq_alloc_data(virq, hw);
> +	if (rc)
> +		return rc;
> +
> +	irq_set_chip_and_handler(virq, &xive_irq_chip, handle_fasteoi_irq);
> +
> +	return 0;
> +}
> +
> +static void xive_irq_domain_unmap(struct irq_domain *d, unsigned int virq)
> +{
> +	struct irq_data *data = irq_get_irq_data(virq);
> +	unsigned int hw_irq;
> +
> +	if (!data)
> +		return;
> +	hw_irq = (unsigned int)irqd_to_hwirq(data);
> +	if (hw_irq)
> +		xive_irq_free_data(virq);
> +}
> +
> +static int xive_irq_domain_xlate(struct irq_domain *h, struct device_node *ct,
> +				 const u32 *intspec, unsigned int intsize,
> +				 irq_hw_number_t *out_hwirq, unsigned int *out_flags)
> +
> +{
> +	*out_hwirq = intspec[0];
> +
> +	/*
> +	 * If intsize is at least 2, we look for the type in the second cell,
> +	 * we assume the LSB indicates a level interrupt.
> +	 */
> +	if (intsize > 1) {
> +		if (intspec[1] & 1)
> +			*out_flags = IRQ_TYPE_LEVEL_LOW;
> +		else
> +			*out_flags = IRQ_TYPE_EDGE_RISING;
> +	} else
> +		*out_flags = IRQ_TYPE_LEVEL_LOW;
> +
> +	return 0;
> +}
> +
> +static int xive_irq_domain_match(struct irq_domain *h, struct device_node *node,
> +				 enum irq_domain_bus_token bus_token)
> +{
> +	return xive_ops->match(node);
> +}
> +
> +static const struct irq_domain_ops xive_irq_domain_ops = {
> +	.match = xive_irq_domain_match,
> +	.map = xive_irq_domain_map,
> +	.unmap = xive_irq_domain_unmap,
> +	.xlate = xive_irq_domain_xlate,
> +};
> +
> +static void __init xive_init_host(void)
> +{
> +	xive_irq_domain = irq_domain_add_nomap(NULL, XIVE_MAX_IRQ,
> +					       &xive_irq_domain_ops, NULL);
> +	BUG_ON(xive_irq_domain == NULL);
> +	irq_set_default_host(xive_irq_domain);
> +}
> +
> +static void xive_cleanup_cpu_queues(unsigned int cpu, struct xive_cpu *xc)
> +{
> +	if (xc->queue[xive_irq_priority].qpage)
> +		xive_ops->cleanup_queue(cpu, xc, xive_irq_priority);
> +}
> +
> +static int xive_setup_cpu_queues(unsigned int cpu, struct xive_cpu *xc)
> +{
> +	int rc = 0;
> +
> +	/* We setup 1 queues for now with a 64k page */
> +	if (!xc->queue[xive_irq_priority].qpage)
> +		rc = xive_ops->setup_queue(cpu, xc, xive_irq_priority);
> +
> +	return rc;
> +}
> +
> +static int xive_prepare_cpu(unsigned int cpu)
> +{
> +	struct xive_cpu *xc;
> +
> +	xc = per_cpu(xive_cpu, cpu);
> +	if (!xc) {
> +		struct device_node *np;
> +
> +		xc = kzalloc_node(sizeof(struct xive_cpu),
> +				  GFP_KERNEL, cpu_to_node(cpu));
> +		if (!xc)
> +			return -ENOMEM;
> +		np = of_get_cpu_node(cpu, NULL);
> +		if (np)
> +			xc->chip_id = of_get_ibm_chip_id(np);
> +		of_node_put(np);
> +
> +		per_cpu(xive_cpu, cpu) = xc;
> +	}
> +
> +	/* Setup EQs if not already */
> +	return xive_setup_cpu_queues(cpu, xc);
> +}
> +
> +static void xive_setup_cpu(void)
> +{
> +	struct xive_cpu *xc = __this_cpu_read(xive_cpu);
> +
> +	/* Debug: Dump the TM state */
> +	DBG("CPU %d [HW 0x%02x] VT=%02x\n",
> +	    smp_processor_id(), hard_smp_processor_id(),
> +	    in_8(xive_tm_area + xive_tm_offset + TM_WORD2));
> +
> +	/* The backend might have additional things to do */
> +	if (xive_ops->setup_cpu)
> +		xive_ops->setup_cpu(smp_processor_id(), xc);
> +
> +	/* Set CPPR to 0xff to enable flow of interrupts */
> +	xc->cppr = 0xff;
> +	out_8(xive_tm_area + xive_tm_offset + TM_CPPR, 0xff);
> +}
> +
> +#ifdef CONFIG_SMP
> +void xive_smp_setup_cpu(void)
> +{
> +	DBG("XIVE: SMP setup CPU %d\n", smp_processor_id());
> +
> +	/* This will have already been done on the boot CPU */
> +	if (smp_processor_id() != boot_cpuid)
> +		xive_setup_cpu();
> +
> +}
> +
> +int xive_smp_prepare_cpu(unsigned int cpu)
> +{
> +	int rc;
> +
> +	/* Allocate per-CPU data and queues */
> +	rc = xive_prepare_cpu(cpu);
> +	if (rc)
> +		return rc;
> +
> +	/* Allocate and setup IPI for the new CPU */
> +	return xive_setup_cpu_ipi(cpu);
> +}
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +static void xive_flush_cpu_queue(unsigned int cpu, struct xive_cpu *xc)
> +{
> +	u32 irq;
> +
> +	/* We assume local irqs are disabled */
> +	WARN_ON(!irqs_disabled());
> +
> +	/* Check what's already in the CPU queue */
> +	while ((irq = xive_scan_interrupts(xc, false)) != 0) {
> +		/*
> +		 * We need to re-route that interrupt to its new distination.
> +		 * First get and lock the descriptor
> +		 */
> +		struct irq_desc *desc = irq_to_desc(irq);
> +		struct irq_data *d = irq_desc_get_irq_data(desc);
> +		struct xive_irq_data *xd;
> +		unsigned int hw_irq = (unsigned int)irqd_to_hwirq(d);
> +
> +		/*
> +		 * Ignore anything that isn't a XIVE irq and ignore
> +		 * IPIs, so can just be dropped.
> +		 */
> +		if (d->domain != xive_irq_domain || hw_irq == 0)
> +			continue;
> +#ifdef DEBUG_FLUSH
> +		pr_info("CPU %d: Got irq %d while offline, re-routing...\n",
> +			cpu, irq);
> +#endif
> +		raw_spin_lock(&desc->lock);
> +		xd = irq_desc_get_handler_data(desc);
> +
> +		/* For LSIs, we EOI, this will cause a resend if it's
> +		 * still asserted. Otherwise do an MSI retrigger
> +		 */
> +		if (xd->flags & XIVE_IRQ_FLAG_LSI)
> +			xive_do_source_eoi(irqd_to_hwirq(d), xd);
> +		else
> +			xive_irq_retrigger(d);
> +		raw_spin_unlock(&desc->lock);
> +	}
> +}
> +
> +void xive_smp_disable_cpu(void)
> +{
> +	struct xive_cpu *xc = __this_cpu_read(xive_cpu);
> +	unsigned int cpu = smp_processor_id();
> +
> +	/* Migrate interrupts away from the CPU */
> +	irq_migrate_all_off_this_cpu();
> +
> +	/* Set CPPR to 0 to disable flow of interrupts */
> +	xc->cppr = 0;
> +	out_8(xive_tm_area + xive_tm_offset + TM_CPPR, 0);
> +
> +	/* Flush everything still in the queue */
> +	xive_flush_cpu_queue(cpu, xc);
> +
> +	/* Re-enable CPPR  */
> +	xc->cppr = 0xff;
> +	out_8(xive_tm_area + xive_tm_offset + TM_CPPR, 0xff);
> +}
> +
> +void xive_flush_interrupt(void)
> +{
> +	struct xive_cpu *xc = __this_cpu_read(xive_cpu);
> +	unsigned int cpu = smp_processor_id();
> +
> +	/* Called if an interrupt occurs while the CPU is hot unplugged */
> +	xive_flush_cpu_queue(cpu, xc);
> +}
> +
> +#endif /* CONFIG_HOTPLUG_CPU */
> +
> +#endif /* CONFIG_SMP */
> +
> +void xive_kexec_teardown_cpu(int secondary)
> +{
> +	struct xive_cpu *xc = __this_cpu_read(xive_cpu);
> +	unsigned int cpu = smp_processor_id();
> +
> +	/* Set CPPR to 0 to disable flow of interrupts */
> +	xc->cppr = 0;
> +	out_8(xive_tm_area + xive_tm_offset + TM_CPPR, 0);
> +
> +	/* Backend cleanup if any */
> +	if (xive_ops->teardown_cpu)
> +		xive_ops->teardown_cpu(cpu, xc);
> +
> +	/* Get rid of IPI */
> +	xive_cleanup_cpu_ipi(cpu, xc);
> +
> +	/* Disable and free the queues */
> +	xive_cleanup_cpu_queues(cpu, xc);
> +}
> +
> +void xive_shutdown(void)
> +{
> +	xive_ops->shutdown();
> +}
> +
> +bool xive_core_init(const struct xive_ops *ops, void __iomem *area, u32 offset,
> +		    u8 max_prio)
> +{
> +	xive_tm_area = area;
> +	xive_tm_offset = offset;
> +	xive_ops = ops;
> +	xive_irq_priority = max_prio;
> +
> +	ppc_md.get_irq = xive_get_irq;
> +	__xive_enabled = true;
> +
> +	DBG("Initializing host..\n");
> +	xive_init_host();
> +
> +	DBG("Initializing boot CPU..\n");
> +
> +	/* Allocate per-CPU data and queues */
> +	xive_prepare_cpu(smp_processor_id());
> +
> +	/* Get ready for interrupts */
> +	xive_setup_cpu();
> +
> +	pr_info("XIVE: Interrupt handling intialized with %s backend\n",
> +		xive_ops->name);
> +	pr_info("XIVE: Using priority %d for all interrupts\n", max_prio);
> +
> +	return true;
> +}
> +
> +static int __init xive_off(char *arg)
> +{
> +	xive_cmdline_disabled = true;
> +	return 0;
> +}
> +__setup("xive=off", xive_off);
> diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
> new file mode 100644
> index 0000000..26cc6bf
> --- /dev/null
> +++ b/arch/powerpc/sysdev/xive/native.c
> @@ -0,0 +1,604 @@
> +/*
> + * Copyright 2016,2017 IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +#include <linux/types.h>
> +#include <linux/irq.h>
> +#include <linux/debugfs.h>

Unused?

> +#include <linux/smp.h>
> +#include <linux/interrupt.h>
> +#include <linux/seq_file.h>

Unused?

> +#include <linux/init.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/delay.h>
> +#include <linux/cpumask.h>
> +#include <linux/mm.h>
> +
> +#include <asm/prom.h>
> +#include <asm/io.h>
> +#include <asm/smp.h>
> +#include <asm/irq.h>
> +#include <asm/errno.h>
> +#include <asm/xive.h>
> +#include <asm/opal.h>
> +
> +#include "xive-regs.h"
> +#include "xive-internal.h"
> +
> +#define DBG(fmt...)	pr_devel("XIVE: " fmt)
> +
> +/* Enable this for using queue MMIO page for EOI. We don't currently
> + * use it as we always notify
> + */
> +#undef USE_QUEUE_MMIO

Dead code? Or we want to keep it?


> +static u32 xive_provision_size;
> +static u32 *xive_provision_chips;
> +static u32 xive_provision_chip_count;
> +static u32 xive_queue_shift;
> +static u32 xive_pool_vps = XIVE_INVALID_VP;
> +static struct kmem_cache *xive_provision_cache;
> +
> +int xive_native_populate_irq_data(u32 hw_irq, struct xive_irq_data *data)
> +{
> +	__be64 flags, eoi_page, trig_page;
> +	__be32 esb_shift, src_chip;
> +	u64 opal_flags;
> +	s64 rc;
> +
> +	memset(data, 0, sizeof(*data));
> +
> +	rc = opal_xive_get_irq_info(hw_irq, &flags, &eoi_page, &trig_page,
> +				    &esb_shift, &src_chip);
> +	if (rc) {
> +		pr_err("XIVE: opal_xive_get_irq_info(0x%x) returned %lld\n",
> +		       hw_irq, rc);
> +		return -EINVAL;
> +	}
> +
> +	opal_flags = be64_to_cpu(flags);
> +	if (opal_flags & OPAL_XIVE_IRQ_STORE_EOI)
> +		data->flags |= XIVE_IRQ_FLAG_STORE_EOI;
> +	if (opal_flags & OPAL_XIVE_IRQ_LSI)
> +		data->flags |= XIVE_IRQ_FLAG_LSI;
> +	if (opal_flags & OPAL_XIVE_IRQ_SHIFT_BUG)
> +		data->flags |= XIVE_IRQ_FLAG_SHIFT_BUG;
> +	if (opal_flags & OPAL_XIVE_IRQ_MASK_VIA_FW)
> +		data->flags |= XIVE_IRQ_FLAG_MASK_FW;
> +	if (opal_flags & OPAL_XIVE_IRQ_EOI_VIA_FW)
> +		data->flags |= XIVE_IRQ_FLAG_EOI_FW;
> +	data->eoi_page = be64_to_cpu(eoi_page);
> +	data->trig_page = be64_to_cpu(trig_page);
> +	data->esb_shift = be32_to_cpu(esb_shift);
> +	data->src_chip = be32_to_cpu(src_chip);
> +
> +	data->eoi_mmio = ioremap(data->eoi_page, 1u << data->esb_shift);
> +	if (!data->eoi_mmio) {
> +		pr_err("XIVE: Failed to map EOI page for irq 0x%x\n", hw_irq);
> +		return -ENOMEM;
> +	}
> +
> +	if (!data->trig_page)
> +		return 0;
> +	if (data->trig_page == data->eoi_page) {
> +		data->trig_mmio = data->eoi_mmio;
> +		return 0;
> +	}
> +
> +	data->trig_mmio = ioremap(data->trig_page, 1u << data->esb_shift);
> +	if (!data->trig_mmio) {
> +		pr_err("XIVE: Failed to map trigger page for irq 0x%x\n", hw_irq);
> +		return -ENOMEM;
> +	}
> +	return 0;
> +}
> +
> +int xive_native_configure_irq(u32 hw_irq, u32 target, u8 prio, u32 sw_irq)
> +{
> +	s64 rc;
> +
> +	for (;;) {
> +		rc = opal_xive_set_irq_config(hw_irq, target, prio, sw_irq);
> +		if (rc != OPAL_BUSY)
> +			break;
> +		msleep(1);
> +	}
> +	return rc == 0 ? 0 : -ENXIO;
> +}
> +
> +/* This can be called multiple time to change a queue configuration */
> +int xive_native_configure_queue(u32 vp_id, struct xive_q *q, u8 prio,
> +				__be32 *qpage, u32 order, bool can_escalate)
> +{
> +	s64 rc = 0;
> +	__be64 qeoi_page_be;
> +	__be32 esc_irq_be;
> +	u64 flags, qpage_phys;
> +
> +	/* If there's an actual queue page, clean it */
> +	if (order) {
> +		BUG_ON(!qpage);

Can't we just return an error?

> +		qpage_phys = __pa(qpage);
> +	} else
> +		qpage_phys = 0;
> +
> +	/* Initialize the rest of the fields */
> +	q->msk = order ? ((1u << (order - 2)) - 1) : 0;
> +	q->idx = 0;
> +	q->toggle = 0;
> +
> +	rc = opal_xive_get_queue_info(vp_id, prio, NULL, NULL,
> +				      &qeoi_page_be,
> +				      &esc_irq_be,
> +				      NULL);
> +	if (rc) {
> +		pr_err("XIVE: Error %lld getting queue info prio %d\n",
> +		       rc, prio);
> +		rc = -EIO;
> +		goto fail;
> +	}
> +	q->eoi_phys = be64_to_cpu(qeoi_page_be);
> +
> +#ifdef USE_QUEUE_MMIO
> +	if (!q->eoi_mmio)
> +		q->eoi_mmio = ioremap(q->eoi_phys, PAGE_SIZE);
> +	if (!q->eoi_mmio) {
> +		pr_err("XIVE: Failed to map queue MMIO prio %d CPU %d\n",
> +		       rc, prio, cpu);
> +		rc = -ENOMEM;
> +		goto fail;
> +	}
> +#endif /* USE_QUEUE_MMIO */
> +
> +
...
> +static bool xive_parse_provisioning(struct device_node *np)
> +{
> +	int rc;
> +
> +	if (of_property_read_u32(np, "ibm,xive-provision-page-size",
> +				 &xive_provision_size) < 0)
> +		return true;
> +	rc = of_property_count_elems_of_size(np, "ibm,xive-provision-chips", 4);
> +	if (rc < 0) {
> +		pr_err("XIVE: Error %d getting provision chips array\n", rc);
> +		return false;
> +	}
> +	xive_provision_chip_count = rc;
> +	if (rc == 0)
> +		return true;
> +
> +	xive_provision_chips = kzalloc(4 * xive_provision_chip_count,
> +				       GFP_KERNEL);
> +	BUG_ON(!xive_provision_chips);

return false?

> +
> +	rc = of_property_read_u32_array(np, "ibm,xive-provision-chips",
> +					xive_provision_chips,
> +					xive_provision_chip_count);
...
> diff --git a/arch/powerpc/sysdev/xive/xive-internal.h b/arch/powerpc/sysdev/xive/xive-internal.h
> new file mode 100644
> index 0000000..e736fc5
> --- /dev/null
> +++ b/arch/powerpc/sysdev/xive/xive-internal.h
> @@ -0,0 +1,51 @@

Copyright missing.

> +#ifndef __XIVE_INTERNAL_H
> +#define __XIVE_INTERNAL_H
...
> diff --git a/arch/powerpc/sysdev/xive/xive-regs.h b/arch/powerpc/sysdev/xive/xive-regs.h
> new file mode 100644
> index 0000000..f1edb23
> --- /dev/null
> +++ b/arch/powerpc/sysdev/xive/xive-regs.h
> @@ -0,0 +1,88 @@

Copyright missing.

> +#ifndef __XIVE_REGS_H__
> +#define __XIVE_REGS_H__
...
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 16321ad..c71e919 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
...
> +
> +static void dump_one_xive_irq(uint32_t num)

u32?

> +{
> +	int64_t rc;
> +	__be64 vp;
> +	uint8_t prio;

u8?


zzzzz ...

cheers
