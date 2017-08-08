Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRQVm4q8VzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 17:09:04 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5] powerpc/mm: Only read faulting instruction when necessary
 in do_page_fault()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20170808070859.A3F3A653E4@po15668-vm-win7.idsi0.si.c-s.fr>
Date: Tue,  8 Aug 2017 09:08:59 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit a7a9dcd882a67 ("powerpc: Avoid taking a data miss on every
userspace instruction miss") has shown that limiting the read of
faulting instruction to likely cases improves performance.

This patch goes further into this direction by limiting the read
of the faulting instruction to the only cases where it is definitly
needed.

On an MPC885, with the same benchmark app as in the commit referred
above, we see a reduction of 4000 dTLB misses (approx 3%):

Before the patch:
 Performance counter stats for './fault 500' (10 runs):

         720495838      cpu-cycles		( +-  0.04% )
            141769      dTLB-load-misses	( +-  0.02% )
             52722      iTLB-load-misses	( +-  0.01% )
             19611      faults			( +-  0.02% )

       5.750535176 seconds time elapsed		( +-  0.16% )

With the patch:
 Performance counter stats for './fault 500' (10 runs):

         717669123      cpu-cycles		( +-  0.02% )
            137344      dTLB-load-misses	( +-  0.03% )
             52731      iTLB-load-misses	( +-  0.01% )
             19614      faults			( +-  0.03% )

       5.728423115 seconds time elapsed		( +-  0.14% )

The proper work of the huge stack expansion was tested with the
following app:

#include <stdlib.h>
#include <stdio.h>

int main(int argc, char **argv)
{
	char buf[1024 * 1025];

	sprintf(buf, "Hello world !\n");
	printf(buf);

	exit(0);
}

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 I'm wondering if it really worth it to do something so complex. Is there really a chance that the
 get_user() faults ? It would mean that an instruction that as just been executed has been in the
 meantime swapped out. Is that really a possibility ? I'd expect not, which would mean that we
 could limit it to __get_user_inatomic() and then not implement this complex unlocking and retry stuff.

 v5: Reworked to fit after Benh do_fault improvement and rebased on top of powerpc/merge (65152902e43fef)

 v4: Rebased on top of powerpc/next (f718d426d7e42e) and doing access_ok() verification before __get_user_xxx()

 v3: Do a first try with pagefault disabled before releasing the semaphore

 v2: Changes 'if (cond1) if (cond2)' by 'if (cond1 && cond2)'

 arch/powerpc/mm/fault.c | 90 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 65 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index f88fac3d281b..7a218f69f956 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -68,26 +68,58 @@ static inline bool notify_page_fault(struct pt_regs *regs)
 /*
  * Check whether the instruction at regs->nip is a store using
  * an update addressing form which will update r1.
+ * If no, returns STACK_EXPANSION_BAD
+ * If yes, returns STACK_EXPANSION_GOOD
+ * In addition, the result is ored with STACK_EXPANSION_UNLOCKED if the
+ * semaphore has been released
  */
-static bool store_updates_sp(struct pt_regs *regs)
+
+#define STACK_EXPANSION_BAD		0
+#define STACK_EXPANSION_GOOD		1
+#define STACK_EXPANSION_LOCKED		0
+#define STACK_EXPANSION_UNLOCKED	2
+
+int store_updates_sp(struct pt_regs *regs)
 {
 	unsigned int inst;
+	unsigned int __user *nip = (unsigned int __user *)regs->nip;
+	int ret;
+	int sema = STACK_EXPANSION_LOCKED;
+
+	/*
+	 * We want to do this outside mmap_sem, because reading code around nip
+	 * can result in fault, which will cause a deadlock when called with
+	 * mmap_sem held. However, we do a first try with pagefault disabled as
+	 * a fault here is very unlikely.
+	 */
+	if (!access_ok(VERIFY_READ, nip, sizeof(inst)))
+		return STACK_EXPANSION_BAD | STACK_EXPANSION_LOCKED;
+
+	pagefault_disable();
+	ret = __get_user_inatomic(inst, nip);
+	pagefault_enable();
+	if (ret) {
+		up_read(&current->mm->mmap_sem);
+		sema = STACK_EXPANSION_UNLOCKED;
+		if (__get_user(inst, nip))
+			return STACK_EXPANSION_BAD | STACK_EXPANSION_UNLOCKED;
+	}
 
-	if (get_user(inst, (unsigned int __user *)regs->nip))
-		return false;
 	/* check for 1 in the rA field */
 	if (((inst >> 16) & 0x1f) != 1)
-		return false;
+		return STACK_EXPANSION_BAD | sema;
+
 	/* check major opcode */
 	switch (inst >> 26) {
+	case 62:	/* std or stdu */
+		if ((inst & 3) == 0)
+			break;
 	case 37:	/* stwu */
 	case 39:	/* stbu */
 	case 45:	/* sthu */
 	case 53:	/* stfsu */
 	case 55:	/* stfdu */
-		return true;
-	case 62:	/* std or stdu */
-		return (inst & 3) == 1;
+		return STACK_EXPANSION_GOOD | sema;
 	case 31:
 		/* check minor opcode */
 		switch ((inst >> 1) & 0x3ff) {
@@ -97,10 +129,10 @@ static bool store_updates_sp(struct pt_regs *regs)
 		case 439:	/* sthux */
 		case 695:	/* stfsux */
 		case 759:	/* stfdux */
-			return true;
+			return STACK_EXPANSION_GOOD | sema;
 		}
 	}
-	return false;
+	return STACK_EXPANSION_BAD | sema;
 }
 /*
  * do_page_fault error handling helpers
@@ -220,9 +252,9 @@ static bool bad_kernel_fault(bool is_exec, unsigned long error_code,
 	return is_exec || (address >= TASK_SIZE);
 }
 
-static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
-				struct vm_area_struct *vma,
-				bool store_update_sp)
+int query_stack_expansion(struct pt_regs *regs, unsigned long address,
+			  struct vm_area_struct *vma, bool store_update_sp,
+			  unsigned int flags)
 {
 	/*
 	 * N.B. The POWER/Open ABI allows programs to access up to
@@ -237,7 +269,7 @@ static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
 		/* get user regs even if this fault is in kernel mode */
 		struct pt_regs *uregs = current->thread.regs;
 		if (uregs == NULL)
-			return true;
+			return STACK_EXPANSION_BAD;
 
 		/*
 		 * A user-mode access to an address a long way below
@@ -251,10 +283,16 @@ static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
 		 * between the last mapped region and the stack will
 		 * expand the stack rather than segfaulting.
 		 */
-		if (address + 2048 < uregs->gpr[1] && !store_update_sp)
-			return true;
+		if (address + 2048 < uregs->gpr[1]) {
+			if (store_update_sp)
+				return STACK_EXPANSION_GOOD;
+			if (!(flags & (FAULT_FLAG_USER)) ||
+			    !(flags & (FAULT_FLAG_WRITE)))
+				return STACK_EXPANSION_BAD;
+			return store_updates_sp(regs);
+		}
 	}
