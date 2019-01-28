Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5024C282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 19:45:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4174E20855
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 19:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4174E20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pKqR0JphzDqPW
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 06:45:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.58.91; helo=7.mo178.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 7.mo178.mail-out.ovh.net (7.mo178.mail-out.ovh.net
 [46.105.58.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pKng17V6zDqKv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 06:44:05 +1100 (AEDT)
Received: from player796.ha.ovh.net (unknown [10.109.159.140])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 9ACDB49F46
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 19:26:13 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n0.emea.ibm.com [195.212.29.162])
 (Authenticated sender: clg@kaod.org)
 by player796.ha.ovh.net (Postfix) with ESMTPSA id 2A1A02049141;
 Mon, 28 Jan 2019 18:26:01 +0000 (UTC)
Subject: Re: [PATCH 18/19] KVM: PPC: Book3S HV: add passthrough support
To: Paul Mackerras <paulus@ozlabs.org>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107191006.10648-1-clg@kaod.org> <20190107191006.10648-2-clg@kaod.org>
 <20190122052657.GG15124@blackberry>
 <b3788899d86b1d3bb8d141f1126592e3593ac8ef.camel@kernel.crashing.org>
 <20190123103009.GB29826@blackberry>
 <75762dbe-0f08-5b06-e376-744ff87ff4cb@kaod.org>
 <20190128061353.GD3237@blackberry>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <38b0244d-beb6-3aee-c638-279ca570633c@kaod.org>
Date: Mon, 28 Jan 2019 19:26:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128061353.GD3237@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5279626140287929223
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrjedtgdduudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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

On 1/28/19 7:13 AM, Paul Mackerras wrote:
> On Wed, Jan 23, 2019 at 12:07:19PM +0100, Cédric Le Goater wrote:
>> On 1/23/19 11:30 AM, Paul Mackerras wrote:
>>> On Wed, Jan 23, 2019 at 05:45:24PM +1100, Benjamin Herrenschmidt wrote:
>>>> On Tue, 2019-01-22 at 16:26 +1100, Paul Mackerras wrote:
>>>>> On Mon, Jan 07, 2019 at 08:10:05PM +0100, Cédric Le Goater wrote:
>>>>>> Clear the ESB pages from the VMA of the IRQ being pass through to the
>>>>>> guest and let the fault handler repopulate the VMA when the ESB pages
>>>>>> are accessed for an EOI or for a trigger.
>>>>>
>>>>> Why do we want to do this?
>>>>>
>>>>> I don't see any possible advantage to removing the PTEs from the
>>>>> userspace mapping.  You'll need to explain further.
>>>>
>>>> Afaik bcs we change the mapping to point to the real HW irq ESB page
>>>> instead of the "IPI" that was there at VM init time.
>>
>> yes exactly. You need to clean up the pages each time.
>>  
>>> So that makes it sound like there is a whole lot going on that hasn't
>>> even been hinted at in the patch descriptions...  It sounds like we
>>> need a good description of how all this works and fits together
>>> somewhere under Documentation/.
>>
>> OK. I have started doing so for the models merged in QEMU but not yet 
>> for KVM. I will work on it.
>>
>>> In any case we need much more informative patch descriptions.  I
>>> realize that it's all currently in Cedric's head, but I bet that in
>>> two or three years' time when we come to try to debug something, it
>>> won't be in anyone's head...
>>
>> I agree. 
>>
>>
>> So, storing the ESB VMA under the KVM device is not shocking anyone ?  
> 
> Actually, now that I think of it, why can't userspace (QEMU) manage
> this using mmap()?  Based on what Ben has said, I assume there would
> be a pair of pages for each interrupt that a PCI pass-through device
> has. 

Yes. there is a pair of ESB pages per IRQ number.

> Would we end up with too many VMAs if we just used mmap() to
> change the mappings from the software-generated pages to the
> hardware-generated interrupt pages?  
The sPAPR IRQ number space is 0x8000 wide now. The first 4K are 
dedicated to CPU IPIs and the remaining 4K are for devices. We can 
extend the last range if needed as these are for MSIs. Dynamic 
extensions under KVM should work also.

This to say that we have with 8K x 2 (trigger+EOI) pages. This is a
lot of mmap(), too much. Also the KVM model needs to be compatible
with the QEMU emulated one and it was simpler to have one overall
memory region for the IPI ESBs, one for the END ESBs (if we support
that one day) and one for the TIMA.

> Are the necessary pages for a PCI
> passthrough device contiguous in both host real space 

They should as they are the PHB4 ESBs.

> and guest real space ? 

also. That's how we organized the mapping. 

> If so we'd only need one mmap() for all the device's interrupt
> pages.

Ah. So we would want to make a special case for the passthrough 
device and have a mmap() and a memory region for its ESBs. Hmm.

Wouldn't that require to hot plug a memory region under the guest ? 
which means that we need to provision an address space/container 
region for theses regions. What are the benefits ? 

Is clearing the PTEs and repopulating the VMA unsafe ? 

Thanks,     

C.


