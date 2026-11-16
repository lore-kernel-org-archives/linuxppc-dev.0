Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AAE606A330
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 12:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oT+R11gA
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSnkW6Zb1z30Vs;
	Mon, 16 Nov 2026 23:49:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794833379;
	cv=none; b=NG3Bckpv+KoM0yi8rXqTOeJJ1K0SLlNTWSVOOw+53mikPh67dF4MR7kKQ9Dc18AU2Xy9DrVR6GbxA68Wpy1yL5ZrrDmAuvrfGkVizbnFPUDcvqTyWeL2oWBT2BPk//AQqQnZbMjAhzzHVlYu8i+YVB/Kayutomvcg4/+ipyDEfkzNDH7HDD9/3sSxF8V1jYj+/dyf1KXVxePZWr+Lqjus5BHpqYQVVTYCjCxxlmaVuOAHbFT+zgafLtQt6N8n1lMqaYQgfQujTPNqYBe/mbp82DNsATnK75nabpiN9fLOlTuxJcT2foPb/5eB9bn+a2T9LVXKMkmofBdY5PWtuF6Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794833379; c=relaxed/relaxed;
	bh=qoB7g+eS1ylSOIwCWgqOZHTyzN8hCooYymexDoSw87s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kj3WAQgy2T8MsdTqeG0tV9LdG7J9vGwOipaZnKExlyL/d5ww2DJbTqmUPBpa1T/Bvd2AMzVOqZ0qegMo9APdxWHK5ojC67IEZQ2/gCk3fy23Y1dpBc7KyX9OzNVMKWZgZPcNsvMw7H2YO2OoZQCpTVYXHxglN7sMpKaqLVkFpdtJJDoVaIdhup4oSThNG3xavsexQ5ufKfc6w1lpdHQuFCaO0eVWJRB74tXjreI/3+ObA46xb9pGMXFuWCmtG7oCiKSJM60i4WpEsyZ4SndhcjrJ3HXCYw3Oq+dZvuX47dkfp6Rvhk3MvGew3YBqsx3e6t2UVkzf0/vZRZQl5DOLMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oT+R11gA; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oT+R11gA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSnkW0CMGz30VX
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 23:49:39 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 23542623F3;
	Mon, 16 Nov 2026 12:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370C91F000C9;
	Mon, 16 Nov 2026 12:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794833376;
	bh=qoB7g+eS1ylSOIwCWgqOZHTyzN8hCooYymexDoSw87s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oT+R11gAH0vSoXIiJOgzL5DZMmDQu0VBOCSu1NCF69MwsOaOw3S5H6STg2aurkm0c
	 vCW0onxviZL+52Xf8/hkUgFDwBhS+P/Xdk8+xVC+TqH3AjBlK2cn2o8M59Bk35+/D+
	 HyuNnlNXE+gcEo2hmCEL4ySU52WuasJXDzj+2Cg9Xso1he/SYgpAqBCZzh6vXCs+Sz
	 tiNjF2YDbfxn06+Z5wAHK6xzHxQ+nicz9fLY2nmzj4XZNUMisfcXrk6CFuCxd/4ztr
	 z8CFOOoCbzImh3vqm+Una6IOlMn+BUfRY0PB69xSwdMElN+DfbcNrS/qi5HthWGdKL
	 mbMs0PLz9MS/w==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Linus Walleij <linusw@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Malin Jonsson <malin.jonsson@est.tech>,
	Matthew Wilcox <willy@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org
Subject: [PATCH v3 09/10] mm: drop HIGHPTE support altogether
Date: Mon, 16 Nov 2026 13:48:31 +0100
Message-ID: <20261116124832.662455-10-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116124832.662455-1-arnd@kernel.org>
References: <20261116124832.662455-1-arnd@kernel.org>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arnd Bergmann <arnd@arndb.de>

With both x86 and arm having dropped CONFIG_HIGHPTE support, no
architecture is left using it, so remove the remnants in common code.

It is likely that further cleanups are possible in the page table
code but those are not obvious from the config options.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/hugetlb.h |  5 +----
 include/linux/mm.h      |  1 -
 include/linux/pgtable.h | 13 -------------
 mm/pgtable-generic.c    | 25 ++++++++++++-------------
 mm/userfaultfd.c        |  6 +-----
 5 files changed, 14 insertions(+), 36 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 58f755e70e96..7c6d191fdf50 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -178,7 +178,6 @@ void hugetlb_bootmem_set_nodes(void);
 
 /* arch callbacks */
 
-#ifndef CONFIG_HIGHPTE
 /*
  * pte_offset_huge() and pte_alloc_huge() are helpers for those architectures
  * which may go down to the lowest PTE level in their huge_pte_offset() and
@@ -193,7 +192,6 @@ static inline pte_t *pte_alloc_huge(struct mm_struct *mm, pmd_t *pmd,
 {
 	return pte_alloc(mm, pmd) ? NULL : pte_offset_huge(pmd, address);
 }
-#endif
 
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz);
@@ -1047,9 +1045,8 @@ static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
 	 */
 	if (size >= PUD_SIZE)
 		return pud_lockptr(mm, (pud_t *) pte);
