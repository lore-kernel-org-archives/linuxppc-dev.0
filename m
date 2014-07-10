Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6147E1A00EF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 12:29:32 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/9] powerpc: Pull out ksp_vsid logic into a helper
Date: Thu, 10 Jul 2014 12:29:21 +1000
Message-Id: <1404959366-17664-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1404959366-17664-1-git-send-email-mpe@ellerman.id.au>
References: <1404959366-17664-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The previous patch left a bit of a wart in copy_process(). Clean it up a
bit by moving the logic out into a helper.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/process.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index e39f388fc25c..9c34327e38ca 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1095,6 +1095,23 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	return 0;
 }
 
+static void setup_ksp_vsid(struct task_struct *p, unsigned long sp)
+{
+#ifdef CONFIG_PPC_STD_MMU_64
+	unsigned long sp_vsid;
+	unsigned long llp = mmu_psize_defs[mmu_linear_psize].sllp;
+
+	if (mmu_has_feature(MMU_FTR_1T_SEGMENT))
+		sp_vsid = get_kernel_vsid(sp, MMU_SEGSIZE_1T)
+			<< SLB_VSID_SHIFT_1T;
+	else
+		sp_vsid = get_kernel_vsid(sp, MMU_SEGSIZE_256M)
+			<< SLB_VSID_SHIFT;
+	sp_vsid |= SLB_VSID_KERNEL | llp;
+	p->thread.ksp_vsid = sp_vsid;
+#endif
+}
+
 /*
  * Copy a thread..
  */
@@ -1174,21 +1191,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	p->thread.vr_save_area = NULL;
 #endif
 
-#ifdef CONFIG_PPC_STD_MMU_64
-	{
-		unsigned long sp_vsid;
-		unsigned long llp = mmu_psize_defs[mmu_linear_psize].sllp;
+	setup_ksp_vsid(p, sp);
 
-		if (mmu_has_feature(MMU_FTR_1T_SEGMENT))
-			sp_vsid = get_kernel_vsid(sp, MMU_SEGSIZE_1T)
-				<< SLB_VSID_SHIFT_1T;
-		else
-			sp_vsid = get_kernel_vsid(sp, MMU_SEGSIZE_256M)
-				<< SLB_VSID_SHIFT;
-		sp_vsid |= SLB_VSID_KERNEL | llp;
-		p->thread.ksp_vsid = sp_vsid;
-	}
-#endif /* CONFIG_PPC_STD_MMU_64 */
 #ifdef CONFIG_PPC64 
 	if (cpu_has_feature(CPU_FTR_DSCR)) {
 		p->thread.dscr_inherit = current->thread.dscr_inherit;
-- 
1.9.1
