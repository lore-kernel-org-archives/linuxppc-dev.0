Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0139.outbound.protection.outlook.com [65.55.169.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF0311A0519
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Dec 2015 09:31:38 +1100 (AEDT)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v2] powerpc/e6500: add locking to hugetlb
Date: Fri, 4 Dec 2015 16:31:13 -0600
Message-ID: <1449268273-8643-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

e6500 has threads but does not have TLB write conditional.  Thus,
the hugetlb code needs to take the same lock that the normal TLB miss
handlers take, to ensure that the tlbsx and tlbwe are atomic.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
v2: Fix trailing whitespace

 arch/powerpc/mm/hugetlbpage-book3e.c | 46 ++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/powerpc/mm/hugetlbpage-book3e.c b/arch/powerpc/mm/hugetlbpage-book3e.c
index ba47aaf..180707e 100644
--- a/arch/powerpc/mm/hugetlbpage-book3e.c
+++ b/arch/powerpc/mm/hugetlbpage-book3e.c
@@ -51,6 +51,48 @@ static inline int mmu_get_tsize(int psize)
 	return mmu_psize_defs[psize].enc;
 }
 
+#if defined(CONFIG_PPC_FSL_BOOK3E) && defined(CONFIG_PPC64)
+#include <asm/paca.h>
+
+static inline void book3e_tlb_lock(void)
+{
+	struct paca_struct *paca = get_paca();
+	unsigned long tmp;
+	int token = smp_processor_id() + 1;
+
+	asm volatile("1: lbarx %0, 0, %1;"
+		     "cmpwi %0, 0;"
+		     "bne 2f;"
+		     "stbcx. %2, 0, %1;"
+		     "bne 1b;"
+		     "b 3f;"
+		     "2: lbzx %0, 0, %1;"
+		     "cmpwi %0, 0;"
+		     "bne 2b;"
+		     "b 1b;"
+		     "3:"
+		     : "=&r" (tmp)
+		     : "r" (&paca->tcd_ptr->lock), "r" (token)
+		     : "memory");
+}
+
+static inline void book3e_tlb_unlock(void)
+{
+	struct paca_struct *paca = get_paca();
+
+	isync();
+	paca->tcd_ptr->lock = 0;
+}
+#else
+static inline void book3e_tlb_lock(void)
+{
+}
+
+static inline void book3e_tlb_unlock(void)
+{
+}
+#endif
+
 static inline int book3e_tlb_exists(unsigned long ea, unsigned long pid)
 {
 	int found = 0;
@@ -109,7 +151,10 @@ void book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea,
 	 */
 	local_irq_save(flags);
 
+	book3e_tlb_lock();
+
 	if (unlikely(book3e_tlb_exists(ea, mm->context.id))) {
+		book3e_tlb_unlock();
 		local_irq_restore(flags);
 		return;
 	}
@@ -141,6 +186,7 @@ void book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea,
 
 	asm volatile ("tlbwe");
 
+	book3e_tlb_unlock();
 	local_irq_restore(flags);
 }
 
-- 
2.5.0
