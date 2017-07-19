Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC4X172b6zDrSw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 14:57:21 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 21/24] powerpc/mm: Move page fault VMA access checks to a
 helper
Date: Wed, 19 Jul 2017 14:49:43 +1000
Message-Id: <20170719044946.22030-21-benh@kernel.crashing.org>
In-Reply-To: <20170719044946.22030-1-benh@kernel.crashing.org>
References: <20170719044946.22030-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/fault.c | 57 ++++++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 6a938fc8c5fb..2291686d24c6 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -222,6 +222,37 @@ static bool bad_kernel_fault(bool is_exec, unsigned long error_code,
 	return is_exec || (address >= TASK_SIZE);
 }
 
+static bool access_error(bool is_write, bool is_exec,
+			 struct vm_area_struct *vma)
+{
+	/*
+	 * Allow execution from readable areas if the MMU does not
+	 * provide separate controls over reading and executing.
+	 *
+	 * Note: That code used to not be enabled for 4xx/BookE.
+	 * It is now as I/D cache coherency for these is done at
+	 * set_pte_at() time and I see no reason why the test
+	 * below wouldn't be valid on those processors. This -may-
+	 * break programs compiled with a really old ABI though.
+	 */
+	if (is_exec) {
+		return !(vma->vm_flags & VM_EXEC) &&
+			(cpu_has_feature(CPU_FTR_NOEXECUTE) ||
+			 !(vma->vm_flags & (VM_READ | VM_WRITE)));
+	}
+
+	if (is_write) {
+		if (unlikely(!(vma->vm_flags & VM_WRITE)))
+			return true;
+		return false;
+	}
+
+	if (unlikely(!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE))))
+		return true;
+
+	return false;
+}
+
 #ifdef CONFIG_PPC_SMLPAR
 static inline void cmo_account_page_fault(void)
 {
@@ -461,30 +492,8 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		return bad_area(regs, address);
 
 good_area:
-	if (is_exec) {
-		/*
-		 * Allow execution from readable areas if the MMU does not
-		 * provide separate controls over reading and executing.
-		 *
-		 * Note: That code used to not be enabled for 4xx/BookE.
-		 * It is now as I/D cache coherency for these is done at
-		 * set_pte_at() time and I see no reason why the test
-		 * below wouldn't be valid on those processors. This -may-
-		 * break programs compiled with a really old ABI though.
-		 */
-		if (unlikely(!(vma->vm_flags & VM_EXEC) &&
-			     (cpu_has_feature(CPU_FTR_NOEXECUTE) ||
-			      !(vma->vm_flags & (VM_READ | VM_WRITE)))))
-			return bad_area(regs, address);
-	/* a write */
-	} else if (is_write) {
-		if (unlikely(!(vma->vm_flags & VM_WRITE)))
-			return bad_area(regs, address);
-	/* a read */
-	} else {
-		if (unlikely(!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE))))
-			return bad_area(regs, address);
-	}
+	if (unlikely(access_error(is_write, is_exec, vma)))
+		return bad_area(regs, address);
 
 	/*
 	 * If for any reason at all we couldn't handle the fault,
-- 
2.13.3
