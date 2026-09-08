Return-Path: <linuxppc-dev+bounces-26701-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CD1C79F9F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 03:04:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hf80j28VSz2xq0;
	Tue, 08 Sep 2026 13:04:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788836645;
	cv=none; b=JDElOLNJffqOsX2Ujd12btjV/MDjJ/L7HohVD5zDHiF7XaU6GlcB8zaBUYQID4xVOuKZxO4lscL4xWm98K1PkwfmcnJD2HvUXmCdUEh3XeTD3C+uNkzZFyyGqDcACwoTcQy9D2FqXoJT74mQ+7R0LmqUlwXdZChhc4GAwIUznXWbXnw5fdV2QE6DhwFtUu46AULircrY300q6b21pQh30xUg5dA5zHgzOd1U2CFiEOF0oxyInoqDohwuqx2R65PN2o7hnaN0VXtMPHXGyQHlVo1tEpgqTznfbqPr0BZDf1iyXWV4mRJdLZ1djYk0Xa/NAdHNCZY7d8EIFduByeJMJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788836645; c=relaxed/relaxed;
	bh=4XfCysBDn5qT8WqcsoKK1dWXF2dmEIjBSMFOB3v2Scw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lni5ZeR6OdenyWgnrMnsXB9krwwz6wYeMZtTCAzZ5TFJXnozX+6eDAV8HbNDs7pAwITVnKmjHlI+0tbiu6/SEwXMl12yly3TQyI0YVbyEsUoLmomM1HTkQ0xXnN8em9KmlYPtAHk8lB0rEnsnmxs1gZcu5fwg8VcqerZVlS/1/rnyP/RFfhAZ3TDWhD/NENX2w++2LNOn4z/i+N4jiX5lxadvlfMt7IHj1Il+1ZT2o5leJF95ofuZ4jAJ3hhfXKmBTUsvP7Bbvy5dveCJhxYGeucQNwPaXiMwwxcDnHdscnYL9rrNBS8UXmQjub7XUhWU/m6RYR2AcCxNqb7ioHFcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PxCHSUOp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PxCHSUOp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hf80f4Lwjz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 13:04:02 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-8556ec44e9aso3442397b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 20:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788836639; x=1789441439; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4XfCysBDn5qT8WqcsoKK1dWXF2dmEIjBSMFOB3v2Scw=;
        b=PxCHSUOpah5sLnMm/n87GscH/6IzHM9zLlfplIIVEQysByS8SnMvQ1PY1rrTz+nX2T
         b3i7I2qEcx/rVY+1c3vA4+eizAshsNgx3L64NpLBRU3PlPsDaZN5HYM+DRl0mCzu0hEK
         s48R2rhONWl4gp6Zid5rI64DAinV6eDAuNkVUnHMB7sytUeELu0NEvsPFqDLxOlSd5TL
         i4X0zjCPSGKos5/6qRlktQ7an+6nTfDYI3HcrzuJOTDoLVeHpPjtmu8iHAtOXz3k8Bvr
         pFwXpqfBrfecpU4DVKBxqNRZVOkbkYZR9D3toxgK8ps3H6UG8GdZYi3TDNJh3QCZ38OE
         3WAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788836639; x=1789441439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4XfCysBDn5qT8WqcsoKK1dWXF2dmEIjBSMFOB3v2Scw=;
        b=LGS/yqK7y6nXNfmO9bYoZVRy1feP+0w1FfOK7bfz9zqFvGfaXnSzu/8eUx+5RW+q1E
         tzGpGi0wZxYQoa5BnBhPTdqqGVoUqFnCqWudZHiIosEz/OnyV+LnoApQfY/GvN17V99s
         zj1BfBC+6nUI6soT/QVvhBQgo3IfkLPKORQiXmWjoVpWZWv6T3zWwzPDQ+tAet+dMkjJ
         S6kwVN1ip/K8DeBZdN+28EGulx5wL8QKVM5KZhilP5RXN2jv8k9pLaUKb9tt2B1lk+pf
         xiM8ON27SST6j8e+0uwJIHy0aVqEb7O6wZwFVpUkRozZlkedc8qFfXxONhIZrt3q3lGE
         zJCg==
X-Forwarded-Encrypted: i=1; AKwUvBxKohb1tLymAk9ztcDh9Gbz+K4DvCkRvvLreXBOmBS6iEmPVKNd3eN7bf/mlDuyPaYOHGsa9prRBpZK6GY=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mehVSSblsQ/ulj6v/rIGuogExniY/aQR0MuQYHjbEt0J7+WAap
	Xqfny7935Vs65YC8ZjJFkH13So+7ZR5KXefVUd+rsC3hnNRfwEMem+sP9o5jZzDnERQ=
X-Gm-Gg: AYBFou1871VMomhcleLpC69z8UJDrjA5h2m5taFddFamtGha49psYLf3J1jMmKNlxLG
	jM7fqkb4tspYMwqyj79reR8iUtn//CEu9yxNQk+NnIYAo2Sok+MDRhPglndg4UV8HDaCGgQuZG0
	ddoq3KqhCw/PcKhvcb8otcgITlkafGXdfhBS/cVsZP9UEGw8tRN7CgACzQHXbHkSEbdd0mpFQBs
	1HObx8YJb9lu6yPG6M+3BKhYI9RgjWxP5rN5cGdxOdF4l+i2colTLzeznFq/qWIdjff3qryl6nJ
	CzYq9Tl9m+Xgnsa6R5zLn4ob1/0mN8zoWACoO7P9CQuAHw3erCWWIya6oB/UqaP+yq7363bfOkT
	VovSIIycOyhYMyti41c9hyjQ+gZlr0zCysRke5vLj5cCO7MHbeaQdWAx0DG2Bdh7dZspRgB0ryU
	s50rXeVwHk1BSuGms5GB3r1I2ltfqNJ+NY71VhWJZ1tc916/YEf2f4H0L16xOR3sMhhu+o+JiRR
	5nvY0cX+OLmKCTZJwPLghwb
