Return-Path: <linuxppc-dev+bounces-18603-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28E8EC01A0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 07:49:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffQL94HHhz2yZ6;
	Mon, 23 Mar 2026 18:49:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774252177;
	cv=none; b=a9x55hxJn5GaQ8tGk5CgTf4lHv7r5j4PuWy8/hqlD4sKUr+b1ymV4+9NekOEyOR7r10r+TdALDyOgAhrKoLMs0+IjHjjZa/AIHdOaDwoD0PZ1wJOQC5a2uJ1ffai2rSau1qeEd2oXWki4bZbwrrrYQpzOKEqTQhjNnswPBZVaDyqgKc4Fv70t8HpQ+ICco2QFsmMVelMcdbsuJyXNnwvb7PyVjcYL/RGwgL/+Nz8PwceyllBr3bgAlqanpFtwqlCqHFblC9A8IUnark29TOraE+VVCDvHX7vPX1gsqGCh5ZuWpdbKiTjQyd5vz7FWvhgg1XtBfUjn+izkrgGYq2XWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774252177; c=relaxed/relaxed;
	bh=LUoq4AqXxwwvH6idpeZLZNb7HSgeuk0Y/FgULYcntaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kV1iyTIi4AjckjOksREi9ao3nQfQZW3TbGjS1LJBP6YsJt2oij9rSjsoLvtX9s6iG6Mfw9DAZul06RSpAmXPRHqueU5Frcz6qUZiRucnuTo8iIh6mkI8t8C4VlC01iyWPv9t3FgBBCSw9WJDVz5O21acID2tYd4cxt7RQofqLRvQGOsv7fgIxDvrup5riciiv4uSGUHUIXxGfQSr6IlFT1BorC2shkreRqndLcgjZUmq3cnd17AkZR0D5q1ek3nf8cB95BA4F9OtZnnWtq4Uyv/zQ1dLpCqkxATkJJpBgd0FRXlJUlwJqLiGkivftSUbBWt6u6YNOu+9Fs2ofsFQww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mLj2uAa3; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mLj2uAa3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffQL85yHJz2ygp
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 18:49:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1DDA6406E9;
	Mon, 23 Mar 2026 07:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591E2C2BC9E;
	Mon, 23 Mar 2026 07:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774252175;
	bh=BA3ifIM8vMxNHhaniMoWafVGKix2KJOOnEEIB0IJslA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mLj2uAa3+/NwQuaTBTXMkFS5rLYfpWnRharPWCiY5k6pdAcO4J3dmwxqJ62FgiBQQ
	 6QZgWy9Mlf+tLly2+EmiGoDig1TtvZff/B4jJXf2DfbTWewwveYymwfcCOjtHZQiEM
	 A5doCHhRHLPTbVpCiM0WsxIRUNgKw1Bx20fB8JozatJ8LOTL2kl9c4hvj5qA9sfO+n
	 AzfuKIyOe63JrT4uxw94ft2d5Kx2CM1R8jWppspvBEBJEOpyiO3cITWk2VSYdG1nuP
	 qsE5AeX67dLQzBsQgP/eryYFm2ElRC0wJ8E8PQf9c8rRCCLLCxB/Hagi8E4T2A58pl
	 wNxCDVFEoh0Dw==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Potapenko <glider@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andreas Larsson <andreas@gaisler.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brendan Jackman <jackmanb@google.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rob Herring <robh@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Will Deacon <will@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v2 4/9] mm: move free_reserved_area() to mm/memblock.c
Date: Mon, 23 Mar 2026 09:48:31 +0200
Message-ID: <20260323074836.3653702-5-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323074836.3653702-1-rppt@kernel.org>
References: <20260323074836.3653702-1-rppt@kernel.org>
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

free_reserved_area() is related to memblock as it frees reserved memory
back to the buddy allocator, similar to what memblock_free_late() does.

Move free_reserved_area() to mm/memblock.c to prepare for further
consolidation of the functions that free reserved memory.

No functional changes.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/memblock.c                     | 37 ++++++++++++++++++++++++++++++-
 mm/page_alloc.c                   | 36 ------------------------------
 tools/include/linux/mm.h          |  1 +
 tools/testing/memblock/internal.h | 34 +++++++++++++++++++++++++---
 4 files changed, 68 insertions(+), 40 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index d4a02f1750e9..c0896efbee97 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -893,6 +893,42 @@ int __init_memblock memblock_remove(phys_addr_t base, phys_addr_t size)
 	return memblock_remove_range(&memblock.memory, base, size);
 }
 