-	else if (size >= PMD_SIZE || IS_ENABLED(CONFIG_HIGHPTE))
+	else if (size >= PMD_SIZE)
 		return pmd_lockptr(mm, (pmd_t *) pte);
-	/* pte_alloc_huge() only applies with !CONFIG_HIGHPTE */
 	return ptep_lockptr(mm, pte);
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6af3b7008f1a..019de55bd796 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4025,7 +4025,6 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 
 static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
 {
-	BUILD_BUG_ON(IS_ENABLED(CONFIG_HIGHPTE));
 	BUILD_BUG_ON(MAX_PTRS_PER_PTE * sizeof(pte_t) > PAGE_SIZE);
 	return ptlock_ptr(virt_to_ptdesc(pte));
 }
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 780fe849ff8b..594c309b1475 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -100,23 +100,10 @@ static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
 #define pte_offset_kernel pte_offset_kernel
 #endif
 
-#ifdef CONFIG_HIGHPTE
-#define __pte_map(pmd, address) \
-	((pte_t *)kmap_local_page(pmd_page(*(pmd))) + pte_index((address)))
-#define pte_unmap(pte)	do {	\
-	kunmap_local((pte));	\
-	rcu_read_unlock();	\
-} while (0)
-#else
-static inline pte_t *__pte_map(pmd_t *pmd, unsigned long address)
-{
-	return pte_offset_kernel(pmd, address);
-}
 static inline void pte_unmap(pte_t *pte)
 {
 	rcu_read_unlock();
 }
-#endif
 
 void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable);
 
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 6e83ce3801b8..f78b9d874b93 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -314,7 +314,7 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
 		pmd_clear_bad(pmd);
 		goto nomap;
 	}
-	return __pte_map(&pmdval, addr);
+	return pte_offset_kernel(&pmdval, addr);
 nomap:
 	rcu_read_unlock();
 	return NULL;
@@ -353,11 +353,11 @@ pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
  * for read (or for write). In a few cases, it may be used with pmd pointing to
  * a pmd_t already copied to or constructed on the stack.
  *
- * When successful, it returns the pte pointer for addr, with its page table
- * kmapped if necessary (when CONFIG_HIGHPTE), and locked against concurrent
- * modification by software, with a pointer to that spinlock in ptlp (in some
- * configs mm->page_table_lock, in SPLIT_PTLOCK configs a spinlock in table's
- * struct page).  pte_unmap_unlock(pte, ptl) to unlock and unmap afterwards.
+ * When successful, it returns the pte pointer for addr, locked against
+ * concurrent modification by software, with a pointer to that spinlock in ptlp
+ * (in some configs mm->page_table_lock, in SPLIT_PTLOCK configs a spinlock in
+ * table's struct page).  pte_unmap_unlock(pte, ptl) to unlock and unmap
+ * afterwards.
  *
  * But it is unsuccessful, returning NULL with *ptlp unchanged, if there is no
  * page table at *pmd: if, for example, the page table has just been removed,
@@ -366,13 +366,12 @@ pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
  * page table can be safely removed or replaced by THP while holding its lock.)
  *
  * pte_offset_map(pmd, addr), and its internal helper __pte_offset_map() above,
- * just returns the pte pointer for addr, its page table kmapped if necessary;
- * or NULL if there is no page table at *pmd.  It does not attempt to lock the
- * page table, so cannot normally be used when the page table is to be updated,
- * or when entries read must be stable.  But it does take rcu_read_lock(): so
- * that even when page table is racily removed, it remains a valid though empty
- * and disconnected table.  Until pte_unmap(pte) unmaps and rcu_read_unlock()s
- * afterwards.
+ * just returns the pte pointer for addr, or NULL if there is no page table at
+ * *pmd.  It does not attempt to lock the page table, so cannot normally be
+ * used when the page table is to be updated, or when entries read must be
+ * stable.  But it does take rcu_read_lock(): so that even when page table is
+ * racily removed, it remains a valid though empty and disconnected table.
+ * Until pte_unmap(pte) unmaps and rcu_read_unlock()s afterwards.
  *
  * pte_offset_map_ro_nolock(mm, pmd, addr, ptlp), above, is like pte_offset_map();
  * but when successful, it also outputs a pointer to the spinlock in ptlp - as
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 169f681f9849..f6bf476abdcd 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1696,11 +1696,7 @@ static long move_pages_ptes(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd
 		folio_unlock(src_folio);
 		folio_put(src_folio);
 	}
-	/*
-	 * Unmap in reverse order (LIFO) to maintain proper kmap_local
-	 * index ordering when CONFIG_HIGHPTE is enabled. We mapped dst_pte
-	 * first, then src_pte, so we must unmap src_pte first, then dst_pte.
-	 */
+
 	if (src_pte)
 		pte_unmap(src_pte);
 	if (dst_pte)
-- 
2.53.0


