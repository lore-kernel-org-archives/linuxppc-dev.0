Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 90E7767A67
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Feb 2005 16:09:45 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 21 Feb 2005 16:09:33 +1100
Message-Id: <1108962573.5412.1.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] ppc32: fix ptep_test_and_clear_young
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

ppc32's implementation of ptep_test_and_clear_young() has a logic error
which makes it fail to flush the hash table. Thus PAGE_ACCESSED is
almost never set again after beeing cleared (unless something else cause
that hash entry to be flushed).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/include/asm-ppc/pgtable.h
===================================================================
--- linux-work.orig/include/asm-ppc/pgtable.h	2005-01-24 17:09:50.000000000 +1100
+++ linux-work/include/asm-ppc/pgtable.h	2005-02-21 16:00:26.000000000 +1100
@@ -560,12 +560,12 @@
 static inline int ptep_test_and_clear_young(pte_t *ptep)
 {
 	unsigned long old;
-	old = (pte_update(ptep, _PAGE_ACCESSED, 0) & _PAGE_ACCESSED);
+	old = pte_update(ptep, _PAGE_ACCESSED, 0);
 #if _PAGE_HASHPTE != 0
 	if (old & _PAGE_HASHPTE)
 		flush_hash_one_pte(ptep);
 #endif
-	return old != 0;
+	return (old & _PAGE_ACCESSED) != 0;
 }
 
 static inline int ptep_test_and_clear_dirty(pte_t *ptep)
