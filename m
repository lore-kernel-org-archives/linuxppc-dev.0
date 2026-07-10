Return-Path: <linuxppc-dev+bounces-24016-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D396C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 16:19:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxcVg5X4sz2xlt;
	Sat, 11 Jul 2026 02:19:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f36"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783700395;
	cv=none; b=Zwu1P0gQA4q9YfsPcQoXPBBdOI7TXqCar9JcohU68qPXD09ZflgDA5AUKi8y6COf2yl8CtMxjiKSh7kUSNtK/zuL0Lx+PfoJJ/0irme/VImSlP4fJsHI38HSNQjnpYK0LqLYf3OdWp6IbRYqHKE0MfEtG7f0rigaPM8EnMfUhkacuX+FVVUDDtdNkAuDjizytBctDXka3cyum43NMsApX+a4UWvyify+cMKiqY86U1D6J4oAWx+082n9GzaGvEqumvnhDedVwPCYcJreZHrz+Hlp7aEHkeafKsAc9eIFZJ9Mgp1fo1HEAoT6ZXJvU1Y2DT3HPN4r/ac41RXOP08u7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783700395; c=relaxed/relaxed;
	bh=wu7pGf03sdcW+GKZ7Iww7/tPEwPDkL98YpGrOpuCsUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niKP5hJCE9DsN2yYfiHt6heLeLJ7ifXHkaWA5WrlHyMMMs8Jh/coxQ+6ijOzslTq1FAqk6XuHoJamOPb9WsU2H3HAMjloujuYf5OaWZc/ZojormKcltaG1NoTxtqWO8vPuNmCWq9CA0ZGjjoFgmkmfVlAeqWcvQl8hy2aXmfLQjGQ/T36QnE9ON1LhfrD0X9ail5ZxnvXWeWnrQAVxxvC2ljNf2BhXDDRTLJ7cOMmlGyRJ9UgH3428NRPMYUbCX6j0gFWcOWrT3TSDVxllnE0i+zXc00Mbf6fdr27RJ5C6ek5l5gRmuC0RbCGHVs5iIhNmmlCbxVnuYT2uUa2Frfaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=nbbKrYVc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f36; helo=mail-qv1-xf36.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=nbbKrYVc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::f36; helo=mail-qv1-xf36.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxcVd19j9z2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2026 02:19:52 +1000 (AEST)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-8eeb4508f29so8876346d6.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 09:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783700388; x=1784305188; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wu7pGf03sdcW+GKZ7Iww7/tPEwPDkL98YpGrOpuCsUc=;
        b=nbbKrYVc7wbwzBXVJv2Fc+8o2rPdjWFz+zgo2SFXOgq0qJj01WWfFOVgokzTYn6OO7
         IzMPJ3nX+EbfX+axGn7DwDSz+Udx0olfIDqk+aSuaENhlzeLcSh7WQUryvMeTxG2x9EL
         lGqggHrNPtOjdts2+KuTT+IdPvp0YV6/OsqU9vd9UT+rOr52lE9WvIxcfyWEjOH899Ch
         4L6h1boysGyxdbl0DL5S1HBlwuZd66AiBCTTt9kwJtsrnhjl6Zgt2xAMDJjM+LPNN9aE
         AeAiygYfzRPg8lGRLp6uGroIbseJfK5670ktDl1f2Ok6iL+x5KcFX6qrgXu1jr79tuTP
         YNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783700388; x=1784305188;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wu7pGf03sdcW+GKZ7Iww7/tPEwPDkL98YpGrOpuCsUc=;
        b=mbq7XV+8NzMgW3RD0ihLlz2DMXN+DrMeavbh47ocwVEZtLOc8fR2Xj3xxx+k5HNysi
         gGXRVs2YkTOOJkyvp/aDR9fxazqVg/pm6BZS6arXevufi0urM5v7z25NpeptGamJPTWz
         dCEuCb0LinPZbvuMR7gqSj+w98wkjYaNG7gRR+CGxEvFyT1fAIDVC8n3iB7g083Cq2rE
         FU32rZh5/JwsjwFbKoeTy7y9klo4qCO7IP36z6p28UOvIo6HIpFVXGO9CwqVxr8XqdQG
         b9K3ct5WlGLcieB8IryXRBrD87ns/zfEz9vlZ63bLDZoKxz9n8FFCzxuy7NBIo7lCV3l
         C2Vg==
X-Forwarded-Encrypted: i=1; AHgh+RpL4TK0oskfpPV3OHmXXTQ3soa5fAtFnhtS1uOZsexCtrKeUAnm2ycRFsdaViTDKrRf3YsN0c4f9/ZILHs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwOQPDUs0+zv616V1UZ9ajrunQcDdSRMrzXGjhi+lITFaJxfh1U
	tmy9Gxjt4FNY5ZpoE1SjzMAkfjaYV/zwOGryfExj/VB3LNmneLNnCc9ZN5nZUeRg9E4=
