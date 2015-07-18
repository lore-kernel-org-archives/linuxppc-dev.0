Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0121.outbound.protection.outlook.com [207.46.100.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A828D1A0CEC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2015 05:25:16 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Scott Wood <scottwood@freescale.com>
Subject: [PATCH 1/2] powerpc/booke64: Move mb() to __set_pte_at() with
 kernel-addr test
Date: Sat, 18 Jul 2015 14:24:57 -0500
Message-ID: <1437247498-6027-1-git-send-email-scottwood@freescale.com>
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

map_kernel() doesn't catch all places that create kernel PTEs.  In
particular, vmalloc() calls set_pte_at() directly.  This causes a
crash when booting a non-SMP kernel on e6500.

Move the sync to __set_pte(), to be executed only for kernel addresses.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/pgtable.h | 11 +++++++++++
 arch/powerpc/mm/pgtable_64.c       | 10 ----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 11a3863..0717693 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -169,6 +169,17 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	 * cases, and 32-bit non-hash with 32-bit PTEs.
 	 */
 	*ptep = pte;
+
+#ifdef CONFIG_PPC_BOOK3E_64
+	/*
+	 * With hardware tablewalk, a sync is needed to ensure that
+	 * subsequent accesses see the PTE we just wrote.  Unlike userspace
+	 * mappings, we can't tolerate spurious faults, so make sure
+	 * the new PTE will be seen the first time.
+	 */
+	if (is_kernel_addr(addr))
+		mb();
+#endif
 #endif
 }
 
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 876232d..e92cb21 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -149,17 +149,7 @@ int map_kernel_page(unsigned long ea, unsigned long pa, int flags)
 #endif /* !CONFIG_PPC_MMU_NOHASH */
 	}
 
-#ifdef CONFIG_PPC_BOOK3E_64
-	/*
-	 * With hardware tablewalk, a sync is needed to ensure that
-	 * subsequent accesses see the PTE we just wrote.  Unlike userspace
-	 * mappings, we can't tolerate spurious faults, so make sure
-	 * the new PTE will be seen the first time.
-	 */
-	mb();
-#else
 	smp_wmb();
-#endif
 	return 0;
 }
 
-- 
2.1.4
