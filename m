Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA66C282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 18:08:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0C0D2083B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 18:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C0D2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43vCHK581fzDqNP
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 05:08:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.58.91; helo=7.mo178.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 7.mo178.mail-out.ovh.net (7.mo178.mail-out.ovh.net
 [46.105.58.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43vCBZ0ND4zDqMy
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 05:04:04 +1100 (AEDT)
Received: from player789.ha.ovh.net (unknown [10.109.146.163])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 9FA684B3CF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 18:45:13 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n0.emea.ibm.com [195.212.29.162])
 (Authenticated sender: clg@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id 5DA6C25BFDDE;
 Tue,  5 Feb 2019 17:45:05 +0000 (UTC)
Subject: Re: [PATCH 16/19] KVM: PPC: Book3S HV: add get/set accessors for the
 EQ configuration
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-17-clg@kaod.org> <20190204052436.GI1927@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ac74f729-a4ec-6a68-4332-71daffc44d6f@kaod.org>
Date: Tue, 5 Feb 2019 18:45:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204052436.GI1927@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 14674979387709492103
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrkeeigddutddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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

On 2/4/19 6:24 AM, David Gibson wrote:
> On Mon, Jan 07, 2019 at 07:43:28PM +0100, Cédric Le Goater wrote:
>> These are used to capture the XIVE END table of the KVM device. It
>> relies on an OPAL call to retrieve from the XIVE IC the EQ toggle bit
>> and index which are updated by the HW when events are enqueued in the
>> guest RAM.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  arch/powerpc/include/uapi/asm/kvm.h   |  21 ++++
>>  arch/powerpc/kvm/book3s_xive_native.c | 166 ++++++++++++++++++++++++++
>>  2 files changed, 187 insertions(+)
>>
>> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
>> index faf024f39858..95302558ce10 100644
>> --- a/arch/powerpc/include/uapi/asm/kvm.h
>> +++ b/arch/powerpc/include/uapi/asm/kvm.h
>> @@ -684,6 +684,7 @@ struct kvm_ppc_cpu_char {
>>  #define KVM_DEV_XIVE_GRP_SOURCES	2	/* 64-bit source attributes */
>>  #define KVM_DEV_XIVE_GRP_SYNC		3	/* 64-bit source attributes */
>>  #define KVM_DEV_XIVE_GRP_EAS		4	/* 64-bit eas attributes */
>> +#define KVM_DEV_XIVE_GRP_EQ		5	/* 64-bit eq attributes */
>>  
>>  /* Layout of 64-bit XIVE source attribute values */
>>  #define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
>> @@ -699,4 +700,24 @@ struct kvm_ppc_cpu_char {
>>  #define KVM_XIVE_EAS_EISN_SHIFT		33
>>  #define KVM_XIVE_EAS_EISN_MASK		0xfffffffe00000000ULL
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
> 
> Should we pad this in case a) we discover some fields in the EQ that
> we thought weren't relevant to the guest actually are or b) future
> XIVE extensions add something we need to migrate.

The underlying XIVE structure is composed of 32bytes. I will double the
size.

Thanks,

C.


> 
>> +};
>> +
>> +#define KVM_XIVE_EQ_FLAG_ENABLED	0x00000001
>> +#define KVM_XIVE_EQ_FLAG_ALWAYS_NOTIFY	0x00000002
>> +#define KVM_XIVE_EQ_FLAG_ESCALATE	0x00000004
>> +
>> +
>>  #endif /* __LINUX_KVM_POWERPC_H */
>> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
>> index 0468b605baa7..f4eb71eafc57 100644
>> --- a/arch/powerpc/kvm/book3s_xive_native.c
>> +++ b/arch/powerpc/kvm/book3s_xive_native.c
>> @@ -607,6 +607,164 @@ static int kvmppc_xive_native_get_eas(struct kvmppc_xive *xive, long irq,
>>  	return 0;
>>  }
>>  
>> +static int kvmppc_xive_native_set_queue(struct kvmppc_xive *xive, long eq_idx,
>> +				      u64 addr)
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
>> +
>> +	pr_devel("%s VCPU %d priority %d fl:%x sz:%d addr:%llx g:%d idx:%d\n",
>> +		 __func__, server, priority, kvm_eq.flags,
>> +		 kvm_eq.qsize, kvm_eq.qpage, kvm_eq.qtoggle, kvm_eq.qindex);
>> +
>> +	rc = xive_native_validate_queue_size(kvm_eq.qsize);
>> +	if (rc || !kvm_eq.qsize) {
>> +		pr_err("invalid queue size %d\n", kvm_eq.qsize);
>> +		return rc;
>> +	}
>> +
>> +	page = gfn_to_page(kvm, gpa_to_gfn(kvm_eq.qpage));
>> +	if (is_error_page(page)) {
>> +		pr_warn("Couldn't get guest page for %llx!\n", kvm_eq.qpage);
>> +		return -ENOMEM;
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
>> +	rc = kvmppc_xive_attach_escalation(vcpu, priority);
>> +error:
>> +	if (rc)
>> +		xive_native_cleanup_queue(vcpu, priority);
>> +	return rc;
>> +}
>> +
>> +static int kvmppc_xive_native_get_queue(struct kvmppc_xive *xive, long eq_idx,
>> +				      u64 addr)
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
>> @@ -628,6 +786,9 @@ static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>>  		return kvmppc_xive_native_sync(xive, attr->attr, attr->addr);
>>  	case KVM_DEV_XIVE_GRP_EAS:
>>  		return kvmppc_xive_native_set_eas(xive, attr->attr, attr->addr);
>> +	case KVM_DEV_XIVE_GRP_EQ:
>> +		return kvmppc_xive_native_set_queue(xive, attr->attr,
>> +						    attr->addr);
>>  	}
>>  	return -ENXIO;
>>  }
>> @@ -650,6 +811,9 @@ static int kvmppc_xive_native_get_attr(struct kvm_device *dev,
>>  		break;
>>  	case KVM_DEV_XIVE_GRP_EAS:
>>  		return kvmppc_xive_native_get_eas(xive, attr->attr, attr->addr);
>> +	case KVM_DEV_XIVE_GRP_EQ:
>> +		return kvmppc_xive_native_get_queue(xive, attr->attr,
>> +						    attr->addr);
>>  	}
>>  	return -ENXIO;
>>  }
>> @@ -674,6 +838,8 @@ static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
>>  		    attr->attr < KVMPPC_XIVE_NR_IRQS)
>>  			return 0;
>>  		break;
>> +	case KVM_DEV_XIVE_GRP_EQ:
>> +		return 0;
>>  	}
>>  	return -ENXIO;
>>  }
> 

