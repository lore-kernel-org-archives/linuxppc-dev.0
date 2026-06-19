Return-Path: <linuxppc-dev+bounces-22823-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D93CD98F2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 13:36:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghdst12r0z3bpx;
	Fri, 19 Jun 2026 23:36:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781876194;
	cv=none; b=ARCRUiemlFWd9YTjASSq+rYLJqLO8j24jFruIollg3l4tJC+AWlSkmo1ihJedIkxasHTWXD1bWEMRpfL5bj8wYzSD4WmtlVoGG19oI92KQWvk10/s13vsARp41amGpv9bFswNGbpMzfCHtfnvwK1sHzGfwNY6UW7j/gwZq9qbU6gCN1dMPBPbywu6u8ccRQ5bg/UMvKaO7hgOTYakSEz7eN34qLobkA0zhHkfbUbeOAqd+vEkPNGo8+ef8FG45oNnlrtOMAquZDjX0sEc4Af34Dfkf9h/r/4P7Uwxi6xzrzC+PgXbepbSE8rsCQmIOEDflSDHI6i0fYtXTsZ4qM4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781876194; c=relaxed/relaxed;
	bh=MBitVv/Wp6PuH6BWLvxBrPjtZ76g3L5KKs3NVrBh8ZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CjGuBugXbm4oNbstijWiInGUBYD1fyHpAoAymn76zK4RfAcyC3NmZR6TGdiTaMTQigKHCuoSABcJjibRy21qRQfVmujxhOWUW9z87BsTNucrv5VH/EKIhY2WxqVebC9+2Jq5Mq8E4Vb185qVXPo0ivW0GJm8a8JIRvtmpZ4+DpxDVD4YETo4Cw8nRKih48zJy4IJSPZKyqB7gx/WPt/fujdJ7AdmyamX8ll6iJf8116QIHOqa7cVgqBuhgw8S8v21kGcfDrJ4kN6Q4eURKsOv0IknWvKTeWBignWKjL4OKXz03S9KXiTZVPYLDEkYpM1DfTvUWAakDKabOgELxjXxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kAH1+xXX; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kAH1+xXX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghdsr58FWz2ykX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 23:36:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5A9A0601E2;
	Fri, 19 Jun 2026 13:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF291F000E9;
	Fri, 19 Jun 2026 13:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781876189;
	bh=MBitVv/Wp6PuH6BWLvxBrPjtZ76g3L5KKs3NVrBh8ZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=kAH1+xXXWAZrnqaGD7/jcVVJZXKo1zqhlJeoVFzORJVb9aVkw/eIs71MOGxdZcaTO
	 gLj5qu44i7FTmN2rf5o3o/3j1qWmECbRssq5GeQm2sT4GmMMGH4Lse//y80zxxhIqT
	 eyzkJU4bptugVm248QSCRQqo6wkaBO5MtCdvWI+LkKIpVqimUNwXQyk7VRJgm6IXk3
	 ndmjfdpm/R6nLX5ltoS7VekJgvgsRGw66rPjZVRqav3g0KHKladHM/yUbPDEHAuJZV
	 RUHs/hLvB02W/2/PHdotsxouWvZD8zoQIaFae5QnDu6Xlklqdeh3wTLyYSkbez2bG/
	 fcXGVjxDeiEiw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
In-Reply-To: <20260619122148.GL231643@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com> <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org> <20260618153705.GH231643@ziepe.ca>
 <yq5ao6h6enhm.fsf@kernel.org> <20260619122148.GL231643@ziepe.ca>
Date: Fri, 19 Jun 2026 14:36:19 +0100
Message-ID: <yq5aldcaejos.fsf@kernel.org>
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

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Fri, Jun 19, 2026 at 01:14:13PM +0100, Aneesh Kumar K.V wrote:
>> > And this is more insane logic. The right fix is to allocate the
>> > swiotlb bounce from the *encrypted* pools when running on the
>> > hypervisor which requires undoing this abuse of force_dma_decrypted().
>> >
>> 
>> Agreed. If the device can do encrypted DMA and requires bouncing, it
>> should bounce through encrypted pools. We don't support encrypted pools
>> now and that means, we mark the option ("mem_encrypt=on iommu=pt
>> swiotlb=force") not supported for now? 
>
> ?? if you don't have a CC system then the swiotlb is "encrypted"
> meaning ordinary struct page system memory.
>
> The hypervisor should not be triggering any CC special stuff here, it
> is not a CC guest.
>
> Agree we don't need to worry about swiotlb=force with a trusted device
> in the GUEST for now, but it should be something to fix eventually.
>

If i understand this correctly, the setup Alexey is referring to here is
bare metal system with memory encryption enabled and dma address doesn't
need C bit cleared because it is handled in iommu. ( I consider this as
memory encryption that is handled transparently, device can access any
address because that encryption details are now managed by iommu).

Thinking about this more, I guess we should mark the swiotlb as
cc_shared only with  CC_ATTR_GUEST_MEM_ENCRYPT instead of
CC_ATTR_MEM_ENCRYPT as we have below.


	/*
	 * if platform support memory encryption, swiotlb buffers are
	 * shared by default.
	 */
	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
		io_tlb_default_mem.cc_shared = true;
	else
		io_tlb_default_mem.cc_shared = false;

....
	if (io_tlb_default_mem.cc_shared)
		set_memory_decrypted((unsigned long)mem->vaddr, bytes >> PAGE_SHIFT);

So we consider swiotlb as encrypted pool in such config.

Now we have the case of host memory encryption where the C-bit needs to
be cleared in dma_addr_t. That requires special handling in the kernel, and
I believe we need to mark swiotlb as unencrypted in this configuration.

I am still not clear whether there is a config option or runtime check
we can use to identify this case.

-aneesh

