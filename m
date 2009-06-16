Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C0441B70CD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 12:54:19 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 16 Jun 2009 12:53:43 +1000
Subject: [PATCH] powerpc/mm: Fix potential access to freed pages when using
	hugetlbfs
Message-Id: <20090616025419.A5581DDD1B@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When using 64k page sizes, our PTE pages are split in two halves,
the second half containing the "extension" used to keep track of
individual 4k pages when not using HW 64k pages.

However, our page tables used for hugetlb have a slightly different
format and don't carry that "second half".

Our code that batched PTEs to be invalidated unconditionally reads
the "second half" (to put it into the batch), which means that when
called to invalidate hugetlb PTEs, it will access unrelated memory.

It breaks when CONFIG_DEBUG_PAGEALLOC is enabled.

This fixes it by only accessing the second half when the _PAGE_COMBO
bit is set in the first half, which indicates that we are dealing with
a "combo" page which represents 16x4k subpages. Anything else shouldn't
have this bit set and thus not require loading from the second half.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---


 arch/powerpc/include/asm/pte-hash64-64k.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-work.orig/arch/powerpc/include/asm/pte-hash64-64k.h	2009-06-16 11:27:05.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/pte-hash64-64k.h	2009-06-16 12:03:29.000000000 +1000
@@ -47,7 +47,8 @@
  * generic accessors and iterators here
  */
 #define __real_pte(e,p) 	((real_pte_t) { \
-	(e), pte_val(*((p) + PTRS_PER_PTE)) })
+			(e), ((e) & _PAGE_COMBO) ? \
+				(pte_val(*((p) + PTRS_PER_PTE))) : 0 })
 #define __rpte_to_hidx(r,index)	((pte_val((r).pte) & _PAGE_COMBO) ? \
         (((r).hidx >> ((index)<<2)) & 0xf) : ((pte_val((r).pte) >> 12) & 0xf))
 #define __rpte_to_pte(r)	((r).pte)
