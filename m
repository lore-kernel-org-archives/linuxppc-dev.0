Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D92160A2601
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 04:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Szc8bvtd
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHM4D6KJYz2y2B;
	Sun, 01 Nov 2026 15:17:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793506636;
	cv=none; b=EEOVB9TIC/uuZ5ZNH0uH+NEGCMP6z8TwEXuUFsbS9NRGYJMi8W0t03X6rFE7E/KRSoRfj0CwFuxXTF5+PE0R/p4ixw/BI/bSRV3L9jbqUEIZDv+AdxoQF3yEZIpEP4w9pXPXBMB5uneV1ZhSrBRcpsB10TNEtLwdHnGYB6p6nLQRbQc6NZzmGchttneqy8amTugQ9GoZ3eK5fzX/GrZTRH7Jfl6A37Z1WZUHwdRRN07YV/9iSF7dSmbh3gtt0lei7yopi1GqgXWNGON8AvpAxdVnd+bYntgoDXHyaj6AlFyBXdhUJls1rZ69GCUYrS8lnaGJpOwE3N1JrEVT15ATKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793506636; c=relaxed/relaxed;
	bh=mUqu+6HsBuPxnZ0xvfhrdFnRGtvir4qjhgMAVr4T9Ko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oeyPlzFywUQSSLPfrD+7VELf8vyWLEAdXQFHcfpeS/lIGzSsVd0/nohqHZY+JbWmV50RrXwapLki10wSa2ZCQT+/1KVACNaTJwALdt4fHNnpIXsGCWvzze8FJSffcwXIVUFgACys7gyNxJVqh9sJHXfn88lsSNF/i9m5hE9VMNCXsenWuXJo/2Y3UzhbIrnBbZsG5P6R+L4TqPSCLSJtcfNairfQLmv/EcQv41528MBQF1vHa97OXOzhenb5z1LfwGat0pe/uJWdrq1s6FK+uxCz07lbJoQZHloiegwaVW0MPoXhPPFNNry8kHe2pD3bsdG+qGfOwaK8nSAmeugKyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Szc8bvtd; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Szc8bvtd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHM4C6x1nz2xQs
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2026 15:17:15 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B672A4095F;
	Sun,  1 Nov 2026 04:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3681F000C1;
	Sun,  1 Nov 2026 04:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793506633;
	bh=mUqu+6HsBuPxnZ0xvfhrdFnRGtvir4qjhgMAVr4T9Ko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Szc8bvtdgyfePD3Lcy+welmLY8PIM/MtSN+SWIMLPjyxSAUjFYbtzX/kg/Gk5W6ob
	 AYPG16F5BppYWK28ekq6B4oHkbVsa+lhdlIX9kk2K7luf1zP8bvyIiQlN7cxKLefnz
	 AoI6Ac242CTEeqI3aifav4i4kabOUAzpWrpQTkliA8ZqivaSs5YfaonNvidpfoWMJa
	 6jPJ8xnrDXxGgY7hl5m0qHxKAk5XJempL3eDIBY50vaX+CFknAYUnPM1R+RrTcypkl
	 ukEcKPlOK+p0kKrGynfvdOLrmP1tOsJWpENln+kYeylBrjzAxWzp/+bUv9vsW/XkIc
	 9w+/Glq+JuypQ==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Kohei Enju <enju.kohei@fujitsu.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v6 6/8] dma: swiotlb: Centralize memory-encryption pool
 sizing
In-Reply-To: <auR0fT1yrKQ9wbm8@FCCLS0092175.localdomain>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
 <20260924060756.1325156-7-aneesh.kumar@kernel.org>
 <asVs3doaJ4WrT3M2@willie-the-truck> <asYZFXGyafRjjBS0@arm.com>
 <asYiOgskwi8JYLe_@willie-the-truck> <yq5awlrt3dwo.fsf@kernel.org>
 <yq5av77c92oo.fsf@kernel.org> <aseRzPshcoys7AJS@arm.com>
 <yq5ao6d48dqr.fsf@kernel.org> <auR0fT1yrKQ9wbm8@FCCLS0092175.localdomain>
