Return-Path: <linuxppc-dev+bounces-19119-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C1410F92EC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 02:05:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flpGd4DpPz2yVT;
	Wed, 01 Apr 2026 13:05:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775009113;
	cv=none; b=LFmimoL3BHhkWXnHGCw9ZPaJgrYgs+0NeUhBlDatjyMT0T+2Zbxyd7g2mhFZX8cFIMOuhmyccdgVRhnHgFsQ6jer/9gPFPCGY9DPyg31tX1bcgkavbvt6TLckp3MNZKlWvp5KJSC9yg79+HpsSPOc61IRJYMyAiEqEFAOyKaN/40JLYK7R/5PGXscKvi3uMB3ZCgGKuJ0bt2iJ0kbF5xgjvknfIYRYy6MZfL7OKILpS7oHsneb+c7uqyuiDIuUG24wktNCz1qqsKSFisukNMrITzOob3S4V0I5SvoJMMYPz/g/wya2t8mFo3cLdlXkMQOF0nTaQshgBN05P8Yw6qUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775009113; c=relaxed/relaxed;
	bh=SJMfA7CNqV0/pOxot929IT3yuZq+Zmc7WLvwY3fmaj4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=M53uRh7Ss4b7nIbRTZg1kvuIoqHHhP8cN+c+6COKQTSdrK/WUuAq5COIjbG7lyfGWFT5ns1swZ5nlrBkH1Tu+sUf04MCWavbDJkr/Zq+5yZf5681b+RNcJaXEFWkM9Fr7CTTKsGfMCyc+XrzV3yCfIzdepArS5KIJfxdf5jCMTsyE+mHahgIDdVcNhP/eM2AG0KsVC4M+HYvVi0cKoHnGRMWExuk7EC6hBZlSDujuAc/TVqM2eOhaHI7fM1THSi/R4g+ZU5V1NFFi6p0sIFkFKypajQ8vA3Q7yDMsdMf5fq/+xIh1ty9pM4ycq/yg+1rVCirVGLMK/2g6smY3/4sYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UF8RxqUw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UF8RxqUw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flpGb4j80z2yfl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 13:05:10 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2b23f90f53aso39540615ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 19:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775009108; x=1775613908; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJMfA7CNqV0/pOxot929IT3yuZq+Zmc7WLvwY3fmaj4=;
        b=UF8RxqUwhcXeesk6kUjLHC39bLpClfdnmAL5JhbOIf//XYJtkgvUyQX3yqlJe9RXcm
         3qMCXuz4hUjCXhvPZzKexz/xZRmIxUh0/eGhHA1uZNfTjA+Z1UHd68tVNk8o44Y2DkV5
         3LcC5B9EB4wj7G7nVv1bVVdyVbVfSbSt2wiGH4hcBpGaBqYHPX4fkDh/GIsyd7K416tH
         PPQX3BgsqBlE1gV/TPFN/dnge9L3D//wBqZWWQ1aqoYI12xSD2F+9geB7/RVTHqxa7Xy
         8T1rhn11F6rTEH5bH62BO9MNixJ8fEB0ykZVHcb0hUMGJIl5OTXHRVX0z/Dd6ZgMa5lo
         zq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775009108; x=1775613908;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SJMfA7CNqV0/pOxot929IT3yuZq+Zmc7WLvwY3fmaj4=;
        b=tLXy8VuBIWP9VpuYe/pyzhLiFKDncWLtTgZZRY78X+QTclhsAOQ4k9MT0U6sMyVh3W
         3eMaB/iIQKY2MEtNNnjkpZBKn+PWiIJykmNDONjknxeuWMqjMyr3+6wsNyV2pdwsPgNp
         N8IHcL+QpGKaALOP7WDQgcPzhfKz8a1Z4JdenM36IlWJmtn2oVrbY/XhuqHMb9iNuOw3
         anDULqdtxZKqPdQHyKAdALlT2whwma8dl+kVqJvbExqaI88ZMxzcpDvTcB6nFS84TFr7
         jL7hCBxSWrRnlgKyfCwDNT0H/VFUjwE6XaWbi448QzuICz3uOBa7LkxP77cix6IXkOtT
         UOfA==
X-Forwarded-Encrypted: i=1; AJvYcCVQV82SO/GOt77V4RHyany2XzPE1PSH/lpzLQ78y6QCCKsEP7AtL0KXicSOSieqwNpkpC4M1DISwd8onEo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyvrzFRlTMmnJH1TY62drBSfPrTMq2vVNbnqJHB08CK2CVzShoh
	BjA1ptB8hYHboLXhSs7M2FeB6SB73msoIJvy5t01nTfxO1eJ1McoPPPg
X-Gm-Gg: ATEYQzy3s3/r2I2WtEU+djFWJ+gPvHHd4f+FlrDam9OOlMx3dISQTb4EZhnzKgkx1Cs
	spsrP8fLjKwo7BTMjJNgHnMaEBLMtefoHGvpttkppY1UbBW/mtJfEmCP9yy+ldL/EHdloUKKaVX
	WqlfarJ0t+ilGi+7yjK4yo0E9ljXgJrw5dp/7QSUnY1o68GwZk8oGSVEJXhuuzKkMhiJTkzAxJ0
	INU1CvxjW38VELWpUbZUERXeTLb+vw2W7w4igjUBpltiOVREK7+U1j2nPjpAQghAAOU0U+aSXCN
	SVhYDCvLI6Mz2CZt2lIy5GGO4QoA3SjboZpac3/kynszK/obPEXRGqRGv89aYxO9emf3kzLGsCI
	QoRqRJtZw9g8SjM0eubB2zWVVzdEXz9ETO52kZRYEYbd17zeH2m8bq92YU517SIWPjVyaCC2DrY
	xqRIBfNHgBpOq0HWCF54EBnw==
