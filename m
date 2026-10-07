Return-Path: <linuxppc-dev+bounces-28991-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BD4CA5FF1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2026 11:14:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j09Vm6v02z2yK7;
	Wed, 07 Oct 2026 22:14:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791371648;
	cv=none; b=cmWdrFa2APNhKaHIUZ+6ifpp8yD3HXhpVEJ+dYQLI+EH823MtFDb83ZVyqjqeF0cXQQRluy66K4higki878C8XZs/L7HGs36iCI7e3v5Q2YjhPd+fl3pAbalI3Tl5rmI70Mhrz5qMp7G93+Y6i/3sO4Dv4jKRzHId5AEOPBXNNdxPsbTdd7Nuk2UL4Y0eW8RYHJmyPR9VncN/oxgZFeh373y0K/HKyc9AgfR2CAlNWJ4oAlttGTz8ST8fafcF1x50Q8yIRzv+cDRHZLX4Tnd+4LVcF8jCnaDK//kP0erK51yiERA4cq4mt7Rg0qiOK3lmqZTS4qhAXeIr4BnMznHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791371648; c=relaxed/relaxed;
	bh=UcXauvZbSIH4pJsW+Km/WUaiLCwRvQn0NhQBabkdWFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVPxqU0qdnEO48xddtb49zE0/RI54mp7TBNKSF6ZeCfJadBCVsI6b/rXKDOdmKzbdXwS5AlaPc7k7aFPzisrR8vUIoA+r4K8z7EaRot3odvMyNQBQ2hIKcE8x2cvPPo9oC+YTCQTce6Wjp1MwBWagyKQcSNSVOY+T6ErxGkfHTa6FZ9kHA2r/PUxBY3A8IDxybJfGsNPfcYqGw0gtfBSYjbtZfC581oJTrc6svZDgRZ8o6sxBaGlt5uhY7csPXJIWnT8T+F+bJb3jBoqIFqSCZBrmTxFmdxrKSuAJaJKSZWi5OgZO8oIp/AJSxkYyNzMplCbQcJCDZ3fX/KGH+Lmlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=igUveoCg; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=igUveoCg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j09Vj5HS0z2y8r
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2026 22:14:03 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72249152B;
	Wed,  7 Oct 2026 04:13:27 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 582333F66F;
	Wed,  7 Oct 2026 04:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791371610; bh=XkPVGrUWVDU6Wer3sPwtuoNfUx3GZi0QoXy/izLzVhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=igUveoCg91F1QZl6TCWGQXum8trlGIS+yJnnGXsR+anmFKmTZ1B9TBQsyFhsbvTr3
	 8LWHLfx0Csp/j+Uam2n55lceRPr9TQ6wTKf+Lwm9q7pLVb3aBVKndMODvi3zPKvm0V
	 t+PIIdBd0ff3Gzs8GCEjofEnDKdb1Cf+a6Zffw4w=
Date: Wed, 7 Oct 2026 12:13:20 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v6 6/8] dma: swiotlb: Centralize memory-encryption pool
 sizing
Message-ID: <asYpUPVTw2W-cR3w@arm.com>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
 <20260924060756.1325156-7-aneesh.kumar@kernel.org>
 <asVs3doaJ4WrT3M2@willie-the-truck>
 <asYZFXGyafRjjBS0@arm.com>
 <asYiOgskwi8JYLe_@willie-the-truck>
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
In-Reply-To: <asYiOgskwi8JYLe_@willie-the-truck>

On Wed, Oct 07, 2026 at 11:43:06AM +0100, Will Deacon wrote:
> On Wed, Oct 07, 2026 at 11:04:05AM +0100, Catalin Marinas wrote:
> > On Tue, Oct 06, 2026 at 10:49:17PM +0100, Will Deacon wrote:
> > > On Thu, Sep 24, 2026 at 11:37:54AM +0530, Aneesh Kumar K.V (Arm) wrote:
> > > > @@ -496,7 +516,8 @@ swiotlb_select_pool_policy(unsigned int flags)
> > > >  	if (swiotlb_force_disable)
> > > >  		return SWIOTLB_POOL_NONE;
> > > >  
> > > > -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> > > > +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> > > > +	    !restricted_dma_pool_present)
> > > >  		return SWIOTLB_POOL_CC_GUEST;
> > > 
> > > I think this check on the restricted DMA pool is too general -- the pool
> > > could be tied to a specific DMA-capable peripheral and so treating its
> > > presence as a global property isn't right.
[...]
> > That said, such heuristics should have been a separate patch to make it
> > easier to review/drop.
> 
> I think the only right way to get a semi-accurate heuristic is to take
> into account the set of dma-capable devices that will use the swiotlb
> pool, but that's fiddly and should probably be tackled as a separate
> series. Maybe a simpler hack in that direction would be to take the
> SWIOTLB_POOL_CC_GUEST if _any_ device is going to use swiotlb? You'll
> run into the usual problem of not being able to tell if a device is
> DMA-capable or not, but you could probably look for a global restricted
> DMA pool and, if that doesn't exist, check for per-device restricted pools
> on dma-coherent devices (since restricted DMA isn't supported by ACPI) as
> a reasonable approximation.

Yes, I think that's reasonable. We'd need to drive this from the arch
code or, as you suggested, drivers/virt/coco rather than generic
heuristics in the swiotlb code.

-- 
Catalin

