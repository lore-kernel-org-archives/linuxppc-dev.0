Return-Path: <linuxppc-dev+bounces-24986-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C84BC54F51
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 10:08:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h97M742Bsz2xnp;
	Wed, 29 Jul 2026 20:08:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785319699;
	cv=none; b=ow/rCbPaAhKrQRzEW1mKhIfx459elm2tUlpza7hYTSVaG8YrMVDdznpWUrhPz+XiqouNZwAOLCr8AqrtlqLzdPHJAi1+cb9nyx9rjI2Mo/PXOjYbKcMdN7+YZ40Np7DX2v9jxZ/0QDFJN+jWuniruMoU1WD8yl2Oae8gatJJ9Y2ha0OG0GkUu0Y1hePF7H8Ci+yUQSfRz7E8H9M2lvJm7j/YwRzZqnkUvoW+2IYmDUVkOa0JfgzoQfYTja+AlukI2akN3wRF1t564cVWVCXGb5QCjR6uAfFt5ZLLby1bArvF4HC/SjEPoK5CfcqB35euWvvGFD4gu9vPQ1dlTKsMLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785319699; c=relaxed/relaxed;
	bh=y+s7LRa+xfn1TaMGIJNFktf1+ZXT37mg0JkHIAIfYYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EB5ttefZ/Jcq9pSx3ekgRxDADBL0HUZGpjryk77k+e621w8lDeSbkHOQRvJ4bLJIGSoXUHGwsLpAoPq1xHdhQtUWdSJKR24rvuZ0oB5S8ljqL+DfIp9j+j+lZO0HikJAJHOtp+Q2CZahM3ZVAkpL4fwyER7HSD1ejlxTuKXcBEj+8SnM5OHbyZgfg/l3IDLsOX++ZldKHVjG6uP0+bnUqQfEtCYv3K4MiT5X2UyPhZpI6tMVzhMaX9d+MyPekOu4m/bg7pfWTQOIBg1EHdlhFfrt9Ec2i5kjqPmvXDrWU1Hi/0zf59Mt+nyKpn3wX8ZIjrESOgwX+8gC21U9kmgMcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XLsYN2c7; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XLsYN2c7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h97M61FsQz2xFc
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 20:08:17 +1000 (AEST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso6607a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 03:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785319693; x=1785924493; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y+s7LRa+xfn1TaMGIJNFktf1+ZXT37mg0JkHIAIfYYQ=;
        b=XLsYN2c7Egff8enNgrbjxlaBhkJZJvaNOZ5obZ4wpZAe7sulZ4fJfSCJGRx/fv8c9k
         HbNFRGsmqkDvoQIiqp7jM9caZzKC4dkNWQNRgv6ZjSF7mJRrSRAShjvgeH4G5LMINtE0
         A0LssHGFKVNXBYtkDbBCW16+CLW1FrnHrseWIMZrCZeLMzIqDKIM3ti1kx0DirVbQh6+
         ECtXT3YvtOMj0umsspr9mxUVYXPgMmYIm9D+heuBofVBDESYIO0xu+bHyWhQ+v4rMYBl
         RcU95GR8Z7kgWVuGIbMCY7Z6O+9y/laUeaiT0Sun+HSgYZOsFDBbthW6haisSmTRP5Ur
         4kxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785319693; x=1785924493;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y+s7LRa+xfn1TaMGIJNFktf1+ZXT37mg0JkHIAIfYYQ=;
        b=TdO44teCgL45wXCeM8eSQCVupc6ajwAPmMd3sq8hOcJS653vddgq6cgesnuWpat7Wi
         +xkBwTZj5HWKO5LTd1HmnELAIRQ3JPGaziDuRe/dbjLNGQfUuCrCZ8noKSrZHnZYaeNs
         aiD9Bd4kAs582SUaOfMo+TMoB1kiFn+9yFMlh/w7miTztPVEWYpOcVAeGwMUsM2dnKMM
         4+1tOAUrPhEgdkm7G3E+9OsjsNajqFeHVbGmQWqwV1cYXdz6npVFJ+dekAKwRn3Acy6x
         lXPzbOajZb7r8eHQ+T6etIwAuORLH+kg3ScUCbhNP+Mm1FT91ijs0hzQ+fvsanutDbZW
         GE6Q==
X-Forwarded-Encrypted: i=1; AHgh+RoXNn8ZbytDV6t4i9QJKlJ0hbr3h9FqlRXpyVPoSoydNYHHjK5CdzYTbLA988dlWpFturPpWSeVmOy3ylE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxrUyOhvUaiUzv4v17CXNLQNrPAieDls4FCvXZD1Biw2rqY4Lj1
	HcmOQAd9DlVr4ZPNQ/8dJWms15zoTJQKlPggzHvNeDMliCCecReRpNh8azfn31mfqQ==
X-Gm-Gg: AR+sD104q+1/onktOo8/LJrVQnDtlroSJOmL+S2Eu0PmmgjcZRU+5GW2j4aBjlnnlWr
	52t7Pz0hh9t1CjuisIu5rFOlv14RgmvYJaSQH6Yzev582WKMdkWFUnlIAuNfYLEiebhU8AA38ff
	wYiAryEUHHR6upltWqRrcF4Ov9PpnFlURH5OjJcr2Ty3EnmYjvfykzmk6VEc9snpPT3FrzW01ER
	pZsa21swDchNysrFAs5oJ7yeC9+mr7/zHag4tTFlAz0pAgNuPB0x0Huuj7fUt4y0ykSLuAm90s7
	R1Wa7lIcb0DV4MH0VT/SO508t2bR/mxPQxd1UW+vfS1grQik6n289qALntIS8pSQ8uwdJZhR7aW
	tH+XyqWbxl6etT2snNI+UAIILy2P4itZkfLsINMbb5xZYJ6q14W7RmI1X+JcRXBvybvtevjIuLq
	QvnEz2ryplkxheKrl3EPkJft+UPqpDdXdEvKwsYL2RWjECOXucrdqXPv8E+REaJl9zzJx/Z2clH
	bc/C0rWoQC4XCZwNtpjMvULm4ymAw==
X-Received: by 2002:a05:6402:4244:10b0:69c:83f3:4831 with SMTP id 4fb4d7f45d1cf-6a063f622a5mr16396a12.7.1785319692673;
        Wed, 29 Jul 2026 03:08:12 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83f4dda2sm89863166b.36.2026.07.29.03.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 03:08:11 -0700 (PDT)
Date: Wed, 29 Jul 2026 10:08:07 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Petr Tesarik <ptesarik@suse.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 12/23] dma: swiotlb: pass mapping attributes by
 reference
