Return-Path: <linuxppc-dev+bounces-29063-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0770FCA600C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 15:33:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0vC51YS2z2yMn;
	Fri, 09 Oct 2026 02:33:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791473585;
	cv=none; b=OsgWMKG5vwTMZVRtSrnn0pocDWvJiGy06HI1bo3sYJisqUvHRJnXxTTB3nUOR1QtTkxeo9U/5aGXrjKhtNmp/Hy4GEYsjCE+7Tx8loA6YET29tQybA7MPkIJXW2Y6bnc17YvhWS63M7CK+ygSCqp/H5+Lr2mwUKZ1wpM0rzpM9Dqtc6Zq6Qyk/RaMiA1mxPgk0DHwZOrtKbOLzTnRpQhDNo1cf6/ewBdHrzhSavnP7QIprBwY5Pe/II2I2TGRm173V42+zPIui+xOOIPfnGMj2wauDG7c49/5SpfdXJewn2y0HpDASW8dFwLxFCXebWBcq77UrP8r5Jf2+NLk0i6tA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791473585; c=relaxed/relaxed;
	bh=YmUv+dVinO4DGyPfi86Rp05KJ0iKog7r1zuWIsZpoNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=NZ+GLN81Cu3vIgrEY8KFkSEup0JwiLRbFT6C97lX22EbuyDfQhXSkmB826ABlI5nrbXLHs1nFyEuSSEr/m++gA3zXTK2eLrmjdclrvy4QuUwdcsa9qDS/UC1Vl1hp7IKGMQapid3rhq8PD+mz0uG3s//BPHBBPKR5nkmEUayJegAgv/SdtMPmOJi7nQscEvfF/Th92I7rzqSDT5SZwXMJY6JLRQyK/+hbYyCHJF3R2BNPpdF7A04fo7tco406VT47mVPCLOndVV8hAGsSvF/uO9I4eadbnFZSohxB6SmAHpWHuuVkLSXCnO53yI5TcMcuI5FnVFhUCyKMsI2+LyehA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Z5UeDLE+; dkim-atps=neutral; spf=pass (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Z5UeDLE+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0vC11PZTz2y8d
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 02:32:59 +1100 (AEDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261008153249euoutp02b4a87ccc77d200f3890d561df189c3bd~cl7g7aAvm2788727887euoutp02g;
	Thu,  8 Oct 2026 15:32:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261008153249euoutp02b4a87ccc77d200f3890d561df189c3bd~cl7g7aAvm2788727887euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791473569;
	bh=YmUv+dVinO4DGyPfi86Rp05KJ0iKog7r1zuWIsZpoNM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Z5UeDLE+dZcsY3l6oA16V8qttCBxPFEJpUpwd2p2jJDN2RWsNpoMi9Gug31sE6gmX
	 xEpsLkgCQwKTVH4iIL1j1xtexJJNNydzs2KShaf9Uvr/sXk+MAVI8vVIQ+YZBs4a/f
	 zFRkjDjJ/PUKBoz2RBPEiGBJ0pC1W9GZs22YyXtc=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261008153248eucas1p144bd3391fe1a79a1d6dfcd386c4a7e94~cl7fxbUbR2862828628eucas1p1P;
	Thu,  8 Oct 2026 15:32:48 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261008153245eusmtip112c16c496ac689d363e975f151c082fb~cl7dN0sE_2339023390eusmtip1f;
	Thu,  8 Oct 2026 15:32:45 +0000 (GMT)
Message-ID: <c2e38455-cb31-4854-ab84-4a370fabc1f9@samsung.com>
Date: Thu, 8 Oct 2026 17:32:44 +0200
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
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v6 6/8] dma: swiotlb: Centralize memory-encryption pool
 sizing
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, Jonathan
	Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy
	Dunlap <rdunlap@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Marc
	Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>, Suzuki K
	Poulose <Suzuki.Poulose@arm.com>, Jiri Pirko <jiri@resnulli.us>, Jason
	Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Petr Tesarik
	<ptesarik@suse.com>, Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>, Madhavan
	Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, Russell
	King <linux@armlinux.org.uk>, Huacai Chen <chenhuacai@kernel.org>, WANG
	Xuerui <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, Andy Lutomirski <luto@kernel.org>, Peter
	Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo
	Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, x86@kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <yq5ao6d48dqr.fsf@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261008153248eucas1p144bd3391fe1a79a1d6dfcd386c4a7e94
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261008143238eucas1p1ee087352709f2a82d2aec95540ae2031
X-EPHeader: CA
X-CMS-RootMailID: 20261008143238eucas1p1ee087352709f2a82d2aec95540ae2031
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
	<20260924060756.1325156-7-aneesh.kumar@kernel.org>
	<asVs3doaJ4WrT3M2@willie-the-truck> <asYZFXGyafRjjBS0@arm.com>
	<asYiOgskwi8JYLe_@willie-the-truck> <yq5awlrt3dwo.fsf@kernel.org>
	<yq5av77c92oo.fsf@kernel.org> <aseRzPshcoys7AJS@arm.com>
	<CGME20261008143238eucas1p1ee087352709f2a82d2aec95540ae2031@eucas1p1.samsung.com>
	<yq5ao6d48dqr.fsf@kernel.org>

