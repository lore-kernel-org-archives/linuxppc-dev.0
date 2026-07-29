Return-Path: <linuxppc-dev+bounces-25005-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAB2C54F51
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 12:43:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9Bnh2Yg4z2yDr;
	Wed, 29 Jul 2026 22:43:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785328984;
	cv=none; b=PWRuy9998j82PFE0LSNLAIrMF8ucVYV7lp2eZiLGSnq/FNukfwGbGUydlwMm/SDwW3SQMqoCAl6MhyQtmK1r7PSiZS1rBkH6R0vHRwY+KEmS+G2ZhgNlqdK5Vds58yj84QFR/Td7eclxoUEf5hIYTs3aaiuBCHm3G4FHqTLF9fdXHZqaxkOXC9vW/08yttQCTLkRANeFvDmshRrSYDpp4/2qWL4PEP3+/BGc2s+YtYDP3hKhQitePo3vRK8gULlOrRfFXOj0kX5ikhbXUGZbnwp7zuJuGNyFAWc6Me10bzYgbz4YUNljYM30WbU8GOqyYddNc0W4q8X9slWeB4sWhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785328984; c=relaxed/relaxed;
	bh=Bj9zUQeAnHt3kbxhKKqsrB/Vw/2J1kCjeLL3HysJ+OQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lugVRgKqwaUELtnCOHupgkhbumKpCk7qzhaEZqMy5ZK64yhYVDHicNx9lAcJ1bJCrDek49G+IbMx0sV/h/OUG2ao1qRBx2/zviK4BPFj/nq0C+KlZkbcyvMWfu4OKUj1rj08c14IxhN1v6u+7PsFsEFlKgyR5Ozpj7+21zsimiFj+Rsckwud6ZdcylsbRA7xLcAhuqcdAIhyzLZreFX55FYmJ9iGhrLZ3pkXcxXGIZHqdmp3zNesTKiNYaJoLTTv2lPDkErVhxBmO78FxUWbXl0EFBKBjKgGVSJJj93VfGFzfqVHiZ3ePn86x6c9JvatyqiVMJj9YTsMn+XIpH26XA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fk51lgHO; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fk51lgHO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9Bnd5JdCz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 22:43:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DBC15408FA;
	Wed, 29 Jul 2026 12:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AFC1F00A3A;
	Wed, 29 Jul 2026 12:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785328976;
	bh=Bj9zUQeAnHt3kbxhKKqsrB/Vw/2J1kCjeLL3HysJ+OQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=fk51lgHOMjZ7UJy7rfHUcnROpoZJbqgvZ+c4OYkSOe9jR6EyxJQLtCRvfMrkzVzx/
	 Rf5/RAEHf7GArTBqQ2VB+DFRw0QyG2ql7V72s/sHnBfMKNLGNkKhrriLiArX2QJ6cx
	 1qjqorspgFLmPUCGw/ASAMk1xr2Hf3oQaNKGeNdpiutzp0s+nYTRSZ/CF0deF+AX7m
	 j+0tciNij7lI/yw9EWy9c9F87NR3fNmwd7IBMyco2FdZOP3CL96MBIgHeLxBgXTGUm
	 RadyiuP8fXfsneErpOdP7H1gRrbUQIP2TUtweQLf125QqSdmlDtS8C9gom80W6A0AG
	 Isf/jYJgsYTQQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 12/23] dma: swiotlb: pass mapping attributes by
 reference
In-Reply-To: <amnRB98ZZIysHuM3@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-13-aneesh.kumar@kernel.org>
 <ami_mpd_1pF4Tmdu@google.com> <yq5a5x1ygo7z.fsf@kernel.org>
 <amnRB98ZZIysHuM3@google.com>
Date: Wed, 29 Jul 2026 18:12:38 +0530
Message-ID: <yq5acxw6dl1d.fsf@kernel.org>
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

Mostafa Saleh <smostafa@google.com> writes:

> On Wed, Jul 29, 2026 at 02:35:36PM +0530, Aneesh Kumar K.V wrote:
>> Mostafa Saleh <smostafa@google.com> writes:
>> 
>> > On Fri, Jul 17, 2026 at 11:34:30PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> >> Change swiotlb_tbl_map_single() to take the DMA mapping attributes by
>> >> reference and update the direct callers accordingly.
>> >> 
>> >> This is a preparatory change for a follow-up patch which updates the
>> >> attributes based on the selected swiotlb pool. Keeping the signature change
>> >> separate makes the follow-up patch easier to review.
>> >> 
>> >
>> > I do not understand the point of this, why would
>> > swiotlb_tbl_map_single() force attrs over the caller which should
>> > already know the context (whether DMA is shared or not) which case
>> > would this be useful to force from the SWIOTLB code?
>> >
>> 
>> The mapping request was for private memory, but the device could not use
>> it because the dma_capable() (force_dma_unencrypted() == true) check
>> failed. As a result, dma_direct_map_phys() allocated a swiotlb bounce
>> buffer, which is shared. Since the DMA now targets the shared bounce
>> buffer rather than the original private memory, the attributes must be
>> updated to reflect the new shared mapping.
>> 
>> dma_addr = phys_to_dma(dev, phys);
>> if (unlikely(!dma_capable(dev, dma_addr, size, true)))
>> 	if (is_swiotlb_active(dev))
>> 		return swiotlb_map(dev, phys, size, dir, attrs);
>> 
>> 
>
> But it does not make sense to me to have it in such a low level
> function, and it shouldn't change the attrs that was passed.
>
> dma_direct_map_phys() is the right place to do this it should set
> the correct attrs before calling swiotlb_map().
>

There is a possibility that we may support io_tlb_mem with cc_shared =
false in the future. As a result, only swiotlb_map() knows which type of
bounce buffer was used, making it the only place where the attributes
can be updated correctly.

-aneesh

