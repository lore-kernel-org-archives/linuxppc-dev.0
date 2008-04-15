Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 949EADE854
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 05:56:34 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: paulus@samba.org
Subject: [PATCH 12/13] [POWERPC] Cleanup pgtable-ppc32.h
Date: Tue, 15 Apr 2008 14:52:30 -0500
Message-Id: <1208289151-2925-13-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1208289151-2925-12-git-send-email-galak@kernel.crashing.org>
References: <1208289151-2925-1-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-2-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-3-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-4-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-5-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-6-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-7-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-8-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-9-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-10-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-11-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-12-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Removed defines KERNEL_PGD_PTRS & USER_PGD_PTRS since they aren't used anywhere
* Changed pmd_page macro to use pfn_to_page so we get proper behavior if
  ARCH_PFN_OFFSET is set as well if we use a different memory model on ppc32.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 include/asm-powerpc/pgtable-ppc32.h |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/include/asm-powerpc/pgtable-ppc32.h b/include/asm-powerpc/pgtable-ppc32.h
index bd5b401..daea769 100644
--- a/include/asm-powerpc/pgtable-ppc32.h
+++ b/include/asm-powerpc/pgtable-ppc32.h
@@ -98,9 +98,6 @@ extern int icache_44x_need_flush;
 #define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
 #define FIRST_USER_ADDRESS	0
 
-#define USER_PGD_PTRS (PAGE_OFFSET >> PGDIR_SHIFT)
-#define KERNEL_PGD_PTRS (PTRS_PER_PGD-USER_PGD_PTRS)
-
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %llx.\n", __FILE__, __LINE__, \
 		(unsigned long long)pte_val(e))
@@ -693,7 +690,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 #define pmd_page_vaddr(pmd)	\
 	((unsigned long) (pmd_val(pmd) & PAGE_MASK))
 #define pmd_page(pmd)		\
-	(mem_map + (__pa(pmd_val(pmd)) >> PAGE_SHIFT))
+	pfn_to_page((__pa(pmd_val(pmd)) >> PAGE_SHIFT))
 #endif
 
 /* to find an entry in a kernel page-table-directory */
-- 
1.5.4.1
