Return-Path: <galak@freescale.com>
Date: Thu, 7 Apr 2005 14:26:05 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0504071414230.5277@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Allow adjust of pfn offset in pte
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew,

Allow the pfn to be offset by more than just PAGE_SHIFT in the pte.  
Today, PAGE_SHIFT tends to allow us to have 12-bits of flags in the pte.  
In the future if we have a larger pte we can allocate more bits for flags 
by offsetting the pfn even further.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---

diff -Nru a/include/asm-ppc/pgtable.h b/include/asm-ppc/pgtable.h
--- a/include/asm-ppc/pgtable.h	2005-04-07 14:25:07 -05:00
+++ b/include/asm-ppc/pgtable.h	2005-04-07 14:25:07 -05:00
@@ -431,10 +431,15 @@
  * Conversions between PTE values and page frame numbers.
  */
 
-#define pte_pfn(x)		(pte_val(x) >> PAGE_SHIFT)
+/* in some case we want to additionaly adjust where the pfn is in the pte to
+ * allow room for more flags */
+#define PFN_SHIFT_OFFSET	(PAGE_SHIFT)
+
+#define pte_pfn(x)		(pte_val(x) >> PFN_SHIFT_OFFSET)
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 
-#define pfn_pte(pfn, prot)	__pte(((pte_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
+#define pfn_pte(pfn, prot)	__pte(((pte_basic_t)(pfn) << PFN_SHIFT_OFFSET) |\
+					pgprot_val(prot))
 #define mk_pte(page, prot)	pfn_pte(page_to_pfn(page), prot)
 
 /*
