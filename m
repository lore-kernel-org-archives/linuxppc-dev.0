Return-Path: <linuxppc-dev+bounces-25419-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5415CC55174
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 09:10:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFPl733d7z2y8c;
	Wed, 05 Aug 2026 19:10:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785921027;
	cv=none; b=DbDE5Cw2XrkS9ZaVB95LE7nLdV1ZfDrsHHkQgfNqa2053RxFoMCaHk+9GkrHT/DrS0656PKMl5mYCRfFypVqbW/as7lOGpPD83YXXWw/HQBNFVe9gYvNbCZ2xOerAH4g0zMuLh2aQGsVZhkuruz0fSH73+pIQ5lTKJ14lsmBC5meJnCaZZt1lVoevvmNAu57QWmIv7z6vCBH/oCQY3Qosp/CZyQ+tStPWaSd0+rjiD7rd7toe7q4RctMLrhzAOTAQQKYZYgInIesRrzO6pDfqoVnzkQ8dkM1RsS5Ft6nmi91gpE3wRAoyCkAxEQVemMJY5NgbAmBVGzsttX6dCqeAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785921027; c=relaxed/relaxed;
	bh=Gc5m4+tIBvg0egjJhph4T+RN5CfIOJByD9/EsS70PrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrlcxdpeobFUrG6I5hTsKSBzGrBhMNfSZndZSW9/EtsvW2rFqQkEbt3HfoU8ACbWV5PEwWpWCj4f0nakL7Fc28hsX5iIzQaxH/B+utNZHgl1C3WA6FPWhwuQI+4Hw+SSUt+IMUt4gsZfhYm8AQJL6QfeZs30lIUYve/X3CTo83ctAzXJu3tnyGf1Pd4S9mtMuh93wd3vjWSLIjsEyxHeTQp0nyaS6f6gIIwD2Z4BaIKYK70SOBeAqvTgkTWreO+kzIVIsNrhvD3N/j8W1YY0M5RddZ8QEf/K5fI4oWkB3uWwWxHq4rpcKSjwl8CfAcX/j0eP+9j/icXCiy9x21Dl+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=WUiv5gTn; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=WUiv5gTn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFPl55qrdz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 19:10:25 +1000 (AEST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4954d5d814fso46325e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 02:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785921022; x=1786525822; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gc5m4+tIBvg0egjJhph4T+RN5CfIOJByD9/EsS70PrM=;
        b=WUiv5gTnkfjTA94JOWFcf4heMPcy2QL3avCBc9Mm8i2qm2OTlAf3HD2z82H4KOGttk
         rvsZMQAciPT8C4SCA+2fkZtZEdi7xdWXamWlapTdKfhNyFlEGBkekIXZDaHrDmM22anD
         7UVMbCghn69RSbyOxmc3H3w8zjbUa4mg6GVVPzmS4HoiS+u1+OwZfJBCQq4YwzK5rbDE
         ZkiPCamSxmzJtO3JaDpOSCVM9kltLYpl6Cr4Sf7b1Jom8ThcxZ7VcFvIroGDvwkCypzR
         CrqTq6DYLbV1a52fns1hwPX/R6LkoaAFXRMCvbZq87ZWVDi2+4y1YgoZ+V1J0Cy1+GGn
         i+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785921022; x=1786525822;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gc5m4+tIBvg0egjJhph4T+RN5CfIOJByD9/EsS70PrM=;
        b=m7EMmtzMqK+8GGFc1OjPDBhaqC4KWqrTggHpWPBualk6Xrfy4kzblCA6EK/Fi5AuuD
         /GstP4ozplAXC3SlUZb+OEu2uStazqt+RIQl48r8em5hufj7e9AIjvUrgISQxgAwcwsd
         RXZk+0xjvd24HSSUfVe3Z0xBajPdWowzgjfnBAeHIkjdpgmsA2l0LD8xySrWB01WCsb9
         ueFT/9cHmc11rIyos5Rv9YPD0P3jkZFajZEBRI0+BDiGNIq6o4uy8ScrY8dNxgAG7ErH
         iJLmgD9xMAMgaAGmDdtH8+jS0USEmdEXfJtUt3COB4Pb83//Eixv6Kn9J5YqoA69LJgo
         wXjg==
X-Forwarded-Encrypted: i=1; AHgh+RprpP+kfjsyWeJdWwOquavivTmNsPFnsCHHTon1hi/u7XjXiRel1XvUxXj1beX7N4vIYoMqNzAaGnSkFXs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy22jpaKO/Ns1EjlcUUCOS1E8avNQDtiANt0Ndgq4bxn1AFojR+
	MHpmMq71mxQvNo5f4Et4rmXSmajD4073G0OphjJo5J8IkElNVE+tRkA9TT5EwiKNCQ==
X-Gm-Gg: AR+sD12pPVRVMr5p7HWjD/N+sY9ggUzf8X3xKztCpy3RjxBdIlhxWeCXUlK3kwrn7RE
	aYf4UnvMFky8rzhtTjXjt8hHv3ehSKbtzEyfshgDLamNOgETsMu+hHhnK2+GtValnlU6af8GQgA
	/lr8eYgqxboqUcAAPvrvtGp7xo/D+ystJBouWd5AAe80GTEKigwkoQ4ev5QAalfy6JZ+P7Pj9sJ
	Ng9MyVDDp5qYPsF9e/jMa2vKgRmoidaLwh6wh5bCF1uS6vBcSnPHYgOrVPMZeZMTqzB/QbtXnvE
	wjfrH63t88eGgmdewLDER8UXFXXxAvKRCV8ihGYE5oaW02Pl8ThiX66K8soi84xJIYDCNPC4N95
	7m8WDDTtoCcgEuPFNtc3wbEfmlGM2YamEzEwSV09f0AQbPv0zg/XfQ66ZggkKRvarXwNNjDkaI+
	/UbmZmin3YjdA5NRpJSNiaAe3E94F5OZNoxAm0GZdQx9f3Znql9tcbh76jRmPxl/n7d0+O1YIGc
	6x+oMYWqqCaSgHpgWp17J/fW4TDTw==
X-Received: by 2002:a05:600c:630f:b0:495:4069:b0de with SMTP id 5b1f17b1804b1-4994f123620mr696915e9.9.1785921021836;
        Wed, 05 Aug 2026 02:10:21 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994dfda45asm92632815e9.4.2026.08.05.02.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 02:10:20 -0700 (PDT)
Date: Wed, 5 Aug 2026 09:10:16 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 12/23] dma: swiotlb: pass mapping attributes by
 reference
