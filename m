Return-Path: <linuxppc-dev+bounces-25555-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A73C5AC7A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 11:04:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGh9C5CN6z3c3K;
	Fri, 07 Aug 2026 21:03:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786100639;
	cv=none; b=hgdGwFJWlInV+ATrFN50yHQxi29ZSoARTCsJ6HyDDp22rduR57fQcj1o8LiFeLQ/XsNihM+3b3uayBx3fPwlsFST5SwdFePv6iMijGp8WwfC1JBRfMbLFIhf2V7Z48nsPuFC1aF70+mLid5YQgDqJlI6D7grdPFhk+fromSoGtRRDlCFdqbvAhSnyJlLRUteWKMQZqVQ/Avfqbp6/hdUq3T/5ywuhqtpw5b86kirNxwa3DhNEr0xCDqTWeAwLor8N0i7RlraUADLWmiPb1TIeSMjBn0mlXMjFx9llo/E90oOSVe5egxVwRhvKhpSp4jDN740PrLEijvPVCyPFZyEUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786100639; c=relaxed/relaxed;
	bh=JGUeaFOrmYnG09K1ojCvxoSpMGRjoyG9uPmXrdQbCYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAeIN9W5bDn1Y69v0YqkO92S6XaZm+iJaqk9nJPTpeGfzKFW0HXQGUViWXgIrKDD/kHvxBWLOa+34n5SLmcznIYrjNqPRmIazf9IZ6w1f838sVcEIcFJ+5NDzW5R8bNt+6nZZMjgZErTMEPZlSjCgU4ZUH1bHYXdQwY6J7HUFnNQrV4XOOBVjwbSNhUjQXPTDUQ1CK+8HTUpTncUobiVqKLIO9CapLiO4LIRK4m53H2h1mdQDjG9K9Hak3rN6PWXMfeXu+LX+gVoznFk6nszkerloogXDIqVRjO2fa288TSg0UkpoyCPyiT4o6GN92n/Gr/fwKfHlJE4bXEZGV5RuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=J8p7ij5I; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=robin.murphy@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=J8p7ij5I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=robin.murphy@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGh985zQkz3c2h
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 21:03:54 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 056EA1A9A;
	Fri,  7 Aug 2026 04:03:18 -0700 (PDT)