Message-ID: <amnRB98ZZIysHuM3@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-13-aneesh.kumar@kernel.org>
 <ami_mpd_1pF4Tmdu@google.com>
 <yq5a5x1ygo7z.fsf@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a5x1ygo7z.fsf@kernel.org>

On Wed, Jul 29, 2026 at 02:35:36PM +0530, Aneesh Kumar K.V wrote:
> Mostafa Saleh <smostafa@google.com> writes:
> 
> > On Fri, Jul 17, 2026 at 11:34:30PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> Change swiotlb_tbl_map_single() to take the DMA mapping attributes by
> >> reference and update the direct callers accordingly.
> >> 
> >> This is a preparatory change for a follow-up patch which updates the
> >> attributes based on the selected swiotlb pool. Keeping the signature change
> >> separate makes the follow-up patch easier to review.
> >> 
> >
> > I do not understand the point of this, why would
> > swiotlb_tbl_map_single() force attrs over the caller which should
> > already know the context (whether DMA is shared or not) which case
> > would this be useful to force from the SWIOTLB code?
> >
> 
> The mapping request was for private memory, but the device could not use
> it because the dma_capable() (force_dma_unencrypted() == true) check
> failed. As a result, dma_direct_map_phys() allocated a swiotlb bounce
> buffer, which is shared. Since the DMA now targets the shared bounce
> buffer rather than the original private memory, the attributes must be
> updated to reflect the new shared mapping.
> 
> dma_addr = phys_to_dma(dev, phys);
> if (unlikely(!dma_capable(dev, dma_addr, size, true)))
> 	if (is_swiotlb_active(dev))
> 		return swiotlb_map(dev, phys, size, dir, attrs);
> 
> 

But it does not make sense to me to have it in such a low level
function, and it shouldn't change the attrs that was passed.

dma_direct_map_phys() is the right place to do this it should set
the correct attrs before calling swiotlb_map().

Thanks,
Mostafa

> -aneesh

