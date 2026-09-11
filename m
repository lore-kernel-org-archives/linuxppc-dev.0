Return-Path: <linuxppc-dev+bounces-27089-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E26DC88E41
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 05:03:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hh2W90xgYz2ygK;
	Fri, 11 Sep 2026 15:03:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789103013;
	cv=none; b=DzMBnyJrQO1XZru7NZky1DaHGAQ178RAsJdLKBoNKq3vufIs6inRZfL+zWrIw5cC8HPIFuhFbsLIpR4kPe1YWS5ym65nPnIGbzLzYdaNH+UKQpW0MinGQC+RoZw/vSBAn9DVVPyEwFNvrQ85vQSTiiI2cDXPSoppgb4jX4jEh2d2nyBmW96NdHKkwHMbD5w90ahfnwCiijsYL8Y3qzuohd2T7QS/9qpnzJz1ay4kHCC4loL4u+WLaFBzRIWTQAIFYlbev7kkig0npzMHSk/0iXcysPoRz1BxQvs6LJp5Lb2r4OgoKdHyHUlN15eBnfE0Da/q3468dC7FP19uvu/QUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789103013; c=relaxed/relaxed;
	bh=qqQtNE5K5bGF4fAhBmQKuNzeCVlz+kHVYANXwAzhHeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RWiRWtb9DmY17TLvQgUQdBBZtbyX5lCbCUEMAjNBFqMrVAwG6xvUb9xp3LBBQWgdWOMUfiIadgLN4sJtOV8I9j3pg9bA0YGy6LDthgMSor7PtBpw4rHkJYZrrDIdfqSQlg/xhCKr0WfyfV27GrMGGz/+LCau8lFlm+JO/TAfzyUq4q28AfjGTXAt40Jq4lE9UuZtmSZ+NIo8SJaz5CHlZN4MzkaB49FgmZYYw5S5gfi/3ikklwfPKeDlAKtnxPncKizwA7LG6d22UftmgIdmUsI+MGfFAq0H9xN8/WsXg+c5QIkbLU9K4jTyj6M2LykDLHiIDwKx3eYqeYq2USgE0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=X5IRfwjX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=X5IRfwjX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh2W70DHyz2yd7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 15:03:29 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2d942c7cc2fso4255505ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 22:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789103007; x=1789707807; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qqQtNE5K5bGF4fAhBmQKuNzeCVlz+kHVYANXwAzhHeA=;
        b=X5IRfwjX5zgAT+GMOvBvmKON+gbDOjYgL1IYyb/5C7crCiJlB+SMHOt67gb8WUeEQY
         hpJVzaYiSGaHdMvEVnazddV74ccJQ5UFRY56JwFOwCBA+8QOK0jyVXMnEXd4jp5JEX4T
         7VV+4B0YxE6SHcVOM9jHG0qpwO4vUXe65+cdaSHOrr42zu6bjkpdRNMAl5tVMZPudCqX
         KP8PSiwDF6sf4bS0Uc+s1tjlUMcb4kTtJEmze/eSbA0icslyzGPuWZgcnfFjv6gF6/hx
         +6RUe+dMWeb5JPzrv4UyCwA4wOdJzf4hNHaAk2j3gSbcNB+3K6hFkfN62aotzvGc5LKn
         9kaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789103007; x=1789707807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qqQtNE5K5bGF4fAhBmQKuNzeCVlz+kHVYANXwAzhHeA=;
        b=XVxyVkQuqSuse2zkEqhgXQ96OJ8nYdgC0C8nbR3teYNpUwcJ//nANn5DMTvvCyv3DV
         lCEcsum3qB5FpPmtnNgJ1p6UBYkY7ogwtgvV+RYNlEHcoh168TPhmRCSG0rQZMHaRDLG
         wSKNwBUI9ATCBg7napwYOzCO3nLVMTSg8Lx8YnNk5RxowKnCgBGAK/+R9NMHLrMyiUyr
         McfXAaRvEo8usnP3q5Hcm8Og65g/liok7nA4Tak/cvCmKl6Sk22trTVkhw9Qks0Ijo60
         hFUMkK7asraHXb7IMulE3lnGD1aLueydTb/gBoR3pPFcnARvazrHb8Rtpxf+69IAk0NM
         wmOQ==
X-Forwarded-Encrypted: i=1; AKwUvBxhyA/jndAWBLIuKzvrRgQMJnT987hibSO3atYvrmzbLl96PUh4AbyXmTkrQ4o3I+IEMMgY9qzBNSQrQ+E=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kXLcEMEOb+5cfWV4XsOWIk0mtXN0dpforPK86Bopvc6sx1ZcEy
	UbL+Lqd0imr5cuzLADbIyfnnfBayn+KpiB2CKIHpaSOg81H15I1xDsg8S2avl/IFLgM=
