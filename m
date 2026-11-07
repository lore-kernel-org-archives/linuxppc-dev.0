Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3996606A335
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CoQ7QYaW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMHVT67Kqz2xwM;
	Sun, 08 Nov 2026 00:50:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794059409;
	cv=none; b=gd2V1oiyueDWjqqi6vgcZ0FR1NS0IJUH6k/tqHA+Gy9rcjPVmwFLhKtTK9NSvrXK+ms0J2E9aG2suxjhe/ZSot7jm7YNTI2thbELhCWcMjxC6In33k/Y9Naq5YTBwnFB5js9ok5nwuExQjXw1HavKihsHi+fFRjfJvwSYf3DNP8JysQjP/V2Jnpu+r687WdrCm4RwkaGi8aCOsW0Bpfq6E5ge6IARqgnbofkfK/sry6EN737hSHS78znWaAtMyiIBlax1FY7udDFxoKFmCEbmJe2MVSrVjj9noyDdwAjnKBAgJwcoel27yne7VS6I2aF49eTzzPWjxh1ThIfPZpkRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794059409; c=relaxed/relaxed;
	bh=SZiSpxzoKRu3m4OtR5S8aNLPIx1JblGQq3c/+ycjfuU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=n0fAgb11ya/OFlZhV1A+xZPZc5dHOuVpC9o5X3oMm+mINFkjMViTBOcdkBzwEyJQtxencEFnFKhSpZF0Eqsb5wkLE/zxMIPgFM4JqLS+DOQu0OPJ5rpI+od6Sz7lyxsiylYCeHVJS4NZn1QEpfNATuVjdAOEUqQiuzSkRUTB433ejBZfdkrd/LEng8re03HyJLMu7C0STRsiIi83qU2zjSyI9IhcBqG8gCCanl+m2DTKRtnzZ6bEtnvGFPJkZ7gZM6I4wjFOYFM4EcLq5Y0sUJ06XFTKUu5GSyWSyWV7bwmqr6wl87pgkrd0jP0siPj6HIsVkwU3NqczUNz5EiPoIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CoQ7QYaW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CoQ7QYaW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com [IPv6:2607:f8b0:4864:20::1330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMHVS1ZDHz2xM9
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 00:50:07 +1100 (AEDT)
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso2543648eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 05:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794059403; x=1794664203; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SZiSpxzoKRu3m4OtR5S8aNLPIx1JblGQq3c/+ycjfuU=;
        b=CoQ7QYaWiFw5uDEW1PyIHwe1riRSza0QBGjfDfl9K9RU9kmKZxRneqtypAxoR1tgNZ
         5jQBde4QYkY7t+j/3C7amOlnvktiMtR8gzOHBxsj26PVr/E41FSX7bu/2xFwasZhDeNT
         +/fdijrjTcfJn1NFCs0ld9D8tmwhWJC7qskJb10BEigx3D091y2d1IWd9h4MUA45VdnN
         d0aYffqCbuEYUq+nRuIL88k/TIf5HirIufOE9VHF2NJm2prrkWgDPls/jf/XHgRmHLcD
         8r1dUMnDhexxPtLKAGNXgStejXE/AeNyxvSugfIY7CTMcVwR9H7YmUnBVPyNE+ivdBwS
         cblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794059403; x=1794664203;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SZiSpxzoKRu3m4OtR5S8aNLPIx1JblGQq3c/+ycjfuU=;
        b=NmRgwUeVryIdZlx84alFmXgey3Sw/RlQt08VmC0q9HPKdQTzjNp6bwzbwKMB61ggP6
         3EymBFwvbMLuSz7LJZba/QRlihiPAgQLGECdOfUGITyWJk7YczgJPPj4ITnoII66OCgn
         7R4BVhGnuwpbNVWTBmco1YIbChSQRWr1ZXH8DMyNLQmvPFwpgzFoqSeJGEkzblJxsjH+
         J+Gb1udeVgIDdp1WtJNImlgSoWjCsgr6cf5xwUjIs1eKJRgWT9iIUzBvE+11jQtQdS8y
         Iv1hI1Vy/fTGD4zr43MrLtWRl1bANxsGS51mILPMBkw1m/bO/WweAE95a7A5m48Vkrr5
         TA8w==
X-Forwarded-Encrypted: i=1; AL+hErGQ65H/teF+LXI65aLv8ATj0u1+NU1P/6Bb4I5U7gEJLJsIoPyAOf2KVvw0D/DowRAzV5bXv+ZxdRaw82s=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8JWCIMKOEfbqKhrLJFfnlWzzBd+6Ny1qhC1rKEznoWEZYIKLLg
	7nmPG5LKSUUgw5rKjbe3Zj/2c9fVItCfCl9aoUzR4daihelF0ezCyciO
X-Gm-Gg: AYBFou0UOtF5e9u/2GoD7bZFVdvnIH3i/zZxaUFIAjphxwdXnGkmJSnIsuudpHyf5qa
	9heVO1KxPyFHUPLgGPZAu3gEO7zJ81eg+OshUOZ7Vebka4Mg1o+Oz7eCvtCsA1Wn9XHGnHhJUZX
	xrZhJpgTRTRrhxu6rF4+zcpIXb14FkaxvJq4QWW83b4tH0/rTjPmHQI0BawNuYwVor8NOVdpURQ
	WiTnHb0URYc1a+pR0dNaJQOFdVIJK9evNlL8MDotcz5GTYkoRBPm8JX+UhXEyujD2tbwlVJZk+U
	QAXcNUpunXqfESP5J+GomJRq/r58oqx4j5Zgtfm3MaCP0zy/DafIiiF1qZBigLbMjhBUcHBtN4T
	9sYQbu/c4DdyHLWDyq1lv8+exFXwCdA1448NkAgowCrtfmHl4BuF/UKnm6AobRX49+GamAigAfP
	SgFyXL4J+wjdV+zSQ1JHOxprEjwMjqlyusmNysm6nHBZFx/RYYm4OHD4YaRm/hSEJNSXthnO4a8
	tvvob6T6vKt5DSYzGhBr0yxPLhxSDCQioMSwFD1uuD0Nz9HeeSJiiXLHwrdbWrG1qUOvZJks3+w
	ilgs1//KHsqh9zuPTC4L74msMJUJ+qf00ZlOlC+7cnLpfHkn4mhzTbr2yQ==
X-Received: by 2002:a05:693c:8946:20b0:369:7c:bfce with SMTP id 5a478bee46e88-36f75839375mr8242678eec.14.1794059402392;
        Sat, 07 Nov 2026 05:50:02 -0800 (PST)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa922c6c7sm21280820eec.10.2026.11.07.05.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 05:50:01 -0800 (PST)
From: Wen Jiang <jiangwenxiaomi@gmail.com>
To: akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	urezki@gmail.com,
	linux-mm@kvack.org
Cc: baohua@kernel.org,
	dev.jain@arm.com,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	david@kernel.org,
	rppt@kernel.org,
	leo.yan@arm.com,
	xueyuan.chen21@gmail.com,
	chleroy@kernel.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	ajd@linux.ibm.com,
	jiangwen6@xiaomi.com,
	jiangwenxiaomi@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 00/10] mm/vmalloc: Speed up ioremap, vmalloc and vmap with contiguous memory
