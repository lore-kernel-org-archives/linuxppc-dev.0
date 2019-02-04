Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE22EC282CB
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 11:29:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A1920815
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 11:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A1920815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tQTP1N6vzDqDN
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 22:29:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.72.44; helo=9.mo173.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 9.mo173.mail-out.ovh.net (9.mo173.mail-out.ovh.net
 [46.105.72.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tQRR3ntfzDqCX
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 22:27:31 +1100 (AEDT)
Received: from player158.ha.ovh.net (unknown [10.109.160.239])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 19CC6F20C5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 12:19:17 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player158.ha.ovh.net (Postfix) with ESMTPSA id 9EBA123C3542;
 Mon,  4 Feb 2019 11:19:07 +0000 (UTC)
Subject: Re: [PATCH 05/19] KVM: PPC: Book3S HV: add a new KVM device for the
 XIVE native exploitation mode
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-6-clg@kaod.org> <20190204042559.GA1927@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a4355ddf-462e-57d0-c225-7cd7d02a5482@kaod.org>
Date: Mon, 4 Feb 2019 12:19:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204042559.GA1927@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2284732385990445959
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrkeeggddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2/4/19 5:25 AM, David Gibson wrote:
> On Mon, Jan 07, 2019 at 07:43:17PM +0100, Cédric Le Goater wrote:
>> This is the basic framework for the new KVM device supporting the XIVE
>> native exploitation mode. The user interface exposes a new capability
>> and a new KVM device to be used by QEMU.
>>
>> Internally, the interface to the new KVM device is protected with a
>> new interrupt mode: KVMPPC_IRQ_XIVE.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  arch/powerpc/include/asm/kvm_host.h   |   2 +
>>  arch/powerpc/include/asm/kvm_ppc.h    |  21 ++
>>  arch/powerpc/kvm/book3s_xive.h        |   3 +
>>  include/uapi/linux/kvm.h              |   3 +
>>  arch/powerpc/kvm/book3s.c             |   7 +-
>>  arch/powerpc/kvm/book3s_xive_native.c | 332 ++++++++++++++++++++++++++
>>  arch/powerpc/kvm/powerpc.c            |  30 +++
>>  arch/powerpc/kvm/Makefile             |   2 +-
>>  8 files changed, 398 insertions(+), 2 deletions(-)
>>  create mode 100644 arch/powerpc/kvm/book3s_xive_native.c
>>
>> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
>> index 0f98f00da2ea..c522e8274ad9 100644
>> --- a/arch/powerpc/include/asm/kvm_host.h
>> +++ b/arch/powerpc/include/asm/kvm_host.h
>> @@ -220,6 +220,7 @@ extern struct kvm_device_ops kvm_xics_ops;
>>  struct kvmppc_xive;
>>  struct kvmppc_xive_vcpu;
>>  extern struct kvm_device_ops kvm_xive_ops;
>> +extern struct kvm_device_ops kvm_xive_native_ops;
>>  
>>  struct kvmppc_passthru_irqmap;
>>  
>> @@ -446,6 +447,7 @@ struct kvmppc_passthru_irqmap {
>>  #define KVMPPC_IRQ_DEFAULT	0
>>  #define KVMPPC_IRQ_MPIC		1
>>  #define KVMPPC_IRQ_XICS		2 /* Includes a XIVE option */
>> +#define KVMPPC_IRQ_XIVE		3 /* XIVE native exploitation mode */
>>  
>>  #define MMIO_HPTE_CACHE_SIZE	4
>>  
>> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
>> index eb0d79f0ca45..1bb313f238fe 100644
>> --- a/arch/powerpc/include/asm/kvm_ppc.h
>> +++ b/arch/powerpc/include/asm/kvm_ppc.h
>> @@ -591,6 +591,18 @@ extern int kvmppc_xive_set_icp(struct kvm_vcpu *vcpu, u64 icpval);
>>  extern int kvmppc_xive_set_irq(struct kvm *kvm, int irq_source_id, u32 irq,
>>  			       int level, bool line_status);
>>  extern void kvmppc_xive_push_vcpu(struct kvm_vcpu *vcpu);
>> +
>> +static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
>> +{
>> +	return vcpu->arch.irq_type == KVMPPC_IRQ_XIVE;
>> +}
>> +
>> +extern int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
>> +				    struct kvm_vcpu *vcpu, u32 cpu);
>> +extern void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu);
>> +extern void kvmppc_xive_native_init_module(void);
>> +extern void kvmppc_xive_native_exit_module(void);
>> +
>>  #else
>>  static inline int kvmppc_xive_set_xive(struct kvm *kvm, u32 irq, u32 server,
>>  				       u32 priority) { return -1; }
>> @@ -614,6 +626,15 @@ static inline int kvmppc_xive_set_icp(struct kvm_vcpu *vcpu, u64 icpval) { retur
>>  static inline int kvmppc_xive_set_irq(struct kvm *kvm, int irq_source_id, u32 irq,
>>  				      int level, bool line_status) { return -ENODEV; }
>>  static inline void kvmppc_xive_push_vcpu(struct kvm_vcpu *vcpu) { }
>> +
>> +static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
>> +	{ return 0; }
>> +static inline int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
>> +						  struct kvm_vcpu *vcpu, u32 cpu) { return -EBUSY; }
>> +static inline void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu) { }
>> +static inline void kvmppc_xive_native_init_module(void) { }
>> +static inline void kvmppc_xive_native_exit_module(void) { }
>> +
>>  #endif /* CONFIG_KVM_XIVE */
>>  
>>  /*
>> diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xive.h
>> index 10c4aa5cd010..5f22415520b4 100644
>> --- a/arch/powerpc/kvm/book3s_xive.h
>> +++ b/arch/powerpc/kvm/book3s_xive.h
>> @@ -12,6 +12,9 @@
>>  #ifdef CONFIG_KVM_XICS
>>  #include "book3s_xics.h"
>>  
>> +#define KVMPPC_XIVE_FIRST_IRQ	0
>> +#define KVMPPC_XIVE_NR_IRQS	KVMPPC_XICS_NR_IRQS
>> +
>>  /*
>>   * State for one guest irq source.
>>   *
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 6d4ea4b6c922..52bf74a1616e 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -988,6 +988,7 @@ struct kvm_ppc_resize_hpt {
>>  #define KVM_CAP_ARM_VM_IPA_SIZE 165
>>  #define KVM_CAP_MANUAL_DIRTY_LOG_PROTECT 166
>>  #define KVM_CAP_HYPERV_CPUID 167
>> +#define KVM_CAP_PPC_IRQ_XIVE 168
>>  
>>  #ifdef KVM_CAP_IRQ_ROUTING
>>  
>> @@ -1211,6 +1212,8 @@ enum kvm_device_type {
>>  #define KVM_DEV_TYPE_ARM_VGIC_V3	KVM_DEV_TYPE_ARM_VGIC_V3
>>  	KVM_DEV_TYPE_ARM_VGIC_ITS,
>>  #define KVM_DEV_TYPE_ARM_VGIC_ITS	KVM_DEV_TYPE_ARM_VGIC_ITS
>> +	KVM_DEV_TYPE_XIVE,
>> +#define KVM_DEV_TYPE_XIVE		KVM_DEV_TYPE_XIVE
>>  	KVM_DEV_TYPE_MAX,
>>  };
>>  
>> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
>> index bd1a677dd9e4..de7eed191107 100644
>> --- a/arch/powerpc/kvm/book3s.c
>> +++ b/arch/powerpc/kvm/book3s.c
>> @@ -1039,7 +1039,10 @@ static int kvmppc_book3s_init(void)
>>  #ifdef CONFIG_KVM_XIVE
>>  	if (xive_enabled()) {
>>  		kvmppc_xive_init_module();
>> +		kvmppc_xive_native_init_module();
>>  		kvm_register_device_ops(&kvm_xive_ops, KVM_DEV_TYPE_XICS);
>> +		kvm_register_device_ops(&kvm_xive_native_ops,
>> +					KVM_DEV_TYPE_XIVE);
>>  	} else
>>  #endif
>>  		kvm_register_device_ops(&kvm_xics_ops, KVM_DEV_TYPE_XICS);
>> @@ -1050,8 +1053,10 @@ static int kvmppc_book3s_init(void)
>>  static void kvmppc_book3s_exit(void)
>>  {
>>  #ifdef CONFIG_KVM_XICS
>> -	if (xive_enabled())
>> +	if (xive_enabled()) {
>>  		kvmppc_xive_exit_module();
>> +		kvmppc_xive_native_exit_module();
>> +	}
>>  #endif
>>  #ifdef CONFIG_KVM_BOOK3S_32_HANDLER
>>  	kvmppc_book3s_exit_pr();
>> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
>> new file mode 100644
>> index 000000000000..115143e76c45
>> --- /dev/null
>> +++ b/arch/powerpc/kvm/book3s_xive_native.c
>> @@ -0,0 +1,332 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2017-2019, IBM Corporation.
>> + */
>> +
>> +#define pr_fmt(fmt) "xive-kvm: " fmt
>> +
>> +#include <linux/anon_inodes.h>
>> +#include <linux/kernel.h>
>> +#include <linux/kvm_host.h>
>> +#include <linux/err.h>
>> +#include <linux/gfp.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/delay.h>
>> +#include <linux/percpu.h>
>> +#include <linux/cpumask.h>
>> +#include <asm/uaccess.h>
>> +#include <asm/kvm_book3s.h>
>> +#include <asm/kvm_ppc.h>
>> +#include <asm/hvcall.h>
>> +#include <asm/xics.h>
>> +#include <asm/xive.h>
>> +#include <asm/xive-regs.h>
>> +#include <asm/debug.h>
>> +#include <asm/debugfs.h>
>> +#include <asm/time.h>
>> +#include <asm/opal.h>
>> +
>> +#include <linux/debugfs.h>
>> +#include <linux/seq_file.h>
>> +
>> +#include "book3s_xive.h"
>> +
>> +static void xive_native_cleanup_queue(struct kvm_vcpu *vcpu, int prio)
>> +{
>> +	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
>> +	struct xive_q *q = &xc->queues[prio];
>> +
>> +	xive_native_disable_queue(xc->vp_id, q, prio);
>> +	if (q->qpage) {
>> +		put_page(virt_to_page(q->qpage));
>> +		q->qpage = NULL;
>> +	}
>> +}
>> +
>> +void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
>> +	int i;
>> +
>> +	if (!kvmppc_xive_enabled(vcpu))
>> +		return;
>> +
>> +	if (!xc)
>> +		return;
>> +
>> +	pr_devel("native_cleanup_vcpu(cpu=%d)\n", xc->server_num);
>> +
>> +	/* Ensure no interrupt is still routed to that VP */
>> +	xc->valid = false;
>> +	kvmppc_xive_disable_vcpu_interrupts(vcpu);
>> +
>> +	/* Disable the VP */
>> +	xive_native_disable_vp(xc->vp_id);
>> +
>> +	/* Free the queues & associated interrupts */
>> +	for (i = 0; i < KVMPPC_XIVE_Q_COUNT; i++) {
>> +		/* Free the escalation irq */
>> +		if (xc->esc_virq[i]) {
>> +			free_irq(xc->esc_virq[i], vcpu);
>> +			irq_dispose_mapping(xc->esc_virq[i]);
>> +			kfree(xc->esc_virq_names[i]);
>> +			xc->esc_virq[i] = 0;
>> +		}
>> +
>> +		/* Free the queue */
>> +		xive_native_cleanup_queue(vcpu, i);
>> +	}
>> +
>> +	/* Free the VP */
>> +	kfree(xc);
>> +
>> +	/* Cleanup the vcpu */
>> +	vcpu->arch.irq_type = KVMPPC_IRQ_DEFAULT;
>> +	vcpu->arch.xive_vcpu = NULL;
>> +}
>> +
>> +int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
>> +				    struct kvm_vcpu *vcpu, u32 cpu)
> 
> Why do we need both a *vcpu and a cpu number as an integer?

