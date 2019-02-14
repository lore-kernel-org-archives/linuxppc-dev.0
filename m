Return-Path: <SRS0=RHZ4=QV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E374AC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 16:52:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEB0A21928
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 16:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB0A21928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440j9z4lGNzDqYB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 03:52:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.58.226; helo=3.mo2.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 3.mo2.mail-out.ovh.net (3.mo2.mail-out.ovh.net [46.105.58.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440j7Z5rL2zDqNv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 03:50:31 +1100 (AEDT)
Received: from player732.ha.ovh.net (unknown [10.109.159.73])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 646B918485D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 17:50:27 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player732.ha.ovh.net (Postfix) with ESMTPSA id DB5D529C7EE2;
 Thu, 14 Feb 2019 16:50:19 +0000 (UTC)
Subject: Re: [PATCH 15/19] KVM: PPC: Book3S HV: add get/set accessors for the
 source configuration
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190107184331.8429-16-clg@kaod.org>
 <20190204052148.GH1927@umbus.fritz.box>
 <02ee0470-3c6a-5c5c-a903-44e172ce1ed5@kaod.org>
 <20190205053233.GG22661@umbus.fritz.box>
 <c0faf4dd-7af1-d97a-f8f1-838fcf412ab8@kaod.org>
 <20190206012329.GQ22661@umbus.fritz.box>
 <20190206012447.GR22661@umbus.fritz.box>
 <1d92005a-c12d-1a55-d01b-98eded13629c@kaod.org>
 <20190207024855.GZ22661@umbus.fritz.box>
 <9f03f232-1c47-6e27-6d79-3bcc900fe943@kaod.org>
 <20190208051543.GE2688@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d549f598-2821-0f40-b060-35a7323569ae@kaod.org>
Date: Thu, 14 Feb 2019 17:50:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190208051543.GE2688@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11264347094730247047
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrleeggdeiiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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

On 2/8/19 6:15 AM, David Gibson wrote:
> On Thu, Feb 07, 2019 at 10:13:48AM +0100, Cédric Le Goater wrote:
>> On 2/7/19 3:48 AM, David Gibson wrote:
>>> On Wed, Feb 06, 2019 at 08:07:36AM +0100, Cédric Le Goater wrote:
>>>> On 2/6/19 2:24 AM, David Gibson wrote:
>>>>> On Wed, Feb 06, 2019 at 12:23:29PM +1100, David Gibson wrote:
>>>>>> On Tue, Feb 05, 2019 at 02:03:11PM +0100, Cédric Le Goater wrote:
>>>>>>> On 2/5/19 6:32 AM, David Gibson wrote:
>>>>>>>> On Mon, Feb 04, 2019 at 05:07:28PM +0100, Cédric Le Goater wrote:
>>>>>>>>> On 2/4/19 6:21 AM, David Gibson wrote:
>>>>>>>>>> On Mon, Jan 07, 2019 at 07:43:27PM +0100, Cédric Le Goater wrote:
>>>>>>>>>>> Theses are use to capure the XIVE EAS table of the KVM device, the
>>>>>>>>>>> configuration of the source targets.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>>>>>>>>>> ---
>>>>>>>>>>>  arch/powerpc/include/uapi/asm/kvm.h   | 11 ++++
>>>>>>>>>>>  arch/powerpc/kvm/book3s_xive_native.c | 87 +++++++++++++++++++++++++++
>>>>>>>>>>>  2 files changed, 98 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
>>>>>>>>>>> index 1a8740629acf..faf024f39858 100644
>>>>>>>>>>> --- a/arch/powerpc/include/uapi/asm/kvm.h
>>>>>>>>>>> +++ b/arch/powerpc/include/uapi/asm/kvm.h
>>>>>>>>>>> @@ -683,9 +683,20 @@ struct kvm_ppc_cpu_char {
>>>>>>>>>>>  #define   KVM_DEV_XIVE_SAVE_EQ_PAGES	4
>>>>>>>>>>>  #define KVM_DEV_XIVE_GRP_SOURCES	2	/* 64-bit source attributes */
>>>>>>>>>>>  #define KVM_DEV_XIVE_GRP_SYNC		3	/* 64-bit source attributes */
>>>>>>>>>>> +#define KVM_DEV_XIVE_GRP_EAS		4	/* 64-bit eas attributes */
>>>>>>>>>>>  
>>>>>>>>>>>  /* Layout of 64-bit XIVE source attribute values */
>>>>>>>>>>>  #define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
>>>>>>>>>>>  #define KVM_XIVE_LEVEL_ASSERTED		(1ULL << 1)
>>>>>>>>>>>  
>>>>>>>>>>> +/* Layout of 64-bit eas attribute values */
>>>>>>>>>>> +#define KVM_XIVE_EAS_PRIORITY_SHIFT	0
>>>>>>>>>>> +#define KVM_XIVE_EAS_PRIORITY_MASK	0x7
>>>>>>>>>>> +#define KVM_XIVE_EAS_SERVER_SHIFT	3
>>>>>>>>>>> +#define KVM_XIVE_EAS_SERVER_MASK	0xfffffff8ULL
>>>>>>>>>>> +#define KVM_XIVE_EAS_MASK_SHIFT		32
>>>>>>>>>>> +#define KVM_XIVE_EAS_MASK_MASK		0x100000000ULL
>>>>>>>>>>> +#define KVM_XIVE_EAS_EISN_SHIFT		33
>>>>>>>>>>> +#define KVM_XIVE_EAS_EISN_MASK		0xfffffffe00000000ULL
>>>>>>>>>>> +
>>>>>>>>>>>  #endif /* __LINUX_KVM_POWERPC_H */
>>>>>>>>>>> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
>>>>>>>>>>> index f2de1bcf3b35..0468b605baa7 100644
>>>>>>>>>>> --- a/arch/powerpc/kvm/book3s_xive_native.c
>>>>>>>>>>> +++ b/arch/powerpc/kvm/book3s_xive_native.c
>>>>>>>>>>> @@ -525,6 +525,88 @@ static int kvmppc_xive_native_sync(struct kvmppc_xive *xive, long irq, u64 addr)
>>>>>>>>>>>  	return 0;
>>>>>>>>>>>  }
>>>>>>>>>>>  
>>>>>>>>>>> +static int kvmppc_xive_native_set_eas(struct kvmppc_xive *xive, long irq,
>>>>>>>>>>> +				      u64 addr)
>>>>>>>>>>
>>>>>>>>>> I'd prefer to avoid the name "EAS" here.  IIUC these aren't "raw" EAS
>>>>>>>>>> values, but rather essentially the "source config" in the terminology
>>>>>>>>>> of the PAPR hcalls.  Which, yes, is basically implemented by setting
>>>>>>>>>> the EAS, but since it's the PAPR architected state that we need to
>>>>>>>>>> preserve across migration, I'd prefer to stick as close as we can to
>>>>>>>>>> the PAPR terminology.
>>>>>>>>>
>>>>>>>>> But we don't have an equivalent name in the PAPR specs for the tuple 
>>>>>>>>> (prio, server). We could use the generic 'target' name may be ? even 
>>>>>>>>> if this is usually referring to a CPU number.
>>>>>>>>
>>>>>>>> Um.. what?  That's about terminology for one of the fields in this
>>>>>>>> thing, not about the name for the thing itself.
>>>>>>>>
>>>>>>>>> Or, IVE (Interrupt Vector Entry) ? which makes some sense. 
>>>>>>>>> This is was the former name in HW. I think we recycle it for KVM.
>>>>>>>>
>>>>>>>> That's a terrible idea, which will make a confusing situation even
>>>>>>>> more confusing.
>>>>>>>
>>>>>>> Let's use SOURCE_CONFIG and QUEUE_CONFIG. The KVM ioctls are very 
>>>>>>> similar to the hcalls anyhow.
>>>>>>
>>>>>> Yes, I think that's a good idea.
>>>>>
>>>>> Actually... AIUI the SET_CONFIG hcalls shouldn't be a fast path.  
>>>>
>>>> No indeed. I have move them to standard hcalls in the current version.
>>>>
>>>>> Can
>>>>> we simplify things further by removing the hcall implementation from
>>>>> the kernel entirely, and have qemu implement them by basically just
>>>>> forwarding them to the appropriate SET_CONFIG ioctl()?
>>>>
>>>> Yes. I think we could. 
>>>
>>> Great!
>>>
>>>> The hcalls H_INT_SET_SOURCE_CONFIG and H_INT_SET_QUEUE_CONFIG and 
>>>> the KVM ioctls to set the EQ and the SOURCE configuration have a 
>>>> lot in common. I need to look at how we can plug the KVM ioctl in 
>>>> the hcalls under QEMU.
>>>>
>>>> We will have to convert the returned error to respect the PAPR 
>>>> specs or have the ioctls return H_* errors.
>>>
>>> I don't think returning H_* values from a kernel call is a good idea.
>>> Converting errors is kinda ugly, but I still think it's the better
>>> option.  Note that we already have something like this for the HPT
>>> resizing hcalls.
>>
>> ok.
>>  
>>>> Let's dig that idea. If we choose that path, QEMU will have an 
>>>> up-to-date EAT and so we won't need to synchronize its state anymore 
>>>> for migration.
>>>
>>> I guess so, though I don't see that as essential.
>>>
>>>> H_INT_GET_SOURCE_CONFIG can be implemented in QEMU without any KVM 
>>>> ioctl.
>>>>
>>>> H_INT_GET_QUEUE_INFO could be implemented in QEMU. I need to check 
>>>> how we return the address of the END ESB in sPAPR. We haven't paid 
>>>> much attention to these pages because they are not used under Linux
>>>> and today the address is returned by OPAL. 
>>>>
>>>> H_INT_GET_QUEUE_CONFIG is a little more problematic because we need
>>>> to query into the XIVE HW the EQ index and toggle bit. OPAL support
>>>> is required for that. But we could reduce the KVM support to the 
>>>> ioctl querying these EQ information.
>>>
>>> Right, and we'd need an ioctl() like that for migration anyway, yes?
>>
>> Yes. it is the same need.
>>
>>>> H_INT_ESB could be entirely done under QEMU.
>>>
>>> This one can actually happen on fairly hot paths, so I think doing
>>> that in qemu probably isn't a good idea.
>>
>> I agree It would nice to have some performance.
>>
>> This hcall is used when LSIs are involved, which is not really a common 
>> configuration. There are no OPAL calls involved. And we are duplicating 
>> code at the KVM level to retrigger the interrupt when the level is still
>> asserted.
>>
>> I will benchmark the two options before making a choice.
> 
> Ok.
 

Here are some iperf results for a 4 vCPUs guest running a 5.0.0 kernel
on a small initrd image. I didn't do any kind of tuning like CPU pinning. 
So these are really rough figures :   


  kernel irqchip            OFF      ON    ON (*)

  rtl8139  (LSI)           1.19    1.24   1.23    Gbits/sec
  VIRTIO                  31.80   42.30    --     Gbits/sec


There is not much benefit in handling the H_INT_ESB hcall under KVM it seems. 
I think we can leave it under QEMU.  


C.
