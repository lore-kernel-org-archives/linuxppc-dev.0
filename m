Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9AA606A329
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 07:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nW0D0jtq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSfHD6YBmz2yHD;
	Mon, 16 Nov 2026 18:14:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::60"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794813240;
	cv=none; b=M+emVLu6E07SzRbal4fyIxHn3nJ35+ridmbDDyMgT1uVXbSKc2Ifl7F1xPVYlwINGv8RXENu32J460tUu1hwFq0LwoJr2OsKSFbZHafUljcvaXHbLyhKrzIyQYOSNzN9ixrlHMPADx5415ImfTR1Z0dbAqbZNc97g64NFAGsvj1DN0KXRU3yOtMedJv32BTxv4e6qZm9ibgS/Fo34LkgADI+EMYV3P0U0SWoplIA0+EglTU4vG+ms15NenxUNFyRxZf1DKpPySlGlzBPeoHTivw3m0CbYut8geb69sN8OmuccNloS9suD0wup2fBCv91RnF6VX7rraW8AidKxX1dSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794813240; c=relaxed/relaxed;
	bh=AOtJc8ArX8+ToyaiTRWaxycd35R3Jnx2kTE6b07ZdMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GZcvpngbHQRIZbI8yBRoLq/GeLGZREdMolBcEfJ0sQ3GMyaZDCSv002ODS0vLZ5KKgS39sh9cAb/fbzoMEb/ZDKv4jrl+E+l6Rc2tAI848DiuaGpZoH62VDRJUnByymnCJDsJD4FgPr/z5dbhCYsz8K86c2OCBu8aLeYIF3dl2jSRb/9W3qS0dLIIRUYzTU/F56PcxnoCJRLCz1y2Gj8s0QQg/3aejQDSB4syBpjHe6TqQaQ9t+wT1eOUVJOrB3Y4dzvW3fR/L8cvZxvIldSwMAl0zS5j4JSMa2Gd9VeTpGW1qHeWaDwgjJ0E/BFxN65DNc5qzCfAQ3aX+gIb6ZXsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nW0D0jtq; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::60; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nW0D0jtq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::60; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-96.mta0.migadu.com [IPv6:2001:41d0:1004:224b::60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSfHC6vFwz2xnn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 18:13:59 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=7/JYJzeyd+b/iRPmzXRLtiBy/A7aQtupMKn/EdxvRIU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794813221; v=1; x=1795418021;
 b=nW0D0jtqi6IQbHFRngaT2zyRdXassmaeVQlNRx4TiqLyjQ8Y2vz17pMg4BjgFljgUXl4meIE
 N5IXqCpfY69OSpwUq+ZvebtoPlDTTPyDSEoXvCIR8d3Uz7XyaZ4OXg+ebyqLSrfCn9l8zY8jpHN
 lcltd8kejcBirorUAS+J6bLA=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 2e79e42b6b187866;
	Mon, 16 Nov 2026 07:13:40 +0000
X-Mizu-Trace-ID: 2e79e42b6b187866
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Hao Ge <hao.ge@linux.dev>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v5 01/11] mm/vmalloc: skip cond_resched() in the vmap unmap paths when atomic
Date: Mon, 16 Nov 2026 15:13:15 +0800
Message-Id: <20261116071325.263682-2-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261116071325.263682-1-hao.ge@linux.dev>
References: <20261116071325.263682-1-hao.ge@linux.dev>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The vmap failure paths can be reached with GFP_ATOMIC or GFP_NOWAIT
since commit b186a94227b7 ("kmsan: remove hard-coded GFP_KERNEL
flags") and commit 8da89ba18ed4 ("mm/vmalloc: handle non-blocking
GFP in __vmalloc_area_node()"), so an undo of a partially installed
mapping may have to run in atomic context, where the cond_resched()
in vunmap_pmd_range() cannot schedule.

Give __vunmap_range_noflush() and kmsan_vunmap_range_noflush() a
can_resched argument and skip the cond_resched() when it is false.
The existing callers are on sleepable paths and pass true, so nothing
changes for them.

Fixes: 47ebd0310e89 ("mm: kmsan: handle alloc failures in kmsan_vmap_pages_range_noflush()")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-178439@kernel.org/
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 include/linux/kmsan.h |  8 ++++++--
 mm/kmsan/hooks.c      | 14 +++++++++-----
 mm/vmalloc.c          | 24 ++++++++++++++----------
 mm/vmalloc.h          |  3 ++-
 4 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index 7da9fd506b39..0016c032d1e7 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -150,11 +150,14 @@ int __must_check kmsan_vmap_pages_range_noflush(unsigned long start,
  * kmsan_vunmap_kernel_range_noflush() - Notify KMSAN about a vunmap.
  * @start: start of vunmapped range.
  * @end:   end of vunmapped range.
+ * @can_resched: whether the unmap walk may call cond_resched(); pass
+ * false from atomic context.
  *
  * KMSAN unmaps the contiguous metadata ranges created by
  * kmsan_map_kernel_range_noflush().
  */
-void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end);
+void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end,
+				bool can_resched);
 
 /**
  * kmsan_ioremap_page_range() - Notify KMSAN about a ioremap_page_range() call.
@@ -355,7 +358,8 @@ static inline int __must_check kmsan_vmap_pages_range_noflush(
 }
 
 static inline void kmsan_vunmap_range_noflush(unsigned long start,
-					      unsigned long end)
+					      unsigned long end,
+					      bool can_resched)
 {
 }
 
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index a706666db097..69008b085658 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -136,10 +136,13 @@ static unsigned long vmalloc_origin(unsigned long addr)
 						 KMSAN_META_ORIGIN);
 }
 
-void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end)
+void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end,
+				bool can_resched)
 {
-	__vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end));
-	__vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end));
+	__vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end),
+			       can_resched);
+	__vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end),
+			       can_resched);
 	flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));
 	flush_cache_vmap(vmalloc_origin(start), vmalloc_origin(end));
 }
@@ -168,8 +171,9 @@ static void kmsan_iounmap_pages(unsigned long start, unsigned long end)
 		if (origin)
 			__free_pages(origin, KMSAN_IOREMAP_META_ORDER);
 	}
-	__vunmap_range_noflush(shadow_start, shadow_end);
-	__vunmap_range_noflush(origin_start, origin_end);
+	/* ioremap metadata mappings are always GFP_KERNEL, so resched is safe. */
+	__vunmap_range_noflush(shadow_start, shadow_end, true);
+	__vunmap_range_noflush(origin_start, origin_end, true);
 	flush_tlb_kernel_range(shadow_start, shadow_end);
 	flush_tlb_kernel_range(origin_start, origin_end);
 }
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ccaf158c5b7f..3c0d9e69b886 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -429,7 +429,7 @@ static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 }
 
 static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
