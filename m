Return-Path: <linuxppc-dev+bounces-19374-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC08EEB577
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 12:58:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpXZQ39bvz302b;
	Sun, 05 Apr 2026 22:58:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775393902;
	cv=none; b=I81xrhPYjVqyzAGEZMKhrTRZi/fCEc727WfD3x4tsvrL1xMv0Rz8KYx5IzYeu1+5AZU4iG0c2eHs+3poqtD5irjOVaiIPEPcpQz1DrSC3sUfUY6hztSkTfrlKch64iTUV7snnQlnouijbKXKQBQ3SgVeBWFcIAtLlkxw74f2rxVHHmFQ+ryDKCsQN3nCRSu1gmV0Dx3IO8c32i1eu/RvN4jRy/OdHMVrphBwsLpjkbsIcfiJTAkt8ct4MD6i8D8x+1YVMc/cx+Mh3AOc7iAxa7m4aCNmDF8/QDSylR3WgDT0tt0IDpyiSXDkLTB586VyaAoc4Mvi4FKA3fAPhfke2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775393902; c=relaxed/relaxed;
	bh=tR6tFFSAYX0KQImZ49bGZfXfFcdkBNLOh7cRjPEro20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NroK2oKxvWeJhV5LujxBgstiV/97LEJ3dmtibxKEL34FFKyXijp/G0AqXJwnXuU+0MJOUgrundUeJonK1AWAQrd/zekibB66AXJgKI3wGsCuVtJXiyDbNstbdaUMXTrM+y9hW7zINuSh94KwfWoUMt5KY3oHeSfvl7BwVwC85TnoUEM39CQeg01Xn+LoHyYDfeg0lKHudB/KmgoN6XMchPlcOBibhpmiKGNIDtuLV+Ys3I3OyV/GJ48G9N9Hf1z9gO2SUYmGQKNf6ZzcCyEvLuXqtt7ZeEs6lsWyJgxCzm1rmL36bwR9ADXQvuArnWfivqbegDGkGsxg5A7jjr/PTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=aWKW18h0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=aWKW18h0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpXZP4snxz2ypV
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 22:58:21 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so1734939a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 05:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775393900; x=1775998700; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tR6tFFSAYX0KQImZ49bGZfXfFcdkBNLOh7cRjPEro20=;
        b=aWKW18h07qO34AnWHC6E/yX3vl6jOG2vkZBzteFhVasbYyIjl6pT890hKFZRUEvs7B
         ijT0Qj0ajEYQ+Sfrp1DACPFug45ERWq30PjZtfPhw8MIQVjatHHnf4yL57aSyxGF8wF3
         hjCGSqxzHpfNrG1+TsK7PTHCtU2KUv9X/CdhxdmVpSEiBB0FJ+OWs9k1Hiy2nUBiaaWp
         Mv2u79kWBPl8kz7n71CB4WRxmn0SkOKO7XzDX8IHzys6vrx3HdH3JRvgzcJg4lciKjLH
         u0Ro12ChImlLOtjia/NuwDhfD1Om6lR7y2nyl444IF3aNW3/8DHptlQJ26FQZG+DTMfy
         MYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775393900; x=1775998700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tR6tFFSAYX0KQImZ49bGZfXfFcdkBNLOh7cRjPEro20=;
        b=dz5uRGh6PrzH63ZCYfaxX/4tnkZLycOAFW+C9t6wbiKzZYEnH1nBBxifg7TveqX+7j
         DrDRI9ENNANLab8iMpQw4Tb8CYO2y9lyn6OHGCSOFO1dEbNtBwrML4u8WETMnU0l5iXl
         VYRFXEAzMgLdg/YjAM/qLCHN82jpDO7M7ZGWKh7P6cRvOzxlARoO2D8iSPhlsrjRlixh
         FFGLmK/EbgqlEgK+BVjqeImc0ZwONtRhY7cqDyo0RzbTiLzJ3KMa4ITykI/c/B+VPJSe
         cKLUi2sGuzTWwW5s7dXCcHF3PaTKVnPKkFDFZLGhfSQUxb0i8Ui8bLBbktmOek4ZVo5m
         oAVA==
X-Forwarded-Encrypted: i=1; AJvYcCUq0eReJtShWAxIOOQbYgKNtJi9pnHfzQ18dV9joWhRRKFgabb0sVKXiyTP+1WvOLivL1Ub2JK/eFdtXyA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwnT736AshFuXMLUP38gi65qYwU9so1KUegl2CBF4N+Lgl3zHgU
	/dU9LsX0YjNZAssNwE4wrc8yA8eCAQbrBud39RKc1JK/gqnDcDHYWPupZiWA9Y+UgY4=
