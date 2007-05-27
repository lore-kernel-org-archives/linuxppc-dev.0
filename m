Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 378E7DDEF4
	for <linuxppc-dev@ozlabs.org>; Sun, 27 May 2007 15:18:28 +1000 (EST)
Subject: powerpc: Fix possible access to free pages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Sun, 27 May 2007 15:18:22 +1000
Message-Id: <1180243103.19517.47.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I think whe have a subtle race on ppc64 with the tlb batching. The
common code expects tlb_flush() to actually flush any pending TLB
batch. In does that because it delays all page freeing until after
tlb_flush() is called, in order to ensure no stale reference to
those pages exist in any TLB, thus causing potential access to
the freed data.

However, our tlb_flush only triggers the RCU for freeing page
table pages, it does not currently trigger a flush of a pending
TLB/hash batch, which is, I think, an error. This fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/include/asm-powerpc/tlb.h
===================================================================
--- linux-work.orig/include/asm-powerpc/tlb.h	2007-05-27 15:09:01.000000000 +1000
+++ linux-work/include/asm-powerpc/tlb.h	2007-05-27 15:09:12.000000000 +1000
@@ -38,6 +38,15 @@
 
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
+	struct ppc64_tlb_batch *tlbbatch = &__get_cpu_var(ppc64_tlb_batch);
+
+	/* If there's a TLB batch pending, then we must flush it because the
+	 * pages are going to be freed and we really don't want to have a CPU
+	 * access a freed page because it has a stale TLB
+	 */
+	if (tlbbatch->index)
+		__flush_tlb_pending(tlbbatch);
+
 	pte_free_finish();
 }
 
