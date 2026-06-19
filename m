Return-Path: <linuxppc-dev+bounces-22825-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AB3CD98F2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 14:06:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghfXH4sfLz3bqD;
	Sat, 20 Jun 2026 00:06:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::72d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781877983;
	cv=none; b=UEmGkXYzFjIIY/AI3DBWO7TpRfR0e6vARTYiXvLbDtcPJysAnlwGelZSAGWVwzaJH7bGsDdSy1F8/qKk7LWqGHBzBmS1O7zwD4jN+J/XpLMOA+aBj+d9TFqV6zPmr5BzvJxz8PKU6eRpZh0iWGVvJqdX3/0CZo4wc3eR583WuLxIblPBC9vyNWU7e55n6ZzcKvO7H0GqmKu1WD3jUCHRkVZpFawQ2dt2ara3fedQNK25Idi19a2A+X+vyqxViqlknGXmFEb3dOoPu5cYUhtl59Tqm4P5Vism8eC0pQC8/3ujkEz/3LVHSr3dg4seguEnmVS+JIi1HPpGdqjPkU9DEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781877983; c=relaxed/relaxed;
	bh=rSB/t2vnZpwaKaBmIo7hL1ql2I4ostuStLW/up58Wu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Em2yfbbSvzTORkO9TvEAAHjBLeYlhNFhMF1f7BDdAlcJ7lbzUrzDRpQAkVq5+3HxuDLVm+XaZCXjuzROgsfMEhzi2m4WjdnbEOpDDpQFBl1UI0zg1YQMDnF7n5lFvqxiuSCBnZZq5ouF0Hr2aN5vfp4VcP7v+OQCarILoXexazVvs4ro0mnFgKs98y3WfjSa+ZD8xVsnVtqRGuydocPgfWKVB9Sm1C9EhR36NcJFqa8nqBLPTsJNuyc2KN/o0tFZ6rzRMzDmM+O22rze4ox6dpU3Vf8kvbbj+fYqgpH6qjkw4/mRVwLFeJ1YfBYs1W7/vJBHLxShXiKEOpqSpQmfUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ouggkopI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72d; helo=mail-qk1-x72d.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ziepe.ca
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ouggkopI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::72d; helo=mail-qk1-x72d.google.com; envelope-from=jgg@ziepe.ca; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghfXF2vm7z2ykX
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2026 00:06:20 +1000 (AEST)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-9158fbaa4bbso243944585a.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 07:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781877978; x=1782482778; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rSB/t2vnZpwaKaBmIo7hL1ql2I4ostuStLW/up58Wu8=;
        b=ouggkopI8Uh+Oy3ZcKhaEqUXtRsEsqGph3/Bqjy7/cwrO+i/HnE9sNPzFGVFRH823N
         zLonJKvTBbCrud9/xgN8NO69NTVmezdoA1IQXbUMmr+CEnlTco6nr2cuZW8EYY+CAGkS
         46DPL4o+LH6dcRRs/QVlcCsYprO27XcH9vqTmZMK/RXxgI4gnPSsLgdCtoFz/hIrV1ze
         CaApFyg6Ab6cv6uYKXfT0gXl3ZbOWl6wsRVORpFXrVbnSwf+e/LafmElIXR5B2Hy+sgW
         OPZt8yUel1loyEFR1qXoc2yK9E+7PeIEjBc3Z3a/+yZ9f272LCIWt51/slpihwD0LJMD
         XWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781877978; x=1782482778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSB/t2vnZpwaKaBmIo7hL1ql2I4ostuStLW/up58Wu8=;
        b=Bt0sotxgmMGTAn5LN2pcpk7doiZ9DZf2JUIMUF8troAqOYn4ZUG1OHXqty92+uwyrv
         1WzpFGPaMHY4qNWdyBmGhwH30eWeRNKU+S0gplngVS0gawPBaYh1uYxzNscmLHtg+bEH
         uTCtuWhk1aeRSUt0FuCzNthEgcTS9Oh9Xe1Z42cqd1VBNn5/k8pyKPmKDK5fVUblqUzT
         J+QAly8o3uSHEfLaXrS+7zNJ3qKUPOzhuZs2zpHld4f+93ZwJCT+uzQQdjEAhLPtUXu+
         D2Y6cG+CMuZRl27cbkjRM0qHgmg9CgF9E9M5+bt46roE1/kJPgX1ozU/NW8bNBazszh2
         QJUA==
X-Forwarded-Encrypted: i=1; AFNElJ99TiQpgbIpYyT5HEmwJF2MJM5YxxSCGx9zW6BY9CZTm0SAD3G9x0CbbMRMjJlcrqMp91g6BCzP6EuQ1Z0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzSFA183VjwAK9y4wuaYQtuT5kBTZrf+p04f5aOpgYCyCsD9bf9
	9UYyteV5MPR+xahLupMynxhWJJWsU8rxAYLcLeGZs+1buK/2+amUnMUgxY/nO841nfM=