-	return false;
+	return STACK_EXPANSION_GOOD;
 }
 
 static bool access_error(bool is_write, bool is_exec,
@@ -386,6 +424,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	int is_write = page_fault_is_write(error_code);
 	int fault, major = 0;
 	bool store_update_sp = false;
+	int query;
 
 	if (notify_page_fault(regs))
 		return 0;
@@ -427,14 +466,6 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
-	/*
-	 * We want to do this outside mmap_sem, because reading code around nip
-	 * can result in fault, which will cause a deadlock when called with
-	 * mmap_sem held
-	 */
-	if (is_write && is_user)
-		store_update_sp = store_updates_sp(regs);
-
 	if (is_user)
 		flags |= FAULT_FLAG_USER;
 	if (is_write)
@@ -481,8 +512,17 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		return bad_area(regs, address);
 
 	/* The stack is being expanded, check if it's valid */
-	if (unlikely(bad_stack_expansion(regs, address, vma, store_update_sp)))
+	query = query_stack_expansion(regs, address, vma, store_update_sp,
+				      flags);
+	if (unlikely(!(query & STACK_EXPANSION_GOOD))) {
+		if (query & STACK_EXPANSION_UNLOCKED)
+			return bad_area_nosemaphore(regs, address);
 		return bad_area(regs, address);
+	}
+	if (unlikely(query & STACK_EXPANSION_UNLOCKED)) {
+		store_update_sp = true;
+		goto retry;
+	}
 
 	/* Try to expand it */
 	if (unlikely(expand_stack(vma, address)))
-- 
2.13.3