X-Received: by 2002:a17:903:287:b0:2b2:4bf9:1766 with SMTP id d9443c01a7336-2b269d28734mr13881265ad.33.1775009108361;
        Tue, 31 Mar 2026 19:05:08 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24268e7f5sm125994015ad.35.2026.03.31.19.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 19:05:07 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gaurav Batra <gbatra@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Gaurav Batra <gbatra@linux.ibm.com>, Dan
 =?utf-8?Q?Hor=C3=A1k?= <dan@danny.cz>, Timothy Pearson
 <tpearson@raptorengineering.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: Re: [PATCH] powerpc/powernv/iommu: iommu incorrectly bypass DMA APIs
In-Reply-To: <20260331223022.47488-1-gbatra@linux.ibm.com>
Date: Wed, 01 Apr 2026 06:35:23 +0530
Message-ID: <o6k3mqwc.ritesh.list@gmail.com>
References: <20260331223022.47488-1-gbatra@linux.ibm.com>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


++CC few people who would be interested in this fix.

Gaurav Batra <gbatra@linux.ibm.com> writes:

> In a PowerNV environment, for devices that supports DMA mask less than
> 64 bit but larger than 32 bits, iommu is incorrectly bypassing DMA
> APIs while allocating and mapping buffers for DMA operations.
>
> Devices are failing with ENOMEN during probe with the following messages
>
> amdgpu 0000:01:00.0: [drm] Detected VRAM RAM=4096M, BAR=4096M
> amdgpu 0000:01:00.0: [drm] RAM width 128bits GDDR5
> amdgpu 0000:01:00.0: iommu: 64-bit OK but direct DMA is limited by 0
> amdgpu 0000:01:00.0: dma_iommu_get_required_mask: returning bypass mask 0xfffffffffffffff
> amdgpu 0000:01:00.0:  4096M of VRAM memory ready
> amdgpu 0000:01:00.0:  32570M of GTT memory ready.
> amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
> amdgpu 0000:01:00.0: [drm] Debug VRAM access will use slowpath MM access
> amdgpu 0000:01:00.0: [drm] GART: num cpu pages 4096, num gpu pages 65536
> amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F4FFF80000).
> amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
> amdgpu 0000:01:00.0: (-12) create WB bo failed
> amdgpu 0000:01:00.0: amdgpu_device_wb_init failed -12
> amdgpu 0000:01:00.0: amdgpu_device_ip_init failed
> amdgpu 0000:01:00.0: Fatal error during GPU init
> amdgpu 0000:01:00.0: finishing device.
> amdgpu 0000:01:00.0: probe with driver amdgpu failed with error -12
> amdgpu 0000:01:00.0:  ttm finalized
>
> Fixes: 1471c517cf7d ("powerpc/iommu: bypass DMA APIs for coherent allocations for pre-mapped memory")
> Reported-by: Dan Horák <dan@danny.cz>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5039

We could even add the lore link so that in future people can find the
discussion.
Closes: https://lore.kernel.org/linuxppc-dev/20260313142351.609bc4c3efe1184f64ca5f44@danny.cz/

> Tested-by: Dan Horak <dan@danny.cz>
> Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>

Feel free to change this to the following, I mainly only suggested the fix :)

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> Signed-off-by: Gaurav Batra <gbatra@linux.ibm.com>
> ---

Generally this info...
> I am working on testing the patch in an LPAR with AMDGPU. I will update the
> results soon.

... goes below the three dashes in here ^^^
This is the same place where people also update the patch change log.

But sure, thanks for updating. As for this patch, it looks good to me.
So, feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


>  arch/powerpc/kernel/dma-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
> index 73e10bd4d56d..8b4de508d2eb 100644
> --- a/arch/powerpc/kernel/dma-iommu.c
> +++ b/arch/powerpc/kernel/dma-iommu.c
> @@ -67,7 +67,7 @@ bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg,
>  }
>  bool arch_dma_alloc_direct(struct device *dev)
>  {
> -	if (dev->dma_ops_bypass)
> +	if (dev->dma_ops_bypass && dev->bus_dma_limit)
>  		return true;
>  
>  	return false;
> @@ -75,7 +75,7 @@ bool arch_dma_alloc_direct(struct device *dev)
>  
>  bool arch_dma_free_direct(struct device *dev, dma_addr_t dma_handle)
>  {
> -	if (!dev->dma_ops_bypass)
> +	if (!dev->dma_ops_bypass || !dev->bus_dma_limit)
>  		return false;
>  
>  	return is_direct_handle(dev, dma_handle);
> -- 
>
> I am working on testing the patch in an LPAR with AMDGPU. I will update the
> results soon.

This should go up, as mentioned above.

-ritesh

