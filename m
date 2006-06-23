Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 23 Jun 2006 18:20:09 +1000
Subject: [PATCH 1/8] Setup the boot cpu's paca pointer in C rather than asm
Message-Id: <20060623082006.9669B67A76@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There's no need to set the boot cpu paca in asm, so do it in C so us
mere mortals can understand it.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/head_64.S  |   11 -----------
 arch/powerpc/kernel/setup_64.c |    9 ++++++++-
 2 files changed, 8 insertions(+), 12 deletions(-)

Index: to-merge/arch/powerpc/kernel/head_64.S
===================================================================
--- to-merge.orig/arch/powerpc/kernel/head_64.S
+++ to-merge/arch/powerpc/kernel/head_64.S
@@ -1976,17 +1976,6 @@ _STATIC(start_here_common)
 	/* Not reached */
 	BUG_OPCODE
 
-/* Put the paca pointer into r13 and SPRG3 */
-_GLOBAL(setup_boot_paca)
-	LOAD_REG_IMMEDIATE(r3, boot_cpuid)
-	lwz	r3,0(r3)
-	LOAD_REG_IMMEDIATE(r4, paca) 	/* Get base vaddr of paca array	 */
-	mulli	r3,r3,PACA_SIZE		/* Calculate vaddr of right paca */
-	add	r13,r3,r4		/* for this processor.		 */
-	mtspr	SPRN_SPRG3,r13
-
-	blr
-
 /*
  * We put a few things here that have to be page-aligned.
  * This stuff goes at the beginning of the bss, which is page-aligned.
Index: to-merge/arch/powerpc/kernel/setup_64.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/setup_64.c
+++ to-merge/arch/powerpc/kernel/setup_64.c
@@ -149,6 +149,13 @@ early_param("smt-enabled", early_smt_ena
 #define check_smt_enabled()
 #endif /* CONFIG_SMP */
 
+/* Put the paca pointer into r13 and SPRG3 */
+void __init setup_paca(int cpu)
+{
+	local_paca = &paca[cpu];
+	mtspr(SPRN_SPRG3, local_paca);
+}
+
 /*
  * Early initialization entry point. This is called by head.S
  * with MMU translation disabled. We rely on the "feature" of
@@ -183,7 +190,7 @@ void __init early_setup(unsigned long dt
 	early_init_devtree(__va(dt_ptr));
 
 	/* Now we know the logical id of our boot cpu, setup the paca. */
-	setup_boot_paca();
+	setup_paca(boot_cpuid);
 
 	/* Fix up paca fields required for the boot cpu */
 	get_paca()->cpu_start = 1;
