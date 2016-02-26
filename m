Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45BB21A0341
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 11:27:31 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 26 Feb 2016 10:27:29 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6C4912CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 11:27:25 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1Q0RH7M53805112
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 11:27:25 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1Q0Qr1n026925
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 11:26:53 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 2/2] powerpc/mm: Improve readability of update_mmu_cache()
Date: Fri, 26 Feb 2016 11:26:26 +1100
Message-Id: <1456446386-28619-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1456446386-28619-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1456446386-28619-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function is used to update the MMU with software PTE. It can
be called by data access exception handler (0x300) or instruction
access exception handler (0x400). If the function is called by
0x400 handler , the local variable @access is set to _PAGE_EXEC
to indicate the software PTE should have that flag set. When the
function is called by 0x300 handler, @access is set to zero.

This improves the readability of the function by replacing if
statements with switch. No logical changes introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/mm/mem.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index d0f0a51..58b9b31 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -492,7 +492,7 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 	 * We don't need to worry about _PAGE_PRESENT here because we are
 	 * called with either mm->page_table_lock held or ptl lock held
 	 */
-	unsigned long access = 0, trap;
+	unsigned long access, trap;
 
 	/* We only want HPTEs for linux PTEs that have _PAGE_ACCESSED set */
 	if (!pte_young(*ptep) || address >= TASK_SIZE)
@@ -505,13 +505,18 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 	 *
 	 * We also avoid filling the hash if not coming from a fault
 	 */
-	if (current->thread.regs == NULL)
-		return;
-	trap = TRAP(current->thread.regs);
-	if (trap == 0x400)
-		access |= _PAGE_EXEC;
-	else if (trap != 0x300)
+	trap = current->thread.regs ? TRAP(current->thread.regs) : 0UL;
+	switch (trap) {
+	case 0x300:
+		access = 0UL;
+		break;
+	case 0x400:
+		access = _PAGE_EXEC;
+		break;
+	default:
 		return;
+	}
+
 	hash_preload(vma->vm_mm, address, access, trap);
 #endif /* CONFIG_PPC_STD_MMU */
 #if (defined(CONFIG_PPC_BOOK3E_64) || defined(CONFIG_PPC_FSL_BOOK3E)) \
-- 
2.1.0
