Return-Path: <linuxppc-dev+bounces-24133-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A97C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 19:12:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzXB5329jz2xRw;
	Tue, 14 Jul 2026 05:12:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::829"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783969933;
	cv=none; b=KTxPS5fOx7OAFyMK3kpY3gREbbdWjehhn/Eb84b7Uy83XTNGayX7DxfL62Yrvrnb0KxrkHj1H3dG5JmEPOyXaxRY3CT2PdMhIXDwZalr2ps1j5lNKIx1j34HC02jGvEN+frJ9H+xV5V4ymj/KK0FFoZNGdatr5xH9kc0tERtlK9jd6g/xHOlFtyYylundrJaGUju8ioVWiWZAJFqe4leivxxhveToUtwB/lrJebWJuZOVvb16S0mxhzk2g9xlRcdLlbIXGiooCgSOTSwAWkVqf3fAMBH6T27JT/ArD6/byKkZgfIZOLAzWAqP1Or57g28gW48gMKnX5abQtMTdh/YA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783969933; c=relaxed/relaxed;
	bh=/NxveP/pyfIFv71kVfPTlg3b5XZeJTUOET5rnvr6kHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0ieIPU599p6+raiTFBWbPWzH+HjW1kr3DvYjZwu+C+Vf0XVZ3cb6hc5a5wDkE6lHgMEHmU3IlhswWqPTf5IF/4/h0dVjl1VSJXEMw4NOcgmeBmKohdwK8HBMlkHmL++E31Kior2xjmCGPmS497I2Vc1fiETfRX5jRWgQhCcvxaSH7itIB75+P7KQsUUlXKLURT8lRN0Hn2xnH0rlg7FTJIswX5BFdclulN28S2LZsqsTDDuWgLUUDAv3CebtkdVGVH7btq1A26eQ7oc8hR5yb/V3r5NKuhT6/cgepBtORbVCS4Ll/gC/HPcAlz570wrchniWHwGM0T1zHMRs7RD+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=YnwyencM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::829; helo=mail-qt1-x829.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=YnwyencM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::829; helo=mail-qt1-x829.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzXB41LyZz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 05:12:11 +1000 (AEST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-51c16ac21acso1497371cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 12:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783969929; x=1784574729; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/NxveP/pyfIFv71kVfPTlg3b5XZeJTUOET5rnvr6kHo=;
        b=YnwyencMdK4cif1M1uyeWY55McQaFV+4IQtNKSouLs85HknckAXblXNWL4LHz4mUql
         3vtiyEtRsgMFGYjr1xbAL9xnL5m6AZB8+W7M8jnG5BEL/9iJsclBjfHR2sSAv/A1XHax
         CtnWI6Zub9/T6MIY+7iIol1cQZttlvOxirSwLkttX0x4nGOtH5+IVhVVo2Z1sd6Le/6C
         CcahahKAbO1iMeh3nEo5TXCvDN2CAYPKH8OBk5wp/5ro2A84sPLVJ8m03Fa9etDkZTg0
         n0JwxkAgvSwZg7m+Gm1t4GcTgftAcn2Ug5dZ2yk4+DeqKvyrJ1MciO1mURgg/PvA5XdB
         bqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783969929; x=1784574729;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/NxveP/pyfIFv71kVfPTlg3b5XZeJTUOET5rnvr6kHo=;
        b=Ov5WqyeEAT4uANt0jIwPhHKvwjqES08Z+OV1CYFeNq1S/NtAgeXvoRJxyCU5FwEnAZ
         Bylf/q3NM/6PftvnsvKqxXxQ791tFwiOSRusTi1BGk2N9waDrjx5Ul117yujyGfE8SUA
         aL9Nb+mUGBIbb4SgHdiREEa2BawV9IYm9ciMjjYz/krj+rC/xMjv8lK18507MKfgEyUy
         B4GP5Rn4uYMabcx0myDd1wwUZjwWsNwxlH55utAq1kLSW4erF820W0h8ItCdaawu3P9B
         Qg4Z96eRxGa9A8OStKQIqp3q4nWd9j4/AD8MitAzfQjopF42mdBr6ZLw2YSx2MJe91M2
         tH/A==
X-Forwarded-Encrypted: i=1; AHgh+Rp79RiHA3Xfju3SdOO+B6lXcxK2UcMp8k8/1PVe02/3MGtJCI9cdsAsXbyAA2YNrWAdFrr4okeQlHwq8xY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxRKDl+no2pdUNTXOXYOyjfNEJVE7j8HV26CBod0QathwMPPFB2
	nKsjcURfjaY/8LkrH8yhZnRs4iAGTc+tLqO9HGJlrkt9bLWTLP8I0d4cJiA7W2oWovY=
X-Gm-Gg: AfdE7ckDL9OI2dwHhTEoRXkA7nSbS6j+6i84aRsfcSJdfzZHlu4RqSE8NpFdszzjkjG
	wsesc7dOukkT06QLVDeeROykSzN0KKhdKSM3EAWwmb/qdYSFesbtXbCN7jf95OJBgpd5TWY/teO
	2opRsuF409thnd749GfSMPIN5COjqeMGxwSBgygyEdMY48vfYWn8B44wFsxERWTqComawAdBGlW
	xYENmYt9ALOoGrQoTnj1TsY8jpjFvv7ZItzJH+0QfsSV+RMLe+EHvlsXY8qpTwccAy0L8XBQZQj
	JcX8JKHmK5coccFSVndFKybg9Hrhc+BkCTVk/fXxUGIlLXiAW5uaxjXLduxAEYt/Fcn0EOGCXNE
	iZn2t+8ehgUfokglfOyA73P0ZkIrNkQlvIJNmYbyKd5DxExi17Rd2d5F1nQez
X-Received: by 2002:a05:622a:551a:b0:51b:f217:539f with SMTP id d75a77b69052e-51cbf0569bbmr98856591cf.17.1783969928867;
        Mon, 13 Jul 2026 12:12:08 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caacad30asm88764001cf.9.2026.07.13.12.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:12:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjM4V-0000000E4Bs-31V7;
	Mon, 13 Jul 2026 16:12:07 -0300
Date: Mon, 13 Jul 2026 16:12:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
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
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 07/22] dma-direct: swiotlb: handle swiotlb alloc/free
 outside __dma_direct_alloc_pages