Message-ID: <anL9-OrDGqYQAWNV@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-13-aneesh.kumar@kernel.org>
 <ami_mpd_1pF4Tmdu@google.com>
 <yq5a5x1ygo7z.fsf@kernel.org>
 <amnRB98ZZIysHuM3@google.com>
 <yq5acxw6dl1d.fsf@kernel.org>
 <20260804142032.GC27883@nvidia.com>
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
In-Reply-To: <20260804142032.GC27883@nvidia.com>

On Tue, Aug 04, 2026 at 11:20:32AM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 29, 2026 at 06:12:38PM +0530, Aneesh Kumar K.V wrote:
> > There is a possibility that we may support io_tlb_mem with cc_shared =
> > false in the future. As a result, only swiotlb_map() knows which type of
> > bounce buffer was used, making it the only place where the attributes
> > can be updated correctly.
> 
> Yeah, +1, the attribute should be changed at the same effective place
> the source memory is changed away from what the DMA API user
> provided. Only the thing providing the new memory (eg swiotlb) should
> know its properties.

I will keep the conversation here instead of 2 threads.

That seems like a big leap, I'd be worried about devices that operate
on confidential data that should not be shared/decrypted.

One example for this which exists in pKVM (this part is not
upstream yet) is non coherent devices that require bouncing but they
still want to keep the data private. In that case ideally they get
an encrypted SWIOTLB pool, but it's always better to fail than to use
a decrypted pool behind it's back.

I have not been following the work on T=1/T=0 devices, but IIRC, they
required some complexity to handle their stage-2 as these modes will
be emulated differently (for CCA, RMM vs untrusted host).
I was thinking that it might be easier to represent those to the
guest kernel as 2 separate devices (bounded to different groups...)
where one is trusted and the other is not, and that way the DMA-API
can have strict rules about memory sharing.

Otherwise, SWIOTLB does not seem like the right place to me, as it
does not understand the context the device is operating in, and the
DMA-API should deduce that from the flags passed.

Thanks,
Mostafa

> 
> Jason

