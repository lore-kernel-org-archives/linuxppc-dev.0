Return-Path: <linuxppc-dev+bounces-24139-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8FFC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 19:28:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzXXb6Gw8z2y1F;
	Tue, 14 Jul 2026 05:28:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::72c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783970895;
	cv=none; b=W6aHx08xSZPqyg1VlvFqXZhGGT129UhS9N6ET5XHDTkTwO+zvDbkF7WaQRSKjvbm9ANGxRKX+PCKnlcR0tSA0WRZLHa0aXFghxMU3tqDXUIp00VQ0cyZ2Fgv01WMLcmHfk4FaQYZgtWaqc4rQsG5RXdeBWULH96YnPBI+kBETIgbqQknkNX5uFJ+3JjGGQnnGLjtY0/DA3WA3GYsl5XTApX1z6YFRFwqIF/4sMirWbYBzkGaY6bRfcCeoNfM5J6zwGSiO/m6HTom0cFqY7MDsslnIezmjB6rx+Yp9uXMRLWv9GTMSY/DOc9YqHNioBO97lsDzqycRcZLTM/TMj076A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783970895; c=relaxed/relaxed;
	bh=bN9JaggjBtthcoIhUPMeMbFxrz5q2FPyWPTtAmvW2io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+P73rK4QMauaksP4B6DQp/s8UW0Ubst3UuInTxMvEcfSNyIGfU1gdqiX/a0bD9SnMnvZ8AEqqdoQ9e2sqCS3HTCC9dIULImstn3w9lfO3VKYJ52vnXhvmQZ5n7W7KmHVxtKaNogoxfcsOa4kYAlXt6S8z9X65FZ+Rm1mTkPJsYfF+FHbFM0ERMgDcN87DN4mud+Yhz0EByOw7W9cnNLbYpcWDy5gmMc2qZcuotUYRb/gI11S1xBpvd/CJDjUfo8roEYfE+DgsaiGjYCE66l56UYMUb42O5IUJpAw69D93RnC0zv3+LmLYiHt0/Q7lHFlt/32VZQdsV5lz4j3dArfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=VRF4nRmF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72c; helo=mail-qk1-x72c.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=VRF4nRmF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::72c; helo=mail-qk1-x72c.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzXXZ5Rxtz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 05:28:14 +1000 (AEST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-92e55b62640so205383785a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 12:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783970892; x=1784575692; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bN9JaggjBtthcoIhUPMeMbFxrz5q2FPyWPTtAmvW2io=;
        b=VRF4nRmFpNzsDyVKJXBcNIXMHwDITFNCzLHU9R++3Icg69GnyRmZgcxjdqLcMXA/IN
         R7+YDgAnSz4bLXRV2sGyZZqJDuioAqJ5gCesvVzUud1hDAKPxgKkg3Y4lsYxibFsTZom
         4BtdLlaZ/h+AdWs+cwgokOhHEavfuXlH+8r/Eql1M//5BzZrH4Di7eNvW/4yB8Ytjydj
         jYxyQ6LeJa3M639KkspXwMKjTl+Y9oZnAwiRyiM7vsYdOiknhRfV8BiMksHqW6nyCKJF
         Pk0BUosJceQKhjwEwtRbqOZMq7Tv9KC2AAI0B8nEBGqT/vUbAbqPrTPaaZKgS+heQhfW
         GvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783970892; x=1784575692;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bN9JaggjBtthcoIhUPMeMbFxrz5q2FPyWPTtAmvW2io=;
        b=nEWqo611IMij1If7l0IPxHt2qil2AOeX75MTZjPwyyddsTN8m6bZtR+EZLXW8xTRLC
         Fbeit1Fy6U0F+N1u8SNdbXTrmXKSru2H0v4HA+HYPxDYBWPHPGlg+7zz/L+7A0jRSxNP
         X1zxVufYAdZY9PPK3Cwbegd9enyI2bGqX59rxcdcGs/p5OELbcATjZ/ucMqQa7IG/jR0
         jlCUysJNh3v8+fIYWoHqTj2x+Uaxlbm/LDp3pQSLaHw3TxuDXqmnRauDdxVRFhWwbIjx
         saFoMlUtK+z34Uz6O1W2EHDLn7al2aadnNaCafdTMeieAYEgGbOsh6uNO3DopvabZe5y
         RINQ==
X-Forwarded-Encrypted: i=1; AHgh+RpJ+TwI44Yo0w6imm0trm0wNkwZPirfT693TOPro8C8Furm43VH4MeRJuFt5vQKSbFfF/XsvHR6oINwzjA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzeOmffmPpTT7qmxeNuGhkMHuSU0YC3FENy2EmvIq9A8rHe1gW/
	80qhACOTYQg9XMVvI8NM5QFntg5ZCeehqfa9GpTJ8V3DxbH4ikRpaP3pG/84FX+MNq0=
X-Gm-Gg: AfdE7ckF7pymxYgE5xlTAwDFTEFnN6teQ9su2v2TEf5j4b9dlIIc4AjjSCnUhXjAqXP
	g9m2ZUPqs3q5CFUYPFhzNTDX5f5jab5A2L4YIrlR2nInkqZidX8vl8SF/41XLHWAkGFr8Y8jrj9
	t3c02ArAzzYFNXisUinlrWDm1uQgLvqiEWliZ25TfVCFAf+dGIN7nmlZeqH3Dag70jBdFO/41te
	zyN2LB9DfFZQO5pdvQiaXKBP6eC30W7sQRIT1ZL9Ogel4DYwX+7qsY2Z6MXsHxVx43LTlK19M1w
	Q7nu7ZVjqLPSfJZD5hqtyKfOxneVObp8itlxzaiqVBhQwi8g26qYFh1phoMI/1Z9txVmJHa1y+x
	3CiJrA4c9jEInad3WPX4OVr4ZYvZsFGqLW3/D8LBy8fXl/Q3jdYp+ERTce+98ppxuSsEBDts=
X-Received: by 2002:a05:620a:2616:b0:92e:4a4a:4478 with SMTP id af79cd13be357-92ef2b55ebbmr1041396385a.31.1783970891864;
        Mon, 13 Jul 2026 12:28:11 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd5bbac2asm137804776d6.21.2026.07.13.12.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:28:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMK0-0000000E5Zr-4AHb;
	Mon, 13 Jul 2026 16:28:09 -0300
Date: Mon, 13 Jul 2026 16:28:08 -0300
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
Subject: Re: [PATCH v7 15/22] dma-direct: pass attrs to dma_capable() for
 DMA_ATTR_CC_SHARED checks
Message-ID: <20260713192808.GU3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-16-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260701054926.825925-16-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:19AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Teach dma_capable() about DMA_ATTR_CC_SHARED so the capability
> check can reject encrypted DMA addresses for devices that require
> unencrypted/shared DMA.
> 
> Also propagate DMA_ATTR_CC_SHARED in swiotlb_map() when the selected
> SWIOTLB pool is decrypted so the capability check sees the correct DMA
> address attribute.
> 
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  arch/x86/kernel/amd_gart_64.c | 30 ++++++++++++++++--------------
>  drivers/xen/swiotlb-xen.c     |  6 +++---
>  include/linux/dma-direct.h    | 10 +++++++++-
>  kernel/dma/direct.h           |  6 +++---
>  kernel/dma/swiotlb.c          |  2 +-
>  5 files changed, 32 insertions(+), 22 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