Date: Sat,  7 Nov 2026 21:49:43 +0800
Message-Id: <20261107134953.748622-1-jiangwenxiaomi@gmail.com>
X-Mailer: git-send-email 2.34.1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wen Jiang <jiangwen6@xiaomi.com>

This patchset accelerates ioremap, vmalloc, and vmap when the memory is
physically fully or partially contiguous. Two techniques are used:

1. Avoid page table rewalk when setting PTEs/PMDs for multiple memory
   segments
2. Use batched mappings wherever possible in both vmalloc and ARM64
   layers

Besides accelerating the mapping path, this also enables large
mappings (PMD and cont-PTE) for vmap, which are currently not
supported.

Patches 1-4 decouple the PTE-level block mapping path from HugeTLB.
Previously vmap_pte_range() installed cont-PTE mappings by reusing
set_huge_pte_at() and huge_ptep_get_and_clear(), which are HugeTLB
helpers gated by CONFIG_HUGETLB_PAGE. This made the feature silently
unavailable on CONFIG_HUGETLB_PAGE=n kernels, and coupled mm/vmalloc.c
to HugeTLB internals. Patches 1 and 2 add the arm64 and powerpc/8xx
implementations of vmap_pte_set_huge()/vmap_pte_clear_huge().
Patch 3 adds the generic fallbacks and converts mm/vmalloc.c over.
Patch 4 then removes the now-dead init_mm special case from
arm64's clear_flush().

