Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FA2606A327
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jsixuUjz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZvBG1J0jz30V2;
	Thu, 26 Nov 2026 22:16:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795691782;
	cv=none; b=RdfTAlx/K+oMvC4QQo1pgPc0684UDkA5zoHJjiJmJtv3OkQJChDK9gjJoWoZOrwCyBfuyCOHIRPo/fKK2mGPhW8nJvmULGe+WMdf5L2gheV2AtUlNcCTdrHL1gdRUSkhkZ7KbmW9FxQIiYg0CdeSJcva77nkGMT2zGmrgt6SIR/4e2nSMkOfLC3cTxDbJfeFFjlLaQEIms9Nk6AMfu4S3f0zDJMBEST43c/Fqg4JeDDIs6/JjbAoRa6S3hS/uVQ1ECfDl8yXay2aAGaaESBCiOxVOUyXrvw8TX+4xVb9IBSJyb2XlkquWURmSP9dsnzXKd+euaQC94AisXV5R9ZjLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795691782; c=relaxed/relaxed;
	bh=BCQBCDXpqdYanypT2YtxcGDNibGU62xDqSTU0b0C9A0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cDXEDnGY0Wq3vxhtUWqnDvgGe2Ul70mMC31cdpVpt6z87JI4bAeSwfiN3cKkFT9iAU5D/SqDw7VXqu+srqzf7s5+WEyoWRq02vktR/4m3qaJbtrUvQ6IBM00PYN5OsWkIhiXCcE5AOsD2v77ZXcRi/h3wYwyxT3SZYd8SKdIbOIyMCpdw7OCfh1rk58MkR7jDJ0g3rfQVVSDI7qGj7VK95RqDzbdrTrJi2LbcBSyDzieGap1iCewm2n9L/r9amkDQYLwXExO06lWGWGb7m9zbD4qku30eVKmiReQMWSTSua9+sWupWWO+1+z20Js5VgxcEwC2IXfs9oiF6kqCYtE2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jsixuUjz; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jsixuUjz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZvBF2csWz2yMP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:16:21 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6E34B61E12;
	Thu, 26 Nov 2026 11:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E67C1F000CA;
	Thu, 26 Nov 2026 11:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691778;
	bh=BCQBCDXpqdYanypT2YtxcGDNibGU62xDqSTU0b0C9A0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jsixuUjzPcdBYEMxRDCOOb4MWFDZOSZu3LunR9YGzkmsdmtoC4JNE2Nzl7MiPl479
	 h/Ssi0m6nbfaQkZG7ARE/Sg/GV155f3Gr/QpUYyWC+SKFd215tncf/YeaPE2rO/CFB
	 E8aT8bUhn3tNrPe1JQadaznrSOTvvA8X7vbZ+RnHQs1l22+QRRO+V9C+/Erc+YCwRD
	 Kris64innIDAw3YgXAgPQZV8KQhnkPeuyeVXpTjrDC1d9ZFrOXf61LHh3EoEg5m7da
	 +OWThIPiWSYLii/UzW4ZLpV2NlAHrQ4Nu7GY9DZOLGb7FgK1vdTPT45o81+fISEFoq
	 M3X9Md68fnF1w==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:24 +0200
Subject: [PATCH RFC v2 11/54] x86/mm/pat: drop the init_mm read lock from
 change_page_attr_set_clr()
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-11-723f1e33c3d8@kernel.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

change_page_attr_set_clr() holds the init_mm read lock so that a collapse
of large pages, which holds the write lock, cannot free a page table under
a CPA lookup.

Since commit 1aac65f3e651 ("x86/mm/pat: Take cpa_lock around large-page
collapse") the collapse holds cpa_lock as well, and with debug_pagealloc no
longer using CPA, cpa_lock is enough to synchronize all CPA operations.

The only thing mmap_read_lock() adds is keeping out a concurrent ptdump.

A ptdump racing with any CPA operation except collapse is safe: only a
collapse frees page tables, and a split replaces a leaf with a complete
page table. The only difference without mmap_read_lock() in CPA is that
ptdump may show some entries before and some after the change.

Collapse, though, must keep the mmap_write_lock() to ensure ptdump and text
poking are not accessing page tables the collapse frees.

Remove mmap_read_lock() and CPA_ST_INIT_MM_LOCKED from CPA operations to
simplify its locking model.

Update the comments of cpa_lock and of the mmap_write_lock() around the
collapse to clearly state what they serialize.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index c3af82788879..e1abc0d1d143 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -61,9 +61,10 @@ enum cpa_warn {
 static const int cpa_warn_level = CPA_PROTECT;
 
 /*
- * Serialize cpa() using cpa_lock so that we don't allow any other cpu, with
- * stale large tlb entries, to change the page attribute in parallel to some
- * other cpu splitting a large page entry along with changing the attribute.
+ * Serialize CPA using cpa_lock so that:
+ * - concurrent requests don't split or change the same large mapping at the
+ *   same time
+ * - collapses of large mappings don't free page tables under a CPA lookup
  */
 static DEFINE_SPINLOCK(cpa_lock);
 
@@ -78,7 +79,6 @@ static DEFINE_SPINLOCK(cpa_lock);
 #define CPA_ST_FLUSH_ALL	0x02 /* flush the entire TLB */
 #define CPA_ST_ALIAS		0x04 /* the request is for an alias */
 #define CPA_ST_STATIC_PROT	0x08 /* enforce static protections in a split */
-#define CPA_ST_INIT_MM_LOCKED	0x10 /* init_mm's mmap lock is held */
 
 static inline pgprot_t cachemode2pgprot(enum page_cache_mode pcm)
 {
@@ -1238,11 +1238,7 @@ static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
 	int ret;
 
 	spin_unlock(&cpa_lock);
-	if (cpa->state & CPA_ST_INIT_MM_LOCKED)
-		mmap_read_unlock(&init_mm);
 	pte = pte_alloc_one_kernel(&init_mm);
-	if (cpa->state & CPA_ST_INIT_MM_LOCKED)
-		mmap_read_lock(&init_mm);
 	spin_lock(&cpa_lock);
 	if (!pte)
 		return -ENOMEM;
@@ -2110,11 +2106,7 @@ static int change_page_attr_set_clr(unsigned long addr, int numpages,
 	cpa.flags = in_flag;
 	cpa.curpage = 0;
 
-	/* Avoid race with concurrent CPA collapse. */
-	cpa.state = CPA_ST_INIT_MM_LOCKED;
-	scoped_guard(mmap_read_lock, &init_mm)
-		ret = __change_page_attr_set_clr(&cpa);
-	cpa.state &= ~CPA_ST_INIT_MM_LOCKED;
+	ret = __change_page_attr_set_clr(&cpa);
 
 	/*
 	 * Check whether we really changed something:
@@ -2143,10 +2135,10 @@ static int change_page_attr_set_clr(unsigned long addr, int numpages,
 		goto out;
 
 	/*
-	 * Take the mmap write lock on init_mm to:
-	 * - Avoid a use-after-free if raced by ptdump (which takes its own
-	 *   write lock on init_mm).
-	 * - Serialise concurrent CPA walkers.
+	 * Take the mmap write lock on init_mm to avoid a use-after-free if
+	 * there is a race with
+	 * - ptdump (which takes its own write lock on init_mm)
+	 * - text poking (which takes the read lock around vmalloc_to_page())
 	 */
 	scoped_guard(mmap_write_lock, &init_mm) {
 		guard(spinlock)(&cpa_lock);

-- 
2.53.0


