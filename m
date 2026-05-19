Return-Path: <linuxppc-dev+bounces-21165-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADD6CD4F5B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 14:35:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKcfH712sz2yR5;
	Wed, 20 May 2026 00:35:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::736"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779201335;
	cv=none; b=POdp7lDrBlR3oHGk3PE9HCnrrpcu0dwtYAO4Jrw4OwZ3Nf6HIaTfxzbKwetW6XC0/r72qznGkGnBRErTyMJyocc2lSN4KgGwtExylHtUNQmKvcVdpe9Xak8BJZ/E2QIw+gRTyTPJvarRWwU7RPnvJWym4+yDo4iarPk55MhkyliFACWWYXCILTwUhQ1eX61kHcdvlCGPtFVpqSebpqym/TN85zcfoinj0AgTF1ASBIS6NMm1H8e14QmpvHqWflGx9M7skDAwKCG8ciXn29G89z/nZV1QCVjxdQ87IIYYvHA6sME50rxXo9Xcyf7hji4rRgM3H8ePmd4KrvF9oZgjTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779201335; c=relaxed/relaxed;
	bh=oQZO5nTRmEQFRCy1SP5NN6DtrD69wZAHlR442WwrJB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfnA2WvT5Xrb/IW30FtxfOkhlIfzOkYsH792f270vWM3ywjfswkgASAOeSLRK4hUqkPfI4rrT8XmQLeEHTpGFNE7B5RFmxXhbOqdAXkT0i9UtSZKv2H9O3sFfV/66Rr6xlXt8CqQzncpxwG/aaoD/Xq1+JZMx1wY3rJQe9teH74lxS8VE4Io2YkxYSqrKyupt9bgZgqi15VHbx1cnvKGPzkablXSjeZ/2PaGvg16nO2Ox4uui1wT87moWkw2xMuSm3NVjs7sdwyHKRks0St4qxb2n3rqHbRBQ9C7jQPF3lNDCcvLMDblP0N0N9Yfi9cTfnrKGhfm7BxWVtEyJ7xPBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Y1vUUj1x; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::736; helo=mail-qk1-x736.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Y1vUUj1x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::736; helo=mail-qk1-x736.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKcfG3zS1z2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 00:35:33 +1000 (AEST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-90ea08cc5ceso640425685a.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 07:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779201331; x=1779806131; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oQZO5nTRmEQFRCy1SP5NN6DtrD69wZAHlR442WwrJB4=;
        b=Y1vUUj1xHB9bFdW+tGGVMIrmMkqnLGzuPAb/ygZDgT8DmabLEE4FMFmHSz6ecE+1YW
         BRzzgbDa6Ghq/2nmN4ksmiVrAISilEncMksUUwfKcbOwhDXP4On+hSvjLNLdlI+NADYl
         QPjzTXPRthggcPSq/FaPX4wCSomOZ3LfsjpAU/TSMcTRWJUZaufxcR4+MnddsYUah9os
         eNr7oMWQsdeHmZMmFOflJwGBpuBu5M8CFugY7CX0noZRIlTx/TzPKWdFljF3mbBybnAM
         3RDmcN6nsfhkhyuXMfJSLDmawUq31qDG5LyzjY2DxFyuEOk+dKlxgHeqDgrOse8wKIef
         vj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201331; x=1779806131;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQZO5nTRmEQFRCy1SP5NN6DtrD69wZAHlR442WwrJB4=;
        b=YrMVHglEZHS3mrke19GP2k5veoyKjqhmWEr0WoKx9gfEYnnGKRvW6aDPVXC8F2IKHV
         3ed+tuG3JjZvCCQ5k/Z5nhndpE2kovSKX9ZaKNlysAEjSZ2CNzysYqlVO4ITkaxPGStA
         OL72o4OImQJbGUff285Faj0w6tlbM98BN4drokcqtP6Ks+FLn2roriI+qdE2EJn/RPui
         Yyy56DD3iCKsDilDz+0xItdtd2X3fuppfKFhps9hT4p7YJyMZkL3IgfltLdwvPQ6z53Y
         Y8DaouPsIqjFGjUyFFsY2dIhQlar/+O8pFI+38ZpUG97J/igH6ucRQsobrqXv+ElYWc2
         QHtg==
X-Forwarded-Encrypted: i=1; AFNElJ8O7rAPAWfT5nCs8VBBTa17GQ7MB4nIqmlJ0dtTfbrpFZlBOWUMRXlGPUcRfH6amMDoSgGyyRd0EdH2vIs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyqmPeHlrHatghK1iTkbUHAkcjE0g2ZdnyiU5JPEJJ71CC7Lv6T
	nqO7FKDGNztIfxeUc+OrV7dISYVnSY0UznjPa9YG2utmeHa7VHVTUSy9GUtHuSs+04I=
X-Gm-Gg: Acq92OHnlJMH0g00UmZytiAx4gmK9FzRBASBdHrKjcJ+z49jra0ptdRybu9iGCFdVHv
	yw9uFt6deWFybQ4YtEVITVY3iFWaqc2T8aazx528A/CMwWQytimQ5Tl1bW3CBT3xYQBgLs14imJ
	lhWx9CUZEET2uzWy7xx80wbE2J6I0iXVC8jjIzuNyVrTKO1pyWvcwt1k/bZmHypoxnGhVdKXNiN
	mIGkqwD05G5PBseT6hW5ahMzZzt50TFmX/4TNEiaQtzLIKgJ14WwSLIIy5AbP5Q8qh/DixKmfuy
	QxegQKvFl/Vklna+rzVWxVMUiTf3Bqqmfohuw+I07KE9zUISzVi80oBxN4p+PJT/lQiktjlYmbJ
	xzT80CH2vMGbRPoFrY49tzTl0yhvGf74c49Hp+DUjhZaWhOcKW2QaGOVeeObT2ARX2NRKDV+72V
	p9USmRAqft/pdWPE7+IbQ7oJ5ywAqV/jjyZEcrhSz8IPvRJ9WzCjOtj5A6n0mtUZSgWJZDXOtGj
	0BRug==
X-Received: by 2002:a05:620a:d8a:b0:913:e5bb:3db6 with SMTP id af79cd13be357-913e5bb548amr1506341585a.31.1779201330581;
        Tue, 19 May 2026 07:35:30 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83ff00sm1849026185a.26.2026.05.19.07.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:35:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPLXd-0000000F7pa-1dCL;
	Tue, 19 May 2026 11:35:29 -0300
Date: Tue, 19 May 2026 11:35:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
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
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <20260519143529.GD7702@ziepe.ca>
References: <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <20260519132911.GA7702@ziepe.ca>
 <agxolksC_1nfO34X@google.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agxolksC_1nfO34X@google.com>

On Tue, May 19, 2026 at 01:41:42PM +0000, Mostafa Saleh wrote:
> On Tue, May 19, 2026 at 10:29:11AM -0300, Jason Gunthorpe wrote:
> > On Tue, May 19, 2026 at 11:04:37AM +0000, Mostafa Saleh wrote:
> > > On Thu, May 14, 2026 at 08:13:25PM +0530, Aneesh Kumar K.V wrote:
> > > > >> 
> > > > >> What I meant was that we need a generic way to identify a pKVM guest, so
> > > > >> that we can use it in the conditional above.
> > > > >
> > > > > I have this patch, with that I can boot with your series unmodified,
> > > > > but I will need to do more testing.
> > > > >
> > > > 
> > > > Thanks, I can add this to the series once you complete the required testing.
> > > > 
> > > 
> > > I am still running more tests, but looking more into it. Setting
> > > force_dma_unencrypted() to true for pKVM guests is wrong, as the
> > > guest shouldn’t try to decrypt arbitrary memory as it can include
> > > sensitive information (for example in case of virtio sub-page
> > > allocation) and should strictly rely on the restricted-dma-pool
> > > for that.
> > 
> > ??
> > 
> > Where does force_dma_unencrypted() cause arbitary memory passed into
> > the DMA API to be decrypted? That should never happen???
> 
> Sorry, maybe arbitrary is not the right expression again :)
> I mean that, with emulated devices that use the DMA-API under pKVM,
> they will map memory coming from other layers (VFS, net) through
> vitrio-block, virtio-net... These can be smaller than a page, and
> using force_dma_unencrypted() will share the whole page.

force_dma_unencrypted() should only trigger swiotlb and that never
memcpy's more than necessary?

Where does it do otherwise? That sounds like a bug?

Jason

