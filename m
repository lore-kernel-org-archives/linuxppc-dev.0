Return-Path: <linuxppc-dev+bounces-26436-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C13EC61DD6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 10:34:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZfHc0ZNWz2xlv;
	Wed, 02 Sep 2026 20:34:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788345292;
	cv=none; b=gGs9+FqEe4P0xpKDk45vFbP3dj7reBJqSzAj2+lUyfnWAA8NJET9xGDNCmKzta1OAS50sKoOq/LRmv5d6N+v4tVAv7bdtPAFXxOrFKyCfEbwNib/ldao4BY0/WNO67faAMvWSyjKzEwLA3YAHW5LOlKfXMs/ixh9xlXAgknv280MB9AjrHPvtRdsKQruveN1sWpv+dyepao/7F6izvAgO5t6GT6ZQ3xwF3QIdriOxeJEOJK/LYy1Y6rKjWB8lrMhaYkPCfZRryvvRfr6HU+8Q5cljo1IoK2dzGOQQiSFkVpo1LyOVYW5AVHBc58fNFC5Zc4+OqWN1/a3lQUEaw2++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788345292; c=relaxed/relaxed;
	bh=MK28dQ5f53A24fyld3wbG3aqc9VcU43UIzUwKaic+Ts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PAOV3SHHFM9zpD0bmd7bOreicFlL/9OdiVifID0HmUmBHi7kibSVeKTNLzjYxp8jDyiMzH941nHrcr0sWodE/CooAGvA3Ip9M3O/ZI+78pG2+DgAlfvwImMDhAtxCiSCddTENSwu2mU0IYf9Bo/xYJBLOBxUJpvsWE3s4JwhkDgzeEPNBvO84DjDnBEt1Vgh4xmLZF6OSQwhb8yJ0+zOJAwx/5ZG2g0k/Dh0/yLULkTrRerj4WzCmHp+aOeIaTCKQ+CKSgqKWCTgHYz+uY30J573IobvVQ27gXLKtdwBAYUCWTIImREyFJeUSoQNUShTd8df9Gi61lUGQG322wKWlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PFpCr8hA; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=pratyush@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PFpCr8hA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=pratyush@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZfHb0Bs7z2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 20:34:50 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 05CCE600C8;
	Wed,  2 Sep 2026 10:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEC31F000E9;
	Wed,  2 Sep 2026 10:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788345287;
	bh=MK28dQ5f53A24fyld3wbG3aqc9VcU43UIzUwKaic+Ts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=PFpCr8hASHzna++msY6KvlxeS6DrPD4/RHcCpalQJAkRCZ4yhqO43xVqeNQVkpLpI
	 0nZP+hPaVPbQew8wieA7UJ8rcn2CYfceSAC4vOIbi5chacl0ivAErzJ0ZOyozwo3xk
	 Tfi5l6KhXJdPajZ/WjMn0kYOl3207/H1O8Klw2HyK1DdGnVtCdnJNJKOvuEewKLYgO
	 cvGeNXDtQkqwvm81J54oSMooJpsA/HCyE13C5IGVaXgHnLhr7CH8krUYzP700eLbSu
	 Y0gMa9bP7yDLAFpPP+01rF7Z+R2xg944CSyEBR0RGNIHfYzaQu0zu0CNZnm9OKyX2r
	 HSIeAI5YkeYrA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  linuxppc-dev@lists.ozlabs.org,
  Aditya Gupta <adityag@linux.ibm.com>,  Alexander Graf <graf@amazon.com>,
  Andrew Morton <akpm@linux-foundation.org>,  Baoquan He
 <baoquan.he@linux.dev>,  "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>,  Hari Bathini <hbathini@linux.ibm.com>,  Madhavan
 Srinivasan <maddy@linux.ibm.com>,  Mahesh Salgaonkar
 <mahesh@linux.ibm.com>,  Michael Ellerman <mpe@ellerman.id.au>,  Mike
 Rapoport <rppt@kernel.org>,  Nicholas Piggin <npiggin@gmail.com>,  Pasha
 Tatashin <pasha.tatashin@soleen.com>,  "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>,  Shivang Upadhyay <shivangu@linux.ibm.com>,
  Shrikanth Hegde <sshegde@linux.ibm.com>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] powerpc: add support for Kexec HandOver (KHO)
