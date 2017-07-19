Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC4X90QwlzDrTY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 14:57:28 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 19/24] powerpc/mm: Add a bunch of (un)likely annotations to
 do_page_fault
Date: Wed, 19 Jul 2017 14:49:41 +1000
Message-Id: <20170719044946.22030-19-benh@kernel.crashing.org>
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

Mostly for the failure cases

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/fault.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index c5859ffd3a96..f1abdc90e330 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -400,7 +400,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * source.  If this is invalid we can skip the address space check,
 	 * thus avoiding the deadlock.
 	 */
-	if (!down_read_trylock(&mm->mmap_sem)) {
+	if (unlikely(!down_read_trylock(&mm->mmap_sem))) {
 		if (!is_user && !search_exception_tables(regs->nip))
 			return bad_area_nosemaphore(regs, address);
 
@@ -416,11 +416,11 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	}
 
 	vma = find_vma(mm, address);
-	if (!vma)
+	if (unlikely(!vma))
 		return bad_area(regs, address);
-	if (vma->vm_start <= address)
+	if (likely(vma->vm_start <= address))
 		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
+	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
 		return bad_area(regs, address);
 
 	/*
@@ -453,7 +453,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		if (address + 2048 < uregs->gpr[1] && !store_update_sp)
 			return bad_area(regs, address);
 	}
-	if (expand_stack(vma, address))
+	if (unlikely(expand_stack(vma, address)))
 		return bad_area(regs, address);
 
 good_area:
@@ -468,18 +468,18 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		 * below wouldn't be valid on those processors. This -may-
 		 * break programs compiled with a really old ABI though.
 		 */
-		if (!(vma->vm_flags & VM_EXEC) &&
-		    (cpu_has_feature(CPU_FTR_NOEXECUTE) ||
-		     !(vma->vm_flags & (VM_READ | VM_WRITE))))
+		if (unlikely(!(vma->vm_flags & VM_EXEC) &&
+			     (cpu_has_feature(CPU_FTR_NOEXECUTE) ||
+			      !(vma->vm_flags & (VM_READ | VM_WRITE)))))
 			return bad_area(regs, address);
 	/* a write */
 	} else if (is_write) {
-		if (!(vma->vm_flags & VM_WRITE))
+		if (unlikely(!(vma->vm_flags & VM_WRITE)))
 			return bad_area(regs, address);
 		flags |= FAULT_FLAG_WRITE;
 	/* a read */
 	} else {
-		if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)))
+		if (unlikely(!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE))))
 			return bad_area(regs, address);
 	}
 
-- 
2.13.3
