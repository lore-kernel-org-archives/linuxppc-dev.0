Return-Path: <clg@kaod.org>
Received: from 11.mo6.mail-out.ovh.net (11.mo6.mail-out.ovh.net
 [188.165.38.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wvPNR2nSCzDqjB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jun 2017 02:41:27 +1000 (AEST)
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 5377DF274D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 15:05:56 +0200 (CEST)
Subject: Re: [RFC PATCH 1/2] powerpc/xive: guest exploitation of the XIVE
 interrupt controller
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
References: <1498123757-18427-1-git-send-email-clg@kaod.org>
 <1498123757-18427-2-git-send-email-clg@kaod.org>
 <1498134010.31581.71.camel@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <590a98df-05df-f923-d665-fd8d77d427d9@kaod.org>
Date: Fri, 23 Jun 2017 15:05:48 +0200
MIME-Version: 1.0
In-Reply-To: <1498134010.31581.71.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/22/2017 02:20 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2017-06-22 at 11:29 +0200, Cédric Le Goater wrote:
>> This is the framework for using XIVE in a PowerVM guest. The support
>> is very similar to the native one in a much simpler form.
> 
> Looks really good. Minor nits & comments...
> 
>> Instead of OPAL calls, a set of Hypervisors call are used to configure
>> the interrupt sources and the event/notification queues of the guest:
>>
>>    H_INT_GET_SOURCE_INFO
>>    H_INT_SET_SOURCE_CONFIG
>>    H_INT_GET_SOURCE_CONFIG
>>    H_INT_GET_QUEUE_INFO
>>    H_INT_SET_QUEUE_CONFIG
>>    H_INT_GET_QUEUE_CONFIG
>>    H_INT_RESET
> 
> There are the base ones.
> 
>> Calls that still need to be addressed :
>>
>>    H_INT_SET_OS_REPORTING_LINE
>>    H_INT_GET_OS_REPORTING_LINE
> 
> Ah so those have to do with that magic cache line you can register with
> the HW so that when you get an interrupt, you can do an MMIO store very
> early on in the interrupt entry path to the XIVE, which will
> asynchronously write the NSR etc... to that cache line which you can
> then poke at later one.
>
> I don't know if it's worth exploiting in Linux, but we should support
> it in qemu/kvm.
 
>From a QEMU point of view, it's not a big deal I think. I just haven't 
introduced a NVT structure yet, which would be needed to hold the address 
of the reporting cache line, or something similar.

>>    H_INT_ESB
> 
> This is a h-call that performs the basic ESB operations. Some
> interrupts can have a flag telling the OS to do the operations using
> that hcall rather than directly. This can be used to workaround HW
> issues with some interrupts sources if needed.

The hcall is implemented in QEMU. It has a lot in common with the 
MMIO, that's why. For Linux, it should not require too much changes.
We could use a XIVE_IRQ_FLAG_H_INT_ESB flag in xive_poke_esb() to do 
the hcall instead of the out* calls.

xive_do_source_eoi() needs some wrapper calls around ->eoi_mmio also.

> 
>>    H_INT_SYNC
> 
> This will be needed for queue accounting in some cases, such as CPU
> hotplug I think etc... For example if you mask an interrupt in the ESB,
> a sync will ensure that any previous occurrence of this interrupt has
> reached its target queue (and thus is visible in memory).

ok. The way this will be handled is still a little fuzzy for me. I need
to study the question. 

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
>> This is work in progress. It was only tested with a QEMU XIVE model
>> for pseries.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  arch/powerpc/include/asm/hvcall.h      |  13 +-
>>  arch/powerpc/include/asm/xive.h        |   1 +
>>  arch/powerpc/platforms/pseries/Kconfig |   1 +
>>  arch/powerpc/platforms/pseries/setup.c |   8 +-
>>  arch/powerpc/platforms/pseries/smp.c   |  18 +-
>>  arch/powerpc/sysdev/xive/Kconfig       |   5 +
>>  arch/powerpc/sysdev/xive/Makefile      |   1 +
>>  arch/powerpc/sysdev/xive/xive-hv.c     | 523 +++++++++++++++++++++++++++++++++
>>  8 files changed, 566 insertions(+), 4 deletions(-)
>>  create mode 100644 arch/powerpc/sysdev/xive/xive-hv.c
>>
>> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
>> index d73755fafbb0..3c019e9f451a 100644
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
>> index c23ff4389ca2..c947952ed934 100644
>> --- a/arch/powerpc/include/asm/xive.h
>> +++ b/arch/powerpc/include/asm/xive.h
>> @@ -110,6 +110,7 @@ extern bool __xive_enabled;
>>  
>>  static inline bool xive_enabled(void) { return __xive_enabled; }
>>  
>> +extern bool xive_hv_init(void);
>>  extern bool xive_native_init(void);
>>  extern void xive_smp_probe(void);
>>  extern int  xive_smp_prepare_cpu(unsigned int cpu);
>> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
>> index 913c54e23eea..4eec0283f043 100644
>> --- a/arch/powerpc/platforms/pseries/Kconfig
>> +++ b/arch/powerpc/platforms/pseries/Kconfig
>> @@ -7,6 +7,7 @@ config PPC_PSERIES
>>  	select PCI
>>  	select PCI_MSI
>>  	select PPC_XICS
>> +	select PPC_XIVE_HV
>>  	select PPC_ICP_NATIVE
>>  	select PPC_ICP_HV
>>  	select PPC_ICS_RTAS
>> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
>> index b5d86426e97b..53bad49b84be 100644
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
>> +	if (!xive_hv_init()) {
>> +		xics_init();
>> +		pseries_setup_i8259_cascade();
>> +	}
>>  }
>>  
>>  static void pseries_lpar_enable_pmcs(void)
>> diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
>> index 52ca6b311d44..3c53ca1d7f85 100644
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
>> @@ -180,6 +183,13 @@ static int smp_pSeries_kick_cpu(int nr)
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
>>  static void smp_pseries_cause_ipi(int cpu)
>>  {
>>  	/* POWER9 should not use this handler */
>> @@ -212,6 +222,11 @@ static int pseries_cause_nmi_ipi(int cpu)
>>  
>>  static __init void pSeries_smp_probe(void)
>>  {
>> +	if (xive_enabled()) {
>> +		xive_smp_probe();
>> +		return;
>> +	}
>> +
>>  	xics_smp_probe();
>>  
>>  	if (cpu_has_feature(CPU_FTR_DBELL))
>> @@ -225,6 +240,7 @@ static struct smp_ops_t pseries_smp_ops = {
>>  	.cause_ipi	= NULL,	/* Filled at runtime by pSeries_smp_probe() */
>>  	.cause_nmi_ipi	= pseries_cause_nmi_ipi,
>>  	.probe		= pSeries_smp_probe,
>> +	.prepare_cpu	= pseries_smp_prepare_cpu,
>>  	.kick_cpu	= smp_pSeries_kick_cpu,
>>  	.setup_cpu	= smp_setup_cpu,
>>  	.cpu_bootable	= smp_generic_cpu_bootable,
>> diff --git a/arch/powerpc/sysdev/xive/Kconfig b/arch/powerpc/sysdev/xive/Kconfig
>> index 12ccd7373d2f..85486e6c279e 100644
>> --- a/arch/powerpc/sysdev/xive/Kconfig
>> +++ b/arch/powerpc/sysdev/xive/Kconfig
>> @@ -9,3 +9,8 @@ config PPC_XIVE_NATIVE
>>  	default n
>>  	select PPC_XIVE
>>  	depends on PPC_POWERNV
>> +
>> +config PPC_XIVE_HV
>> +	bool
>> +	default n
>> +	select PPC_XIVE
>> diff --git a/arch/powerpc/sysdev/xive/Makefile b/arch/powerpc/sysdev/xive/Makefile
>> index 3fab303fc169..c443dfac6e6b 100644
>> --- a/arch/powerpc/sysdev/xive/Makefile
>> +++ b/arch/powerpc/sysdev/xive/Makefile
>> @@ -2,3 +2,4 @@ subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
>>  
>>  obj-y				+= common.o
>>  obj-$(CONFIG_PPC_XIVE_NATIVE)	+= native.o
>> +obj-$(CONFIG_PPC_XIVE_HV)	+= xive-hv.o
>> diff --git a/arch/powerpc/sysdev/xive/xive-hv.c b/arch/powerpc/sysdev/xive/xive-hv.c
>> new file mode 100644
>> index 000000000000..3adfcff9800f
>> --- /dev/null
>> +++ b/arch/powerpc/sysdev/xive/xive-hv.c
> 
> I would call it "papr.c" or "guest.c" by opposition to "native.c",
> ditch the xive_ prefix.

ok. I have chosen spapr.c

>> @@ -0,0 +1,523 @@
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
>> +#include <linux/debugfs.h>
>> +#include <linux/smp.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/seq_file.h>
>> +#include <linux/init.h>
>> +#include <linux/of.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/delay.h>
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
>> +	pr_info("Using LISN range [ %d - %d ]", xibm->base,
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
>> +#define XIVE_SRC_H_INT_ESB     (1ull << (63 - 60)) /* TODO */
>> +#define XIVE_SRC_LSI           (1ull << (63 - 61))
>> +#define XIVE_SRC_TRIGGER_PAGE  (1ull << (63 - 62))
>> +#define XIVE_SRC_STORE_EOI     (1ull << (63 - 63))
> 
> Those are PAPR specific definitions, we can keep them here but they
> could also go in a common place and be prefixed appropriately, up
> to you.

yes. I am not sure where to put them. in : 

	arch/powerpc/include/asm/xive.h
?

or may be in a new file as these define will be used by the hcalls 
in kvm also.

>> +static int xive_hv_populate_irq_data(u32 hw_irq, struct xive_irq_data *data)
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
>> +	if (flags & XIVE_SRC_TRIGGER_PAGE)
>> +		data->trig_page = trig_page;
>> +
>> +	data->eoi_mmio = ioremap(data->eoi_page, 1u << data->esb_shift);
>> +	if (!data->eoi_mmio) {
>> +		pr_err("Failed to map EOI page for irq 0x%x\n", hw_irq);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	if (!data->trig_page)
>> +		return 0;
>> +
>> +	data->trig_mmio = ioremap(data->trig_page, 1u << data->esb_shift);
>> +	if (!data->trig_mmio) {
>> +		pr_err("Failed to map trigger page for irq 0x%x\n", hw_irq);
>> +		return -ENOMEM;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int xive_hv_configure_irq(u32 hw_irq, u32 target, u8 prio, u32 sw_irq)
>> +{
>> +	long rc;
>> +
>> +	rc = plpar_int_set_source_config(XIVE_SRC_SET_EISN, hw_irq, target,
>> +					 prio, sw_irq);
>> +
>> +	return rc == 0 ? 0 : -ENXIO;
>> +}
>>
> Double check if these guys can return the special return code that
> says "wait & try again later"... Same with queue config actually.

the specs says that the syncs are done to complete the in-flight 
interrupts before returning H_SUCCESS. So I think we are fine.
 
>> +/* This can be called multiple time to change a queue configuration */
>> +static int xive_hv_configure_queue(u32 target, struct xive_q *q, u8 prio,
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
>> +	q->eoi_phys = be64_to_cpu(esn_page);
>> +
>> +	/* Default flags */
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
>> +static int xive_hv_setup_queue(unsigned int cpu, struct xive_cpu *xc, u8 prio)
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
>> +	return xive_hv_configure_queue(cpu, q, prio, qpage, xive_queue_shift);
>> +}
>> +
>> +static void xive_hv_cleanup_queue(unsigned int cpu, struct xive_cpu *xc,
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
>> +	free_pages((unsigned long)q->qpage, alloc_order);
>> +	q->qpage = NULL;
>> +}
>> +
>> +static bool xive_hv_match(struct device_node *node)
>> +{
> 
> Hrm ... I suppose so... as long as we don't play with cascaded
> controllers.

OK. I just made it "work" for the moment and didn't dig in the 
consequences yet.

>> +	return 1;
>> +}
>> +
>> +#ifdef CONFIG_SMP
>> +static int xive_hv_get_ipi(unsigned int cpu, struct xive_cpu *xc)
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
>> +static void xive_hv_put_ipi(unsigned int cpu, struct xive_cpu *xc)
>> +{
>> +	xive_irq_bitmap_free(xc->hw_ipi);
>> +}
>> +#endif /* CONFIG_SMP */
>> +
>> +static void xive_hv_shutdown(void)
>> +{
>> +	long rc;
>> +
>> +	rc = plpar_hcall_norets(H_INT_RESET, 0);
>> +	if (rc)
>> +		pr_err("H_INT_RESET failed %ld\n", rc);
>> +}
>> +
>> +static void xive_hv_update_pending(struct xive_cpu *xc)
>> +{
>> +	u8 nsr, cppr;
>> +	u16 ack;
>> +
>> +	/* Perform the acknowledge hypervisor to register cycle */
>> +	ack = be16_to_cpu(__raw_readw(xive_tima + TM_SPC_ACK_OS_REG));
>> +
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
>> +static void xive_hv_eoi(u32 hw_irq)
>> +{
>> +	/* Not used */;
>> +}
> 
> The above could be used for interrupts that need H_INT_ESB... Due to
> how that was architected in PAPR though, I'm thinking we might want to
> review the abstraction a bit between front-end and back-end to provide
> something at the ESB ops level. 

Do you mean exposing the xive_poke_esb() call and friends to the 
backends ? or something more complex than what I have described above ? 

> Not that anything uses that feature yet :-) 
> (DD1.0 implementations might but I don't think they'll exist).
>
>> +static void xive_hv_setup_cpu(unsigned int cpu, struct xive_cpu *xc)
>> +{
>> +	pr_debug("(Old HW value: %08x)\n",
>> +		 in_be32(xive_tima + TM_QW1_OS + TM_WORD2));
>> +
>> +	/* set LSMFB to 0xff to skip backlog scan) */
>> +	out_be32(xive_tima + TM_QW1_OS + TM_WORD0, 0xff);
>> +
>> +	/* TODO: set TM_QW1W2_OS_CAM ?  */;
> 
> What do you mean ? The OS CAM is set by the hypervisor when switching
> us in, or am I missing something ?

no. It's me. I am still learning on this part.
 
>> +	pr_debug("(New HW value: %08x)\n",
>> +		 in_be32(xive_tima + TM_QW1_OS + TM_WORD2));
>> +}
>> +
>> +static void xive_hv_teardown_cpu(unsigned int cpu, struct xive_cpu *xc)
>> +{
>> +	/* Nothing to do */;
>> +}
>> +
>> +void xive_hv_sync_source(u32 hw_irq)
>> +{
>> +	/* TODO: I am not sure this is needed ? */;
> 
> It can be, you should implement it.

ok. I see what is done for OPAL but for sPAPR it is not clear. 

Thanks,

C.

>> +}
>> +EXPORT_SYMBOL_GPL(xive_hv_sync_source);
>> +
>> +static const struct xive_ops xive_hv_ops = {
>> +	.populate_irq_data	= xive_hv_populate_irq_data,
>> +	.configure_irq		= xive_hv_configure_irq,
>> +	.setup_queue		= xive_hv_setup_queue,
>> +	.cleanup_queue		= xive_hv_cleanup_queue,
>> +	.match			= xive_hv_match,
>> +	.shutdown		= xive_hv_shutdown,
>> +	.update_pending		= xive_hv_update_pending,
>> +	.eoi			= xive_hv_eoi,
>> +	.setup_cpu		= xive_hv_setup_cpu,
>> +	.teardown_cpu		= xive_hv_teardown_cpu,
>> +	.sync_source		= xive_hv_sync_source,
>> +#ifdef CONFIG_SMP
>> +	.get_ipi		= xive_hv_get_ipi,
>> +	.put_ipi		= xive_hv_put_ipi,
>> +#endif /* CONFIG_SMP */
>> +	.name			= "hv",
>> +};
>> +
>> +bool xive_hv_init(void)
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
>> +	if (!xive_core_init(&xive_hv_ops, tima, TM_QW1_OS, max_prio))
>> +		return false;
>> +
>> +	pr_info("Using %dkB queues\n", 1 << (xive_queue_shift - 10));
>> +	return true;
>> +}
