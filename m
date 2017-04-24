Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBKHV4VCBzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 18:28:38 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: Only read faulting instruction when necessary in
 do_page_fault()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20170424082832.C0E8C6EAF5@localhost.localdomain>
Date: Mon, 24 Apr 2017 10:28:32 +0200 (CEST)
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

         720495838      cpu-cycles                                                    ( +-  0.04% )
            141769      dTLB-load-misses                                              ( +-  0.02% )
             52722      iTLB-load-misses                                              ( +-  0.01% )
             19611      faults                                                        ( +-  0.02% )

       5.750535176 seconds time elapsed                                          ( +-  0.16% )

With the patch:
 Performance counter stats for './fault 500' (10 runs):

         717669123      cpu-cycles                                                    ( +-  0.02% )
            137344      dTLB-load-misses                                              ( +-  0.03% )
             52731      iTLB-load-misses                                              ( +-  0.01% )
             19614      faults                                                        ( +-  0.03% )

       5.728423115 seconds time elapsed                                          ( +-  0.14% )

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 This patch applies after the serie "powerpc/mm: some cleanup of do_page_fault()"

 arch/powerpc/mm/fault.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 400f2d0d42f8..3d506589236c 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -280,14 +280,6 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
-	/*
-	 * We want to do this outside mmap_sem, because reading code around nip
-	 * can result in fault, which will cause a deadlock when called with
-	 * mmap_sem held
-	 */
-	if (is_write && is_user)
-		__get_user(inst, (unsigned int __user *)regs->nip);
-
 	if (is_user)
 		flags |= FAULT_FLAG_USER;
 
@@ -356,8 +348,22 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 		 * between the last mapped region and the stack will
 		 * expand the stack rather than segfaulting.
 		 */
-		if (address + 2048 < uregs->gpr[1] && !store_updates_sp(inst))
-			goto bad_area;
+		if (address + 2048 < uregs->gpr[1]) {
+			if (!inst) {
+				/*
+				 * We want to do this outside mmap_sem, because
+				 * reading code around nip can result in fault,
+				 * which will cause a deadlock when called with
+				 * mmap_sem held
+				 */
+				up_read(&mm->mmap_sem);
+				__get_user(inst,
+					   (unsigned int __user *)regs->nip);
+				if (!store_updates_sp(inst))
+					goto bad_area_nosemaphore;
+				goto retry;
+			}
+		}
 	}
 	if (expand_stack(vma, address))
 		goto bad_area;
-- 
2.12.0
