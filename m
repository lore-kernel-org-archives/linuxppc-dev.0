Return-Path: <linuxppc-dev+bounces-19763-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85067F41991
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 11:14:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwdnv6L7Mz2yvL;
	Wed, 15 Apr 2026 21:14:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776251667;
	cv=none; b=Y3mxKKeaUtX/w5mPrqvPpScu6vf3Z5xmYgGFYCLZSLntmws4N63Gv2lcK+eyWZvHS2C+pmy5FET2YretGzXcqWA+3YhaC+GPj6qhaRx/OCHWMuI1opQ9WUBzyhO4ipq7ljPAxHTHymcDEaKvXDU3/XtgZgHCJwW3b4YSU+akWUmNtWeZC0L7zATqne+gZIQRsnmwh6R2By7eZfNPWlyg4dnGDvmavszdUFPP0yXLAy7YHpfJZsym5k+ynzK35KdU9PlrnXVBrt6KQy8EclzvgrWwXr+D91UJ3HMVGB+ymYiDoAAGb6YiMYXfQoAGzjkFD2hKZ3F1jXW0cfog9cUh+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776251667; c=relaxed/relaxed;
	bh=Hg37UlEcW10cmklaT0P772ahobtvEU06guOHNmMT8sw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AUQUJB7WMCYljCwL+Z66tppCoudxo7B0XxEczn8iNztK+wwPL2xhnLDwJxmRjIR1/Fr+VAJ23ZXl4PFNXy7OcSoKVv9+kCOEyogPRHWKG7YQhXjwZAMvZD4oGM/Qy65gKOGIgFDFNeqmcGpXhfsTztrMydcbNreKxAesGq/cJhzg21f4J+yJqVmy2aTFamtjWUHe6OkTbBYFPq1Z7gda6KQJ2/p2vfibutPjYhDlCVgh2lxQCHBEuFkpoRM9bFI/La1DTyarPf+bpWisFpVXWOMsteXQJfm7Vwq/qHvmOEvydhhJpQSkzuTGXATZWGsCvJzkXR5MG/qxxNqmmtS1Hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Rvlt1HxE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Rvlt1HxE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwdnr4rvqz2yvG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 21:14:22 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so50753145ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 04:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776251661; x=1776856461; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hg37UlEcW10cmklaT0P772ahobtvEU06guOHNmMT8sw=;
        b=Rvlt1HxE3PYOD7/KX2QcWtebQxEYp+9c0G6C/rnmDVeyHZz2LWx6Ttdse7EmGcqX3V
         lSuLU7ASQnvPEz7D9eWZY//2xUipZQ1vuQlbGXo3MaQKHKYdUaQT5WwXF6RApvlT/B3Q
         2xkAorXlAMY8ErKWm5CHVIIIYq4tWDGA4VToZVa38+/bhl3VUFWI5PtfnSL683a99UYh
         JiSDA2Pcwyv3Lpt6HdbhSDKCrFXXTzBQX34po/e+Bfehu2mO/nbV11/8S0nu9OqoN4XB
         jACHad2NLGRcHbr7IQnBfGNODCtMTax5TtRFJ+uue787QIhJRlzKSZqfzCtKu0p3dw28
         mnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776251661; x=1776856461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hg37UlEcW10cmklaT0P772ahobtvEU06guOHNmMT8sw=;
        b=Ci27npChfu7TxD/DtY955xhWLc61Pb7a7dXyb9fRq7tGocE6w2jntAhbBvRNGdyFt3
         KVVII15Tv45VfqZmncfy5gVTxq+JBL4YlLgr3jO41+YuD0vl5JtTda0MYmdVxV/dsW78
         wGh7wty53NN78YiyP7xDKPx88/0aKgiTp6nvel24A0Df3dharzXxa4R2+K1UyrW/IkSN
         6K7qcGHb2jPU/RcNWCuoO4k5kcBen9/lERDmIHtscZfExCZw1uk5fTsgHeUPLGbdGpAs
         8Meem6Mo07UePKEmpvZYKnv2VHVyIK/P1dFlID64sMfmdopxxF9WeVWib7rvhTinxnC7
         KMbw==
X-Forwarded-Encrypted: i=1; AFNElJ+6lYGoF/OPTNccQqxRQ5s2mUHnhcVVZ8whxVSz4gKuwP6duoQkPcWg355MzVuDF8NntybsYEa2C97cqlE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwecJl0a3upzaMdZ7n58NjdySahW/YUxlJVhV2iaBdxAH8HiJ3X
	d9Re+lbDkJ9MdeNllL8Ql65KRJr/vElisk2vFr61GBqTzueEnfXd/dFsmpCKOrOpEe8=
