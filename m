Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEF5C10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 13:00:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE2052133D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 13:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2052133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44g1N85fMbzDqSV
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 23:00:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=178.32.97.206; helo=19.mo1.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 19.mo1.mail-out.ovh.net (19.mo1.mail-out.ovh.net
 [178.32.97.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fznK1cjVzDqQY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 21:48:33 +1000 (AEST)
Received: from player798.ha.ovh.net (unknown [10.109.159.136])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 0B2F4169FD6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 13:48:28 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-40-22.w86-201.abo.wanadoo.fr
 [86.201.133.22]) (Authenticated sender: clg@kaod.org)
 by player798.ha.ovh.net (Postfix) with ESMTPSA id B2C8B4C1E100;
 Thu, 11 Apr 2019 11:48:19 +0000 (UTC)
Subject: Re: [PATCH v5 16/16] KVM: PPC: Book3S HV: XIVE: introduce a 'release'
 device operation
To: Paul Mackerras <paulus@ozlabs.org>
References: <20190410170448.3923-1-clg@kaod.org>
 <20190410170448.3923-17-clg@kaod.org> <20190411102710.GD21252@blackberry>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ddcbb686-c273-a478-1f64-d1b54c0e5aa3@kaod.org>
Date: Thu, 11 Apr 2019 13:48:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411102710.GD21252@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2993767856400927694
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudelgdeggecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 4/11/19 12:27 PM, Paul Mackerras wrote:
> On Wed, Apr 10, 2019 at 07:04:48PM +0200, Cédric Le Goater wrote:
>> When a P9 sPAPR VM boots, the CAS negotiation process determines which
>> interrupt mode to use (XICS legacy or XIVE native) and invokes a
>> machine reset to activate the chosen mode.
>>
>> To be able to switch from one mode to another, we introduce the
>> capability to release a KVM device without destroying the VM. The KVM
>> device interface is extended with a new 'release' operation which is
>> called when the file descriptor of the device is closed.
> 
> Unfortunately, I think there is now a memory leak:
> 
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index ea2018ae1cd7..ea2619d5ca98 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -2938,6 +2938,19 @@ static int kvm_device_release(struct inode *inode, struct file *filp)
>>  	struct kvm_device *dev = filp->private_data;
>>  	struct kvm *kvm = dev->kvm;
>>  
>> +	if (!dev)
>> +		return -ENODEV;
>> +
>> +	if (dev->kvm != kvm)
>> +		return -EPERM;
>> +
>> +	if (dev->ops->release) {
>> +		mutex_lock(&kvm->lock);
>> +		list_del(&dev->vm_node);
> 
> Because the device is now no longer in the kvm->devices list,
> kvm_destroy_devices() won't find it there and therefore won't call the
> device's destroy method.  In fact now the device's destroy method will
> never get called; I can't see how kvmppc_xive_free() or
> kvmppc_xive_native_free() will ever get called.  Thus the memory for
> the kvmppc_xive structs will never get freed as far as I can see.

ah yes. indeed ...

> We could fix that by freeing both of the kvm->arch.xive_devices
> entries at VM destruction time.

That is what I was doing in the first patch I sent : 

    http://patchwork.ozlabs.org/patch/1082303/

It worked fine and then, I had this better (worse) idea which I included 
in v5. 
 
> If it is true that any device that has a release method will never see
> its destroy method being called, then that needs to be documented
> clearly somewhere.

Yes. Closing the fd should take care of it. I have to rework that patch.

Thanks,

C.