X-Gm-Gg: AeBDietHoRsU3PDtnPNVr6ljiRclsUG4jcUmZ0UPMZ5vraa5qoB3bFIpNeBvmFWl/aD
	kYbrCgGhtBbUmTAzmBkV96DjFVKytzLfCnmHabTKhgSShdu3zf4qkOzHvclWzt79J4j8KV0uFkG
	j2kZcnn8zb9yB/NN8ws9e1h2Z+JO+Qrp+seDauyWPiSMcuDOrdWExipKEWgGG2ZP8CnoxPwQrvL
	vdsdGxw2pTLXFfQ+ZmGxfWjMkOYVWBOBpSvqjlQjcO68wBa8M3Jhz41IHSf4skEhpM816aLZqDd
	ABe8qi3LbTVI2Sbx13C2lIL2P3ORcj0lajP1UBJ6E3Pk2eRR5IHME3SEQQngp6ri/Qr2zwGaGO0
	OCkzH3bMvPxp6K2T2O18sJjYJpiGWJS89BZO1NmnF8JYHNh1+4aKldPh6CnGQY/9NFPukKmY2la
	8w8lCJRiSLsqvHM9AR0PsvQRc/ZyF2z06T84z+j+Nf0MY=
X-Received: by 2002:a17:90b:224e:b0:35b:e51b:1935 with SMTP id 98e67ed59e1d1-35de68cfba8mr8245353a91.17.1775393899744;
        Sun, 05 Apr 2026 05:58:19 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de66b4808sm3748505a91.2.2026.04.05.05.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:58:19 -0700 (PDT)
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
Subject: [PATCH 44/49] mm/sparse-vmemmap: drop ARCH_WANT_OPTIMIZE_DAX_VMEMMAP and simplify checks
Date: Sun,  5 Apr 2026 20:52:35 +0800
Message-Id: <20260405125240.2558577-45-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260405125240.2558577-1-songmuchun@bytedance.com>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
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

Historically, when device DAX vmemmap optimization was introduced, it was
initially implemented as a generic feature within sparse-vmemmap.c. However,
it was later discovered that architectures with specific page table formats
(such as PowerPC with hash translation) would crash because the generic
vmemmap_populate_compound_pages() was unaware of their specific page table
setup (e.g., bolted table entries).

