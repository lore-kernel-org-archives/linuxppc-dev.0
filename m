Return-Path: <linuxppc-dev+bounces-24179-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BDFC44507
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 02:25:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzjp02fw1z2y8p;
	Tue, 14 Jul 2026 12:25:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783995928;
	cv=none; b=P5GdCbC6qAS0DHlKlEBqn2vf+v9gNlvSArXUlXM9E/US9iI2YtVLY10pfV5DVcV8zr7P2anmcijcE8aSrko0au2InMWZEhuiJtn63O4SeueRFTZylMv/dRk18/8KVFrtlI/mcXn9vQxQIupk8Zlx2DUncJyLVAxu9rJruLTdgw+wqZGVi1v7712681ngo7tNkCRzabzkybIX8F3G0xDNTjTHvTj/P8RyhnL5XzS6SWJQaFrEmd26r78EyiUgZX2aRcHGt5sE2rgQhuZ5ogurc9QYjh4U6mIeSI0dskk21PqP1PRWGGD1dhrxbo31XF8/ciFbPgCuV9r/adlpIcRXLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783995928; c=relaxed/relaxed;
	bh=dxhqIlF4Nmwz7Dc6V0zHplATkq8zPUSt2q/Zds9EZa8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=U/G4xc5NP4cSTB8LwQhad3wVWW+s0FgiSXZWFSAfNmTJZlZWqUTz9Ljq6OJL5IT/JT2/sKRYwPcEoqKsJchyHhxz287rCl6i/H5AgHoi4AqSv7y5/sTuqXi+Yy7+s0jWJOU4zBXVKYDVjsmBcH2dwyBy88BJlcO6TPosZ8iH8rFDAaVmHB+i4MW00anM4F886Wf5/tCkdhFfpbG2TA3JkU5lUVD5v1uLCPhmqoWK6pXAuQHPRTVWsvxeBb2rCwNiznQrdFewREBy93Xuly20YbgGuGmeQhjFEPY+27wB/dyGsoqeMbh3EUraTPSKrVSTwbe/kGuCq+Yz0YttQ/7zWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=b48cJk93; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=b48cJk93;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzjny6wLgz2y7W
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 12:25:25 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 821A641877;
	Tue, 14 Jul 2026 02:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DE31F000E9;
	Tue, 14 Jul 2026 02:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783995922;
	bh=dxhqIlF4Nmwz7Dc6V0zHplATkq8zPUSt2q/Zds9EZa8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b48cJk93FtKmn41eVdolAVE/uzQX6EHo01Pnkn0OgnY1vIvJtpHyTyl3C+S0onbuL
	 GGMGjmfE2JKefejiLP1J3PzT6MIi/Ch6j4XkBShkTRk15H8PEW9ZSYVvQQ/3WhTIGU
	 P9nMjGwkFSOLhnsQCjHUwc7HZ389d5X722tVvR6w=
Date: Mon, 13 Jul 2026 19:25:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Benjamin LaHaise <bcrl@kvack.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Jann Horn <jannh@google.com>, Pedro
 Falcato <pfalcato@suse.de>, Muchun Song <muchun.song@linux.dev>, Oscar
 Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain
 <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lance Yang
 <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Inki Dae <inki.dae@samsung.com>, Seung-Woo
 Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin
 <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Jani
 Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang
 <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, Marijn Suijten
 <marijn.suijten@somainline.org>, Lyude Paul <lyude@redhat.com>, Danilo
 Krummrich <dakr@kernel.org>, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>, Sandy Huang <hjc@rock-chips.com>, Heiko
 =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Andy Yan
 <andy.yan@rock-chips.com>, Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Gurchetan Singh
 <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, Zack Rusin
 <zack.rusin@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Matthew Brost
 <matthew.brost@intel.com>, Thomas =?ISO-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Oleksandr Andrushchenko
 <oleksandr_andrushchenko@epam.com>, Helge Deller <deller@gmx.de>, Kees Cook
 <kees@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Boris Brezillon <boris.brezillon@collabora.com>, Steven
 Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-aio@kvack.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
 virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
 xen-devel@lists.xenproject.org, linux-fbdev@vger.kernel.org,
 linux-sound@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v2 00/13] mm: convert more vm_flags_t users to
 vma_flags_t
Message-Id: <20260713192519.58113fa69c169d3f5f82e453@linux-foundation.org>
In-Reply-To: <20260711-b4-vma-flags-mm-v2-0-0fa2357d5431@kernel.org>
References: <20260711-b4-vma-flags-mm-v2-0-0fa2357d5431@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jul 2026 19:44:57 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:

> This series makes further progress in converting usage of the deprecated
> vm_flags_t type to its replacement, vma_flags_t.
> 
> It focuses on mm, though updates some users of mm APIs also.
> 
> It updates:
> 
> * The core do_mmap() code path for VMA mapping.
> * Unmapped area logic.
> * The usage of mm->def_vma_flags.
> * VMA page protection bit logic.
> * General usage of VMA flags in core mm code, mlock, mprotect, mremap.

Added to mm-new, thanks.

And oh my, what a lot of pre-existing issues:
	https://sashiko.dev/#/patchset/20260711-b4-vma-flags-mm-v2-0-0fa2357d5431@kernel.org