Patch 5 extends ARM64 arch_vmap_pte_range_map_size() to batch multiple
CONT_PTE blocks in one call instead of one at a time.

Patch 6 extracts a common helper vmap_set_ptes() that consolidates PTE
mapping logic for the ioremap and vmalloc/vmap paths, handling both
CONT_PTE and regular PTE mappings. This prepares for the next patch.

Patch 7 extends the page table walk path to support page shifts other
than PAGE_SHIFT and eliminates the page table rewalk for huge vmalloc
mappings. The function is renamed from vmap_small_pages_range_noflush()
to vmap_pages_range_noflush_walk().

Patch 8 extracts vm_shift() to consolidate vmalloc mapping shift
selection for reuse in the batching path.

Patches 9-10 add huge vmap support for contiguous pages, including
support for non-compound pages with pfn alignment verification.

On the RK3588 8-core ARM64 SoC, with tasks pinned to a little core and
the performance CPUfreq policy enabled, benchmark results:

* ioremap(1 MB): 1.35x faster (3407 ns -> 2526 ns)
* vmalloc(1 MB) mapping time (excluding allocation) with
  VM_ALLOW_HUGE_VMAP: 1.42x faster (5.00 us -> 3.53 us)
* vmap(100MB) with order-8 pages: 8.3x faster (1235 us -> 149 us)

Many thanks to Xueyuan Chen for his testing efforts on RK3588 boards.

Large vmap() mappings were also tested by Leo Yan with ARM trace buffer
units, including TRBE and SPE. These units use the CPU page tables for
address translation when writing trace data to DRAM, so using larger
vmap() mapping granules can reduce TLB pressure on the trace writer.

The TRBE test used a 1G CoreSight ETM AUX buffer. Across five runs on an
isolated CPU, the average results were:

* dtlb_walk:       68.4 -> 59.4 (-13.16%)
* l1d_tlb_refill: 155.8 -> 119.6 (-23.23%)
* l2d_tlb_refill: 161435.8 -> 495.0 (-99.69%)

The SPE test used a 512M ARM SPE AUX buffer. Across five runs on an
isolated CPU, the average results were:

* dtlb_walk:       1710.4 -> 1315.6 (-23.08%)
* l1d_tlb_refill: 16000.0 -> 15950.2 (-0.31%)
* l2d_tlb_refill: 4796.0 -> 2931.2 (-38.88%)

These results show that enabling larger vmap() mappings can materially
reduce page table walks and TLB refills for large trace buffers.

Many thanks to Leo Yan for his testing efforts on ARM trace buffers.

Changes since v11:
- Clamp each PTE-level mapping in vmap_pages_pte_range() to the remainder
  of the current physically contiguous chunk. A PMD boundary splitting a
  coalesced vmap() batch in the middle of a chunk could otherwise map past
  the end of the chunk. (patch 7, reported by Sashiko)
- Set VM_UNINITIALIZED on the vmap() area until the mapping is complete,
  so that vread_iter() skips it while vmap_try_huge_pmd() may replace an
  empty PTE table with a PMD. (patches 9 and 10, reported by Sashiko)
- Patches 7, 9 and 10 changed in code. The existing tags are kept,
  Dev and Uladzislau, please take another look.

Changes since v10:
- Rebase onto v7.4-rc1.
- Rename pte_set_huge()/pte_clear_huge() to vmap_pte_set_huge()/
  vmap_pte_clear_huge() to make clear they are vmap helpers rather than
  HugeTLB helpers. (Dev Jain, Uladzislau Rezki)
- Add "Kernel mappings only" comment and alignment VM_WARN_ON() checks
  to vmap_pte_clear_huge(). (Dev Jain)
