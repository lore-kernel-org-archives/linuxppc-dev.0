Return-Path: <linuxppc-dev+bounces-27457-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D561C982C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 06:44:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hl8Vm0C67z2yGT;
	Wed, 16 Sep 2026 16:44:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789541039;
	cv=none; b=D9yy88Ot2Xo28SuvKIq8ndnGU8LiKOWCrLYfBXQNiCycTg/Ws/u1Q+cM/39/Epox5ttCA12LgbZtl2UE1NqKdVgaLlN57hVMVsiys6MZztQhR7JWENvAN9evPi4bCw5z+VZOZs6xLcLb/VwysEs6hfkewj1G7C2PQJJwPaplHCCihZWLv8SBm9p1JaJuZBT/DfLtg8Wz/fB2XJLFshvtuO46e7nuNrcj0ZePwu6n2DNQxvB+ex2NIozUQ/P6dcPuK5732EZJ69Wp0u6Bn1yIxWn2rZ7RPp9abFyBv59lrNrVOvX2CpnduozPvCtz/wLih++sRZ9AhTpeFg+2GlkOKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789541039; c=relaxed/relaxed;
	bh=0LtIEs9A+1i71VGLOsFyci15iFpT6FPKjskDwO0GIQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V0AqG89oEGeYNb3xUP1+pKcc5Lw+1/0q06EbkN3B+HgJO74TrigeMb3BDIrKdag/ScGkqDCC8Id4Nc2O5P4FOW380isak3KcwclEQd9hyQ+BfIQjwiwZivtLWffjSruFKHlvNG1FFLIjJrkcpZOfCUzgQeTMnreZH4uteyl+V5QW9wDD+q2Ptm/Ftesk6VSM4GCtpm+HH6tWtKfDeNeTGvx4r60jPILIo25Hlv/G7rrRmv8YKhDSF4OKiabpZhMYv5mU+tKh5W916QI+qPBUgmgGO/eXcdoIEW7WI7VpYLm19MXucmg/47EDQQKs+v1pHAiauMqLfQxgzk7UI3zovg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=TLDanzHC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=TLDanzHC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hl8Vj682Zz2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:43:56 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2dd88a115c1so6141655ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 23:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789541030; x=1790145830; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0LtIEs9A+1i71VGLOsFyci15iFpT6FPKjskDwO0GIQg=;
        b=TLDanzHC8pZOA044P6aL5znKKpDWebsP/kGqINwXRrgnPoEOkR4uqH0Um0yvNCvhk1
         CxYIprUjtWzbo4BgnWH1qBdp1oXLpZ8zVloCXW8B/14lBbShCvJ15PCi49JKWHsCxhs3
         n1Plmzom6RHgWDi+2xypeKxzYRCWRoK0YAHzAnJtc5gc5H9Pt8SxziH9HyoHyPFz2M/h
         D5RWoTMD6ZRaYRvsrjO6vPKRMRImHFvAVIRLODG15g3m8ihiFrhe8RI6ayNp7zSIuCCI
         8YKvw8HlbI9NHUrfb5O5QenGUY8w2vKwI2ZkpECa0c2fdD/UPgw+bOVqE1Xv38UJVub2
         8fPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541030; x=1790145830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0LtIEs9A+1i71VGLOsFyci15iFpT6FPKjskDwO0GIQg=;
        b=BKoKIdtSL5L/RMyz/8YBlCfcO6rouRD2/75KsMOK6nAPWGmpwe44BY9QgK5cY416Vn
         hzrAxQyFcmQO/IEEOjqenefcFD3gDm1lbGA+cORY0aZuKyB09sEfNT6aoq0OgK9wZF2j
         +srBAO5BGcMg5RimcehPZjalu4jBUP5ph9MQupKjJm1ZRqhuop42Glldgbc9hf30THSF
         FRMs2HMgroHLVAYWS3fFbxFlCJvoxUXCpEhr6iszU1+/x+Tueb5ICqNHX2ALe7xGxMyy
         BveYOcSDRT31ywPy5gSoNh4UiFfy5O2pQcmnj9dbowfRZC7RAVlSNQMGuSWIyA6MEfd7
         AyHQ==
X-Forwarded-Encrypted: i=1; AKwUvBxv3HULIZjRTK4/64GNtHHqB3cWf8ofF8ize5OZ6+3CAFcV61S+4kQlEZFL+7t81VpTexoYaeWSI1j0u9c=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lS+jR4A+nE4dHWSEkj3LvCmutUCXTqSsewjjsEsbA5C8NRT7ym
	DWHL5XuazmzIgkxVnp4VNjqD+28qU2MZE8N3U+9JGBk7gEml1VCuczg7tnJYQyWXnZ8=
X-Gm-Gg: AYBFou35DITlM6d+F+rTYSmLVAmXYr/fGNsiWjgxv5jOVjVWE5u9qj5iukQVd1DCJgH
	6PVmJb3fatMasfRXElSkc2sohmVbBrVhqPsmzdhnX/M4jUmTswklVUaUUAjBKv5m2aJZSHPtyGk
	wpIa99OhK/BxpDIDwIgioyKwCZGkfWrLJ/iW2b++pXVysgAlEqwU86PYEqwcC+hKq6Db4C/xY5S
	p9hdZkaaw8s2KzmSt8LWopU7fgARvJhnWghx9463kUfH27AoZygh748ndYwUZfijejepX96tc6U
	IzhxoO+allXmk1PnJpMhjvPWMTh/6XyRbfLhb6fMsqOxO8AO5z2HSAkRyl4D1qbKogmSCIDTbDC
	pr/rRz8bRtDPj9256DpY85smLQrzMBQa62Yngw1ldQFAppFDQKr+hWj6KSWB5n13mutY0fiCFiO
	L5tTnIr43uhlPXry+ca7pOW3PVGyX1PUa8keDbvoGG7dLmkirLxBUCt1lftjgqg+EL8kvLsp5bs
	68xR8FbprcdmjB+ZT4=
X-Received: by 2002:a17:903:22c2:b0:2d9:3083:a3ac with SMTP id d9443c01a7336-2dd8e52c3aamr26882255ad.15.1789541029585;
        Tue, 15 Sep 2026 23:43:49 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f0592asm6074755ad.62.2026.09.15.23.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:43:48 -0700 (PDT)
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
Subject: [PATCH v4 00/11] mm: Switch device DAX to section-based vmemmap optimization
Date: Wed, 16 Sep 2026 14:43:30 +0800
Message-ID: <20260916064341.1825793-1-songmuchun@bytedance.com>
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
generic CONFIG_VMEMMAP_OPTIMIZATION symbol, factoring out shared tail-page
allocation, and keeping the special shared-tail struct page initialization
local to sparse-vmemmap.

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

v4:
- Rename CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION to
  CONFIG_VMEMMAP_OPTIMIZATION (suggested by Mike Rapoport)
- Collect Acked-by tags from Mike Rapoport

v3: https://lore.kernel.org/all/20260911050228.58884-1-songmuchun@bytedance.com/
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
  mm/sparse-vmemmap: introduce CONFIG_VMEMMAP_OPTIMIZATION
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


base-commit: 48cd55c7cb7b6a674cb94c2d65864088877f9279
-- 
2.54.0


