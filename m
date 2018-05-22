Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qy5x0wJ8zDqgs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 00:03:00 +1000 (AEST)
Message-Id: <d37d9ce7b925bc254082cd664e37a062131d04b8.1526995927.git.christophe.leroy@c-s.fr>
In-Reply-To: <1053e5f43a2ea9a9d9abb1f45c88dffb60b9b4fc.1526995927.git.christophe.leroy@c-s.fr>
References: <1053e5f43a2ea9a9d9abb1f45c88dffb60b9b4fc.1526995927.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v7 2/3] powerpc/mm: Only read faulting instruction when
 necessary in do_page_fault()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 npiggin@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 22 May 2018 16:02:56 +0200 (CEST)
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
 v7: Following comment from Nicholas on v6 on possibility of the page getting removed from the pagetables
     between the fault and the read, I have reworked the patch in order to do the get_user() in
     __do_page_fault() directly in order to reduce complexity compared to version v5

 v6: Rebased on latest powerpc/merge branch ; Using __get_user_inatomic() instead of get_user() in order
     to move it inside the semaphored area. That removes all the complexity of the patch.

 v5: Reworked to fit after Benh do_fault improvement and rebased on top of powerpc/merge (65152902e43fef)

 v4: Rebased on top of powerpc/next (f718d426d7e42e) and doing access_ok() verification before __get_user_xxx()

 v3: Do a first try with pagefault disabled before releasing the semaphore

 v2: Changes 'if (cond1) if (cond2)' by 'if (cond1 && cond2)'

 arch/powerpc/mm/fault.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index fcbb34431da2..dc64b8e06477 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -450,9 +450,6 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * can result in fault, which will cause a deadlock when called with
 	 * mmap_sem held
 	 */
-	if (is_write && is_user)
-		get_user(inst, (unsigned int __user *)regs->nip);
-
 	if (is_user)
 		flags |= FAULT_FLAG_USER;
 	if (is_write)
@@ -498,6 +495,26 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
 		return bad_area(regs, address);
 
+	if (unlikely(is_write && is_user && address + 0x100000 < vma->vm_end &&
+		     !inst)) {
+		unsigned int __user *nip = (unsigned int __user *)regs->nip;
+
+		if (likely(access_ok(VERIFY_READ, nip, sizeof(inst)))) {
+			int res;
+
+			pagefault_disable();
+			res = __get_user_inatomic(inst, nip);
+			pagefault_enable();
+			if (unlikely(res)) {
+				up_read(&mm->mmap_sem);
+				res = __get_user(inst, nip);
+				if (!res && inst)
+					goto retry;
+				return bad_area_nosemaphore(regs, address);
+			}
+		}
+	}
+
 	/* The stack is being expanded, check if it's valid */
 	if (unlikely(bad_stack_expansion(regs, address, vma, inst)))
 		return bad_area(regs, address);
-- 
2.13.3
