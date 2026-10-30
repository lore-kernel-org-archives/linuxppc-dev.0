Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ED3606A31D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=M+ve6834
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGNHq0X6wz30W9;
	Sat, 31 Oct 2026 01:08:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793369335;
	cv=none; b=N4R7vgIl8dVK+JHNOte4jLvPc4tLze788rrW0ebk/2DMVvMXusH49snf12DfOUIOg/YqFNqvnrj0w3x7C4KEo8Zh9nIx8SyWw8MXawUXd4jji+xkFnPXV3I8htBtDZEkup/5qkx3xESUZIlVxWjKnjpxqk0SIHpCj/dH+FvGc41XYLuAtKy3N8gyxK28tP70zzw1pdMsWB7JMTNBX1s4O+09ClfXo59FCdIzKUmEVcovnAyW5tBs1WaZCxA4hAWfl3jVzrihcJsIUFo+9ZdFWfqVFSYVQPPlS1tALO9R7nt9SdQeAFuyspXXwU9jN3DNr22LdyXQBHxYwCVlSAAbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793369335; c=relaxed/relaxed;
	bh=QjoN4+6LqE6BOGR2vrR9uNSgacxzY3BRDUxvEZuPaiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Co+u6YlZW8x2JUVHaEsXIc+XQtHreiOLmYzv2VSaOHL55ZU27ijP9SDql0TQa4pEvfSHbXQjY9p0AfnS1nO+Zj7YNus7VKUdNO2w1ydw0qKo1M5zq0T8m/VsZ7J+aREwTsc4nz3xwMNM0o/hn6XIU6e9lwRR4X0D/m8xrLApChazykngSikGXUExyKKKSgSHMZdrCzCD7EO1mmM+YrUSEQMSjeNWmKD/1UEeIlZ3hviZhA4hg4L6Dsy2v1D5jqnIYRKMkW+6/dAV0XXbYq/xeVUjPbgLCjCFxthMjpeXhLRFzYjczLtlKD14eGZ+0yP79XRH8EKVGFWbI6Oz0M627w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=M+ve6834; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=M+ve6834;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGNHp2Q2tz30W5
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 01:08:54 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2ea7987517aso5619575ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 07:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793369332; x=1793974132; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QjoN4+6LqE6BOGR2vrR9uNSgacxzY3BRDUxvEZuPaiQ=;
        b=M+ve6834gW2QOl/0YJXq6S/qlASwk88EGhh6WmNe8l7OmJP8ubmB8xa6Kl5Xo5QTeW
         3m+0ByTOIVCERkWT7csrGAQ/oQBb41LgIl/4diiu+Sc5XXTpL+gg6BPLA1Pt238P/BT0
         7QcxkbZ2kwYQDikVbdgcThC72ETmNGzkx6HkvtlfmonygmnLFr52dZ2yuHoX1AyFqBiT
         jLGlwNMy2o6cQhd5sWyE6e21c3YLYcHyM62Tx6ZlGNaPBGVAuONbxznlCfIBTmBEs64Z
         8jxzbN3F01FTE7W0A/Gv4kKH56SDMruSjqERvJT7qTMzEkXw2FoaDt/gjRnuOk5drOwp
         XRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793369332; x=1793974132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QjoN4+6LqE6BOGR2vrR9uNSgacxzY3BRDUxvEZuPaiQ=;
        b=fo9VH6KkqrGOzAtPflOvnqaalQToe6cPJsFNxlY6GWxMXL10OTY8J/IcTxCodBnCRa
         NPNs6gq6QgV1plivBFxD4Nn2iWIuqVT62XN0heU3Izt/gOhprTG4I09wjE4A8r1TuPoO
         WW1HyNDJxsIOzIHjGt2uP9Cn5Iv6EuF4WqPiw9B82G4+SG7V+CU7P+t4ld54naSu2jVe
         +Y2O+yUeISfScxvS3Ft8j/C+eg4Rr2dnVVgvn3NcfumEuniWib95EV5jEPMFdevP+DYn
         VmQfnTI7T+afOOwlSOj4cDGlrXO/Z7S53DmBkgF4j8NmV0JVUIiepeeGeEaY+z9Olz+u
         8q7Q==
X-Forwarded-Encrypted: i=1; AKwUvBziZOu4Rgyl0vDJdo5HN0654xb8rv2TPCBNTX3HezTDmqtpktFZe7TTx1kR9qZcQkxm6q+dcBL+cp1Ka3c=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKe5tZftO0i7FaxHPtC47UDhaxHKxAdLWo04jzZHV86WG1TzlFo
	z4YoJHHQ0lsSlhBO3vGP5AV0/o35gXDy6GUMdbq43ufNf8JZDrDOE6GA7gvwHCQLHW8=
