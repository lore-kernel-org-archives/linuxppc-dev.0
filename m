Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRyLF279GzDqtV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 14:03:33 +1000 (AEST)
Date: Wed, 9 Aug 2017 13:53:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 02/10] powerpc/xive: guest exploitation of the XIVE
 interrupt controller
Message-ID: <20170809035306.GC13670@umbus.fritz.box>
References: <1502182579-990-1-git-send-email-clg@kaod.org>
 <1502182579-990-3-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
In-Reply-To: <1502182579-990-3-git-send-email-clg@kaod.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 10:56:12AM +0200, C=E9dric Le Goater wrote:
> This is the framework for using XIVE in a PowerVM guest. The support
> is very similar to the native one in a much simpler form.
>=20
> Instead of OPAL calls, a set of Hypervisors call are used to configure
> the interrupt sources and the event/notification queues of the guest:
>=20
>  - H_INT_GET_SOURCE_INFO
>=20
>    used to obtain the address of the MMIO page of the Event State
>    Buffer (PQ bits) entry associated with the source.
>=20
>  - H_INT_SET_SOURCE_CONFIG
>=20
>    assigns a source to a "target".
>=20
>  - H_INT_GET_SOURCE_CONFIG
>=20
>    determines to which "target" and "priority" is assigned to a source
>=20
>  - H_INT_GET_QUEUE_INFO
>=20
>    returns the address of the notification management page associated
>    with the specified "target" and "priority".
>=20
>  - H_INT_SET_QUEUE_CONFIG
>=20
>    sets or resets the event queue for a given "target" and "priority".
>    It is also used to set the notification config associated with the
>    queue, only unconditional notification for the moment.  Reset is
>    performed with a queue size of 0 and queueing is disabled in that
>    case.
>=20
>  - H_INT_GET_QUEUE_CONFIG
>=20
>    returns the queue settings for a given "target" and "priority".
>=20
>  - H_INT_RESET
>=20
>    resets all of the partition's interrupt exploitation structures to
>    their initial state, losing all configuration set via the hcalls
>    H_INT_SET_SOURCE_CONFIG and H_INT_SET_QUEUE_CONFIG.
>=20
>  - H_INT_SYNC
>=20
>    issue a synchronisation on a source to make sure sure all
>    notifications have reached their queue.
>=20
> As for XICS, the XIVE interface for the guest is described in the
> device tree under the interrupt controller node. A couple of new
> properties are specific to XIVE :
>=20
>  - "reg"
>=20
>    contains the base address and size of the thread interrupt
>    managnement areas (TIMA) for the user level for the OS level. Only
>    the OS level is taken into account.
>=20
>  - "ibm,xive-eq-sizes"
>=20
>    the size of the event queues.
>=20
>  - "ibm,xive-lisn-ranges"
>=20
>    the interrupt numbers ranges assigned to the guest. These are
>    allocated using a simple bitmap.
>=20
> Tested with a QEMU XIVE model for pseries and with the Power
> hypervisor
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

I don't know XIVE well enough to review in detail, but I've made some
comments based on general knowledge.