X-Gm-Gg: AYBFou0znmGlJlHDzS2rE9y2JwRU7knWfGWom9r3EReA3sQgWD1bK/M5pe8WrpWqYnI
	p7C7hevSkxGFcQKj4C1SsJj2E6DLx+lvpjYX5xfw1RjepoMhvC+nonS00g2EpsjPwvzjg5ylqyq
	H+9e7dKqNfuj9zaS290R/rljBH9NXWBuE5JGDoZJMmu8TlmkK/kc42xi559ae5uFng80qwOL+zB
	yy1QFIGiFPLFkk8J9hbAjDyZpGDGt0n5yAE9pgX6po+b83CXIwtW0wmxmnVlc7yHkUY2TydcbBq
	0DYd5WD5eQRD0zDouk2/eBJUu0B2DaVq5GEuY/ud0DZ316dHGkKg1zbImILeb27bfkEuKd7QkQe
	3AjuUEk05rgMQzEJt5Fw5NVvZ9/OOFdu8G1MZL8IE7vd29dofRTd9XVQqrsw5zglwSu3VVQntKb
	BcPdBaKIqghBguB478aIS5G/L0kXSS2kMf8GTmsKq6/iOy0OjZ9yRkJj9Te2fstbW58Cc2L82yN
	L5hBOXp1i+862iMh//J9X6zHoQurwW49XqU
X-Received: by 2002:a17:90b:1d45:b0:398:9be9:ab8f with SMTP id 98e67ed59e1d1-39d9c21cf40mr3843551a91.20.1789103006582;
        Thu, 10 Sep 2026 22:03:26 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d99531b16sm2651561a91.14.2026.09.10.22.03.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 22:03:25 -0700 (PDT)
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
Subject: [PATCH v3 00/11] mm: Switch device DAX to section-based vmemmap optimization
Date: Fri, 11 Sep 2026 13:02:17 +0800
Message-ID: <20260911050228.58884-1-songmuchun@bytedance.com>
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
records the compound page order from pgmap->vmemmap_shift in section
metadata before vmemmap population, uses the common per-zone shared tail
vmemmap page, and drops the extra reserved tail page. The powerpc radix
path is updated to use the same shared tail-page helper, so the generic
and powerpc DAX paths follow the same reservation model.

The first patches prepare the shared infrastructure by introducing a
generic CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION symbol, factoring out
shared tail-page allocation, and keeping the special shared-tail struct
page initialization local to sparse-vmemmap.

The middle patches move device DAX onto that infrastructure by recording
the device DAX compound page order in memory-section metadata, using that
metadata to back generic device DAX mappings with the common per-zone
shared tail page, exposing the shared helpers so the powerpc radix path
can use the same model, and dropping the extra DAX-only tail page
reservation and the now-unused section accounting arguments.

The final patch updates the documentation for the new DAX layout.

This is intended to be the third smaller step toward the broader HVO
generalization. The wider HVO consolidation between HugeTLB and device
DAX is left for follow-up series.

[1] https://lore.kernel.org/all/20260513130542.35604-1-songmuchun@bytedance.com/

v3:
- Use EOPNOTSUPP for partial additions to sections that already use
  optimized vmemmap mappings
- Move device_zone() after NODE_DATA() to fix non-NUMA builds
- Collect Acked-by tags from David Hildenbrand and Qi Zheng
- Rebase onto mm/mm-new

v2: https://lore.kernel.org/all/20260908030335.96549-1-songmuchun@bytedance.com/
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

Muchun Song (11):
  mm/sparse-vmemmap: introduce CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION
  mm/sparse-vmemmap: factor out shared vmemmap tail page allocation
  mm/sparse-vmemmap: open-code init_compound_tail()
  mm/sparse-vmemmap: prepare DAX vmemmap population for compound page
    orders
  mm/sparse-vmemmap: set compound page order for device DAX
  mm/sparse-vmemmap: switch device DAX to shared tail vmemmap pages
  mm/sparse-vmemmap: move vmemmap optimization helpers to a public
    header
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
 include/linux/vmemmap-optimization.h          |  94 +++++++++
 mm/Kconfig                                    |   4 +
 mm/hugetlb.c                                  |   2 +-
 mm/hugetlb_vmemmap.c                          |  30 +--
 mm/internal.h                                 |   9 -
 mm/memory_hotplug.c                           |   6 +-
 mm/mm_init.c                                  |  17 +-
 mm/sparse-vmemmap.c                           | 184 ++++++++----------
 mm/sparse.c                                   |   3 +-
 mm/sparse.h                                   |  81 +-------
 20 files changed, 253 insertions(+), 463 deletions(-)
 create mode 100644 include/linux/vmemmap-optimization.h


base-commit: c46036ca3ab7a7628fabe5790aefd917d0858db6
-- 
2.54.0


