Return-Path: <linuxppc-dev+bounces-20980-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E328DCD343F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 14:39:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gH8w43qHFz2xHF;
	Sat, 16 May 2026 00:39:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778773455;
	cv=none; b=Yc95WQr3VBDMHL+7lNl8zP3dwGJzpHS69drBkjtmCU69tH40uVVezjONETuElmAxGHRhJ3SE+57LvHlTdJ1eRhsW7t1uWRMawpfQkpE9d1PxTdIRJwdSa80MCSFMRFdXQkCarBq2K5sztkX2NXTR9Aza1Q4KeQvVZGYlD/VHiWn6yALiiH2ralfZ+6FsM9hr63cNapE8iLlv/zlwg3qNZRsHAP6GTCd/9CSF/foAi5i+I7e1RYLXFHvmIKCYpKzOJUyv00S9zq5FzDS734zDtkHA6zUeCLZuv+vankm9dQTLCKKiTOnHDUmUhB/NbROwAzcGXJfcUmZoJj1vu6iErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778773455; c=relaxed/relaxed;
	bh=lh6aFT9PQ6X1PkDdo12UH9E/whRlrKT0Rk5qkvPCSq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLVCTPzCSFyC6DWRT01QzTIxSrIH8mOsXHUAYul3nncIyGvk1gz3BP/z1NSJTSAiQU2Q11xcRvAQP2Y8c2RNpKpt7sxojMH0btTtgmj7M9Swvg20ZpPkFPweNzVm7AhilJPocFeP2pGPO5dDflkhXg735alYnkyTdLB7aHi7HaUfd4t+zN5ui6cEoe23hNch41FErO7L3x4xDuGVC9eofcHMz1gUdY6QDbxgHM+lu86eXx88MB9OCvzQHWIpNAJebFpETQzSZ7QabceV0xXaoJnci4qHHWZrkHb5KuymTdXJPA7BjQgPhPwTMV4IZWST6N+6W5JIZXqE/gpulZtc2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Eo8BdNm9; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Eo8BdNm9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGZPn3f2lz2xlV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2026 01:44:12 +1000 (AEST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso120405e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 08:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778773444; x=1779378244; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lh6aFT9PQ6X1PkDdo12UH9E/whRlrKT0Rk5qkvPCSq8=;
        b=Eo8BdNm9Qlzzm4P73TmwkNp18bSehEZWBknEhndQrndH5Xha5Q9kqoEFL5UUBFZ2nc
         2yHziF/NSszx2X1MnciBtOKi2W5xEFIjNNIt4cfWAUS+d/hJ9+99T7hLkh/5x1/w6iQK
         MnXQcsMuXCN0AqIRpf+wK/42zdYhYnnPg8JBgIOntafLwdSE/VPO04Xd32l4AlBZIicF
         kTfECykrzlJddkXO4C4QbwbVJ3R+7x3vUjB8+BA8YQSQ6Gvjz0sLL4EN4347eNyC3Z77
         4JrelSbI65OAnBckd0n7URRMFm+AOl7gRaD0kgVjL5fricWXjYaqv6BrarOPJkXEe+ga
         aa3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778773444; x=1779378244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lh6aFT9PQ6X1PkDdo12UH9E/whRlrKT0Rk5qkvPCSq8=;
        b=SmWhfL9/YGDvhgsIlWFuArTFSE6zHYpO8D6A4K5BPOrQ47wLzPytam5CRvxXzGgpvV
         +fphmIZMibZ2O9EcAehiqSWS4VnlpnDuLj0714+Zba38dq4Ww0/fcUqJP5jXRhx3ZMYI
         quyzFw9aZt87PpG8mY49+lVcWTqIMV15OCbwRsDZSPnREFgdaebf/uQvDta2Ss9AoWLu
         RRPRFK+bxUAetjwngAD+S1rZjPkdxsUEuf4QCsHxFyvPjfUBSO512Jo86na7+D3TXO7a
         AraC9Cx3A7iwdFQAusCI3GL5lTmx5nmff+i3K4IrgJ+hELsj47IqBoWoRuAHzvx7Ivec
         lumQ==
X-Forwarded-Encrypted: i=1; AFNElJ/MFL9KWHFk5w5i7bu5I9VLcdO1qwD1kk/J/FC9tu8YgUoE55vAiTeWtIxfSPNiCJ13rI9fOa4nulFWL24=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwCQtgC5yZQUS31i9VGmL+HSA/S+6ujvcVqugK9HGFrc21J4zKN
	z3X8mR/nMiBLeudh34N/Rd/eyWusnRpb5TZf7bGZK9fIAfFFxH893dSr9YB8fg28DQ==
X-Gm-Gg: Acq92OEGY2cbd2y5+OBWsf4lbXPewwJefGF8QiM3TZLWcU+iCOyIy5iprbDWyjVIFyZ
	d6DS1Dt6bvzyhsnYZK1dnu8TnkDZshr8UsNJMhb6P+etX4Heq2XjUXz6fNqnRRz/qADZY67rX1A
	oz9wutdr6cUicGCpChD6cpYDqaFQBnEDP2E5Fukp8xJtONoxxBk1m8NaFmRQv3XLD5SSTNm+PEo
	hm0bRWLsSolQrfpFwlnbCs7YuiWIPZNmbuBYw0rkFT+uB5zd0oToCavuE5S8IpHqwObJQ/g8UaH
	PjOOwmRq9n9I7eIN0o/gRfNdyDQ2g4GkReOorJAdvVK/ho3HS4mkf5UnfPGQg8IuVdzIUtGarE1
	VUUbRgz+sCgqnv5BCjzJJgMODvyWVm/1SCtnZFAGFqh5BSF4hciHp3yu3Pcdtc9Z7PNfWbZfJ39
	57XH3f0ty4/PpLQaDlB8N7HN7VyQAOGUYiwDQceNOkgchMyNyppoosodX36WyawHEwxis=
X-Received: by 2002:a05:600c:c04b:10b0:48a:5d95:d33e with SMTP id 5b1f17b1804b1-48fd6e10247mr915845e9.6.1778773444106;
        Thu, 14 May 2026 08:44:04 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0f72sm7842670f8f.25.2026.05.14.08.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 08:44:03 -0700 (PDT)
Date: Thu, 14 May 2026 15:43:59 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <agXtv-Wsun82SRmf@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <20260514143733.GB7702@ziepe.ca>
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
In-Reply-To: <20260514143733.GB7702@ziepe.ca>

On Thu, May 14, 2026 at 11:37:33AM -0300, Jason Gunthorpe wrote:
> On Thu, May 14, 2026 at 06:18:05PM +0530, Aneesh Kumar K.V wrote:
> > > There is no problem with non-protected guests as they don't use memory
> > > encryption, my initial thought was that th encrpyted/decrypted is
> > > per-pool property which is decided by FW (device-tree).
> > 
> > What I meant was that we need a generic way to identify a pKVM guest, so
> > that we can use it in the conditional above.
> 
> If I understood Mostafa's remarks I think different devices in the
> guest need shared/decrypted and some don't? Ie a virtio hypervisor
> device needs shared while a real PCI device doesn't? Is that right?

In upstream, device passthrough is not supported, but that case is
supported in Android and we plan to upstream it (it currently
depends on the SMMUv3 series first)

> 
> In CC terms that would be a mixture of T=0 and T=1 devices hardwired
> and signaled by firwmare..
> 
> Ideally we'd have a flow where if the arch precreates a swiotlb pool
> with special parameters this overrides all other decision making. Then
> this series is about making CC NOT use that flow... ??

Yes, I believe that will be needed, we do this at android by a per-pool
property added in the device tree.

Thanks,
Mostafa

> 
> Jason