+unsigned long free_reserved_area(void *start, void *end, int poison, const char *s)
+{
+	void *pos;
+	unsigned long pages = 0;
+
+	start = (void *)PAGE_ALIGN((unsigned long)start);
+	end = (void *)((unsigned long)end & PAGE_MASK);
+	for (pos = start; pos < end; pos += PAGE_SIZE, pages++) {
+		struct page *page = virt_to_page(pos);
+		void *direct_map_addr;
+
+		/*
+		 * 'direct_map_addr' might be different from 'pos'
+		 * because some architectures' virt_to_page()
+		 * work with aliases.  Getting the direct map
+		 * address ensures that we get a _writeable_
+		 * alias for the memset().
+		 */
+		direct_map_addr = page_address(page);
+		/*
+		 * Perform a kasan-unchecked memset() since this memory
+		 * has not been initialized.
+		 */
+		direct_map_addr = kasan_reset_tag(direct_map_addr);
+		if ((unsigned int)poison <= 0xFF)
+			memset(direct_map_addr, poison, PAGE_SIZE);
+
+		free_reserved_page(page);
+	}
+
+	if (pages && s)
+		pr_info("Freeing %s memory: %ldK\n", s, K(pages));
+
+	return pages;
+}
+
 /**
  * memblock_free - free boot memory allocation
  * @ptr: starting address of the  boot memory allocation
@@ -1776,7 +1812,6 @@ void __init memblock_free_late(phys_addr_t base, phys_addr_t size)
 		totalram_pages_inc();
 	}
 }
-
 /*
  * Remaining API functions
  */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2d4b6f1a554e..df3d61253001 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6234,42 +6234,6 @@ void adjust_managed_page_count(struct page *page, long count)
 }
 EXPORT_SYMBOL(adjust_managed_page_count);
 
-unsigned long free_reserved_area(void *start, void *end, int poison, const char *s)
-{
-	void *pos;
-	unsigned long pages = 0;
-
-	start = (void *)PAGE_ALIGN((unsigned long)start);
-	end = (void *)((unsigned long)end & PAGE_MASK);
-	for (pos = start; pos < end; pos += PAGE_SIZE, pages++) {
-		struct page *page = virt_to_page(pos);
-		void *direct_map_addr;
-
-		/*
-		 * 'direct_map_addr' might be different from 'pos'
-		 * because some architectures' virt_to_page()
-		 * work with aliases.  Getting the direct map
-		 * address ensures that we get a _writeable_
-		 * alias for the memset().
-		 */
-		direct_map_addr = page_address(page);
-		/*
-		 * Perform a kasan-unchecked memset() since this memory
-		 * has not been initialized.
-		 */
-		direct_map_addr = kasan_reset_tag(direct_map_addr);
-		if ((unsigned int)poison <= 0xFF)
-			memset(direct_map_addr, poison, PAGE_SIZE);
-
-		free_reserved_page(page);
-	}
-
-	if (pages && s)
-		pr_info("Freeing %s memory: %ldK\n", s, K(pages));
-
-	return pages;
-}
-
 void free_reserved_page(struct page *page)
 {
 	clear_page_tag_ref(page);
diff --git a/tools/include/linux/mm.h b/tools/include/linux/mm.h
index 028f3faf46e7..4407d8396108 100644
--- a/tools/include/linux/mm.h
+++ b/tools/include/linux/mm.h
@@ -17,6 +17,7 @@
 
 #define __va(x) ((void *)((unsigned long)(x)))
 #define __pa(x) ((unsigned long)(x))
+#define __pa_symbol(x) ((unsigned long)(x))
 
 #define pfn_to_page(pfn) ((void *)((pfn) * PAGE_SIZE))
 
diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
index 009b97bbdd22..b72be2968104 100644
--- a/tools/testing/memblock/internal.h
+++ b/tools/testing/memblock/internal.h
@@ -11,9 +11,22 @@ static int memblock_debug = 1;
 
 #define pr_warn_ratelimited(fmt, ...)    printf(fmt, ##__VA_ARGS__)
 
+#define K(x) ((x) << (PAGE_SHIFT-10))
+
 bool mirrored_kernelcore = false;
 
 struct page {};
+static inline void *page_address(struct page *page)
+{
+	BUG();
+	return page;
+}
+
+static inline struct page *virt_to_page(void *virt)
+{
+	BUG();
+	return virt;
+}
 
 void memblock_free_pages(unsigned long pfn, unsigned int order)
 {
@@ -23,10 +36,25 @@ static inline void accept_memory(phys_addr_t start, unsigned long size)
 {
 }
 
-static inline unsigned long free_reserved_area(void *start, void *end,
-					       int poison, const char *s)
+unsigned long free_reserved_area(void *start, void *end, int poison, const char *s);
+void free_reserved_page(struct page *page);
+
+static inline bool deferred_pages_enabled(void)
+{
+	return false;
+}
+
+#define for_each_valid_pfn(pfn, start_pfn, end_pfn)			 \
+	for ((pfn) = (start_pfn); (pfn) < (end_pfn); (pfn)++)
+
+static inline void *kasan_reset_tag(const void *addr)
+{
+	return (void *)addr;
+}
+
+static inline bool __is_kernel(unsigned long addr)
 {
-	return 0;
+	return false;
 }
 
 #endif
-- 
2.53.0


