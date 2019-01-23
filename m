Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D28BC282C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 19:19:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF3221872
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 19:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF3221872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43lFTp6H5DzDqDF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 06:19:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.58.60; helo=3.mo68.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 480 seconds by postgrey-1.36 at bilbo;
 Thu, 24 Jan 2019 06:15:46 AEDT
Received: from 3.mo68.mail-out.ovh.net (3.mo68.mail-out.ovh.net [46.105.58.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43lFPG1NkLzDqG0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2019 06:15:44 +1100 (AEDT)
Received: from player759.ha.ovh.net (unknown [10.109.146.168])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id BC86210D49A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 20:07:41 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player759.ha.ovh.net (Postfix) with ESMTPSA id 02BCD1FBFA67;
 Wed, 23 Jan 2019 19:07:33 +0000 (UTC)
Subject: Re: [PATCH 00/19] KVM: PPC: Book3S HV: add XIVE native exploitation
 mode
To: Paul Mackerras <paulus@ozlabs.org>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190122044654.GA15124@blackberry>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2f9b4420-ef90-20b8-d31b-dc547a6aa6b4@kaod.org>
Date: Wed, 23 Jan 2019 20:07:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190122044654.GA15124@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13509672986348850055
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledriedtgdduvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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

On 1/22/19 5:46 AM, Paul Mackerras wrote:
> On Mon, Jan 07, 2019 at 07:43:12PM +0100, Cédric Le Goater wrote:
>> Hello,
>>
>> On the POWER9 processor, the XIVE interrupt controller can control
>> interrupt sources using MMIO to trigger events, to EOI or to turn off
>> the sources. Priority management and interrupt acknowledgment is also
>> controlled by MMIO in the CPU presenter subengine.
>>
>> PowerNV/baremetal Linux runs natively under XIVE but sPAPR guests need
>> special support from the hypervisor to do the same. This is called the
>> XIVE native exploitation mode and today, it can be activated under the
>> PowerPC Hypervisor, pHyp. However, Linux/KVM lacks XIVE native support
>> and still offers the old interrupt mode interface using a
>> XICS-over-XIVE glue which implements the XICS hcalls.
>>
>> The following series is proposal to add the same support under KVM.
>>
>> A new KVM device is introduced for the XIVE native exploitation
>> mode. It reuses most of the XICS-over-XIVE glue implementation
>> structures which are internal to KVM but has a completely different
>> interface. A set of Hypervisor calls configures the sources and the
>> event queues and from there, all control is done by the guest through
>> MMIOs.
>>
>> These MMIO regions (ESB and TIMA) are exposed to guests in QEMU,
>> similarly to VFIO, and the associated VMAs are populated dynamically
>> with the appropriate pages using a fault handler. This is implemented
>> with a couple of KVM device ioctls.
>>
>> On a POWER9 sPAPR machine, the Client Architecture Support (CAS)
>> negotiation process determines whether the guest operates with a
>> interrupt controller using the XICS legacy model, as found on POWER8,
>> or in XIVE exploitation mode. Which means that the KVM interrupt
>> device should be created at runtime, after the machine as started.
>> This requires extra KVM support to create/destroy KVM devices. The
>> last patches are an attempt to solve that problem.
>>
>> Migration has its own specific needs. The patchset provides the
>> necessary routines to quiesce XIVE, to capture and restore the state
>> of the different structures used by KVM, OPAL and HW. Extra OPAL
>> support is required for these.
> 
> Thanks for the patchset.  It mostly looks good, but there are some
> more things we need to consider, and I think a v2 will be needed.
>> One general comment I have is that there are a lot of acronyms in this
> code and you mostly seem to assume that people will know what they all
> mean.  It would make the code more readable if you provide the
> expansion of the acronym on first use in a comment or whatever.  For
> example, one of the patches in this series talks about the "EAS"

 Event Assignment Structure, a.k.a IVE (Interrupt Virtualization Entry)

All the names changed somewhere between XIVE v1 and XIVE v2. OPAL and
Linux should be adjusted ...

> without ever expanding it in any comment or in the patch description,
> and I have forgotten just at the moment what EAS stands for (I just
> know that understanding the XIVE is not eas-y. :)
ah ! yes. But we have great documentation :)

We pushed some high level description of XIVE in QEMU :

  https://git.qemu.org/?p=qemu.git;a=blob;f=include/hw/ppc/xive.h;h=ec23253ba448e25c621356b55a7777119a738f8e;hb=HEAD

I should do the same for Linux with a KVM section to explain the 
interfaces which do not directly expose the underlying XIVE concepts. 
It's better to understand a little what is happening under the hood.

> Another general comment is that you seem to have written all this
> code assuming we are using HV KVM in a host running bare-metal.

Yes. I didn't look at the other configurations. I thought that we could
use the kernel_irqchip=off option to begin with. A couple of checks
are indeed missing.

> However, we could be using PR KVM (either in a bare-metal host or in a
> guest), or we could be doing nested HV KVM where we are using the
> kvm_hv module inside a KVM guest and using special hypercalls for
> controlling our guests.

Yes. 

It would be good to talk a little about the nested support (offline 
may be) to make sure that we are not missing some major interface that 
would require a lot of change. If we need to prepare ground, I think
the timing is good.

The size of the IRQ number space might be a problem. It seems we 
would need to increase it considerably to support multiple nested 
guests. That said I haven't look much how nested is designed.  

> It would be perfectly acceptable for now to say that we don't yet
> support XIVE exploitation in those scenarios, as long as we then make
> sure that the new KVM capability reports false in those scenarios, and
> any attempt to use the XIVE exploitation interfaces fails cleanly.

ok. That looks the best approach for now.

> I don't see that either of those is true in the patch set as it
> stands, so that is one area that needs to be fixed.
> 
> A third general comment is that the new KVM interfaces you have added
> need to be documented in the files under Documentation/virtual/kvm.

ok. 

Thanks,

C. 


