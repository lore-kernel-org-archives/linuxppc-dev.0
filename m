Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BC9606AC11
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=YdXVsUa9
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGJ7l2btrz30Vm;
	Fri, 30 Oct 2026 22:01:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=68.232.139.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793357502;
	cv=none; b=W6sRlc+GSyY4DMlED0JVKE5enx9GUZvsYzrCkvEw9S8sy/NJjmj9kI9u3tofCQWUpZdGK+TX7g6mRIAAdCJhr0mN3TdoRdvJWSKchBzud7dVzvIYVwi07jNrTzBNF+VGh+0ZFkHBgwO7dV8JW1nVdem22iljMc5j2BaJtmC/YPwixOyv3xQHPCCgzB1mSr+PfzX37tDxK1P5CybjXmIQq/wonKe7DFwF1ketpboJKpGqzcsh+EUAB4T0D3clEsjkKMK1ZuXEQ81cbHHNe3tCT0j7zDQzf8HUa8A9TAJE2I0xP+D2NDiG4E4IF8XLDjZnnrxRwsEZL+856Z10290wLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793357502; c=relaxed/relaxed;
	bh=MZqMRfPEVUiuMNxLqgmTIf03oB0BvArhy/TSmIC7oCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiCrb/QApvqEjizkHBZ42mNqpf4Y3c9shc64jj8//k3MIjq2amV4RXu04PIK5eFgrpZhjGO7DVKkxSubrh42HiUNDcmimA/aT1UVZZEzSPSK0ghqV3AuX+v8ohrsXT3usVOVa7mnNIsYk15NpBzKJGIvdQSyzQ+DHXK+xcYDhgH4DPsfmxeIOvziaQVEHM9sGkEJdKqfkCzFgI7AL0o9xG0QQNSzhrZBhA4pggykCwH9pclZxPMb6TNoAKk/x1wwFUppz5llzDxArysNs4k3G3Of3VWbHgpRzwFFWtw0gatm3vV7k8spJJSHCol9NXgc+q1Bs9o1KhiqfKsH7+9GDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; dkim=pass (2048-bit key; unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=YdXVsUa9; dkim-atps=neutral; spf=pass (client-ip=68.232.139.130; helo=esa5.hc1455-7.c3s2.iphmx.com; envelope-from=enju.kohei@fujitsu.com; receiver=lists.ozlabs.org) smtp.mailfrom=fujitsu.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=YdXVsUa9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=fujitsu.com (client-ip=68.232.139.130; helo=esa5.hc1455-7.c3s2.iphmx.com; envelope-from=enju.kohei@fujitsu.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 65 seconds by postgrey-1.37 at boromir; Fri, 30 Oct 2026 21:51:40 AEDT
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGHwD3hwcz30Vd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 21:51:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1793357501; x=1824893501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Bk02kov5eXaN4fQMM0pbL4dj5jWKbTsBzV8w285UiE=;
  b=YdXVsUa9gHzcTwSPdOjph2Vilmilgvcc6At8oOmzZNF9NMLOBwBI0S+V
   0eavFOQH7CVH/snvMcY8bUXJzxzguOO6TzQKRNZpDCZsZ9j71Ydhh0+Ui
   07SO8j83et4eM8ReiMKch+9TulS0rlK4Xlz0ClTgErUV5VELvj9t2QIGz
   MsJXMaKzAT39JEZeSrIH4rsjdlAZWfz70MpPtNU7UNn46uWEYHmcuY601
   kg+YKdG1LCHZ4j1VqXAUnJNdU4pjbU7EsOWBPqOFjfPTalaKs3NKOSI4U
   Ww3dRji010RPc0WAjxslBN6ylFXvcecFWGBtYH32GGWecj64LpEFM+iHP
   w==;
X-CSE-ConnectionGUID: +M1D92mQQ7yGSPWh2DtV5A==
X-CSE-MsgGUID: VKWEpjuKRpqW+KiWTXQ0Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="258305024"
X-IronPort-AV: E=Sophos;i="6.27,186,1786978800"; 
   d="scan'208";a="258305024"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 19:50:28 +0900
