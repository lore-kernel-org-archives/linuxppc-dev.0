Return-Path: <linuxppc-dev+bounces-18345-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA4D103E163
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 10:59:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbQnP5fBDz2yk6;
	Wed, 18 Mar 2026 21:59:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773831561;
	cv=none; b=ZuZVKT0Hn2ARW8nOBJuGtnVGxZuZYqCBKK5furNp4JYf/k/NOXesCuKQcyFzQRfvb6fU9gfZpTtU5jn5lsYbi28f5Go6CBiv5T8/rHwyIP6trPb/+Z8TK1LLvUY/kvqdAPRuPZrghyCdmVxgg1SRdPtK4sBVAuCmx7VS5s8MnoQPRWNeLna7I4V7ce33m6FwyZdxqorNtKsIG5U53Q6P4aaYwW0CXVZmfYqOUg8ImENn6RhwdqsVrWjC94iyQCWhzmrbhF0p37gMRCcIERZ+u0lMKbAuWakqIRM0FORcev6hnUYVWL6KQl19CRVKAF9UTxTKga9O11lwEJN4VFegKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773831561; c=relaxed/relaxed;
	bh=b4TJ14scGXya7L5qIy83bRnI04jJ13R4AZwbJ8XhE5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdZ8H1wAwmpf7psqzbMWUGTe8hCtQMr2UjMQGtZsBcalDaRfTN55Ni89jokhj88vGPulcbb/+vru74F+wpENOSpPhYSE2WZE0FhHAlxc+JXqs/wEKmY5xrqa0+lugoCJDnOx7FJHRyZKt7loLvc08Mni4nGN8lToIM3GWfOkISP6juDJ9tHOS0qR57lqTVEqnHdBTC85ffFO8oVUp4sF86OpzCC5fBCjiBH9RjJTeXge4cjQWgCOWDVmEtdjvXtq4aQHM+HJYewy/caPjy9dmm6n1bycYKcoRzzSgSQ9LaZlhAMiAGmQFkoiTnud/1tDm1gNtFJSGaQxipGp+b5OXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rU9KH6SS; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rU9KH6SS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbQnN5vWtz2yTH
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 21:59:20 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D43484474A;
	Wed, 18 Mar 2026 10:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF89C2BCB2;
	Wed, 18 Mar 2026 10:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773831554;
	bh=Zoj4gf8i7wyLd0/obmXgnP8SmqlA2rGZ2C3jdfoF95I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rU9KH6SSU1eVwCpzSqG52mlBGTcHrnXJ5NciS3FbIP6iXmaONG7+xGMFW+GrF35KS
	 zApVxwPoOJ5fh+Co7piBNJXn3gxE+VHO8+L3iQYdzjxIlcHmmjxtFljUbD8p1qNJoT
	 z/1yZqOnDz1d497ur2v46avMjjrGtSJk9mzG1pXYvXZuFRG3crBPg1olXJFtQVl1yF
	 fNWDB+4gQ6fV+7YL6m3tMRlyfsZiQWIlpYAnNSJ2HqhGu9LvLzjynIP10m2Jc3PE8u
	 h1HkHzkZfEUXm8Q9p8zEJnkpY6RZa5ZmY6CN8WUzLeIxFjjq2BkX7EHPJYF8Wiua/3
	 UCiMaIWQPw4rA==
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
Subject: [PATCH 3/8] mm: move free_reserved_area() to mm/memblock.c
Date: Wed, 18 Mar 2026 12:58:22 +0200
Message-ID: <20260318105827.1358927-4-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318105827.1358927-1-rppt@kernel.org>
References: <20260318105827.1358927-1-rppt@kernel.org>
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
 mm/memblock.c   | 37 ++++++++++++++++++++++++++++++++++++-
 mm/page_alloc.c | 36 ------------------------------------
 2 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index b3ddfdec7a80..8f3010dddc58 100644
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
-- 
2.51.0


