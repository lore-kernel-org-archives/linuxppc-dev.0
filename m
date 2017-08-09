Return-Path: <clg@kaod.org>
Received: from 2.mo177.mail-out.ovh.net (2.mo177.mail-out.ovh.net
 [178.33.109.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xS4gY4MRDzDqtL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 18:48:57 +1000 (AEST)
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id DA7F673FEC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 10:48:53 +0200 (CEST)
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [PATCH 02/10] powerpc/xive: guest exploitation of the XIVE
 interrupt controller
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
References: <1502182579-990-1-git-send-email-clg@kaod.org>
 <1502182579-990-3-git-send-email-clg@kaod.org>
 <20170809035306.GC13670@umbus.fritz.box>
Message-ID: <f82c1111-3dd3-f378-0ff6-222bffc07a35@kaod.org>
Date: Wed, 9 Aug 2017 10:48:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170809035306.GC13670@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/09/2017 05:53 AM, David Gibson wrote:
> On Tue, Aug 08, 2017 at 10:56:12AM +0200, Cédric Le Goater wrote:
>> This is the framework for using XIVE in a PowerVM guest. The support
>> is very similar to the native one in a much simpler form.
>>
>> Instead of OPAL calls, a set of Hypervisors call are used to configure
>> the interrupt sources and the event/notification queues of the guest:
>>
>>  - H_INT_GET_SOURCE_INFO
>>
>>    used to obtain the address of the MMIO page of the Event State
>>    Buffer (PQ bits) entry associated with the source.
>>
>>  - H_INT_SET_SOURCE_CONFIG
>>
>>    assigns a source to a "target".
>>
>>  - H_INT_GET_SOURCE_CONFIG
>>
>>    determines to which "target" and "priority" is assigned to a source
>>
>>  - H_INT_GET_QUEUE_INFO
>>
>>    returns the address of the notification management page associated
>>    with the specified "target" and "priority".
>>
>>  - H_INT_SET_QUEUE_CONFIG
>>
>>    sets or resets the event queue for a given "target" and "priority".
>>    It is also used to set the notification config associated with the
>>    queue, only unconditional notification for the moment.  Reset is
>>    performed with a queue size of 0 and queueing is disabled in that
>>    case.
>>
>>  - H_INT_GET_QUEUE_CONFIG
>>
>>    returns the queue settings for a given "target" and "priority".
>>
>>  - H_INT_RESET
>>
>>    resets all of the partition's interrupt exploitation structures to
>>    their initial state, losing all configuration set via the hcalls
>>    H_INT_SET_SOURCE_CONFIG and H_INT_SET_QUEUE_CONFIG.
>>
>>  - H_INT_SYNC
>>
>>    issue a synchronisation on a source to make sure sure all
>>    notifications have reached their queue.
>>
>> As for XICS, the XIVE interface for the guest is described in the
>> device tree under the interrupt controller node. A couple of new
>> properties are specific to XIVE :
>>
>>  - "reg"
>>
>>    contains the base address and size of the thread interrupt
>>    managnement areas (TIMA) for the user level for the OS level. Only
>>    the OS level is taken into account.
>>
>>  - "ibm,xive-eq-sizes"
>>
>>    the size of the event queues.
>>
>>  - "ibm,xive-lisn-ranges"
>>
>>    the interrupt numbers ranges assigned to the guest. These are
>>    allocated using a simple bitmap.
>>
>> Tested with a QEMU XIVE model for pseries and with the Power
>> hypervisor
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> 
> I don't know XIVE well enough to review in detail, but I've made some
> comments based on general knowledge.

Thanks for taking a look. 
 
> 
>> ---
>>  arch/powerpc/include/asm/hvcall.h            |  13 +-
>>  arch/powerpc/include/asm/xive.h              |   2 +
>>  arch/powerpc/platforms/pseries/Kconfig       |   1 +
>>  arch/powerpc/platforms/pseries/hotplug-cpu.c |  10 +-
>>  arch/powerpc/platforms/pseries/kexec.c       |   6 +-
>>  arch/powerpc/platforms/pseries/setup.c       |   8 +-
>>  arch/powerpc/platforms/pseries/smp.c         |  32 +-
>>  arch/powerpc/sysdev/xive/Kconfig             |   5 +
>>  arch/powerpc/sysdev/xive/Makefile            |   1 +
>>  arch/powerpc/sysdev/xive/spapr.c             | 554 +++++++++++++++++++++++++++
>>  10 files changed, 619 insertions(+), 13 deletions(-)
>>  create mode 100644 arch/powerpc/sysdev/xive/spapr.c
>>
>> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
>> index 57d38b504ff7..3d34dc0869f6 100644
>> --- a/arch/powerpc/include/asm/hvcall.h
>> +++ b/arch/powerpc/include/asm/hvcall.h
>> @@ -280,7 +280,18 @@
>>  #define H_RESIZE_HPT_COMMIT	0x370
>>  #define H_REGISTER_PROC_TBL	0x37C
>>  #define H_SIGNAL_SYS_RESET	0x380
>> -#define MAX_HCALL_OPCODE	H_SIGNAL_SYS_RESET
>> +#define H_INT_GET_SOURCE_INFO   0x3A8
>> +#define H_INT_SET_SOURCE_CONFIG 0x3AC
>> +#define H_INT_GET_SOURCE_CONFIG 0x3B0
>> +#define H_INT_GET_QUEUE_INFO    0x3B4
>> +#define H_INT_SET_QUEUE_CONFIG  0x3B8
>> +#define H_INT_GET_QUEUE_CONFIG  0x3BC
>> +#define H_INT_SET_OS_REPORTING_LINE 0x3C0
>> +#define H_INT_GET_OS_REPORTING_LINE 0x3C4
>> +#define H_INT_ESB               0x3C8
>> +#define H_INT_SYNC              0x3CC
>> +#define H_INT_RESET             0x3D0
>> +#define MAX_HCALL_OPCODE	H_INT_RESET
>>  
>>  /* H_VIOCTL functions */
>>  #define H_GET_VIOA_DUMP_SIZE	0x01
>> diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
>> index c23ff4389ca2..1deb10032d61 100644
>> --- a/arch/powerpc/include/asm/xive.h
>> +++ b/arch/powerpc/include/asm/xive.h
>> @@ -110,6 +110,7 @@ extern bool __xive_enabled;
>>  
>>  static inline bool xive_enabled(void) { return __xive_enabled; }
>>  
>> +extern bool xive_spapr_init(void);
>>  extern bool xive_native_init(void);
>>  extern void xive_smp_probe(void);
>>  extern int  xive_smp_prepare_cpu(unsigned int cpu);
>> @@ -147,6 +148,7 @@ extern int xive_native_get_vp_info(u32 vp_id, u32 *out_cam_id, u32 *out_chip_id)
>>  
>>  static inline bool xive_enabled(void) { return false; }
>>  
>> +static inline bool xive_spapr_init(void) { return false; }
>>  static inline bool xive_native_init(void) { return false; }
>>  static inline void xive_smp_probe(void) { }
>>  extern inline int  xive_smp_prepare_cpu(unsigned int cpu) { return -EINVAL; }
>> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
>> index 3a6dfd14f64b..71dd69d9ec64 100644
>> --- a/arch/powerpc/platforms/pseries/Kconfig
>> +++ b/arch/powerpc/platforms/pseries/Kconfig
>> @@ -7,6 +7,7 @@ config PPC_PSERIES
>>  	select PCI
>>  	select PCI_MSI
>>  	select PPC_XICS
>> +	select PPC_XIVE_SPAPR
>>  	select PPC_ICP_NATIVE
>>  	select PPC_ICP_HV
>>  	select PPC_ICS_RTAS
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> index 6afd1efd3633..de0a5c1d7b29 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> @@ -34,6 +34,7 @@
>>  #include <asm/machdep.h>
>>  #include <asm/vdso_datapage.h>
>>  #include <asm/xics.h>
>> +#include <asm/xive.h>
>>  #include <asm/plpar_wrappers.h>
>>  
>>  #include "pseries.h"
>> @@ -109,7 +110,9 @@ static void pseries_mach_cpu_die(void)
>>  
>>  	local_irq_disable();
>>  	idle_task_exit();
>> -	xics_teardown_cpu();
>> +	/* Nothing TODO for xive ? */;
> 
> You have a XIVE teardown_cpu() method below - should you be calling
> that here, even though it's a no-op for now?

yes. I agree.

>> +	if (!xive_enabled())
>> +		xics_teardown_cpu();
>>  
>>  	if (get_preferred_offline_state(cpu) == CPU_STATE_INACTIVE) {
>>  		set_cpu_current_state(cpu, CPU_STATE_INACTIVE);
>> @@ -174,7 +177,10 @@ static int pseries_cpu_disable(void)
>>  		boot_cpuid = cpumask_any(cpu_online_mask);
>>  
>>  	/* FIXME: abstract this to not be platform specific later on */
>> -	xics_migrate_irqs_away();
>> +	if (xive_enabled())
>> +		xive_smp_disable_cpu();
>> +	else
>> +		xics_migrate_irqs_away();
>>  	return 0;
>>  }
>>  
>> diff --git a/arch/powerpc/platforms/pseries/kexec.c b/arch/powerpc/platforms/pseries/kexec.c
>> index 6681ac97fb18..eeb13429d685 100644
>> --- a/arch/powerpc/platforms/pseries/kexec.c
>> +++ b/arch/powerpc/platforms/pseries/kexec.c
>> @@ -15,6 +15,7 @@
>>  #include <asm/firmware.h>
>>  #include <asm/kexec.h>
>>  #include <asm/xics.h>
>> +#include <asm/xive.h>
>>  #include <asm/smp.h>
>>  #include <asm/plpar_wrappers.h>
>>  
>> @@ -51,5 +52,8 @@ void pseries_kexec_cpu_down(int crash_shutdown, int secondary)
>>  		}
>>  	}
>>  
>> -	xics_kexec_teardown_cpu(secondary);
>> +	if (xive_enabled())
>> +		xive_kexec_teardown_cpu(secondary);
>> +	else
>> +		xics_kexec_teardown_cpu(secondary);
>>  }
>> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
>> index b5d86426e97b..a8531e012658 100644
>> --- a/arch/powerpc/platforms/pseries/setup.c
>> +++ b/arch/powerpc/platforms/pseries/setup.c
>> @@ -57,6 +57,7 @@
>>  #include <asm/nvram.h>
>>  #include <asm/pmc.h>
>>  #include <asm/xics.h>
>> +#include <asm/xive.h>
>>  #include <asm/ppc-pci.h>
>>  #include <asm/i8259.h>
>>  #include <asm/udbg.h>
>> @@ -176,8 +177,11 @@ static void __init pseries_setup_i8259_cascade(void)
>>  
>>  static void __init pseries_init_irq(void)
>>  {
>> -	xics_init();
>> -	pseries_setup_i8259_cascade();
>> +	/* Try using a XIVE if available, otherwise use a XICS */
>> +	if (!xive_spapr_init()) {
>> +		xics_init();
>> +		pseries_setup_i8259_cascade();
>> +	}
>>  }
>>  
>>  static void pseries_lpar_enable_pmcs(void)
>> diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
>> index 24785f63fb40..244bb9974963 100644
>> --- a/arch/powerpc/platforms/pseries/smp.c
>> +++ b/arch/powerpc/platforms/pseries/smp.c
>> @@ -41,6 +41,7 @@
>>  #include <asm/vdso_datapage.h>
>>  #include <asm/cputhreads.h>
>>  #include <asm/xics.h>
>> +#include <asm/xive.h>
>>  #include <asm/dbell.h>
>>  #include <asm/plpar_wrappers.h>
>>  #include <asm/code-patching.h>
>> @@ -136,7 +137,9 @@ static inline int smp_startup_cpu(unsigned int lcpu)
>>  
>>  static void smp_setup_cpu(int cpu)
>>  {
>> -	if (cpu != boot_cpuid)
>> +	if (xive_enabled())
>> +		xive_smp_setup_cpu();
>> +	else if (cpu != boot_cpuid)
>>  		xics_setup_cpu();
>>  
>>  	if (firmware_has_feature(FW_FEATURE_SPLPAR))
>> @@ -181,13 +184,22 @@ static int smp_pSeries_kick_cpu(int nr)
>>  	return 0;
>>  }
>>  
>> +static int pseries_smp_prepare_cpu(int cpu)
>> +{
>> +	if (xive_enabled())
>> +		return xive_smp_prepare_cpu(cpu);
>> +	return 0;
>> +}
>> +
>> +/* Cause IPI as setup by the interrupt controller (xics or xive) */
>> +static void (*ic_cause_ipi)(int cpu);
>> +
>>  static void smp_pseries_cause_ipi(int cpu)
>>  {
>> -	/* POWER9 should not use this handler */
>>  	if (doorbell_try_core_ipi(cpu))
>>  		return;
>>  
>> -	icp_ops->cause_ipi(cpu);
>> +	ic_cause_ipi(cpu);
> 
> Wouldn't it make more sense to change smp_ops->cause_ipi, rather than
> having a double indirection through smp_ops, then the ic_cause_ipi
> global?

we need to retain the original setting of smp_ops->cause_ipi 
somewhere as it can be set from xive_smp_probe() to : 

	icp_ops->cause_ipi 

or from xics_smp_probe() to :

	xive_cause_ipi()

I am not sure we can do any better ? 

>>  }
>>  
>>  static int pseries_cause_nmi_ipi(int cpu)
>> @@ -213,12 +225,17 @@ static int pseries_cause_nmi_ipi(int cpu)
>>  
>>  static __init void pSeries_smp_probe(void)
>>  {
>> -	xics_smp_probe();
>> +	if (xive_enabled())
>> +		xive_smp_probe();
>> +	else
>> +		xics_smp_probe();
>> +
>> +	if (cpu_has_feature(CPU_FTR_DBELL)) {
>> +		ic_cause_ipi = smp_ops->cause_ipi;
>> +		WARN_ON(!ic_cause_ipi);
>>  
>> -	if (cpu_has_feature(CPU_FTR_DBELL))
>>  		smp_ops->cause_ipi = smp_pseries_cause_ipi;
>> -	else
>> -		smp_ops->cause_ipi = icp_ops->cause_ipi;
>> +	}
>>  }
>>  
>>  static struct smp_ops_t pseries_smp_ops = {
>> @@ -226,6 +243,7 @@ static struct smp_ops_t pseries_smp_ops = {
>>  	.cause_ipi	= NULL,	/* Filled at runtime by pSeries_smp_probe() */
>>  	.cause_nmi_ipi	= pseries_cause_nmi_ipi,
>>  	.probe		= pSeries_smp_probe,
>> +	.prepare_cpu	= pseries_smp_prepare_cpu,
>>  	.kick_cpu	= smp_pSeries_kick_cpu,
>>  	.setup_cpu	= smp_setup_cpu,
>>  	.cpu_bootable	= smp_generic_cpu_bootable,
>> diff --git a/arch/powerpc/sysdev/xive/Kconfig b/arch/powerpc/sysdev/xive/Kconfig
>> index 12ccd7373d2f..3e3e25b5e30d 100644
>> --- a/arch/powerpc/sysdev/xive/Kconfig
>> +++ b/arch/powerpc/sysdev/xive/Kconfig
>> @@ -9,3 +9,8 @@ config PPC_XIVE_NATIVE
>>  	default n
>>  	select PPC_XIVE
>>  	depends on PPC_POWERNV
>> +
>> +config PPC_XIVE_SPAPR
>> +	bool
>> +	default n
>> +	select PPC_XIVE
>> diff --git a/arch/powerpc/sysdev/xive/Makefile b/arch/powerpc/sysdev/xive/Makefile
>> index 3fab303fc169..536d6e5706e3 100644
>> --- a/arch/powerpc/sysdev/xive/Makefile
>> +++ b/arch/powerpc/sysdev/xive/Makefile
>> @@ -2,3 +2,4 @@ subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
>>  
>>  obj-y				+= common.o
>>  obj-$(CONFIG_PPC_XIVE_NATIVE)	+= native.o
>> +obj-$(CONFIG_PPC_XIVE_SPAPR)	+= spapr.o
>> diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
>> new file mode 100644
>> index 000000000000..a3668815d5c1
>> --- /dev/null
>> +++ b/arch/powerpc/sysdev/xive/spapr.c
>> @@ -0,0 +1,554 @@
>> +/*
>> + * Copyright 2016,2017 IBM Corporation.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + */
>> +
>> +#define pr_fmt(fmt) "xive: " fmt
>> +
>> +#include <linux/types.h>
>> +#include <linux/irq.h>
>> +#include <linux/smp.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/init.h>
>> +#include <linux/of.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/cpumask.h>
>> +#include <linux/mm.h>
>> +
>> +#include <asm/prom.h>
>> +#include <asm/io.h>
>> +#include <asm/smp.h>
>> +#include <asm/irq.h>
>> +#include <asm/errno.h>
>> +#include <asm/xive.h>
>> +#include <asm/xive-regs.h>
>> +#include <asm/hvcall.h>
>> +
>> +#include "xive-internal.h"
>> +
>> +static u32 xive_queue_shift;
>> +
>> +struct xive_irq_bitmap {
>> +	unsigned long		*bitmap;
>> +	unsigned int		base;
>> +	unsigned int		count;
>> +	spinlock_t		lock;
>> +	struct list_head	list;
>> +};
>> +
>> +static LIST_HEAD(xive_irq_bitmaps);
>> +
>> +static int xive_irq_bitmap_add(int base, int count)
>> +{
>> +	struct xive_irq_bitmap *xibm;
>> +
>> +	xibm = kzalloc(sizeof(*xibm), GFP_ATOMIC);
>> +	if (!xibm)
>> +		return -ENOMEM;
>> +
>> +	spin_lock_init(&xibm->lock);
>> +	xibm->base = base;
>> +	xibm->count = count;
>> +	xibm->bitmap = kzalloc(xibm->count, GFP_KERNEL);
>> +	list_add(&xibm->list, &xive_irq_bitmaps);
>> +
>> +	pr_info("Using IRQ range [%x-%x]", xibm->base,
>> +		xibm->base + xibm->count - 1);
>> +	return 0;
>> +}
>> +
>> +static int __xive_irq_bitmap_alloc(struct xive_irq_bitmap *xibm)
>> +{
>> +	int irq;
>> +
>> +	irq = find_first_zero_bit(xibm->bitmap, xibm->count);
>> +	if (irq != xibm->count) {
>> +		set_bit(irq, xibm->bitmap);
>> +		irq += xibm->base;
>> +	} else {
>> +		irq = -ENOMEM;
>> +	}
>> +
>> +	return irq;
>> +}
>> +
>> +static int xive_irq_bitmap_alloc(void)
>> +{
>> +	struct xive_irq_bitmap *xibm;
>> +	unsigned long flags;
>> +	int irq = -ENOENT;
>> +
>> +	list_for_each_entry(xibm, &xive_irq_bitmaps, list) {
>> +		spin_lock_irqsave(&xibm->lock, flags);
>> +		irq = __xive_irq_bitmap_alloc(xibm);
>> +		spin_unlock_irqrestore(&xibm->lock, flags);
>> +		if (irq >= 0)
>> +			break;
>> +	}
>> +	return irq;
>> +}
>> +
>> +static void xive_irq_bitmap_free(int irq)
>> +{
>> +	unsigned long flags;
>> +	struct xive_irq_bitmap *xibm;
>> +
>> +	list_for_each_entry(xibm, &xive_irq_bitmaps, list) {
>> +		if ((irq >= xibm->base) && (irq < xibm->base + xibm->count)) {
>> +			spin_lock_irqsave(&xibm->lock, flags);
>> +			clear_bit(irq - xibm->base, xibm->bitmap);
>> +			spin_unlock_irqrestore(&xibm->lock, flags);
>> +			break;
>> +		}
>> +	}
>> +}
>> +
>> +static long plpar_int_get_source_info(unsigned long flags,
>> +				      unsigned long lisn,
>> +				      unsigned long *src_flags,
>> +				      unsigned long *eoi_page,
>> +				      unsigned long *trig_page,
>> +				      unsigned long *esb_shift)
>> +{
>> +	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
>> +	long rc;
>> +
>> +	rc = plpar_hcall(H_INT_GET_SOURCE_INFO, retbuf, flags, lisn);
>> +	if (rc) {
>> +		pr_err("H_INT_GET_SOURCE_INFO lisn=%ld failed %ld\n", lisn, rc);
>> +		return rc;
>> +	}
>> +
>> +	*src_flags = retbuf[0];
>> +	*eoi_page  = retbuf[1];
>> +	*trig_page = retbuf[2];
>> +	*esb_shift = retbuf[3];
>> +
>> +	pr_devel("H_INT_GET_SOURCE_INFO flags=%lx eoi=%lx trig=%lx shift=%lx\n",
>> +		retbuf[0], retbuf[1], retbuf[2], retbuf[3]);
>> +
>> +	return 0;
>> +}
>> +
>> +#define XIVE_SRC_SET_EISN (1ull << (63 - 62))
>> +#define XIVE_SRC_MASK     (1ull << (63 - 63)) /* unused */
>> +
>> +static long plpar_int_set_source_config(unsigned long flags,
>> +					unsigned long lisn,
>> +					unsigned long target,
>> +					unsigned long prio,
>> +					unsigned long sw_irq)
>> +{
>> +	long rc;
>> +
>> +
>> +	pr_devel("H_INT_SET_SOURCE_CONFIG flags=%lx lisn=%lx target=%lx prio=%lx sw_irq=%lx\n",
>> +		flags, lisn, target, prio, sw_irq);
>> +
>> +
>> +	rc = plpar_hcall_norets(H_INT_SET_SOURCE_CONFIG, flags, lisn,
>> +				target, prio, sw_irq);
>> +	if (rc) {
>> +		pr_err("H_INT_SET_SOURCE_CONFIG lisn=%ld failed %ld\n",
>> +		       lisn, rc);
>> +		return rc;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static long plpar_int_get_queue_info(unsigned long flags,
>> +				     unsigned long target,
>> +				     unsigned long priority,
>> +				     unsigned long *esn_page,
>> +				     unsigned long *esn_size)
>> +{
>> +	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
>> +	long rc;
>> +
>> +	rc = plpar_hcall(H_INT_GET_QUEUE_INFO, retbuf, flags, target, priority);
>> +	if (rc) {
>> +		pr_err("H_INT_GET_QUEUE_INFO cpu=%ld prio=%ld failed %ld\n",
>> +		       target, priority, rc);
>> +		return rc;
>> +	}
>> +
>> +	*esn_page = retbuf[0];
>> +	*esn_size = retbuf[1];
>> +
>> +	pr_devel("H_INT_GET_QUEUE_INFO page=%lx size=%lx\n",
>> +		retbuf[0], retbuf[1]);
>> +
>> +	return 0;
>> +}
>> +
>> +#define XIVE_EQ_ALWAYS_NOTIFY (1ull << (63 - 63))
>> +
>> +static long plpar_int_set_queue_config(unsigned long flags,
>> +				       unsigned long target,
>> +				       unsigned long priority,
>> +				       unsigned long qpage,
>> +				       unsigned long qsize)
>> +{
>> +	long rc;
>> +
>> +	pr_devel("H_INT_SET_QUEUE_CONFIG flags=%lx target=%lx priority=%lx qpage=%lx qsize=%lx\n",
>> +		flags,  target, priority, qpage, qsize);
>> +
>> +	rc = plpar_hcall_norets(H_INT_SET_QUEUE_CONFIG, flags, target,
>> +				priority, qpage, qsize);
>> +	if (rc) {
>> +		pr_err("H_INT_SET_QUEUE_CONFIG cpu=%ld prio=%ld qpage=%lx returned %ld\n",
>> +		       target, priority, qpage, rc);
>> +		return  rc;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static long plpar_int_sync(unsigned long flags)
>> +{
>> +	long rc;
>> +
>> +	rc = plpar_hcall_norets(H_INT_SYNC, flags);
>> +	if (rc) {
>> +		pr_err("H_INT_SYNC returned %ld\n", rc);
>> +		return  rc;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +#define XIVE_SRC_H_INT_ESB     (1ull << (63 - 60)) /* TODO */
>> +#define XIVE_SRC_LSI           (1ull << (63 - 61))
>> +#define XIVE_SRC_TRIGGER       (1ull << (63 - 62))
>> +#define XIVE_SRC_STORE_EOI     (1ull << (63 - 63))
>> +
>> +static int xive_spapr_populate_irq_data(u32 hw_irq, struct xive_irq_data *data)
>> +{
>> +	long rc;
>> +	unsigned long flags;
>> +	unsigned long eoi_page;
>> +	unsigned long trig_page;
>> +	unsigned long esb_shift;
>> +
>> +	memset(data, 0, sizeof(*data));
>> +
>> +	rc = plpar_int_get_source_info(0, hw_irq, &flags, &eoi_page, &trig_page,
>> +				       &esb_shift);
>> +	if (rc)
>> +		return  -EINVAL;
>> +
>> +	if (flags & XIVE_SRC_STORE_EOI)
>> +		data->flags  |= XIVE_IRQ_FLAG_STORE_EOI;
>> +	if (flags & XIVE_SRC_LSI)
>> +		data->flags  |= XIVE_IRQ_FLAG_LSI;
>> +	data->eoi_page  = eoi_page;
>> +	data->esb_shift = esb_shift;
>> +	data->trig_page = trig_page;
>> +
>> +	/*
>> +	 * No chip-id for the sPAPR backend. This has an impact how we
>> +	 * pick a target. See xive_pick_irq_target().
>> +	 */
>> +	data->src_chip = XIVE_INVALID_CHIP_ID;
>> +
>> +	data->eoi_mmio = ioremap(data->eoi_page, 1u << data->esb_shift);
>> +	if (!data->eoi_mmio) {
>> +		pr_err("Failed to map EOI page for irq 0x%x\n", hw_irq);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	/* Full function page supports trigger */
>> +	if (flags & XIVE_SRC_TRIGGER) {
>> +		data->trig_mmio = data->eoi_mmio;
>> +		return 0;
>> +	}
>> +
>> +	data->trig_mmio = ioremap(data->trig_page, 1u << data->esb_shift);
>> +	if (!data->trig_mmio) {
>> +		pr_err("Failed to map trigger page for irq 0x%x\n", hw_irq);
>> +		return -ENOMEM;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int xive_spapr_configure_irq(u32 hw_irq, u32 target, u8 prio, u32 sw_irq)
>> +{
>> +	long rc;
>> +
>> +	rc = plpar_int_set_source_config(XIVE_SRC_SET_EISN, hw_irq, target,
>> +					 prio, sw_irq);
>> +
>> +	return rc == 0 ? 0 : -ENXIO;
>> +}
>> +
>> +/* This can be called multiple time to change a queue configuration */
>> +static int xive_spapr_configure_queue(u32 target, struct xive_q *q, u8 prio,
>> +				   __be32 *qpage, u32 order)
>> +{
>> +	s64 rc = 0;
>> +	unsigned long esn_page;
>> +	unsigned long esn_size;
>> +	u64 flags, qpage_phys;
>> +
>> +	/* If there's an actual queue page, clean it */
>> +	if (order) {
>> +		if (WARN_ON(!qpage))
>> +			return -EINVAL;
>> +		qpage_phys = __pa(qpage);
>> +	} else {
>> +		qpage_phys = 0;
>> +	}
>> +
>> +	/* Initialize the rest of the fields */
>> +	q->msk = order ? ((1u << (order - 2)) - 1) : 0;
>> +	q->idx = 0;
>> +	q->toggle = 0;
>> +
>> +	rc = plpar_int_get_queue_info(0, target, prio, &esn_page, &esn_size);
>> +	if (rc) {
>> +		pr_err("Error %lld getting queue info prio %d\n", rc, prio);
>> +		rc = -EIO;
>> +		goto fail;
>> +	}
>> +
>> +	/* TODO: add support for the notification page */
>> +	q->eoi_phys = esn_page;
>> +
>> +	/* Default is to always notify */
>> +	flags = XIVE_EQ_ALWAYS_NOTIFY;
>> +
>> +	/* Configure and enable the queue in HW */
>> +	rc = plpar_int_set_queue_config(flags, target, prio, qpage_phys, order);
>> +	if (rc) {
>> +		pr_err("Error %lld setting queue for prio %d\n", rc, prio);
>> +		rc = -EIO;
>> +	} else {
>> +		q->qpage = qpage;
>> +	}
>> +fail:
>> +	return rc;
>> +}
>> +
>> +static int xive_spapr_setup_queue(unsigned int cpu, struct xive_cpu *xc,
>> +				  u8 prio)
>> +{
>> +	struct xive_q *q = &xc->queue[prio];
>> +	unsigned int alloc_order;
>> +	struct page *pages;
>> +	__be32 *qpage;
>> +
>> +	alloc_order = (xive_queue_shift > PAGE_SHIFT) ?
>> +		(xive_queue_shift - PAGE_SHIFT) : 0;
>> +	pages = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, alloc_order);
>> +	if (!pages)
>> +		return -ENOMEM;
>> +	qpage = (__be32 *)page_address(pages);
>> +	memset(qpage, 0, 1 << xive_queue_shift);
>> +
>> +	return xive_spapr_configure_queue(cpu, q, prio, qpage,
>> +					  xive_queue_shift);
>> +}
>> +
>> +static void xive_spapr_cleanup_queue(unsigned int cpu, struct xive_cpu *xc,
>> +				  u8 prio)
>> +{
>> +	struct xive_q *q = &xc->queue[prio];
>> +	unsigned int alloc_order;
>> +	long rc;
>> +
>> +	rc = plpar_int_set_queue_config(0, cpu, prio, 0, 0);
>> +	if (rc)
>> +		pr_err("Error %ld setting queue for prio %d\n", rc, prio);
>> +
>> +	alloc_order = (xive_queue_shift > PAGE_SHIFT) ?
>> +		(xive_queue_shift - PAGE_SHIFT) : 0;
> 
> Maybe a helper inline for this calculation, since it's used in both
> setup_queue() and cleanup_queue?

yes. 

The xive_spapr_setup_queue() and xive_native_setup_queue() 
routines have a lot in common. So do xive_spapr_setup_queue() 
and xive_native_setup_queue(). I will try to move some of
the common code in the xive frontend.


>> +	free_pages((unsigned long)q->qpage, alloc_order);
>> +	q->qpage = NULL;
>> +}
>> +
>> +static bool xive_spapr_match(struct device_node *node)
>> +{
>> +	return 1;
>> +}
>> +
>> +#ifdef CONFIG_SMP
>> +static int xive_spapr_get_ipi(unsigned int cpu, struct xive_cpu *xc)
>> +{
>> +	int irq = xive_irq_bitmap_alloc();
>> +
>> +	if (irq < 0) {
>> +		pr_err("Failed to allocate IPI on CPU %d\n", cpu);
>> +		return -ENXIO;
>> +	}
>> +
>> +	xc->hw_ipi = irq;
>> +	return 0;
>> +}
>> +
>> +static void xive_spapr_put_ipi(unsigned int cpu, struct xive_cpu *xc)
>> +{
>> +	xive_irq_bitmap_free(xc->hw_ipi);
>> +}
>> +#endif /* CONFIG_SMP */
>> +
>> +static void xive_spapr_shutdown(void)
>> +{
>> +	long rc;
>> +
>> +	rc = plpar_hcall_norets(H_INT_RESET, 0);
>> +	if (rc)
>> +		pr_err("H_INT_RESET failed %ld\n", rc);
>> +}
>> +
>> +static void xive_spapr_update_pending(struct xive_cpu *xc)
>> +{
>> +	u8 nsr, cppr;
>> +	u16 ack;
>> +
>> +	/* Perform the acknowledge hypervisor to register cycle */
>> +	ack = be16_to_cpu(__raw_readw(xive_tima + TM_SPC_ACK_OS_REG));
> 
> Why do you need the raw_readw() + be16_to_cpu + mb, rather than one of
> the higher level IO helpers?

This is one of the many ways to do MMIOs on the TIMA. This memory 
region defines a set of offsets and sizes for which loads and 
stores have different effects. 

See the arch/powerpc/include/asm/xive-regs.h file and 
arch/powerpc/kvm/book3s_xive_template.c for some more usage.

maybe we could add some helpers. 
     
> 
>> +	/* Synchronize subsequent queue accesses */
>> +	mb();
>> +
>> +	/*
>> +	 * Grab the CPPR and the "NSR" field which indicates the source
>> +	 * of the hypervisor interrupt (if any)
>> +	 */
>> +	cppr = ack & 0xff;
>> +	nsr = ack >> 8;
>> +
>> +	if (nsr & TM_QW1_NSR_EO) {
>> +		if (cppr == 0xff)
>> +			return;
>> +		/* Mark the priority pending */
>> +		xc->pending_prio |= 1 << cppr;
>> +
>> +		/*
>> +		 * A new interrupt should never have a CPPR less favored
>> +		 * than our current one.
>> +		 */
>> +		if (cppr >= xc->cppr)
>> +			pr_err("CPU %d odd ack CPPR, got %d at %d\n",
>> +			       smp_processor_id(), cppr, xc->cppr);
>> +
>> +		/* Update our idea of what the CPPR is */
>> +		xc->cppr = cppr;
>> +	}
>> +}
>> +
>> +static void xive_spapr_eoi(u32 hw_irq)
>> +{
>> +	/* Not used */;
>> +}
> 
> Do you really want empty stub functions, or would it be better to have
> the method caller check for NULL in the ops structure?

Ben had some comment saying that we could use this eoi op for 
interrupts needing H_INT_ESB. I am not sure this is the case 
anymore with the framework I propose in the following patches.
That said, I will have to implement in QEMU interrupt sources 
needing this flag in order to test. phyp won't implement it.

Nevertheless I can add a check for NULL.

Thanks,c

C.

>> +
>> +static void xive_spapr_setup_cpu(unsigned int cpu, struct xive_cpu *xc)
>> +{
>> +	/* Only some debug on the TIMA settings */
>> +	pr_debug("(HW value: %08x %08x %08x)\n",
>> +		 in_be32(xive_tima + TM_QW1_OS + TM_WORD0),
>> +		 in_be32(xive_tima + TM_QW1_OS + TM_WORD1),
>> +		 in_be32(xive_tima + TM_QW1_OS + TM_WORD2));
>> +}
>> +
>> +static void xive_spapr_teardown_cpu(unsigned int cpu, struct xive_cpu *xc)
>> +{
>> +	/* Nothing to do */;
>> +}
>> +
>> +static void xive_spapr_sync_source(u32 hw_irq)
>> +{
>> +	/* Specs are unclear on what this is doing */
>> +	plpar_int_sync(0);
>> +}
>> +
>> +static const struct xive_ops xive_spapr_ops = {
>> +	.populate_irq_data	= xive_spapr_populate_irq_data,
>> +	.configure_irq		= xive_spapr_configure_irq,
>> +	.setup_queue		= xive_spapr_setup_queue,
>> +	.cleanup_queue		= xive_spapr_cleanup_queue,
>> +	.match			= xive_spapr_match,
>> +	.shutdown		= xive_spapr_shutdown,
>> +	.update_pending		= xive_spapr_update_pending,
>> +	.eoi			= xive_spapr_eoi,
>> +	.setup_cpu		= xive_spapr_setup_cpu,
>> +	.teardown_cpu		= xive_spapr_teardown_cpu,
>> +	.sync_source		= xive_spapr_sync_source,
>> +#ifdef CONFIG_SMP
>> +	.get_ipi		= xive_spapr_get_ipi,
>> +	.put_ipi		= xive_spapr_put_ipi,
>> +#endif /* CONFIG_SMP */
>> +	.name			= "spapr",
>> +};
>> +
>> +bool xive_spapr_init(void)
>> +{
>> +	struct device_node *np;
>> +	struct resource r;
>> +	void __iomem *tima;
>> +	struct property *prop;
>> +	u8 max_prio = 7;
>> +	u32 val;
>> +	u32 len;
>> +	const __be32 *reg;
>> +	int i;
>> +
>> +	if (xive_cmdline_disabled)
>> +		return false;
>> +
>> +	pr_devel("%s()\n", __func__);
>> +	np = of_find_compatible_node(NULL, NULL, "ibm,power-ivpe");
>> +	if (!np) {
>> +		pr_devel("not found !\n");
>> +		return false;
>> +	}
>> +	pr_devel("Found %s\n", np->full_name);
>> +
>> +	/* Resource 1 is the OS ring TIMA */
>> +	if (of_address_to_resource(np, 1, &r)) {
>> +		pr_err("Failed to get thread mgmnt area resource\n");
>> +		return false;
>> +	}
>> +	tima = ioremap(r.start, resource_size(&r));
>> +	if (!tima) {
>> +		pr_err("Failed to map thread mgmnt area\n");
>> +		return false;
>> +	}
>> +
>> +	/* Feed the IRQ number allocator with the ranges given in the DT */
>> +	reg = of_get_property(np, "ibm,xive-lisn-ranges", &len);
>> +	if (!reg) {
>> +		pr_err("Failed to read 'ibm,xive-lisn-ranges' property\n");
>> +		return false;
>> +	}
>> +
>> +	if (len % (2 * sizeof(u32)) != 0) {
>> +		pr_err("invalid 'ibm,xive-lisn-ranges' property\n");
>> +		return false;
>> +	}
>> +
>> +	for (i = 0; i < len / (2 * sizeof(u32)); i++, reg += 2)
>> +		xive_irq_bitmap_add(be32_to_cpu(reg[0]),
>> +				    be32_to_cpu(reg[1]));
>> +
>> +	/* Iterate the EQ sizes and pick one */
>> +	of_property_for_each_u32(np, "ibm,xive-eq-sizes", prop, reg, val) {
>> +		xive_queue_shift = val;
>> +		if (val == PAGE_SHIFT)
>> +			break;
>> +	}
>> +
>> +	/* Initialize XIVE core with our backend */
>> +	if (!xive_core_init(&xive_spapr_ops, tima, TM_QW1_OS, max_prio))
>> +		return false;
>> +
>> +	pr_info("Using %dkB queues\n", 1 << (xive_queue_shift - 10));
>> +	return true;
>> +}
> 
