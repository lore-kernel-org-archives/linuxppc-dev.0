Return-Path: <linuxppc-dev+bounces-20954-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C366CD4851
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2026 12:10:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGTg14mZMz2xy8;
	Thu, 14 May 2026 22:10:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778759334;
	cv=none; b=Ys4UGiJVP0Q5mo6USqz/b7TrxWmKx+UJybEQVBKRKMMvF3iZR7bIbKoFu9j+KCzvHLWOB6HYiSZaifEAL5vLrz3v/JT1QfU16WULoWV7PF2VRVSY7PdSHr48gdjU5gKrYgerGtcDWlSIj+PR2FCY784GLZs5WRhV9krNFIdYKjO9fjcy5CmFQXsIZXZe+zKACsx+G7wlNEKZDaM6E1TowUj0P+zpkKCiQkqbygiyr5R6GnwSIWHUoWEwjINyMi39b+24yK7uQ0OP9qbEIvrOMBtdy2cKeDa+oHuIgFE53XbdlySJBlr99vid/OT9yIoc9ZIboQkuwgzKfnfFTnfUfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778759334; c=relaxed/relaxed;
	bh=rg6bmFDt84HgfdmHQ5rMQfe5qNs0Lmh5zrMOKqozbmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kK9+hAGAdOZZDWvulc2DVKveWqKg+EE5rNa6VcNT410F6bmvze59mwiB3VPamnms2JQfBMxNfsRR/578fkLCD1z+hobe/pRQ4AcJ34pbFMKIoH0oaVpxok312z0gRZKd2knLa+2H+DvuryIJCIS13JXcbwrdv7WZ59hpcs34lVJsBb3esKc+jNscdHQCfJIFOSCh5Q4mM+LPd6iGnBSgEt+hN6E6if9DhOcFSF/VAiE1ckDYsb+S2RUExwp4aMV4pn43aVLyvpC4xKqIEmHc7yDZvm2RojgQux+DfUDgvUvtbrXdbbhxaTZtR0NRBpU3omvr5Wv0q+X692bdT+zbVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Tfmqypwn; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Tfmqypwn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGTBD72kxz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 21:48:52 +1000 (AEST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso93455e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 04:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778759324; x=1779364124; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rg6bmFDt84HgfdmHQ5rMQfe5qNs0Lmh5zrMOKqozbmM=;
        b=Tfmqypwnm3YS5NJaypyX6JF7UfVPaNWqRsKcEbD1TJsQK2KWCdeaWSFv3rrmOPWQyu
         uVHTP/WoGELFSAqPv6vLke4HR7h0uYihq+WmbXb0+TSqiST5xVm6SAdFEPoDTCDDUyXp
         +cG1CL94WhZWZjxTJGxagucJgnyCWQfUh86QvwCeLt6G4NS90OzhicIJgWuqTcvrMeSm
         JLTqoHVeClbXH42KvxN+3Sa/nfoIRbdR5bx4ztYpjqHqpeoOKFOd5VZEwGwLwWoMFrV+
         j4vLjG7MdsJsyP8T7Z6CNjpoxc7T1NQ8PaAt23GBbL0GnZu3gNQMw1CVuRLtXVIIB0oN
         xolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778759324; x=1779364124;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rg6bmFDt84HgfdmHQ5rMQfe5qNs0Lmh5zrMOKqozbmM=;
        b=QvHcSt4LxfcukXXTcI9GVOIQIbvlK+8wtXF+XI9I1TBUZ5wnVNC7a507PJgSqShRFF
         MvFSIdi5TwqIPj7IpQL8W4zy7X/NKzc9K07nUbpHmri5FpGh0TluCaX3BIw+dBcBOSD+
         Rhsl3QHwa+D2yNJY16ZZaeeYfSKAOH3uVpzGrm3yKJ1VNiZaRANA/zbrujG3+odPcwvy
         WvKtVpZ2DqzocsWzticB+skY8nK3PwHzPhGjwT5PjyfoRDB3YVlakep31+TE+vkXaE2M
         ktf5YxgWRSvQBfaq5FcDSsEYBFs69oYJfLkV/7wEnD0V5cXKbaaZnoaeLSxA4Si4vhVU
         5YFA==
X-Forwarded-Encrypted: i=1; AFNElJ/dd1+yuycqVPG8p5HIMaRrUsw/oE6rtSAEyiwEtsgR/beLe8zu/XB+9c+djWwQBYdwuyZi2UNVZEScd7Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyVpNAKItUeRP5gHODOlZ41Q9TxS1tOuc1NgEnNiPaBb1vGQxOU
	2LtOUFMOpmQMYn8PjVrLVaWkm3K7l6Yvv1eD3MzZ2mr7vUC2Mw5OP2uHfjlYU4Zc1A==
X-Gm-Gg: Acq92OElz66GFnjVCSr5fK/JBr94j8l8jYQObzHWyKS21JAifiZDkoJd4+cjnCP4+mk
	VY017Y9IYUh+QduGTTh7stO0aUOUDYBc1goNOsIi+80NKb9f25gdxbU+bXwatIlA9XIpDskgIIe
	CSRqSL112ltqdoV6xEQ6Y0dnuy2/Ylr5028eWw3Sa0WpVXjVDKKi/POZYJuTk+LOrzNKTfcXqKr
	qLYaFqTPl+RGmLVPUuK2IzxDqCixsnDKP/y6MC/3NzK9l51SUauyKF1r1m35ZFkqih8Y0b9ZC4E
	VTAX1OtK1b74GbokbdB+ZGmVuMcjxR1BV2BLD+0W49xDOTUKW/tPBUloObsFg0cFDHdKjplff7n
	sbjPr55nLdIIlroZRmsLQzVrxXac2cV5kX6u6ea8vMXGukFSH0FjDsty4qavI57togGekWP329s
	mWuxvToxwH2mfnXhu09MVYm0RWB9DnIF/4AOlS/J9ycO2GLLodCn8NZny60qborAfnU0I=
X-Received: by 2002:a05:600c:a30a:b0:475:d905:9f12 with SMTP id 5b1f17b1804b1-48fd6bcf0b7mr839965e9.4.1778759323668;
        Thu, 14 May 2026 04:48:43 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fdb26ac98sm47844535e9.2.2026.05.14.04.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 04:48:42 -0700 (PDT)
Date: Thu, 14 May 2026 11:48:39 +0000
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
Message-ID: <agW2lzJI-20DyJVe@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <20260513172450.GR7702@ziepe.ca>
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
In-Reply-To: <20260513172450.GR7702@ziepe.ca>

On Wed, May 13, 2026 at 02:24:50PM -0300, Jason Gunthorpe wrote:
> On Wed, May 13, 2026 at 02:27:14PM +0000, Mostafa Saleh wrote:
> 
> > > +		/*
> > > +		 * if platform supports memory encryption,
> > > +		 * restricted mem pool is decrypted by default
> > > +		 */
> > > +		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
> > > +			mem->unencrypted = true;
> > > +			set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
> > > +					     rmem->size >> PAGE_SHIFT);
> > > +		} else {
> > > +			mem->unencrypted = false;
> > > +		}
> >
> > This breaks pKVM as it doesn’t set CC_ATTR_MEM_ENCRYPT, so all virtio
> > traffic now fails.
> 
> How will pKVM signal what kind of memory the DMA needs then?
> 
> Does it use set_memory_decrypted()? How can it use
> set_memory_decrypted() without offering CC_ATTR_MEM_ENCRYPT ?