> ---
>  arch/powerpc/include/asm/hvcall.h            |  13 +-
>  arch/powerpc/include/asm/xive.h              |   2 +
>  arch/powerpc/platforms/pseries/Kconfig       |   1 +
>  arch/powerpc/platforms/pseries/hotplug-cpu.c |  10 +-
>  arch/powerpc/platforms/pseries/kexec.c       |   6 +-
>  arch/powerpc/platforms/pseries/setup.c       |   8 +-
>  arch/powerpc/platforms/pseries/smp.c         |  32 +-
>  arch/powerpc/sysdev/xive/Kconfig             |   5 +
>  arch/powerpc/sysdev/xive/Makefile            |   1 +
>  arch/powerpc/sysdev/xive/spapr.c             | 554 +++++++++++++++++++++=
++++++
>  10 files changed, 619 insertions(+), 13 deletions(-)
>  create mode 100644 arch/powerpc/sysdev/xive/spapr.c
>=20
> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm=
/hvcall.h
> index 57d38b504ff7..3d34dc0869f6 100644
> --- a/arch/powerpc/include/asm/hvcall.h
> +++ b/arch/powerpc/include/asm/hvcall.h
> @@ -280,7 +280,18 @@
>  #define H_RESIZE_HPT_COMMIT	0x370
>  #define H_REGISTER_PROC_TBL	0x37C
>  #define H_SIGNAL_SYS_RESET	0x380
> -#define MAX_HCALL_OPCODE	H_SIGNAL_SYS_RESET
> +#define H_INT_GET_SOURCE_INFO   0x3A8
> +#define H_INT_SET_SOURCE_CONFIG 0x3AC
> +#define H_INT_GET_SOURCE_CONFIG 0x3B0
> +#define H_INT_GET_QUEUE_INFO    0x3B4
> +#define H_INT_SET_QUEUE_CONFIG  0x3B8
> +#define H_INT_GET_QUEUE_CONFIG  0x3BC
> +#define H_INT_SET_OS_REPORTING_LINE 0x3C0
> +#define H_INT_GET_OS_REPORTING_LINE 0x3C4
> +#define H_INT_ESB               0x3C8
> +#define H_INT_SYNC              0x3CC
> +#define H_INT_RESET             0x3D0
> +#define MAX_HCALL_OPCODE	H_INT_RESET
> =20
>  /* H_VIOCTL functions */
>  #define H_GET_VIOA_DUMP_SIZE	0x01
> diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/x=
ive.h
> index c23ff4389ca2..1deb10032d61 100644
> --- a/arch/powerpc/include/asm/xive.h
> +++ b/arch/powerpc/include/asm/xive.h
> @@ -110,6 +110,7 @@ extern bool __xive_enabled;
> =20
>  static inline bool xive_enabled(void) { return __xive_enabled; }
> =20
> +extern bool xive_spapr_init(void);
>  extern bool xive_native_init(void);
>  extern void xive_smp_probe(void);
>  extern int  xive_smp_prepare_cpu(unsigned int cpu);
> @@ -147,6 +148,7 @@ extern int xive_native_get_vp_info(u32 vp_id, u32 *ou=
t_cam_id, u32 *out_chip_id)
> =20
>  static inline bool xive_enabled(void) { return false; }
> =20
> +static inline bool xive_spapr_init(void) { return false; }
>  static inline bool xive_native_init(void) { return false; }
>  static inline void xive_smp_probe(void) { }
>  extern inline int  xive_smp_prepare_cpu(unsigned int cpu) { return -EINV=
AL; }
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platfo=
rms/pseries/Kconfig
> index 3a6dfd14f64b..71dd69d9ec64 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -7,6 +7,7 @@ config PPC_PSERIES
>  	select PCI
>  	select PCI_MSI
>  	select PPC_XICS
> +	select PPC_XIVE_SPAPR
>  	select PPC_ICP_NATIVE
>  	select PPC_ICP_HV
>  	select PPC_ICS_RTAS
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/=
platforms/pseries/hotplug-cpu.c
> index 6afd1efd3633..de0a5c1d7b29 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -34,6 +34,7 @@
>  #include <asm/machdep.h>
>  #include <asm/vdso_datapage.h>
>  #include <asm/xics.h>
> +#include <asm/xive.h>
>  #include <asm/plpar_wrappers.h>
> =20
>  #include "pseries.h"
> @@ -109,7 +110,9 @@ static void pseries_mach_cpu_die(void)
> =20
>  	local_irq_disable();
>  	idle_task_exit();
> -	xics_teardown_cpu();
> +	/* Nothing TODO for xive ? */;

You have a XIVE teardown_cpu() method below - should you be calling
that here, even though it's a no-op for now?

