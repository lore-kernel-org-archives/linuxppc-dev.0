Return-Path: <linuxppc-dev+bounces-21144-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9812CD4851
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 11:04:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKWz351rqz2yCM;
	Tue, 19 May 2026 21:04:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779188687;
	cv=none; b=jNw6McQYF8zICusTCqo0+KSL3z5zNOx8lJ8Q2g2qW+5xyrDbsW4H0v6dw+OmGx9RqmjMiKRz3G9s8Fm+MNJtEzsu4PaWuIm3gz2+45FxYUzvESAlppHHs/uYOtimU2cZ685EyZjozsK2wFb4c1oIe+h7PWgPejdLDzBP5fS8xgYrSK7rndCb88sJ8oQOMDeFhmAej9zsqRzYHdjB5Va6TrDDkPd3eKi5mCeC/FuZtNWQAQhxFDUku47WYHF4N0UgQekF8ZVHyenDb5nTnn5n21WKOAsv0qm+qEYNoh/RG8+kJ7xqIJIDlhzIl3V4651IzMYdwAEPmMlE0HmrIkrr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779188687; c=relaxed/relaxed;
	bh=a+e/82ARLCMhJAFToMBvP+HlY35DA3/x25Ks+dxKl00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4jlDhJiPwehDFq0NPaePadDlbYLb+lMtCttOM5qiLOrdwDxQpvqdbVEJ5kF5kJAp+MI61KTbDwh4XquVuQ6VxG9u9KL9pJuCEmerETLZiAt5trtgsLkgesvc6Z/v6Yqj26c34b+xiPJiw3SYcn0f/2vRkluA3O4owUzYIGjfpl3r9PQAT0scXOdlOHf9eWpMn6c2lQ90RF9wcYl2zuZTmYEok3QLp8XORBsy35Rgmr79FX68QMPMGoO3V0ctfYrv0S9A4jgufB9cTF5hm+Vy2oAP+GsU99EPJbFwI8k+coFwHNfFq7Nlx7jFH/vgZjujE4I0ZOxyjZgkbXshKQ9mQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=p3dZ9w10; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=p3dZ9w10;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKWz22M1rz2xwH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 21:04:46 +1000 (AEST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so795e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 04:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779188682; x=1779793482; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a+e/82ARLCMhJAFToMBvP+HlY35DA3/x25Ks+dxKl00=;
        b=p3dZ9w10fdVFqoNKpBJvZu4k6xQNgOxGl8rgP23KdSKh+kXB3HtL8XlOWaNCepfa3r
         aWfGbYkkONvHdUi0VR46a1wtukA9SuFw0F5vQSukiDY/FkyjTwFe5WJZXl37DkdPt60U
         k+Fok0QvNpqTAuoW1O1ux3vOld/cEOywLCniKS1W9E3CirpxXhid4pMOvzzD1aZn3NIc
         2Qvwh0WE2P1zSK/AomVyzdBSQvJr6dG8mrN6IsGjmRMmsdpRnlYjpFyqXdi0EnW7oHX/
         UUfs9W1VdGwCep9rz9aEm+Sf2fDeppsO3M/VTvfayEb5vtre+WOtwbr7BMbpH34lzSCi
         xAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188682; x=1779793482;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+e/82ARLCMhJAFToMBvP+HlY35DA3/x25Ks+dxKl00=;
        b=Ej3QqI/gXEsz0dTGAi3XxC7TtQsCmvDw5+jNxMh3iNx1Rs+kw58rMFfJILa6ih/WXn
         oZmamSNOUonrNJ85KrFphEee0GIMXk2gw8a9/4l4m8Dj/aT4+kp7dYr7PZyNXAiMabyF
         9gGz/Wo0xqoiWpRpoQ1+1vyCtAEHPHObldCy2UWzYAr3RLMYKBpa7HX60l7SqZvCcgDw
         2p2qrRPcfKwyF8z4EGD1THTHn8Ckfkmki4Rn9tVoSwSufIl5CszXPhZix5f6k8g+XJgL
         6wy5z3pbEyRSo/H9GoP9emr3Vruc0J+aecDFEsLK2e592tpbVziT4cFc5s+/5XKfHtc7
         4sCQ==
X-Forwarded-Encrypted: i=1; AFNElJ9dG+QAJWJmxNz5clmGtDo4Tza1Q02SxGPchN2jShfV5aNcpFli8CuZuQbln0Fv046WO1+2QBpfr0nL9qY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyUJOSwEPBrO1ZKOcOguzeOqoLpxO+tt2N7JRU1TDCAnu319Ok6
	D5jyv8qI2mFEJPCcXW2jskTHYQoxOOU/V69A6fZwMIk5ACYWlaM1KGmIAnhLIAu4Lg==
X-Gm-Gg: Acq92OH2GuZqTX+im+7fmfp1pADaxs3D9KySYUg6APw0QmRQIoI4oG75HjSFwbLrygO
	y/OnZ9PIjBH+nYG2x5lJNPD2AaA/ylKjMREVe7XOu3kEhISQAl+Mvg/URG+lVeOqPCXMqJySVhd
	5WPV2+ZIhmRg0GGRMneIDx/B82ZH0mLYkSPk5lQSYjOI8LWLnu4Gjutos5o4GB25VxR9T2FztiP
	MyLN1CMGwa043+3REXW7IIdXxz3iRUnslZpMXq3SuEv+olRZEE7XC3osH+jo7tXrlnwpG0w+aqE
	4gKeGx4tifl+jN2dX8m28mVihFqjT9yxLkY4eav78dOC3Ajx03l6bPplEQAUdhZIqWblhvpENRi
	n2ZMStU/t1oa5ewVg4+EpL1+IbHa4Rz52ZvAa1/1YD+jHTosyQNpfrOfNMI9l+rGlqvEf7lZe3b
	RZZZeDLQfJ/BsaHrWs/gqw+cRshu+gQLVlo91ruipLQEh4hUZiLi9K6ovztuZmdugWuz1wxs8IA
	ap2Ajt3jzfMLw==
X-Received: by 2002:a05:600c:2183:b0:48a:5d95:d33e with SMTP id 5b1f17b1804b1-48ffa5d593cmr2833855e9.6.1779188681631;
        Tue, 19 May 2026 04:04:41 -0700 (PDT)
Received: from google.com (136.41.155.104.bc.googleusercontent.com. [104.155.41.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c834besm340461595e9.3.2026.05.19.04.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 04:04:41 -0700 (PDT)
Date: Tue, 19 May 2026 11:04:37 +0000
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <agxDxdxynp4KEovA@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
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
In-Reply-To: <yq5ah5oa59wy.fsf@kernel.org>

On Thu, May 14, 2026 at 08:13:25PM +0530, Aneesh Kumar K.V wrote:
> >> 
> >> What I meant was that we need a generic way to identify a pKVM guest, so
> >> that we can use it in the conditional above.
> >
> > I have this patch, with that I can boot with your series unmodified,
> > but I will need to do more testing.
> >
> 
> Thanks, I can add this to the series once you complete the required testing.
> 

I am still running more tests, but looking more into it. Setting
force_dma_unencrypted() to true for pKVM guests is wrong, as the
guest shouldn’t try to decrypt arbitrary memory as it can include
sensitive information (for example in case of virtio sub-page
allocation) and should strictly rely on the restricted-dma-pool
for that.

However, with my patch and setting force_dma_unencrypted() to false
on top of this series, it fails on pKVM due to a missing shared
attribute as Alexey mentioned, as now SWIOTLB rejects non shared
attrs, so, the DMA-API has to pass it. With that, I can boot again:

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 5103a04df99f..b19aeec03f27 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -286,6 +286,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	}
 
 	if (is_swiotlb_for_alloc(dev)) {
+		attrs |= DMA_ATTR_CC_SHARED;
+
 		page = dma_direct_alloc_swiotlb(dev, size, attrs);
 		if (page) {
 			/*
@@ -449,6 +451,8 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 						  &cpu_addr, gfp, attrs);
 
 	if (is_swiotlb_for_alloc(dev)) {
+		attrs |= DMA_ATTR_CC_SHARED;
+
 		page = dma_direct_alloc_swiotlb(dev, size, attrs);
 		if (!page)
 			return NULL;
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index 4e35264ab6f8..8ee5bbf78cfb 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -92,6 +92,7 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
 			return DMA_MAPPING_ERROR;
 
+		attrs |= DMA_ATTR_CC_SHARED;
 		return swiotlb_map(dev, phys, size, dir, attrs);
 	}
 
-- 


I will keep testing and let you know how it goes. If there is nothing
else required to convert pKVM guests to CC, I can just post the patch
separately as it has no dependency on this series.

Re force_dma_unencrypted(), I am looking into a safe way to use it
for pKVM as I beleive it will be useful to eliminate some bouncing.
However, that’s not critical for this series and can be added later
as I am still investigating it, if I reach something I can post it
along the pKVM patch above.

Thanks,
Mostafa

> 
> 
> -aneesh

