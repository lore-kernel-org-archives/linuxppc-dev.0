Return-Path: <linuxppc-dev+bounces-23226-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF1DC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 16:18:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqSxL6yL0z2yfy;
	Wed, 01 Jul 2026 02:18:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f33"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782836294;
	cv=none; b=Cq7fRY2/uFrDN78mnZz4M+ryp2ANxzbmA4DYDz3/FpE+92T/ztZ9O25CtlqsydkkOpMpXXkCE4APOIdP/qpnKxHVgL7qfCiIHYzRAfaZcBNnvl2AHuTtEL5dTFxMIqSdxm6wk7r0RFpIZSGjFHV+hmcr/LUbm1AQH734AviWinJs1R+00qQjNqDByiYnIjtpy8FbN8sZW0PG9JDbBhnrh8Ep+9bP7rND2AKA4a9w6fZw98BLh7lKQla0KVPmOcSYD6+CekUfH7AZV6z9rf5Vk9q+JLDwjhqxUJ9StTouHAoFE502mMSffnu/5bas8bHJ8AehJSjCLRoL70VfHfZjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782836294; c=relaxed/relaxed;
	bh=rGel1rvdm2vqYO1DEls9OmTRzPQ+QRBZhk43D5aDGso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ID2/XohNuudFqzAENFOq2N+pQ3nGRYzx5E/23/EUaQBYXdJTefl9EImBW30x+QcqU8q2Ggq5rbQi7MLxN+YFT8Zvj6g80MZANmPCt9NanJ9GnLggWx0L1IBkIWjYxyL4XoRfjw1squb/RRzMfY02uBDxPp601mxi/zNe7Dd+F1bR/FkoKUZlU1juvDbffJr0kbpEp9f6d3FWfF9XEdHO0xLat93QTX9wOCA3L69jObHjfmw/YZvEZw84lpYVjkk5vENMrhoutkhBRFSNa7nL6w+/sTjSVREriq6oUMI26dkqTU2hdsJbJJcJEdT+2TqODOoKmikIIibD5ovHLls82A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=c3O0WFGZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f33; helo=mail-qv1-xf33.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=c3O0WFGZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::f33; helo=mail-qv1-xf33.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqSxJ6wNYz2yft
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 02:18:12 +1000 (AEST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-8eefd0c5f59so34154276d6.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 09:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1782836288; x=1783441088; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rGel1rvdm2vqYO1DEls9OmTRzPQ+QRBZhk43D5aDGso=;
        b=c3O0WFGZ9GhDG5ipParfzMwGmtLflh1vEYw7YyU6NBfhTW8gYzkh0Tf1lD0G1SGbY2
         pmwSyxcMsp06MwSlVNz5hZZvFz7qlk3ufkYxplbX6Rg2F1xzZXAgZiPAhDXlaH2MYSeZ
         Ou89aiMJ+8dZzoRHtNzmwYuNXpW4eY8jH1acVtxrIaEh43ZSrP3a0iMZAoZYydjPv1Qv
         /8e7/q0Bz34aKKjvowNwKoswAJToDdAe0jqIlbc1leLyzistW6Zd9+HScZeoy5zBEEac
         fvqtDZtRCSSkOXKP37c3mpyS+O35RhrrkeIVZnBMFPC/9+1c/1CIuHgTYjHCCRkBd1sd
         dz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782836288; x=1783441088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGel1rvdm2vqYO1DEls9OmTRzPQ+QRBZhk43D5aDGso=;
        b=HWMID3/v2BIn7EOLFwUZVfJCeB//dQfLerc+ZwZurMk1j+pzFZh8Rw6HRSTBSqi7Nu
         EiL4Hb4tHyAel3LuHmU3EcVSLS1JG9F3a4yctQE+MbraQF5clxUeqpi3X29Sazve64o+
         DeEOrA0ziurbbPHMiDqDSe61KbTDLmeVKNI9AlnzwsXo8Eo+LUmxn8vdPbEscyklfFQd
         SsCF46wJOtqtQQ4VFs85jJnUYPXO3ACP6IgBWFfv2k35cJxsL9QR18QFBdhuRe/OaC2T
         2WZ7nmn3LHLIh0OtIYlj5KqtY16iwweElxQEYv4aetO20+WEKidc3skSHD1n5TbdOfea
         ayMQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/9nEaBK8yaoRb3b9WbfbUwLPK66jWEmFW5/DHoT9TE+p2zetwv7hd5blXp754lcpVfp5mqOmcx2YFpKI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxhcrkjBZh3NL+GdJoL1kV1KeyFAamEYNOujf7N3aCa8J4DgLJ/
	oBMv+99/5H2c/voK5U2IYfLjKNjmyrh5Cmj+KbAYdyY9Vr+1zmd+ozXUFmTY5Eeq4jM=
X-Gm-Gg: AfdE7cmxL3gWIszBUQRIODOF0JzQbchBS5QP3fRVCkwO/2Ub9JsGOC9GjoBLX1k+KMg
	sQNloj/xw7mCCO3OyFewDmXoZI3ZYWY++ICYJ+wRk4uihpeYCcsgwIQuVbEQnfxvTo+cjWd7hV/
	GtOXZ7Q+aWOWToURN7oVHhpVVFw0JIceMeJoTPYLIPGsp/qxv2qjoAYQxZwaehIPT+8REuubB67
	IBTv7BAT3WXQYAOnmPVUitvE0IvGWS6owNC31N0q07Si1NMbP1QhG3uHWOgzIb34DbD55XJE7sx
	RODegqjvOsnmETmrgYbym69bzHpYRsfWLrAY0jqWwQKQ8DbV6utPYUnWK4iVhFPwKTzK3QwiIMP
	z9er+wAsCs5gvUjmKhlJD6QyV/VSBpJNUMRNfPa0Si0Ha0fN/AcUOPY2Aoxy0rCm9EEEhZ8oDgX
	dTNvqIYkdpqgCCeerkM7SSDuJ9+nmI3ZTCtBA0MAMcIeroOWJIZaO0KEYJJCYH5kT26og=
X-Received: by 2002:ad4:4a6e:0:b0:8f0:1b69:25d2 with SMTP id 6a1803df08f44-8f1ba1b1e7bmr44221716d6.23.1782836288213;
        Tue, 30 Jun 2026 09:18:08 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f24723defcsm15060566d6.49.2026.06.30.09.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:18:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1web9x-000000028Ii-0dcm;
	Tue, 30 Jun 2026 13:18:05 -0300
Date: Tue, 30 Jun 2026 13:18:05 -0300
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Message-ID: <20260630161805.GJ7525@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com>
 <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org>
 <20260618153705.GH231643@ziepe.ca>
 <d4ef9a9f-18d9-40e1-9d02-87aeb9cb6540@amd.com>
 <20260619120309.GI231643@ziepe.ca>
 <9f20ce61-1edd-411e-a7c3-be541fb89cb4@amd.com>
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
In-Reply-To: <9f20ce61-1edd-411e-a7c3-be541fb89cb4@amd.com>

On Mon, Jun 22, 2026 at 10:58:23AM +1000, Alexey Kardashevskiy wrote:

> > I think it was a big mistake for the AMD SME stuff to overload the
> > decrypted/encrypted CC stuff which should mean shared/private in a
> > guest context to also mean things about physical memory encryption in
> > the host. It is really confusing.
>
> It is a bit in the PTE which says "encrypted", what do you mean by overloaded?...

Encrypted meaning I'm using DRAM encryption on the host and Encrypted
meaning this page is private and inaccessible to the hypervisor are
very different things with very different requirements and is
confusing they have been overloaded in Linux :(


> > The SME side is just a bad arch choice, the real world doesn't work
> > well if you set high address bits in your dma_addr_t. I think AMD
> > needs to use those restricted swiotlb pool where it allocates this
> > very special "SME Disabled" memory that will have a low
> > dma_addr_t.
> 
> The generic __init iommu_subsys_init(void) calls
> iommu_set_default_translated() if CC_ATTR_MEM_ENCRYPT (==force the
> use of IOMMU) and eliminates the bouncing by default, pretty
> much.

Sure, I know, it is a gross solution to a self inflict error.

> We (AMD) do not really want to force Cbit in DMA handles and
> it is not happening unless "iommu=pt".

Lots of real HW won't work will because of this, so yeah you pretty
much have to. But also there is HW that is fine, like you can use a
mlx5 device and it will handle the C bit just fine.

It is pretty hacky to globally force the iommu mode because some
devices end up not working.

> > Then alloc and bouncing will get memory with a suitable
> > dma_addr_t. This has nothing to do with force_dma_unencrypted() which
> > is only a CC guest concept and nothing else in the OS should ever
> > touch decrypted memory.
> 
> True.
> 
> Although, with "iommu=pt" enabled, dma handles from swiotlb should
> not have Cbit so these swiotlb pages have to be unencrypted.

That is how it should ideall work, in this case the purpose of the
swiotlb pool is to provide low dma address memory because the device
cannot reach the normal linux dram addresses.

> As you mentioned in another mail in the thread, DMAing to
> unencrypted memory with mem_encrypt=on make no sense security
> wise. 

Yes, pretty much.

> May be enforce either mem_encrypt=on or iommu=pt is allowed at
> the same time but not both? I am worried though that some weirdo
> still has a use case for it.

Arguably it should be done per device. The problem is the iommu layer
doesn't know what the dma mask is until the driver binds so it can't
detect a device that is unable to reach any dram and switch away from
identity automatically. That would be much cleaner.

> > > I am looking for a way to set up my "sev-guest" device such as when
> > 
> > Whats a "sev-guest" device?
> 
> It is a platform device, presented in SNP VMs as /dev/sev-guest and
> the guest userspace calls ioctls on it when it needs VM attestation
> report/certificates/etc.
> 
> The sev-guest driver makes calls to the HV (GHCB protocol) to:

> 1) get report/certificates/measurements from the HV <- this is done
> via shared memory as the HV writes to it;

> 2) asks the HV to get the digests from the PSP <- this is done via
> encrypted memory (buuuut it is software encrypted and as far as the
> hw is concerned - it is shared - no Cbit, no RMP - these buffers
> contain plaintext headers of the PSP requests and cyphertext of the
> request/response body).

