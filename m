Return-Path: <SRS0=dqXl=QQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33D5C282C4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 09:43:40 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E6A217D8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 09:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E6A217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43xRvF638FzDqXQ
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 20:43:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.51.53; helo=5.mo178.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 5.mo178.mail-out.ovh.net (5.mo178.mail-out.ovh.net
 [46.105.51.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43xRsL5RCGzDqWn
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2019 20:41:56 +1100 (AEDT)
Received: from player715.ha.ovh.net (unknown [10.109.160.62])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 96DE84FECB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2019 10:41:52 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player715.ha.ovh.net (Postfix) with ESMTPSA id CFC2F27A9245;
 Sat,  9 Feb 2019 09:41:40 +0000 (UTC)
Subject: Re: [PATCH 06/19] KVM: PPC: Book3S HV: add a GET_ESB_FD control to
 the XIVE native device
To: Paul Mackerras <paulus@ozlabs.org>
References: <20190204044531.GB1927@umbus.fritz.box>
 <69791b73-f93e-6957-92e8-5b8620b87731@kaod.org>
 <20190205052822.GE22661@umbus.fritz.box>
 <4d565738-a99b-0333-8533-037677358faa@kaod.org>
 <20190206012308.GP22661@umbus.fritz.box>
 <1745dd9f-2927-cae6-e8da-c350b0bd0a66@kaod.org>
 <20190207024950.GA22661@umbus.fritz.box>
 <d20bbaca-5b49-66e4-9d99-21d991c2c345@kaod.org>
 <20190208051523.GD2688@umbus.fritz.box>
 <9b556f53-fcfb-2ca3-019e-6ced0ec74c2a@kaod.org>
 <20190208215329.GA9529@blackberry>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8c915ed7-5aa5-1276-6598-d5dcd115dd56@kaod.org>
Date: Sat, 9 Feb 2019 10:41:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190208215329.GA9529@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11556236647453199239
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrleefgdegvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2/8/19 10:53 PM, Paul Mackerras wrote:
> On Fri, Feb 08, 2019 at 08:58:14AM +0100, Cédric Le Goater wrote:
>> On 2/8/19 6:15 AM, David Gibson wrote:
>>> On Thu, Feb 07, 2019 at 10:03:15AM +0100, Cédric Le Goater wrote:
>>>> That's the plan I have in mind as suggested by Paul if I understood it well.
>>>> The mechanics are more complex than the patch zapping the PTEs from the VMA
>>>> but it's also safer.
>>>
>>> Well, yes, where "safer" means "has the possibility to be correct".
>>
>> Well, the only problem with the kernel approach is keeping a pointer on 
>> the VMA. If we could call find_vma(), it would be perfectly safe and much 
>> more simpler.
> 
> You seem to be assuming that the kernel can easily work out a single
> virtual address which will be the only place where a given set of
> interrupt pages are mapped.  But that is really not possible in the
> general case, because userspace could have mapped the fd at many
> different offsets in many different places.
> 
> QEMU doesn't do that; in QEMU, the mmaps are sufficiently limited that
> it can work out a single virtual address that needs to be changed.
> The way that QEMU should tell the kernel what that address is and what
> the mapping should be changed to, is via the existing munmap()/mmap()
> interface.

Yes. We agreed on that. QEMU should handle these mappings somewhere in 
VFIO. It's me grumbling, that's all.

The discussion has moved to the mmap() interface of the KVM device. The 
current proposal adds controls on the device creating fds to mmap() the 
TIMA pages and the ESB pages. David is proposing to use directly the fd 
of the KVM device to mmap() these pages with a different offset for each 
set. 

I think that should work pretty well, for passthrough also. The fault 
handler should take care of populating the VMA(s) with the appropriate 
pages. 

We might support END notification one day, so we should have room for 
these pages. And nested might require IRQ space extensions at L1. 
something to keep in mind.

C.
  
