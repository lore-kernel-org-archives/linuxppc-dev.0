Return-Path: <linuxppc-dev+bounces-21166-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6330CD4F5B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 14:37:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKchw2XpBz2yRC;
	Wed, 20 May 2026 00:37:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::835"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779201472;
	cv=none; b=oJ3M9EKBJ8fBs5iba9+YVKt04oWzHCcoR970mmKm930F/rn50XewggqfZKEiWfdYn6MMfnlI83SVJy8Vx5ZbnFd571ilghqPaj6XoTyNsQ6jYlEH6hZIsltQDRrpXRFjV+7ds9fQCaVSJd+pjllwo1t+s2MOQOlxEwa1X8m6EwTbp2azIMzQtW6cb0k0HoOwlsMr3iFTSqnU/6spIW2jKOLOgYtWMSB1flFupI7Qp5uzNvZdOJQLQbnIPP3i0PTZCEoWC4AVDXIbmQt6ygmMCh5q6Trmuc8SgHavL47M46fLsR3/A2EEBb0gH0cN/s2/GEdsdrWWh76Kn1D6ZQhtEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779201472; c=relaxed/relaxed;
	bh=xoUre0ZHh111UbHEIDXHq8nedRN8EZ+gBdSl0fms4oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq7GSB0/Sv/QzOmp+lDua6vEsQFpTci3fwY3kavpGQ/ZRE7UuHAt0j56phPJnFcNv/OdA1W3NNGOvgwGDd7j69eLy1NSvXBz2N9kbGOT8qBLKBbOGBWLEdCSzu+lEuOb+7XwYkntf842I/I+h69BDTf+uWm8DQhmjzlqtVU/2iZXYADE0gzr/Yifm2WAUM0LENcXa4jhiLfaTBzScnDOIIpY6c2aIihWTCVM6grDS+opr9VeU+Wu/8D1ES4HwXgCosfonENZekr4J1zJFhxDb81DjetMPsHQGvOQvAZloQ2o6c/8lBktNbbCfmY69c3N9qLvafsRfOvtYajj7wi2gQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=XhISstGx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=XhISstGx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKchv50qDz2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 00:37:51 +1000 (AEST)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-50faf8ed9c5so18442251cf.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779201469; x=1779806269; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xoUre0ZHh111UbHEIDXHq8nedRN8EZ+gBdSl0fms4oE=;
        b=XhISstGxR7JdfQG5h1wF6MYkwh0rLa0c2UM0wAZNbxB9oJr32PsOL5IoI06vL/8mQY
         rscWjJgwdxFGdmIBB3bdCI4K5kaveOycTzhdtrg3yJ/QY8cwQlU5i86En4G6DKQIQEPu
         sYAeC63vwedWvVtOqMwRXioJ7nLDERk4oESZiwpoB4E0QZ0kQLp9qhQcI/4LU6ykt2CY
         QZFh9Prb5rTzZaDSyFnfgUaEVdgdKTrzwLOqi3/vbEnT9B2dZBt350kMTYopt5gD3I9h
         Dh36C1U2OsCpKVwnt7WjRlD2nOeccTLzWJKa7v5cTU2eSMEc8vv1oDDSM8uznIPsaiYH
         euDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201469; x=1779806269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoUre0ZHh111UbHEIDXHq8nedRN8EZ+gBdSl0fms4oE=;
        b=YGyWADQ7QpOwgZCMCcmKTUana8A/WieJf3YljoR0TPwFCWsmmbHiuWImdvQeoWjUYg
         zpFEjiVREn9uI3mPfH5DSCvTQeZt1BtfxJugK1UUR09p8WGh81+Lmj+gckHn36EqFFbR
         BWYCkZDxuRUCYLahuOEbjmDtZeeST8CPHFtFB2rMKjEePIcA+OTGjeXO3eett8fAHDSy
         XzfgVzJRhhMVpsWc45Xa0IKTWc29hKbUX2bkzTPnXTXKvNgUfe3nxW+31RiU4rI1j3ii
         DMywgNv60Zya8FhlPC5yNzoduLylNi8yVRgxXBMdiII4TIlWomynwdDWPx1ZExxfPkB0
         Mqkw==
X-Forwarded-Encrypted: i=1; AFNElJ8MITPynybqkfmP+skASEBfRcDPaI+cKjgHE7P0kf/B7p6b5rAYgmUSdxo32lF+j6CY3f/oNLjH3Q5qz+M=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwDr6l2w8xN2v3ctu8reymsi2ijfgmB4SRzFxB4CwmlR9iUyhAx
	iYu+yjgfoN17KDRMITh5tkWCq+KqaURVKdHq4ISKXZiyVFQb8CwScEB8GduGcFCoPak=
X-Gm-Gg: Acq92OFGbp+SBu+eQGVvo2NdJMqMssTEqZpv/+2AG4zsKTWkklIkR3C4zuH4bxLL3M+
	oS0Q60IqyTlKcOCWYMPvOtN6Vany7ksDNiUbbZ0GJVFT++ibGL6JGfTmvxFAMrRk/8jhf/0/XtD
	RcUawbtz1o9O8xl7l5bVzE8znplvFK1PTMjSXRbxXAp+xzqimu+qMTl5QBJxKb7g6k7g5afzsb5
	81rqHv2S/h8GlrKnVhQ7MCscMkMHXj+IcdwUEZZGAXBLh5XW4XXLuliCbsJUE7EhDwm0Mesa4+O
	VHvzE1TnmfLfuRJSeTe0th2Vn+2mWWBCHvlU2NUxZ6ZAK8XFKbwguz4xLaCcgoTJEDTi54aIKV3
	B37QYokRmNYiqomkznGLx/y8oG7o51RewqcGB3rSJWkOuRACJV3bXUbkJE6TT2tNZIIWW6+Nmwa
	ufqTRFVvcpb56YezBDoyiUP7kqzLEwpHivCylqQOtos8nBcYZnw3yL14mO9PWY1NUW2K8yIaOpx
	Cysm41ki/ukLDa4
X-Received: by 2002:ac8:584d:0:b0:50f:c26d:f31f with SMTP id d75a77b69052e-5165a046334mr283700431cf.19.1779201468969;
        Tue, 19 May 2026 07:37:48 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456b6856sm165713481cf.7.2026.05.19.07.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:37:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPLZr-0000000F80e-38LO;
	Tue, 19 May 2026 11:37:47 -0300
Date: Tue, 19 May 2026 11:37:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <20260519143747.GE7702@ziepe.ca>
References: <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <20260519132911.GA7702@ziepe.ca>
 <agxolksC_1nfO34X@google.com>
 <yq5ah5o3sdn3.fsf@kernel.org>
 <agxt7SFGT7OLMIah@google.com>
 <yq5aecj7sctv.fsf@kernel.org>
 <agxzanDBmIP54hUz@google.com>
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
In-Reply-To: <agxzanDBmIP54hUz@google.com>

On Tue, May 19, 2026 at 02:27:54PM +0000, Mostafa Saleh wrote:
> However, as I mentioned to Jason, I think with some tweaks to
> force_dma_unencrypted() we can make it work under pKVM for aligned
> memory which eliminates some of the bouncing.
> I am currently investigating that.

force_dma_unencrypted() literally means that memory passed into the
DMA API *without* DMA_ATTR_CC_SHARED cannot be DMA'd from.

It should not mean anything else. The DMA API should never decrypt
passed in memory. You always have to bounce.

Jason