X-Gm-Gg: AfdE7cnx2E3G9YKXgN1eeFgybjTmKXofsnJYo/Hs3eLIxTILWjERlbTlgY5OiCj6mXd
	ZrIqw+op6ZMiLTgT5qqknmCz7qF4k0T+Qky1we4uwNSG59l2sbUjIYUjbnPT18GKUvOrep+FAbo
	Sf82r0RwTYnOU7nfwmavoBmsmDUEVn8qWBKudq5PpOsPzBG62Xd+dc3xEb8ISvHvacCNNtG0/Og
	ubkvq0lpmmHn8jUOmA/t9sj3CvBze5mJo680il9v8apNw/2fZDVUc8vEhjUvs4DDLxHCB5Vx9Y3
	6SpQ3p/cnz9R/GevINZ1Yikdx9yatKgeqmYWYHO3jbtHgL/Y4zC/1HMvmiFTYpCIytERPIDsoKb
	MF/ohiwTgP46u6xc16YsyEaAp2IS+oRuZNOSIresd6CkqYjLk8nffRIWRFjwj
X-Received: by 2002:ad4:5743:0:b0:8f4:870f:72bc with SMTP id 6a1803df08f44-8fec3cf5d44mr142091486d6.51.1783700387612;
        Fri, 10 Jul 2026 09:19:47 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56bf455sm44263206d6.13.2026.07.10.09.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:19:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wiDx3-00000007We8-41pt;
	Fri, 10 Jul 2026 13:19:45 -0300
Date: Fri, 10 Jul 2026 13:19:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
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
Subject: Re: [PATCH v7 16/22] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Message-ID: <20260710161945.GO118978@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
 <ak42F240d-53QeFN@arm.com>
 <yq5apl0xgy89.fsf@kernel.org>
 <ak-CT3oanlDfgTy4@arm.com>
 <20260709181336.GM118978@ziepe.ca>
 <yq5ajyr3h106.fsf@kernel.org>
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
In-Reply-To: <yq5ajyr3h106.fsf@kernel.org>

On Fri, Jul 10, 2026 at 10:52:49AM +0530, Aneesh Kumar K.V wrote:
> >> > 	/*
> >> > 	 * For host memory encryption and device requiring unencrypted DMA,
> >> > 	 * MMIO memory is treated as shared by default.
> >> > 	 */
> >> > 	if (attrs & DMA_ATTR_MMIO) {
> >> > 		if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) || force_dma_unencrypted(dev))
> >> > 			attrs |= DMA_ATTR_CC_SHARED;
> >> > 	}
> >> 
> >> Yes, I think it does the trick, preserves the current semantics for AMD.
> >> I guess you could use a single 'if' for all checks (up to you).
> >
> > Please don't change it, MMIO P2P is broken on CC systems today and it
> > should stay broken. Passing DMA_ATTR_MMIO with DMA_ATTR_CC_SHARED is
> > an error that we need to correct in the drivers not make work in the
> > core code.
> >
> 
> But the above changes are intended to handle HOST_MEM_ENCRYPT. In v7, we
> had the following diff:

To follow how the rest of the decrypted/encrypted stuff works the MMIO
has to be flaged with CC_SHARED for HOST_MEM_ENCRYPT too, just like
the PTEs.

> @@ -88,37 +88,40 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>  {
>  	dma_addr_t dma_addr;
>  
> +	/*
> +	 * For a device requiring unencrypted DMA, MMIO memory is treated
> +	 * as shared by default.
> +	 */
> +	if (force_dma_unencrypted(dev) && (attrs & DMA_ATTR_MMIO))
> +		attrs |= DMA_ATTR_CC_SHARED;

force_dma_unencrypted() says nothing about the properties of the
address passed in, this was nonsense :\

> As we discussed [1], that can come in a later patch. In the meantime, adding
> the HOST_MEM_ENCRYPT check preserves the previous behavior for SME.

It never worked. When we added ATTR_MMIO it started to have a chance
to work but prior to that it was always broken anyhow. I don't see
there is much merit in preserving the narrow window when we
inadvertantly had a half working ATTR_MMIO.

But if you really want to it should be
cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) *only* and get rid of the wrong
force_dma_unencrypted().

But IMHO, I'd rather this series treat ATTR_MMIO as private MMIO and
ATTR_MMIO|CC_SHARED as shared MMIO and that's the right and correct
thing for the DMA API.

Jason