> +	if (!xive_enabled())
> +		xics_teardown_cpu();
> =20
>  	if (get_preferred_offline_state(cpu) =3D=3D CPU_STATE_INACTIVE) {
>  		set_cpu_current_state(cpu, CPU_STATE_INACTIVE);
> @@ -174,7 +177,10 @@ static int pseries_cpu_disable(void)
>  		boot_cpuid =3D cpumask_any(cpu_online_mask);
> =20
>  	/* FIXME: abstract this to not be platform specific later on */
> -	xics_migrate_irqs_away();
> +	if (xive_enabled())
> +		xive_smp_disable_cpu();
> +	else
> +		xics_migrate_irqs_away();
>  	return 0;
>  }
> =20
> diff --git a/arch/powerpc/platforms/pseries/kexec.c b/arch/powerpc/platfo=
rms/pseries/kexec.c
> index 6681ac97fb18..eeb13429d685 100644
> --- a/arch/powerpc/platforms/pseries/kexec.c
> +++ b/arch/powerpc/platforms/pseries/kexec.c
> @@ -15,6 +15,7 @@
>  #include <asm/firmware.h>
>  #include <asm/kexec.h>
>  #include <asm/xics.h>
> +#include <asm/xive.h>
>  #include <asm/smp.h>
>  #include <asm/plpar_wrappers.h>
> =20
> @@ -51,5 +52,8 @@ void pseries_kexec_cpu_down(int crash_shutdown, int sec=
ondary)
>  		}
>  	}
> =20
> -	xics_kexec_teardown_cpu(secondary);
> +	if (xive_enabled())
> +		xive_kexec_teardown_cpu(secondary);
> +	else
> +		xics_kexec_teardown_cpu(secondary);
>  }
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platfo=
rms/pseries/setup.c
> index b5d86426e97b..a8531e012658 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -57,6 +57,7 @@
>  #include <asm/nvram.h>
>  #include <asm/pmc.h>
>  #include <asm/xics.h>
> +#include <asm/xive.h>
>  #include <asm/ppc-pci.h>
>  #include <asm/i8259.h>
>  #include <asm/udbg.h>
> @@ -176,8 +177,11 @@ static void __init pseries_setup_i8259_cascade(void)
> =20
>  static void __init pseries_init_irq(void)
>  {
> -	xics_init();
> -	pseries_setup_i8259_cascade();
> +	/* Try using a XIVE if available, otherwise use a XICS */
> +	if (!xive_spapr_init()) {
> +		xics_init();
> +		pseries_setup_i8259_cascade();
> +	}
>  }
> =20
>  static void pseries_lpar_enable_pmcs(void)
> diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platform=
s/pseries/smp.c
> index 24785f63fb40..244bb9974963 100644
> --- a/arch/powerpc/platforms/pseries/smp.c
> +++ b/arch/powerpc/platforms/pseries/smp.c
> @@ -41,6 +41,7 @@
>  #include <asm/vdso_datapage.h>
>  #include <asm/cputhreads.h>
>  #include <asm/xics.h>
> +#include <asm/xive.h>
>  #include <asm/dbell.h>
>  #include <asm/plpar_wrappers.h>
>  #include <asm/code-patching.h>
> @@ -136,7 +137,9 @@ static inline int smp_startup_cpu(unsigned int lcpu)
> =20
>  static void smp_setup_cpu(int cpu)
>  {
> -	if (cpu !=3D boot_cpuid)
> +	if (xive_enabled())
> +		xive_smp_setup_cpu();
> +	else if (cpu !=3D boot_cpuid)
>  		xics_setup_cpu();
> =20
>  	if (firmware_has_feature(FW_FEATURE_SPLPAR))
> @@ -181,13 +184,22 @@ static int smp_pSeries_kick_cpu(int nr)
>  	return 0;
>  }
> =20
> +static int pseries_smp_prepare_cpu(int cpu)
> +{
> +	if (xive_enabled())
> +		return xive_smp_prepare_cpu(cpu);
> +	return 0;
> +}
> +
> +/* Cause IPI as setup by the interrupt controller (xics or xive) */
> +static void (*ic_cause_ipi)(int cpu);
> +
>  static void smp_pseries_cause_ipi(int cpu)
>  {
> -	/* POWER9 should not use this handler */
>  	if (doorbell_try_core_ipi(cpu))
>  		return;
> =20
> -	icp_ops->cause_ipi(cpu);
> +	ic_cause_ipi(cpu);

Wouldn't it make more sense to change smp_ops->cause_ipi, rather than
having a double indirection through smp_ops, then the ic_cause_ipi
global?

>  }
> =20
>  static int pseries_cause_nmi_ipi(int cpu)
> @@ -213,12 +225,17 @@ static int pseries_cause_nmi_ipi(int cpu)
> =20
>  static __init void pSeries_smp_probe(void)
>  {
> -	xics_smp_probe();
> +	if (xive_enabled())
> +		xive_smp_probe();
> +	else
> +		xics_smp_probe();
> +
> +	if (cpu_has_feature(CPU_FTR_DBELL)) {
> +		ic_cause_ipi =3D smp_ops->cause_ipi;
> +		WARN_ON(!ic_cause_ipi);
> =20
> -	if (cpu_has_feature(CPU_FTR_DBELL))
>  		smp_ops->cause_ipi =3D smp_pseries_cause_ipi;
> -	else
> -		smp_ops->cause_ipi =3D icp_ops->cause_ipi;
> +	}
>  }
> =20
>  static struct smp_ops_t pseries_smp_ops =3D {
> @@ -226,6 +243,7 @@ static struct smp_ops_t pseries_smp_ops =3D {
>  	.cause_ipi	=3D NULL,	/* Filled at runtime by pSeries_smp_probe() */
>  	.cause_nmi_ipi	=3D pseries_cause_nmi_ipi,
>  	.probe		=3D pSeries_smp_probe,
> +	.prepare_cpu	=3D pseries_smp_prepare_cpu,
>  	.kick_cpu	=3D smp_pSeries_kick_cpu,
>  	.setup_cpu	=3D smp_setup_cpu,
>  	.cpu_bootable	=3D smp_generic_cpu_bootable,
> diff --git a/arch/powerpc/sysdev/xive/Kconfig b/arch/powerpc/sysdev/xive/=
Kconfig
> index 12ccd7373d2f..3e3e25b5e30d 100644
> --- a/arch/powerpc/sysdev/xive/Kconfig
> +++ b/arch/powerpc/sysdev/xive/Kconfig
> @@ -9,3 +9,8 @@ config PPC_XIVE_NATIVE
>  	default n
>  	select PPC_XIVE
>  	depends on PPC_POWERNV
> +
> +config PPC_XIVE_SPAPR
> +	bool
> +	default n
> +	select PPC_XIVE
> diff --git a/arch/powerpc/sysdev/xive/Makefile b/arch/powerpc/sysdev/xive=
/Makefile
> index 3fab303fc169..536d6e5706e3 100644
> --- a/arch/powerpc/sysdev/xive/Makefile
> +++ b/arch/powerpc/sysdev/xive/Makefile
> @@ -2,3 +2,4 @@ subdir-ccflags-$(CONFIG_PPC_WERROR) :=3D -Werror
> =20
>  obj-y				+=3D common.o
>  obj-$(CONFIG_PPC_XIVE_NATIVE)	+=3D native.o
> +obj-$(CONFIG_PPC_XIVE_SPAPR)	+=3D spapr.o
> diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/=
spapr.c
> new file mode 100644
> index 000000000000..a3668815d5c1
> --- /dev/null
> +++ b/arch/powerpc/sysdev/xive/spapr.c
> @@ -0,0 +1,554 @@
> +/*
> + * Copyright 2016,2017 IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#define pr_fmt(fmt) "xive: " fmt
> +
> +#include <linux/types.h>
> +#include <linux/irq.h>
> +#include <linux/smp.h>
> +#include <linux/interrupt.h>
> +#include <linux/init.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/cpumask.h>
> +#include <linux/mm.h>
> +
> +#include <asm/prom.h>
> +#include <asm/io.h>
> +#include <asm/smp.h>
> +#include <asm/irq.h>
> +#include <asm/errno.h>
> +#include <asm/xive.h>
> +#include <asm/xive-regs.h>
> +#include <asm/hvcall.h>
> +
> +#include "xive-internal.h"
> +
> +static u32 xive_queue_shift;
> +
> +struct xive_irq_bitmap {
> +	unsigned long		*bitmap;
> +	unsigned int		base;
> +	unsigned int		count;
> +	spinlock_t		lock;
> +	struct list_head	list;
> +};
> +
> +static LIST_HEAD(xive_irq_bitmaps);
> +
> +static int xive_irq_bitmap_add(int base, int count)
> +{
> +	struct xive_irq_bitmap *xibm;
> +
> +	xibm =3D kzalloc(sizeof(*xibm), GFP_ATOMIC);
> +	if (!xibm)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&xibm->lock);
> +	xibm->base =3D base;
> +	xibm->count =3D count;
> +	xibm->bitmap =3D kzalloc(xibm->count, GFP_KERNEL);
> +	list_add(&xibm->list, &xive_irq_bitmaps);
> +
> +	pr_info("Using IRQ range [%x-%x]", xibm->base,
> +		xibm->base + xibm->count - 1);
> +	return 0;
> +}
> +
> +static int __xive_irq_bitmap_alloc(struct xive_irq_bitmap *xibm)
> +{
> +	int irq;
> +
> +	irq =3D find_first_zero_bit(xibm->bitmap, xibm->count);
> +	if (irq !=3D xibm->count) {
> +		set_bit(irq, xibm->bitmap);
> +		irq +=3D xibm->base;
> +	} else {
> +		irq =3D -ENOMEM;
> +	}
> +
> +	return irq;
> +}
> +
> +static int xive_irq_bitmap_alloc(void)
> +{
> +	struct xive_irq_bitmap *xibm;
> +	unsigned long flags;
> +	int irq =3D -ENOENT;
> +
> +	list_for_each_entry(xibm, &xive_irq_bitmaps, list) {
> +		spin_lock_irqsave(&xibm->lock, flags);
> +		irq =3D __xive_irq_bitmap_alloc(xibm);
> +		spin_unlock_irqrestore(&xibm->lock, flags);
> +		if (irq >=3D 0)
> +			break;
> +	}
> +	return irq;
> +}
> +
> +static void xive_irq_bitmap_free(int irq)
> +{
> +	unsigned long flags;
> +	struct xive_irq_bitmap *xibm;
> +
> +	list_for_each_entry(xibm, &xive_irq_bitmaps, list) {
> +		if ((irq >=3D xibm->base) && (irq < xibm->base + xibm->count)) {
> +			spin_lock_irqsave(&xibm->lock, flags);
> +			clear_bit(irq - xibm->base, xibm->bitmap);
> +			spin_unlock_irqrestore(&xibm->lock, flags);
> +			break;
> +		}
> +	}
> +}
> +
> +static long plpar_int_get_source_info(unsigned long flags,
> +				      unsigned long lisn,
> +				      unsigned long *src_flags,
> +				      unsigned long *eoi_page,
> +				      unsigned long *trig_page,
> +				      unsigned long *esb_shift)
> +{
> +	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
> +	long rc;
> +
> +	rc =3D plpar_hcall(H_INT_GET_SOURCE_INFO, retbuf, flags, lisn);
> +	if (rc) {
> +		pr_err("H_INT_GET_SOURCE_INFO lisn=3D%ld failed %ld\n", lisn, rc);
> +		return rc;
> +	}
> +
> +	*src_flags =3D retbuf[0];
> +	*eoi_page  =3D retbuf[1];
> +	*trig_page =3D retbuf[2];
> +	*esb_shift =3D retbuf[3];
> +
> +	pr_devel("H_INT_GET_SOURCE_INFO flags=3D%lx eoi=3D%lx trig=3D%lx shift=
=3D%lx\n",
> +		retbuf[0], retbuf[1], retbuf[2], retbuf[3]);
> +
> +	return 0;
> +}
> +
> +#define XIVE_SRC_SET_EISN (1ull << (63 - 62))
> +#define XIVE_SRC_MASK     (1ull << (63 - 63)) /* unused */
> +
> +static long plpar_int_set_source_config(unsigned long flags,
> +					unsigned long lisn,
> +					unsigned long target,
> +					unsigned long prio,
> +					unsigned long sw_irq)
> +{
> +	long rc;
> +
> +
> +	pr_devel("H_INT_SET_SOURCE_CONFIG flags=3D%lx lisn=3D%lx target=3D%lx p=
rio=3D%lx sw_irq=3D%lx\n",
> +		flags, lisn, target, prio, sw_irq);
> +
> +
> +	rc =3D plpar_hcall_norets(H_INT_SET_SOURCE_CONFIG, flags, lisn,
> +				target, prio, sw_irq);
> +	if (rc) {
> +		pr_err("H_INT_SET_SOURCE_CONFIG lisn=3D%ld failed %ld\n",
> +		       lisn, rc);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static long plpar_int_get_queue_info(unsigned long flags,
> +				     unsigned long target,
> +				     unsigned long priority,
> +				     unsigned long *esn_page,
> +				     unsigned long *esn_size)
> +{
> +	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
> +	long rc;
> +
> +	rc =3D plpar_hcall(H_INT_GET_QUEUE_INFO, retbuf, flags, target, priorit=
y);
> +	if (rc) {
> +		pr_err("H_INT_GET_QUEUE_INFO cpu=3D%ld prio=3D%ld failed %ld\n",
> +		       target, priority, rc);
> +		return rc;
> +	}
> +
> +	*esn_page =3D retbuf[0];
> +	*esn_size =3D retbuf[1];
> +
> +	pr_devel("H_INT_GET_QUEUE_INFO page=3D%lx size=3D%lx\n",
> +		retbuf[0], retbuf[1]);
> +
> +	return 0;
> +}
> +
> +#define XIVE_EQ_ALWAYS_NOTIFY (1ull << (63 - 63))
> +
> +static long plpar_int_set_queue_config(unsigned long flags,
> +				       unsigned long target,
> +				       unsigned long priority,
> +				       unsigned long qpage,
> +				       unsigned long qsize)
> +{
> +	long rc;
> +
> +	pr_devel("H_INT_SET_QUEUE_CONFIG flags=3D%lx target=3D%lx priority=3D%l=
x qpage=3D%lx qsize=3D%lx\n",
> +		flags,  target, priority, qpage, qsize);
> +
> +	rc =3D plpar_hcall_norets(H_INT_SET_QUEUE_CONFIG, flags, target,
> +				priority, qpage, qsize);
> +	if (rc) {
> +		pr_err("H_INT_SET_QUEUE_CONFIG cpu=3D%ld prio=3D%ld qpage=3D%lx return=
ed %ld\n",
> +		       target, priority, qpage, rc);
> +		return  rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static long plpar_int_sync(unsigned long flags)
> +{
> +	long rc;
> +
> +	rc =3D plpar_hcall_norets(H_INT_SYNC, flags);
> +	if (rc) {
> +		pr_err("H_INT_SYNC returned %ld\n", rc);
> +		return  rc;
> +	}
> +
> +	return 0;
> +}
> +
> +#define XIVE_SRC_H_INT_ESB     (1ull << (63 - 60)) /* TODO */
> +#define XIVE_SRC_LSI           (1ull << (63 - 61))
> +#define XIVE_SRC_TRIGGER       (1ull << (63 - 62))
> +#define XIVE_SRC_STORE_EOI     (1ull << (63 - 63))
> +
> +static int xive_spapr_populate_irq_data(u32 hw_irq, struct xive_irq_data=
 *data)
> +{
> +	long rc;
> +	unsigned long flags;
> +	unsigned long eoi_page;
> +	unsigned long trig_page;
> +	unsigned long esb_shift;
> +
> +	memset(data, 0, sizeof(*data));
> +
> +	rc =3D plpar_int_get_source_info(0, hw_irq, &flags, &eoi_page, &trig_pa=
ge,
> +				       &esb_shift);
> +	if (rc)
> +		return  -EINVAL;
> +
> +	if (flags & XIVE_SRC_STORE_EOI)
> +		data->flags  |=3D XIVE_IRQ_FLAG_STORE_EOI;
> +	if (flags & XIVE_SRC_LSI)
> +		data->flags  |=3D XIVE_IRQ_FLAG_LSI;
> +	data->eoi_page  =3D eoi_page;
> +	data->esb_shift =3D esb_shift;
> +	data->trig_page =3D trig_page;
> +
> +	/*
> +	 * No chip-id for the sPAPR backend. This has an impact how we
> +	 * pick a target. See xive_pick_irq_target().
> +	 */
> +	data->src_chip =3D XIVE_INVALID_CHIP_ID;
> +
> +	data->eoi_mmio =3D ioremap(data->eoi_page, 1u << data->esb_shift);
> +	if (!data->eoi_mmio) {
> +		pr_err("Failed to map EOI page for irq 0x%x\n", hw_irq);
> +		return -ENOMEM;
> +	}
> +
> +	/* Full function page supports trigger */
> +	if (flags & XIVE_SRC_TRIGGER) {
> +		data->trig_mmio =3D data->eoi_mmio;
> +		return 0;
> +	}
> +
> +	data->trig_mmio =3D ioremap(data->trig_page, 1u << data->esb_shift);
> +	if (!data->trig_mmio) {
> +		pr_err("Failed to map trigger page for irq 0x%x\n", hw_irq);
> +		return -ENOMEM;
> +	}
> +	return 0;
> +}
> +
> +static int xive_spapr_configure_irq(u32 hw_irq, u32 target, u8 prio, u32=
 sw_irq)
> +{
> +	long rc;
> +
> +	rc =3D plpar_int_set_source_config(XIVE_SRC_SET_EISN, hw_irq, target,
> +					 prio, sw_irq);
> +
> +	return rc =3D=3D 0 ? 0 : -ENXIO;
> +}
> +
> +/* This can be called multiple time to change a queue configuration */
> +static int xive_spapr_configure_queue(u32 target, struct xive_q *q, u8 p=
rio,
> +				   __be32 *qpage, u32 order)
> +{
> +	s64 rc =3D 0;
> +	unsigned long esn_page;
> +	unsigned long esn_size;
> +	u64 flags, qpage_phys;
> +
> +	/* If there's an actual queue page, clean it */
> +	if (order) {
> +		if (WARN_ON(!qpage))
> +			return -EINVAL;
> +		qpage_phys =3D __pa(qpage);
> +	} else {
> +		qpage_phys =3D 0;
> +	}
> +
> +	/* Initialize the rest of the fields */
> +	q->msk =3D order ? ((1u << (order - 2)) - 1) : 0;
> +	q->idx =3D 0;
> +	q->toggle =3D 0;
> +
> +	rc =3D plpar_int_get_queue_info(0, target, prio, &esn_page, &esn_size);
> +	if (rc) {
> +		pr_err("Error %lld getting queue info prio %d\n", rc, prio);
> +		rc =3D -EIO;
> +		goto fail;
> +	}
> +
> +	/* TODO: add support for the notification page */
> +	q->eoi_phys =3D esn_page;
> +
> +	/* Default is to always notify */
> +	flags =3D XIVE_EQ_ALWAYS_NOTIFY;
> +
> +	/* Configure and enable the queue in HW */
> +	rc =3D plpar_int_set_queue_config(flags, target, prio, qpage_phys, orde=
r);
> +	if (rc) {
> +		pr_err("Error %lld setting queue for prio %d\n", rc, prio);
> +		rc =3D -EIO;
> +	} else {
> +		q->qpage =3D qpage;
> +	}
> +fail:
> +	return rc;
> +}
> +
> +static int xive_spapr_setup_queue(unsigned int cpu, struct xive_cpu *xc,
> +				  u8 prio)
> +{
> +	struct xive_q *q =3D &xc->queue[prio];
> +	unsigned int alloc_order;
> +	struct page *pages;
> +	__be32 *qpage;
> +
> +	alloc_order =3D (xive_queue_shift > PAGE_SHIFT) ?
> +		(xive_queue_shift - PAGE_SHIFT) : 0;
> +	pages =3D alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, alloc_order);
> +	if (!pages)
> +		return -ENOMEM;
> +	qpage =3D (__be32 *)page_address(pages);
> +	memset(qpage, 0, 1 << xive_queue_shift);
> +
> +	return xive_spapr_configure_queue(cpu, q, prio, qpage,
> +					  xive_queue_shift);
> +}
> +
> +static void xive_spapr_cleanup_queue(unsigned int cpu, struct xive_cpu *=
xc,
> +				  u8 prio)
> +{
> +	struct xive_q *q =3D &xc->queue[prio];
> +	unsigned int alloc_order;
> +	long rc;
> +
> +	rc =3D plpar_int_set_queue_config(0, cpu, prio, 0, 0);
> +	if (rc)
> +		pr_err("Error %ld setting queue for prio %d\n", rc, prio);
> +
> +	alloc_order =3D (xive_queue_shift > PAGE_SHIFT) ?
> +		(xive_queue_shift - PAGE_SHIFT) : 0;

Maybe a helper inline for this calculation, since it's used in both
setup_queue() and cleanup_queue?

> +	free_pages((unsigned long)q->qpage, alloc_order);
> +	q->qpage =3D NULL;
> +}
> +
> +static bool xive_spapr_match(struct device_node *node)
> +{
> +	return 1;
> +}
> +
> +#ifdef CONFIG_SMP
> +static int xive_spapr_get_ipi(unsigned int cpu, struct xive_cpu *xc)
> +{
> +	int irq =3D xive_irq_bitmap_alloc();
> +
> +	if (irq < 0) {
> +		pr_err("Failed to allocate IPI on CPU %d\n", cpu);
> +		return -ENXIO;
> +	}
> +
> +	xc->hw_ipi =3D irq;
> +	return 0;
> +}
> +
> +static void xive_spapr_put_ipi(unsigned int cpu, struct xive_cpu *xc)
> +{
> +	xive_irq_bitmap_free(xc->hw_ipi);
> +}
> +#endif /* CONFIG_SMP */
> +
> +static void xive_spapr_shutdown(void)
> +{
> +	long rc;
> +
> +	rc =3D plpar_hcall_norets(H_INT_RESET, 0);
> +	if (rc)
> +		pr_err("H_INT_RESET failed %ld\n", rc);
> +}
> +
> +static void xive_spapr_update_pending(struct xive_cpu *xc)
> +{
> +	u8 nsr, cppr;
> +	u16 ack;
> +
> +	/* Perform the acknowledge hypervisor to register cycle */
> +	ack =3D be16_to_cpu(__raw_readw(xive_tima + TM_SPC_ACK_OS_REG));

Why do you need the raw_readw() + be16_to_cpu + mb, rather than one of
the higher level IO helpers?

> +	/* Synchronize subsequent queue accesses */
> +	mb();
> +
> +	/*
> +	 * Grab the CPPR and the "NSR" field which indicates the source
> +	 * of the hypervisor interrupt (if any)
> +	 */
> +	cppr =3D ack & 0xff;
> +	nsr =3D ack >> 8;
> +
> +	if (nsr & TM_QW1_NSR_EO) {
> +		if (cppr =3D=3D 0xff)
> +			return;
> +		/* Mark the priority pending */
> +		xc->pending_prio |=3D 1 << cppr;
> +
> +		/*
> +		 * A new interrupt should never have a CPPR less favored
> +		 * than our current one.
> +		 */
> +		if (cppr >=3D xc->cppr)
> +			pr_err("CPU %d odd ack CPPR, got %d at %d\n",
> +			       smp_processor_id(), cppr, xc->cppr);
> +
> +		/* Update our idea of what the CPPR is */
> +		xc->cppr =3D cppr;
> +	}
> +}
> +
> +static void xive_spapr_eoi(u32 hw_irq)
> +{
> +	/* Not used */;
> +}

Do you really want empty stub functions, or would it be better to have
the method caller check for NULL in the ops structure?

> +
> +static void xive_spapr_setup_cpu(unsigned int cpu, struct xive_cpu *xc)
> +{
> +	/* Only some debug on the TIMA settings */
> +	pr_debug("(HW value: %08x %08x %08x)\n",
> +		 in_be32(xive_tima + TM_QW1_OS + TM_WORD0),
> +		 in_be32(xive_tima + TM_QW1_OS + TM_WORD1),
> +		 in_be32(xive_tima + TM_QW1_OS + TM_WORD2));
> +}
> +
> +static void xive_spapr_teardown_cpu(unsigned int cpu, struct xive_cpu *x=
c)
> +{
> +	/* Nothing to do */;
> +}
> +
> +static void xive_spapr_sync_source(u32 hw_irq)
> +{
> +	/* Specs are unclear on what this is doing */
> +	plpar_int_sync(0);
> +}
> +
> +static const struct xive_ops xive_spapr_ops =3D {
> +	.populate_irq_data	=3D xive_spapr_populate_irq_data,
> +	.configure_irq		=3D xive_spapr_configure_irq,
> +	.setup_queue		=3D xive_spapr_setup_queue,
> +	.cleanup_queue		=3D xive_spapr_cleanup_queue,
> +	.match			=3D xive_spapr_match,
> +	.shutdown		=3D xive_spapr_shutdown,
> +	.update_pending		=3D xive_spapr_update_pending,
> +	.eoi			=3D xive_spapr_eoi,
> +	.setup_cpu		=3D xive_spapr_setup_cpu,
> +	.teardown_cpu		=3D xive_spapr_teardown_cpu,
> +	.sync_source		=3D xive_spapr_sync_source,
> +#ifdef CONFIG_SMP
> +	.get_ipi		=3D xive_spapr_get_ipi,
> +	.put_ipi		=3D xive_spapr_put_ipi,
> +#endif /* CONFIG_SMP */
> +	.name			=3D "spapr",
> +};
> +
> +bool xive_spapr_init(void)
> +{
> +	struct device_node *np;
> +	struct resource r;
> +	void __iomem *tima;
> +	struct property *prop;
> +	u8 max_prio =3D 7;
> +	u32 val;
> +	u32 len;
> +	const __be32 *reg;
> +	int i;
> +
> +	if (xive_cmdline_disabled)
> +		return false;
> +
> +	pr_devel("%s()\n", __func__);
> +	np =3D of_find_compatible_node(NULL, NULL, "ibm,power-ivpe");
> +	if (!np) {
> +		pr_devel("not found !\n");
> +		return false;
> +	}
> +	pr_devel("Found %s\n", np->full_name);
> +
> +	/* Resource 1 is the OS ring TIMA */
> +	if (of_address_to_resource(np, 1, &r)) {
> +		pr_err("Failed to get thread mgmnt area resource\n");
> +		return false;
> +	}
> +	tima =3D ioremap(r.start, resource_size(&r));
> +	if (!tima) {
> +		pr_err("Failed to map thread mgmnt area\n");
> +		return false;
> +	}
> +
> +	/* Feed the IRQ number allocator with the ranges given in the DT */
> +	reg =3D of_get_property(np, "ibm,xive-lisn-ranges", &len);
> +	if (!reg) {
> +		pr_err("Failed to read 'ibm,xive-lisn-ranges' property\n");
> +		return false;
> +	}
> +
> +	if (len % (2 * sizeof(u32)) !=3D 0) {
> +		pr_err("invalid 'ibm,xive-lisn-ranges' property\n");
> +		return false;
> +	}
> +
> +	for (i =3D 0; i < len / (2 * sizeof(u32)); i++, reg +=3D 2)
> +		xive_irq_bitmap_add(be32_to_cpu(reg[0]),
> +				    be32_to_cpu(reg[1]));
> +
> +	/* Iterate the EQ sizes and pick one */
> +	of_property_for_each_u32(np, "ibm,xive-eq-sizes", prop, reg, val) {
> +		xive_queue_shift =3D val;
> +		if (val =3D=3D PAGE_SHIFT)
> +			break;
> +	}
> +
> +	/* Initialize XIVE core with our backend */
> +	if (!xive_core_init(&xive_spapr_ops, tima, TM_QW1_OS, max_prio))
> +		return false;
> +
> +	pr_info("Using %dkB queues\n", 1 << (xive_queue_shift - 10));
> +	return true;
> +}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmKhyAACgkQbDjKyiDZ
s5JfQQ/+MenCB1/xRsRwS3FqH7APWe2uDADOeqvWtwWvxTLzbQxposFspiPAUBHC
v7b3Y56jc+pbFcuB0JGy7o+HpfhUnA+kFuUBwsE/ftxybsOqKszX9+V+1TKVXRvZ
DjUOMUWp3m159/6X3FW5y8hjCHYo+ipcNOBD3FOhXup2glq1PL+ETZINsxhio9ML
jYxy85Rc0b0xpqfiNVRf3RZbXunLvi6D5UMoMopVv8lbdulsOFbsTl9lKDkQku5h
KWmoTdp40kKiQmRoDqGj1AYpEhghZWYEzLaR7eGSNyeSQKzrohaypODEH4b3AaNr
gV9tu4bH2hPfrO5W7/ucOdYug8RhDahDWU/ual87Zf6Ec74TCKNk2HgdItVMEeMw
vVjMMYMFUX8zXF4Z4AEnLUhr0xHdrAoPIUnEQW1VezZGm0w8M0Jm5nSt1WiK1+G/
TbF9mxTvKptgy8mXpdOJCYkCf2h/fgeJTBhRKUlYyOhsPVoBteq5z3HPW++Cl3Da
Q8Hs+tWAkSd+R8cM1u2keynO6Dgi5VJaBondUQO7dEeoTxkHk4gOE8988S8x+3Jl
X6q7WQopJrKVbksxONRLjp+IihsGOmJ8TzHy+eLnKsNaO1Np7torcZXdIefyAJxX
ek47F+ZGlrzQBf+15AfFXd2b4jYFjvFUhzjw1+t1Vjb/w+czq1g=
=bbLZ
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
