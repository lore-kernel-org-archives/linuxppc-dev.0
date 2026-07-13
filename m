Return-Path: <linuxppc-dev+bounces-24146-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8D8C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 19:42:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzXs55Lc6z2y8p;
	Tue, 14 Jul 2026 05:42:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::830"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783971753;
	cv=none; b=cW39mMr11Z0HgFwxsoyUSu6NCDvlypWTolBZguKftnrQj+K9IFT4REjI1+LUVh7hT+iivo05F/FAyA702Ino0GvxngdlWb4KPFhaFohF0P8IpW1HUzAs0BAcP/fnk9Pk6RP05AdGUz/ZES3fJA0xM4i5TGT0gwiC0TaAoE0NFY4IwkTEl6zkrAo77CehAl4CFChBhG1ToCQdSnFqHHHHib0cV4i4As12ZjMlCLXgUhT72Xh/yae4Qt1oNmpC0ZTDZ4T/gJQm9KNOmd4ZjaDl44bGWaVSdNDeGsm/2Ana8iwNLaAomjT3mlNs0klFjX/yLHMIBk6+6Ik23Y+1YxmDDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783971753; c=relaxed/relaxed;
	bh=1BBsjNZJ46p61GVJyRNvRKNhKTJyhEwUbX6XNXZgDe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSLUuUAgQox7jGVc2qdgEJGpoTBXTiugHIaK/gUSxPz4roIAIo1oXo25QB4dKmoddrf+LekbErFL5c9HhEDqjlqBF3jIpaGbOKrPRV2vyhnt3FVBi3uzVYxT4W0Y1BfaKIhu0hu7zl2iKYiVjTf/gwMXahsprv34Un6uFiocO2GAI4UY2oXJY5SgYK9GRO5pS4UnUaEZbN/UqoVjZvDF2lknwJ+6u8CYRVRS/sD4MzwWw6qU1DfsflISls0RIvdZUy0EUUP8DSjDZuU4cCL9UQDgtsvz7OW5Pr+zws4KdhXb9ivdJQwa41j4JOnqQ/F8D8kgWlCGIjcNddqVVEjc7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=h4PJiI1f; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::830; helo=mail-qt1-x830.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=h4PJiI1f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::830; helo=mail-qt1-x830.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzXs46L1Nz2y1F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 05:42:32 +1000 (AEST)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-51c2a818fc4so25802021cf.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 12:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971751; x=1784576551; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1BBsjNZJ46p61GVJyRNvRKNhKTJyhEwUbX6XNXZgDe0=;
        b=h4PJiI1fxo9+IuKsk5k5p2HpaFVD6q9UZcfujwh4/Jae/oFhLqijy3aqaaRxqW51cv
         BqAgSz+5WcBZOw1uSa/uwTLDSAmt0f1DUokkqcT2AeteN8KzyLjW3hX9VLxr5oxCkkBR
         DYNPKA7XnV+poyrDXBEQGmHrLaDO1h6tPOhksmygIx4uA9Dyn2mvWSj8c4sHNJqspHt0
         8Y5xJ/0Q1yAPTZ/Z2RFiicacNEPrGjD1rTBSTOmRdY7pWdVM0HzbtjLCdlf4Wd+ad+hb
         Ss1FrJF/iz7NtjlaGcfxDnzgrZah+umh4bjbFhfOy6z/rci4BI2hvuy0kO6d+uWXHwTH
         r/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971751; x=1784576551;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1BBsjNZJ46p61GVJyRNvRKNhKTJyhEwUbX6XNXZgDe0=;
        b=Tvv8EHdy4LQ0cOzpK77QU51JmBxMkUPe62e+Q3sF37vwxL2IdT4WQHgUpqBbMrBx50
         SkS5dv5U5+Bib5PEUY3/HNOdzYIDBpktCdz8rTpQaHuIHlOq0RjrulP8rZctS/KJ1nxW
         DtXrIBAxcid9524gp2EQkJ193Y/dGyIw6UpnRcZ6prNYCG4MENNAC1gyM/v/+gt9xhCW
         mJK3k3eZuw72OPnWX/I3sV5zF3qs9igzOtMYHQ6xoPSxqX5ZceZsuXMLCNXFY/xmu1tF
         xdz6QmSV0oec3UaQcVPahm4LrJeNKQN/WJLBkjIemAPnRfdSH9G0y6ddavyujX0yUkVd
         k72w==
X-Forwarded-Encrypted: i=1; AHgh+RoicmfjKNRo2hkTNtC5GAzyd/CKtPcPxKfdVHbwTdLk41PChdkS5Zm60o3vsUtrAiFYL2U+4qAhJ1lwU70=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyLfiAcFZUvFOBfTa9Uf+rhRCeJebknHt9jGS7YpXqPcB30uAik
	lk7E5tR9E4EL9r6tRM1eyDBXi7vkDNWFaVSR14TXOVTFrImFhJ2gs5JOrje/WAPSmaU=
X-Gm-Gg: AfdE7cmJ53Jnse64ljoFA3Ks8ZG0mq/CGAE+R6ziutcmpkzWMf5KNgbh9Kc++60Hkei
	QY/jn92zYYZodBlPRpBJfJ1daf28C5sbX1Ct9fnT4NwZznCv/7f/cj6I/d0wQwystsQwtAGoLy6
	UYCp4TYt227FGHW2bIvuPEWbRvMtzPa2FMHiMkd9KiInAc//Hkdj3c3UZQPONUgd1v4GtPkyIZj
	JxUuIeDi6D49tqOoxOPc4ofDsVZrUOiyy0w4PwrPJP6ZNVmT9qZ0NxhVna1Dyow6X5XoaHDynqw
	Vno9jMFPemujCQMnNSAdRe1lEXM1WicXOKKeD8jqsQWhu9MwNMRvdPk94Xna2XUELEbTTEQ5Wt7
	fXb7O6C6sLqQ5SVaD4VrPVw9UiUXCl9oCNw4tc5kGrloreUfhnf5fSMKnwpDW
X-Received: by 2002:ac8:7d53:0:b0:517:6550:2a0 with SMTP id d75a77b69052e-51cbf0b836emr108931441cf.19.1783971750625;
        Mon, 13 Jul 2026 12:42:30 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd5bbac2asm138277776d6.21.2026.07.13.12.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:42:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMXt-0000000E6oU-2oJ5;
	Mon, 13 Jul 2026 16:42:29 -0300
Date: Mon, 13 Jul 2026 16:42:29 -0300
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v7 22/22] swiotlb: remove unused SWIOTLB_FORCE flag
Message-ID: <20260713194229.GB3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-23-aneesh.kumar@kernel.org>
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
In-Reply-To: <20260701054926.825925-23-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:26AM +0530, Aneesh Kumar K.V (Arm) wrote:
> SWIOTLB_FORCE has no remaining in-tree users. Forced bouncing is now
> controlled through the swiotlb=force command line option via
> swiotlb_force_bounce.
> 
> Remove the unused flag and simplify the force_bounce initialization.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  include/linux/swiotlb.h | 3 +--
>  kernel/dma/swiotlb.c    | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