-			     pgtbl_mod_mask *mask)
+			     pgtbl_mod_mask *mask, bool can_resched)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -451,12 +451,14 @@ static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 			continue;
 		vunmap_pte_range(pmd, addr, next, mask);
 
-		cond_resched();
+		/* The undo path may run in atomic context. */
+		if (can_resched)
+			cond_resched();
 	} while (pmd++, addr = next, addr != end);
 }
 
 static void vunmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
-			     pgtbl_mod_mask *mask)
+			     pgtbl_mod_mask *mask, bool can_resched)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -476,12 +478,12 @@ static void vunmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 		}
 		if (pud_none_or_clear_bad(pud))
 			continue;
-		vunmap_pmd_range(pud, addr, next, mask);
+		vunmap_pmd_range(pud, addr, next, mask, can_resched);
 	} while (pud++, addr = next, addr != end);
 }
 
 static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
-			     pgtbl_mod_mask *mask)
+			     pgtbl_mod_mask *mask, bool can_resched)
 {
 	p4d_t *p4d;
 	unsigned long next;
@@ -496,7 +498,7 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
-		vunmap_pud_range(p4d, addr, next, mask);
+		vunmap_pud_range(p4d, addr, next, mask, can_resched);
 	} while (p4d++, addr = next, addr != end);
 }
 
@@ -512,7 +514,8 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
  *
  * This is an internal function only. Do not use outside mm/.
  */
-void __vunmap_range_noflush(unsigned long start, unsigned long end)
+void __vunmap_range_noflush(unsigned long start, unsigned long end,
+			    bool can_resched)
 {
 	unsigned long next;
 	pgd_t *pgd;
@@ -527,7 +530,7 @@ void __vunmap_range_noflush(unsigned long start, unsigned long end)
 			mask |= PGTBL_PGD_MODIFIED;
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		vunmap_p4d_range(pgd, addr, next, &mask);
+		vunmap_p4d_range(pgd, addr, next, &mask, can_resched);
 	} while (pgd++, addr = next, addr != end);
 
 	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
@@ -536,8 +539,9 @@ void __vunmap_range_noflush(unsigned long start, unsigned long end)
 
 void vunmap_range_noflush(unsigned long start, unsigned long end)
 {
-	kmsan_vunmap_range_noflush(start, end);
-	__vunmap_range_noflush(start, end);
+	/* The unmap paths are sleepable, keep the resched point. */
+	kmsan_vunmap_range_noflush(start, end, true);
+	__vunmap_range_noflush(start, end, true);
 }
 
 /**
diff --git a/mm/vmalloc.h b/mm/vmalloc.h
index d8372a4f65c4..4ec114a75f04 100644
--- a/mm/vmalloc.h
+++ b/mm/vmalloc.h
@@ -44,6 +44,7 @@ int __must_check __vmap_pages_range_noflush(unsigned long addr,
 
 void vunmap_range_noflush(unsigned long start, unsigned long end);
 
-void __vunmap_range_noflush(unsigned long start, unsigned long end);
+void __vunmap_range_noflush(unsigned long start, unsigned long end,
+			    bool can_resched);
 
 #endif /* __MM_VMALLOC_H */
-- 
2.25.1