X-Gm-Gg: AfdE7cmncbNgT9tG3vjHrLrZoncdNbYSo23pybZSyxYVdLt0EXaROnzWEHOIuIhasuL
	e+gGKNVI9ZuPff4x/eJB6G6lfauwCpDwGApRsQcTMsb+5j4FBUEHH5XC9kyQIyoGnjN0fSau0+y
	bnlan+NhLArQl3TY8CapucsZ6FPAXaivogWSHpmFPziFnyEhlgfdhwoT7SpsP6+1jAN4i2rLPnB
	+FDfygBk6T0tDQixkTPpUNF4/A7UCEj3J5N7Z0PDrLNcGEWR8IfFUVvyTTo335VKxSad1/5Tt/O
	SisrVqV/iT4rrSOCdM/Wgh4e64Zmli83b9HtCQl3keLw8UMn/imby5vXrwx3Gvj9d1V22CiO6GT
	7R4fuc60IoAhOI9zRuE+yekuSrb+l92hGAJ0jscBk8CtK+EzFZ8gUqjY28VbdEZNuXerBas9bHf
	q0kWJSU92NUlrSbw+lDnqhso4m+3vNBcSieC2fL09cKPFmcyopwre+3tbyiDe/Xq5ObWE=
X-Received: by 2002:a05:620a:6842:b0:914:ac45:a98 with SMTP id af79cd13be357-9208f6479eamr503398085a.17.1781877977966;
        Fri, 19 Jun 2026 07:06:17 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-920a142f50asm250739785a.12.2026.06.19.07.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 07:06:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1waZrM-00000004cLp-3AI9;
	Fri, 19 Jun 2026 11:06:16 -0300
Date: Fri, 19 Jun 2026 11:06:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
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
Message-ID: <20260619140616.GB1068655@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com>
 <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org>
 <20260618153705.GH231643@ziepe.ca>
 <yq5ao6h6enhm.fsf@kernel.org>
 <20260619122148.GL231643@ziepe.ca>
 <yq5aldcaejos.fsf@kernel.org>
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
In-Reply-To: <yq5aldcaejos.fsf@kernel.org>

On Fri, Jun 19, 2026 at 02:36:19PM +0100, Aneesh Kumar K.V wrote:
> >> Agreed. If the device can do encrypted DMA and requires bouncing, it
> >> should bounce through encrypted pools. We don't support encrypted pools
> >> now and that means, we mark the option ("mem_encrypt=on iommu=pt
> >> swiotlb=force") not supported for now? 
> >
> > ?? if you don't have a CC system then the swiotlb is "encrypted"
> > meaning ordinary struct page system memory.
> >
> > The hypervisor should not be triggering any CC special stuff here, it
> > is not a CC guest.
> >
> > Agree we don't need to worry about swiotlb=force with a trusted device
> > in the GUEST for now, but it should be something to fix eventually.
> >
> 
> If i understand this correctly, the setup Alexey is referring to here is
> bare metal system with memory encryption enabled and dma address doesn't
> need C bit cleared because it is handled in iommu.

This is how I understand it too, if the iommu is turned on then it can
take the high PA with the C bit set and map it to an IOVA that matches
the device's dma limit.

> ( I consider this as memory encryption that is handled
> transparently, device can access any address because that encryption
> details are now managed by iommu).

Compared to the guest side there are some important host side differences:

 - On the host the iommu can fix it because this is only a matter of
   IOVA range not access control. On a guest even a IOMMU cannot
   permit access to private memory
 - On the host the state of the device is driven by the dma limit
   which is not set until after the driver probes. On guest the state is
   set by the tsm and device security level before the driver
   probes
 - Both flows end up using pgprot_decrypted and set_memory_decrypted()
   to create their special pools, but for completely different
   reasons.
 - The memory coming from the special swiotlb pool must NOT be used by
   a trusted device on a CC guest, while there is no problem for any
   device to use it on the host.

> Thinking about this more, I guess we should mark the swiotlb as
> cc_shared only with  CC_ATTR_GUEST_MEM_ENCRYPT instead of
> CC_ATTR_MEM_ENCRYPT as we have below.

The name cc_shared should be used for GUEST scenarios only.

I guess there is some merit in keeping swiotlb using "decrypted" to
mean it usinig pgprot_decrypted and set_memory_decyped() which AMD
gives meaning to on both host and guest.

IDK what AMD should do on the host by default. I guess it should setup
a swiotlb pool of low dma addrs "unencrypted", but not "cc_shared"?

But if we are operating on the host then this pool is not limited to
only T=0 devices, every device can "safely" use it. (ignoring this
destroys the security memory encryption on bare metal was supposed to
provide)

> Now we have the case of host memory encryption where the C-bit needs to
> be cleared in dma_addr_t. That requires special handling in the kernel, and
> I believe we need to mark swiotlb as unencrypted in this configuration.

I think we need to split the two things up, they have different
behaviors and need different flags and labels to make it all work
right.

> I am still not clear whether there is a config option or runtime check
> we can use to identify this case.

The dma api has to detect, after the driver sets the dma limit, that
none of system memory is usable when:
 - The direct path is being used
 - phys to dma for 0 is outside the dma limit

Then it should assume the arch has setup a swiotlb pool for it to use
to fix the high memory problem.

Similar hackery would be needed in the dma alloc path to know that
decrypted can be used to fix the high memory problem like for GUEST.

I guess some 'dev_cannot_reach_memory(dev)' sort of test in a
few key places? Setup with a static branch to be a nop on everything
but AMD, compiled out on every other arch.

Jason

