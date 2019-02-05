Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F42C282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 13:09:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB9D207E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 13:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB9D207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43v4fw11k6zDqNb
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 00:09:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=178.33.251.53; helo=1.mo178.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 1.mo178.mail-out.ovh.net (1.mo178.mail-out.ovh.net
 [178.33.251.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43v4XM1CPvzDqNC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 00:04:02 +1100 (AEDT)
Received: from player695.ha.ovh.net (unknown [10.109.143.220])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 4FF1650CB0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 13:55:50 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n0.emea.ibm.com [195.212.29.162])
 (Authenticated sender: clg@kaod.org)
 by player695.ha.ovh.net (Postfix) with ESMTPSA id 3EE29245BC6E;
 Tue,  5 Feb 2019 12:55:40 +0000 (UTC)
Subject: Re: [PATCH 06/19] KVM: PPC: Book3S HV: add a GET_ESB_FD control to
 the XIVE native device
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-7-clg@kaod.org> <20190204044531.GB1927@umbus.fritz.box>
 <69791b73-f93e-6957-92e8-5b8620b87731@kaod.org>
 <20190205052822.GE22661@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4d565738-a99b-0333-8533-037677358faa@kaod.org>
Date: Tue, 5 Feb 2019 13:55:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205052822.GE22661@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 9788010841384913799
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrkeeigdegfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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

On 2/5/19 6:28 AM, David Gibson wrote:
> On Mon, Feb 04, 2019 at 12:30:39PM +0100, Cédric Le Goater wrote:
>> On 2/4/19 5:45 AM, David Gibson wrote:
>>> On Mon, Jan 07, 2019 at 07:43:18PM +0100, Cédric Le Goater wrote:
>>>> This will let the guest create a memory mapping to expose the ESB MMIO
>>>> regions used to control the interrupt sources, to trigger events, to
>>>> EOI or to turn off the sources.
>>>>
>>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>>> ---
>>>>  arch/powerpc/include/uapi/asm/kvm.h   |  4 ++
>>>>  arch/powerpc/kvm/book3s_xive_native.c | 97 +++++++++++++++++++++++++++
>>>>  2 files changed, 101 insertions(+)
>>>>
>>>> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
>>>> index 8c876c166ef2..6bb61ba141c2 100644
>>>> --- a/arch/powerpc/include/uapi/asm/kvm.h
>>>> +++ b/arch/powerpc/include/uapi/asm/kvm.h
>>>> @@ -675,4 +675,8 @@ struct kvm_ppc_cpu_char {
>>>>  #define  KVM_XICS_PRESENTED		(1ULL << 43)
>>>>  #define  KVM_XICS_QUEUED		(1ULL << 44)
>>>>  
>>>> +/* POWER9 XIVE Native Interrupt Controller */
>>>> +#define KVM_DEV_XIVE_GRP_CTRL		1
>>>> +#define   KVM_DEV_XIVE_GET_ESB_FD	1
>>>
>>> Introducing a new FD for ESB and TIMA seems overkill.  Can't you get
>>> to both with an mmap() directly on the xive device fd?  Using the
>>> offset to distinguish which one to map, obviously.
>>
>> The page offset would define some sort of user API. It seems feasible.
>> But I am not sure this would be practical in the future if we need to 
>> tune the length.
> 
> Um.. why not?  I mean, yes the XIVE supports rather a lot of
> interrupts, but we have 64-bits of offset we can play with - we can
> leave room for billions of ESB slots and still have room for billions
> of VPs.

So the first 4 pages could be the TIMA pages and then would come  
the pages for the interrupt ESBs. I think that we can have different 
vm_fault handler for each mapping.
 
I wonder how this will work out with pass-through. As Paul said in 
a previous email, it would be better to let QEMU request a new 
mapping to handle the ESB pages of the device being passed through.
I guess this is not a special case, just another offset and length.

I will give it a try.

Thanks,

C. 
