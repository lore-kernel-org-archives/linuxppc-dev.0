Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01A8C282CC
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 16:18:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29AA921852
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 16:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29AA921852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tXvR0zX3zDqLK
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 03:18:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=178.33.251.8; helo=13.mo4.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 13.mo4.mail-out.ovh.net (13.mo4.mail-out.ovh.net [178.33.251.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tXsY03GLzDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 03:17:03 +1100 (AEDT)
Received: from player792.ha.ovh.net (unknown [10.109.146.168])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 107611D0E61
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 17:07:36 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player792.ha.ovh.net (Postfix) with ESMTPSA id 8B2002702780;
 Mon,  4 Feb 2019 16:07:29 +0000 (UTC)
Subject: Re: [PATCH 15/19] KVM: PPC: Book3S HV: add get/set accessors for the
 source configuration
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-16-clg@kaod.org> <20190204052148.GH1927@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <02ee0470-3c6a-5c5c-a903-44e172ce1ed5@kaod.org>
Date: Mon, 4 Feb 2019 17:07:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204052148.GH1927@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 7153968008228735879
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrkeeggdekhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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

On 2/4/19 6:21 AM, David Gibson wrote:
> On Mon, Jan 07, 2019 at 07:43:27PM +0100, Cédric Le Goater wrote:
>> Theses are use to capure the XIVE EAS table of the KVM device, the
>> configuration of the source targets.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  arch/powerpc/include/uapi/asm/kvm.h   | 11 ++++
>>  arch/powerpc/kvm/book3s_xive_native.c | 87 +++++++++++++++++++++++++++
>>  2 files changed, 98 insertions(+)
>>
>> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
>> index 1a8740629acf..faf024f39858 100644
>> --- a/arch/powerpc/include/uapi/asm/kvm.h
>> +++ b/arch/powerpc/include/uapi/asm/kvm.h
>> @@ -683,9 +683,20 @@ struct kvm_ppc_cpu_char {
>>  #define   KVM_DEV_XIVE_SAVE_EQ_PAGES	4
>>  #define KVM_DEV_XIVE_GRP_SOURCES	2	/* 64-bit source attributes */
>>  #define KVM_DEV_XIVE_GRP_SYNC		3	/* 64-bit source attributes */
>> +#define KVM_DEV_XIVE_GRP_EAS		4	/* 64-bit eas attributes */
>>  
>>  /* Layout of 64-bit XIVE source attribute values */
>>  #define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
>>  #define KVM_XIVE_LEVEL_ASSERTED		(1ULL << 1)
>>  
>> +/* Layout of 64-bit eas attribute values */
>> +#define KVM_XIVE_EAS_PRIORITY_SHIFT	0
>> +#define KVM_XIVE_EAS_PRIORITY_MASK	0x7
>> +#define KVM_XIVE_EAS_SERVER_SHIFT	3
>> +#define KVM_XIVE_EAS_SERVER_MASK	0xfffffff8ULL
>> +#define KVM_XIVE_EAS_MASK_SHIFT		32
>> +#define KVM_XIVE_EAS_MASK_MASK		0x100000000ULL
>> +#define KVM_XIVE_EAS_EISN_SHIFT		33
>> +#define KVM_XIVE_EAS_EISN_MASK		0xfffffffe00000000ULL
>> +
>>  #endif /* __LINUX_KVM_POWERPC_H */
>> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
>> index f2de1bcf3b35..0468b605baa7 100644
>> --- a/arch/powerpc/kvm/book3s_xive_native.c
>> +++ b/arch/powerpc/kvm/book3s_xive_native.c
>> @@ -525,6 +525,88 @@ static int kvmppc_xive_native_sync(struct kvmppc_xive *xive, long irq, u64 addr)
>>  	return 0;
>>  }
>>  
>> +static int kvmppc_xive_native_set_eas(struct kvmppc_xive *xive, long irq,
>> +				      u64 addr)
> 
> I'd prefer to avoid the name "EAS" here.  IIUC these aren't "raw" EAS
> values, but rather essentially the "source config" in the terminology
> of the PAPR hcalls.  Which, yes, is basically implemented by setting
> the EAS, but since it's the PAPR architected state that we need to
> preserve across migration, I'd prefer to stick as close as we can to
> the PAPR terminology.

But we don't have an equivalent name in the PAPR specs for the tuple 
(prio, server). We could use the generic 'target' name may be ? even 
if this is usually referring to a CPU number.

Or, IVE (Interrupt Vector Entry) ? which makes some sense. 
This is was the former name in HW. I think we recycle it for KVM. 
 
C.  

> 
>> +{
>> +	struct kvmppc_xive_src_block *sb;
>> +	struct kvmppc_xive_irq_state *state;
>> +	u64 __user *ubufp = (u64 __user *) addr;
>> +	u16 src;
>> +	u64 kvm_eas;
>> +	u32 server;
>> +	u8 priority;
>> +	u32 eisn;
>> +
>> +	sb = kvmppc_xive_find_source(xive, irq, &src);
>> +	if (!sb)
>> +		return -ENOENT;
>> +
>> +	state = &sb->irq_state[src];
>> +
>> +	if (!state->valid)
>> +		return -EINVAL;
>> +
>> +	if (get_user(kvm_eas, ubufp))
>> +		return -EFAULT;
>> +
>> +	pr_devel("%s irq=0x%lx eas=%016llx\n", __func__, irq, kvm_eas);
>> +
>> +	priority = (kvm_eas & KVM_XIVE_EAS_PRIORITY_MASK) >>
>> +		KVM_XIVE_EAS_PRIORITY_SHIFT;
>> +	server = (kvm_eas & KVM_XIVE_EAS_SERVER_MASK) >>
>> +		KVM_XIVE_EAS_SERVER_SHIFT;
>> +	eisn = (kvm_eas & KVM_XIVE_EAS_EISN_MASK) >> KVM_XIVE_EAS_EISN_SHIFT;
>> +
>> +	if (priority != xive_prio_from_guest(priority)) {
>> +		pr_err("invalid priority for queue %d for VCPU %d\n",
>> +		       priority, server);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return kvmppc_xive_native_set_source_config(xive, sb, state, server,
>> +						    priority, eisn);
>> +}
>> +
>> +static int kvmppc_xive_native_get_eas(struct kvmppc_xive *xive, long irq,
>> +				      u64 addr)
>> +{
>> +	struct kvmppc_xive_src_block *sb;
>> +	struct kvmppc_xive_irq_state *state;
>> +	u64 __user *ubufp = (u64 __user *) addr;
>> +	u16 src;
>> +	u64 kvm_eas;
>> +
>> +	sb = kvmppc_xive_find_source(xive, irq, &src);
>> +	if (!sb)
>> +		return -ENOENT;
>> +
>> +	state = &sb->irq_state[src];
>> +
>> +	if (!state->valid)
>> +		return -EINVAL;
>> +
>> +	arch_spin_lock(&sb->lock);
>> +
>> +	if (state->act_priority == MASKED)
>> +		kvm_eas = KVM_XIVE_EAS_MASK_MASK;
>> +	else {
>> +		kvm_eas = (state->act_priority << KVM_XIVE_EAS_PRIORITY_SHIFT) &
>> +			KVM_XIVE_EAS_PRIORITY_MASK;
>> +		kvm_eas |= (state->act_server << KVM_XIVE_EAS_SERVER_SHIFT) &
>> +			KVM_XIVE_EAS_SERVER_MASK;
>> +		kvm_eas |= ((u64) state->eisn << KVM_XIVE_EAS_EISN_SHIFT) &
>> +			KVM_XIVE_EAS_EISN_MASK;
>> +	}
>> +	arch_spin_unlock(&sb->lock);
>> +
>> +	pr_devel("%s irq=0x%lx eas=%016llx\n", __func__, irq, kvm_eas);
>> +
>> +	if (put_user(kvm_eas, ubufp))
>> +		return -EFAULT;
>> +
>> +	return 0;
>> +}
>> +
>>  static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>>  				       struct kvm_device_attr *attr)
>>  {
>> @@ -544,6 +626,8 @@ static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>>  						     attr->addr);
>>  	case KVM_DEV_XIVE_GRP_SYNC:
>>  		return kvmppc_xive_native_sync(xive, attr->attr, attr->addr);
>> +	case KVM_DEV_XIVE_GRP_EAS:
>> +		return kvmppc_xive_native_set_eas(xive, attr->attr, attr->addr);
>>  	}
>>  	return -ENXIO;
>>  }
>> @@ -564,6 +648,8 @@ static int kvmppc_xive_native_get_attr(struct kvm_device *dev,
>>  			return kvmppc_xive_native_get_vc_base(xive, attr->addr);
>>  		}
>>  		break;
>> +	case KVM_DEV_XIVE_GRP_EAS:
>> +		return kvmppc_xive_native_get_eas(xive, attr->attr, attr->addr);
>>  	}
>>  	return -ENXIO;
>>  }
>> @@ -583,6 +669,7 @@ static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
>>  		break;
>>  	case KVM_DEV_XIVE_GRP_SOURCES:
>>  	case KVM_DEV_XIVE_GRP_SYNC:
>> +	case KVM_DEV_XIVE_GRP_EAS:
>>  		if (attr->attr >= KVMPPC_XIVE_FIRST_IRQ &&
>>  		    attr->attr < KVMPPC_XIVE_NR_IRQS)
>>  			return 0;
> 