Received: from [10.57.42.104] (unknown [10.57.42.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE4F43F86F;
	Fri,  7 Aug 2026 04:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786100602; bh=xVUNR7ylOX30B68Mp97+YrCjqIAMylEeu1MoGj3JgSs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J8p7ij5IxKrp/kurzyHOpL7pNcFvOmaC1o1pKHx1B0H8nD1rs9aRZPjUBxhjjZZCQ
	 N4wJy56XcfQZ9q6eMGh6OX2azJnBHJkC8guCRYo50qm8khWqqcEcjsfqtXCA71yfRP
	 ZBj3ot3KvGeWH3bSFFxlac5fB9iAToqsB4eMcWRg=
Message-ID: <0ce2249d-3a64-4889-b455-0e8fddcc7282@arm.com>
Date: Fri, 7 Aug 2026 12:03:14 +0100
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/23] dma: swiotlb: pass mapping attributes by
 reference
To: Jason Gunthorpe <jgg@nvidia.com>, Mostafa Saleh <smostafa@google.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Steven Price <steven.price@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>,
 Petr Tesarik <ptesarik@suse.com>, Alexey Kardashevskiy <aik@amd.com>,
 Dan Williams <dan.j.williams@intel.com>, Xu Yilun
 <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
 Michael Kelley <mhklinux@outlook.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-13-aneesh.kumar@kernel.org>
 <ami_mpd_1pF4Tmdu@google.com> <yq5a5x1ygo7z.fsf@kernel.org>
 <amnRB98ZZIysHuM3@google.com> <yq5acxw6dl1d.fsf@kernel.org>
 <20260804142032.GC27883@nvidia.com> <anL9-OrDGqYQAWNV@google.com>
 <20260805123023.GO27883@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260805123023.GO27883@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-08-05 1:30 pm, Jason Gunthorpe wrote:
> On Wed, Aug 05, 2026 at 09:10:16AM +0000, Mostafa Saleh wrote:
>> On Tue, Aug 04, 2026 at 11:20:32AM -0300, Jason Gunthorpe wrote:
>>> On Wed, Jul 29, 2026 at 06:12:38PM +0530, Aneesh Kumar K.V wrote:
>>>> There is a possibility that we may support io_tlb_mem with cc_shared =
>>>> false in the future. As a result, only swiotlb_map() knows which type of
>>>> bounce buffer was used, making it the only place where the attributes
>>>> can be updated correctly.
>>>
>>> Yeah, +1, the attribute should be changed at the same effective place
>>> the source memory is changed away from what the DMA API user
>>> provided. Only the thing providing the new memory (eg swiotlb) should
>>> know its properties.
>>
>> I will keep the conversation here instead of 2 threads.
>>
>> That seems like a big leap, I'd be worried about devices that operate
>> on confidential data that should not be shared/decrypted.
> 
> That seems like something very differnt.
> 
>> One example for this which exists in pKVM (this part is not
>> upstream yet) is non coherent devices that require bouncing but they
>> still want to keep the data private. In that case ideally they get
>> an encrypted SWIOTLB pool, but it's always better to fail than to use
>> a decrypted pool behind it's back.
> 
> We don't have any API for a DMA API caller to signal 'must be
> confidential'. If we want to add one it would be a flag to check
> before changing the physical address in swiotlb.
> 
> As defined today the DMA API expressly copies from private to shared
> memory, that is baked into it's design and not a bug.
> 
> My expectation is all these cases have to be solved by setting up the
> swiotlb properly so it provides suitable bounce buffers. Yes, this
> means we will eventually need both private and shared swiotlb pools.
> 
>> I have not been following the work on T=1/T=0 devices, but IIRC, they
>> required some complexity to handle their stage-2 as these modes will
>> be emulated differently (for CCA, RMM vs untrusted host).
>> I was thinking that it might be easier to represent those to the
>> guest kernel as 2 separate devices (bounded to different groups...)
>> where one is trusted and the other is not, and that way the DMA-API
>> can have strict rules about memory sharing.
> 
> No way! That's would be a giant disaster for the driver model.
> 
> Each struct device will have a flag that shows if it is in T=1 or T=0
> state. The flag can only change while a driver is not bound, and
> changing the flag will update the DMA API configuration.

I see we no longer seem to have the concern of devices in TDISP RUN 
state being able to send T=0 transactions other than MSI writes, where 
GICv3 means the host is already going to have to be in on the game to 
some degree there anyway. There could still be a potential concern of 
other non-PCIe equivalents wanting such a thing, though. However, even 
then we don't have support in firmware bindings nor the IOMMU API itself 
to be able to describe a single device being associated with both the 
RMM's vSMMU for the T=1 (Realm) VA space, and the NS VMM's vSMMU for the 
T=0 VA space, even if we did only have to care about using strictly one 
or the other at any given time based on device state. Having distinct 
struct devices is indeed clunky, but does at least reduce the problem to 
a currently-manageable one of the client driver having to wrangle them 
as a pair. Note that there are other such hardware properties that may 
also differ between states, such as ITS frames when we do get GICv5, so 
in fact having separate descriptions of the "shared" and "private" 
aspects of a device, based on their respective MMIO address aliases, may 
not be entirely unreasonable for CCA - making OSes understand that seems 
like it might be easier than having to reinvent swathes of ACPI and 
Devicetree bindings (and then still having to make OSes understand *those*).

> A T=1 device should have the same issue as you point out for pkvm, it
> really needs to have a private SWIOTLB pool.

Yes, once device_cc_accepted() is true then we *must not* inadvertently 
share any DMA buffers, if the caller has not explicitly requested 
CC_SHARED (tying in to the XT use-case), otherwise we'd be breaking the 
end-to-end confidentiality that TDISP/IDE/etc. is all about. So until we 
do have an additional private SWIOTLB, we will have to just fail 
mappings for an accepted device which would otherwise want bouncing due 
to DMA mask or alignment limitations.

(And FWIW when we do get there, I'd be inclined to make the default 
SWIOTLB the "private" one, so all the sharing/decryption stuff can be 
neatly partitioned off into the CoCo etc. special cases...)

Thanks,
Robin.

>> Otherwise, SWIOTLB does not seem like the right place to me, as it
>> does not understand the context the device is operating in, and the
>> DMA-API should deduce that from the flags passed.
> 
> It is exactly the right place because it is the one supplying the new
> memory. Context is irrelevant, the flag only describes what the new
> memory actually *IS*, and swiotlb knows 100% if the new memory is
> shared or private.
> 
> For your issue it would be appropriate to add a debugging check that
> the new memory is not incompatible with the expected policy. eg a T=1
> device getting decrypted swiotlb memory is a bug in swiotlb setup that
> should be caught. But that's a debugging check, we expect the swiotlb
> to have selected the right kind of memory by construction. This isn't
> done yet since this series doesn't even yet support a T=1 device..
> 
> Jason


