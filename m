Return-Path: <linuxppc-dev+bounces-21164-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9161DCD4F5B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 14:28:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKcTg1wLVz2yL8;
	Wed, 20 May 2026 00:28:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::829"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779200887;
	cv=none; b=jtbJa3+LmdSp/U6q3+9OpSPrKwH/5Xl8Us1iwaTG5M7TmND9GHHBfjymdTalekesoZTuGoZk5IwD88fq/QxZ8HXA99W2F5KuY4WF5xzCRTSYimsFw/u+bB1PBWN7dcIWmUAQm+oCL3JXF36iriSMsf6esBvYy9g+sr5bJnSjw3hf8L6bEixn0G+iHhwJ1wiFMOXReL+72Z5w9IBVzjOskWbEbRAfy3Oqnah5DUQHJFPOa7d1S/b8zylDKQxpYNXaL2sJBqshhQIgJrO7AnRPmKR+BorxR7oqr5bL//m7jF0zFoTsVPiigPZBQutqB3cbXGbq4ye3fkLH+eVhQF3qxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779200887; c=relaxed/relaxed;
	bh=FTIuQdBXtpQH67pVdVz1Fjrx/oRpQ8R86tVZsSSuQBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXDaTU/qFOgptGdMH4kSHIsfgvecgkAftNkgtJQOO4aAqG9K3slBxzBSb81kQMQWMmAD084hCZGdcKiQ7myhdIutPzBJM9UyGwkKrzX/8crziL19XRPjuQ/Co6AGgpZRzz9GDJtWQZ8K7A6vP78ZgH55r+9h1ejU893rfjeBAMSvIv4/LzVheaHYjXUL02ApDsi+1I+COtWtFFRgFraeBbPIRTEfymuYCFQU+dJnXW+jWv+3KZIiwZ2cjnP+Q1zlVq0FPIRg1DOEKWnXRth4hXUoPkMDP4Xs4vsrF7yiJRahIF1z3DZlN8eEN4lBHeeSZe3zGserAdfy+2jnJG0Lew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ASqfTKOm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::829; helo=mail-qt1-x829.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ASqfTKOm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::829; helo=mail-qt1-x829.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKcTf1vksz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 00:28:05 +1000 (AEST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-50d864c23bdso1051cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 07:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779200883; x=1779805683; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FTIuQdBXtpQH67pVdVz1Fjrx/oRpQ8R86tVZsSSuQBc=;
        b=ASqfTKOmLxRZUUcdg/K9tmDVBfp58JN37v5qr+RC/THukKT9Ah1H86EeJ83bUX7R3U
         PG7BSdGNTvaYrWdzP6LLcCtv2ekvbwgqSRIDtb/XSnPQlg/C7vL+m4BiwMhwozjAyhmY
         OR0EK5KDJbv/EYidx8f6o04Lse0AIZonrKDkIO5L14gGHGPazeSiZR8z+V125hD2RwFV
         3OCtFD4QglsQdlIlUgZu4KuooVHwxXJfvhk9CanFLzQoAN0BZB24U5DpG6mzTXY/EobB
         rSWUyLrMWh65kBQlNFg8RRGGBkw2ylf1CxJSlJU/YGyO9FLGItJM1EYHdOtT6MGfH0Uk
         StFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779200883; x=1779805683;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTIuQdBXtpQH67pVdVz1Fjrx/oRpQ8R86tVZsSSuQBc=;
        b=sLeXPMvOV7dNyEX6WBv8wBtq4XmLxjowwU9sKD4iq6pc0qPNo3TNKN3JxSgR/ddsVw
         CvtSev8TFN+sMKUOEdGJS04Cik6dgYpLBL5z2RQsA/ZXeGRxphCk/xlyF17tHrzGwlDV
         i3Gup/uekpjI3L+zpbt/t4ZxOM2RIMFgaFp/jAY6NyRl/n/10I6pOU87G3X+VqkscCb4
         by4DyqA9SsjrVS1OpVcumx2ddKAKR6CL5SFEaE5JjiA2Z17dveqt1Fdo7He2fBErzEId
         S+VhYexbtIWsZgOZ2t0HIlWBJK6Y/+M7BGB8I0X+TRCcJE29NNdTRSuXUCs1/bL0CJa+
         AC0g==
X-Forwarded-Encrypted: i=1; AFNElJ+GYIU8ZEuDxJDgucOyIk1pAJWaNZe6LrpY6Jd9j8yO3E01H3615ucnaumeuanGitcXBOi/239DeIUiQtU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxWjgJe8cect+hbuMvtN/4PllIlDWnacRKv7g+yDLX2vSVPer89
	ckGASsUgX57pkhbwilZaF/zCnxr+cJPiilfnrxnTnIggje865dYic7K2wueOWZ9YZA==
X-Gm-Gg: Acq92OEYgXMykN85Q5VADXX3cp9muVF6Ey6k9a/e1wwmlDXpt0nPO+ncwbwbdocHWaX
	PQnfG9EwyGzwe/A9kKivHY217fsoAVb1BA5HqY0sLS+bcrd/JzZ1my8gUZCQP5sqKtJPsc451Lb
	tCriWDBCtjb6eRzWIUOQGf+NWdxOTuWKdMGjuwKwH0wlLLS3dEpbqgxj3SMgGPAhlMcmXr9dWPk
	DmOtb4dSezCb7rQgEZWM/8QvscY39NQl7Dgpx/6eomSq5s9+L/UtIgbIoF9uKXzrTvrrw0d0qpM
	3i6eYmwl0cIG7+jVJYYFo17Ju8c/Wdf6ZUcT49qCzbtWLsTyg7adSLxHzBSon+ZZMda1xQC3IHM
	SB9Kaw+U+4UQ/MYGlvgL72Jj9AQQV+0OwIu87uPjNHIK7i+hXX2omzqJ7bu89lK1JsMQPD/vqzB
	QiAdt0v28D5P2e69egFAOlX6VWOy88U/e/NMu5NQQI7IDRDRjliIJpdnhTWEJR3hsYcovdKA4MR
	4rY
X-Received: by 2002:ac8:5cd0:0:b0:516:4f62:85ee with SMTP id d75a77b69052e-5167b6a87a6mr33333931cf.19.1779200882847;
        Tue, 19 May 2026 07:28:02 -0700 (PDT)
Received: from google.com (136.41.155.104.bc.googleusercontent.com. [104.155.41.136])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9cbb0404sm37077347b3.42.2026.05.19.07.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:28:02 -0700 (PDT)
Date: Tue, 19 May 2026 14:27:54 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
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
Message-ID: <agxzanDBmIP54hUz@google.com>
References: <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <20260519132911.GA7702@ziepe.ca>
 <agxolksC_1nfO34X@google.com>
 <yq5ah5o3sdn3.fsf@kernel.org>
 <agxt7SFGT7OLMIah@google.com>
 <yq5aecj7sctv.fsf@kernel.org>
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
In-Reply-To: <yq5aecj7sctv.fsf@kernel.org>

On Tue, May 19, 2026 at 07:47:48PM +0530, Aneesh Kumar K.V wrote:
> Mostafa Saleh <smostafa@google.com> writes:
> 
> > On Tue, May 19, 2026 at 07:30:16PM +0530, Aneesh Kumar K.V wrote:
> >> Mostafa Saleh <smostafa@google.com> writes:
> >> 
> >> >> > 
> >> >> > I am still running more tests, but looking more into it. Setting
> >> >> > force_dma_unencrypted() to true for pKVM guests is wrong, as the
> >> >> > guest shouldn’t try to decrypt arbitrary memory as it can include
> >> >> > sensitive information (for example in case of virtio sub-page
> >> >> > allocation) and should strictly rely on the restricted-dma-pool
> >> >> > for that.
> >> >> 
> >> >> ??
> >> >> 
> >> >> Where does force_dma_unencrypted() cause arbitary memory passed into
> >> >> the DMA API to be decrypted? That should never happen???
> >> >
> >> > Sorry, maybe arbitrary is not the right expression again :)
> >> > I mean that, with emulated devices that use the DMA-API under pKVM,
> >> > they will map memory coming from other layers (VFS, net) through
> >> > vitrio-block, virtio-net... These can be smaller than a page, and
> >> >
> >> 
> >> Don't we PAGE_ALIGN these requests?
> >> 
> >> dma_direct_alloc
> >> 	size = PAGE_ALIGN(size);
> >> 
> >> iommu_dma_alloc_pages
> >> 	size_t alloc_size = PAGE_ALIGN(size);
> >> 
> >> 
> >
> > For allocation, yes, and that's fine because we bring memory from
> > the pool.
> > But not for mapping, as dma_direct_map_phys(), where the memory is
> > allocated from the driver or other parts in the kernel and the page
> > may be shared with other kernel components.
> >
> 
> But if we are using restricted-dma-pool, we also have:
> 
> mem->force_bounce = true;
> mem->for_alloc = true;
> 
> So, will we use the swiotlb buffers for mapping and copy only the shared
> content into those swiotlb buffers?

True, that's why under pKVM, force_dma_unencrypted() should never
cause any memory to be decrypted and so we set it to false.
As in case of any bugs, the guest does not leak any information,
similar to what just happened initially here due to missing attrs.

However, as I mentioned to Jason, I think with some tweaks to
force_dma_unencrypted() we can make it work under pKVM for aligned
memory which eliminates some of the bouncing.
I am currently investigating that.

Thanks,
Mostafa

> 
> -aneesh