X-Gm-Gg: AeBDievxn+xUN/jTvAEEegL/6TSP7fljGV6iVT2oNbMB4kp+9syoYnTgSXl9HayvC7f
	E2LdAYlIzdvQeTi2xygRhmRGu3lWvD0fRcWiucW2WO2TI4lbKA1gAmD7iwQk47ZC2rUjOQIVL3u
	euzUeBDZTI9dnyMVz+0aNoofkTVRdel550cvtq8acaYmktbCMjMPdeZRXONkP4U4QitdJVtBCuf
	gCsqRtxHXw04IwSrVotltVF+voyUIJDRxv/KCShSG+FwD8Jbnd/9QH2w6hyYDzgHXte/xNeQ83F
	eTOSX/c3ELgYJ1IHlyJMjhp0UOcxBOeovU7xwrh2JFkMFDSfJlHkv0IT+fTY2rTaBNZAE0iL40i
	g4qxX2+5La3QY+PKlM/z4AnBuJNXDs0GyIIMZcermVJu6YAWvsWFlzWQ36ZypvIZJQxLZH+oNj8
	RFA1TH0rXs1ajRfOL+nBwTk5HC+hGEo7pown7IyE/MeT8=
X-Received: by 2002:a17:903:5cd:b0:2b2:42f8:1a45 with SMTP id d9443c01a7336-2b2d5a8ebc5mr145530325ad.39.1776251660541;
        Wed, 15 Apr 2026 04:14:20 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b477fd3724sm19509485ad.0.2026.04.15.04.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:14:19 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 0/6] mm: Fix vmemmap optimization accounting and initialization
Date: Wed, 15 Apr 2026 19:14:06 +0800
Message-Id: <20260415111412.1003526-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
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

This patch series fixes a number of issues related to vmemmap optimization
for compound pages (e.g., DAX), including incorrect page accounting and
missing architecture-specific initialization steps.

The series addresses these issues through the following steps:
- Patch 1: Fixes a vmemmap accounting underflow in error paths.
- Patch 2-3: Fixes DAX vmemmap accounting by plumbing the pgmap
  argument through memory deactivation paths.
- Patch 4-5: Fixes missing architecture-specific page table syncs by
  plumbing the pgmap argument through vmemmap_populate APIs.
- Patch 6: Fixes pageblock migratetype initialization for large
  compound ZONE_DEVICE pages.

Changelog:
v1 -> v2:
- Moved vmemmap accounting to populate_section_memmap() /
  depopulate_section_memmap() to fix accounting underflow,
  suggested by Mike.
- Replaced VM_BUG_ON with VM_WARN_ON_ONCE as requested by David.
- Reduced frequency of calling cond_resched() in pageblock_migratetype_init_range()
  based on feedback from David and Mike.
- Extracted all bugfix patches from a larger patchset
  (https://lore.kernel.org/linux-mm/20260405125240.2558577-1-songmuchun@bytedance.com/)
  into this separate patchset, suggested by David.

Muchun Song (6):
  mm/sparse-vmemmap: Fix vmemmap accounting underflow
  mm/sparse-vmemmap: Pass @pgmap argument to memory deactivation paths
  mm/sparse-vmemmap: Fix DAX vmemmap accounting with optimization
  mm/sparse-vmemmap: Pass @pgmap argument to arch vmemmap_populate()
  mm/sparse-vmemmap: Fix missing architecture-specific page table sync
  mm/mm_init: Fix pageblock migratetype for ZONE_DEVICE compound pages

 arch/arm64/mm/mmu.c                        | 11 +--
 arch/loongarch/mm/init.c                   | 12 +--
 arch/powerpc/include/asm/book3s/64/radix.h |  9 +--
 arch/powerpc/mm/book3s64/radix_pgtable.c   | 18 +++--
 arch/powerpc/mm/init_64.c                  |  4 +-
 arch/powerpc/mm/mem.c                      |  5 +-
 arch/riscv/mm/init.c                       |  9 ++-
 arch/s390/mm/init.c                        |  5 +-
 arch/s390/mm/vmem.c                        |  2 +-
 arch/sparc/mm/init_64.c                    |  5 +-
 arch/x86/mm/init_64.c                      | 13 +--
 include/linux/memory_hotplug.h             |  8 +-
 include/linux/mm.h                         |  8 +-
 mm/hugetlb_vmemmap.c                       |  4 +-
 mm/memory_hotplug.c                        | 12 +--
 mm/memremap.c                              |  4 +-
 mm/mm_init.c                               | 42 ++++++----
 mm/sparse-vmemmap.c                        | 93 ++++++++++++++--------
 18 files changed, 160 insertions(+), 104 deletions(-)

-- 
2.20.1


