Return-Path: <linuxppc-dev+bounces-23390-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E66C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 12:11:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grbMT4kCqz2yXj;
	Thu, 02 Jul 2026 22:11:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782994277;
	cv=none; b=NCrjTZ6rkapuqWF8nwM2X7FqUYbTy48zylm9UUO5xp82vGydhIAW/lrnergLNUpYWo8QYGh8OCaVONnRQtINMiTDGl4btgFtVDEoGH8PjuIFbTHZWZNlx77ddC0I0Vae4n6YpUKmd21AT9DvdoEksjOcrqQuD97t44QLqdmF8gWWIaYqixngzX6vJy03+Ch7bWxY5VAnyHNlGNW3Gd/azD4k061Swa0x9x29tEBv2kbQqMwQlZVPbRQtWMwJF1zxcAW1lW0nGF7MVb6tKF4ZSKnNrRUlZZ9hvlxyB0pRCKdBcGFTVpuZ2je8yyk7ySrldREUBn4bbY9u+8yz35EDbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782994277; c=relaxed/relaxed;
	bh=szYxJDyUXLwpHCPYtdT5QZRTamk7ohIwjDiVPC1pzUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZPHE0dFRpnpZ5soma+QxZOKpdNOnNGVqrxgcnp1upahbZDnmOLKpaVwhGIs4d+DYbOK+urZCRUZfK6J/3WasdPj2hTMqVjb92JSOuwPGnOAXxypb9V32455tXzcpgT+o6H1xuHxZF07R0gERbiSyJ4ka08z2ZJGuRNU0JbaLMEhtL7b1V4cz+t7NUdAyefXFUIv6BphSDtHX4vPV9QJtqGEL1xvx4kLknEnp1EN4oJb5keJ4M/4przGkfIF9Ezw26B96YC/MfVZwA3rH7yvBPBHQmHlGOZbougmZEQooeDfx9xDm4GDTXJ9r5fScPRC3IfPClolBluRNADoS79WPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=o2h14zEv; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b2; helo=out-178.mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=o2h14zEv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b2; helo=out-178.mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grbMS62lBz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 22:11:16 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782994254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=szYxJDyUXLwpHCPYtdT5QZRTamk7ohIwjDiVPC1pzUs=;
	b=o2h14zEvKcQ49vaQ50LBNnbgHGGpFBTA0OsIFCWdpiUc7gYaraiUcJHgmdFM4mBzY7pBJH
	3Nawgn9WkBzIHxRb3Nw1H0UdEQI7UMwMGIksMhfoUjYHvm6uqPS5csZAIdTgWkWJ0NxwiR
	+fbu3PSBP2IvpsY/0wNqYNag0+1ZZPU=
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
Subject: Re: [PATCH 05/13] mm: prefer mm->def_vma_flags in mm logic
Date: Thu,  2 Jul 2026 20:10:22 +0800
Message-Id: <20260702121022.49113-1-lance.yang@linux.dev>
In-Reply-To: <3b4ccdc38819b42ddc79ee5a795831208ac7986c.1782760670.git.ljs@kernel.org>
References: <3b4ccdc38819b42ddc79ee5a795831208ac7986c.1782760670.git.ljs@kernel.org>
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


On Mon, Jun 29, 2026 at 08:25:28PM +0100, Lorenzo Stoakes wrote:
>Currently mm->def_flags (of type vm_flags_t) is union'd with
>mm->def_vma_flags (of type vma_flags_t).
>
>As part of the effort to convert vm_flags_t usage to vma_flags_t (in order
>to no longer be arbitrarily limited to a system word size for VMA flags),
>prefer mm->def_vma_flags to mm->def_flags throughout the mm logic.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
>---
> mm/debug.c |  2 +-
> mm/mlock.c | 13 +++++++------
> mm/mmap.c  | 11 ++++++-----
> mm/vma.c   |  4 ++--
> 4 files changed, 16 insertions(+), 14 deletions(-)
>
>diff --git a/mm/debug.c b/mm/debug.c
>index 497654b36f1a..f0a354a9496a 100644
>--- a/mm/debug.c
>+++ b/mm/debug.c
>@@ -226,7 +226,7 @@ void dump_mm(const struct mm_struct *mm)
> 		mm->numa_next_scan, mm->numa_scan_offset, mm->numa_scan_seq,
> #endif
> 		atomic_read(&mm->tlb_flush_pending),
>-		mm->def_flags, &mm->def_flags
>+		vma_flags_to_legacy(mm->def_vma_flags), &mm->def_vma_flags
> 	);

While at it, one thing for later: dump_mm() still assumes one-world VMA
flags. That works today since vma_flags_t is one word. Maybe worth a
BUILD_BUG_ON() here, before that stops being true?

Not a big deal though. Feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>

> }
> EXPORT_SYMBOL(dump_mm);
[...]

