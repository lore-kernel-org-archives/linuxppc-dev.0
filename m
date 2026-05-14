Return-Path: <linuxppc-dev+bounces-20956-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC4BCD4851
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2026 12:35:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGVD929Y5z2xy8;
	Thu, 14 May 2026 22:35:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::72f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778762137;
	cv=none; b=MjWmh8sptsSbgtb8kabXqlx0i3CwIrdOxi1obUAE5omQjSaR3/uOkRtCe2J336y6Y6xM6sINAsuW7PTmhvPPNGEzEXNdve3jgoSVNYg4hsMVibtwLMphhjDQzMQkjOcmAnS45D9mXV4loUquB3miB9k7yj7RJmS24qtcAsFjKu3eZf+CAVDdl2Zba1kSuo5NaiteA7/vGYphEA/4rdO/CgOWUIFbJxh4bLD47IT9z8ln30nA2D0/2LRhIuv+OxxuVcb7xaq5CdTBzhi/X1uSw6ILOLPsidDrAZxFzlVUk9XyiZbzLgFRRfNQDrfIgdhe049YVyuIVLHfowYOUGvtqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778762137; c=relaxed/relaxed;
	bh=x0syXDbvsxMHU2qFtHkGrYSSCi/zfIXRFYXzTsoQZCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNsZMNv3irzm7pOg8xA9ZGBQ/mSATOE0YpQMlt5ezPt+ZKmcz9Qlz5aOEVYKhbBF5Ue5pGBUaMkdosPmsbHcWw6oWOzHkk6kq+PMv/86XCzelENAeFdAzpKQJK55RVU45pdj7bO6nl06gWI3k/Ymlss76h97DTnRl5JBypz8+r9UP8f+MkUAQ7hhUVZjN5vdKNWXIKX6kMatTNH2mHe3E+wAgtja6te0LRYEfBRvyqWUfVNqx41U3g/W2vbewbiwiOY1Rp+F8urDEYlOWoc/FbrcBOiIWbHTvffGY3wL0b7Dvt2nwrpFJ5EoXIxV8dYz9OlYlA+8bJzDXJ1OWFndog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=VvzGVkDu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72f; helo=mail-qk1-x72f.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=VvzGVkDu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::72f; helo=mail-qk1-x72f.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGVD72VHGz2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 22:35:34 +1000 (AEST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-911501a99feso36604685a.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 05:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778762131; x=1779366931; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x0syXDbvsxMHU2qFtHkGrYSSCi/zfIXRFYXzTsoQZCg=;
        b=VvzGVkDuK5nvfoHVPdQT2oPYUp/rglI2ITct6QWmyQlljeruL9syrHa/uo814KRz7Y
         c6jX3qSUhIIp7Udm3PwbN3KAotquaBhYZgMrJnRcF4fIO5OIHJOy2y3va0qr+lrLdaIV
         cuEYdLCXaDx3ERmo6NXBt+xpe5zK9ephFFvOyDHOyoCyccGGgvLuRNXgnH8+wVL1arep
         SiMx8qRdPB2QDsbprWnQQ25aV+n5Om8JxfxZYXq9o3TG7ne1vBZufTRiZTBrw1YeA9qR
         2NA6W8VA/o55OJ7YYfCjgdl8mZ5M2qfYOFcJ5jDBdsCTNqGTfBM+Bt9lNcZMKVMIouwn
         luJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778762131; x=1779366931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0syXDbvsxMHU2qFtHkGrYSSCi/zfIXRFYXzTsoQZCg=;
        b=S0SfRAHdPGxK30LlNhdgBrH/rb//vZijhTtEYdvd1uDnnPyD1HhDWISi77Z+HuEhiD
         QF4wenokrHjz4A2Szj7EjhK1ETFx15VNrMOcZ8nFXYXNS1o0EoB1l3TyJbXU+lsekFhK
         R/JBAiA5AFw8Usxw4RpEmotHsWvLD44If6x2h7abDsFHsjLIdg9H3E7JiwW2lygkmikL
         gX9a0JZjUI3zzFMJXqMyRcfD5X3tAbkVGIk285Uu+gH8wee6Yc64SJ3YTvrEfXIKbIvg
         82Y+YBkyxI5O8quRR/+OKV27YhKVTV7s56NtX68Yc5X9UlmjivRzhyezRX9jaz4R+fdL
         qX9w==
X-Forwarded-Encrypted: i=1; AFNElJ83T/Q7EkffQn4xnvk7JxCssGwpAkwTks4K8YklX/ESJfucfdOAs/HG4pphpJW7yCo10dcnQtTmEFGj8Sw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyPQ+zJMH4Jg7Hs1s7c7TuehUMN9WKLKyFAW1b7soWnK+kgc1Ib
	iyVaBizdKHUTZUTT5zEpjBQLuMQiU6qCZGQeLaxxyN3QZGQWHnQUW47lAlisCJfq9d4=
X-Gm-Gg: Acq92OFpQKNT92F5XOszGeDaHo2wwvF+QmbeyUi2DZhS4Iz22xPyYgp3GPWBgwE6k7D
	VjTbtvzjejVzgRqikhG7WK7qedjmfen1dmmt1dNZE7ZgB2ROTFpo6ojolIp7eyYCyDIrLAY8fk1
	2NdgVxbQgSyDSpdziz+fnmb2bHEhPHQyFJXp6U4H+0iMBQYPLh+S7wKOeSAPTuZQmOa+l8z68Zn
	GEHpLpaBbp6Kl58CZlJqFKBI06nscvwSzKWAJvFYylO3aGWUPuKVWBatcuJPAIIrjb2d41pdwBM
	i+Pcc6uotm33mNPze9NgqCu0IX0hZAeKT+QHpjne0b45ugHXlW28l0+6tEF8zQsuPcmEKXehfnz
	MIEDkpLT4i//T2a+l5fHpRJmAHmygqfa/3pRJ7x2yL/BDU5pZy8jn1seGFk7TDcebpBXuehnId6
	amULvNBBAGQ9dbQQYTcnxM4lwO3sLAcMwjZdogOw6cDwiGUln9fbQnV942BqT+QffepVhyVuUWW
	mCBTQ==
X-Received: by 2002:a05:620a:4114:b0:8ef:c472:cd71 with SMTP id af79cd13be357-90facfa13d8mr999953285a.31.1778762131005;
        Thu, 14 May 2026 05:35:31 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba182540sm234520585a.4.2026.05.14.05.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 05:35:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNVHl-00000005B3F-3Oru;
	Thu, 14 May 2026 09:35:29 -0300
Date: Thu, 14 May 2026 09:35:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20260514123529.GZ7702@ziepe.ca>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <20260513172450.GR7702@ziepe.ca>
 <agW2lzJI-20DyJVe@google.com>
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
In-Reply-To: <agW2lzJI-20DyJVe@google.com>

> > How will pKVM signal what kind of memory the DMA needs then?
> > 
> > Does it use set_memory_decrypted()? How can it use
> > set_memory_decrypted() without offering CC_ATTR_MEM_ENCRYPT ?
> 
> pKVM (hypervisor) doesn’t signal anything.
> The VMM when running protected guests will use restricted dma-pools
> for emulated vritio devices in the guest, which gets decrypted by
> the guest kernel and hence shared with the host kernel, and then
> traffic is bounced via the pool.

That really does sound like CC and set_memory_decrypted() to me..

> It’s also worth noting that bouncing here isn't just about visibility.
> Because memory sharing operates at page granularity, bouncing sub-page
> allocations through the restricted pool prevents adjacent, sensitive
> guest data from being exposed to the untrusted host.

That's a somewhat different problem, we have the dev->trusted stuff
that is supposed to deal with this kind of security. We need it for
IOMMU based systems too, eg hot plug thunderbolt should have it.

Then CC issue is more that the DMA API can't decrypt random passed in
memory because doing so often requires changing the PTEs pointing at
the page so it would break everything if done transparently.

> > > I believe that the pool should have a way to control it’s property
> > > (encrypted or decrypted) and that takes priority over whatever
> > > attributes comes from allocation.
> > 
> > We should get here because dma_capable() fails, and then swiotlb needs
> > to return something that makes dma_capable() succeed. Yes, it should
> > return details about the thing it decided, but it shouldn't have been
> > pre-created with some idea how to make dma_capable() work.
> 
> That sounds neat, but at the end we have force_dma_unencrypted() in
> dma_capable() which is just hardcoded to true/false by the platform.

For now, the next step is it becomes per-device and dynamic during the
device lifecycle.

> How is that different from having the state static by the pool?

statically attached pools to the device are not so flexible when
devices have dynamically changing capabilities..

> > If dma_capable() can fail, then swiotlb should know exactly what to do
> > to fix it.
> 
> dma_capable() returns a bool, I don’t think it can know what exactly
> went wrong (based on address, size, attrs, dev...)

Yes, but I think the design is swiotlb is supposed to re-inspect what
is going on against the limits dma_capable checks and then select the
correct remedy..

> While we can debate the aesthetics of the setup , this is
> the exisitng behaviour for Linux, which existed for years
> and pKVM relies on and is used extensively.
> And, this patch alters that long-standing logic and introduces
> a functional regression.

Yeah, Aneesh needs to do something here, I'm pointing out it is
entirely seperate thing from the CC path we are working on which is
decoupling CC from reylying on force swiotlb.

> We can address this by either adjusting this patch or by changing
> pKVM guests to be more aligned with other CCA guests which is
> something I have been wondering about if it would help reduce
> bouncing.

Every time I look at pkvm I think it is just ARM CCA with a different
design and no access to the unique HW features..

> > If we can make that work then maybe the flows are designed correctly.
> 
> Mmm, I am not sure I understand this one, shouldn’t the device also be
> notified about the switch in memory state, if it expects to read/write
> decrypted memory, how would that work if the kernel changes it to an
> encrypted one?

Nothing on the device changes. In a CC world we put the device in a
T=0 or T=1 state before the driver loads and the expectation from the
DMA API is that the device will only use that T=x DMA type during
operation.

A T=1 state device can access all of memory, private or shared. Any
information the platform may need is encoded in the dma_addr_t or in
the S1 IOPTEs.

So we never need to tell the device driver what kind of memory the DMA
is targetting, and we NEVER expect a device in T=1 mode to have to
issue a T=0 DMA to use the DMA API.

In a pkvm world it should be the same, the S2 table for the SMMU will
control what the device can access, and if the SMMU points to a
"private" or "shared" page is not something the device needs to know
or care about.

Jason

