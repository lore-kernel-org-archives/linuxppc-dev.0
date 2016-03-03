Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A4F261A03DF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 15:27:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: bsingharora@gmail.com, duwe@lst.de, <linux-kernel@vger.kernel.org>,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: [PATCH v3 1/8] powerpc: Create a helper for getting the kernel toc
 value
Date: Thu,  3 Mar 2016 15:26:53 +1100
Message-Id: <1456979220-10931-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the logic to work out the kernel toc pointer into a header. This is
a good cleanup, and also means we can use it elsewhere in future.

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Reviewed-by: Torsten Duwe <duwe@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/sections.h | 12 ++++++++++++
 arch/powerpc/kernel/paca.c          | 11 +----------
 2 files changed, 13 insertions(+), 10 deletions(-)

v3: No change.
v2: New.

diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index a5e930aca804..abf5866e08c6 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -22,6 +22,18 @@ static inline int in_kernel_text(unsigned long addr)
 	return 0;
 }
 
+static inline unsigned long kernel_toc_addr(void)
+{
+	/* Defined by the linker, see vmlinux.lds.S */
+	extern unsigned long __toc_start;
+
+	/*
+	 * The TOC register (r2) points 32kB into the TOC, so that 64kB of
+	 * the TOC can be addressed using a single machine instruction.
+	 */
+	return (unsigned long)(&__toc_start) + 0x8000UL;
+}
+
 static inline int overlaps_interrupt_vector_text(unsigned long start,
 							unsigned long end)
 {
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 01ea0edf0579..93dae296b6be 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -17,10 +17,6 @@
 #include <asm/pgtable.h>
 #include <asm/kexec.h>
 
-/* This symbol is provided by the linker - let it fill in the paca
- * field correctly */
-extern unsigned long __toc_start;
-
 #ifdef CONFIG_PPC_BOOK3S
 
 /*
@@ -149,11 +145,6 @@ EXPORT_SYMBOL(paca);
 
 void __init initialise_paca(struct paca_struct *new_paca, int cpu)
 {
-       /* The TOC register (GPR2) points 32kB into the TOC, so that 64kB
-	* of the TOC can be addressed using a single machine instruction.
-	*/
-	unsigned long kernel_toc = (unsigned long)(&__toc_start) + 0x8000UL;
-
 #ifdef CONFIG_PPC_BOOK3S
 	new_paca->lppaca_ptr = new_lppaca(cpu);
 #else
@@ -161,7 +152,7 @@ void __init initialise_paca(struct paca_struct *new_paca, int cpu)
 #endif
 	new_paca->lock_token = 0x8000;
 	new_paca->paca_index = cpu;
-	new_paca->kernel_toc = kernel_toc;
+	new_paca->kernel_toc = kernel_toc_addr();
 	new_paca->kernelbase = (unsigned long) _stext;
 	/* Only set MSR:IR/DR when MMU is initialized */
 	new_paca->kernel_msr = MSR_KERNEL & ~(MSR_IR | MSR_DR);
-- 
2.5.0
