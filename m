Return-Path: <linuxppc-dev+bounces-23126-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B045C43602
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 19:26:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpx8S5fw9z2xRw;
	Tue, 30 Jun 2026 05:26:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782761160;
	cv=none; b=Wnt+tAN0H7a4Ee+vl1uJGCAJZ2RGR7YcZjWoSVe7mNx054pe1Hmt/Nqn0ATqbfoBznhsyJTTPqt8qH4nw7gyGWg6CZ70l1jdCaL2Ag+U2F2WcPdOdRjDpN+I64mgFK9baC11uZ0kMZX6XTi6G3ZgxSrOkaXOc/uxzwDdyJnyDNaDk48YCgMsHiGl8h26bm3noRt7z3gcfpFRw/oYM+as3hVzz6gvFyD1bZWdmO4IcVFPeZ2GgTLsmsOac6CB5HkYh5cw0M0JgTXByyLHI1BBn+nja6Ck9X+l6deBDRrQdtptGxZjl1PN0+GxH89N4pg/azmxDzin3POx36F4j8MsMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782761160; c=relaxed/relaxed;
	bh=uYIw6aQ9I+77XwEcGZ5sLAkEEwuPzF6gubx9MILGtr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kF0Pq/bdmwWn+gnYSRjt96zkODYss0slMZPcUSZMKj9EX1DUE2LcBX/82YprdyjI5gviUsPPrsVLrLo7qJ/5EtAD7b42AXK7/cVX0nNDILea6mt+1z/d29d5KHg9+LKacaFrpRCmF+99RA4l+AHqGjW9cGDlfPMSzz4W8c7v7UanQxbt0d7MC2ioDx6mOc0qncJWzRVZTWCTVVjDrbQH116KDBkqTI0ZiWUxWUvweGsGjs87Zp6kDIqxkG90WE/bPmhKyCqalgiZjXLOseVafj8z0Ac2LIiA3JUtfME7sq9YOfhVtV6NT5s01rG4vwHP7h/s9wtm8Ht+SxcmNrvenQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOjc9JyG; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOjc9JyG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpx8R4RQXz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 05:25:59 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 723DC60008;
	Mon, 29 Jun 2026 19:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F6D1F000E9;
	Mon, 29 Jun 2026 19:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782761156;
	bh=uYIw6aQ9I+77XwEcGZ5sLAkEEwuPzF6gubx9MILGtr0=;
	h=From:To:Cc:Subject:Date;
	b=WOjc9JyG02UBcXhhgV9ic0phr0uZCFD5k0ILdv6ONhCv8Z1XYDxBYiwvpukl7K1Fg
	 a8aIrsAXippHTg2Wibb6tHWkzlE4E0fWXgBDrHzByOJL4F8jISF06sHckyYY+PF7tK
	 OiAiSmS9jz9wRn1oMBm18e5Uavo00IhgOxFuVQdHvJLDYYtq4uXlvS/eQXpk6KaIDD
	 GN3rVLuuxb69YleGJzixCH/hWeHWpFDPzoCr2KQROO1CK5H8VnjBM1FKT5hXUj42/o
	 WOenPbgoWzQyVU21Y69V/YrWJ0M+K8b+G7Zlo5u3zMESofU5MsPpKfLAYEn9kt+uGS
	 wlAF5pba2Dehg==
From: Lorenzo Stoakes <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Lucas Stach <l.stach@pengutronix.de>,
	Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
	Helge Deller <deller@gmx.de>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Kees Cook <kees@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
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
Subject: [PATCH 00/13] convert more vm_flags_t users to vma_flags_t
Date: Mon, 29 Jun 2026 20:25:23 +0100
Message-ID: <cover.1782760670.git.ljs@kernel.org>
X-Mailer: git-send-email 2.54.0
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
Content-Transfer-Encoding: 8bit

This series makes further progress in converting usage of the deprecated
vm_flags_t type to its replacement, vma_flags_t.

It focuses on mm, though updates some users of mm APIs also.

It updates:

* The core do_mmap() code path for VMA mapping.
* Unmapped area logic.
* The usage of mm->def_vma_flags.
* VMA page protection bit logic.
* General usage of VMA flags in core mm code, mlock, mprotect, mremap.


REVIEWER/MERGER NOTE: This is dependent on [0], which must be merged before
this.

[0]:https://lore.kernel.org/linux-mm/cover.1782735110.git.ljs@kernel.org/

Lorenzo Stoakes (13):
  mm: introduce vma_flags_can_grow() and vma_can_grow()
  mm/vma: update do_mmap() to use vma_flags_t
  mm: convert __get_unmapped_area() to use vma_flags_t
  mm: update generic_get_unmapped_area[_topdown]() to use vma_flags_t
  mm: prefer mm->def_vma_flags in mm logic
  mm/vma: convert vm_pgprot_modify() to use vma_flags_t and rename
  mm/vma: rename vma_get_page_prot to vma_flags_to_page_prot
  mm: introduce vma_get_page_prot() and use it
  mm/vma: update create_init_stack_vma() to use vma_flags_t
  mm/vma: convert miscellaneous uses of VMA flags in core mm
  mm/mlock: convert mlock code to use vma_flags_t
  mm/mprotect: convert mprotect code to use vma_flags_t
  mm/mremap: convert mremap code to use vma_flags_t

 arch/mips/kernel/vdso.c                     |   4 +-
 arch/powerpc/mm/book3s64/slice.c            |   6 +-
 drivers/gpu/drm/drm_gem.c                   |   2 +-
 drivers/gpu/drm/drm_gem_dma_helper.c        |   2 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c      |   2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c       |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.c     |   6 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c    |  12 +-
 drivers/gpu/drm/msm/msm_gem.c               |   2 +-
 drivers/gpu/drm/nouveau/nouveau_gem.c       |   2 +-
 drivers/gpu/drm/omapdrm/omap_fbdev.c        |   2 +-
 drivers/gpu/drm/omapdrm/omap_gem.c          |   6 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c |   2 +-
 drivers/gpu/drm/tegra/gem.c                 |   2 +-
 drivers/gpu/drm/virtio/virtgpu_vram.c       |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c  |   2 +-
 drivers/gpu/drm/xe/xe_device.c              |   2 +-
 drivers/gpu/drm/xe/xe_mmio_gem.c            |   2 +-
 drivers/gpu/drm/xen/xen_drm_front_gem.c     |   2 +-
 drivers/video/fbdev/core/fb_io_fops.c       |   2 +-
 fs/aio.c                                    |   2 +-
 fs/hugetlbfs/inode.c                        |   3 +-
 include/linux/huge_mm.h                     |  10 +-
 include/linux/memfd.h                       |   6 +-
 include/linux/mm.h                          |  51 ++++--
 include/linux/sched/mm.h                    |  16 +-
 ipc/shm.c                                   |   3 +-
 mm/debug.c                                  |   2 +-
 mm/huge_memory.c                            |  21 +--
 mm/memfd.c                                  |  15 +-
 mm/mlock.c                                  |  97 ++++++------
 mm/mmap.c                                   | 164 +++++++++++---------
 mm/mprotect.c                               |  16 +-
 mm/mremap.c                                 |  38 ++---
 mm/nommu.c                                  |   3 +-
 mm/util.c                                   |  10 +-
 mm/vma.c                                    |  27 ++--
 mm/vma.h                                    |   8 +-
 mm/vma_exec.c                               |  20 ++-
 sound/core/memalloc.c                       |   2 +-
 tools/testing/vma/include/dup.h             |  22 ++-
 41 files changed, 339 insertions(+), 261 deletions(-)

--
2.54.0