X-Gm-Gg: AYBFou2Qj7RbpWreWSDyyirUkZxpHwfB+lLAxkBaBTxCACxeSCDjDI0cioHTEa3pc9U
	9Up7kPF2oHgQs2MDlup7Fqsjhb+BfwuBCZifQX1ivFG5+Eozd6HWTHsTbX5+d3xLHt6G/53mvqo
	kTvUi2bmIu8VxfxG5P9SeoNbAhCpWNTCbyTDEwiyhai6e9wsfBlG0BCdGQ/e24vbNRBvfGAQStL
	1RBN1+YfhWq5WDlpWFlSDbblmQAt70XRy0mZ5zEwJskA8aWl4YWTPmjsrFUMW098MPFUFE1vBtL
	mktuw5OeYI56Y/Mn7QdwcIMekrwLj2gQ4XrhsknEwawhimcL0VDHMKi5H3qKiOaJjsCuamntLSy
	sbwaYvinBffEW7Z5UcR4DpYecEfII8A4v7AeDUIxztHB2Nl7aafb/LBXZtDYqcnO0Hkyb5jJ/5i
	AHFU5Qv04NbTt9PSqCO+queokAU2XeNWfPu+CR/8LtkcGC344lCyk3zKlmmrX5fk4xFW0xE4il7
	hiGsZrKJfBLS0HCCZuPaLJ0ufLQ+KwijP14AMXDCRnrNs8PpzZy97kk51rzqDVHbORSjxixw2Se
	ZGWaSk8QwQ8S2fHfQDgdfE3PYTE8dl5HLtiIYZdI5kPUQfdtpLmnNX6Mughrh2bIDVVPK95N
X-Received: by 2002:a17:903:2f03:b0:2e9:4f7b:affd with SMTP id d9443c01a7336-2eb36415069mr25082595ad.6.1793369332072;
        Fri, 30 Oct 2026 07:08:52 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3929b27bsm7601795ad.62.2026.10.30.07.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:08:51 -0700 (PDT)
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
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 3/4] mm/sparse-vmemmap: drop vmemmap_can_optimize()
Date: Fri, 30 Oct 2026 22:07:19 +0800
Message-ID: <20261030140720.1256062-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261030140720.1256062-1-songmuchun@bytedance.com>
References: <20261030140720.1256062-1-songmuchun@bytedance.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

section_vmemmap_optimizable() can already decide whether a section uses
vmemmap optimization based on the section compound order. The DAX-specific
vmemmap_can_optimize() helper duplicates that policy, so remove it to
simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm.h  | 37 -------------------------------------
 mm/sparse-vmemmap.c | 11 +++++++++--
 2 files changed, 9 insertions(+), 39 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e875f73b0c6f..4fb48fbe712d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -38,7 +38,6 @@
 #include <linux/bitops.h>
 #include <linux/iommu-debug-pagealloc.h>
 #include <linux/kcsan-checks.h>
-#include <linux/vmemmap-optimization.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -5395,42 +5394,6 @@ static inline void vmem_altmap_free(struct vmem_altmap *altmap,
 }
 #endif
 
-#ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
-static inline bool __vmemmap_can_optimize(struct vmem_altmap *altmap,
-					  struct dev_pagemap *pgmap)
-{
-	unsigned long nr_pages;
-	unsigned long nr_vmemmap_pages;
-
-	if (!IS_ENABLED(CONFIG_VMEMMAP_OPTIMIZATION))
-		return false;
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
-	return !altmap && (nr_vmemmap_pages > VMEMMAP_OPTIMIZATION_PAGES);
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
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 3e9d6617c4bb..43559593107c 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -466,12 +466,20 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 {
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
+	struct mem_section *ms = __pfn_to_section(pfn);
 	int r;
 
 	if (WARN_ON_ONCE(!IS_ALIGNED(pfn, PAGES_PER_SUBSECTION) ||
 		!IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
 		return NULL;
 
+	/*
+	 * Vmemmap optimization is not supported when vmemmap pages are backed
+	 * by an altmap.
+	 */
+	if (altmap && section_vmemmap_optimizable(ms))
+		section_set_compound_order(ms, 0);
+
 	r = vmemmap_populate(start, end, nid, altmap);
 	if (r < 0)
 		return NULL;
@@ -699,10 +707,9 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 	struct mem_section *ms = __pfn_to_section(pfn);
 	struct mem_section_usage *usage = NULL;
 	struct page *memmap;
-	unsigned int order;
+	unsigned int order = pgmap ? pgmap->vmemmap_shift : 0;
 	int rc;
 
-	order = vmemmap_can_optimize(altmap, pgmap) ? pgmap->vmemmap_shift : 0;
 	if (nr_pages < PAGES_PER_SECTION && section_compound_order(ms))
 		return ERR_PTR(-EOPNOTSUPP);
 
-- 
2.54.0


