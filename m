Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062C8606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cSDndUUz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZvB45M0Xz30V0;
	Thu, 26 Nov 2026 22:16:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795691772;
	cv=none; b=H86REkA7rUOFwYdK/peIfTMbuHXa+ZcpbieW0aRLej/3GcPN9bvEvamrzT4S3dlxMdWWCqUv9QndIG1LRxtsc0KvKo7Fn2Tw2hcF8U/EWTptWdXASIj0/da7u8b7CIqpGfur8+mep/KaxF/0AXMH2wxz3CU+BuJJmo4E9qqpXXtHSENuCB7TsTP+GAeMtZA84+3q+tM69Ksm+qWVLoevDnRvhdMdbGWVmfIxN62aSQLhw5dgZjmNsV0+EXX7KLo5RTCqgLKrQMIJ6Ul1fJe0MwvTEXRwQMPy1XAo7rr8ZTNBnhNvSKpZKdWrgrx3WQ/6VyqbYBBz7EAH2fwLuLwpyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795691772; c=relaxed/relaxed;
	bh=es5ACbySNcsOn5mifmn0sw17oD0NBxslOJGoEpu9y4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MejBwt4KPswZY6P2D2wgdliavVs/jslaI7nSqskZN1ZYADNkBdkchZCmzZbvypmMv3EX092hJ7/mRs4Qt6V6ZE+dJi05+INbgi6qfc7Q2ARwvO40zE0Geb5Tzqx5CJ86iJNYmwhWGrqQW6hqNU/SrlkQhOfteV9Tj7w50bP9kg2AedrkiLs11/c4WnSzkg2ZyCfwPrbf3ScQI7FakKHKw0PXkiXPDlkABdbVxZoyqT6+pTpu+5OZiLv14kV2HlkeqarTFzpdFhrz/fOu0wMlwOKIPS1OES7nbBMRe1AEA6QWkrCuVDh7vOGcSWNkH0yYikmCylhJaWe1vKVRLnjoLg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cSDndUUz; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cSDndUUz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZvB36r1gz308H
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:16:11 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 914B562A0A;
	Thu, 26 Nov 2026 11:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6301F000CA;
	Thu, 26 Nov 2026 11:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691769;
	bh=es5ACbySNcsOn5mifmn0sw17oD0NBxslOJGoEpu9y4U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cSDndUUz9ltRjMWCc1xwCEbOkpe05ultR/LXhUlE6AUSFKfFr+U81WBg1NHJJziN4
	 5BpdWRlhz+dlZkpO0lsm0H8cShz7Xnd+ejDNsr78OZzzhH2VF1SACE9rPuhGkVY1Nm
	 X+JoHHWwKD3W4o+1CnThn7LJ/6BYObVfQsC7W53zeqwXLDZQ8PylSlK0mBA3ZnEg9/
	 YvA8qnUsuE0+ARzPIvKeaVKp31kZDSgUCVZIba9Igp7V+pk6uLJiT2ShBKarTJ0eIg
	 OKdfCkFnY6Z6Ap3nQZc387ovnsZL8wGv72Ts13Qf0gU8AtHbY3uD18PHegoZJ6ivBN
	 6kbaQuYg5fydA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:23 +0200
Subject: [PATCH RFC v2 10/54] x86/mm/pat: stop using CPA for
 debug_pagealloc
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-generic-set-memory-v0-1-v2-10-723f1e33c3d8@kernel.org>
References: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
In-Reply-To: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
To: linux-mm@kvack.org
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Borislav Petkov <bp@alien8.de>, Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, x86@kernel.org
X-Mailer: b4 0.16.1-dev
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With debug_pagealloc, the page allocator unmaps pages from the direct map
when it frees them and maps them back when it allocates them, in whatever
context it runs. It does that with CPA, in a mode of its own.

