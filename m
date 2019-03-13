Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FC8C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 12:31:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C732214AE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 12:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C732214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KB651ZPqzDqKL
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 23:31:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=178.33.111.247; helo=4.mo5.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 11679 seconds by postgrey-1.36 at bilbo;
 Wed, 13 Mar 2019 23:27:28 AEDT
Received: from 4.mo5.mail-out.ovh.net (4.mo5.mail-out.ovh.net [178.33.111.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KB1X1C5fzDqJq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 23:27:24 +1100 (AEDT)
Received: from player692.ha.ovh.net (unknown [10.109.160.62])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id D3C0A2244B3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 12:49:13 +0100 (CET)
Received: from kaod.org (lfbn-1-2226-17.w90-76.abo.wanadoo.fr [90.76.48.17])
 (Authenticated sender: clg@kaod.org)
 by player692.ha.ovh.net (Postfix) with ESMTPSA id 4D3F83A0B865;
 Wed, 13 Mar 2019 11:49:00 +0000 (UTC)
Subject: Re: [PATCH v2 09/16] KVM: PPC: Book3S HV: XIVE: add a control to
 dirty the XIVE EQ pages
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-10-clg@kaod.org>
 <20190225025329.GM7668@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e952c257-dbc9-fd4c-fd10-20533c4b2c42@kaod.org>
Date: Wed, 13 Mar 2019 12:48:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190225025329.GM7668@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17165751457596672903
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrhedtgdefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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

On 2/25/19 3:53 AM, David Gibson wrote:
> On Fri, Feb 22, 2019 at 12:28:33PM +0100, Cédric Le Goater wrote:
>> When migration of a VM is initiated, a first copy of the RAM is
>> transferred to the destination before the VM is stopped, but there is
>> no guarantee that the EQ pages in which the event notification are
>> queued have not been modified.
>>
>> To make sure migration will capture a consistent memory state, the
>> XIVE device should perform a XIVE quiesce sequence to stop the flow of
>> event notifications and stabilize the EQs. This is the purpose of the
>> KVM_DEV_XIVE_EQ_SYNC control which will also marks the EQ pages dirty
>> to force their transfer.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  arch/powerpc/include/uapi/asm/kvm.h        |  1 +
>>  arch/powerpc/kvm/book3s_xive_native.c      | 67 ++++++++++++++++++++++
>>  Documentation/virtual/kvm/devices/xive.txt | 29 ++++++++++
>>  3 files changed, 97 insertions(+)
>>
>> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
>> index 289c504b7c1d..cd78ad1020fe 100644
>> --- a/arch/powerpc/include/uapi/asm/kvm.h
>> +++ b/arch/powerpc/include/uapi/asm/kvm.h
>> @@ -678,6 +678,7 @@ struct kvm_ppc_cpu_char {
>>  /* POWER9 XIVE Native Interrupt Controller */
>>  #define KVM_DEV_XIVE_GRP_CTRL		1
>>  #define   KVM_DEV_XIVE_RESET		1
>> +#define   KVM_DEV_XIVE_EQ_SYNC		2
>>  #define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source attributes */
>>  #define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source attributes */
>>  #define KVM_DEV_XIVE_GRP_EQ_CONFIG	4	/* 64-bit eq attributes */
>> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
>> index dd2a9d411fe7..3debc876d5a0 100644
>> --- a/arch/powerpc/kvm/book3s_xive_native.c
>> +++ b/arch/powerpc/kvm/book3s_xive_native.c
>> @@ -640,6 +640,70 @@ static int kvmppc_xive_reset(struct kvmppc_xive *xive)
>>  	return 0;
>>  }
>>  
>> +static void kvmppc_xive_native_sync_sources(struct kvmppc_xive_src_block *sb)
>> +{
>> +	int j;
>> +
>> +	for (j = 0; j < KVMPPC_XICS_IRQ_PER_ICS; j++) {
>> +		struct kvmppc_xive_irq_state *state = &sb->irq_state[j];
>> +		struct xive_irq_data *xd;
>> +		u32 hw_num;
>> +
>> +		if (!state->valid)
>> +			continue;
>> +		if (state->act_priority == MASKED)
> 
> Is this correct?  If you masked an irq, then immediately did a sync,
> couldn't there still be some of the irqs in flight?  I thought the
> reason we needed a sync was that masking and other such operations
> _didn't_ implicitly synchronize.

The struct kvmppc_xive_irq_state reflects the state of the EAS 
configuration and not the state of the source. The source is masked 
setting the PQ bits to '-Q', which is what is being done before calling 
the KVM_DEV_XIVE_EQ_SYNC control. 

If a source EAS is configured, OPAL syncs the XIVE IC of the source and
the XIVE IC of the previous target if any.  

So I think we are fine.

C.
  

  
>> +			continue;
>> +
>> +		arch_spin_lock(&sb->lock);
>> +		kvmppc_xive_select_irq(state, &hw_num, &xd);
>> +		xive_native_sync_source(hw_num);
>> +		xive_native_sync_queue(hw_num);
>> +		arch_spin_unlock(&sb->lock);
>> +	}
>> +}
>> +
>> +static int kvmppc_xive_native_vcpu_eq_sync(struct kvm_vcpu *vcpu)
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
>> +static int kvmppc_xive_native_eq_sync(struct kvmppc_xive *xive)
>> +{
>> +	struct kvm *kvm = xive->kvm;
>> +	struct kvm_vcpu *vcpu;
>> +	unsigned int i;
>> +
>> +	pr_devel("%s\n", __func__);
>> +
>> +	for (i = 0; i <= xive->max_sbid; i++) {
>> +		if (xive->src_blocks[i])
>> +			kvmppc_xive_native_sync_sources(xive->src_blocks[i]);
>> +	}
>> +
>> +	mutex_lock(&kvm->lock);
>> +	kvm_for_each_vcpu(i, vcpu, kvm) {
>> +		kvmppc_xive_native_vcpu_eq_sync(vcpu);
>> +	}
>> +	mutex_unlock(&kvm->lock);
>> +
>> +	return 0;
>> +}
>> +
>>  static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>>  				       struct kvm_device_attr *attr)
>>  {
>> @@ -650,6 +714,8 @@ static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>>  		switch (attr->attr) {
>>  		case KVM_DEV_XIVE_RESET:
>>  			return kvmppc_xive_reset(xive);
>> +		case KVM_DEV_XIVE_EQ_SYNC:
>> +			return kvmppc_xive_native_eq_sync(xive);
>>  		}
>>  		break;
>>  	case KVM_DEV_XIVE_GRP_SOURCE:
>> @@ -688,6 +754,7 @@ static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
>>  	case KVM_DEV_XIVE_GRP_CTRL:
>>  		switch (attr->attr) {
>>  		case KVM_DEV_XIVE_RESET:
>> +		case KVM_DEV_XIVE_EQ_SYNC:
>>  			return 0;
>>  		}
>>  		break;
>> diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/virtual/kvm/devices/xive.txt
>> index 267634eae9e0..a26be635cff9 100644
>> --- a/Documentation/virtual/kvm/devices/xive.txt
>> +++ b/Documentation/virtual/kvm/devices/xive.txt
>> @@ -23,6 +23,12 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
>>      queues. To be used by kexec and kdump.
>>      Errors: none
>>  
>> +    1.2 KVM_DEV_XIVE_EQ_SYNC (write only)
>> +    Sync all the sources and queues and mark the EQ pages dirty. This
>> +    to make sure that a consistent memory state is captured when
>> +    migrating the VM.
>> +    Errors: none
>> +
>>    2. KVM_DEV_XIVE_GRP_SOURCE (write only)
>>    Initializes a new source in the XIVE device and mask it.
>>    Attributes:
>> @@ -95,3 +101,26 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
>>      -ENOENT: Unknown source number
>>      -EINVAL: Not initialized source number, invalid priority or
>>               invalid CPU number.
>> +
>> +* Migration:
>> +
>> +  Saving the state of a VM using the XIVE native exploitation mode
>> +  should follow a specific sequence. When the VM is stopped :
>> +
>> +  1. Mask all sources (PQ=01) to stop the flow of events.
>> +
>> +  2. Sync the XIVE device with the KVM control KVM_DEV_XIVE_EQ_SYNC to
>> +  flush any in-flight event notification and to stabilize the EQs. At
>> +  this stage, the EQ pages are marked dirty to make sure they are
>> +  transferred in the migration sequence.
>> +
>> +  3. Capture the state of the source targeting, the EQs configuration
>> +  and the state of thread interrupt context registers.
>> +
>> +  Restore is similar :
>> +
>> +  1. Restore the EQ configuration. As targeting depends on it.
>> +  2. Restore targeting
>> +  3. Restore the thread interrupt contexts
>> +  4. Restore the source states
>> +  5. Let the vCPU run
> 