In-Reply-To: <7bb84b8a-c394-4895-9e22-632dc506cbb6@linux.ibm.com> (Sourabh
	Jain's message of "Sun, 23 Aug 2026 21:11:05 +0530")
References: <20260821105609.983622-1-sourabhjain@linux.ibm.com>
	<20260821105609.983622-3-sourabhjain@linux.ibm.com>
	<2vxza4qfznyo.fsf@kernel.org>
	<7bb84b8a-c394-4895-9e22-632dc506cbb6@linux.ibm.com>
Date: Wed, 02 Sep 2026 12:34:42 +0200
Message-ID: <2vxz5x0ox7p9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
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
Content-Type: text/plain

On Sun, Aug 23 2026, Sourabh Jain wrote:

> On 21/08/26 17:26, Pratyush Yadav wrote:
>> On Fri, Aug 21 2026, Sourabh Jain wrote:
>>
>>> Add the architecture bits needed to enable CONFIG_KEXEC_HANDOVER on
>>> powerpc.
>>>
>>> Set ARCH_SUPPORTS_KEXEC_HANDOVER for PPC64, following the existing
>>> pattern used by ARCH_SUPPORTS_KEXEC and ARCH_SUPPORTS_KEXEC_FILE.
>>>
>>> On the boot path, parse the "linux,kho-fdt" and "linux,kho-scratch"
>>> properties from /chosen and pass them to kho_populate(). This lets a
>>> kernel booted via KHO kexec recover the FDT and scratch region left
>>> behind by the previous kernel. The call is placed early in
>>> setup_arch(), before unflatten_device_tree().
>>>
>>> Open issues:
>>> ============
>>>
>>> This patch also adds "depends on !CRASH_DUMP" to
>>> ARCH_SUPPORTS_KEXEC_HANDOVER. This is needed because of an ordering
>>> conflict between crashkernel reservation and KHO scratch reservation
>>> on powerpc.
>>>
>>> Crashkernel memory is reserved very early in boot, from arch-specific
>>> code: head.S -> early_setup() -> early_init_devtree() ->
>>> arch_reserve_crashkernel() / fadump_reserve_mem(). KHO's scratch
>>> region is reserved later, from generic code: start_kernel() ->
>>> mm_core_init() -> kho_memory_init(). So on powerpc, crashkernel
>>> memory is always reserved first.
>>>
>>> This ordering causes a real failure. In the common case, crashkernel
>>> reservation on powerpc starts at a 512M offset (the exact offset can
>>> vary, but 512M is typical). So with crashkernel=3G, the reservation
>>> occupies memory from 512M up to 3.5G -- roughly 75% of the entire low
>>> 4G area.
>>>
>>> Since crashkernel reservation always happens first, that 3G is
>>> already committed by the time kho_memory_init() runs. It then tries
>>> to reserve a low scratch region sized at 200% of whatever is already
>>> reserved below 4G. With ~75% of that 4G area already taken by
>>> crashkernel memory, 200% of that easily exceeds the remaining space
>>> -- and since the low scratch region is itself capped at 4G, there's
>>> no room left to fit it. The reservation fails.
>> crashkernel has the variant "crashkernel=size[KMG],high", which ensures
>> memory is allocated above 4G. Unless powerpc has some requirement for
>> strictly having the crashkernel below 4G, I think it will make a lot of
>> sense to enable support for this feature. So KHO users can specify this
>> to get crashkernel working with KHO.
>
> I agree that this is one way to work around the low-memory reservation problem.
> However, there are a few things that come into play here:
>
> 1. On powerpc, the crashkernel reservation can go up to 64 GB for kdump. With
> the
>    current default scratch memory reservation policy, this could result in
> reserving
>    up to 256 GB of scratch memory: 200% for the high-memory reservation and
> another
>    200% for per-node memory.

That calculation looks off. It _should_ be 200% once not twice. So 128
GB total. If the allocation came out via the global area, it should
_only_ be accounted to the global scratch size. Similarly, only the
allocations made specifically on that node should be counted for the
per-node scratch size.

But I have also noticed this problem on some of the systems Google has.
Which makes me wonder if scratch_size_update() is broken and
over-calculating. I have this on my TODO list and have been meaning to
look into it, but other things keep intervening.

If you are interested, feel free to take it off my hands.

>    For fadump, which is the powerpc-specific memory dump capture mechanism, the
> crashkernel
>    reservation can go up to 180 GB. In this case, we could end up reserving up
> to 720 GB of
>    scratch memory, which is too much. I agree that users can tune this, but I
> think the
>    default scale should be more reasonable for powerpc.

Once we fix scratch_size_update() to actually use 200% and not 400%,
perhaps that alone will be enough? If not, we can discuss reducing the
default scratch scale to maybe 150%. But I'd rather do it for all
platforms if we do it at all, because this problem doesn't seem specific
to PowerPC.

>
>
> 2. Fadump also uses the crashkernel kernel command-line argument, but its
> reservation policy
>    is different from kdump. The crashkernel base address starts after the memory
> needed for
>    fadump. For example, with crashkernel=3G, the base address would be 3 GB, and
> the crashkernel
>    reservation would be from 3 GB to 6 GB. So, depending on the crashkernel
> size, the reservation
>    may or may not fall within low memory. Also, fadump does not support
> crashkernel=xxM,high.
>
> 3. I do have a patch [1] to support high crashkernel reservations with kdump,
> but this would not
>    work with Hash MMU. With Hash MMU, the kernel image is constrained to low
> memory, whereas with
>    crashkernel=,high, all segments would be loaded into high memory.

Oh, nice!

>
> So, while supporting crashkernel=,high can help address the low-memory
> reservation issue for kdump,
> I think there are still some powerpc-specific constraints to consider. I would
> like to explore
> whether we can fix the ordering between crashkernel and scratch memory
> reservations, so that we can
> avoid unnecessarily large scratch memory reservations and address some of the
> other constraints mentioned
> above. Please share your thoughts.
>
>>
>> Powerpc doesn't support this right now, but from a quick skim of the
>> code, I think it should be simple enough.
>
> I have patch series under review for the same:
> [1]
> https://lore.kernel.org/all/20260708143357.673251-1-sourabhjain@linux.ibm.com/
>
>> From
>> arch_reserve_crashkernel() you just need to pass a bool * to
>> parse_crashkernel(), and then pass the result to
>> reserve_crashkernel_generic().
>
> Due to some architecture-specific dependencies (such as RTAS), booting the
> kernel from above 4G with
> support for high crashkernel is not as straightforward as on other
> architectures. Patch 2/4 in [1] has the
> details.
>
>>
>> Solving the ordering of crash reservations and KHO is tricky and comes
>> with some difficult tradeoffs. Allocating crash from highmem should be a
>> lot simpler.
>
>
> Could you please elaborate a bit on what makes the ordering tricky and what the
> main tradeoffs are between crash reservations and KHO? It would help me better
> understand the concerns here.

The problem today is that kho_preserved_memory_reserve() (called by
kho_mem_retrieve()) does a memblock_reserve() for each preserved folio.
So if you have a lot of order-0 (or, 4k) folios, you end up with a lot
of reservations in memblock. The large number of reservations can slow
down later memblock operations like allocations too since memblock might
have to walk through a lot of ranges to find free memory.

We kind of work around this problem by calling kho_mem_retrieve() as
pretty much the last thing in the MM init. So all allocations prior to
this have already been fulfilled from scratch without any of the
reservations added, so it should be pretty fast. You only take the
performance hit at the end, where the only thing left is to release
pages to buddy.

Even then, the memblock reservations can get pretty damn slow. In some
of my testing with under-load systems, preserving a 2G memfd with 4k
pages can go over **5 minutes** in only kho_mem_retrieve() if the folios
of the memfd are fragmented enough. Plus there is the memory overhead of
the regions in memblock.reserved.

So long-term, I would like to get rid of the memblock reservations
entirely and use scratch-only mode all the way until buddy comes up. And
I would like to modify buddy init (free_low_memory_core_early() and
deferred_init_memmap_chunk()) to be KHO-aware and directly skip the KHO
pages.

This vision goes in the opposite direction of turning scratch-only mode
off _earlier_. And turning off scratch-only mode earlier is necessary
for doing crash reservations outside of scratch.

That is the tradeoff I mentioned. Hope I was clear enough.

>>
>> And on that note, I don't think you should do a depends on !CRASH_DUMP.
>> Even when CONFIG_KEXEC_HANDOVER is enabled, KHO isn't on by default
>> (well, unless KEXEC_HANDOVER_ENABLE_DEFAULT is set). You need to enable
>> it via cmdline. So it is entirely possible for people using KHO on PPC
>> to not use crash and vice versa. This decision can be made at deployment
>> time, not at compile time.
>
> Agree. depends on !CRASH_DUMP is temporary and will be removed once
> we settle the crashkernel reservation and scratch region handling.

My point is that !CRASH_DUMP can be removed _even if_ we don't settle
the reservation thing, because it is perfectly valid for the same kernel
to use either KHO or crash but not at the same time. These both can be
enabled/disabled at runtime.

[...]

-- 
Regards,
Pratyush Yadav

