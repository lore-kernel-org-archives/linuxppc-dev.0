Return-Path: <linuxppc-dev+bounces-23417-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F2FC43327
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 15:47:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grh996rHDz2xwM;
	Fri, 03 Jul 2026 01:47:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783007261;
	cv=none; b=nzNdpDzkkILSGbr5UnjNt6E8jIRbfKJ5mE/o4ifr5cyIVlhRtyrigTchknDf4dPcb56LEn6ux8I6Mo6ViWPh0m0RW7x3YhtfOaawuTyYF75s05yShFEnPQNwBXYGRiJrn04j406A9Ze2hIF1R4B19Ex3TmGECcKOtOuqW0Ap7yaA9y/OD7FdqNpbUfOnClb8XeODEj4koZdewUF0a5Xi1arlZ961uNBnWyqH0YbAh+3vo99ccXj5l/bJq+NusXWcDHzpY84egw1gXJyk34972tsq3pEQVDF+ddG0xEDwRGsnFj0GmPFAVhhqCUd8fdv26jEiQBeoT2leHzHIFm/zrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783007261; c=relaxed/relaxed;
	bh=Po4UWa+Txwx6nSBMW1aPQiZMcfNfQH1HH88CC93hgvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dq+fsejrFEtsILVRV6p50syRgNdXQxb0zD2dQVo8mcoNnKQZJ54P1VNUHdgDXu3EsO34HTs6aHBMjTXuNgnEOho7vl+JQ559pP9rFgPDkP2K2/40C1S52UU0z54bATvZxTA2nxkj5AXsfXBy99ZdXB8XIrk6P7y5wJY3eglotalKprc4XtozvyBPBPZEYfrN7wAJZYxtc8ODD/CPi4aERTrpKe1ENwMenC9t+eH4tlr2pkeoxk4l2xAJqHeYKrkFyCvHDZnyh7HEHoVzZV1ZSiLrgaUUWCd15cUecKRgL8WaXObCdHl98IraDfvZuysdqktMgvORCAisFVmp3tE4LQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TzKC7lqe; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TzKC7lqe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grh990BH7z2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 01:47:41 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E29F6601F1;
	Thu,  2 Jul 2026 15:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504D91F00A3E;
	Thu,  2 Jul 2026 15:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783007257;
	bh=Po4UWa+Txwx6nSBMW1aPQiZMcfNfQH1HH88CC93hgvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TzKC7lqe9Irn8JWqPCnRnBZrIjo+wjSEuABLaM62PvcVIf4DaJMLiJvSaLOlIhJOf
	 znTjZNuNsA3irPkrJRqgdqBSalvaquhCKCvJXbcnp48ft4f4usQWudMjc5HdiilEg8
	 aXu2StIvmQVSGOVmy/Z45hqYBBWUQ4dmbbAuXk0zKTG9Nk6i9FrPim4oLQSVwaxjeJ
	 SDNmxdCjFnKqxvBlFG1TSv8opFwMO6hCg3J9TODlwY2GGXnrD8Ppex9n5gZkrvDNyw
	 HAH74jjJFvvUXueVEU77M3F6be8/OSAHgO1cGcNXrmLyLcrgWJzjocoh6IYJOxKTNs
	 hiEtCFwm59HOw==
Date: Thu, 2 Jul 2026 16:47:14 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, tsbogend@alpha.franken.de, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	l.stach@pengutronix.de, inki.dae@samsung.com, sw0312.kim@samsung.com, 
	kyungmin.park@samsung.com, krzk@kernel.org, peter.griffin@linaro.org, 
	jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, 
	tursulin@ursulin.net, robin.clark@oss.qualcomm.com, lumag@kernel.org, lyude@redhat.com, 
	dakr@kernel.org, tomi.valkeinen@ideasonboard.com, hjc@rock-chips.com, 
	heiko@sntech.de, andy.yan@rock-chips.com, thierry.reding@kernel.org, 
	mperttunen@nvidia.com, jonathanh@nvidia.com, kraxel@redhat.com, 
	dmitry.osipenko@collabora.com, zack.rusin@broadcom.com, matthew.brost@intel.com, 
	thomas.hellstrom@linux.intel.com, oleksandr_andrushchenko@epam.com, deller@gmx.de, bcrl@kvack.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, muchun.song@linux.dev, osalvador@suse.de, 
	david@kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	liam@infradead.org, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, hughd@google.com, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, jannh@google.com, pfalcato@suse.de, 
	kees@kernel.org, perex@perex.cz, tiwai@suse.com, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org, 
	etnaviv@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org, virtualization@lists.linux.dev, 
	intel-xe@lists.freedesktop.org, xen-devel@lists.xenproject.org, linux-fbdev@vger.kernel.org, 
	linux-aio@kvack.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 11/13] mm/mlock: convert mlock code to use vma_flags_t
Message-ID: <akaH31jAOuMtthKF@lucifer>
References: <2db16db81538355ca65f778c246d2381c673cad4.1782760670.git.ljs@kernel.org>
 <20260702132107.73727-1-lance.yang@linux.dev>
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
In-Reply-To: <20260702132107.73727-1-lance.yang@linux.dev>

On Thu, Jul 02, 2026 at 09:21:07PM +0800, Lance Yang wrote:
>
> On Mon, Jun 29, 2026 at 08:25:34PM +0100, Lorenzo Stoakes wrote:
> >Replace use of the legacy vm_flags_t flags with vma_flags_t values
> >throughout the mlock logic.
> >
> >Additionally update comments to reflect the changes to be consistent.
> >
> >No functional change intended.
> >
> >Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> >---
>
> Nothing scary jumped out at me. Just one tiny nit below ;)
>
> [...]
> >@@ -466,24 +466,23 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
> >  */
> > static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > 	       struct vm_area_struct **prev, unsigned long start,
> >-	       unsigned long end, vm_flags_t newflags)
> >+	       unsigned long end, vma_flags_t *new_vma_flags)
> > {
> >-	vma_flags_t new_vma_flags = legacy_to_vma_flags(newflags);
> > 	const vma_flags_t old_vma_flags = vma->flags;
> > 	struct mm_struct *mm = vma->vm_mm;
> > 	int nr_pages;
> > 	int ret = 0;
> >
> >-	if (vma_flags_same_pair(&old_vma_flags, &new_vma_flags) ||
> >+	if (vma_flags_same_pair(&old_vma_flags, new_vma_flags) ||
> > 	    vma_is_secretmem(vma) || !vma_supports_mlock(vma)) {
> > 		/*
> >-		 * Don't set VM_LOCKED or VM_LOCKONFAULT and don't count.
> >+		 * Don't set VMA_LOCKED_BIT or VM_LOCKONFAULT and don't count.
>
> s/VM_LOCKONFAULT/VMA_LOCKONFAULT_BIT/

Ah yeah oops, will fix and respin! Good spot [and claude missed it ugh] :)

>
> Otherwise LGTM. Feel free to add:
>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
>
> > 		 * For secretmem, don't allow the memory to be unlocked.
> > 		 */
> > 		goto out;
> > 	}
> >
> >-	vma = vma_modify_flags(vmi, *prev, vma, start, end, &new_vma_flags);
> >+	vma = vma_modify_flags(vmi, *prev, vma, start, end, new_vma_flags);
> > 	if (IS_ERR(vma)) {
> > 		ret = PTR_ERR(vma);
> > 		goto out;
> [...]

Thanks, Lorenzo