Ok, but here you have overloaded the word encrypted again :( Decrypted
memory containing ciphertext I think you mean

> > > dma_alloc_attrs(snp_dev->dev,...) happens, it allocates a page from
> > > the shared swiotlb pool (with no actual bouncing) and there is no
> > > obvious way to trick the DMA layer into doing that.
> > 
> > Why do you need this?
> 
> /dev/sev-guest uses only shared memory (from the HW standpoint), and
> it is normally lot less than 1MB. If hugepages are used, then today
> it allocates 4K pages (they come encrypted and likely backed with a
> 2M page), the driver converts them to shared to make that GHCB
> call. The conversion smashes backing 2M page to 4K pages (+RMP
> +IOPDE as there is possible ongoing DMA), which is a problem (I have
> mentioned it as "TMPM" before - a hw/fw helper to do the smashing).

Okay, but this has nothing to do with sev-guest at all, and should not
be solved uniquely for it.

The DMA API in general has a problem spraying allocations all over
system memory and fragmenting the RMP/GPT/etc and yes it needs a
solution, but it should be entirely in the DMA API and have no
special involvment with sev-guest. sev-guest should just make coherent
allocations and use them in the normal way.

> The idea here is that if swiotlb is already shared, the sev-guest
> could use that memory pool.

dma_alloc_coherent using the swiotlb pool instead of allocating and
converting in general is a reasonable proposal, IMHO. Again, nothing
to do with sev-guest.

Jason

