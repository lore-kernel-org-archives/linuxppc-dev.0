Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qy5w1xvnzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 00:02:59 +1000 (AEST)
Message-Id: <1053e5f43a2ea9a9d9abb1f45c88dffb60b9b4fc.1526995927.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v7 1/3] powerpc/mm: Move get_user() out of store_updates_sp()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 npiggin@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 22 May 2018 16:02:54 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In preparation of the following patch which will focus on calling
that get_user() only when necessary, this patch takes out of
store_updates_sp() the call to get_user() used to read the faulting
instruction.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v7: New

 arch/powerpc/mm/fault.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index c01d627e687a..fcbb34431da2 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -66,15 +66,11 @@ static inline bool notify_page_fault(struct pt_regs *regs)
 }
 
 /*
- * Check whether the instruction at regs->nip is a store using
+ * Check whether the instruction inst is a store using
  * an update addressing form which will update r1.
  */
-static bool store_updates_sp(struct pt_regs *regs)
+static bool store_updates_sp(unsigned int inst)
 {
-	unsigned int inst;
-
-	if (get_user(inst, (unsigned int __user *)regs->nip))
-		return false;
 	/* check for 1 in the rA field */
 	if (((inst >> 16) & 0x1f) != 1)
 		return false;
@@ -235,7 +231,7 @@ static bool bad_kernel_fault(bool is_exec, unsigned long error_code,
 
 static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
 				struct vm_area_struct *vma,
-				bool store_update_sp)
+				unsigned int inst)
 {
 	/*
 	 * N.B. The POWER/Open ABI allows programs to access up to
@@ -264,7 +260,7 @@ static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
 		 * between the last mapped region and the stack will
 		 * expand the stack rather than segfaulting.
 		 */
-		if (address + 2048 < uregs->gpr[1] && !store_update_sp)
+		if (address + 2048 < uregs->gpr[1] && !store_updates_sp(inst))
 			return true;
 	}
 	return false;
@@ -403,7 +399,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	int is_user = user_mode(regs);
 	int is_write = page_fault_is_write(error_code);
 	int fault, major = 0;
-	bool store_update_sp = false;
+	unsigned int inst = 0;
 
 	if (notify_page_fault(regs))
 		return 0;
@@ -455,7 +451,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * mmap_sem held
 	 */
 	if (is_write && is_user)
-		store_update_sp = store_updates_sp(regs);
+		get_user(inst, (unsigned int __user *)regs->nip);
 
 	if (is_user)
 		flags |= FAULT_FLAG_USER;
@@ -503,7 +499,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		return bad_area(regs, address);
 
 	/* The stack is being expanded, check if it's valid */
-	if (unlikely(bad_stack_expansion(regs, address, vma, store_update_sp)))
+	if (unlikely(bad_stack_expansion(regs, address, vma, inst)))
 		return bad_area(regs, address);
 
 	/* Try to expand it */
-- 
2.13.3
