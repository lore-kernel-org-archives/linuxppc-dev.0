Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9BD606A33F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 06:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=BvpPVbZ7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKsRX45rTz2xJR;
	Thu, 05 Nov 2026 17:12:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793859160;
	cv=none; b=CXpols5NCTeV+t8k0ifTdO6mCJzeW8f0TWdWnUpf/+l4D1yo8q5dSdrIB3OXrMuowcOZmUfJJO90shmXTG+C/pvdfutmf2AnmpH6Fh1CtNIp+qwk1zopP4mubffZddpLriktk0xk8IYx57JUme/X7ZfUNejRt8WNlcoSDyngQ1ytPWqaKFHMwbw5fGVjpskkfwBIieEE5R8+U3mFywzcocwLCY6LRdrysX5SjUzBVgQRdaK/JvKgUKFXRLlJ8j9XmBEjURBG9wHSUzeq97k/PYM0R5XDiQgzdEPd51puiHbY7XcdT3eGlkK5D0EkrbtaaZbF3wbi1bBXO79bpYUZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793859160; c=relaxed/relaxed;
	bh=86mQJyKlXA+m+CUFz+gI1B4tAIO9REzBudSQUtfJrm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QfhxddNtb4bhdH3Tswd7MxsKpMH1Fb+0djqdtdu1KhR+3CWsTRIc9xX01w1ADZMYMgUDuWkIZDjNeOgKKUWIeBdH1+AxXUCh0bqZ5a/F49Y7TYye43muAgKfAEhj4ST8R+7UcnJ6P6xn4ftruTaWu0n+PYJB+Yoek9dy/pCbiS6i3BZYpRLjGc4i83hcZA5TmLkyB7DnUEPgGMonzSLT96icGKeFzw6WRIKnx6Sy61gJcFFoKCgHGj8ABQmhSOnDqu9MWTH9wVfkbLHivMhjzT6W6Ud+HVcRbicSXP2SNkefHdYrJuCucDk421c6ww7kgkXg1pi+PTExkKrzdyMPlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=BvpPVbZ7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=BvpPVbZ7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKsRV0KPmz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 17:12:36 +1100 (AEDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-3b09a65c76dso1089185a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 22:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793859154; x=1794463954; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=86mQJyKlXA+m+CUFz+gI1B4tAIO9REzBudSQUtfJrm0=;
        b=BvpPVbZ7f2pVETPkdtG9NlSz2MUfDuuuLeJF1RWuP/0bHY8R/cYYfK8Q8p7C0eluY2
         MiQFzqWUejhXTtRT2WLMyQJbb43sRR75AN/mr6Q+lt47jmVNL9/WvAi31Po619XLThFS
         o52r7Psi2dXELjfYiJAUJ8oPnwH0kAWQ/M0S1wKXsbhCskT42accTujAmeM67Uk5j1lZ
         DdocWmt72UMq15E694K/UV5HE8CxUhC02vNvEW5pJaXSxhy4ZRZroQatX9zpL48vmpW1
         q34iae0nsj6Hp31JMvleax1LCK1AZIP6S4Kn+IfSbl6ZtGcGaOiQJd1vmFtcSI69qCPE
         lBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793859154; x=1794463954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=86mQJyKlXA+m+CUFz+gI1B4tAIO9REzBudSQUtfJrm0=;
        b=sp03QXEjAYywmHMpTlUf7vCqyopZ0RnlgdnfUUpbgIL9oN6AHPF4ornD9R9Q5IhgxD
         4Ad2sceJe/m5VFQkGgOoPM5ZZYcRFMLDvyr8GpFS1P75fUs+yV+SgMrshG78tVB6/IOE
         oNWj3pn1VjitHkj74qG8rc0/IIDZdp/xZAugxtQGFGdAqOHk4ezGAlzYZ5/pxk9UxBFa
         JJEwYfBIUsWoCPX7VuynvQ9lRHJ424eHKCJ0InChHpRC4YY0HlDrCS8vFSajvVtSWmaz
         cO6vZnPDzzLeOMg7141MBYwXCP0aXhEZk632gntXjOR1ehPKSYuS962eYfyL6lq7d9hs
         gHVA==
X-Forwarded-Encrypted: i=1; AKwUvBwIVe/AjjRNsg+mgZt3l7mX2OT6Cbe6s/T1GOEEhC3y+C1FhOZB3gaoDP5fmUqW6ZHS/+1YowWfZASOaNc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9i3szdT6IuocpmGniiZr73Ayg6XK39CIDEeH6zIMiT3V+YTOBm
	p4O2i93kMI4dly1z1EeracwyHLaMtTjpIxkfyG9pxwZL+dYD8rydbCYxDBV5f2A45LI=
X-Gm-Gg: AYBFou2lnE/1+IeI5XuK2noCIZAJcKDjS1C7MkEpzhJRZvS4D3QUpOjudI8+IwtDuCg
	iEyriS+nD/8Rk696sNSoxPMao2kfhDvbnkpugETwC9mhBGc2iEtdbSvfblLgcZKf2A065HaB5mW
	d1+Dh8SzQixiLpY+zdr5+4ENJKsXU4+M5sOoisSUfPrGVfX+7TTk9SbGSwRxnWO0VDY4h9qQZGt
	0Hb/GEvYmLKVyCJUKfKX2LlgtmDakRcWeceFS9rVDCNBnWTmgwD2Np6i8gHJHkI3BX4FEBQvwSt
	Tp+XLuydELUyAawzFfr4Juj2oZVlwKggDmXp6lexFT/J1/UU/SLMT3q6Jd2QCxczp4/QJnwjdnG
	H2BDMggyE5XJmBGuK5zdkKBvGxd/d2Duk06nPu6ERivr5YQzBDjytLZVvfYo2EOrt1M6F2F/im3
	CRxV1+YERjWOFJoj2ik4qlZHTN9EVl7b27ZKf6ZHXn5nXnjikiQlH9cLMMgp5WnJ06U3+2wGosa
	tLOm0rguUG55fJuHjIAD0CpeAQZqRHL0PqiZwydmhkatyNO7EZ2gyOCvoiv8F2mHnPG10XDH+07
	BuWCdtqUjxMPvNdCb3G9FUrH5EUYuBQw62P8Tffn+xAC8jVrQI0HCBZQjDKAa2+Ojw==
X-Received: by 2002:a17:90b:3844:b0:3ab:36c4:b502 with SMTP id 98e67ed59e1d1-3ae89814e4fmr15532805a91.30.1793859153687;
        Wed, 04 Nov 2026 22:12:33 -0800 (PST)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323a1fdsm2107528a91.5.2026.11.04.22.12.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 22:12:32 -0800 (PST)
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
Subject: [PATCH v2 0/5] mm: Simplify device DAX vmemmap optimization plumbing
Date: Thu,  5 Nov 2026 14:12:12 +0800
Message-ID: <20261105061217.13302-1-songmuchun@bytedance.com>
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

v2:
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

 arch/arm64/mm/mmu.c                        |  5 +-
 arch/loongarch/mm/init.c                   |  7 +--
 arch/powerpc/include/asm/book3s/64/radix.h | 12 -----
 arch/powerpc/mm/book3s64/radix_pgtable.c   | 23 +++------
 arch/powerpc/mm/init_64.c                  |  2 +
 arch/powerpc/mm/mem.c                      |  5 +-
 arch/riscv/mm/init.c                       |  5 +-
 arch/s390/mm/init.c                        |  5 +-
 arch/x86/mm/init_64.c                      |  5 +-
 include/linux/memory_hotplug.h             |  8 ++--
 include/linux/mm.h                         | 40 +---------------
 include/linux/vmemmap-optimization.h       | 56 +++++++++++++++++-----
 mm/memory_hotplug.c                        | 16 +++----
 mm/memremap.c                              |  4 +-
 mm/sparse-vmemmap.c                        | 29 ++++++-----
 mm/sparse.c                                |  6 +--
 mm/sparse.h                                |  5 --
 17 files changed, 97 insertions(+), 136 deletions(-)


base-commit: dba8aba0a9a00ff781c03d82ae534fc6f8c2e263
-- 
2.54.0


