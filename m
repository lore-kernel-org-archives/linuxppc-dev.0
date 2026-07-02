Return-Path: <linuxppc-dev+bounces-23415-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4818CC43327
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 15:40:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grh165598z2yRM;
	Fri, 03 Jul 2026 01:40:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783006842;
	cv=none; b=Z4b5HI0RNHocFyIx7M7c60pNy7zTE5xlKk1BjA19D16x/sJZwW4Qn8banzj24rbyuhYEJFxaJpE3CMIcgMYMuW38S0y+voSoRZRQXJ9CeLdBrwEc3sTnp5ER2RnVRbQtONpr4tSOxGdtB+LPAxnRyok65EYOlXq/SJuhuhKxZNcpEdVq1XXTA3+MInKdiPVLkXy2VvX+/3s6RUHcFrA9wdTNrlylAKnotO3N4xgctc2n9wVTjWNF9jjME2htXUsIr/XCoNH2NU7J8i9p/Ii0A5enlScXFEz5ZYukG851iwRQhKst/KbfEB0HcP1na1VPqUpkm5foRh0C5daqPWuJnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783006842; c=relaxed/relaxed;
	bh=gNLYS8EYE6bJ5KaXF7DR9fRu4urDF+a7laqqF8q0hcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3n8+NYmSyui9YxIQvS55X7OvEOdo1jScjFiUN4NpsH8E6ujUGSxOGZa9MoPjA/xS4JpNKIk4MQWYhd2XB9i5Ia4Rqz9GiEl/BBUicTKbKjWn8H5o3w9E8AU6dSDc/Yjn+iif9cYHpmX9b6xC5lN2wc2W+7w125Zm0BubgPqFJEISIFVQvrXM6Ty99LXimL+p7AY/50Njs5MRj+Vlh5t5pc8nlIZdbsqtNZtJPkq33vtuz/QersOkuthU1r60d8akj4wIFQCCTON345uf1wCoS4AFn5LPKIFqvepqgcipI6h0M97DYdpJHscEm4cfxmFLs5NPdg97Ol7dIg9sTO/xw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8vOAtQO; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8vOAtQO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grh153xGsz2yN8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 01:40:41 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C7EA7601CA;
	Thu,  2 Jul 2026 15:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8E41F00A3E;
	Thu,  2 Jul 2026 15:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783006838;
	bh=gNLYS8EYE6bJ5KaXF7DR9fRu4urDF+a7laqqF8q0hcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z8vOAtQOT+iGTiy4xQ3GfxWy9CpR6iieY1qxm1fyBJSvxEFV2aEwGeTLwIZE4UbYF
	 sH6QvDHKQJHBXcc/JYlecYNDNZBJEw63vn2taYjOLxg3iNlePJRLcm76SDX3qcqqpf
	 OAzUHT+NRGQHyZOOfos5EJuVfaKEWfkdr4crDOBp2KFX/hKeIetGWLc1I64/oz6RHQ
	 NC8RA6ivq/IEW4DV1d+3Z0k229cWnviqo6Svky+UHUgnyeaFy3m0xyIovRQ1UfVX8n
	 wqqP9ts5FpBy46j7HS+G+te0/D/3BLeS388iQo+wLiLJCSDRdl7jDwGFy3vdpkllGJ
	 NUUDfmqseIbQg==
Date: Thu, 2 Jul 2026 16:40:15 +0100
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
Subject: Re: [PATCH 08/13] mm: introduce vma_get_page_prot() and use it
Message-ID: <akaGOiLz-3Zx6kDs@lucifer>
References: <3bb8bdc4788230c33102166d56cbc5abfad9d4cb.1782760670.git.ljs@kernel.org>
 <20260702123845.95316-1-lance.yang@linux.dev>
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
In-Reply-To: <20260702123845.95316-1-lance.yang@linux.dev>

On Thu, Jul 02, 2026 at 08:38:45PM +0800, Lance Yang wrote:
>
> On Mon, Jun 29, 2026 at 08:25:31PM +0100, Lorenzo Stoakes wrote:
> >There's a large number of vm_get_page_prot(vma->vm_flags) invocations. Make
> >life easier by introducing vma_get_page_prot() parameterised by the VMA.
> >
> >This also makes converting vm_get_page_prot() to vma_flags_t easier.
> >
> >Also update the userland VMA tests to reflect the change.
> >
> >No functional change intended.
> >
> >Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> >---
> > drivers/gpu/drm/drm_gem.c                   |  2 +-
> > drivers/gpu/drm/drm_gem_dma_helper.c        |  2 +-
> > drivers/gpu/drm/drm_gem_shmem_helper.c      |  2 +-
> > drivers/gpu/drm/etnaviv/etnaviv_gem.c       |  2 +-
> > drivers/gpu/drm/exynos/exynos_drm_gem.c     |  6 +++---
> > drivers/gpu/drm/i915/gem/i915_gem_mman.c    | 12 ++++++------
> > drivers/gpu/drm/msm/msm_gem.c               |  2 +-
> > drivers/gpu/drm/nouveau/nouveau_gem.c       |  2 +-
> > drivers/gpu/drm/omapdrm/omap_fbdev.c        |  2 +-
> > drivers/gpu/drm/omapdrm/omap_gem.c          |  6 +++---
> > drivers/gpu/drm/rockchip/rockchip_drm_gem.c |  2 +-
> > drivers/gpu/drm/tegra/gem.c                 |  2 +-
> > drivers/gpu/drm/virtio/virtgpu_vram.c       |  2 +-
> > drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c  |  2 +-
> > drivers/gpu/drm/xe/xe_device.c              |  2 +-
> > drivers/gpu/drm/xe/xe_mmio_gem.c            |  2 +-
> > drivers/gpu/drm/xen/xen_drm_front_gem.c     |  2 +-
> > drivers/video/fbdev/core/fb_io_fops.c       |  2 +-
>
> One missed?
>
> drivers/gpu/drm/panthor/panthor_gem.c still has:
>
> 	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
>
> Can use vma_get_page_prot(vma) too.

Oops! Will respin and update. Good spot!

>
> [...]

Thanks, Lorenzo