To address this, commit 87a7ae75d738 ("mm/vmemmap/devdax: fix kernel crash
when probing devdax devices") introduced a restrictive config option,
which eventually evolved into ARCH_WANT_OPTIMIZE_DAX_VMEMMAP (via commits
0b376f1e0ff5 and 0b6f15824cc7). This effectively turned a generic
optimization into an opt-in architectural feature.

However, the architecture landscape has evolved. The decision of whether
to apply DAX vmemmap optimization techniques for specific page table formats
is now fully delegated to the architecture-specific implementations (e.g.,
within vmemmap_populate()). The upper-level Kconfig restrictions and the
rigid generic wrapper functions are no longer necessary to prevent crashes,
as the architectures themselves handle the viability of the mappings. If an
architecture does not support DAX vmemmap optimization, it can simply
implement fallback logic similar to what PowerPC does in its
vmemmap_populate() routines.

If the architecture supports neither HugeTLB vmemmap optimization nor DAX
vmemmap optimization, but still wants to reduce code size and disable this
feature entirely, it is now possible to turn off SPARSEMEM_VMEMMAP_OPTIMIZATION.
It is no longer a hidden option, but rather a user-configurable boolean under
the SPARSEMEM_VMEMMAP umbrella.

Therefore, this patch removes the redundant ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
and drops the complicated vmemmap_can_optimize() helper. Instead, we
unify SPARSEMEM_VMEMMAP_OPTIMIZATION as a fundamental core capability that
is enabled by default whenever SPARSEMEM_VMEMMAP is selected.

The check in sparse_add_section() is safely simplified to:
if (!altmap && pgmap && nr_pages == PAGES_PER_SECTION)
which succinctly reflects the prerequisites for the optimization without
unnecessary boilerplate.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/powerpc/Kconfig |  1 -
 arch/riscv/Kconfig   |  1 -
 arch/x86/Kconfig     |  1 -
 include/linux/mm.h   | 34 ----------------------------------
 mm/Kconfig           | 14 ++++++++------
 mm/sparse-vmemmap.c  |  2 +-
 6 files changed, 9 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index da4e2ec2af20..8158d5d0c226 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -184,7 +184,6 @@ config PPC
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	select ARCH_WANT_LD_ORPHAN_WARN
-	select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP	if PPC_RADIX_MMU
 	select ARCH_WANTS_MODULES_DATA_IN_VMALLOC	if PPC_BOOK3S_32 || PPC_8xx
 	select ARCH_WEAK_RELEASE_ACQUIRE
 	select BINFMT_ELF
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 61a9d8d3ea64..a8eccb828e7b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -85,7 +85,6 @@ config RISCV
 	select ARCH_WANT_GENERAL_HUGETLB if !RISCV_ISA_SVNAPOT
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
 	select ARCH_WANT_LD_ORPHAN_WARN if !XIP_KERNEL
-	select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f19625648f0f..83c55e286b40 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -146,7 +146,6 @@ config X86
 	select ARCH_WANT_GENERAL_HUGETLB
 	select ARCH_WANT_HUGE_PMD_SHARE		if X86_64
 	select ARCH_WANT_LD_ORPHAN_WARN
-	select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP	if X86_64
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c36001c9d571..8baa224444be 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4910,40 +4910,6 @@ static inline void vmem_altmap_free(struct vmem_altmap *altmap,
 }
 #endif
 
-#define VMEMMAP_RESERVE_NR	OPTIMIZED_FOLIO_VMEMMAP_PAGES
-#ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
-static inline bool __vmemmap_can_optimize(struct vmem_altmap *altmap,
-					  struct dev_pagemap *pgmap)
-{
-	unsigned long nr_pages;
-	unsigned long nr_vmemmap_pages;
-
-	if (!pgmap || !is_power_of_2(sizeof(struct page)))
-		return false;
-
-	nr_pages = pgmap_vmemmap_nr(pgmap);
-	nr_vmemmap_pages = ((nr_pages * sizeof(struct page)) >> PAGE_SHIFT);
-	/*
-	 * For vmemmap optimization with DAX we need minimum 2 vmemmap
-	 * pages. See layout diagram in Documentation/mm/vmemmap_dedup.rst
-	 */
-	return !altmap && (nr_vmemmap_pages > VMEMMAP_RESERVE_NR);
-}
-/*
- * If we don't have an architecture override, use the generic rule
- */
-#ifndef vmemmap_can_optimize
-#define vmemmap_can_optimize __vmemmap_can_optimize
-#endif
-
-#else
-static inline bool vmemmap_can_optimize(struct vmem_altmap *altmap,
-					   struct dev_pagemap *pgmap)
-{
-	return false;
-}
-#endif
-
 enum mf_flags {
 	MF_COUNT_INCREASED = 1 << 0,
 	MF_ACTION_REQUIRED = 1 << 1,
diff --git a/mm/Kconfig b/mm/Kconfig
index e81aa77182b2..166552d5d69a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -411,17 +411,19 @@ config SPARSEMEM_VMEMMAP
 	  efficient option when sufficient kernel resources are available.
 
 config SPARSEMEM_VMEMMAP_OPTIMIZATION
-	bool
+	bool "Enable Vmemmap Optimization Infrastructure"
+	default y
 	depends on SPARSEMEM_VMEMMAP
+	help
+	  This allows features like HugeTLB and DAX to map multiple contiguous
+	  vmemmap pages to a single underlying physical page to save memory.
+
+	  If unsure, say Y.
 
 #
 # Select this config option from the architecture Kconfig, if it is preferred
-# to enable the feature of HugeTLB/dev_dax vmemmap optimization.
+# to enable the feature of HugeTLB vmemmap optimization.
 #
-config ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
-	bool
-	select SPARSEMEM_VMEMMAP_OPTIMIZATION if SPARSEMEM_VMEMMAP
-
 config ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	bool
 
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index ac2efba9ef92..752a48112504 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -698,7 +698,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 		return ret;
 
 	ms = __nr_to_section(section_nr);
-	if (vmemmap_can_optimize(altmap, pgmap) && nr_pages == PAGES_PER_SECTION) {
+	if (!altmap && pgmap && nr_pages == PAGES_PER_SECTION) {
 		section_set_order(ms, pgmap->vmemmap_shift);
 #ifdef CONFIG_ZONE_DEVICE
 		section_set_zone(ms, ZONE_DEVICE);
-- 
2.20.1


