Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdx2m6J0NzDqnH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 16:38:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Anton Blanchard <anton@samba.org>,
	aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH] powerpc/mm: Use VM_WARN_ONCE() for irqs disabled check
Date: Tue, 28 Jun 2016 16:38:21 +1000
Message-Id: <1467095901-4634-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The check for !arch_irqs_disabled() in find_linux_pte_or_hugepte() is a
debugging aid, and needn't be enabled for production builds.

Switch it to a VM_WARN_ONCE(), which is compiled out when
CONFIG_DEBUG_VM=n.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/pgtable.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index ee09e99097f0..651848039dc4 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -71,10 +71,8 @@ pte_t *__find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
 static inline pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
 					       bool *is_thp, unsigned *shift)
 {
-	if (!arch_irqs_disabled()) {
-		pr_info("%s called with irq enabled\n", __func__);
-		dump_stack();
-	}
+	VM_WARN_ONCE(!arch_irqs_disabled(),
+		     "find_linux_pte_or_hugepte() called with irqs enabled!\n");
 	return __find_linux_pte_or_hugepte(pgdir, ea, is_thp, shift);
 }
 
-- 
2.5.0
