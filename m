Return-Path: <linuxppc-dev+bounces-20981-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A823ECD343F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 14:40:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gH8xy6jPyz2xHF;
	Sat, 16 May 2026 00:40:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::129"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778769831;
	cv=none; b=LUJ2tnaOy8c3tIzQpk7/58TIj8QVlzmsj2o1SaUayBfPsh1JK8nKEzo9KoH3DwHczZluHWhAk7oGWlJ000NiPT297safw3h6MzxDWnipcqDJ5pML/m5uzA8nGgMB2Qud2BQF4BtEFwmPg2kiYFBpPneSxVS8VG7uLUYXUBNWta5FCvMlVFirpTxyhAYMT5qs+mvWNpXR1rDK5mPxVPGEDCFlwrNd5tZqT4Is4vQVQQ9kJNMOxpHQ4aWI7i1azgfb9EPP/DGEgYPG5VcIQ+Z8/61goRtAb2y/yGiSwyxqsL8qcFUpMRx2zUt7vdXsyFGzR5Ez9SYZ/rIUjxWTziXAdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778769831; c=relaxed/relaxed;
	bh=i68MgXr4Uit+MmJrWGtw9NAg1hDWWWOTovHHIC3ey2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMQAi8gm8GeQkqbh1hTGF2NlW5hALgH5IFjBNqzNfL4xwvj4R+CybWppEb26S9iYCnD0TutWp+M7Snh4K1UC9plHwNgsV3SQ096Bp2SjFO3zjmo8ULLFR7/V8l9hmBQ6qKPtkNwKEqIEd0p56Z73cTmpvBS130avuCKp59kFERJ+4TS/IzFRLvNuiI9Wc+s0cYdSmVoTyQQ2Aac5hqMT9YyE0BdOk/8+fCakN+lzTX6aEltOdmpwUEomfuABJbT7rN+TQa1S6HH2uzbmIFVY4KpbGN1WbfZ99+qWeCIbWcsQIqwRyXG7HgpAevJIbdnfZbk6cMTy7wO/ufOhs/gl6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LAvUg6AX; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::129; helo=mail-lf1-x129.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LAvUg6AX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::129; helo=mail-lf1-x129.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGY455kF0z2xH9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2026 00:43:49 +1000 (AEST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5a8bd9a881eso5972e87.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 07:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778769826; x=1779374626; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i68MgXr4Uit+MmJrWGtw9NAg1hDWWWOTovHHIC3ey2A=;
        b=LAvUg6AXIDsIXb5IW5EZR8kMyzQfhi1Ql9M1KbH/A/oJfKGnC+FJw2DcK8UGYKCSse
         UEMZP7+GCR762ZKZ3pVMI4EROPDCSGMpkN+RjcnjDv8spm9lh0I6nH1JZfogxPeB+bq7
         5oW2Mu0Ks+XBX1gPHF5kT6KktM0ehGevUtEc5JOetpDEycAqK53k7kJwNoGgpM/AcDct
         5hMz8lQGNf3+MfJAUiS1wS24x8GxgPgBtl5SDNwepZ3nl2SnaKoiZVEeXYWLKDW9EAxD
         GoX2zMgaUbNfq78hmivTwZE8hM4eI+n77S0hY97ik/hhvuLJka1eunC2ucDz4K3VqIRQ
         Z2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769826; x=1779374626;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i68MgXr4Uit+MmJrWGtw9NAg1hDWWWOTovHHIC3ey2A=;
        b=XH/yuPPN00SqWoNEgQJTVBIzKnUsBGBcbMvWsx0OcUsINA0wVSZClR2sd6ibI5QBfX
         RKu3NzgqtQIzCMuDNcyPyLsh+DcapQpAGSGKc9pMFqXUdBK9QtsCJejDF0ftXwDnlUpE
         9iGRNFuCfnQ6tr7bk+j2IcgfnoTB0f+XE0oUT3OKtd9Nckd/o6V7PirGNqJHK0PNDFmm
         nkDQYpGnOpazOhhIlUpWDLj3Cm5khHgO/2LrktQ1HbuLwuZNJnrLfs8Bzey2BQaxthDE
         udfzMHh+as/s2jzhXOe05vM97cyj6++YkaDdMAyqJ+C6+VoU28dOCnXwiIuXzQ6NnFxY
         fkeg==
X-Forwarded-Encrypted: i=1; AFNElJ/LO3ItXGIjYIPcgGt6Tx4hiYU7q/kG6ZzNsQECvZqHjRutvLI0OuXiYVdSHnYCyZDU3cB60epGRLPLpw8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwQFeGwPlpmQsKx5b1kC2hrC15P9OKRv09B1TsVu0dTmld0ZUpl
	QRRV2xceDf28OSNxjgVsWPh9HbOX917RQ8dyALbjYrC70mljt9UJnMmELKK8rxiHrQ==
X-Gm-Gg: Acq92OG3OXD2xaKv7cl1LAN3Dv6HhsdFx2oo9Gy/fsqjYptCrOoMWfxtw20G8xZTpGb
	KptL+3Jfc/RtFIkexfDgff09KGL3jZSOmG3jNRXPMPnHh06Zq1isqv1MWFh1tJacz0ssSleS5Gp
	r/Yt/gBzqylOXJj/+n4489Pvct2ZzgoZB99KPKlTD6Gfwy4EV9dYu7lY0dGMTGBvZaMKXzDyBmT
	fKQj4fhl4IMico/Bnc0Auz93Rr7hoELrcfzqTUweoLuZ5pr8AHtVFcboTCuctJm+c+6CFFLB4/P
	2FHiWTgd0GdRhvw1Dg34qXPRNhypRcLc9qfcxg2s6AB6BBFMUajvoTJ1MxQdSRtyLbIoo0XscGt
	0Bk/WZJdqLRMWXsHfZRABOvHRPQd7DmwqovziwwPtxG597g+QYN6ti8T1pIHov/rUmKlPF/Ss+w
	U9hJLElxxpNqZjUWCalUqd7UJH+ND0c7IkP4ZR1FnUl32Lk+64gZWocyPZQ3GaCrduRHMW
X-Received: by 2002:a05:6512:66c2:20b0:5a7:478a:e6e1 with SMTP id 2adb3069b0e04-5a9282ddf8amr143960e87.5.1778769825580;
        Thu, 14 May 2026 07:43:45 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3945c885856sm6691881fa.5.2026.05.14.07.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:43:44 -0700 (PDT)
Date: Thu, 14 May 2026 14:43:39 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <agXfm3mS_M3fvRrN@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <20260513172450.GR7702@ziepe.ca>
 <agW2lzJI-20DyJVe@google.com>
 <20260514123529.GZ7702@ziepe.ca>
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
In-Reply-To: <20260514123529.GZ7702@ziepe.ca>

On Thu, May 14, 2026 at 09:35:29AM -0300, Jason Gunthorpe wrote:
> > > How will pKVM signal what kind of memory the DMA needs then?
> > > 
> > > Does it use set_memory_decrypted()? How can it use
> > > set_memory_decrypted() without offering CC_ATTR_MEM_ENCRYPT ?
> > 
> > pKVM (hypervisor) doesn’t signal anything.
> > The VMM when running protected guests will use restricted dma-pools
> > for emulated vritio devices in the guest, which gets decrypted by
> > the guest kernel and hence shared with the host kernel, and then
> > traffic is bounced via the pool.
> 
> That really does sound like CC and set_memory_decrypted() to me..
> 
> > It’s also worth noting that bouncing here isn't just about visibility.
> > Because memory sharing operates at page granularity, bouncing sub-page
> > allocations through the restricted pool prevents adjacent, sensitive
> > guest data from being exposed to the untrusted host.
> 
> That's a somewhat different problem, we have the dev->trusted stuff
> that is supposed to deal with this kind of security. We need it for
> IOMMU based systems too, eg hot plug thunderbolt should have it.

I see that it is used only for dma-iommu and for PCI devices.
However, I think that should be a problem with other CCA solutions
with emulated devices as they are untrusted. As I'd expect they
would have virtio devices.

> 
> Then CC issue is more that the DMA API can't decrypt random passed in
> memory because doing so often requires changing the PTEs pointing at
> the page so it would break everything if done transparently.
> 
> > > > I believe that the pool should have a way to control it’s property
> > > > (encrypted or decrypted) and that takes priority over whatever
> > > > attributes comes from allocation.
> > > 
> > > We should get here because dma_capable() fails, and then swiotlb needs
> > > to return something that makes dma_capable() succeed. Yes, it should
> > > return details about the thing it decided, but it shouldn't have been
> > > pre-created with some idea how to make dma_capable() work.
> > 
> > That sounds neat, but at the end we have force_dma_unencrypted() in
> > dma_capable() which is just hardcoded to true/false by the platform.
> 
> For now, the next step is it becomes per-device and dynamic during the
> device lifecycle.
> 
> > How is that different from having the state static by the pool?
> 
> statically attached pools to the device are not so flexible when
> devices have dynamically changing capabilities..

Pools can be per-device also. A device can have mutiple pools with
different memory attrs, which then can be matched by the DMA code
at runtime, it's not as flexible, but removes some complexity from
the guest code.

> 
> > > If dma_capable() can fail, then swiotlb should know exactly what to do
> > > to fix it.
> > 
> > dma_capable() returns a bool, I don’t think it can know what exactly
> > went wrong (based on address, size, attrs, dev...)
> 
> Yes, but I think the design is swiotlb is supposed to re-inspect what
> is going on against the limits dma_capable checks and then select the
> correct remedy..

I see, but that’s not part of this series, and probably would require
some rework so dma_capable() can return an error code (ERANGE, EPERM...)
so that caller can deal with that.

> 
> > While we can debate the aesthetics of the setup , this is
> > the exisitng behaviour for Linux, which existed for years
> > and pKVM relies on and is used extensively.
> > And, this patch alters that long-standing logic and introduces
> > a functional regression.
> 
> Yeah, Aneesh needs to do something here, I'm pointing out it is
> entirely seperate thing from the CC path we are working on which is
> decoupling CC from reylying on force swiotlb.

I am looking into converting pKVM to use the CC stuff, I replied with
a patch to Aneesh in this thread. However, I need to do more testing
and make sure there are not any unwanted consequences.

> 
> > We can address this by either adjusting this patch or by changing
> > pKVM guests to be more aligned with other CCA guests which is
> > something I have been wondering about if it would help reduce
> > bouncing.
> 
> Every time I look at pkvm I think it is just ARM CCA with a different
> design and no access to the unique HW features..
> 
> > > If we can make that work then maybe the flows are designed correctly.
> > 
> > Mmm, I am not sure I understand this one, shouldn’t the device also be
> > notified about the switch in memory state, if it expects to read/write
> > decrypted memory, how would that work if the kernel changes it to an
> > encrypted one?
> 
> Nothing on the device changes. In a CC world we put the device in a
> T=0 or T=1 state before the driver loads and the expectation from the
> DMA API is that the device will only use that T=x DMA type during
> operation.
> 
> A T=1 state device can access all of memory, private or shared. Any
> information the platform may need is encoded in the dma_addr_t or in
> the S1 IOPTEs.
> 
> So we never need to tell the device driver what kind of memory the DMA
> is targetting, and we NEVER expect a device in T=1 mode to have to
> issue a T=0 DMA to use the DMA API.
> 
> In a pkvm world it should be the same, the S2 table for the SMMU will
> control what the device can access, and if the SMMU points to a
> "private" or "shared" page is not something the device needs to know
> or care about.

I see that's because dma-iommu chooses the attrs for iommu_map().

In pKVM, dma_addr_t and IOPTE are the same for private and shared,
so nothing differs in that case.
We don’t expect pass-through devices to interact with shared
memory (T=0) at the moment.
However, I can see use cases for that, where the host and the guest
collaborate with device passthrough and require zero copy.

One other interesting case for device-passthrough is non-coherent
devices which then require private pools for bouncing.

Thanks,
Mostafa

> 
> Jason

