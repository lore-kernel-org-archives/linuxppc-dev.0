Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFF2C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 08:19:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE9A2147C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 08:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE9A2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44K4WT24r7zDqKN
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 19:19:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.61.149; helo=7.mo177.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 64840 seconds by postgrey-1.36 at bilbo;
 Wed, 13 Mar 2019 19:17:39 AEDT
Received: from 7.mo177.mail-out.ovh.net (7.mo177.mail-out.ovh.net
 [46.105.61.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44K4TH2ZkfzDqLb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 19:17:36 +1100 (AEDT)
Received: from player794.ha.ovh.net (unknown [10.109.146.86])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id A2C20EA3AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 09:17:31 +0100 (CET)
Received: from kaod.org (lfbn-1-2226-17.w90-76.abo.wanadoo.fr [90.76.48.17])
 (Authenticated sender: clg@kaod.org)
 by player794.ha.ovh.net (Postfix) with ESMTPSA id C0B8A399AEA7;
 Wed, 13 Mar 2019 08:17:17 +0000 (UTC)
Subject: Re: [PATCH v2 16/16] KVM: PPC: Book3S HV: XIVE: clear the vCPU
 interrupt presenters
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-17-clg@kaod.org>
 <20190225041858.GT7668@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3604baf2-0a39-6990-968f-1222d32f9278@kaod.org>
Date: Wed, 13 Mar 2019 09:17:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190225041858.GT7668@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13590456301960268679
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrgeelgdduudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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

On 2/25/19 5:18 AM, David Gibson wrote:
> On Fri, Feb 22, 2019 at 12:28:40PM +0100, Cédric Le Goater wrote:
>> When the VM boots, the CAS negotiation process determines which
>> interrupt mode to use and invokes a machine reset. At that time, the
>> previous KVM interrupt device is 'destroyed' before the chosen one is
>> created. Upon destruction, the vCPU interrupt presenters using the KVM
>> device should be cleared first, the machine will reconnect them later
>> to the new device after it is created.
>>
>> When using the KVM device, there is still a race window with the early
>> checks in kvmppc_native_connect_vcpu(). Yet to be fixed.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  arch/powerpc/kvm/book3s_xics.c        | 19 +++++++++++++
>>  arch/powerpc/kvm/book3s_xive.c        | 39 +++++++++++++++++++++++++--
>>  arch/powerpc/kvm/book3s_xive_native.c | 16 +++++++++++
>>  3 files changed, 72 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
>> index f27ee57ab46e..81cdabf4295f 100644
>> --- a/arch/powerpc/kvm/book3s_xics.c
>> +++ b/arch/powerpc/kvm/book3s_xics.c
>> @@ -1342,6 +1342,25 @@ static void kvmppc_xics_free(struct kvm_device *dev)
>>  	struct kvmppc_xics *xics = dev->private;
>>  	int i;
>>  	struct kvm *kvm = xics->kvm;
>> +	struct kvm_vcpu *vcpu;
>> +
>> +	/*
>> +	 * When destroying the VM, the vCPUs are destroyed first and
>> +	 * the vCPU list should be empty. If this is not the case,
>> +	 * then we are simply destroying the device and we should
>> +	 * clean up the vCPU interrupt presenters first.
>> +	 */
>> +	if (atomic_read(&kvm->online_vcpus) != 0) {
>> +		/*
>> +		 * call kick_all_cpus_sync() to ensure that all CPUs
>> +		 * have executed any pending interrupts
>> +		 */
>> +		if (is_kvmppc_hv_enabled(kvm))
>> +			kick_all_cpus_sync();
>> +
>> +		kvm_for_each_vcpu(i, vcpu, kvm)
>> +			kvmppc_xics_free_icp(vcpu);
>> +	}
>>  
>>  	debugfs_remove(xics->dentry);
>>  
>> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
>> index 7a14512b8944..0a1c11d6881c 100644
>> --- a/arch/powerpc/kvm/book3s_xive.c
>> +++ b/arch/powerpc/kvm/book3s_xive.c
>> @@ -1105,11 +1105,19 @@ void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu)
>>  void kvmppc_xive_cleanup_vcpu(struct kvm_vcpu *vcpu)
>>  {
>>  	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
>> -	struct kvmppc_xive *xive = xc->xive;
>> +	struct kvmppc_xive *xive;
>>  	int i;
>>  
>> +	if (!kvmppc_xics_enabled(vcpu))
> 
> This should be kvmppc_xive_enabled(), no?

This is the KVM XICS-on-XIVE device and its IRQ type is KVMPPC_IRQ_XICS.
So this is correct :/ 

May be we should introduce a KVMPPC_IRQ_XICS_ON_XIVE macro to clarify.

> 
>> +		return;
>> +
>> +	if (!xc)
>> +		return;
>> +
>>  	pr_devel("cleanup_vcpu(cpu=%d)\n", xc->server_num);
>>  
>> +	xive = xc->xive;
>> +
>>  	/* Ensure no interrupt is still routed to that VP */
>>  	xc->valid = false;
>>  	kvmppc_xive_disable_vcpu_interrupts(vcpu);
>> @@ -1146,6 +1154,10 @@ void kvmppc_xive_cleanup_vcpu(struct kvm_vcpu *vcpu)
>>  	}
>>  	/* Free the VP */
>>  	kfree(xc);
>> +
>> +	/* Cleanup the vcpu */
>> +	vcpu->arch.irq_type = KVMPPC_IRQ_DEFAULT;
>> +	vcpu->arch.xive_vcpu = NULL;
>>  }
>>  
>>  int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
>> @@ -1163,7 +1175,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
>>  	}
>>  	if (xive->kvm != vcpu->kvm)
>>  		return -EPERM;
>> -	if (vcpu->arch.irq_type)
>> +	if (vcpu->arch.irq_type != KVMPPC_IRQ_DEFAULT)
>>  		return -EBUSY;
>>  	if (kvmppc_xive_find_server(vcpu->kvm, cpu)) {
>>  		pr_devel("Duplicate !\n");
>> @@ -1833,8 +1845,31 @@ static void kvmppc_xive_free(struct kvm_device *dev)
>>  {
>>  	struct kvmppc_xive *xive = dev->private;
>>  	struct kvm *kvm = xive->kvm;
>> +	struct kvm_vcpu *vcpu;
>>  	int i;
>>  
>> +	/*
>> +	 * When destroying the VM, the vCPUs are destroyed first and
>> +	 * the vCPU list should be empty. If this is not the case,
>> +	 * then we are simply destroying the device and we should
>> +	 * clean up the vCPU interrupt presenters first.
>> +	 */
>> +	if (atomic_read(&kvm->online_vcpus) != 0) {
>> +		/*
>> +		 * call kick_all_cpus_sync() to ensure that all CPUs
>> +		 * have executed any pending interrupts
>> +		 */
>> +		if (is_kvmppc_hv_enabled(kvm))
>> +			kick_all_cpus_sync();
>> +
>> +		/*
>> +		 * TODO: There is still a race window with the early
>> +		 * checks in kvmppc_native_connect_vcpu()
>> +		 */
>> +		kvm_for_each_vcpu(i, vcpu, kvm)
>> +			kvmppc_xive_cleanup_vcpu(vcpu);
>> +	}
>> +
>>  	debugfs_remove(xive->dentry);
>>  
>>  	if (kvm)
>> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
>> index bf60870144f1..c0655164d9af 100644
>> --- a/arch/powerpc/kvm/book3s_xive_native.c
>> +++ b/arch/powerpc/kvm/book3s_xive_native.c
>> @@ -909,8 +909,24 @@ static void kvmppc_xive_native_free(struct kvm_device *dev)
>>  {
>>  	struct kvmppc_xive *xive = dev->private;
>>  	struct kvm *kvm = xive->kvm;
>> +	struct kvm_vcpu *vcpu;
>>  	int i;
>>  
>> +	/*
>> +	 * When destroying the VM, the vCPUs are destroyed first and
>> +	 * the vCPU list should be empty. If this is not the case,
>> +	 * then we are simply destroying the device and we should
>> +	 * clean up the vCPU interrupt presenters first.
>> +	 */
>> +	if (atomic_read(&kvm->online_vcpus) != 0) {
>> +		/*
>> +		 * TODO: There is still a race window with the early
>> +		 * checks in kvmppc_xive_native_connect_vcpu()
>> +		 */
>> +		kvm_for_each_vcpu(i, vcpu, kvm)
>> +			kvmppc_xive_native_cleanup_vcpu(vcpu);
>> +	}
>> +
>>  	debugfs_remove(xive->dentry);
>>  
>>  	pr_devel("Destroying xive native device\n");
> 

