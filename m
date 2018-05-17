Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mpGZ6JFGzF1xh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 20:59:34 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6] powerpc/mm: Only read faulting instruction when necessary
 in do_page_fault()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20180517105930.71B1D6F937@po14934vm.idsi0.si.c-s.fr>
Date: Thu, 17 May 2018 12:59:29 +0200 (CEST)
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

int main(int argc, char **argv)
{
	char buf[1024 * 1025];

	sprintf(buf, "Hello world !\n");
	printf(buf);

	exit(0);
}

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v6: Rebased on latest powerpc/merge branch ; Using __get_user_inatomic() instead of get_user() in order
     to move it inside the semaphored area. That removes all the complexity of the patch.

 v5: Reworked to fit after Benh do_fault improvement and rebased on top of powerpc/merge (65152902e43fef)

 v4: Rebased on top of powerpc/next (f718d426d7e42e) and doing access_ok() verification before __get_user_xxx()

 v3: Do a first try with pagefault disabled before releasing the semaphore

 v2: Changes 'if (cond1) if (cond2)' by 'if (cond1 && cond2)'

 arch/powerpc/mm/fault.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index c01d627e687a..a7d5cc76a8ce 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -72,8 +72,18 @@ static inline bool notify_page_fault(struct pt_regs *regs)
 static bool store_updates_sp(struct pt_regs *regs)
 {
 	unsigned int inst;
+	int ret;
 
-	if (get_user(inst, (unsigned int __user *)regs->nip))
+	/*
+	 * Using get_user_in_atomic() as reading code around nip can result in
+	 * fault, which may cause a deadlock when called with mmap_sem held,
+	 * however since we are reading the instruction that generated the DSI
+	 * we are handling, the page is necessarily already present.
+	 */
+	pagefault_disable();
+	ret = __get_user_inatomic(inst, (unsigned int __user *)regs->nip);
+	pagefault_enable();
+	if (ret)
 		return false;
 	/* check for 1 in the rA field */
 	if (((inst >> 16) & 0x1f) != 1)
@@ -234,8 +244,7 @@ static bool bad_kernel_fault(bool is_exec, unsigned long error_code,
 }
 
 static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
-				struct vm_area_struct *vma,
-				bool store_update_sp)
+				struct vm_area_struct *vma)
 {
 	/*
 	 * N.B. The POWER/Open ABI allows programs to access up to
@@ -264,7 +273,7 @@ static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
 		 * between the last mapped region and the stack will
 		 * expand the stack rather than segfaulting.
 		 */
-		if (address + 2048 < uregs->gpr[1] && !store_update_sp)
+		if (address + 2048 < uregs->gpr[1] && !store_updates_sp(regs))
 			return true;
 	}
 	return false;
@@ -403,7 +412,6 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	int is_user = user_mode(regs);
 	int is_write = page_fault_is_write(error_code);
 	int fault, major = 0;
-	bool store_update_sp = false;
 
 	if (notify_page_fault(regs))
 		return 0;
@@ -449,14 +457,6 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		return bad_key_fault_exception(regs, address,
 					       get_mm_addr_key(mm, address));
 
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
@@ -503,7 +503,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		return bad_area(regs, address);
 
 	/* The stack is being expanded, check if it's valid */
-	if (unlikely(bad_stack_expansion(regs, address, vma, store_update_sp)))
+	if (unlikely(bad_stack_expansion(regs, address, vma)))
 		return bad_area(regs, address);
 
 	/* Try to expand it */
-- 
2.13.3