Date: Sun, 01 Nov 2026 09:47:05 +0530
Message-ID: <yq5a8q3d9oe6.fsf@kernel.org>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Kohei Enju <enju.kohei@fujitsu.com> writes:

> On 10/08 20:02, Aneesh Kumar K.V wrote:
>> Catalin Marinas <catalin.marinas@arm.com> writes:
>> 
>> > On Thu, Oct 08, 2026 at 11:03:27AM +0530, Aneesh Kumar K.V wrote:
>> >> Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:
>> >> > Will Deacon <will@kernel.org> writes:
>> >> >> On Wed, Oct 07, 2026 at 11:04:05AM +0100, Catalin Marinas wrote:
>> >> >>> On Tue, Oct 06, 2026 at 10:49:17PM +0100, Will Deacon wrote:
>> >> >>> > On Thu, Sep 24, 2026 at 11:37:54AM +0530, Aneesh Kumar K.V (Arm) wrote:
>> >> >>> > > @@ -496,7 +516,8 @@ swiotlb_select_pool_policy(unsigned int flags)
>> >> >>> > >  	if (swiotlb_force_disable)
>> >> >>> > >  		return SWIOTLB_POOL_NONE;
>> >> >>> > >  
>> >> >>> > > -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>> >> >>> > > +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
>> >> >>> > > +	    !restricted_dma_pool_present)
>> >> >>> > >  		return SWIOTLB_POOL_CC_GUEST;
>> >> >>> > 
>> >> >>> > I think this check on the restricted DMA pool is too general -- the pool
>> >> >>> > could be tied to a specific DMA-capable peripheral and so treating its
>> >> >>> > presence as a global property isn't right.
>> >> >>> 
>> >> >>> I agree it's a hack but that was the simplest way to avoid the pVMs
>> >> >>> getting a bounce buffer after this patch. More than happy to leave it
>> >> >>> out and reduce the buffer on cmdline or we come up with some better
>> >> >>> heuristics.
>> >> >>
>> >> >> Hrm, that does mean that reverting just this part will regress pVMs
>> >> >> because they'll suddenly be allocating a tonne more memory for an
>> >> >> entirely unused swiotlb buffer. So I think I'd prefer to drop the entire
>> >> >> series until this has been worked out properly.
>> >> >>
>> >> >>> Another option could be the arch code passing another flag that it
>> >> >>> doesn't want an encrypted pool (e.g. when running in a pKVM guest) but I
>> >> >>> don't particularly this either. The arch code doesn't know whether
>> >> >>> there's an alternative pool.
>> >> >>
>> >> >> At that point, the default size may as well be driven by the
>> >> >> drivers/virt/coco driver.
>> >> >>
>> >> >>> That said, such heuristics should have been a separate patch to make it
>> >> >>> easier to review/drop.
>> >> >>
>> >> >> I think the only right way to get a semi-accurate heuristic is to take
>> >> >> into account the set of dma-capable devices that will use the swiotlb
>> >> >> pool, but that's fiddly and should probably be tackled as a separate
>> >> >> series. Maybe a simpler hack in that direction would be to take the
>> >> >> SWIOTLB_POOL_CC_GUEST if _any_ device is going to use swiotlb? You'll
>> >> >> run into the usual problem of not being able to tell if a device is
>> >> >> DMA-capable or not, but you could probably look for a global restricted
>> >> >> DMA pool and, if that doesn't exist, check for per-device restricted pools
>> >> >> on dma-coherent devices (since restricted DMA isn't supported by ACPI) as
>> >> >> a reasonable approximation.
>> >> >
>> >> > So, something like this?
>> >> >
>> >> > 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
>> >> > 	    swiotlb_cc_guest_needs_default_pool())
>> >> > 		return SWIOTLB_POOL_CC_GUEST;
>> >> >
>> >> 
>> >> Detecting a DMA-capable device is not straightforward, and if we get it
>> >> wrong, we will enable SWIOTLB_POOL_CC_GUEST unnecessarily. Would the
>> >> code below be a reasonable approximation of what you suggested?
>> >> 
>> >> Another option would be to make swiotlb_cc_guest_needs_default_pool() a
>> >> weak function that architectures can override. arm64 pKVM could then use
>> >> a different scheme (for this patch series default to false). Would that
>> >> be preferable?
>> >
>> > Even the rmem check for each device is still a hack that may bite us in
>> > the future (private devices for example would not need swiotlb). I'm
>> > thinking more and more of leaving the sizing an arch-specific decision,
>> > don't bother generalising it at all.
>> >
>> > On pKVM vs CCA guests, there's really nothing specific here to pKVM
>> > guests. The only difference is that confidential guests that so far have
>> > run without a swiotlb buffer will regress if their memory is tight. For
>> > confidential guests without dedicated rmem (either CCA or pKVM), I think
>> > our options are either command line swiotlb sizing or dynamic swiotlb.
>> >
>> > Could you respin your series while leaving out the generic sizing? IOW,
>> > no x86 code generalisation. We can discuss the best strategy on sizing
>> > later (I haven't checked how much of this series still makes sense
>> > without the generic sizing).
>> >
>> 
>> It would mostly consist of the first three cleanup patches, followed by
>> three patches that replace the addressing_limit argument with flags.
>> 
>> #define SWIOTLB_VERBOSE	(1 << 0) /* verbose initialization */
>> /* Initialize a pool for devices with limited DMA addressing. */
>> #define SWIOTLB_INIT_ADDRESSING_LIMIT	(1 << 1)
>> /* Initialize a pool that requires architecture remapping. */
>> #define SWIOTLB_INIT_REMAP		(1 << 2)
>> /* Initialize a pool for DMA to memory-encrypted host or guest memory. */
>> #define SWIOTLB_INIT_MEM_ENCRYPT		(1 << 3)
>> /* Initialize a pool for unaligned kmalloc bouncing. */
>> #define SWIOTLB_INIT_KMALLOC		(1 << 4)
>> /* Do not initialize a pool unless SWIOTLB is explicitly required. */
>> #define SWIOTLB_INIT_DEFAULT_OFF		(1 << 5)
>> 
>> This results in the large change below. I'm not sure we want to do this
>> for no real benefit other than making swiotlb_should_init() slightly
>> easier to follow.
>> 
>> static bool __init swiotlb_should_init(unsigned int flags)
>> {
>> 	if (swiotlb_force_disable)
>> 		return false;
>> 
>> 	if (swiotlb_force_bounce)
>> 		return true;
>> 
>> 	if (flags & (SWIOTLB_INIT_REMAP | SWIOTLB_INIT_MEM_ENCRYPT)))
>> 		return true;
>> 
>> 	/* Explicit requirements override an architecture's default opt-out. */
>> 	if (flags & SWIOTLB_INIT_DEFAULT_OFF)
>> 		return false;
>> 
>> 	return flags & (SWIOTLB_INIT_ADDRESSING_LIMIT | SWIOTLB_INIT_KMALLOC);
>> }
>>  [...]
>
> Hi Aneesh,
>
> I can reproduce the CCA regression discussed in this thread:
>   https://lore.kernel.org/all/yq5azeyxyfol.fsf@kernel.org/#t
>
> The guest runs out of SWIOTLB slots, causing disk I/O to fail and
> preventing the guest from booting.
>
> I would like to test the fix on real CCA hardware. Could you please Cc
> me when you respin the series? I follow LKML, but I may still miss the
> posting by chance.
>

The conclusion was to either use CONFIG_SWIOTLB_DYNAMIC or swiotlb kernel command line
option

-aneesh

