Return-Path: <linuxppc-dev+bounces-23384-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86045C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 11:38:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grZdV6WRpz2yN8;
	Thu, 02 Jul 2026 21:38:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.178
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782992302;
	cv=none; b=W69gYEGODZ/A1V1X+L+YcnoknzXj7/RF3AwjS5tHQTie195x84GY/+q9Zj7qyfyb+ictTZBvKCNj2Rh3iNHdRHRXeb1H5zmRDfa7xlM4kR0pDdaw4D89b0hp2jxss1ls21k7Xz76j5pzdC+HIFcO7L20To20I4RkWf4sTPGjWQJHTAjGtCBWHIiBFF8dtXuNV110TiSiVg6fSjT6v3MfxVzrc9w24eKDtZ8edkUEwZ42uvIcHTPgYPLEzjoiBSp1vd+Q5+YPZHqHPUyx/LQgkaqei+Xg0y3LOtYxbP90N9FwSpXAbsVeytP9vk5BNHeHt+eHGugnyGTNVkVqw0cP/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782992302; c=relaxed/relaxed;
	bh=s4zTiOPxPEEvh+Z2LMv+6gqe9ZZvh+3yTK3Yc5UnT/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mzXkL4hdoxLkasEWj2R5x7e5PFc0Cqr7KoAhTuID0UERl93adfuU7No4xkkRPR3hfsBbis1bUWfVqX0sJZ0nNUU3igykrbSne7S2umAhY4/n8AVtnSn8ioxtkyTKepAbFalgrUo2MYQm/hH65LnZ3/TgxS+ELOfU/Aptu+gj9MhZi2ZftIP+C1+3RyvR0cIrN55abALCMYOtxr+3Wf58dEplzXB1ZlIkfSj8rTTvxP55w3Jhx3SL/tUo8iu+JrvKRj/K3ctKatofhKHIbbYNH7idSooQLHaOVgs+K3psqfsrsULPThrc6mOpcdVOdoMw499KfO+Y11qDjyYpPx9crg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AkD1PO3E; dkim-atps=neutral; spf=pass (client-ip=95.215.58.178; helo=out-178.mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AkD1PO3E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.178; helo=out-178.mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 14984 seconds by postgrey-1.37 at boromir; Thu, 02 Jul 2026 21:38:19 AEST
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grZdR0WdJz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 21:38:16 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782992273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4zTiOPxPEEvh+Z2LMv+6gqe9ZZvh+3yTK3Yc5UnT/U=;
	b=AkD1PO3EYh/hmuzqNyG5+F4iFU+xRbougp+bY+xotWctIjwUQvMKpAwXsjPb5kG+NxyY12
	mV0mEGNoe2Czu7JdCtguHySTk1KxuHzjRfZnXIBhIe71SSOqRiI6wOFZz62JhxqVX83KFA
	KhWu2A9hV9btjfbdFeq0dyXUttdl5PQ=
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
Subject: Re: [PATCH 03/13] mm: convert __get_unmapped_area() to use vma_flags_t
Date: Thu,  2 Jul 2026 19:37:22 +0800
Message-Id: <20260702113722.97837-1-lance.yang@linux.dev>
In-Reply-To: <b1ad7c4443f5cba622e4c48c5a9ef15427001a93.1782760670.git.ljs@kernel.org>
References: <b1ad7c4443f5cba622e4c48c5a9ef15427001a93.1782760670.git.ljs@kernel.org>
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


On Mon, Jun 29, 2026 at 08:25:26PM +0100, Lorenzo Stoakes wrote:
>Update __get_unmapped_area() to be parameterised by vma_flags_t rather than
>vm_flags_t as part of the effort to move VMA flags from a system word to a
>bitmap.
>
>We cascade the changes up to arch_get_unmapped_area_topdown() and
>arch_get_unmapped_area(), where, for now, we use vma_flags_to_legacy() in
>order to propagate the VMA flags.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
>---

Nothing suspicious that I could spot :) Feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>

