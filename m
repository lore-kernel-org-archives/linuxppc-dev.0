Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 28 Nov 2008 17:05:05 +1100
Subject: [PATCH] powerpc: Fix ppc32 mm_struct CPU tracking in SMP
Message-Id: <20081128060533.BA31ADDDDB@ozlabs.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 32-bit hash code didn't need it so far so we don't update
mm->cpu_vm_mask on context switch. This however breaks the
merge of the RCU based page table freeing and other upcoming
32-bit embedded SMP work.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/mmu_context.h |    3 +++
 1 file changed, 3 insertions(+)

--- linux-476.orig/arch/powerpc/include/asm/mmu_context.h	2008-11-28 15:46:39.000000000 +1100
+++ linux-476/arch/powerpc/include/asm/mmu_context.h	2008-11-28 16:59:06.000000000 +1100
@@ -186,6 +186,9 @@ static inline void switch_mm(struct mm_s
 
 	tsk->thread.pgdir = next->pgd;
 
+	if (!cpu_isset(smp_processor_id(), next->cpu_vm_mask))
+		cpu_set(smp_processor_id(), next->cpu_vm_mask);
+
 	/* No need to flush userspace segments if the mm doesnt change */
 	if (prev == next)
 		return;
