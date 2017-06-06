Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whshY73vKzDqLj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 23:18:53 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4] powerpc/mm: Only read faulting instruction when necessary
 in do_page_fault()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20170606131849.8338D68F83@localhost.localdomain>
Date: Tue,  6 Jun 2017 15:18:49 +0200 (CEST)
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

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v4: Rebased on top of powerpc/next (f718d426d7e42e) and doing access_ok() verification before __get_user_xxx()

 v3: Do a first try with pagefault disabled before releasing the semaphore

 v2: Changes 'if (cond1) if (cond2)' by 'if (cond1 && cond2)'

 arch/powerpc/mm/fault.c | 60 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 4c422632047b..add2166d2459 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -72,26 +72,50 @@ static inline int notify_page_fault(struct pt_regs *regs)
 /*
  * Check whether the instruction at regs->nip is a store using
  * an update addressing form which will update r1.
+ * If no, returns 0 with mmap_sem released
+ * If yes, returns 1 if mmap_sem hasn't been released
+ * If yes, returns 2 if mmap_sem has been released
  */
 static int store_updates_sp(struct pt_regs *regs)
 {
 	unsigned int inst;
+	unsigned int __user *nip = (unsigned int __user *)regs->nip;
+	int ret;
+	bool is_mm_locked = true;
+
+	/*
+	 * We want to do this outside mmap_sem, because reading code around nip
+	 * can result in fault, which will cause a deadlock when called with
+	 * mmap_sem held. However, we do a first try with pagefault disabled as
+	 * a fault here is very unlikely.
+	 */
+	if (!access_ok(VERIFY_READ, nip, sizeof(inst)))
+		goto failed;
+
+	pagefault_disable();
+	ret = __get_user_inatomic(inst, nip);
+	pagefault_enable();
+	if (ret) {
+		up_read(&current->mm->mmap_sem);
+		is_mm_locked = false;
+		if (__get_user(inst, nip))
+			goto failed;
+	}
 
-	if (get_user(inst, (unsigned int __user *)regs->nip))
-		return 0;
 	/* check for 1 in the rA field */
 	if (((inst >> 16) & 0x1f) != 1)
-		return 0;
+		goto failed;
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
-		return 1;
-	case 62:	/* std or stdu */
-		return (inst & 3) == 1;
+		return is_mm_locked ? 1 : 2;
 	case 31:
 		/* check minor opcode */
 		switch ((inst >> 1) & 0x3ff) {
@@ -101,9 +125,13 @@ static int store_updates_sp(struct pt_regs *regs)
 		case 439:	/* sthux */
 		case 695:	/* stfsux */
 		case 759:	/* stfdux */
-			return 1;
+			return is_mm_locked ? 1 : 2;
 		}
 	}
+failed:
+	if (is_mm_locked)
+		up_read(&current->mm->mmap_sem);
+
 	return 0;
 }
 /*
@@ -283,14 +311,6 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 
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
 
@@ -359,8 +379,14 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 		 * between the last mapped region and the stack will
 		 * expand the stack rather than segfaulting.
 		 */
-		if (address + 2048 < uregs->gpr[1] && !store_update_sp)
-			goto bad_area;
+		if (is_write && is_user && address + 2048 < uregs->gpr[1] &&
+		    !store_update_sp) {
+			store_update_sp = store_updates_sp(regs);
+			if (store_update_sp == 2)
+				goto retry;
+			if (store_update_sp == 0)
+				goto bad_area_nosemaphore;
+		}
 	}
 	if (expand_stack(vma, address))
 		goto bad_area;
-- 
2.12.0