Message-ID: <20260713191207.GO3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-8-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260701054926.825925-8-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:11AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Move swiotlb allocation out of __dma_direct_alloc_pages() and handle it in
> dma_direct_alloc() / dma_direct_alloc_pages().
> 
> This is needed for follow-up changes that simplify the handling of
> memory encryption/decryption based on the DMA attribute flags.
> 
> swiotlb backing pages are already mapped decrypted by
> swiotlb_update_mem_attributes() and rmem_swiotlb_device_init(), so
> dma-direct should not call dma_set_decrypted() on allocation nor
> dma_set_encrypted() on free for swiotlb-backed memory.
> 
> Update alloc/free paths to detect swiotlb-backed pages and skip
> encrypt/decrypt transitions for those paths. Keep the existing highmem
> rejection in dma_direct_alloc_pages() for swiotlb allocations.
> 
> Only for "restricted-dma-pool", we currently set `for_alloc = true`, while
> rmem_swiotlb_device_init() decrypts the whole pool up front. This pool is
> typically used together with "shared-dma-pool", where the shared region is
> accessed after remap/ioremap and the returned address is suitable for
> decrypted memory access. So existing code paths remain valid.
> 
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  include/linux/swiotlb.h |  6 ++++
>  kernel/dma/direct.c     | 71 ++++++++++++++++++++++++++++++-----------
>  kernel/dma/swiotlb.c    |  6 ++++
>  3 files changed, 65 insertions(+), 18 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