That mode is the one exception in the locking of CPA: it skips cpa_lock,
and every request checks for it. The exception is easy to get wrong:
commit 5fce67641a3e ("x86/mm/pat: Don't gate cpa_lock on
debug_pagealloc_enabled()") dropped it, and commit 7da514d819a0 ("x86/mm:
Fix and document DEBUG_PAGEALLOC") had to bring it back.

With debug_pagealloc enabled the direct map is mapped with 4K pages, so
mapping or unmapping a page always updates a single existing PTE.

Update the PTEs with apply_to_existing_page_range(), like powerpc and riscv
do, and drop the lockless mode from CPA.

Every request now takes cpa_lock, so cpa_inc_4k_install() does not need
data_race() any more.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 77 +++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 44 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 87c7c7934b42..c3af82788879 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -72,7 +72,6 @@ static DEFINE_SPINLOCK(cpa_lock);
 #define CPA_REQ_COLLAPSE	0x02 /* try to collapse large pages */
 #define CPA_REQ_SPLIT		0x04 /* split large pages */
 #define CPA_REQ_PAGES_ARRAY	0x08
-#define CPA_REQ_DEBUG_PAGEALLOC	0x10
 
 /* cpa_data::state */
 #define CPA_ST_FLUSHTLB		0x01 /* the TLB needs a flush */
@@ -165,7 +164,7 @@ static inline void cpa_inc_2m_checked(void)
 
 static inline void cpa_inc_4k_install(void)
 {
-	data_race(cpa_4k_install++);
+	cpa_4k_install++;
 }
 
 static inline void cpa_inc_lp_sameprot(int level)
@@ -2014,7 +2013,6 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa)
 {
 	unsigned long numpages = cpa->numpages;
 	unsigned long rempages = numpages;
-	bool lock = true;
 	int ret = 0;
 
 	/*
@@ -2024,29 +2022,6 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa)
 	    !(cpa->flags & CPA_REQ_SPLIT))
 		return ret;
 
-	/*
-	 * DEBUG_PAGEALLOC is special; it is called from any context the
-	 * page-allocator is, which violates the normal cpa_lock locking
-	 * rules.
-	 *
-	 * However, since it is part of the page-allocator, things are still
-	 * properly serialized by the page-allocator locking and the fact that
-	 * when a page is owned by the page-allocator, it isn't owned by
-	 * anybody else. That is, you *SHOULD NOT* be calling cpa() on memory
-	 * that isn't allocated.
-	 *
-	 * Additionally, DEBUG_PAGEALLOC ensures (per probe_page_size_mask())
-	 * that the kernel mapping is 4k pages, therefore there are no large
-	 * pages to split/collapse.
-	 *
-	 * Furthermore, the page-allocator strictly manages pages that
-	 * *exist*, avoiding pgd_lock.
-	 *
-	 * Therefore, it is safe to not take cpa_lock.
-	 */
-	if (debug_pagealloc_enabled() && (cpa->flags & CPA_REQ_DEBUG_PAGEALLOC))
-		lock = false;
-
 	while (rempages) {
 		/*
 		 * Store the remaining nr of pages for the large page
@@ -2057,12 +2032,8 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa)
 		if (cpa->flags & CPA_REQ_PAGES_ARRAY)
 			cpa->numpages = 1;
 
-		if (lock) {
-			guard(spinlock)(&cpa_lock);
-			ret = __change_page_attr(cpa);
-		} else {
+		scoped_guard(spinlock, &cpa_lock)
 			ret = __change_page_attr(cpa);
-		}
 		if (ret)
 			goto out;
 
@@ -2651,14 +2622,14 @@ int set_pages_rw(struct page *page, int numpages)
 	return set_memory_rw(addr, numpages);
 }
 
-static int __set_pages_p(struct page *page, int numpages, unsigned int cpa_flags)
+static int __set_pages_p(struct page *page, int numpages)
 {
 	struct cpa_data cpa = { .addr = (unsigned long)page_address(page),
 				.pgd = NULL,
 				.numpages = numpages,
 				.mask_set = __pgprot(_PAGE_PRESENT | _PAGE_RW),
 				.mask_clr = __pgprot(0),
-				.flags = CPA_REQ_NO_CHECK_ALIAS | cpa_flags };
+				.flags = CPA_REQ_NO_CHECK_ALIAS };
 
 	/*
 	 * No alias checking needed for setting present flag. otherwise,
@@ -2669,14 +2640,14 @@ static int __set_pages_p(struct page *page, int numpages, unsigned int cpa_flags
 	return __change_page_attr_set_clr(&cpa);
 }
 
-static int __set_pages_np(struct page *page, int numpages, unsigned int cpa_flags)
+static int __set_pages_np(struct page *page, int numpages)
 {
 	struct cpa_data cpa = { .addr = (unsigned long)page_address(page),
 				.pgd = NULL,
 				.numpages = numpages,
 				.mask_set = __pgprot(0),
 				.mask_clr = __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY),
-				.flags = CPA_REQ_NO_CHECK_ALIAS | cpa_flags };
+				.flags = CPA_REQ_NO_CHECK_ALIAS };
 
 	/*
 	 * No alias checking needed for setting not present flag. otherwise,
@@ -2689,17 +2660,35 @@ static int __set_pages_np(struct page *page, int numpages, unsigned int cpa_flag
 
 int set_direct_map_invalid_noflush(struct page *page, unsigned int nr)
 {
-	return __set_pages_np(page, nr, 0);
+	return __set_pages_np(page, nr);
 }
 
 int set_direct_map_default_noflush(struct page *page, unsigned int nr)
 {
-	return __set_pages_p(page, nr, 0);
+	return __set_pages_p(page, nr);
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
+static int kernel_map_pte(pte_t *ptep, unsigned long addr, void *data)
+{
+	int *enable = data;
+	pte_t pte = ptep_get(ptep);
+	pgprot_t prot = pte_pgprot(pte);
+
+	if (*enable)
+		pgprot_val(prot) |= _PAGE_PRESENT | _PAGE_RW;
+	else
+		pgprot_val(prot) &= ~(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY);
+	prot = pgprot_clear_protnone_bits(prot);
+	set_pte_atomic(ptep, pfn_pte(pte_pfn(pte), prot));
+
+	return 0;
+}
+
 void __kernel_map_pages(struct page *page, int numpages, int enable)
 {
+	unsigned long addr = (unsigned long)page_address(page);
+
 	if (PageHighMem(page))
 		return;
 	if (!enable) {
@@ -2708,14 +2697,14 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
 	}
 
 	/*
-	 * The return value is ignored as the calls cannot fail.
-	 * Large pages for identity mappings are not used at boot time
-	 * and hence no memory allocations during large page split.
+	 * This runs in any context the page allocator does, without locks.
+	 * The allocator owns these pages, so nothing else changes their PTEs,
+	 * and with debug_pagealloc the direct map has only 4K pages (see
+	 * probe_page_size_mask()), so their page tables are never split or
+	 * collapsed.
 	 */
-	if (enable)
-		__set_pages_p(page, numpages, CPA_REQ_DEBUG_PAGEALLOC);
-	else
-		__set_pages_np(page, numpages, CPA_REQ_DEBUG_PAGEALLOC);
+	apply_to_existing_page_range(&init_mm, addr, numpages * PAGE_SIZE,
+				     kernel_map_pte, &enable);
 
 	/*
 	 * We should perform an IPI and flush all tlbs, but that can

-- 
2.53.0


