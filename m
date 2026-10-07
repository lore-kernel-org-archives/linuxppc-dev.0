Return-Path: <linuxppc-dev+bounces-28993-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE574CA5FF1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2026 12:15:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0Bsr71Ljz2yYd;
	Wed, 07 Oct 2026 23:15:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791375344;
	cv=none; b=GCO0bMoAs7AELfAbXMaVTH1K5JS4f1pE0a5vI/QtHhiR9LRAaH5d3/NQgfd2HbYi1S5r3L3vj5BYji5QFm01ToxExyU3vkt/1VqfBp72MhspdQjjAcrteXFRLJOgseV7yB0B9MsI1kn5KhSjwCnQEj0G8e9m40H0A4UWnXw4sqcvkqAPms+WgBoXp62JmfswljOOOl3+fiIAu27Ze97ame+27l8+2M1JYwAqalxKzDMw+57B3OMMcWJ+GKGaeMWDe00xrbJYsWWf+QcKigJQiGm+Q1R5f+XqdXpfdL6B5/wHsCEOu9u0CDicT8WzaIMxmf3+5NJnChQnT2tZWTyhxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791375344; c=relaxed/relaxed;
	bh=THCKMx4ZCnm8mOHpovi4eI/Rqy36KGJtBfYIVu2eZq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BkMLN0k+XMGSCZ+uefjfP6Fuzp/9ZzXk/QiqOPM/Zzwxi77TkaHddADWaoufN0z8O1saU6JQe3pgbJA6u4OK7k1i/pMBOSypGb0sbInlPEKDfF/GFY5fcGnzDF5Iku0yEZjBqHD0NbmCgBKr5z4GyDj2Ap84it9G5j+Cr3/9+aqrrnif+YRMbekrgOilTR4vcv4DFKZ5mWJ85Bu6JYSQqXxxFnm7EmCqvOBs1yeBpqewhJcWdb0k1KG/D4qjfCk6+XtV9f27KxP0nU8Ndhb5P/HTGpNmYT0TF9M04eKCuvulOcl43YNmDpkDGVjjVztJ8IGzeur6uUbgkTooC4TLuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bfl8aja+; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bfl8aja+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0Bsq544Bz2yVM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2026 23:15:43 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 30AC24136F;
	Wed,  7 Oct 2026 12:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E961F0089B;
	Wed,  7 Oct 2026 12:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791375339;
	bh=THCKMx4ZCnm8mOHpovi4eI/Rqy36KGJtBfYIVu2eZq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Bfl8aja+VSRTna257B4Gm2/By+1W2Nv4TQy25TzrHnAFX8A1jdDrmXdZ3WzgIyzp8
	 jBTkfVwJtKCnodEsgOCFyt/BfpUeE6IZHCbxRI9zna/h0rF0LbfWDm9i4r2aHrawGI
	 IGfikya6X0AbG64Zsqz5emGEUelpLSovqtyGoPLiIVKkvcZkkrJMeSGpIXUcZvpiUG
	 mO1yAEOlwfQ1bj2VR8aFJGvRCIWlqYxiNFzVrp24UHu7ugy8E3RDe8t8FmvS7Zeixg
	 2pF40rwJ7JSNIgBhu+4qSL0O0WS2aBAOGN6PLwSVDSRzDWBbTgQlO/Dl8ONXKChE5p
	 yOivzKvQiEetQ==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
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
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v6 6/8] dma: swiotlb: Centralize memory-encryption pool
 sizing
In-Reply-To: <asYiOgskwi8JYLe_@willie-the-truck>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
 <20260924060756.1325156-7-aneesh.kumar@kernel.org>
 <asVs3doaJ4WrT3M2@willie-the-truck> <asYZFXGyafRjjBS0@arm.com>
 <asYiOgskwi8JYLe_@willie-the-truck>
Date: Wed, 07 Oct 2026 17:45:19 +0530
Message-ID: <yq5awlrt3dwo.fsf@kernel.org>
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
Content-Type: text/plain

Will Deacon <will@kernel.org> writes:

> On Wed, Oct 07, 2026 at 11:04:05AM +0100, Catalin Marinas wrote:
>> On Tue, Oct 06, 2026 at 10:49:17PM +0100, Will Deacon wrote:
>> > On Thu, Sep 24, 2026 at 11:37:54AM +0530, Aneesh Kumar K.V (Arm) wrote:
>> > > @@ -496,7 +516,8 @@ swiotlb_select_pool_policy(unsigned int flags)
>> > >  	if (swiotlb_force_disable)
>> > >  		return SWIOTLB_POOL_NONE;
>> > >  
>> > > -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>> > > +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
>> > > +	    !restricted_dma_pool_present)
>> > >  		return SWIOTLB_POOL_CC_GUEST;
>> > 
>> > I think this check on the restricted DMA pool is too general -- the pool
>> > could be tied to a specific DMA-capable peripheral and so treating its
>> > presence as a global property isn't right.
>> 
>> I agree it's a hack but that was the simplest way to avoid the pVMs
>> getting a bounce buffer after this patch. More than happy to leave it
>> out and reduce the buffer on cmdline or we come up with some better
>> heuristics.
>
> Hrm, that does mean that reverting just this part will regress pVMs
> because they'll suddenly be allocating a tonne more memory for an
> entirely unused swiotlb buffer. So I think I'd prefer to drop the entire
> series until this has been worked out properly.
>
>> Another option could be the arch code passing another flag that it
>> doesn't want an encrypted pool (e.g. when running in a pKVM guest) but I
>> don't particularly this either. The arch code doesn't know whether
>> there's an alternative pool.
>
> At that point, the default size may as well be driven by the
> drivers/virt/coco driver.
>
>> That said, such heuristics should have been a separate patch to make it
>> easier to review/drop.
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

So, something like this?

	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
	    swiotlb_cc_guest_needs_default_pool())
		return SWIOTLB_POOL_CC_GUEST;

where:

static bool swiotlb_cc_guest_needs_default_pool(void)
{
	for_each_of_allnodes(np) {
		if (swiotlb_of_dma_needs_default_pool(np))
			return true;
	}

	return false;
}

I didn't quite follow the ACPI-related feedback. IIUC, on ACPI systems
we will end up using SWIOTLB_POOL_CC_GUEST?

-aneesh