On 08.10.2026 16:32, Aneesh Kumar K.V wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
>> On Thu, Oct 08, 2026 at 11:03:27AM +0530, Aneesh Kumar K.V wrote:
>>> Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:
>>>> Will Deacon <will@kernel.org> writes:
>>>>> On Wed, Oct 07, 2026 at 11:04:05AM +0100, Catalin Marinas wrote:
>>>>>> On Tue, Oct 06, 2026 at 10:49:17PM +0100, Will Deacon wrote:
>>>>>>> On Thu, Sep 24, 2026 at 11:37:54AM +0530, Aneesh Kumar K.V (Arm) wrote:
>>>>>>>> @@ -496,7 +516,8 @@ swiotlb_select_pool_policy(unsigned int flags)
>>>>>>>>  	if (swiotlb_force_disable)
>>>>>>>>  		return SWIOTLB_POOL_NONE;
>>>>>>>>  
>>>>>>>> -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>>>>>>>> +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
>>>>>>>> +	    !restricted_dma_pool_present)
>>>>>>>>  		return SWIOTLB_POOL_CC_GUEST;
>>>>>>> I think this check on the restricted DMA pool is too general -- the pool
>>>>>>> could be tied to a specific DMA-capable peripheral and so treating its
>>>>>>> presence as a global property isn't right.
>>>>>> I agree it's a hack but that was the simplest way to avoid the pVMs
>>>>>> getting a bounce buffer after this patch. More than happy to leave it
>>>>>> out and reduce the buffer on cmdline or we come up with some better
>>>>>> heuristics.
>>>>> Hrm, that does mean that reverting just this part will regress pVMs
>>>>> because they'll suddenly be allocating a tonne more memory for an
>>>>> entirely unused swiotlb buffer. So I think I'd prefer to drop the entire
>>>>> series until this has been worked out properly.
>>>>>
>>>>>> Another option could be the arch code passing another flag that it
>>>>>> doesn't want an encrypted pool (e.g. when running in a pKVM guest) but I
>>>>>> don't particularly this either. The arch code doesn't know whether
>>>>>> there's an alternative pool.
>>>>> At that point, the default size may as well be driven by the
>>>>> drivers/virt/coco driver.
>>>>>
>>>>>> That said, such heuristics should have been a separate patch to make it
>>>>>> easier to review/drop.
>>>>> I think the only right way to get a semi-accurate heuristic is to take
>>>>> into account the set of dma-capable devices that will use the swiotlb
>>>>> pool, but that's fiddly and should probably be tackled as a separate
>>>>> series. Maybe a simpler hack in that direction would be to take the
>>>>> SWIOTLB_POOL_CC_GUEST if _any_ device is going to use swiotlb? You'll
>>>>> run into the usual problem of not being able to tell if a device is
>>>>> DMA-capable or not, but you could probably look for a global restricted
>>>>> DMA pool and, if that doesn't exist, check for per-device restricted pools
>>>>> on dma-coherent devices (since restricted DMA isn't supported by ACPI) as
>>>>> a reasonable approximation.
>>>> So, something like this?
>>>>
>>>> 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
>>>> 	    swiotlb_cc_guest_needs_default_pool())
>>>> 		return SWIOTLB_POOL_CC_GUEST;
>>>>
>>> Detecting a DMA-capable device is not straightforward, and if we get it
>>> wrong, we will enable SWIOTLB_POOL_CC_GUEST unnecessarily. Would the
>>> code below be a reasonable approximation of what you suggested?
>>>
>>> Another option would be to make swiotlb_cc_guest_needs_default_pool() a
>>> weak function that architectures can override. arm64 pKVM could then use
>>> a different scheme (for this patch series default to false). Would that
>>> be preferable?
>> Even the rmem check for each device is still a hack that may bite us in
>> the future (private devices for example would not need swiotlb). I'm
>> thinking more and more of leaving the sizing an arch-specific decision,
>> don't bother generalising it at all.
>>
>> On pKVM vs CCA guests, there's really nothing specific here to pKVM
>> guests. The only difference is that confidential guests that so far have
>> run without a swiotlb buffer will regress if their memory is tight. For
>> confidential guests without dedicated rmem (either CCA or pKVM), I think
>> our options are either command line swiotlb sizing or dynamic swiotlb.
>>
>> Could you respin your series while leaving out the generic sizing? IOW,
>> no x86 code generalisation. We can discuss the best strategy on sizing
>> later (I haven't checked how much of this series still makes sense
>> without the generic sizing).
>>
> It would mostly consist of the first three cleanup patches, followed by
> three patches that replace the addressing_limit argument with flags.
>
> #define SWIOTLB_VERBOSE	(1 << 0) /* verbose initialization */
> /* Initialize a pool for devices with limited DMA addressing. */
> #define SWIOTLB_INIT_ADDRESSING_LIMIT	(1 << 1)
> /* Initialize a pool that requires architecture remapping. */
> #define SWIOTLB_INIT_REMAP		(1 << 2)
> /* Initialize a pool for DMA to memory-encrypted host or guest memory. */
> #define SWIOTLB_INIT_MEM_ENCRYPT		(1 << 3)
> /* Initialize a pool for unaligned kmalloc bouncing. */
> #define SWIOTLB_INIT_KMALLOC		(1 << 4)
> /* Do not initialize a pool unless SWIOTLB is explicitly required. */
> #define SWIOTLB_INIT_DEFAULT_OFF		(1 << 5)
>
> This results in the large change below. I'm not sure we want to do this
> for no real benefit other than making swiotlb_should_init() slightly
> easier to follow.
>
> static bool __init swiotlb_should_init(unsigned int flags)
> {
> 	if (swiotlb_force_disable)
> 		return false;
>
> 	if (swiotlb_force_bounce)
> 		return true;
>
> 	if (flags & (SWIOTLB_INIT_REMAP | SWIOTLB_INIT_MEM_ENCRYPT)))
> 		return true;
>
> 	/* Explicit requirements override an architecture's default opt-out. */
> 	if (flags & SWIOTLB_INIT_DEFAULT_OFF)
> 		return false;
>
> 	return flags & (SWIOTLB_INIT_ADDRESSING_LIMIT | SWIOTLB_INIT_KMALLOC);
> }
>
> Marek,
>
> Patch 3 is a fix, so you may want to take it even if we drop the rest of
> the series. Perhaps the first three patches could be taken together?

Okay, I will take only the first 3 patches to dma-mapping-for-next branch now
and wait for the remaining patches until they gets sorted out.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