X-Received: by 2002:a05:6a00:2d0c:b0:857:72ba:ff0d with SMTP id d2e1a72fcca58-8616af5cf97mr37061890b3a.21.1788836638765;
        Mon, 07 Sep 2026 20:03:58 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152a358a2sm4868234b3a.29.2026.09.07.20.03.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 20:03:58 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 00/11] mm: Switch device DAX to section-based vmemmap optimization
Date: Tue,  8 Sep 2026 11:03:24 +0800
Message-ID: <20260908030335.96549-1-songmuchun@bytedance.com>
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

This series is split out from the earlier, larger series "mm: Generalize
HVO for HugeTLB and device DAX" [1]. While the parent series generalizes
vmemmap optimization across HugeTLB and device DAX, this subset addresses
a single, self-contained step: switching device DAX to the section-based
sparse-vmemmap optimization infrastructure introduced for HugeTLB.

After the HugeTLB conversion, optimized vmemmap state is described by
the memory section and the sparse-vmemmap population path can allocate or
reuse shared tail vmemmap pages based on that metadata. Device DAX still
uses the older DAX-specific population model, including a separate tail
vmemmap page reservation and architecture-specific logic to locate or
populate reusable tail pages.

This series makes device DAX use the same section-based model. Device DAX
sets the section order from pgmap->vmemmap_shift before vmemmap
population, uses the common per-zone shared tail vmemmap page, and drops
the extra reserved tail page. The powerpc radix path is updated to use
the same shared tail-page helper, so the generic and powerpc DAX paths
follow the same reservation model.

The first patches prepare the shared infrastructure by introducing a
generic CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION symbol, factoring out
shared tail-page allocation, and keeping the special shared-tail struct
page initialization local to sparse-vmemmap.

The middle patches move device DAX onto that infrastructure by recording
the device DAX compound page order in the memory section, using that
section metadata to back generic device DAX mappings with the common
per-zone shared tail page, exposing the shared helpers so the powerpc
radix path can use the same model, and dropping the extra DAX-only tail
page reservation and the now-unused section accounting arguments.

The final patch updates the documentation for the new DAX layout.

This is intended to be the third smaller step toward the broader HVO
generalization. The wider HVO consolidation between HugeTLB and device
DAX is left for follow-up series.

v2:
- Add a missing SPARSEMEM_VMEMMAP dependency (suggested by Qi Zheng,
  reported by Sashiko)
- Add an explicit ZONE_DEVICE dependency for DEV_DAX
- Add missing dependencies to the new public header
- Explain why optimized and ordinary layouts cannot share a section
  (suggested by Qi Zheng)
- Explain why sharing tail vmemmap pages is safe for DEV-DAX (suggested
  by Qi Zheng)
- Clarify the removal of duplicated 4K PUD calculations from the docs
  (reported by Sashiko)
- Collect Acked-by tags from Qi Zheng

v1: https://lore.kernel.org/all/20260831075342.57563-1-songmuchun@bytedance.com/

[1] https://lore.kernel.org/all/20260513130542.35604-1-songmuchun@bytedance.com/

Muchun Song (11):
  mm/sparse-vmemmap: introduce CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
  mm/sparse-vmemmap: factor out shared vmemmap tail page allocation
  mm/sparse-vmemmap: open-code init_compound_tail()
  mm/sparse-vmemmap: prepare DAX vmemmap population for section orders
  mm/sparse-vmemmap: set section order for device DAX
  mm/sparse-vmemmap: switch device DAX to shared tail vmemmap pages
  mm/sparse-vmemmap: move HVO helpers to a public header
  powerpc/mm: switch device DAX to shared tail vmemmap pages
  mm/sparse-vmemmap: drop the extra tail page from device DAX
    reservation
  mm/sparse-vmemmap: drop unused section_nr_vmemmap_pages() arguments
  Documentation/mm: update DAX vmemmap deduplication docs

 Documentation/arch/powerpc/vmemmap_dedup.rst  |  90 ++-------
 Documentation/mm/vmemmap_dedup.rst            |  32 +--
 MAINTAINERS                                   |   1 +
 arch/powerpc/mm/book3s64/radix_pgtable.c      | 124 +-----------
 arch/x86/entry/vdso/vdso32/fake_32bit_build.h |   2 +-
 drivers/dax/Kconfig                           |   2 +
 fs/Kconfig                                    |   1 +
 include/linux/mm.h                            |   6 +-
 include/linux/mmzone.h                        |  23 ++-
 include/linux/page-flags.h                    |   5 +-
 include/linux/vmemmap-optimization.h          |  91 +++++++++
 mm/Kconfig                                    |   4 +
 mm/hugetlb.c                                  |   2 +-
 mm/hugetlb_vmemmap.c                          |  30 +--
 mm/internal.h                                 |   9 -
 mm/memory_hotplug.c                           |   6 +-
 mm/mm_init.c                                  |  17 +-
 mm/sparse-vmemmap.c                           | 184 ++++++++----------
 mm/sparse.c                                   |   3 +-
 mm/sparse.h                                   |  78 +-------
 20 files changed, 250 insertions(+), 460 deletions(-)
 create mode 100644 include/linux/vmemmap-optimization.h


base-commit: 9d3243fc689fef444f87e0a703b4c99653137e1b
-- 
2.54.0


