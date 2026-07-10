Return-Path: <linuxppc-dev+bounces-23991-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19584C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 05:23:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxKwq362vz2xlw;
	Fri, 10 Jul 2026 15:23:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783660987;
	cv=none; b=ZHmUnpGG53mxNuyxxa8H4Vm2yudKlHoBtm2KNHamsmS/s2MJ6PEEiOflC4Q67VDn+/X0ZCVVerSvwcqQ3On3R2hR3zIcgHIIiJMC+4RQ+Cov5vx1/Sxou2maqdlq6G4z6Ncr0i6xx7tWuFIvZdj9UhYNl615+Sb6nRBV+wSVRdpfMuFDOxRHF5PmU49J07AIH9RWezvVeDC3BUE5SibjU5V9JIKBS2fVPtgvsT9LPCxIpdee8Zfym+UU/0RGTtk0C2/wPl3s8A0SJUpLqw1E5SgP38qxE0wR50lQfQfleogOnnn3AQCHEMP0c6Tj1Qh5gYfsY4O4g81AOyiWHnyjHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783660987; c=relaxed/relaxed;
	bh=550ooWT8542+63+b73F3KAgnV89CFJo9aC92rxEIRio=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uc2UkRrRPnOj/INHDJA9xtFAD3+pVoFdCmKjx6IQ7IIn87yuSXA+h/VlfXbAfOH0bf8d+XD8U9nI/qI7gg+ggG/CVwSeIHkavLrAGHwm7PHfrlxwh92mAmPznL8MYQMbFMs0jp70+uutiXdZIcSc20Vlqm7162X9ToQPUr/IxyquKrsG7nj99Kl05sb8OlFnFVcLxcO5Li8LNQwOvL0cxMkJ+ZPV25arVpatyWHw0Fn+Qec7qJcvAoRJ/xZnfk8wArDOXjYrcCPsYC3cwo4OQTQtofPD6B7GLKWI9IaWCEhs1uBMZTKOGOJe2U7E1VZNvhlir41pfDL6DyIX94uTCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bNlSVXT3; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bNlSVXT3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxKwp2KZFz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 15:23:06 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 400E16001A;
	Fri, 10 Jul 2026 05:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EBD1F000E9;
	Fri, 10 Jul 2026 05:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783660984;
	bh=550ooWT8542+63+b73F3KAgnV89CFJo9aC92rxEIRio=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=bNlSVXT3ETCHbdeWOabjzODZivq8U9g4F7kEA6Aw4NSN7/iClos+6FnnRkEloBTQx
	 kYDdZ5It6cK3pDU1sVLNfVvyp92GT9KnRBSjY45JIhg78l32NwyF7rJpiRPqj0BVUP
	 8ZguLouhrS8wYHspEicQcK61eLs15Bcqz/9u2KhrJQJk4XgUD2q/0h/z4hDga0v9QI
	 eMeQxwFokadPjLOrsMZkF6JDmQ/8georqPF7vU27VTFLhMKBvJISPjIM8Mrs4P/TXt
	 yOJTeULh173Hgo7dKmAW3nhIaq8VFpWH+iVqc4tNoqbH1ucJJsZH4f7Af8vl/d9ed7
	 nijIDYfIjO2vw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mostafa Saleh <smostafa@google.com>,
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
	Jiri Pirko <jiri@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 16/22] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
In-Reply-To: <20260709181336.GM118978@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
 <ak42F240d-53QeFN@arm.com> <yq5apl0xgy89.fsf@kernel.org>
 <ak-CT3oanlDfgTy4@arm.com> <20260709181336.GM118978@ziepe.ca>
Date: Fri, 10 Jul 2026 10:52:49 +0530
Message-ID: <yq5ajyr3h106.fsf@kernel.org>
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

> On Thu, Jul 09, 2026 at 12:13:19PM +0100, Catalin Marinas wrote:
>> > > For AMD/SME, on host with memory encryption we now end up setting the C
>> > > bit for DMA_ATTR_MMIO. This is fine for RAM but not sure whether
>> > > some other MMIO bus understands this attribute. Maybe we should stick to
>> > > something like __phys_to_dma() for the !CC_SHARED && MMIO path. Or,
>> > > since this is not universally defined, just use the old dma_addr = phys
>> > > if MMIO and ignore any unlikely DMA offsets.
>> > >
>> > 
>> > Considering for AMD/SME system an unencrypted dma addr is one without C
>> > bit, will this be good?
>> > 
>> > 	/*
>> > 	 * For host memory encryption and device requiring unencrypted DMA,
>> > 	 * MMIO memory is treated as shared by default.
>> > 	 */
>> > 	if (attrs & DMA_ATTR_MMIO) {
>> > 		if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) || force_dma_unencrypted(dev))
>> > 			attrs |= DMA_ATTR_CC_SHARED;
>> > 	}
>> 
>> Yes, I think it does the trick, preserves the current semantics for AMD.
>> I guess you could use a single 'if' for all checks (up to you).
>
> Please don't change it, MMIO P2P is broken on CC systems today and it
> should stay broken. Passing DMA_ATTR_MMIO with DMA_ATTR_CC_SHARED is
> an error that we need to correct in the drivers not make work in the
> core code.
>

But the above changes are intended to handle HOST_MEM_ENCRYPT. In v7, we
had the following diff:

@@ -88,37 +88,40 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 {
 	dma_addr_t dma_addr;
 
+	/*
+	 * For a device requiring unencrypted DMA, MMIO memory is treated
+	 * as shared by default.
+	 */
+	if (force_dma_unencrypted(dev) && (attrs & DMA_ATTR_MMIO))
+		attrs |= DMA_ATTR_CC_SHARED;
+

This is now getting updated to

@@ -624,37 +626,44 @@ dma_addr_t dma_direct_map_phys(struct device *dev, phys_addr_t phys,
 {
 	dma_addr_t dma_addr;
 
+	if (attrs & DMA_ATTR_MMIO) {
+		/*
+		 * For host memory encryption and device requiring
+		 * unencrypted DMA, MMIO memory is treated as shared by
+		 * default.
+		 */
+		if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) ||
+		    force_dma_unencrypted(dev))
+			attrs |= DMA_ATTR_CC_SHARED;
+	}
+

I agree that we need to move that DMA_ATTR_CC_SHARED setting to 

modified   drivers/pci/p2pdma.c
@@ -285,6 +285,11 @@ int pcim_p2pdma_init(struct pci_dev *pdev)
 			continue;
 
 		p2p->mem[i].owner = &pdev->dev;
+
+		p2p->mem[i].dma_mapping_flags = DMA_ATTR_MMIO;
+		if (force_dma_unencrypted(dev))
+			p2p->mem[i].dma_mapping_flags |= DMA_ATTR_CC_SHARED;
+

As we discussed [1], that can come in a later patch. In the meantime, adding
the HOST_MEM_ENCRYPT check preserves the previous behavior for SME.

[1] https://lore.kernel.org/all/20260522132240.GD7702@ziepe.ca/

-aneesh

