Return-Path: <linuxppc-dev+bounces-25618-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD65C2A09B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 18:14:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGsjT3wnnz3c7d;
	Sat, 08 Aug 2026 04:14:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786126445;
	cv=none; b=aDTVqbmH8ETEnclViHv8mn5BAFp15cpr1mVsCs0ipYzxmIOnl4OjwidBKem/bi+iRQGl55TpDyPeYwpShvFgz/quGdSt1sXgAyVKOBpyiUD4mHISiTPew1cd0LzJpQTr3JXql9c/4k/bPM9JUPHajn5n4wdqRMFGNudA/lyZI4bdqzTo6cbTDiiDERvi7p+MFHd/Hm8vdQwJHC6TpE3X20O24AFJa4U1Vnatrk4zDvwt3vkVIWceJSqNbR0DAJ5I++9kIWZhLGV7aW+jECu1LJVyDNvfXNCX1H+AZUpjXHzNfasAX+aZ8v+07wFVcZoRBNp1grDvh/9EmCAdVPjYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786126445; c=relaxed/relaxed;
	bh=NlmgqKiyqc7mU7pAn/JSXJE8TLhKwTlI/zLMMe65kC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKYuHW9C+ySBXFTGhrCTqxSAnDnQOrSnAgAAdb/brizDcM/w/zKhMgOlEYdXmtfauHfczmxVbzLeZbiLC3bWPnOxeSISBN5nmpZSvSPTVN/godnzrhLei41Q47uEUzoJhdeG/3B62ACOSBFUdWDuxa1/nSzQUeuXdgdxJyFqfdRrI7P2fQkv2qsSPPxq/J2wZ6fsE8dpJrCK/UvpF/O18WhLPsgbb8461mFJPKSVgJeLGAtrn4HQMTazjQHq79GcIy1j9jrVpf4PqdShVruleCJrNfX6JA0x85Gg1MGegzQRXI1d+xVxS7zjOJv8vuS95dA+o2t7OZq6gZnXW3D8nw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tDxXMeZq; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tDxXMeZq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com; envelope-from=smostafa@google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGsjR3m5Kz3c7S
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 04:14:03 +1000 (AEST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so795a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 11:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786126438; x=1786731238; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NlmgqKiyqc7mU7pAn/JSXJE8TLhKwTlI/zLMMe65kC4=;
        b=tDxXMeZqEb/8bAwf9Ull4m1VBa0B5BYwKTxFd4Cj1gvA9bKnLCEpvrLDc+jPliD9Kc
         Ab5qFTNxSYcC+lSxokn2Ko53jMMbG96QySwvyBA/y07kFdSW9amqVq7w+u2bj7SmNPO8
         XGihOQo1ympmohuTu2JycjH1nnF5Dvx0BXlGFg9ylsvThKQgs9eDu1gxrDhj5VGjWzO6
         me7Cza0xmDY2ATQVfUFot4lb83/IC8ZEDtVRLX+25qzDMIQ0Md3ngDbCOErdlAcgzsPN
         8oMITTsSB55Qq08+ILRsk+1UCZNJca5wZCVISmVsSLuGJM4uiwOhVZvpDFHFKTzeqfNY
         3iwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126438; x=1786731238;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NlmgqKiyqc7mU7pAn/JSXJE8TLhKwTlI/zLMMe65kC4=;
        b=fUGyUvUDYZOySsdJyfVW3O6GebZEWb478EEtcUjqYAydrPOSKHKkxzLHw54PB7yArA
         mW8ip25W8/ZAL1KJ3dKgL3loHejelolkLe1C7XTPTLaYpew65cHLrPNwPEzonHKPOAAl
         yIifiwZcl9rY5KMRFKFA4c5EVj6R5B/klvAv0Wu1M1sILpHJi8ljm1x28X9F3M/FsAbW
         0wFMxRu11ZiT4E+yJR79Y+b0xMLt4mLGIIVW60BYjUgjB7+egUFGf7iAVBQeT3xLkwXm
         EFU2OexkMimZFzO3zmfrnxsU6zRg9E3RPqAJ7pmOXTOFgxyP2mRczJgCNJyKugfy9u5b
         K4lQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr2As6/3VLZztEeYx2o2dSx31ueMrXgA0dz+xF671FS3ZyQIoa872udF8dB3UBzd/emiD6vVlO5CPqr/ik=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyVp+gq0RmCQ1kmHPvfIJAgQCCntp5tBGI0Enrx0DUItkVivoqa
	emEVNdeIFxMtmi3skv6HPzvzqSclN2k7qDXFw9pxmeeLE3SN8NTiQNkvmYMd74gAFw==
X-Gm-Gg: AR+sD11RMSPjc5SR5URCfkfT1KzWjTbwrPIIrtlcZG/CcEVHFJk0h0kFzHfID+vv8xz
	L3MjfmrR8bJzxGJk7G3+MJukYPRJn58iZXkIx+GrrwJvQuv1dXYvr9VRIgafuQHHxq5k5dwVwhj
	I1YSJo6P4J5hw5IuG5McuvH83ypqtjbnd0rz31gkBMO88varxUeGkjEp7u04uSK4VLjT1a5RjYl
	JLJWm6sBP9BIBjf5rgGwQaTuTzDKh2fioBo+A9VKecKizStOLvALPxv6aPNYTuUWzT35gtaQIJ7
	zAZtDULpixOzgDTode8ZJ9Dl5WDy/885O9XG0QAEgYTBOivqwckGFpcPeTAeUZB1pOTvRhR5Qr/
	ktRmxVB7V9DK+RDSwVksqkUqx4DTAzKKJ7rmh3iUc0Qp9jq98TfnVtQ2uUcPEXUA6rezUoLrp9t
	KT6RIQ/o3vejRr+/1npbYqNv7SZQXoh3u/F+iLckKLfgmPZMP6UTJ5kgVdP0T32DzDAI/H5LQBl
	Depy0q63EFEz0el7GEpIiuMjEL+sg==
X-Received: by 2002:aa7:ce06:0:b0:6a1:f26c:ae2d with SMTP id 4fb4d7f45d1cf-6a1f4f438f9mr5439a12.6.1786126433777;
        Fri, 07 Aug 2026 11:13:53 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080ab446bsm79186966b.27.2026.08.07.11.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:13:52 -0700 (PDT)
Date: Fri, 7 Aug 2026 18:13:49 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
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
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected
 guests
Message-ID: <anYgXSR4VAi3TpOj@google.com>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
 <20260807092612.2202005-1-aneesh.kumar@kernel.org>
 <anXIZSh9lq99VG9X@willie-the-truck>
 <yq5acxvu2ict.fsf@kernel.org>
 <anXbJ2O4DWgPxCeg@willie-the-truck>
 <20260807135810.GA200537@ziepe.ca>
 <anX7F7dnKOtAOIIe@google.com>
 <20260807164734.GE200537@ziepe.ca>
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
In-Reply-To: <20260807164734.GE200537@ziepe.ca>

On Fri, Aug 07, 2026 at 01:47:34PM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 07, 2026 at 03:34:47PM +0000, Mostafa Saleh wrote:
> > On Fri, Aug 07, 2026 at 10:58:10AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Aug 07, 2026 at 02:18:31PM +0100, Will Deacon wrote:
> > > 
> > > > > I was under the impression that there is a possibility of using swiotlb
> > > > > instead of restricted-dma-pool with pKVM.
> > > > 
> > > > Yes, that patch enables swiotlb as a possibility for protected guests
> > > > but with your patch we avoid shrinking the swiotlb buffer even when
> > > > restricted dma pools are being used and that's a waste of memory.
> > > 
> > > I also thought we switched pkvm to use CC-like swiotlb as part of the
> > > alignment in this rework? Mostafa ?
> > 
> > Yes, now protected VMs can use the SWIOTLB for bouncing. However for
> > Android (and kvmtool), use restricted DMA. so SWIOTLB is not used.
> 
> Oh? Why?
> 

The patches are not in Linux yet, when it eventually lands in Android
it should be possible, I did some initial assessment and did not
see any regressions.

> > However, I do not think we should over engineer this in the code,
> > swiotlb can be set from the cmdline and now through Kconfig also.
> 
> That's fine for android, but real users buying a cloud VM and sticking
> a distro on it shouldn't be expected to have to mess with cmdline just
> go get a halfway working system

But the whole thing is best effort anyway, the kernel picks
IO_TLB_DEFAULT_SIZE which does not depend on the system topology or
how many devices or how much DMA they do.
SWIOTLB memory is wasted if unused so we should be careful around
that as it would be the other way around and users would have to
decrease it manually.

Thanks,
Mostafa

> 
> Jason

