Return-Path: <michael@ozlabs.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 13 Jul 2006 17:54:44 +1000
Subject: [PATCH 2/3] Fix a compiler warning in mm/tlb_64.c
In-Reply-To: <1152777279.500377.573076823663.qpush@concordia>
Message-Id: <20060713075443.EA4D167B87@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The compiler doesn't understand that BUG() never returns, so complains that
psize isn't set. Just set it to the normal value, which seems to produce nice
code and keeps gcc happy.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/mm/tlb_64.c |    1 +
 1 file changed, 1 insertion(+)

Index: to-merge/arch/powerpc/mm/tlb_64.c
===================================================================
--- to-merge.orig/arch/powerpc/mm/tlb_64.c
+++ to-merge/arch/powerpc/mm/tlb_64.c
@@ -146,6 +146,7 @@ void hpte_update(struct mm_struct *mm, u
 		psize = mmu_huge_psize;
 #else
 		BUG();
+		psize = pte_pagesize_index(pte); /* shutup gcc */
 #endif
 	} else
 		psize = pte_pagesize_index(pte);
