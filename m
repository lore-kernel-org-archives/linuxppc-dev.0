Return-Path: <B40534@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6873F2C04D7
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Jun 2013 21:24:08 +1000 (EST)
From: Wang Dongsheng <dongsheng.wang@freescale.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/hibernate: add restore mmu context after resume
Date: Sun, 9 Jun 2013 18:37:40 +0800
Message-ID: <1370774260-31072-2-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1370774260-31072-1-git-send-email-dongsheng.wang@freescale.com>
References: <1370774260-31072-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: anton@enomsg.org, Wang Dongsheng <dongsheng.wang@freescale.com>,
 scottwood@freescale.com, johannes@sipsolutions.net,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

add restore_mmu_context to replace switch_mmu_context in
restore_processor_state, because the switch_mmu_context will do
a whole pile of stuff that are probably completely unnecessary.

There just need to restore the existing process context, and
invalidate TLB for boot core.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
 arch/powerpc/include/asm/tlbflush.h |  2 ++
 arch/powerpc/kernel/swsusp.c        |  4 +---
 arch/powerpc/mm/tlb_nohash.c        | 12 ++++++++++++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/tlbflush.h b/arch/powerpc/include/asm/tlbflush.h
index 61a5927..c401fe3 100644
--- a/arch/powerpc/include/asm/tlbflush.h
+++ b/arch/powerpc/include/asm/tlbflush.h
@@ -44,6 +44,8 @@ extern void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmadd
 extern void __local_flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
 				   int tsize, int ind);
 
+extern void restore_mmu_context(void);
+
 #ifdef CONFIG_SMP
 extern void flush_tlb_mm(struct mm_struct *mm);
 extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
diff --git a/arch/powerpc/kernel/swsusp.c b/arch/powerpc/kernel/swsusp.c
index eae33e1..0b104d7 100644
--- a/arch/powerpc/kernel/swsusp.c
+++ b/arch/powerpc/kernel/swsusp.c
@@ -32,7 +32,5 @@ void save_processor_state(void)
 
 void restore_processor_state(void)
 {
-#ifdef CONFIG_PPC32
-	switch_mmu_context(current->active_mm, current->active_mm);
-#endif
+	restore_mmu_context();
 }
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index df32a83..a5a0708 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -39,10 +39,12 @@
 #include <linux/of_fdt.h>
 #include <linux/hugetlb.h>
 
+#include <asm/current.h>
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include <asm/code-patching.h>
 #include <asm/hugetlb.h>
+#include <asm/mmu_context.h>
 
 #include "mmu_decl.h"
 
@@ -193,6 +195,16 @@ void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 }
 EXPORT_SYMBOL(local_flush_tlb_page);
 
+void restore_mmu_context(void)
+{
+	struct mm_struct *mm = current->active_mm;
+
+	set_context(mm->context.id, mm->pgd);
+
+	_tlbil_all();
+}
+EXPORT_SYMBOL(restore_mmu_context);
+
 /*
  * And here are the SMP non-local implementations
  */
-- 
1.8.0