- Pick up Reviewed-by tags from Uladzislau Rezki and Dev Jain.

Changes since v9:
- Add a VM_WARN_ON() for pte_valid() in pte_set_huge(). (patch 1)
- Update the comment in arch_vmap_pte_range_map_size() to reflect
  the new batching behavior. (patch5)
- Drop the PMD_SIZE cap in arch_vmap_pte_range_map_size(). (patch 5)
- Rename steps to nr_pages in vmap_pte_range() and
  vmap_pages_pte_range(), and use 1U for the PMD page count.
  (patches 6, 7)
- Rename get_vmap_batch_order() to get_vmap_mapping_order(). (patch 9)

Changes since v8:
- Rebase onto v7.3-rc4.
- Rename new_pte to pte in pte_set_huge(). Add a
  VM_WARN_ON for addr alignment. (patch 1)
- Use BUILD_BUG() instead of WARN_ON_ONCE in the
  generic pte_set_huge()/pte_clear_huge() fallbacks. (patch 3)

Changes since v7:
- v7's patch 1 (which extended the hugetlb helpers in
  arch/arm64/mm/hugetlbpage.c) is replaced by pte_set_huge()/
  pte_clear_huge(), split across patches 1-3 so that the arm64,
  powerpc/8xx and generic changes can be reviewed and acked
  independently: patch 1 is arm64 only, patch 2 is powerpc/8xx only,
  patch 3 is the generic fallbacks plus the mm/vmalloc.c conversion.
  hugetlbpage.c no longer gains the CONT_PTE batching hooks, and patch 4
  additionally removes its now-dead init_mm special case. mm/vmalloc.c
  no longer includes <linux/hugetlb.h>.
- The generic pte_set_huge()/pte_clear_huge() fallbacks WARN_ON_ONCE()
  instead of silently doing nothing. They only exist to keep the build
  working on architectures without PTE-level block mappings, where they
  are unreachable (patch 3).
- Patch 5 (v7 patch 2): use round_down(size, CONT_PTE_SIZE) instead of
  rounddown_pow_of_two(size), since pte_set_huge() takes the size directly
  without an ilog2() roundtrip. This lets a single call span several
  CONT_PTE blocks: a 768K (512K + 256K) ioremap is now 1.25x faster than
  v7.
- Patch 6 (v7 patch 3): vmap_set_ptes() now calls pte_set_huge() instead
  of the hugetlb path.
- Patch 9 (v7 patch 6): get_vmap_batch_order() takes pages+i instead of a
  separate idx argument, and applies pfn alignment limit to scan length
  rather than to the resulting order. Renamed idx/map_addr to
  batch_idx/batch_start. Dropped Dev's Reviewed-by.

Changes since v6:
- Add a clarifying comment about the reuse of hugetlb helpers
  by non-hugetlbfs(vmalloc) mm code (patch 1)
- Expand the arm64/vmalloc commit message and comment to clarify that
  multi-CONT_PTE_SIZE values are vmalloc mapping spans, not HugeTLB
  hstate sizes (patch 2)
- Move the local steps variable change in vmap_pte_range() into the
  vmap_set_ptes() extraction patch (patch 3)
- Propagate vmap_pages_pte_range() errors through the upper
  vmap_pages_*() levels instead of returning -ENOMEM for all failures
  (patch 4)
- Add a preparatory vm_shift() helper patch before the batching patch
  (patch 5)
- Guard the PFN alignment clamp in get_vmap_batch_order() against PFN 0
  before calling __ffs() (patch 6)
- Fix kmsan_vmap_pages_range_noflush() indentation in the batching path
  (patch 6)

Changes since v5:
- No code changes.
- Pick up Reviewed-by and Tested-by tags from Dev, Leo and Uladzislau.
  Many thanks!
- Add TRBE/SPE large vmap() test results from Leo Yan to the cover
  letter.

Changes since v4:
- Move pgsize update before contig_ptes check (patch 1)
- Use rounddown_pow_of_two instead of __fls in
  arch_vmap_pte_range_map_size (patch 2)
- Reword comment to avoid mentioning cont_pte and remove if in
  vmap_set_ptes (patch 3)
