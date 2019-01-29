Return-Path: <SRS0=r5zj=QF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABCDC169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 14:09:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A457F20869
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 14:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A457F20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ppJs5bSgzDqR6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 01:09:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=87.98.172.75; helo=4.mo2.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 4.mo2.mail-out.ovh.net (4.mo2.mail-out.ovh.net [87.98.172.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ppGy1C9VzDqC5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 01:07:36 +1100 (AEDT)
Received: from player794.ha.ovh.net (unknown [10.109.146.76])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 1FEEA17BB39
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 14:48:07 +0100 (CET)
Received: from kaod.org (gbibp9ph1--yellowicen11.emea.ibm.com [195.212.29.58])
 (Authenticated sender: clg@kaod.org)
 by player794.ha.ovh.net (Postfix) with ESMTPSA id 0FD80220EBF8;
 Tue, 29 Jan 2019 13:47:56 +0000 (UTC)
Subject: Re: [PATCH 18/19] KVM: PPC: Book3S HV: add passthrough support
To: Paul Mackerras <paulus@ozlabs.org>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107191006.10648-1-clg@kaod.org> <20190107191006.10648-2-clg@kaod.org>
 <20190122052657.GG15124@blackberry>
 <b3788899d86b1d3bb8d141f1126592e3593ac8ef.camel@kernel.crashing.org>
 <20190123103009.GB29826@blackberry>
 <75762dbe-0f08-5b06-e376-744ff87ff4cb@kaod.org>
 <20190128061353.GD3237@blackberry>
 <38b0244d-beb6-3aee-c638-279ca570633c@kaod.org>
 <20190129024503.GA11368@blackberry>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f92f71ee-5c8e-f6b1-dbbf-436bbb0624cd@kaod.org>
Date: Tue, 29 Jan 2019 14:47:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129024503.GA11368@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6455628591912946567
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrjedvgdehjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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

On 1/29/19 3:45 AM, Paul Mackerras wrote:
> On Mon, Jan 28, 2019 at 07:26:00PM +0100, Cédric Le Goater wrote:
>> On 1/28/19 7:13 AM, Paul Mackerras wrote:
>>> Would we end up with too many VMAs if we just used mmap() to
>>> change the mappings from the software-generated pages to the
>>> hardware-generated interrupt pages?  
>> The sPAPR IRQ number space is 0x8000 wide now. The first 4K are 
>> dedicated to CPU IPIs and the remaining 4K are for devices. We can 
> 
> Confused.  You say the number space has 32768 entries but then imply
> there are only 8K entries.  Do you mean that the API allows for 15-bit
> IRQ numbers but we are only making using of 8192 of them?

Ouch. My bad. Let's do it again. 

The sPAPR IRQ number space is 0x2000 wide :

https://git.qemu.org/?p=qemu.git;a=blob;f=hw/ppc/spapr_irq.c;h=1da7a32348fced0bd638717022fc37a83fc5e279;hb=HEAD#l396

The first 4K are dedicated to the CPU IPIs and the remaining 4K are for 
devices (which can be extended if needed).

So that's 8192 x 2 ESB pages.

>> extend the last range if needed as these are for MSIs. Dynamic 
>> extensions under KVM should work also.
>>
>> This to say that we have with 8K x 2 (trigger+EOI) pages. This is a
>> lot of mmap(), too much. Also the KVM model needs to be compatible
> 
> I wasn't suggesting an mmap per IRQ, I meant that the bulk of the
> space would be covered by a single mmap, overlaid by subsequent mmaps
> where we need to map real device interrupts.

ok. The same fault handler could be used to populate the VMA with the 
ESB pages. 

But it would mean extra work on the QEMU side, which is not needed 
with this patch. 

>> with the QEMU emulated one and it was simpler to have one overall
>> memory region for the IPI ESBs, one for the END ESBs (if we support
>> that one day) and one for the TIMA.
>>
>>> Are the necessary pages for a PCI
>>> passthrough device contiguous in both host real space 
>>
>> They should as they are the PHB4 ESBs.
>>
>>> and guest real space ? 
>>
>> also. That's how we organized the mapping. 
> 
> "How we organized the mapping" is a significant design decision that I
> haven't seen documented anywhere, and is really needed for
> understanding what's going on.

OK. I will add comments on that. See below for some description.

There is nothing fancy, it's simply indexed with the interrupt number,
like for HW, or for the QEMU XIVE emulated model.

>>> If so we'd only need one mmap() for all the device's interrupt
>>> pages.
>>
>> Ah. So we would want to make a special case for the passthrough 
>> device and have a mmap() and a memory region for its ESBs. Hmm.
>>
>> Wouldn't that require to hot plug a memory region under the guest ? 
> 
> No; the way that a memory region works is that userspace can do
> whatever disparate mappings it likes within the region on the user
> process side, and the corresponding region of guest real address space
> follows that automatically.

yes. I suppose this should work also for 'ram device' memory mappings.

So when the passthrough device is added to the guest, we would add a 
new 'ram device' memory region for the device interrupt ESB pages 
that would overlap with the initial guest ESB pages.  

This is really a different approach.

>> which means that we need to provision an address space/container 
>> region for theses regions. What are the benefits ? 
>>
>> Is clearing the PTEs and repopulating the VMA unsafe ? 
> 
> Explicitly unmapping parts of the VMA seems like the wrong way to do
> it.  If you have a device mmap where the device wants to change the
> physical page underlying parts of the mapping, there should be a way
> for it to do that explicitly (but I don't know off the top of my head
> what the interface to do that is).
> 
> However, I still haven't seen a clear and concise explanation of what
> is being changed, when, and why we need to do that.

Yes. I agree on that. The problem is not very different from what we 
have today with the XICS-over-XIVE glue in KVM. Let me try to explain.


The KVM XICS-over-XIVE device and the proposed KVM XIVE native device 
implement an IRQ space for the guest using the generic IPI interrupts 
of the XIVE IC controller. These interrupts are allocated at the OPAL
level and "mapped" into the guest IRQ number space in the range 0-0x1FFF.
Interrupt management is performed in the XIVE way: using loads and 
stores on the addresses of the XIVE IPI interrupt ESB pages.

Both KVM devices share the same internal structure caching information 
on the interrupts, among which the xive_irq_data struct containing the 
addresses of the IPI ESB pages and an extra one in case of passthrough. 
The later contains the addresses of the ESB pages of the underlying HW 
controller interrupts, PHB4 in all cases for now.    

A guest when running in the XICS legacy interrupt mode lets the KVM 
XICS-over-XIVE device "handle" interrupt management, that is to perform  
the loads and stores on the addresses of the ESB pages of the guest 
interrupts. 

However, when running in XIVE native exploitation mode, the KVM XIVE 
native device exposes the interrupt ESB pages to the guest and lets 
the guest perform directly the loads and stores. 

The VMA exposing the ESB pages make use of a custom VM fault handler
which role is to populate the VMA with appropriate pages. When a fault
occurs, the guest IRQ number is deduced from the offset, and the ESB 
pages of associated XIVE IPI interrupt are inserted in the VMA (using
the internal structure caching information on the interrupts).

Supporting device passthrough in the guest running in XIVE native 
exploitation mode adds some extra refinements because the ESB pages 
of a different HW controller (PHB4) need to be exposed to the guest 
along with the initial IPI ESB pages of the XIVE IC controller. But
the overall mechanic is the same. 

When the device HW irqs are mapped into or unmapped from the guest
IRQ number space, the passthru_irq helpers, kvmppc_xive_set_mapped()
and kvmppc_xive_clr_mapped(), are called to record or clear the 
passthrough interrupt information and to perform the switch.

The approach taken by this patch is to clear the ESB pages of the 
guest IRQ number being mapped and let the VM fault handler repopulate. 
The handler will insert the ESB page corresponding to the HW interrupt 
of the device being passed-through or the initial IPI ESB page if the
device is being removed.   



Thanks,

C.
