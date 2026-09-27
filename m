Return-Path: <linuxppc-dev+bounces-28292-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA31C9833E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 02:54:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hspvN21xHz30Tf;
	Sun, 27 Sep 2026 12:54:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790477696;
	cv=none; b=QeWnFhDuulMBb7ME4TFykdY8uiY4mwEQJVjUKCzy8xvRJInrVn5z+H342VqA5dWkmSuxwyCS5sOUkrMV2vllk4GpiJElzI7RbGYt7d1+eUn5I5+baVlFrLW0PzhnvKk9XPS4sSlUXaZ1TC0YR6MEJ/WIqtEHu6sGoYenoIbUDK9UrUwJTZrIphwzr0ir7K9i/mF3MCN/I7cY1yqGMRt/IyG52x5TCrnqI4NjN39LAZQsw0dnGUHpqweep2rFlDeguKr57VEjGPyhc4j3hR3eDr+i1BYQmNtJzdn4tMb3BVQcQqMpZfHsZ/vD7sOCfEcYrGvatmiFmDtU4vaa9XsgeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790477696; c=relaxed/relaxed;
	bh=YdCenWsLNM4fgmWyqHdVLEa8fbYRLFc5Vlv8cacB468=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FZ0rbY8PSp/C51fsWLNgqCEkEkS7e/pXqj7cW3YkzP63qQ48crLNf+879g3GdSaqDViNifA5aVnVxH9XGG30CrMvE95LG9LE4131aOlRIPdEM8W1uXeY1Gvi9C3JT9oeF2LCxSL075iDDUREsijZF6Nxrn8pRhFxRLzmosGkS2f7jPnDozbFubfj8r76e1hJY0xOSDCSiedamqSlgZNCxZfU1TP+SPjRMUAoxWjJso2H8vQY/Fr4lP7sDgXQgi3MY6j5bs4h3kErz86TFZLXjSo8Qu5A/FwZlSGpPZOoY+2A4eoWrMqe+T2sP4odAnRwd51Jj+CC5auAgFHCollfRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=hrEFpGLZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::e; helo=mail-pj2-x0e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=hrEFpGLZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::e; helo=mail-pj2-x0e.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0e.google.com (mail-pj2-x0e.google.com [IPv6:2607:f8b0:4864:39::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hspvK4d5Lz3048
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 12:54:52 +1000 (AEST)
Received: by mail-pj2-x0e.google.com with SMTP id 98e67ed59e1d1-39d654f02baso850229a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 19:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790477690; x=1791082490; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YdCenWsLNM4fgmWyqHdVLEa8fbYRLFc5Vlv8cacB468=;
        b=hrEFpGLZ1mBipFe8b8dH7JmwergTX370zz8v43dpf2ss1LpCOIjapUmWr6qgIm/x2j
         9Aaa5pW8ELtxaE+V/KQ/t6ITq32f6vviNnBtB1hVan2mOuDuTNnJGzyQgpylxEMDjRpo
         MTLl7Vq1Y0+R1J4PEUq7XybCPYnRrv9fjsVWxv5wQX+6QHS/NNQ4+zHvcFoTzR3/w2FC
         gEWpBm34k7iNIfHrAHeZo4/6Hxd/1dyln/WG3hb0b7AJrsx3DVC9rL+oAhAa6EjGn+ER
         BmxaY3tZ1Vk1efh3zqoamGxg5hdzyuaqTKqkWD21GxTjhD4ybIqANUAWnXZ5VxXwcDHO
         NsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790477690; x=1791082490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YdCenWsLNM4fgmWyqHdVLEa8fbYRLFc5Vlv8cacB468=;
        b=JK6hBwqMRjwHDljxyOh6DU+G2LRi1xNYkJqKf+vIgW23ctflZ+Yo5yR6t/y9ZZyP6f
         0FIOO2WHIBwpwDcmGYTVWG9kTPNREDhUH5zZjP8yqCG0lyzWUW5JoUgU5FJiblDsrHK+
         kdc+SMOPiYdhiUaSDi+bdU1o9ijIjrV8eZ80edDTiqhNXN0rKerW9Zre+sSRQitIgGcx
         dCT4f1yqClxvXtfLhzV15IkpYC8iL0GID1fz7gXNgKDQf2mWHcISudqA8XODbHGbG5uM
         x1cwE2czJenU9s6Ar+nkdaTmsgPWq4tYEN/kejfFD2CUKsHTKAw5A1eEpLvO/6VpueAz
         j5ug==
X-Forwarded-Encrypted: i=1; AKwUvBzhX5dAHk1ro2jjRZim5rNqZqOqcXF18s50Klwp6OSoaopq9I4krOgHgb+lK0ibPcxYqL+uIVVmlCV2BXo=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYL3zEJc7/bYRrMBbUxlVpmE+qW8PjkRmF6Dn73ixPXXCN1zftB7
	9tz3BIzyoIIzN4KPyiVqvPfIwDb64PMyTykd4If4uR1iSeQ/ngt5pIVig+mRH3E9LUI=
X-Gm-Gg: AYBFou0vov/j+SsTtER7QF3UCXbS7Ma9l6uV9tFnwZBQIg+5Otn4aNFJrP3ZNVyl3Hf
	h2UfPSaFT2DwOPM9/lwDtRPkT1qo2tn6xvYuyiW8zQq9Pes3XJ3imKaBi7ObKJ8ed0SO62FrEgC
	nG304BPHIMqotFpFRvmSX7Sc8FN1l60g0nzdi/abfmdIe9AeC7cXtxewxToVIeP4dYLBpt+2YLQ
	TIYlW8kP0PIYqE0mPbewjCnLbBL5LYcepCd8xBeiqwQdifb+I5ahcWZ9KtpVH7nEvx920b+KROk
	qCRNdFSRbIHfZBTk6jyxexvXuIExC8eaBbYrkaccR2WyaM2rzx01xnFKH8G/aKzBcH3YtecsW8T
	3FqkRKGaCjF39xQVrNkGlzXvUBjQKg8Go82UuFxoevJxVTqt8+xVVvWA84LvJ95QCa6LaoefAdU
	+7o2AIcbK85RsBt2br0M23I23LYhOX+To7C6QJda/0yrhrsRHzKQUm/72uvoFjmLg4nSSWZq/eh
	nYj+qzCBPa6ILuMxJX3
X-Received: by 2002:a17:90b:1652:b0:3a0:9640:8043 with SMTP id 98e67ed59e1d1-3a098ccdd41mr8412652a91.15.1790477689681;
        Sat, 26 Sep 2026 19:54:49 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efb156sm13461377a91.1.2026.09.26.19.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 19:54:48 -0700 (PDT)
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
	Muchun Song <songmuchun@bytedance.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v5 00/12] mm: Switch device DAX to section-based vmemmap optimization
Date: Sun, 27 Sep 2026 10:54:29 +0800
Message-ID: <20260927025441.741633-1-songmuchun@bytedance.com>
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

[1] https://lore.kernel.org/all/20260513130542.35604-1-songmuchun@bytedance.com/

v5:
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

v4: https://lore.kernel.org/all/20260916064341.1825793-1-songmuchun@bytedance.com/
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

 Documentation/arch/powerpc/vmemmap_dedup.rst  |  90 ++------
 Documentation/mm/vmemmap_dedup.rst            |  32 +--
 MAINTAINERS                                   |   1 +
 arch/loongarch/include/asm/pgtable.h          |   1 +
 arch/powerpc/mm/book3s64/radix_pgtable.c      | 124 +----------
 arch/riscv/mm/init.c                          |   1 +
 arch/x86/entry/vdso/vdso32/fake_32bit_build.h |   2 +-
 fs/Kconfig                                    |   1 +
 include/linux/mm.h                            |   7 +-
 include/linux/mmzone.h                        |  38 ++--
 include/linux/page-flags.h                    |   5 +-
 include/linux/vmemmap-optimization.h          | 115 ++++++++++
 mm/Kconfig                                    |   5 +
 mm/hugetlb.c                                  |   2 +-
 mm/hugetlb_vmemmap.c                          |  31 +--
 mm/internal.h                                 |   9 -
 mm/memory_hotplug.c                           |   6 +-
 mm/mm_init.c                                  |  17 +-
 mm/sparse-vmemmap.c                           | 209 +++++++++---------
 mm/sparse.c                                   |   3 +-
 mm/sparse.h                                   |  81 +------
 21 files changed, 299 insertions(+), 481 deletions(-)
 create mode 100644 include/linux/vmemmap-optimization.h


base-commit: 92068d3f6a4274d952441ba8f46221c3c03787dd
-- 
2.54.0