To be in sync with the other similar routines : kvmppc_xics_connect_vcpu() 
and kvmppc_xive_connect_vcpu().

But if we consider that this 'cpu' parameter is always in sync with 
vcpu->vcpu_id, we could remove it from the KVM ioctl call I suppose.

Should we do the same for the other routines ? 
 
>> +{
>> +	struct kvmppc_xive *xive = dev->private;
>> +	struct kvmppc_xive_vcpu *xc;
>> +	int rc;
>> +
>> +	pr_devel("native_connect_vcpu(cpu=%d)\n", cpu);
>> +
>> +	if (dev->ops != &kvm_xive_native_ops) {
>> +		pr_devel("Wrong ops !\n");
>> +		return -EPERM;
>> +	}
>> +	if (xive->kvm != vcpu->kvm)
>> +		return -EPERM;
>> +	if (vcpu->arch.irq_type)
> 
> Please use an explicit == / != here so we don't have to remember which
> symbolic value corresponds to 0.

ok. I agree.

Thanks,

C. 


> 
>> +		return -EBUSY;
>> +	if (kvmppc_xive_find_server(vcpu->kvm, cpu)) {
>> +		pr_devel("Duplicate !\n");
>> +		return -EEXIST;
>> +	}
>> +	if (cpu >= KVM_MAX_VCPUS) {
>> +		pr_devel("Out of bounds !\n");
>> +		return -EINVAL;
>> +	}
>> +	xc = kzalloc(sizeof(*xc), GFP_KERNEL);
>> +	if (!xc)
>> +		return -ENOMEM;
>> +
>> +	mutex_lock(&vcpu->kvm->lock);
>> +	vcpu->arch.xive_vcpu = xc;
>> +	xc->xive = xive;
>> +	xc->vcpu = vcpu;
>> +	xc->server_num = cpu;
>> +	xc->vp_id = xive->vp_base + cpu;
>> +	xc->valid = true;
>> +
>> +	rc = xive_native_get_vp_info(xc->vp_id, &xc->vp_cam, &xc->vp_chip_id);
>> +	if (rc) {
>> +		pr_err("Failed to get VP info from OPAL: %d\n", rc);
>> +		goto bail;
>> +	}
>> +
>> +	/*
>> +	 * Enable the VP first as the single escalation mode will
>> +	 * affect escalation interrupts numbering
>> +	 */
>> +	rc = xive_native_enable_vp(xc->vp_id, xive->single_escalation);
>> +	if (rc) {
>> +		pr_err("Failed to enable VP in OPAL: %d\n", rc);
>> +		goto bail;
>> +	}
>> +
>> +	/* Configure VCPU fields for use by assembly push/pull */
>> +	vcpu->arch.xive_saved_state.w01 = cpu_to_be64(0xff000000);
>> +	vcpu->arch.xive_cam_word = cpu_to_be32(xc->vp_cam | TM_QW1W2_VO);
>> +
>> +	/* TODO: initialize queues ? */
>> +
>> +bail:
>> +	vcpu->arch.irq_type = KVMPPC_IRQ_XIVE;
>> +	mutex_unlock(&vcpu->kvm->lock);
>> +	if (rc)
>> +		kvmppc_xive_native_cleanup_vcpu(vcpu);
>> +
>> +	return rc;
>> +}
>> +
>> +static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>> +				       struct kvm_device_attr *attr)
>> +{
>> +	return -ENXIO;
>> +}
>> +
>> +static int kvmppc_xive_native_get_attr(struct kvm_device *dev,
>> +				       struct kvm_device_attr *attr)
>> +{
>> +	return -ENXIO;
>> +}
>> +
>> +static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
>> +				       struct kvm_device_attr *attr)
>> +{
>> +	return -ENXIO;
>> +}
>> +
>> +static void kvmppc_xive_native_free(struct kvm_device *dev)
>> +{
>> +	struct kvmppc_xive *xive = dev->private;
>> +	struct kvm *kvm = xive->kvm;
>> +	int i;
>> +
>> +	debugfs_remove(xive->dentry);
>> +
>> +	pr_devel("Destroying xive native for partition\n");
>> +
>> +	if (kvm)
>> +		kvm->arch.xive = NULL;
>> +
>> +	/* Mask and free interrupts */
>> +	for (i = 0; i <= xive->max_sbid; i++) {
>> +		if (xive->src_blocks[i])
>> +			kvmppc_xive_free_sources(xive->src_blocks[i]);
>> +		kfree(xive->src_blocks[i]);
>> +		xive->src_blocks[i] = NULL;
>> +	}
>> +
>> +	if (xive->vp_base != XIVE_INVALID_VP)
>> +		xive_native_free_vp_block(xive->vp_base);
>> +
>> +	kfree(xive);
>> +	kfree(dev);
>> +}
>> +
>> +static int kvmppc_xive_native_create(struct kvm_device *dev, u32 type)
>> +{
>> +	struct kvmppc_xive *xive;
>> +	struct kvm *kvm = dev->kvm;
>> +	int ret = 0;
>> +
>> +	pr_devel("Creating xive native for partition\n");
>> +
>> +	if (kvm->arch.xive)
>> +		return -EEXIST;
>> +
>> +	xive = kzalloc(sizeof(*xive), GFP_KERNEL);
>> +	if (!xive)
>> +		return -ENOMEM;
>> +
>> +	dev->private = xive;
>> +	xive->dev = dev;
>> +	xive->kvm = kvm;
>> +	kvm->arch.xive = xive;
>> +
>> +	/* We use the default queue size set by the host */
>> +	xive->q_order = xive_native_default_eq_shift();
>> +	if (xive->q_order < PAGE_SHIFT)
>> +		xive->q_page_order = 0;
>> +	else
>> +		xive->q_page_order = xive->q_order - PAGE_SHIFT;
>> +
>> +	/* Allocate a bunch of VPs */
>> +	xive->vp_base = xive_native_alloc_vp_block(KVM_MAX_VCPUS);
>> +	pr_devel("VP_Base=%x\n", xive->vp_base);
>> +
>> +	if (xive->vp_base == XIVE_INVALID_VP)
>> +		ret = -ENOMEM;
>> +
>> +	xive->single_escalation = xive_native_has_single_escalation();
>> +
>> +	if (ret)
>> +		kfree(xive);
>> +
>> +	return ret;
>> +}
>> +
>> +static int xive_native_debug_show(struct seq_file *m, void *private)
>> +{
>> +	struct kvmppc_xive *xive = m->private;
>> +	struct kvm *kvm = xive->kvm;
>> +	struct kvm_vcpu *vcpu;
>> +	unsigned int i;
>> +
>> +	if (!kvm)
>> +		return 0;
>> +
>> +	seq_puts(m, "=========\nVCPU state\n=========\n");
>> +
>> +	kvm_for_each_vcpu(i, vcpu, kvm) {
>> +		struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
>> +
>> +		if (!xc)
>> +			continue;
>> +
>> +		seq_printf(m, "cpu server %#x NSR=%02x CPPR=%02x IBP=%02x PIPR=%02x w01=%016llx w2=%08x\n",
>> +			   xc->server_num,
>> +			   vcpu->arch.xive_saved_state.nsr,
>> +			   vcpu->arch.xive_saved_state.cppr,
>> +			   vcpu->arch.xive_saved_state.ipb,
>> +			   vcpu->arch.xive_saved_state.pipr,
>> +			   vcpu->arch.xive_saved_state.w01,
>> +			   (u32) vcpu->arch.xive_cam_word);
>> +
>> +		kvmppc_xive_debug_show_queues(m, vcpu);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int xive_native_debug_open(struct inode *inode, struct file *file)
>> +{
>> +	return single_open(file, xive_native_debug_show, inode->i_private);
>> +}
>> +
>> +static const struct file_operations xive_native_debug_fops = {
>> +	.open = xive_native_debug_open,
>> +	.read = seq_read,
>> +	.llseek = seq_lseek,
>> +	.release = single_release,
>> +};
>> +
>> +static void xive_native_debugfs_init(struct kvmppc_xive *xive)
>> +{
>> +	char *name;
>> +
>> +	name = kasprintf(GFP_KERNEL, "kvm-xive-%p", xive);
>> +	if (!name) {
>> +		pr_err("%s: no memory for name\n", __func__);
>> +		return;
>> +	}
>> +
>> +	xive->dentry = debugfs_create_file(name, 0444, powerpc_debugfs_root,
>> +					   xive, &xive_native_debug_fops);
>> +
>> +	pr_debug("%s: created %s\n", __func__, name);
>> +	kfree(name);
>> +}
>> +
>> +static void kvmppc_xive_native_init(struct kvm_device *dev)
>> +{
>> +	struct kvmppc_xive *xive = (struct kvmppc_xive *)dev->private;
>> +
>> +	/* Register some debug interfaces */
>> +	xive_native_debugfs_init(xive);
>> +}
>> +
>> +struct kvm_device_ops kvm_xive_native_ops = {
>> +	.name = "kvm-xive-native",
>> +	.create = kvmppc_xive_native_create,
>> +	.init = kvmppc_xive_native_init,
>> +	.destroy = kvmppc_xive_native_free,
>> +	.set_attr = kvmppc_xive_native_set_attr,
>> +	.get_attr = kvmppc_xive_native_get_attr,
>> +	.has_attr = kvmppc_xive_native_has_attr,
>> +};
>> +
>> +void kvmppc_xive_native_init_module(void)
>> +{
>> +	;
>> +}
>> +
>> +void kvmppc_xive_native_exit_module(void)
>> +{
>> +	;
>> +}
>> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
>> index b90a7d154180..01d526e15e9d 100644
>> --- a/arch/powerpc/kvm/powerpc.c
>> +++ b/arch/powerpc/kvm/powerpc.c
>> @@ -566,6 +566,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>  	case KVM_CAP_PPC_ENABLE_HCALL:
>>  #ifdef CONFIG_KVM_XICS
>>  	case KVM_CAP_IRQ_XICS:
>> +#endif
>> +#ifdef CONFIG_KVM_XIVE
>> +	case KVM_CAP_PPC_IRQ_XIVE:
>>  #endif
>>  	case KVM_CAP_PPC_GET_CPU_CHAR:
>>  		r = 1;
>> @@ -753,6 +756,9 @@ void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
>>  		else
>>  			kvmppc_xics_free_icp(vcpu);
>>  		break;
>> +	case KVMPPC_IRQ_XIVE:
>> +		kvmppc_xive_native_cleanup_vcpu(vcpu);
>> +		break;
>>  	}
>>  
>>  	kvmppc_core_vcpu_free(vcpu);
>> @@ -1941,6 +1947,30 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
>>  		break;
>>  	}
>>  #endif /* CONFIG_KVM_XICS */
>> +#ifdef CONFIG_KVM_XIVE
>> +	case KVM_CAP_PPC_IRQ_XIVE: {
>> +		struct fd f;
>> +		struct kvm_device *dev;
>> +
>> +		r = -EBADF;
>> +		f = fdget(cap->args[0]);
>> +		if (!f.file)
>> +			break;
>> +
>> +		r = -ENXIO;
>> +		if (!xive_enabled())
>> +			break;
>> +
>> +		r = -EPERM;
>> +		dev = kvm_device_from_filp(f.file);
>> +		if (dev)
>> +			r = kvmppc_xive_native_connect_vcpu(dev, vcpu,
>> +							    cap->args[1]);
>> +
>> +		fdput(f);
>> +		break;
>> +	}
>> +#endif /* CONFIG_KVM_XIVE */
>>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>>  	case KVM_CAP_PPC_FWNMI:
>>  		r = -EINVAL;
>> diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
>> index 64f1135e7732..806cbe488410 100644
>> --- a/arch/powerpc/kvm/Makefile
>> +++ b/arch/powerpc/kvm/Makefile
>> @@ -99,7 +99,7 @@ endif
>>  kvm-book3s_64-objs-$(CONFIG_KVM_XICS) += \
>>  	book3s_xics.o
>>  
>> -kvm-book3s_64-objs-$(CONFIG_KVM_XIVE) += book3s_xive.o
>> +kvm-book3s_64-objs-$(CONFIG_KVM_XIVE) += book3s_xive.o book3s_xive_native.o
>>  kvm-book3s_64-objs-$(CONFIG_SPAPR_TCE_IOMMU) += book3s_64_vio.o
>>  
>>  kvm-book3s_64-module-objs := \
> 

