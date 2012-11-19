Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id E51C32C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:32:59 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 024/493] powerpc: remove CONFIG_HOTPLUG ifdefs
Date: Mon, 19 Nov 2012 13:19:33 -0500
Message-Id: <1353349642-3677-24-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove conditional code based on CONFIG_HOTPLUG being false.  It's
always on now in preparation of it going away as an option.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: linuxppc-dev@lists.ozlabs.org 
---
 arch/powerpc/mm/tlb_hash64.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index ae758b3..841afee 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -183,11 +183,9 @@ void tlb_flush(struct mmu_gather *tlb)
  * since 64K pages may overlap with other bridges when using 64K pages
  * with 4K HW pages on IO space.
  *
- * Because of that usage pattern, it's only available with CONFIG_HOTPLUG
- * and is implemented for small size rather than speed.
+ * Because of that usage pattern, it is implemented for small size
+ * rather than speed.
  */
-#ifdef CONFIG_HOTPLUG
-
 void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 			      unsigned long end)
 {
@@ -221,5 +219,3 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 	arch_leave_lazy_mmu_mode();
 	local_irq_restore(flags);
 }
-
-#endif /* CONFIG_HOTPLUG */
-- 
1.8.0
