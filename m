Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271C0C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 15:52:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A878F2082E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 15:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A878F2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tXKG4pXbzDqJs
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 02:52:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.40.29; helo=14.mo4.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 14.mo4.mail-out.ovh.net (14.mo4.mail-out.ovh.net [46.105.40.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tX9z69ctzDqJc
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 02:46:14 +1100 (AEDT)
Received: from player763.ha.ovh.net (unknown [10.109.160.93])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 2A0E51D4813
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 16:46:12 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player763.ha.ovh.net (Postfix) with ESMTPSA id 5973D2599025;
 Mon,  4 Feb 2019 15:46:01 +0000 (UTC)
Subject: Re: [PATCH 14/19] KVM: PPC: Book3S HV: add a control to make the XIVE
 EQ pages dirty
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-15-clg@kaod.org> <20190204051833.GG1927@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c5c3f60a-dfb0-4641-901d-a41f412d80fc@kaod.org>
Date: Mon, 4 Feb 2019 16:46:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204051833.GG1927@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6792272664827431815
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrkeeggdekudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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

On 2/4/19 6:18 AM, David Gibson wrote:
> On Mon, Jan 07, 2019 at 07:43:26PM +0100, Cédric Le Goater wrote:
>> When the VM is stopped in a migration sequence, the sources are masked
>> and the XIVE IC is synced to stabilize the EQs. When done, the KVM
>> ioctl KVM_DEV_XIVE_SAVE_EQ_PAGES is called to mark dirty the EQ pages.
>>
>> The migration can then transfer the remaining dirty pages to the
>> destination and start collecting the state of the devices.
> 
> Is there a reason to make this a separate step from the SYNC
> operation?

Hmm, apart from letting QEMU orchestrate the migration step by step, no.

We could merge the SYNC and the SAVE_EQ_PAGES in a single KVM operation. 
I think that should be fine. 

However, it does not make sense to call this operation without the VM 
being stopped. I wonder how this can checked from KVM. May be we can't. 

C. 

> 
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  arch/powerpc/include/uapi/asm/kvm.h   |  1 +
>>  arch/powerpc/kvm/book3s_xive_native.c | 40 +++++++++++++++++++++++++++
>>  2 files changed, 41 insertions(+)
>>
>> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
>> index f3b859223b80..1a8740629acf 100644
>> --- a/arch/powerpc/include/uapi/asm/kvm.h
>> +++ b/arch/powerpc/include/uapi/asm/kvm.h
>> @@ -680,6 +680,7 @@ struct kvm_ppc_cpu_char {
>>  #define   KVM_DEV_XIVE_GET_ESB_FD	1
>>  #define   KVM_DEV_XIVE_GET_TIMA_FD	2
>>  #define   KVM_DEV_XIVE_VC_BASE		3
>> +#define   KVM_DEV_XIVE_SAVE_EQ_PAGES	4
>>  #define KVM_DEV_XIVE_GRP_SOURCES	2	/* 64-bit source attributes */
>>  #define KVM_DEV_XIVE_GRP_SYNC		3	/* 64-bit source attributes */
>>  
>> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
>> index a8052867afc1..f2de1bcf3b35 100644
>> --- a/arch/powerpc/kvm/book3s_xive_native.c
>> +++ b/arch/powerpc/kvm/book3s_xive_native.c
>> @@ -373,6 +373,43 @@ static int kvmppc_xive_native_get_tima_fd(struct kvmppc_xive *xive, u64 addr)
>>  	return put_user(ret, ubufp);
>>  }
>>  
>> +static int kvmppc_xive_native_vcpu_save_eq_pages(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
>> +	unsigned int prio;
>> +
>> +	if (!xc)
>> +		return -ENOENT;
>> +
>> +	for (prio = 0; prio < KVMPPC_XIVE_Q_COUNT; prio++) {
>> +		struct xive_q *q = &xc->queues[prio];
>> +
>> +		if (!q->qpage)
>> +			continue;
>> +
>> +		/* Mark EQ page dirty for migration */
>> +		mark_page_dirty(vcpu->kvm, gpa_to_gfn(q->guest_qpage));
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int kvmppc_xive_native_save_eq_pages(struct kvmppc_xive *xive)
>> +{
>> +	struct kvm *kvm = xive->kvm;
>> +	struct kvm_vcpu *vcpu;
>> +	unsigned int i;
>> +
>> +	pr_devel("%s\n", __func__);
>> +
>> +	mutex_lock(&kvm->lock);
>> +	kvm_for_each_vcpu(i, vcpu, kvm) {
>> +		kvmppc_xive_native_vcpu_save_eq_pages(vcpu);
>> +	}
>> +	mutex_unlock(&kvm->lock);
>> +
>> +	return 0;
>> +}
>> +
>>  static int xive_native_validate_queue_size(u32 qsize)
>>  {
>>  	switch (qsize) {
>> @@ -498,6 +535,8 @@ static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>>  		switch (attr->attr) {
>>  		case KVM_DEV_XIVE_VC_BASE:
>>  			return kvmppc_xive_native_set_vc_base(xive, attr->addr);
>> +		case KVM_DEV_XIVE_SAVE_EQ_PAGES:
>> +			return kvmppc_xive_native_save_eq_pages(xive);
>>  		}
>>  		break;
>>  	case KVM_DEV_XIVE_GRP_SOURCES:
>> @@ -538,6 +577,7 @@ static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
>>  		case KVM_DEV_XIVE_GET_ESB_FD:
>>  		case KVM_DEV_XIVE_GET_TIMA_FD:
>>  		case KVM_DEV_XIVE_VC_BASE:
>> +		case KVM_DEV_XIVE_SAVE_EQ_PAGES:
>>  			return 0;
>>  		}
>>  		break;
> 

