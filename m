Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rNhz6XJSzF0Vt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 17:01:23 +1000 (AEST)
Message-Id: <61ef5847cedae91eb5415f40fb4276585950cb43.1527058032.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v8] powerpc/mm: Only read faulting instruction when necessary
 in do_page_fault()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 npiggin@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 23 May 2018 09:01:19 +0200 (CEST)
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
of the faulting instruction to the only cases where it is likely
needed.

On an MPC885, with the same benchmark app as in the commit referred
above, we see a reduction of about 3900 dTLB misses (approx 3%):

Before the patch:
 Performance counter stats for './fault 500' (10 runs):

         683033312      cpu-cycles                                                    ( +-  0.03% )
            134538      dTLB-load-misses                                              ( +-  0.03% )
             46099      iTLB-load-misses                                              ( +-  0.02% )
             19681      faults                                                        ( +-  0.02% )

       5.389747878 seconds time elapsed                                          ( +-  0.06% )

With the patch:

 Performance counter stats for './fault 500' (10 runs):

         682112862      cpu-cycles                                                    ( +-  0.03% )
            130619      dTLB-load-misses                                              ( +-  0.03% )
             46073      iTLB-load-misses                                              ( +-  0.05% )
             19681      faults                                                        ( +-  0.01% )

       5.381342641 seconds time elapsed                                          ( +-  0.07% )

The proper work of the huge stack expansion was tested with the
following app:

int main(int argc, char **argv)
{
	char buf[1024 * 1025];

	sprintf(buf, "Hello world !\n");
	printf(buf);

	exit(0);
}

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v8: Back to a single patch as it now makes no sense to split the first part in two. The third patch has no
     dependencies with the ones before, so it will be resend independantly. As suggested by Nicholas, the
     patch now does the get_user() stuff inside bad_stack_expansion(), that's a mid way between v5 and v7.

 v7: Following comment from Nicholas on v6 on possibility of the page getting removed from the pagetables
     between the fault and the read, I have reworked the patch in order to do the get_user() in
     __do_page_fault() directly in order to reduce complexity compared to version v5

 v6: Rebased on latest powerpc/merge branch ; Using __get_user_inatomic() instead of get_user() in order
     to move it inside the semaphored area. That removes all the complexity of the patch.

 v5: Reworked to fit after Benh do_fault improvement and rebased on top of powerpc/merge (65152902e43fef)

 v4: Rebased on top of powerpc/next (f718d426d7e42e) and doing access_ok() verification before __get_user_xxx()

 v3: Do a first try with pagefault disabled before releasing the semaphore

 v2: Changes 'if (cond1) if (cond2)' by 'if (cond1 && cond2)'

 arch/powerpc/mm/fault.c | 63 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 0c99f9b45e8f..7f9363879f4a 100644
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
@@ -233,9 +229,10 @@ static bool bad_kernel_fault(bool is_exec, unsigned long error_code,
 	return is_exec || (address >= TASK_SIZE);
 }
 
-static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
-				struct vm_area_struct *vma,
-				bool store_update_sp)
+/* Return value is true if bad (sem. released), false if good, -1 for retry */
+static int bad_stack_expansion(struct pt_regs *regs, unsigned long address,
+				struct vm_area_struct *vma, unsigned int flags,
+				bool is_retry)
 {
 	/*
 	 * N.B. The POWER/Open ABI allows programs to access up to
@@ -247,10 +244,15 @@ static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
 	 * expand to 1MB without further checks.
 	 */
 	if (address + 0x100000 < vma->vm_end) {
+		struct mm_struct *mm = current->mm;
+		unsigned int __user *nip = (unsigned int __user *)regs->nip;
+		unsigned int inst;
 		/* get user regs even if this fault is in kernel mode */
 		struct pt_regs *uregs = current->thread.regs;
-		if (uregs == NULL)
+		if (uregs == NULL) {
+			up_read(&mm->mmap_sem);
 			return true;
+		}
 
 		/*
 		 * A user-mode access to an address a long way below
@@ -264,8 +266,30 @@ static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
 		 * between the last mapped region and the stack will
 		 * expand the stack rather than segfaulting.
 		 */
-		if (address + 2048 < uregs->gpr[1] && !store_update_sp)
-			return true;
+		if (address + 2048 >= uregs->gpr[1])
+			return false;
+		if (is_retry)
+			return false;
+
+		if ((flags & FAULT_FLAG_WRITE) && (flags & FAULT_FLAG_USER) &&
+		    access_ok(VERIFY_READ, nip, sizeof(inst))) {
+			int res;
+
+			pagefault_disable();
+			res = __get_user_inatomic(inst, nip);
+			pagefault_enable();
+			if (res) {
+				up_read(&mm->mmap_sem);
+				res = __get_user(inst, nip);
+				if (!res && store_updates_sp(inst))
+					return -1;
+				return true;
+			}
+			if (store_updates_sp(inst))
+				return false;
+		}
+		up_read(&mm->mmap_sem);
+		return true;
 	}
 	return false;
 }
@@ -403,7 +427,8 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	int is_user = user_mode(regs);
 	int is_write = page_fault_is_write(error_code);
 	int fault, major = 0;
-	bool store_update_sp = false;
+	bool is_retry = false;
+	int is_bad;
 
 	if (notify_page_fault(regs))
 		return 0;
@@ -454,9 +479,6 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * can result in fault, which will cause a deadlock when called with
 	 * mmap_sem held
 	 */
-	if (is_write && is_user)
-		store_update_sp = store_updates_sp(regs);
-
 	if (is_user)
 		flags |= FAULT_FLAG_USER;
 	if (is_write)
@@ -503,8 +525,13 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		return bad_area(regs, address);
 
 	/* The stack is being expanded, check if it's valid */
-	if (unlikely(bad_stack_expansion(regs, address, vma, store_update_sp)))
-		return bad_area(regs, address);
+	is_bad = bad_stack_expansion(regs, address, vma, flags, is_retry);
+	if (unlikely(is_bad == -1)) {
+		is_retry = true;
+		goto retry;
+	}
+	if (unlikely(is_bad))
+		return bad_area_nosemaphore(regs, address);
 
 	/* Try to expand it */
 	if (unlikely(expand_stack(vma, address)))
-- 
2.13.3
