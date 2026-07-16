Return-Path: <linuxppc-dev+bounces-24320-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45719C4450A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2026 14:53:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1GHZ4Qk4z3bgK;
	Fri, 17 Jul 2026 00:52:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::82c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784213578;
	cv=none; b=Y8H1tnvh/2vGtuYuwVlsBeKnagVsOBDAztuY7ub8AA51DFJ4xcOA3Zw4AGnfr0Z1/URRuB3sqyuqaVQcLyilNCeUDoefF4Kv2alRO/vn+a/8ki1qD7JpkMAf9pq4DT1lxlTZyR9v1urvtYFdesWiTko2d25sOx1zGFc2lULPy3r/6vCLAl8KMknpWE77tqNEGnqotnZDgKqxXKe6EpuEhR3nqtcv3R/nhpc+4i5rxTpSiRfBQif7hbCnbREjmQ0ogKXEQF0LVEA96BXwFwhY5L48N+WCs/bR56Q5TRnJkH4NB6QYtgUw3JK/2KaRHR2RcH3rrKUZnmteRxqIhMdnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784213578; c=relaxed/relaxed;
	bh=M86Ir7wes1y7r8ERYu4z2fhecNCYpHaDZuovfA+lIDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMWCLynfGZKcLym2uYsJu25MX9UYKP2v+ICzgwKTOSobEBjtFB48ZdsFaCxkHIDRApoxN5NWN1fctUFf1oo9894Aoh2QAk0hM7VlIGtE7Ogl2Q9S0gL4ga3tbZowKQ1laiWliOHx7rYb0qorPW63SbnxvtWTQTdbhs4TibaT2JAYdfwGFKS0pbwFFxY3uF5J6DH90A9rNuPy8WVELD+9dMvJ8PUDqsWVflv2GdUDCjVKIFJ3JEc+EI6XuInYX8+2/zs/9YfsG6/cnqkD2vBFdhKFT0t/AaTujGS1D4hFDr27b1O4G1x66tG/FfC6UQrUAtNH5rSfJckbWqe5R9bSyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=MXtJlkef; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=MXtJlkef;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1GHX6B5Rz30FB
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2026 00:52:56 +1000 (AEST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-51c05dcdf49so72956921cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2026 07:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784213573; x=1784818373; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M86Ir7wes1y7r8ERYu4z2fhecNCYpHaDZuovfA+lIDI=;
        b=MXtJlkefhXIKSyk7eGMYJCwKXFi0uhXRqVagpC0Q2IBd1EwxjUyLCI3ARLU5hDhZw8
         G9mRcRr2mSLRWJGINRG/+Fdcm/LcwzsRTaQRrzt8uHobSwFijGCDOvF1prE/LFcgGaLE
         tDey7dgLUOmQ+lJM+i9oYBsQY5NrKUMVPB+Cxlvgc51rlY7AmFXW0azoKhuBkee1VIkf
         dTp2ggNxF8/tPIMgqWd1c+CpzZUNhUSGXwCtMdtWDrQw7SVmcSYQTAZRe5fJ8z/0rhX0
         aGlYjB2oXUfZv8+5Y4cjFfcsBvI7ptLXmZVSLVPYpNa67q1ByMA6B6wdb+ASItCBPscj
         xCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784213573; x=1784818373;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M86Ir7wes1y7r8ERYu4z2fhecNCYpHaDZuovfA+lIDI=;
        b=pUZuVTBCZOZvEVvYjVzsnsIA9UPXQdzm2VlBskrlGhC0PTgUDgcYwM9Uy4UVJNSeSW
         y0+pJjh85bIiPtXtNxVN7XS/PLASbjxGdBSkmQ+rORgqW/tCwT9m1XRdpgxDMUwdktGH
         GcLOBV240CVs/3A9pLaQ2TPaH2b2MBELQ6lcaZyu43ZKhHSuE+FE87Zt5RPM4kvurDaS
         3EvZq8ZGgZCfOYP0rbWMrTf0Xu2HjNNGAn3hGrmuNdVFr9zMZ55MAFHUBx0wr0LEvMZs
         BPjHR/X0vxkDz9ytiTOkhAZY0qdxLou8B7ZXbIEO9qb6a/zu2ii+Ev/YCx6HTtpeg2dC
         NxhQ==
X-Forwarded-Encrypted: i=1; AHgh+RqOCF4NHkVPYEDTyYMJTq6BH2rlpvauxajeCopPtBJYeFFuViO+rGfX7zve+fw+idDtpow287OxwSFH8U4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyra+KCt4xgiM2u7SFr4gHkIlfh7Z7lRa2u2pj3yTV+zqC98W1n
	4EzXykum0xHyTeXjGqmWgaE5zMU6hRzyV6hDNQEtqi3lJWVAZ9Z/tqb8+/yEYQpXGns=
X-Gm-Gg: AfdE7ckD9xC/xnnnbtSNQgUfgyM3P83r17UzfBf5NO3kt0ocns4OS6YVwjB3Q2fpR8H
	SrwKtugJN9kE9Z1ZIO6WHyVdeJ93QZy02cibQlNt8jX33kSk6AwOsZ2eNy863pFcQFmOSQjqfta
	MQb1fe1cXuCAbNOgjCYv/XaUNtaZCXoLUTEJKNtOBhobjaLEkHjgs8Ibkla3zJpq+bi6QV0mrTo
	B2ctGELTJrnQkp0bqX/NzO8AFfVa/sqB1a1DRv9PLcNns4ehT4HNwKB220a5kmdwprj8yZBe2Ov
	/751EhBk4FZvc8FdPqCNfd3LOmrJJaeJAa4WyMIBRB1tdEOya4WOfszzjzhFRTZMr+65LwBK2Rj
	HPnG/wIuQxATIcoDLlTOOAzce3ZX4fQGY7poJfP/0tz64CXUGNw==
X-Received: by 2002:a05:622a:1b88:b0:51c:1811:6eae with SMTP id d75a77b69052e-51e4f0a757dmr78823321cf.47.1784213572745;
        Thu, 16 Jul 2026 07:52:52 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51ec9fef211sm28849141cf.0.2026.07.16.07.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:52:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wkNSF-00000002ZDm-0DPq;
	Thu, 16 Jul 2026 11:52:51 -0300
Date: Thu, 16 Jul 2026 11:52:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
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
Subject: Re: [PATCH v7 16/22] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Message-ID: <20260716145251.GE210048@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
 <ak42F240d-53QeFN@arm.com>
 <yq5apl0xgy89.fsf@kernel.org>
 <9d83ec13-3b1e-4c1b-8bab-16ea057cfba0@amd.com>
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
In-Reply-To: <9d83ec13-3b1e-4c1b-8bab-16ea057cfba0@amd.com>

On Thu, Jul 16, 2026 at 11:55:20AM +1000, Alexey Kardashevskiy wrote:
> > > For AMD/SME, on host with memory encryption we now end up setting the C
> > > bit for DMA_ATTR_MMIO. This is fine for RAM but not sure whether
> > > some other MMIO bus understands this attribute. Maybe we should stick to
> > > something like __phys_to_dma() for the !CC_SHARED && MMIO path. Or,
> > > since this is not universally defined, just use the old dma_addr = phys
> > > if MMIO and ignore any unlikely DMA offsets.
> > > 
> > 
> > Considering for AMD/SME system an unencrypted dma addr is one without C
> > bit, will this be good?
> 
> Normally both encrypted and unencrypted DMA addresses do not have
> Cbit, with the only exception of "iommu=pt" (which is not the
> default afaik). And in this case, having Cbit in DMA handles only
> makes sense if p2p trafic goes via the root port (== IOMMU in
> passthrough mode, and I am not sure even about if the root port will
> convert this Cbit to T=1 MMIO in this mode) but if it goes via some
> PCI bridge - then Cbit won't mean encryption for sure. But I do not
> know much about p2p (never touched). But in any case
> force_dma_unencrypted() seems to make no sense here.

True p2p through a switch does not call the DMA API at all, it
directly stuffs the physical MMIO BAR address of the target into the
dma_addr_t - which won't have a C bit.

The DMA API is only involved if the p2p will transit through the root
port, so adding the C bit is correct.

AFAICT it is iommu=!pt that doesn't work at all since the AMD IOMMU
driver always does __sme_set() even for MMIO when forming the IOPTE,
which I guess is wrong for MMIO.

Jason

