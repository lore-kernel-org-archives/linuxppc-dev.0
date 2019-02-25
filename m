Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799F7C4360F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 11:14:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25022087C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 11:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25022087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447K8y2qqlzDqSq
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 22:14:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=87.98.165.38; helo=6.mo2.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 603 seconds by postgrey-1.36 at bilbo;
 Mon, 25 Feb 2019 22:12:55 AEDT
Received: from 6.mo2.mail-out.ovh.net (6.mo2.mail-out.ovh.net [87.98.165.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447K6v23S7zDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 22:12:51 +1100 (AEDT)
Received: from player687.ha.ovh.net (unknown [10.109.160.39])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 65AFF185BE7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 11:57:20 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id D1E203042A86;
 Mon, 25 Feb 2019 10:57:02 +0000 (UTC)
Subject: Re: [PATCH v2 11/16] KVM: introduce a 'mmap' method for KVM devices
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-12-clg@kaod.org>
 <20190225033309.GO7668@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c906cf13-fb2a-3a76-4382-2a7f98496c05@kaod.org>
Date: Mon, 25 Feb 2019 11:57:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190225033309.GO7668@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 14559856123187137486
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrudejgddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Paolo,

On 2/25/19 4:33 AM, David Gibson wrote:
> On Fri, Feb 22, 2019 at 12:28:35PM +0100, Cédric Le Goater wrote:
>> Some KVM devices will want to handle special mappings related to the
>> underlying HW. For instance, the XIVE interrupt controller of the
>> POWER9 processor has MMIO pages for thread interrupt management and
>> for interrupt source control that need to be exposed to the guest when
>> the OS has the required support.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> 
> Ah, when I suggested mmap() on the base device fd, I hadn't realized
> there wasn't a facility for that yet.
> 
> Have you discussed this with Paolo?  

Not yet.

> We'll need some core KVM buy in to merge this.

Here is an extension of the KVM device to allow special mappings.
Something we would need for the support of the POWER9 XIVE interrupt 
controller.

There are two MMIOs we need to expose to the guest : 

 1. HW MMIO controlling of the interrupt presenter registers (TIMA)
 2. HW MMIO of the interrupt sources for interrupt management (ESB)

The TIMA could have been exposed with a page offset in the vCPU mapping
but as it only makes sense when the XIVE interrupt mode is active, we 
chose to use directly the KVM device fd for that. Is that ok ? 

An alternate solution is to use a device ioctl to allocate an anon fd
and do the mapping, but that seems like extra fuss for the same result. 

Thanks,

C. 

>> ---
>>  include/linux/kvm_host.h |  1 +
>>  virt/kvm/kvm_main.c      | 11 +++++++++++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> index c38cc5eb7e73..cbf81487b69f 100644
>> --- a/include/linux/kvm_host.h
>> +++ b/include/linux/kvm_host.h
>> @@ -1223,6 +1223,7 @@ struct kvm_device_ops {
>>  	int (*has_attr)(struct kvm_device *dev, struct kvm_device_attr *attr);
>>  	long (*ioctl)(struct kvm_device *dev, unsigned int ioctl,
>>  		      unsigned long arg);
>> +	int (*mmap)(struct kvm_device *dev, struct vm_area_struct *vma);
>>  };
>>  
>>  void kvm_device_get(struct kvm_device *dev);
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index 585845203db8..84717d8cb5e4 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -2878,6 +2878,16 @@ static long kvm_vcpu_compat_ioctl(struct file *filp,
>>  }
>>  #endif
>>  
>> +static int kvm_device_mmap(struct file *filp, struct vm_area_struct *vma)
>> +{
>> +	struct kvm_device *dev = filp->private_data;
>> +
>> +	if (dev->ops->mmap)
>> +		return dev->ops->mmap(dev, vma);
>> +
>> +	return -ENODEV;
>> +}
>> +
>>  static int kvm_device_ioctl_attr(struct kvm_device *dev,
>>  				 int (*accessor)(struct kvm_device *dev,
>>  						 struct kvm_device_attr *attr),
>> @@ -2927,6 +2937,7 @@ static const struct file_operations kvm_device_fops = {
>>  	.unlocked_ioctl = kvm_device_ioctl,
>>  	.release = kvm_device_release,
>>  	KVM_COMPAT(kvm_device_ioctl),
>> +	.mmap = kvm_device_mmap,
>>  };
>>  
>>  struct kvm_device *kvm_device_from_filp(struct file *filp)
> 

