Return-Path: <linuxppc-dev+bounces-23394-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2EBC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 12:40:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grc0q3lkbz2yYq;
	Thu, 02 Jul 2026 22:40:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::ac"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782996011;
	cv=none; b=Cq1BPvRFdKdnbAP/1pzMny7IpbscL2J8dS7ez6JMqEWwePnoa8DhOHMqOMUvQjUlUSFRPGERjf27HyWVD2bwVwN0S/6odXvS5gmaYFF7m5TbzgM4gwb7dfxe4slLTpHZ8u592rfu5vrWv3qgQOHneriGibEQJZ8FFyIvuaFYEHrIn62ZBhEG++VgPLKamrc2kEiglBWHr68uhBQB2GBFOcIb26XHhQmM2DQVr2OPk4VKjAvhQl3rduBYrn+BLJ9UFG5XpHAkDqT/+bkiiw5x8D5qUv4NTs+OMaHO4Q0noisMiokvOOaY/EOSCgsiNwa7kTwdmdB70uFFTTzJLeq0cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782996011; c=relaxed/relaxed;
	bh=MSqvG6QTDeOE5qt8LI9tLb3iySB/2eramUM4HlZdPG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SFaJSXZ7cTOlXNjWXZDAh4iNTyaULmAhurePkQ8kOZZmuObVbaBD4XdrcCTmXuIzRWrZdMYGuThVPNNfwjQ2QZLTqy+gmXzqS9bVVy/tt/9mh3wColJgISWbWD96rsSujbdxbcI7F3WaiL8lfnuQSrmPd2h40n/zzqTHxnZq0P5ho16wL5SS2OdcC6it/QCLDz6t/rexLAnTuvybVxhCylNLwq2GNB0t8f4CnBF/MZsBX1ZmNQMJvMGOv2vmLgstnYEb/lNpUA+gtoHRpJThDR4kilJTifg7FOxb7ND3XAcUAonGL1IqJ4BhYl+say/7qZUKJ55HhzKd9CxiROnDPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=F10EZD2M; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::ac; helo=out-172.mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=F10EZD2M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::ac; helo=out-172.mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [IPv6:2001:41d0:203:375::ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grc0m6pSSz2yYY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 22:40:05 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782995985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MSqvG6QTDeOE5qt8LI9tLb3iySB/2eramUM4HlZdPG8=;
	b=F10EZD2MKuMsgIZGg+Kv4CpsFBAqfutqUSZV+CnlSj4mTRO6SM+hx7IFnwTXi02n4W5ksq
	B3eV7EruPZaVg8GiZqN77RrtZjvlyRAPzkka+Z5kYwT5shcZ0occtt6vxWz8dsjkDZRJwI
	jZvjN/4FCRiAB3/YW0BqvRoNYnrlgRU=
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	tsbogend@alpha.franken.de,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	l.stach@pengutronix.de,
	inki.dae@samsung.com,
	sw0312.kim@samsung.com,
	kyungmin.park@samsung.com,
	krzk@kernel.org,
	peter.griffin@linaro.org,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	robin.clark@oss.qualcomm.com,
	lumag@kernel.org,
	lyude@redhat.com,
	dakr@kernel.org,
	tomi.valkeinen@ideasonboard.com,
	hjc@rock-chips.com,
	heiko@sntech.de,
	andy.yan@rock-chips.com,
	thierry.reding@kernel.org,
	mperttunen@nvidia.com,
	jonathanh@nvidia.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com,
	zack.rusin@broadcom.com,
	matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	oleksandr_andrushchenko@epam.com,
	deller@gmx.de,
	bcrl@kvack.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	hughd@google.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jannh@google.com,
	pfalcato@suse.de,
	kees@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org,
	xen-devel@lists.xenproject.org,
	linux-fbdev@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 08/13] mm: introduce vma_get_page_prot() and use it
Date: Thu,  2 Jul 2026 20:38:45 +0800
Message-Id: <20260702123845.95316-1-lance.yang@linux.dev>
In-Reply-To: <3bb8bdc4788230c33102166d56cbc5abfad9d4cb.1782760670.git.ljs@kernel.org>
References: <3bb8bdc4788230c33102166d56cbc5abfad9d4cb.1782760670.git.ljs@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, Jun 29, 2026 at 08:25:31PM +0100, Lorenzo Stoakes wrote:
>There's a large number of vm_get_page_prot(vma->vm_flags) invocations. Make
>life easier by introducing vma_get_page_prot() parameterised by the VMA.
>
>This also makes converting vm_get_page_prot() to vma_flags_t easier.
>
>Also update the userland VMA tests to reflect the change.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
>---
> drivers/gpu/drm/drm_gem.c                   |  2 +-
> drivers/gpu/drm/drm_gem_dma_helper.c        |  2 +-
> drivers/gpu/drm/drm_gem_shmem_helper.c      |  2 +-
> drivers/gpu/drm/etnaviv/etnaviv_gem.c       |  2 +-
> drivers/gpu/drm/exynos/exynos_drm_gem.c     |  6 +++---
> drivers/gpu/drm/i915/gem/i915_gem_mman.c    | 12 ++++++------
> drivers/gpu/drm/msm/msm_gem.c               |  2 +-
> drivers/gpu/drm/nouveau/nouveau_gem.c       |  2 +-
> drivers/gpu/drm/omapdrm/omap_fbdev.c        |  2 +-
> drivers/gpu/drm/omapdrm/omap_gem.c          |  6 +++---
> drivers/gpu/drm/rockchip/rockchip_drm_gem.c |  2 +-
> drivers/gpu/drm/tegra/gem.c                 |  2 +-
> drivers/gpu/drm/virtio/virtgpu_vram.c       |  2 +-
> drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c  |  2 +-
> drivers/gpu/drm/xe/xe_device.c              |  2 +-
> drivers/gpu/drm/xe/xe_mmio_gem.c            |  2 +-
> drivers/gpu/drm/xen/xen_drm_front_gem.c     |  2 +-
> drivers/video/fbdev/core/fb_io_fops.c       |  2 +-

One missed?

drivers/gpu/drm/panthor/panthor_gem.c still has:

	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);

Can use vma_get_page_prot(vma) too.

[...]

