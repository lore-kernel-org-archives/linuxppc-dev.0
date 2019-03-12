Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BA0C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 14:24:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA6C22075C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 14:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6C22075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Jcfd687GzDqHR
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 01:24:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=87.98.143.68; helo=2.mo7.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 597 seconds by postgrey-1.36 at bilbo;
 Wed, 13 Mar 2019 01:22:21 AEDT
Received: from 2.mo7.mail-out.ovh.net (2.mo7.mail-out.ovh.net [87.98.143.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44JccY1H48zDqBP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 01:22:18 +1100 (AEDT)
Received: from player791.ha.ovh.net (unknown [10.109.146.175])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id C2282109106
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 15:03:34 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n0.emea.ibm.com [195.212.29.162])
 (Authenticated sender: clg@kaod.org)
 by player791.ha.ovh.net (Postfix) with ESMTPSA id C502B37BC983;
 Tue, 12 Mar 2019 14:03:26 +0000 (UTC)
Subject: Re: [PATCH v2 03/16] KVM: PPC: Book3S HV: XIVE: introduce a new
 capability KVM_CAP_PPC_IRQ_XIVE
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-4-clg@kaod.org> <20190225003527.GG7668@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2f029721-0b20-2706-6627-0bac36afd03e@kaod.org>
Date: Tue, 12 Mar 2019 15:03:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190225003527.GG7668@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13562027330792885127
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrgeekgdeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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

On 2/25/19 1:35 AM, David Gibson wrote:
> On Fri, Feb 22, 2019 at 12:28:27PM +0100, Cédric Le Goater wrote:
>> The user interface exposes a new capability to let QEMU connect the
>> vCPU to the XIVE KVM device if required. The capability is only
>> advertised on a PowerNV Hypervisor as support for nested guests
>> (pseries KVM Hypervisor) is not yet available.
>>
>> Internally, the interface to the new KVM device is protected with a
>> new interrupt mode: KVMPPC_IRQ_XIVE.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  arch/powerpc/include/asm/kvm_host.h   |   1 +
>>  arch/powerpc/include/asm/kvm_ppc.h    |  13 +++
>>  arch/powerpc/kvm/book3s_xive.h        |   6 ++
>>  include/uapi/linux/kvm.h              |   1 +
>>  arch/powerpc/kvm/book3s_xive.c        |  67 +++++++-----
>>  arch/powerpc/kvm/book3s_xive_native.c | 144 ++++++++++++++++++++++++++
>>  arch/powerpc/kvm/powerpc.c            |  33 ++++++
>>  Documentation/virtual/kvm/api.txt     |   9 ++
>>  8 files changed, 246 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
>> index 9f75a75a07f2..eb8581be0ee8 100644
>> --- a/arch/powerpc/include/asm/kvm_host.h
>> +++ b/arch/powerpc/include/asm/kvm_host.h
>> @@ -448,6 +448,7 @@ struct kvmppc_passthru_irqmap {
>>  #define KVMPPC_IRQ_DEFAULT	0
>>  #define KVMPPC_IRQ_MPIC		1
>>  #define KVMPPC_IRQ_XICS		2 /* Includes a XIVE option */
>> +#define KVMPPC_IRQ_XIVE		3 /* XIVE native exploitation mode */
>>  
>>  #define MMIO_HPTE_CACHE_SIZE	4
>>  
>> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
>> index 4b72ddde7dc1..1e61877fe147 100644
>> --- a/arch/powerpc/include/asm/kvm_ppc.h
>> +++ b/arch/powerpc/include/asm/kvm_ppc.h
>> @@ -594,6 +594,14 @@ extern int kvmppc_xive_set_irq(struct kvm *kvm, int irq_source_id, u32 irq,
>>  			       int level, bool line_status);
>>  extern void kvmppc_xive_push_vcpu(struct kvm_vcpu *vcpu);
>>  
>> +static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
>> +{
>> +	return vcpu->arch.irq_type == KVMPPC_IRQ_XIVE;
>> +}
>> +
>> +extern int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
>> +					   struct kvm_vcpu *vcpu, u32 cpu);
>> +extern void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu);
>>  extern void kvmppc_xive_native_init_module(void);
>>  extern void kvmppc_xive_native_exit_module(void);
>>  
>> @@ -621,6 +629,11 @@ static inline int kvmppc_xive_set_irq(struct kvm *kvm, int irq_source_id, u32 ir
>>  				      int level, bool line_status) { return -ENODEV; }
>>  static inline void kvmppc_xive_push_vcpu(struct kvm_vcpu *vcpu) { }
>>  
>> +static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
>> +	{ return 0; }
>> +static inline int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
>> +			  struct kvm_vcpu *vcpu, u32 cpu) { return -EBUSY; }
>> +static inline void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu) { }
>>  static inline void kvmppc_xive_native_init_module(void) { }
>>  static inline void kvmppc_xive_native_exit_module(void) { }
>>  
>> diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xive.h
>> index a08ae6fd4c51..bcb1bbcf0359 100644
>> --- a/arch/powerpc/kvm/book3s_xive.h
>> +++ b/arch/powerpc/kvm/book3s_xive.h
>> @@ -248,5 +248,11 @@ extern int (*__xive_vm_h_ipi)(struct kvm_vcpu *vcpu, unsigned long server,
>>  extern int (*__xive_vm_h_cppr)(struct kvm_vcpu *vcpu, unsigned long cppr);
>>  extern int (*__xive_vm_h_eoi)(struct kvm_vcpu *vcpu, unsigned long xirr);
>>  
>> +/*
>> + * Common Xive routines for XICS-over-XIVE and XIVE native
>> + */
>> +void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu);
>> +int kvmppc_xive_debug_show_queues(struct seq_file *m, struct kvm_vcpu *vcpu);
>> +
>>  #endif /* CONFIG_KVM_XICS */
>>  #endif /* _KVM_PPC_BOOK3S_XICS_H */
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index e6368163d3a0..52bf74a1616e 100644
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
>> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
>> index f78d002f0fe0..d1cc18a5b1c4 100644
>> --- a/arch/powerpc/kvm/book3s_xive.c
>> +++ b/arch/powerpc/kvm/book3s_xive.c
>> @@ -1049,7 +1049,7 @@ int kvmppc_xive_clr_mapped(struct kvm *kvm, unsigned long guest_irq,
>>  }
>>  EXPORT_SYMBOL_GPL(kvmppc_xive_clr_mapped);
>>  
>> -static void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu)
>> +void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu)
>>  {
>>  	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
>>  	struct kvm *kvm = vcpu->kvm;
>> @@ -1883,6 +1883,43 @@ static int kvmppc_xive_create(struct kvm_device *dev, u32 type)
>>  	return 0;
>>  }
>>  
>> +int kvmppc_xive_debug_show_queues(struct seq_file *m, struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < KVMPPC_XIVE_Q_COUNT; i++) {
>> +		struct xive_q *q = &xc->queues[i];
>> +		u32 i0, i1, idx;
>> +
>> +		if (!q->qpage && !xc->esc_virq[i])
>> +			continue;
>> +
>> +		seq_printf(m, " [q%d]: ", i);
>> +
>> +		if (q->qpage) {
>> +			idx = q->idx;
>> +			i0 = be32_to_cpup(q->qpage + idx);
>> +			idx = (idx + 1) & q->msk;
>> +			i1 = be32_to_cpup(q->qpage + idx);
>> +			seq_printf(m, "T=%d %08x %08x...\n", q->toggle,
>> +				   i0, i1);
>> +		}
>> +		if (xc->esc_virq[i]) {
>> +			struct irq_data *d = irq_get_irq_data(xc->esc_virq[i]);
>> +			struct xive_irq_data *xd =
>> +				irq_data_get_irq_handler_data(d);
>> +			u64 pq = xive_vm_esb_load(xd, XIVE_ESB_GET);
>> +
>> +			seq_printf(m, "E:%c%c I(%d:%llx:%llx)",
>> +				   (pq & XIVE_ESB_VAL_P) ? 'P' : 'p',
>> +				   (pq & XIVE_ESB_VAL_Q) ? 'Q' : 'q',
>> +				   xc->esc_virq[i], pq, xd->eoi_page);
>> +			seq_puts(m, "\n");
>> +		}
>> +	}
>> +	return 0;
>> +}
>>  
>>  static int xive_debug_show(struct seq_file *m, void *private)
>>  {
>> @@ -1908,7 +1945,6 @@ static int xive_debug_show(struct seq_file *m, void *private)
>>  
>>  	kvm_for_each_vcpu(i, vcpu, kvm) {
>>  		struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
>> -		unsigned int i;
>>  
>>  		if (!xc)
>>  			continue;
>> @@ -1918,33 +1954,8 @@ static int xive_debug_show(struct seq_file *m, void *private)
>>  			   xc->server_num, xc->cppr, xc->hw_cppr,
>>  			   xc->mfrr, xc->pending,
>>  			   xc->stat_rm_h_xirr, xc->stat_vm_h_xirr);
>> -		for (i = 0; i < KVMPPC_XIVE_Q_COUNT; i++) {
>> -			struct xive_q *q = &xc->queues[i];
>> -			u32 i0, i1, idx;
>>  
>> -			if (!q->qpage && !xc->esc_virq[i])
>> -				continue;
>> -
>> -			seq_printf(m, " [q%d]: ", i);
>> -
>> -			if (q->qpage) {
>> -				idx = q->idx;
>> -				i0 = be32_to_cpup(q->qpage + idx);
>> -				idx = (idx + 1) & q->msk;
>> -				i1 = be32_to_cpup(q->qpage + idx);
>> -				seq_printf(m, "T=%d %08x %08x... \n", q->toggle, i0, i1);
>> -			}
>> -			if (xc->esc_virq[i]) {
>> -				struct irq_data *d = irq_get_irq_data(xc->esc_virq[i]);
>> -				struct xive_irq_data *xd = irq_data_get_irq_handler_data(d);
>> -				u64 pq = xive_vm_esb_load(xd, XIVE_ESB_GET);
>> -				seq_printf(m, "E:%c%c I(%d:%llx:%llx)",
>> -					   (pq & XIVE_ESB_VAL_P) ? 'P' : 'p',
>> -					   (pq & XIVE_ESB_VAL_Q) ? 'Q' : 'q',
>> -					   xc->esc_virq[i], pq, xd->eoi_page);
>> -				seq_printf(m, "\n");
>> -			}
>> -		}
>> +		kvmppc_xive_debug_show_queues(m, vcpu);
>>  
>>  		t_rm_h_xirr += xc->stat_rm_h_xirr;
>>  		t_rm_h_ipoll += xc->stat_rm_h_ipoll;
>> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
>> index e475ce83ad14..1f3da47a4a6a 100644
>> --- a/arch/powerpc/kvm/book3s_xive_native.c
>> +++ b/arch/powerpc/kvm/book3s_xive_native.c
>> @@ -31,6 +31,128 @@
>>  
>>  #include "book3s_xive.h"
>>  
>> +static void kvmppc_xive_native_cleanup_queue(struct kvm_vcpu *vcpu, int prio)
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
>> +		kvmppc_xive_native_cleanup_queue(vcpu, i);
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
>> +	if (vcpu->arch.irq_type != KVMPPC_IRQ_DEFAULT)
>> +		return -EBUSY;
>> +	if (kvmppc_xive_find_server(vcpu->kvm, cpu)) {
> 
> You haven't taken the kvm->lock yet, so couldn't a race mean a
> duplicate server gets inserted after you make this check?
> 
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
> 
> Similarly you don't verify this is NULL after taking the lock, so
> couldn't another thread race and make a connect which gets clobbered
> here?

Yes. this is not very safe ... We need to clean up all the KVM device 
methods doing the connection of the presenter to the vCPU AFAICT. 
I will fix the XIVE native one for now. 

And also, this CPU parameter is useless. There is no reason to connect 
a vCPU from another vCPU.

>> +	xc->xive = xive;
>> +	xc->vcpu = vcpu;
>> +	xc->server_num = cpu;
>> +	xc->vp_id = xive->vp_base + cpu;
> 
> Hrm.  This ties the internal VP id to the userspace chosen server
> number, which isn't ideal.  It puts a constraint on those server
> numbers that you wouldn't otherwise have.

Ah yes. I should be using the kvmppc_pack_vcpu_id() like we do for  
the XICS-over-XIVE device probably. I need to check that it is correct 
in this mode.

Thanks,

C.

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
>>  static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>>  				       struct kvm_device_attr *attr)
>>  {
>> @@ -126,10 +248,32 @@ static int xive_native_debug_show(struct seq_file *m, void *private)
>>  {
>>  	struct kvmppc_xive *xive = m->private;
>>  	struct kvm *kvm = xive->kvm;
>> +	struct kvm_vcpu *vcpu;
>> +	unsigned int i;
>>  
>>  	if (!kvm)
>>  		return 0;
>>  
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
>>  	return 0;
>>  }
>>  
>> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
>> index 8c69af10f91d..a38a643a24dd 100644
>> --- a/arch/powerpc/kvm/powerpc.c
>> +++ b/arch/powerpc/kvm/powerpc.c
>> @@ -570,6 +570,12 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>  	case KVM_CAP_PPC_GET_CPU_CHAR:
>>  		r = 1;
>>  		break;
>> +#ifdef CONFIG_KVM_XIVE
>> +	case KVM_CAP_PPC_IRQ_XIVE:
>> +		/* only for PowerNV */
>> +		r = !!cpu_has_feature(CPU_FTR_HVMODE);
>> +		break;
>> +#endif
>>  
>>  	case KVM_CAP_PPC_ALLOC_HTAB:
>>  		r = hv_enabled;
>> @@ -753,6 +759,9 @@ void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
>>  		else
>>  			kvmppc_xics_free_icp(vcpu);
>>  		break;
>> +	case KVMPPC_IRQ_XIVE:
>> +		kvmppc_xive_native_cleanup_vcpu(vcpu);
>> +		break;
>>  	}
>>  
>>  	kvmppc_core_vcpu_free(vcpu);
>> @@ -1941,6 +1950,30 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
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
>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>> index 356156f5c52d..1db1435769b4 100644
>> --- a/Documentation/virtual/kvm/api.txt
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -4458,6 +4458,15 @@ struct kvm_sync_regs {
>>          struct kvm_vcpu_events events;
>>  };
>>  
>> +6.75 KVM_CAP_PPC_IRQ_XIVE
>> +
>> +Architectures: ppc
>> +Target: vcpu
>> +Parameters: args[0] is the XIVE device fd
>> +            args[1] is the XIVE CPU number (server ID) for this vcpu
>> +
>> +This capability connects the vcpu to an in-kernel XIVE device.
>> +
>>  7. Capabilities that can be enabled on VMs
>>  ------------------------------------------
>>  
> 

