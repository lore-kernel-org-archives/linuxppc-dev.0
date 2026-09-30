Return-Path: <linuxppc-dev+bounces-28560-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F84CA5FCB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 14:07:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvxgr2gwSz2y24;
	Thu, 01 Oct 2026 00:07:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::29"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790777240;
	cv=none; b=Qs+xHYANNfrTzbBbkTcvLwk8IWdFnImkx6whnHdhBeabhmCmBKT3e6E1UvfWUIvyi/SpfGovVrhpzset8W8jlmTgmFG7jLRYw6u5LDaGTS3UM4+4rSZNxPFyUkbyKQcy432R45l2dJVNqfkMxB5ADE6/nux6YvapD0L/Mnq0eoydq+gq7LQb7x6Fhw8dgCbnf/mF/TYJFUk5GVN60yANarecsx/yqPpyIg/C4/UOQepNzU+ILIMwYS8l6XU5P5Van1KJqAF8FSGBqG/sVsI88Ef8LEjy5dWJ/6L7fCbu0M+TQgrlC45HPVj+9/xrjHQofaAayPD5eRAGU9y3FtfAiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790777240; c=relaxed/relaxed;
	bh=6e1W9oGdmTQ/Tr5KCupwBGHorLPAMWe6GyMMJhNYhVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hxni4BAj9ivgKIzsQ7ouuZhmqrCjICNm8E6w/hLdRYhrRdh6CR7ia/iTdS2daWyet2idOjwjYk9wF1a+ZA4WsFLDJQEyJB7g2ZdHSzQDkiVfMDy5j09THxVlpBaJmZDtqMTfvC1K8fkxCNVURwIo3G3umOhncr33UUSUaWWbbmPmov94c7ordkPQ5Ht9vF12aYHCoCVez/bJJKi6ADiBuI1i6BR57Sw4XQgGiSPUcPVlmhkRQLAfM2B/87kSOfFdgVvSd4Kdl36at3iOMT9jl1ijRU/l4Noe1w5VqEDOlNY7rP90P/KK7Fn1l2mlzVR0M6fuNNizbAq77WSJItzBAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=BdVnQ48S; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::29; helo=mail-pz2-x29.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=BdVnQ48S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:3b::29; helo=mail-pz2-x29.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x29.google.com (mail-pz2-x29.google.com [IPv6:2607:f8b0:4864:3b::29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvxgp469cz2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 00:07:17 +1000 (AEST)
Received: by mail-pz2-x29.google.com with SMTP id 41be03b00d2f7-cc7d1802740so750865a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 07:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790777235; x=1791382035; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6e1W9oGdmTQ/Tr5KCupwBGHorLPAMWe6GyMMJhNYhVc=;
        b=BdVnQ48StqZZuTNAREOpFdvSY0TP4ayNbRWvHVEiyl7+Rqt2KL2O20+KEtSph8YIK0
         2Vz6t/JlH/mygufH2TAdBTlnGLwKXqOH+14baHK0YQ6Enee6XkocvzsShE7B3UwkMZt6
         UTGts7hyRwiGHxWHqNCypwO4ORqMOTTePnS3jvUyaP+I5llnsM5yESOFYs3b8YtXBoQG
         /vtN09gbK/6wlZqdKGnOAd3DQursVcRlPXfyvqFv6lDwIv1k1qgFGjbClyuJLU/WUJVZ
         8JR1sK7wD5zCm3w/RrHnsbtnhCp61T0k9aFZn7KvJqrR8ArBy77vPEQvvoWWc56UkbeI
         dNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790777235; x=1791382035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6e1W9oGdmTQ/Tr5KCupwBGHorLPAMWe6GyMMJhNYhVc=;
        b=S/GhET028gd0gz5v6Kb36qUZlVAXXUeof/lMITyVGWDzRXilUM1i2uF5ISuhIWX3E1
         DgqziTWEB4heCG4qWtQoCYPn8fibR25BDNhMtxEnzWqKWbBnnxnRXqmvL0/IwmsLMb9f
         BoTC0+ux81HmOPs8Rgaz+CNu759+oUy/4L9z84394tgOeA+hyT4d4yMnL2jbfb9bPdvE
         xjAo9Z04XJkVFCTLRaJUkT91puoFw7P8huPntCCOP14vaDw14GNaPP/QxubfEZX+01OV
         bjoldCNZHVVZsj0BhQ06XPxacwzdBcvZB/osnPQiJTGQ05+UbyIMqdtmKzun16EmxbF1
         h0IQ==
X-Forwarded-Encrypted: i=1; AKwUvByAWq2kV1k5C0pqYUo7Fu8IN05p+cpU7uPwrbsfbabUALjOtEv8pnUzm8MMKY2KUldOnBB3DxMgd6VmRAg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLbEXcExfmIxt2tIH2aFtaG3UdDPdvW2Tq9RYIDDa2cX8+woBbc
	OEEtnRQMUnditkgd0+/OrB03zD0dI64PAOlwWezfVpM1wvcjfYeMrmpqq6w+XVJFPrI=
X-Gm-Gg: AYBFou12m6YqeLwP80Ms89JQJVY+zXJltPS+iMXMwl77983YSTW7dX8hl9zO0bX0oYI
	CP9cJhCGSMqClh3Nu7ZfWmCGZdA7Gqs4d+UDT3rHhh0aEu6SZ5k7o5tYhywZY5TxYAm7fEBDzlc
	zLDApzD9mGXQQOPn163dEzo4cLgiNR0jfPM0nuyZIqE9m+SehevW9u59JBs46A8o8W8/uzZiGSq
	y4p4acXtc7rTBCof2J9ZHTpVWbqzSdPoTLFPCN5ChIpH/xqUIOlj1KrDGLu9bHJwgiAb/r83P9k
	EhFQX7N7pRBas9abXwcx8WhSKNc8WsgHhLDlY8kf8RyBN3/Auvmety65zgWwpcKck5/RTnT1Vuk
	LlzDppIfyd9LHwUjgfWJsTXxjmH+f2LRHMAlyDeV46+isRcO72El17PfjvVIxXp1nNg8gQo4paB
	0qJIKFrMwlgOi1WuQB3XzSv+SlJrLgcu3IQ+8HSb2JhlknUyrqqparXka65TcHzf6TwMnwqt4EX
	DuBUasQXjp2YQ==
X-Received: by 2002:a17:90b:2684:b0:39d:84af:a0b3 with SMTP id 98e67ed59e1d1-3a4d151ef73mr1140780a91.18.1790777235209;
        Wed, 30 Sep 2026 07:07:15 -0700 (PDT)
Received: from G6L4RL2QG9 ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4e60ea12csm639509a91.1.2026.09.30.07.07.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 07:07:14 -0700 (PDT)
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
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v6 00/12] mm: Switch device DAX to section-based vmemmap optimization
Date: Wed, 30 Sep 2026 22:06:15 +0800
Message-ID: <20260930140627.57431-1-songmuchun@bytedance.com>
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

This version is based on mm-new commit a878c908dc92.

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

The first patches prepare the shared infrastructure by factoring out
shared tail-page allocation, allocating the per-zone shared tail-page
array dynamically, and introducing a generic
CONFIG_VMEMMAP_OPTIMIZATION symbol.

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

[1] https://lore.kernel.org/20260513130542.35604-1-songmuchun@bytedance.com/

v6:
- Use try_get_page() to prevent the shared device DAX tail-page
  reference count from overflowing (suggested by Andrew Morton,
  reported by Sashiko)
- Move constant declarations to the top of their functions and fold
  the shared tail-page array lookup into vmemmap_tails() (suggested by
  David Hildenbrand)
- Clarify the DAX population flag description and why optimized tail
  pages must not be poisoned (suggested by David Hildenbrand)
- Collect Acked-by tags from David Hildenbrand
- Rebase onto mm/mm-new

v5: https://lore.kernel.org/20260927025441.741633-1-songmuchun@bytedance.com/
- Move the shared tail-page factoring before introducing
  CONFIG_VMEMMAP_OPTIMIZATION
- Add a new patch to allocate the per-zone shared tail-page array
  dynamically and fix the RISC-V build failure reported by the kernel
  test robot
- Select VMEMMAP_OPTIMIZATION from ZONE_DEVICE instead of DEV_DAX so
  MSHV_VTL cannot set vmemmap_shift while leaving the optimization
  disabled (reported by Sashiko)
- Move the vmemmap optimization macros and MAX_FOLIO_VMEMMAP_ALIGN from
  mmzone.h to vmemmap-optimization.h

v4: https://lore.kernel.org/20260916064341.1825793-1-songmuchun@bytedance.com/
- Rename CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION to
  CONFIG_VMEMMAP_OPTIMIZATION (suggested by Mike Rapoport)
- Collect Acked-by tags from Mike Rapoport

v3: https://lore.kernel.org/20260911050228.58884-1-songmuchun@bytedance.com/
- Use EOPNOTSUPP for partial additions to sections that already use
  optimized vmemmap mappings
- Move device_zone() after NODE_DATA() to fix non-NUMA builds
- Collect Acked-by tags from David Hildenbrand and Qi Zheng
- Rebase onto mm/mm-new

v2: https://lore.kernel.org/20260908030335.96549-1-songmuchun@bytedance.com/
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

v1: https://lore.kernel.org/20260831075342.57563-1-songmuchun@bytedance.com/

Muchun Song (12):
  mm/sparse-vmemmap: factor out shared vmemmap tail page allocation
  mm/sparse-vmemmap: allocate shared tail page array dynamically
  mm/sparse-vmemmap: introduce CONFIG_VMEMMAP_OPTIMIZATION
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

 Documentation/arch/powerpc/vmemmap_dedup.rst  |  90 ++-----
 Documentation/mm/vmemmap_dedup.rst            |  32 +--
 MAINTAINERS                                   |   1 +
 arch/loongarch/include/asm/pgtable.h          |   1 +
 arch/powerpc/mm/book3s64/radix_pgtable.c      | 124 +---------
 arch/riscv/mm/init.c                          |   1 +
 arch/x86/entry/vdso/vdso32/fake_32bit_build.h |   2 +-
 fs/Kconfig                                    |   1 +
 include/linux/mm.h                            |   7 +-
 include/linux/mmzone.h                        |  38 +--
 include/linux/page-flags.h                    |   5 +-
 include/linux/vmemmap-optimization.h          | 115 +++++++++
 mm/Kconfig                                    |   5 +
 mm/hugetlb.c                                  |   2 +-
 mm/hugetlb_vmemmap.c                          |  31 +--
 mm/internal.h                                 |   9 -
 mm/memory_hotplug.c                           |   6 +-
 mm/mm_init.c                                  |  17 +-
 mm/sparse-vmemmap.c                           | 227 +++++++++---------
 mm/sparse.c                                   |   3 +-
 mm/sparse.h                                   |  81 +------
 21 files changed, 313 insertions(+), 485 deletions(-)
 create mode 100644 include/linux/vmemmap-optimization.h


base-commit: a878c908dc928cfe8b3be0f33d3e60d1af437cb9
-- 
2.54.0


