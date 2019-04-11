Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26ADC10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 06:14:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 141F620873
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 06:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141F620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44frN51PqdzDqPF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 16:14:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.43.140; helo=5.mo179.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 5.mo179.mail-out.ovh.net (5.mo179.mail-out.ovh.net
 [46.105.43.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44frLD5lvzzDqP9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 16:13:04 +1000 (AEST)
Received: from player714.ha.ovh.net (unknown [10.109.159.90])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 93B3C122F54
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 08:12:59 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-40-22.w86-201.abo.wanadoo.fr
 [86.201.133.22]) (Authenticated sender: clg@kaod.org)
 by player714.ha.ovh.net (Postfix) with ESMTPSA id E278F492C814;
 Thu, 11 Apr 2019 06:12:49 +0000 (UTC)
Subject: Re: [PATCH v5 16/16] KVM: PPC: Book3S HV: XIVE: introduce a 'release'
 device operation
To: David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@ozlabs.org>
References: <20190410170448.3923-1-clg@kaod.org>
 <20190410170448.3923-17-clg@kaod.org> <20190411031625.GA21252@blackberry>
 <20190411043834.GA20857@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <54636380-2356-44f9-5282-93839912b2b3@kaod.org>
Date: Thu, 11 Apr 2019 08:12:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411043834.GA20857@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 15774702122361850830
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudekgdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 4/11/19 6:38 AM, David Gibson wrote:
> On Thu, Apr 11, 2019 at 01:16:25PM +1000, Paul Mackerras wrote:
>> On Wed, Apr 10, 2019 at 07:04:48PM +0200, Cédric Le Goater wrote:
>>> When a P9 sPAPR VM boots, the CAS negotiation process determines which
>>> interrupt mode to use (XICS legacy or XIVE native) and invokes a
>>> machine reset to activate the chosen mode.
>>>
>>> To be able to switch from one mode to another, we introduce the
>>> capability to release a KVM device without destroying the VM. The KVM
>>> device interface is extended with a new 'release' operation which is
>>> called when the file descriptor of the device is closed.
>>
>> I believe the release operation is not called until all of the mmaps
>> using the fd are unmapped - which is a good thing for us, since it
>> means the guest can't possibly be accessing the XIVE directly.
yes.

>> You might want to reword that last paragraph to mention that.

ok. 

>>> Such operations are defined for the XICS-on-XIVE and the XIVE native
>>> KVM devices. They clear the vCPU interrupt presenters that could be
>>> attached and then destroy the device.
>>>
>>> This is not considered as a safe operation as the vCPUs are still
>>> running and could be referencing the KVM device through their
>>> presenters. To protect the system from any breakage, the kvmppc_xive
>>> objects representing both KVM devices are now stored in an array under
>>> the VM. Allocation is performed on first usage and memory is freed
>>> only when the VM exits.
>>
>> One quick comment below:
>>
>>> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
>>> index 480a3fc6b9fd..064a9f2ae678 100644
>>> --- a/arch/powerpc/kvm/book3s_xive.c
>>> +++ b/arch/powerpc/kvm/book3s_xive.c
>>> @@ -1100,11 +1100,19 @@ void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu)
>>>  void kvmppc_xive_cleanup_vcpu(struct kvm_vcpu *vcpu)
>>>  {
>>>  	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
>>> -	struct kvmppc_xive *xive = xc->xive;
>>> +	struct kvmppc_xive *xive;
>>>  	int i;
>>>  
>>> +	if (!kvmppc_xics_enabled(vcpu))
>>> +		return;
>>
>> Should that be kvmppc_xive_enabled() rather than xics?
> 
> I think I asked that on an earlier iteration, and the answer is no.
> The names are confusing, but this file is all about xics-on-xive
> rather than xive native.  So here we're checking what's available from
> the guest's point of view, so "xics", but most of the surrounding
> functions are named "xive" because that's the backend.
> 

yes. 

The relevant part is at the end of the kvmppc_xive_connect_vcpu() routine :

  int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
  			     struct kvm_vcpu *vcpu, u32 cpu)
  {
	...
  	vcpu->arch.irq_type = KVMPPC_IRQ_XICS;
	return 0;
  }



David suggested a few cleanups that we could do in the xics-on-xive 
device. We might want to introduce a KVMPPC_IRQ_XICS_ON_XIVE flag also. 
First, I would like to get rid of references to the kvmppc_xive struct 
and remove some useless attributes to improve locking.

Once the XIVE native mode is merged, all kernels above 4.14 running on 
a P9 sPAPR guest will switch to XIVE and the xics-on-xive device will 
only be useful for nested.


C.
