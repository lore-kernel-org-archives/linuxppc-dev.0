Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CEA606A32C
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 04:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=jLr1BDM+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jM36W4QWlz2y2K;
	Sat, 07 Nov 2026 15:32:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794025923;
	cv=none; b=oIEmtQJWxLXd/2XPwpmcAb2j2AmhPQWueFSuG9YYARuGvq6miDxEElLKpe7CnrUH0QqwhLu5XWjYLEvjaW4d3o7wtt8syuXMDgd2G5FjxFzy694S3Ad7x714cD+Myk9SHNxZ5TruBk7W3GaI8UqRDAAF8EuwhMZ9CNaA2lDKtN5I8ynjeAgDIZuBpfWNcmOtnTnL58u9myGZWdALUU6qkBAUCYd8PwLDra111LG9DC4f4HYVNjMpGGaZLmdSyiaXuFKLyOw5/5i1egnVx9Wov5n+Pc0iLNQfq/tuM5ZrRKjI/5t313JirNsd5oHgT2Xu+xZDq1XDfhDEJx+6rDSUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794025923; c=relaxed/relaxed;
	bh=tMJYIXC5HK/L92Fsjcvgr4iGfrMwtNzZGIshDMxf8u0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hBKDWx9Jvg4XbqwOwtBXhb84j/gPo5wL8/I0kMQMxynqhP9I4XQa5Njiu2V13vm9mvsUUJlBy/W+/3quiktfh94qG4ZZB+tlAqrZQ1+yWPMdjRa1K29eduZRlQFGiMnEADDiPuBaWbZtbxYYT1etKv1JDre619FVK+tOdWsM8BzGGh5+F8sO6/voRFUCLbIHVCUqYjozIn5C+EVY0OGmj515wt+RH7WebmO/No9gGPUKYY39FwCsdqyXkcXFgMrBNhYK7GdSaMmPZcSOR4bo6F1CKWbTQDV34qDaxmBxL2bKun6kvpGp2jFGDXC8PVbgHu6qVMXzghAHgUiPZVZa9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=jLr1BDM+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=jLr1BDM+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jM36V07Srz2xS6
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 15:32:00 +1100 (AEDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-cc147d86bebso163419a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 20:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794025917; x=1794630717; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tMJYIXC5HK/L92Fsjcvgr4iGfrMwtNzZGIshDMxf8u0=;
        b=jLr1BDM+DIS+pt8GNyVZeIpRjCzhn8lsmhibJ1SJNQ6FggDtuY6FM1YnnmIRVqUvyh
         geFM9WjLNM0aR5XcMYLe4zShtXeD9xPwhEBAIRcm8AqFdbJNbMTEny55pksWY+vVKs/V
         FO05drH7zUF5sMl90sE+d8FY2ZDUyPW+SUNB5X30XrxvJ2gw9ZbdEg3fwU5RtXS/fsoS
         4+1ssbdTB76zp9mYzU8hy1frnK/wTVT8eZQey472dMhP6XDKUZZthg0OF4N/5gIkcz32
         b67DMqwAgHgSZ/znvHg6KR87hxKJOakxmHE4XdnsQ0JE1iZJ/lEZneydZbiMB5SmFEgJ
         R0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794025917; x=1794630717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tMJYIXC5HK/L92Fsjcvgr4iGfrMwtNzZGIshDMxf8u0=;
        b=UtnS2eyz0pbJucrkOsHiaIn5a8xzJRaQVL+6vG4uVqtyHdBsJXMAvvIFXOZS9xjWAz
         qqcvF5aNRa1QBxOBnSkOKjSEyc1z5fCv1zbycFzJ20UBfhqbJWaEDNuVU5gGNP3F8HXl
         qGW05xT9WhKV/62Sj+fJXEki+4v0k9hdOnm2OxoUOg9+H+DaJ3aSGLcbnOP2FNTKQdWj
         sXl2NGokqX50ps/GQl+3qmnky6X5RUCiUHVh31hHLTNs7QeYLlCaG1RNVND5Nth/5oU0
         +DO03zbtPgJGw5bijFfOAh/PNQUZzqcOHK1LWx/NmhMhnPrUdnoeadt0U6obUha3Ipyd
         RHlQ==
X-Forwarded-Encrypted: i=1; AL+hErGwAIbyaxn6RJStwifUAQsWO4/JtWnP6QzpCiuq1r7W7Cb/ZLi2utea0VCcIgl6mDVjbYViNJVCVO9m3kQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+TIFrxF1hSWhhJeZYRr0EHrw5t7jwKXl+DFiuJVBaW+GBQ2Okr
	1ndN45Jr3PhDYrjcgBDYBPOschbwCYucH0gOqpoh6G3i6X/aZoqmKgogTqs4ru4wcm0=
X-Gm-Gg: AYBFou07d02YT10NrlaJLFXWMt1n80UNMwSdtD+OpwgaxOuTB0NeXGD90kf/zQIT6Ty
	dPCQIUIbpgzBgFypUsqmZl+J1h5/ETFdAO61L9XeNqxsr9zX1NIaso6odRwC46yz7tBDwTTYKhR
	Yim1u2Fok8PtZMkgH/cZJicqrhhIHUqiBuuzqJrZ9kz8XzjiqDZjUecZC3npIaZpNFwG6DEvUFO
	6o1VCE9Qmtt5uqLzOTqEZVoxW32o0gqQ7/WyD2nf+HvXBpJPKidwOUoPv3xrHqh7CJg6HTdUBjJ
	jGreH4MxCcs0obKcFSg26hUS9G+QiO3NNYOAUxhNAA3xSmCZ0WJ3+32Wyg0TF+9PAEPSa/KJhPG
	QoVW9Ii9RyNgDZKb5fmdNc/MVwDG81PKaO/UlfrZverNi74fqoLTj2/ISep0+LkxAVzb6ryW3Nq
	KcU1GzLiNjK6Hm57BP/zpK4+XdHcNs8IVo4LCX/iP5WpPyVMBmZNYk7Pw6TrOtgVUPE109fd9nS
	X6sHZmEPWeY4O5Xq6fKTa8W58IL2TTY5P3k+6uvCmCr8C+ugyHbWQzWi0brQAMsceO/Lr3hCCA3
	br0OEGFlATXbcGO6QKZHa3BaToaBVNO3425g4ZyfnUEchd8iyFHpBQzxh+4n
X-Received: by 2002:a17:90b:3c0a:b0:3a0:eec6:b065 with SMTP id 98e67ed59e1d1-3b1060a6be4mr758538a91.13.1794025917280;
        Fri, 06 Nov 2026 20:31:57 -0800 (PST)
Received: from G6L4RL2QG9 ([2409:8a00:1832:6900:c8de:13da:804b:a0fa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10584b66bsm1578451a91.14.2026.11.06.20.31.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 20:31:56 -0800 (PST)
From: Muchun Song <songmuchun@bytedance.com>
To: David Hildenbrand <david@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Lance Yang <lance.yang@linux.dev>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <qi.zheng@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 0/5] mm: Simplify device DAX vmemmap optimization plumbing
Date: Sat,  7 Nov 2026 12:31:17 +0800
Message-ID: <20261107043122.25650-1-songmuchun@bytedance.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This series is split out from the earlier, larger series "mm: Generalize
HVO for HugeTLB and device DAX" [1]. While the parent series generalizes
vmemmap optimization across HugeTLB and device DAX, this subset addresses
a single, self-contained step: simplifying the device DAX vmemmap
optimization plumbing.

After device DAX was converted to section-based vmemmap optimization,
whether a mapping can be optimized is carried in mem_section, and the
architecture-specific population path can handle any remaining fallback.
The code still retains the DAX-specific vmemmap_can_optimize() helper, a
PowerPC override, and @pgmap arguments threaded through lower-level
vmemmap population and memory-removal interfaces. These duplicate the
section-order policy and keep otherwise generic paths coupled to
dev_pagemap.

This series removes that obsolete plumbing by consolidating the
optimization policy around memory-section metadata and simplifying the
generic and architecture-specific population paths. This also eliminates
dependencies that are no longer needed once the optimization state is
carried by the memory section.

This leaves the section compound order as the single source of truth for
vmemmap optimization and decouples the generic sparse-vmemmap and
memory-hotplug paths from device DAX.

This is another smaller step toward the broader HVO generalization.

[1] https://lore.kernel.org/20260513130542.35604-1-songmuchun@bytedance.com/

v3:
- Rebase onto mm-new at 684242af7090.
- Move section_vmemmap_optimization_disable() out of line to fix the
  LoongArch header-order build failure (reported by Sashiko and the
  kernel test robot).
- Keep section_vmemmap_optimizable() in mm/sparse.h and leave the
  vmemmap_optimizable_order() relocation in patch 4.
- Tighten the disable helper checks to require one aligned memory
  section.
- Collect Reviewed-by from Lance Yang.

v2: https://lore.kernel.org/20261105061217.13302-1-songmuchun@bytedance.com/
- Rebase onto mm-new at dba8aba0a9a0
- Add section_vmemmap_optimization_disable() and use it for PowerPC,
  LoongArch, and altmap fallbacks.
- Add a LoongArch patch that keeps device DAX vmemmap optimization
  disabled while leaving HugeTLB HVO unchanged.
- Ignore section compound orders that cannot be optimized.
- Add direct vmemmap-optimization.h includes for architecture users.

v1: https://lore.kernel.org/20261030140720.1256062-1-songmuchun@bytedance.com/

Muchun Song (5):
  powerpc/mm: make vmemmap_populate_compound_pages() static
  powerpc/mm: drop powerpc vmemmap_can_optimize()
  loongarch/mm: disable device DAX vmemmap optimization
  mm/sparse-vmemmap: drop vmemmap_can_optimize()
  mm/sparse-vmemmap: drop @pgmap from vmemmap population APIs

 arch/arm64/mm/mmu.c                        |  5 +--
 arch/loongarch/mm/init.c                   |  7 ++--
 arch/powerpc/include/asm/book3s/64/radix.h | 12 ------
 arch/powerpc/mm/book3s64/radix_pgtable.c   | 23 ++++-------
 arch/powerpc/mm/init_64.c                  |  2 +
 arch/powerpc/mm/mem.c                      |  5 +--
 arch/riscv/mm/init.c                       |  5 +--
 arch/s390/mm/init.c                        |  5 +--
 arch/x86/mm/init_64.c                      |  5 +--
 include/linux/memory_hotplug.h             |  8 ++--
 include/linux/mm.h                         | 40 +------------------
 include/linux/vmemmap-optimization.h       | 31 +++++++++------
 mm/memory_hotplug.c                        | 16 ++++----
 mm/memremap.c                              |  4 +-
 mm/sparse-vmemmap.c                        | 46 +++++++++++++++-------
 mm/sparse.c                                |  6 +--
 16 files changed, 89 insertions(+), 131 deletions(-)


base-commit: 684242af7090928ada5e48fd40a0f3a539b3fd5b
-- 
2.54.0