pKVM (hypervisor) doesn’t signal anything.
The VMM when running protected guests will use restricted dma-pools
for emulated vritio devices in the guest, which gets decrypted by
the guest kernel and hence shared with the host kernel, and then
traffic is bounced via the pool.

It’s also worth noting that bouncing here isn't just about visibility.
Because memory sharing operates at page granularity, bouncing sub-page
allocations through the restricted pool prevents adjacent, sensitive
guest data from being exposed to the untrusted host.

> 
> > Also, by design, some drivers are clueless about bouncing, so
> 
> Oh? What does this mean? We take quite a dim view of drivers mis-using
> the DMA API..

Maybe clueless is not the right word, I mean when virtio drivers use
the DMA API they don’t know whether it’s going to bounce or not as
that is decided by dma-direct (and in other cases by dma-iommu,
but not for pKVM).

> 
> > I believe that the pool should have a way to control it’s property
> > (encrypted or decrypted) and that takes priority over whatever
> > attributes comes from allocation.
> 
> We should get here because dma_capable() fails, and then swiotlb needs
> to return something that makes dma_capable() succeed. Yes, it should
> return details about the thing it decided, but it shouldn't have been
> pre-created with some idea how to make dma_capable() work.

That sounds neat, but at the end we have force_dma_unencrypted() in
dma_capable() which is just hardcoded to true/false by the platform.
How is that different from having the state static by the pool?

> 
> If dma_capable() can fail, then swiotlb should know exactly what to do
> to fix it.

dma_capable() returns a bool, I don’t think it can know what exactly
went wrong (based on address, size, attrs, dev...)

> 
> If pkvm wants to use the hacky scheme where you force a swiotlb pool
> configuration during arch init with force swiotlb that's a somewhat
> different flow and, sure the forced pool should force do whatever it
> is forced to.
> 
> But lets try to keep them seperated in the discussion..

While we can debate the aesthetics of the setup , this is
the exisitng behaviour for Linux, which existed for years
and pKVM relies on and is used extensively.
And, this patch alters that long-standing logic and introduces
a functional regression.

We can address this by either adjusting this patch or by changing
pKVM guests to be more aligned with other CCA guests which is
something I have been wondering about if it would help reduce
bouncing.

> 
> > And that brings us to the same point whether it’s better to return
> > the memory along with it’s state or we pass the requested state.
> > I think for other cases it’s fine for the device/DMA-API to dictate
> > the attrs, but not in restricted-dma case, the firmware just knows better.
> 
> The memory type must be returned back at some level so downstream
> things can do the right transformation of the phys_addr_t.

Agreed, I believe that will be needed at least for
SWIOTLB/restricted-dma -> dma-API interactions.

> 
> One of the aspirational CC things that should work is a T=1 device
> tries to DMA from a decrypted page, finds the address is above the dma
> limit of the device, so it bounces it with SWIOTLB to an encrypted low
> address page and then the DMA API internal flow switiches from working
> with decrypted to encrypted phys_addr_t.
> 
> If we can make that work then maybe the flows are designed correctly.

Mmm, I am not sure I understand this one, shouldn’t the device also be
notified about the switch in memory state, if it expects to read/write
decrypted memory, how would that work if the kernel changes it to an
encrypted one?

Thanks,
Mostafa
> 
> Jason