- Rename vmap_batched() to vmap_pages_range_batched() (patch 5)
- Use batch_end as the batching cursor to avoid an unused start variable
  (patch 5)
- Check arch_vmap_pmd_supported before PMD mapping (patch 6)

Changes since v3:
- Squash vmap_pte_range() loop variable fix into patch 4 (patch 3, 4)
- Use shift >= PMD_SHIFT and fix *nr increment in
  vmap_pages_pmd_range() (patch 4)
- Pass page_shift directly without capping at PMD_SHIFT (patch 4, 5)
- Add vm_shift() helper and pass pgprot_t to get_vmap_batch_order()
  (patch 5)
- Use min(order, __ffs(pfn)) for graceful pfn alignment degradation,
  replacing IS_ALIGNED check (patch 5)
- Remove irrelevant ioremap_max_page_shift early-exit (patch 5)
- Add __get_vm_area_node_aligned_caller() wrapper, rename to
  vmap_get_aligned_vm_area() (patch 6)

Changes since v2:
- Use __fls instead of fls in arch_vmap_pte_range_map_size (patch 2)
- Add WARN_ON checks in vmap_pages_pmd_range (patch 4)
- Fix flush_cache_vmap to use saved start address instead of the
  already-advanced addr (patch 5)
- Rename __vmap_huge() to vmap_batched() (patch 5)
- Add caller parameter and unroll while(1) loop (patch 5)
- Squash patch 7 into patch 5 (stop scanning for compound pages after
  encountering small pages)

Changes since v1:
- Fix condition order and use PMD_SIZE instead of CONT_PMD_SIZE in
  patch 1 (Dev Jain)
- Squash patch 3+4 and patch 5+7 (Dev Jain)
- Replace "zigzag" with "page table rewalk" in commit messages
  (Dev Jain)
- Rename vmap_small_pages_range_noflush() to
  vmap_pages_range_noflush_walk() (Dev Jain)
- Extract vmap_set_ptes() as a new patch to consolidate PTE mapping
  logic between vmap_pte_range() and vmap_pages_pte_range(), handling
  both CONT_PTE and regular mappings (Mike Rapoport)
- Support non-compound pages in get_vmap_batch_order() by falling
  back to physical contiguity scanning with pfn alignment check
  (Dev Jain, Uladzislau Rezki)
- In get_vmap_batch_order(), filter out orders that the architecture
  cannot batch by checking arch_vmap_pte_supported_shift() directly.
  This avoids overhead for orders 1-3 on ARM64 CONT_PTE with 4K
  pages. (patch 5)

Barry Song (Xiaomi) (4):
  arm64/vmalloc: allow arch_vmap_pte_range_map_size() to batch multiple
    CONT_PTE
  mm/vmalloc: extend page table walk to support larger page_shift sizes
    and eliminate page table rewalk
  mm/vmalloc: map contiguous pages in batches for vmap() if possible
  mm/vmalloc: align vm_area so vmap() can batch mappings

Wen Jiang (6):
  arm64/mm: add vmap_pte_set_huge() and vmap_pte_clear_huge()
  powerpc/8xx: add vmap_pte_set_huge()
  mm/vmalloc: use vmap_pte_set_huge()/vmap_pte_clear_huge() for
    PTE-level block mappings
  arm64/hugetlb: drop the init_mm special case in clear_flush()
  mm/vmalloc: extract vmap_set_ptes() to consolidate PTE mapping logic
  mm/vmalloc: extract vm_shift() to consolidate mapping shift selection

 arch/arm64/include/asm/pgtable.h             |   6 +
 arch/arm64/include/asm/vmalloc.h             |  12 +-
 arch/arm64/mm/hugetlbpage.c                  |   5 +-
 arch/arm64/mm/mmu.c                          |  27 ++
 arch/powerpc/include/asm/nohash/32/pte-8xx.h |   4 +
 arch/powerpc/mm/nohash/8xx.c                 |  29 ++
 include/linux/pgtable.h                      |  29 ++
 mm/vmalloc.c                                 | 275 ++++++++++++++-----
 8 files changed, 316 insertions(+), 71 deletions(-)

-- 
2.34.1


