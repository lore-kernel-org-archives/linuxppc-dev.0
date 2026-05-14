Return-Path: <linuxppc-dev+bounces-20958-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25168CD4F25
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2026 14:37:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGXwz581hz2xH9;
	Fri, 15 May 2026 00:37:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f2a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778769459;
	cv=none; b=cVKgEypAZv/JpIkuIseuiuFtU+s4DJBURM3Man6/YwkFioaMgBgRWMTKxjWJNHXpKI93BMMMXIoIHoFHvFlA/rQ0eagnk1eJzIY6RsRgXt1cyPg4fGP3QaQhLlUNfsMIXWV3DLLgdhjpD2SIDuwQOA9zo0Y3Mqh94aayx2cw0QgaHKh/fVYPC8jN2aXDHGbBgXBf8r+LkHLSUszuHVG8HYDTNY4OjNb/LofLNpBJ5ng3m7BD1fDZf7LXEAdY7Pm/ff5KbJ7RlaJCDYt8pBlnp8I0MMwyPioFkyupavoPuh3KrO65M6sl/uW12i3jmpVPMjzFsYorUlU1WT/oKYS9Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778769459; c=relaxed/relaxed;
	bh=TKVmCu+Gb/QJi05GS/MUngbhCp2nJ8/F0kCLFA01DR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXcgpcWbMKuZ/p5CU5IrnFMnbEKsgYhQdtjsjqyWEVCJq3Jcic0JA0pTLG2cdwM8qlLietoapygJJJaLvb6Z8PcbnzvJh/x852MU56C4p6Z65lE/RPieGOt98oycZGiUXnfNbBtgbRhqoQgiX11fYl7bwyY8mZrEmhIcAglYm+CqURaueLdHR5VGEPA9SF3LIH9+dHzv2aWHXTev626UAEr14QeH/4mGTiGHQDhMn3o68mRT2ZPjwA9wL5R8ejD9Vu5f7bW0imkf3s7tCbHna/6aIGTskwMcHVpakHg9nY+70w4lfzJ1n8OrajRE6colt1BoRp6cJnlELs5zWT2vBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ENsV5tiQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f2a; helo=mail-qv1-xf2a.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ENsV5tiQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::f2a; helo=mail-qv1-xf2a.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGXwy37cnz2xFl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2026 00:37:38 +1000 (AEST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-8be236ce888so63931486d6.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 07:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778769455; x=1779374255; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TKVmCu+Gb/QJi05GS/MUngbhCp2nJ8/F0kCLFA01DR8=;
        b=ENsV5tiQ4BBSQAiFcpxANb+7vBkxGfUOUH4Yn1I1923OkrRLdeH2e5CH3dFXF41hFr
         JktsxY7eqXkUkaoPIEcVKek40OWwfJD35wBzGWkEfHnsvqfMBvz9u7DRH/v5tOVkqMhj
         ztTIqMGMsg5OGm7ynPDg3zsh4v1ATCGd+Cyp5ryLQ60qSr+Iej9NSWW5DWNYkikigg35
         R63nwWDMkMddTrPxTCek+KSb8qzqdlMMUfaw77Qg8w0KBl5OoR3byNNbmbmDBUUzXRxK
         8cRFnVFBgJT73yc7TPEyYtYCMsui1Wl0pCE+tn4g2h8GRRzSlEY3zmtPch5eRwbMDsZu
         wvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769455; x=1779374255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKVmCu+Gb/QJi05GS/MUngbhCp2nJ8/F0kCLFA01DR8=;
        b=guepS5tlM4f339KIeD4zLuMx6tG/4hDNP/Eu8A7j+DCvkYTvk7FiJFxmphzlohQI4m
         Pei1+oOtni0el0GTsq69Q15d5U52DajMLEXqGBhEEdr+qqqdge6lWnexK4YusfXw3K0a
         uhwK7OV7+5Rq23Bvndhh0mtbC4LRiVfc/QwHxi9h3bMFDZmQtncguSn9v0Resxa140IP
         g8X1oEyJ9pq0RanbtXY+z+EQ4WGTYhBcoSuhf593ahRLXn6HGw5uTEGevtPZVhvzmf/d
         /462AM2aL4pAgQ80RDGXKBPxvy0HmkLV4MRXp4x1imgwwwjcoTdDeXH/dKEsd+P0TMzu
         eo/g==
X-Forwarded-Encrypted: i=1; AFNElJ8s7dZqQkofQntfdNazb96Mi+nodsZakybnyNdVUgqbpi6V8dbVgpkWaGeNuKwc3tUOq/4uT0lQmFHTHuU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yznfx/CP6RZFZd4kzG9UE06Vl/QTDMX37iX4yR8c4KrKcJbhO4H
	3TYlL99IlfeFCDHkD812LV5HBlWsrwIfHWMcePVd+iEALmWafgZ+8xnaijXWqnsiU/M=
X-Gm-Gg: Acq92OHwWM/pPS2YoW+jMOlQPHqKr2t1oKiUu7kleBm7WXcrbjAiCf/LaZM1n6sK13E
	aLbtk76g8SVISM+PYHLnTbuqLX0+7P1UmbLkUEeSj0VDvmR7lv5WiAjNqGJwTKTk26hyAFKut5k
	rAmIQCRq+8KHYpNKG12+8K+aAgNmrfTUslOnJLYVhy2VLoIWlamNWx21FJ8s5CIn1Q3ct9f5tXe
	DfSK5XevFtICkB/kfpftT37dFV7U4obSiBuTzEP1AC2M1KuckbemTWaAbbpFTPzGapExOi1IiLW
	n7sjD5JBpfLdNhKKo5OVDqahWSjSYFyz1INQzm4w0geptg7fATUuVks29lYdC1S+nb/LANvB8A7
	NK0IoWFdnLne5OqYQvZYYHOX+40eOmJBL2uqD4KekiEoZ7uY9uw0MHucc9CfpYr/IEY+nGeAhUw
	Ao1QbVpEeyNcWnfrAglpvoGGJN7+7jnk9xOSmIrQBVYtWHS+3gENjIhMvsy2K9QhWvwAeH2jIMZ
	rHQlA==
X-Received: by 2002:a05:6214:55c6:b0:8ca:ee3:6e99 with SMTP id 6a1803df08f44-8ca0ee376b1mr2894306d6.44.1778769454659;
        Thu, 14 May 2026 07:37:34 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908e11929sm25017416d6.14.2026.05.14.07.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:37:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNXBt-00000005Lti-0CPB;
	Thu, 14 May 2026 11:37:33 -0300
Date: Thu, 14 May 2026 11:37:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
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
Message-ID: <20260514143733.GB7702@ziepe.ca>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
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
In-Reply-To: <yq5apl2y5f96.fsf@kernel.org>

On Thu, May 14, 2026 at 06:18:05PM +0530, Aneesh Kumar K.V wrote:
> > There is no problem with non-protected guests as they don't use memory
> > encryption, my initial thought was that th encrpyted/decrypted is
> > per-pool property which is decided by FW (device-tree).
> 
> What I meant was that we need a generic way to identify a pKVM guest, so
> that we can use it in the conditional above.

If I understood Mostafa's remarks I think different devices in the
guest need shared/decrypted and some don't? Ie a virtio hypervisor
device needs shared while a real PCI device doesn't? Is that right?

In CC terms that would be a mixture of T=0 and T=1 devices hardwired
and signaled by firwmare..

Ideally we'd have a flow where if the arch precreates a swiotlb pool
with special parameters this overrides all other decision making. Then
this series is about making CC NOT use that flow... ??

Jason

