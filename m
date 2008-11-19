Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D7AF9DDDED
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 02:53:08 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id mAJFr4fh024573
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 09:53:05 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: hash_page_sync should only be used on SMP &
	STD_MMU_32
Date: Wed, 19 Nov 2008 09:53:04 -0600
Message-Id: <1227109984-22195-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Clean up the ifdefs so we only use hash_page_sync if we are
CONFIG_SMP && CONFIG_PPC_STD_MMU_32

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/mm/pgtable_32.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index c31d6d2..44fbc81 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -48,7 +48,7 @@ EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
 
 extern char etext[], _stext[];
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && defined(CONFIG_PPC_STD_MMU_32)
 extern void hash_page_sync(void);
 #endif
 
@@ -127,7 +127,7 @@ pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 
 void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && defined(CONFIG_PPC_STD_MMU_32)
 	hash_page_sync();
 #endif
 	free_page((unsigned long)pte);
@@ -135,7 +135,7 @@ void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 
 void pte_free(struct mm_struct *mm, pgtable_t ptepage)
 {
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && defined(CONFIG_PPC_STD_MMU_32)
 	hash_page_sync();
 #endif
 	pgtable_page_dtor(ptepage);
-- 
1.5.6.5