Received: from az2uksmgm3.o.css.fujitsu.com (unknown [10.151.22.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id B37771007998
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 10:50:28 +0000 (UTC)
Received: from az2uksmom2.o.css.fujitsu.com (unknown [10.151.22.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm3.o.css.fujitsu.com (Postfix) with ESMTPS id 68528C041EB
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 10:50:28 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.9.203.66])
	by az2uksmom2.o.css.fujitsu.com (Postfix) with SMTP id EC18C140769F;
	Fri, 30 Oct 2026 10:50:23 +0000 (UTC)
Date: Fri, 30 Oct 2026 19:50:20 +0900
From: Kohei Enju <enju.kohei@fujitsu.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	x86@kernel.org
Subject: Re: [PATCH v6 6/8] dma: swiotlb: Centralize memory-encryption pool
 sizing
Message-ID: <auR0fT1yrKQ9wbm8@FCCLS0092175.localdomain>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
 <20260924060756.1325156-7-aneesh.kumar@kernel.org>
 <asVs3doaJ4WrT3M2@willie-the-truck>
 <asYZFXGyafRjjBS0@arm.com>
 <asYiOgskwi8JYLe_@willie-the-truck>
 <yq5awlrt3dwo.fsf@kernel.org>
 <yq5av77c92oo.fsf@kernel.org>
 <aseRzPshcoys7AJS@arm.com>
 <yq5ao6d48dqr.fsf@kernel.org>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <yq5ao6d48dqr.fsf@kernel.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/08 20:02, Aneesh Kumar K.V wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> 
> > On Thu, Oct 08, 2026 at 11:03:27AM +0530, Aneesh Kumar K.V wrote:
> >> Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:
> >> > Will Deacon <will@kernel.org> writes:
> >> >> On Wed, Oct 07, 2026 at 11:04:05AM +0100, Catalin Marinas wrote:
> >> >>> On Tue, Oct 06, 2026 at 10:49:17PM +0100, Will Deacon wrote:
> >> >>> > On Thu, Sep 24, 2026 at 11:37:54AM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> >>> > > @@ -496,7 +516,8 @@ swiotlb_select_pool_policy(unsigned int flags)
> >> >>> > >  	if (swiotlb_force_disable)
> >> >>> > >  		return SWIOTLB_POOL_NONE;
> >> >>> > >  
> >> >>> > > -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> >> >>> > > +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> >> >>> > > +	    !restricted_dma_pool_present)
> >> >>> > >  		return SWIOTLB_POOL_CC_GUEST;
> >> >>> > 
> >> >>> > I think this check on the restricted DMA pool is too general -- the pool
> >> >>> > could be tied to a specific DMA-capable peripheral and so treating its
> >> >>> > presence as a global property isn't right.
> >> >>> 
> >> >>> I agree it's a hack but that was the simplest way to avoid the pVMs
> >> >>> getting a bounce buffer after this patch. More than happy to leave it
> >> >>> out and reduce the buffer on cmdline or we come up with some better
> >> >>> heuristics.
> >> >>
> >> >> Hrm, that does mean that reverting just this part will regress pVMs
> >> >> because they'll suddenly be allocating a tonne more memory for an
> >> >> entirely unused swiotlb buffer. So I think I'd prefer to drop the entire
> >> >> series until this has been worked out properly.
> >> >>
> >> >>> Another option could be the arch code passing another flag that it
> >> >>> doesn't want an encrypted pool (e.g. when running in a pKVM guest) but I
> >> >>> don't particularly this either. The arch code doesn't know whether
> >> >>> there's an alternative pool.
> >> >>
> >> >> At that point, the default size may as well be driven by the
> >> >> drivers/virt/coco driver.
> >> >>
> >> >>> That said, such heuristics should have been a separate patch to make it
> >> >>> easier to review/drop.
> >> >>
> >> >> I think the only right way to get a semi-accurate heuristic is to take
> >> >> into account the set of dma-capable devices that will use the swiotlb
> >> >> pool, but that's fiddly and should probably be tackled as a separate
> >> >> series. Maybe a simpler hack in that direction would be to take the
> >> >> SWIOTLB_POOL_CC_GUEST if _any_ device is going to use swiotlb? You'll
> >> >> run into the usual problem of not being able to tell if a device is
> >> >> DMA-capable or not, but you could probably look for a global restricted
> >> >> DMA pool and, if that doesn't exist, check for per-device restricted pools
> >> >> on dma-coherent devices (since restricted DMA isn't supported by ACPI) as
> >> >> a reasonable approximation.
> >> >
> >> > So, something like this?
> >> >
> >> > 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> >> > 	    swiotlb_cc_guest_needs_default_pool())
> >> > 		return SWIOTLB_POOL_CC_GUEST;
> >> >
> >> 
> >> Detecting a DMA-capable device is not straightforward, and if we get it
> >> wrong, we will enable SWIOTLB_POOL_CC_GUEST unnecessarily. Would the
> >> code below be a reasonable approximation of what you suggested?
> >> 
> >> Another option would be to make swiotlb_cc_guest_needs_default_pool() a
> >> weak function that architectures can override. arm64 pKVM could then use
> >> a different scheme (for this patch series default to false). Would that
> >> be preferable?
> >
> > Even the rmem check for each device is still a hack that may bite us in
> > the future (private devices for example would not need swiotlb). I'm
> > thinking more and more of leaving the sizing an arch-specific decision,
> > don't bother generalising it at all.
> >
> > On pKVM vs CCA guests, there's really nothing specific here to pKVM
> > guests. The only difference is that confidential guests that so far have
> > run without a swiotlb buffer will regress if their memory is tight. For
> > confidential guests without dedicated rmem (either CCA or pKVM), I think
> > our options are either command line swiotlb sizing or dynamic swiotlb.
> >
> > Could you respin your series while leaving out the generic sizing? IOW,
> > no x86 code generalisation. We can discuss the best strategy on sizing
> > later (I haven't checked how much of this series still makes sense
> > without the generic sizing).
> >
> 
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
>  [...]

Hi Aneesh,

I can reproduce the CCA regression discussed in this thread:
  https://lore.kernel.org/all/yq5azeyxyfol.fsf@kernel.org/#t

The guest runs out of SWIOTLB slots, causing disk I/O to fail and
preventing the guest from booting.

I would like to test the fix on real CCA hardware. Could you please Cc
me when you respin the series? I follow LKML, but I may still miss the
posting by chance.

Thanks,
Kohei

