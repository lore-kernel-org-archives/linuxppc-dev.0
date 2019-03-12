Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08272C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 17:02:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F29D2083D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 17:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F29D2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Jh9X1rqdzDqGC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 04:02:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.39.61; helo=2.mo178.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 2.mo178.mail-out.ovh.net (2.mo178.mail-out.ovh.net
 [46.105.39.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Jh7W6SZHzDqDG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 04:00:53 +1100 (AEDT)
Received: from player738.ha.ovh.net (unknown [10.109.146.50])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 1D24C58543
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 18:00:48 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n0.emea.ibm.com [195.212.29.162])
 (Authenticated sender: clg@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id 1C8503B8A401;
 Tue, 12 Mar 2019 17:00:39 +0000 (UTC)
Subject: Re: [PATCH v2 06/16] KVM: PPC: Book3S HV: XIVE: add controls for the
 EQ configuration
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-7-clg@kaod.org> <20190225023955.GJ7668@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9e732140-b2c0-dfb7-d753-ba0ec7f3b930@kaod.org>
Date: Tue, 12 Mar 2019 18:00:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190225023955.GJ7668@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16555232233160346503
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrgeekgdelkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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

On 2/25/19 3:39 AM, David Gibson wrote:
> On Fri, Feb 22, 2019 at 12:28:30PM +0100, Cédric Le Goater wrote:
>> These controls will be used by the H_INT_SET_QUEUE_CONFIG and
>> H_INT_GET_QUEUE_CONFIG hcalls from QEMU. They will also be used to
>> restore the configuration of the XIVE EQs in the KVM device and to
>> capture the internal runtime state of the EQs. Both 'get' and 'set'
>> rely on an OPAL call to access from the XIVE interrupt controller the
>> EQ toggle bit and EQ index which are updated by the HW when event
>> notifications are enqueued in the EQ.
>>
>> The value of the guest physical address of the event queue is saved in
>> the XIVE internal xive_q structure for later use. That is when
>> migration needs to mark the EQ pages dirty to capture a consistent
>> memory state of the VM.
>>
>> To be noted that H_INT_SET_QUEUE_CONFIG does not require the extra
>> OPAL call setting the EQ toggle bit and EQ index to configure the EQ,
>> but restoring the EQ state will.

I think we need to add some kind of flags to differentiate the hcall
H_INT_SET_QUEUE_CONFIG from the restore of the EQ. The hcall does
not need OPAL support call and this could help in the code transition.

But without OPAL support, we won't have migration. Would that be of 
any use ?  


>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  arch/powerpc/include/asm/xive.h            |   2 +
>>  arch/powerpc/include/uapi/asm/kvm.h        |  21 +++
>>  arch/powerpc/kvm/book3s_xive.h             |   2 +
>>  arch/powerpc/kvm/book3s_xive.c             |  15 +-
>>  arch/powerpc/kvm/book3s_xive_native.c      | 207 +++++++++++++++++++++
>>  Documentation/virtual/kvm/devices/xive.txt |  29 +++
>>  6 files changed, 270 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
>> index b579a943407b..46891f321606 100644
>> --- a/arch/powerpc/include/asm/xive.h
>> +++ b/arch/powerpc/include/asm/xive.h
>> @@ -73,6 +73,8 @@ struct xive_q {
>>  	u32			esc_irq;
>>  	atomic_t		count;
>>  	atomic_t		pending_count;
>> +	u64			guest_qpage;
>> +	u32			guest_qsize;
>>  };
>>  
>>  /* Global enable flags for the XIVE support */
>> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
>> index 91899c7f9abd..177e43f3edaf 100644
>> --- a/arch/powerpc/include/uapi/asm/kvm.h
>> +++ b/arch/powerpc/include/uapi/asm/kvm.h
>> @@ -679,6 +679,7 @@ struct kvm_ppc_cpu_char {
>>  #define KVM_DEV_XIVE_GRP_CTRL		1
>>  #define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source attributes */
>>  #define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source attributes */
>> +#define KVM_DEV_XIVE_GRP_EQ_CONFIG	4	/* 64-bit eq attributes */
>>  
>>  /* Layout of 64-bit XIVE source attribute values */
>>  #define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
>> @@ -694,4 +695,24 @@ struct kvm_ppc_cpu_char {
>>  #define KVM_XIVE_SOURCE_EISN_SHIFT	33
>>  #define KVM_XIVE_SOURCE_EISN_MASK	0xfffffffe00000000ULL
>>  
>> +/* Layout of 64-bit eq attribute */
>> +#define KVM_XIVE_EQ_PRIORITY_SHIFT	0
>> +#define KVM_XIVE_EQ_PRIORITY_MASK	0x7
>> +#define KVM_XIVE_EQ_SERVER_SHIFT	3
>> +#define KVM_XIVE_EQ_SERVER_MASK		0xfffffff8ULL
>> +
>> +/* Layout of 64-bit eq attribute values */
>> +struct kvm_ppc_xive_eq {
>> +	__u32 flags;
>> +	__u32 qsize;
>> +	__u64 qpage;
>> +	__u32 qtoggle;
>> +	__u32 qindex;
>> +	__u8  pad[40];
>> +};
>> +
>> +#define KVM_XIVE_EQ_FLAG_ENABLED	0x00000001
>> +#define KVM_XIVE_EQ_FLAG_ALWAYS_NOTIFY	0x00000002
>> +#define KVM_XIVE_EQ_FLAG_ESCALATE	0x00000004
>> +
>>  #endif /* __LINUX_KVM_POWERPC_H */
>> diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xive.h
>> index ab3ac152980d..6660d138c6b7 100644
>> --- a/arch/powerpc/kvm/book3s_xive.h
>> +++ b/arch/powerpc/kvm/book3s_xive.h
>> @@ -267,6 +267,8 @@ struct kvmppc_xive_src_block *kvmppc_xive_create_src_block(
>>  	struct kvmppc_xive *xive, int irq);
>>  void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb);
>>  int kvmppc_xive_select_target(struct kvm *kvm, u32 *server, u8 prio);
>> +int kvmppc_xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio,
>> +				  bool single_escalation);
>>  
>>  #endif /* CONFIG_KVM_XICS */
>>  #endif /* _KVM_PPC_BOOK3S_XICS_H */
>> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
>> index 086da91d7c6e..7431e31bc541 100644
>> --- a/arch/powerpc/kvm/book3s_xive.c
>> +++ b/arch/powerpc/kvm/book3s_xive.c
>> @@ -166,7 +166,8 @@ static irqreturn_t xive_esc_irq(int irq, void *data)
>>  	return IRQ_HANDLED;
>>  }
>>  
>> -static int xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio)
>> +int kvmppc_xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio,
>> +				  bool single_escalation)
>>  {
>>  	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
>>  	struct xive_q *q = &xc->queues[prio];
>> @@ -185,7 +186,7 @@ static int xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio)
>>  		return -EIO;
>>  	}
>>  
>> -	if (xc->xive->single_escalation)
>> +	if (single_escalation)
>>  		name = kasprintf(GFP_KERNEL, "kvm-%d-%d",
>>  				 vcpu->kvm->arch.lpid, xc->server_num);
>>  	else
>> @@ -217,7 +218,7 @@ static int xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio)
>>  	 * interrupt, thus leaving it effectively masked after
>>  	 * it fires once.
>>  	 */
>> -	if (xc->xive->single_escalation) {
>> +	if (single_escalation) {
>>  		struct irq_data *d = irq_get_irq_data(xc->esc_virq[prio]);
>>  		struct xive_irq_data *xd = irq_data_get_irq_handler_data(d);
>>  
>> @@ -291,7 +292,8 @@ static int xive_check_provisioning(struct kvm *kvm, u8 prio)
>>  			continue;
>>  		rc = xive_provision_queue(vcpu, prio);
>>  		if (rc == 0 && !xive->single_escalation)
>> -			xive_attach_escalation(vcpu, prio);
>> +			kvmppc_xive_attach_escalation(vcpu, prio,
>> +						      xive->single_escalation);
>>  		if (rc)
>>  			return rc;
>>  	}
>> @@ -1219,7 +1221,8 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
>>  		if (xive->qmap & (1 << i)) {
>>  			r = xive_provision_queue(vcpu, i);
>>  			if (r == 0 && !xive->single_escalation)
>> -				xive_attach_escalation(vcpu, i);
>> +				kvmppc_xive_attach_escalation(
>> +					vcpu, i, xive->single_escalation);
>>  			if (r)
>>  				goto bail;
>>  		} else {
>> @@ -1234,7 +1237,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
>>  	}
>>  
>>  	/* If not done above, attach priority 0 escalation */
>> -	r = xive_attach_escalation(vcpu, 0);
>> +	r = kvmppc_xive_attach_escalation(vcpu, 0, xive->single_escalation);
>>  	if (r)
>>  		goto bail;
>>  
>> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
>> index cb5a5c6e05af..34a35bcf550c 100644
>> --- a/arch/powerpc/kvm/book3s_xive_native.c
>> +++ b/arch/powerpc/kvm/book3s_xive_native.c
>> @@ -341,6 +341,201 @@ static int kvmppc_xive_native_set_source_config(struct kvmppc_xive *xive,
>>  						       priority, eisn);
>>  }
>>  
>> +static int xive_native_validate_queue_size(u32 qsize)
>> +{
>> +	switch (qsize) {
>> +	case 12:
>> +	case 16:
>> +	case 21:
>> +	case 24:
>> +	case 0:
>> +		return 0;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int kvmppc_xive_native_set_queue_config(struct kvmppc_xive *xive,
>> +					       long eq_idx, u64 addr)
>> +{
>> +	struct kvm *kvm = xive->kvm;
>> +	struct kvm_vcpu *vcpu;
>> +	struct kvmppc_xive_vcpu *xc;
>> +	void __user *ubufp = (u64 __user *) addr;
>> +	u32 server;
>> +	u8 priority;
>> +	struct kvm_ppc_xive_eq kvm_eq;
>> +	int rc;
>> +	__be32 *qaddr = 0;
>> +	struct page *page;
>> +	struct xive_q *q;
>> +
>> +	/*
>> +	 * Demangle priority/server tuple from the EQ index
>> +	 */
>> +	priority = (eq_idx & KVM_XIVE_EQ_PRIORITY_MASK) >>
>> +		KVM_XIVE_EQ_PRIORITY_SHIFT;
>> +	server = (eq_idx & KVM_XIVE_EQ_SERVER_MASK) >>
>> +		KVM_XIVE_EQ_SERVER_SHIFT;
>> +
>> +	if (copy_from_user(&kvm_eq, ubufp, sizeof(kvm_eq)))
>> +		return -EFAULT;
>> +
>> +	vcpu = kvmppc_xive_find_server(kvm, server);
>> +	if (!vcpu) {
>> +		pr_err("Can't find server %d\n", server);
>> +		return -ENOENT;
>> +	}
>> +	xc = vcpu->arch.xive_vcpu;
>> +
>> +	if (priority != xive_prio_from_guest(priority)) {
>> +		pr_err("Trying to restore invalid queue %d for VCPU %d\n",
>> +		       priority, server);
>> +		return -EINVAL;
>> +	}
>> +	q = &xc->queues[priority];
> 
> You need to validate the 'flags' field (AFAICT we don't actually have
> any flags yet, so it's only valid it if is 0.

Well, we should set the ESCALATE flags and ALWAYS_NOTIFY also but this
is already set by xive_native_configure_queue(). I will take a closer look 
and document. 

>> +
>> +	pr_devel("%s VCPU %d priority %d fl:%x sz:%d addr:%llx g:%d idx:%d\n",
>> +		 __func__, server, priority, kvm_eq.flags,
>> +		 kvm_eq.qsize, kvm_eq.qpage, kvm_eq.qtoggle, kvm_eq.qindex);
>> +
>> +	rc = xive_native_validate_queue_size(kvm_eq.qsize);
>> +	if (rc) {
>> +		pr_err("invalid queue size %d\n", kvm_eq.qsize);
>> +		return rc;
>> +	}
>> +
>> +	/* reset queue and disable queueing */
>> +	if (!kvm_eq.qsize) {
>> +		q->guest_qpage = 0;
>> +		q->guest_qsize = 0;
>> +
>> +		rc = xive_native_configure_queue(xc->vp_id, q, priority,
>> +						 NULL, 0, true);
>> +		if (rc) {
>> +			pr_err("Failed to reset queue %d for VCPU %d: %d\n",
>> +			       priority, xc->server_num, rc);
>> +			return rc;
>> +		}
>> +
>> +		if (q->qpage) {
>> +			put_page(virt_to_page(q->qpage));
>> +			q->qpage = NULL;
>> +		}
>> +
>> +		return 0;
>> +	}
>> +
>> +
>> +	page = gfn_to_page(kvm, gpa_to_gfn(kvm_eq.qpage));
>> +	if (is_error_page(page)) {
>> +		pr_warn("Couldn't get guest page for %llx!\n", kvm_eq.qpage);
>> +		return -ENOMEM;
> 
> Nit: I don't think ENOMEM is the right error here.  ENOMEM indicates
> that the kernel couldn't allocate enough memory to complete whatever
> you asked.  Here the problem is the user supplied a bad guest address,
> which is a rather different error.  EFAULT is closer, but still not
> quite right, since it could be a valid user address but not a valid
> guest address.  There are probably existing KVM calls that could hit
> this problem, I wonder what they use.

I have seen a -EINVAL (s390) and a -EFAULT (x86)

Thanks,

C. 

>> +	}
>> +	qaddr = page_to_virt(page) + (kvm_eq.qpage & ~PAGE_MASK);
>> +
>> +	/* Backup queue page guest address for migration */
>> +	q->guest_qpage = kvm_eq.qpage;
>> +	q->guest_qsize = kvm_eq.qsize;
>> +
>> +	rc = xive_native_configure_queue(xc->vp_id, q, priority,
>> +					 (__be32 *) qaddr, kvm_eq.qsize, true);
>> +	if (rc) {
>> +		pr_err("Failed to configure queue %d for VCPU %d: %d\n",
>> +		       priority, xc->server_num, rc);
>> +		put_page(page);
>> +		return rc;
>> +	}
>> +
>> +	rc = xive_native_set_queue_state(xc->vp_id, priority, kvm_eq.qtoggle,
>> +					 kvm_eq.qindex);
>> +	if (rc)
>> +		goto error;
>> +
>> +	rc = kvmppc_xive_attach_escalation(vcpu, priority,
>> +					   xive->single_escalation);
>> +error:
>> +	if (rc)
>> +		kvmppc_xive_native_cleanup_queue(vcpu, priority);
>> +	return rc;
>> +}
>> +
>> +static int kvmppc_xive_native_get_queue_config(struct kvmppc_xive *xive,
>> +					       long eq_idx, u64 addr)
>> +{
>> +	struct kvm *kvm = xive->kvm;
>> +	struct kvm_vcpu *vcpu;
>> +	struct kvmppc_xive_vcpu *xc;
>> +	struct xive_q *q;
>> +	void __user *ubufp = (u64 __user *) addr;
>> +	u32 server;
>> +	u8 priority;
>> +	struct kvm_ppc_xive_eq kvm_eq;
>> +	u64 qpage;
>> +	u64 qsize;
>> +	u64 qeoi_page;
>> +	u32 escalate_irq;
>> +	u64 qflags;
>> +	int rc;
>> +
>> +	/*
>> +	 * Demangle priority/server tuple from the EQ index
>> +	 */
>> +	priority = (eq_idx & KVM_XIVE_EQ_PRIORITY_MASK) >>
>> +		KVM_XIVE_EQ_PRIORITY_SHIFT;
>> +	server = (eq_idx & KVM_XIVE_EQ_SERVER_MASK) >>
>> +		KVM_XIVE_EQ_SERVER_SHIFT;
>> +
>> +	vcpu = kvmppc_xive_find_server(kvm, server);
>> +	if (!vcpu) {
>> +		pr_err("Can't find server %d\n", server);
>> +		return -ENOENT;
>> +	}
>> +	xc = vcpu->arch.xive_vcpu;
>> +
>> +	if (priority != xive_prio_from_guest(priority)) {
>> +		pr_err("invalid priority for queue %d for VCPU %d\n",
>> +		       priority, server);
>> +		return -EINVAL;
>> +	}
>> +	q = &xc->queues[priority];
>> +
>> +	memset(&kvm_eq, 0, sizeof(kvm_eq));
>> +
>> +	if (!q->qpage)
>> +		return 0;
>> +
>> +	rc = xive_native_get_queue_info(xc->vp_id, priority, &qpage, &qsize,
>> +					&qeoi_page, &escalate_irq, &qflags);
>> +	if (rc)
>> +		return rc;
>> +
>> +	kvm_eq.flags = 0;
>> +	if (qflags & OPAL_XIVE_EQ_ENABLED)
>> +		kvm_eq.flags |= KVM_XIVE_EQ_FLAG_ENABLED;
>> +	if (qflags & OPAL_XIVE_EQ_ALWAYS_NOTIFY)
>> +		kvm_eq.flags |= KVM_XIVE_EQ_FLAG_ALWAYS_NOTIFY;
>> +	if (qflags & OPAL_XIVE_EQ_ESCALATE)
>> +		kvm_eq.flags |= KVM_XIVE_EQ_FLAG_ESCALATE;
>> +
>> +	kvm_eq.qsize = q->guest_qsize;
>> +	kvm_eq.qpage = q->guest_qpage;
>> +
>> +	rc = xive_native_get_queue_state(xc->vp_id, priority, &kvm_eq.qtoggle,
>> +					 &kvm_eq.qindex);
>> +	if (rc)
>> +		return rc;
>> +
>> +	pr_devel("%s VCPU %d priority %d fl:%x sz:%d addr:%llx g:%d idx:%d\n",
>> +		 __func__, server, priority, kvm_eq.flags,
>> +		 kvm_eq.qsize, kvm_eq.qpage, kvm_eq.qtoggle, kvm_eq.qindex);
>> +
>> +	if (copy_to_user(ubufp, &kvm_eq, sizeof(kvm_eq)))
>> +		return -EFAULT;
>> +
>> +	return 0;
>> +}
>> +
>>  static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>>  				       struct kvm_device_attr *attr)
>>  {
>> @@ -355,6 +550,9 @@ static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>>  	case KVM_DEV_XIVE_GRP_SOURCE_CONFIG:
>>  		return kvmppc_xive_native_set_source_config(xive, attr->attr,
>>  							    attr->addr);
>> +	case KVM_DEV_XIVE_GRP_EQ_CONFIG:
>> +		return kvmppc_xive_native_set_queue_config(xive, attr->attr,
>> +							   attr->addr);
>>  	}
>>  	return -ENXIO;
>>  }
>> @@ -362,6 +560,13 @@ static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>>  static int kvmppc_xive_native_get_attr(struct kvm_device *dev,
>>  				       struct kvm_device_attr *attr)
>>  {
>> +	struct kvmppc_xive *xive = dev->private;
>> +
>> +	switch (attr->group) {
>> +	case KVM_DEV_XIVE_GRP_EQ_CONFIG:
>> +		return kvmppc_xive_native_get_queue_config(xive, attr->attr,
>> +							   attr->addr);
>> +	}
>>  	return -ENXIO;
>>  }
>>  
>> @@ -377,6 +582,8 @@ static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
>>  		    attr->attr < KVMPPC_XIVE_NR_IRQS)
>>  			return 0;
>>  		break;
>> +	case KVM_DEV_XIVE_GRP_EQ_CONFIG:
>> +		return 0;
>>  	}
>>  	return -ENXIO;
>>  }
>> diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/virtual/kvm/devices/xive.txt
>> index 4f513a1880c7..c0b5d9bd43fb 100644
>> --- a/Documentation/virtual/kvm/devices/xive.txt
>> +++ b/Documentation/virtual/kvm/devices/xive.txt
>> @@ -52,3 +52,32 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
>>      -ENXIO:  CPU event queues not configured or configuration of the
>>               underlying HW interrupt failed
>>      -EBUSY:  No CPU available to serve interrupt
>> +
>> +  4. KVM_DEV_XIVE_GRP_EQ_CONFIG (read-write)
>> +  Configures an event queue of a CPU
>> +  Attributes:
>> +    EQ descriptor identifier (64-bit)
>> +  The EQ descriptor identifier is a tuple (server, priority) :
>> +  bits:     | 63   ....  32 | 31 .. 3 |  2 .. 0
>> +  values:   |    unused     |  server | priority
>> +  The kvm_device_attr.addr points to :
>> +    struct kvm_ppc_xive_eq {
>> +	__u32 flags;
>> +	__u32 qsize;
>> +	__u64 qpage;
>> +	__u32 qtoggle;
>> +	__u32 qindex;
>> +	__u8  pad[40];
>> +    };
>> +  - flags: queue flags
>> +  - qsize: queue size (power of 2)
>> +  - qpage: real address of queue
>> +  - qtoggle: current queue toggle bit
>> +  - qindex: current queue index
>> +  - pad: reserved for future use
>> +  Errors:
>> +    -ENOENT: Invalid CPU number
>> +    -EINVAL: Invalid priority or invalid queue size
>> +    -EFAULT: Invalid user pointer for attr->addr.
>> +    -ENOMEM: Invalid queue address
>> +    -EIO:    Configuration of the underlying HW failed
> 

