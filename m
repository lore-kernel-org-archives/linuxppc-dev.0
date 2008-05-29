Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <b5d665dc398cc0822783593ce3a2fc6b62990759.1212042061.git.michael@ellerman.id.au>
In-Reply-To: <33bba4965d9907a8a93e9f92fd5c3874a6e21f90.1212042061.git.michael@ellerman.id.au>
References: <33bba4965d9907a8a93e9f92fd5c3874a6e21f90.1212042061.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/6] Allow create_branch() to return errors
Date: Thu, 29 May 2008 16:20:54 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently create_branch() creates a branch instruction for you, and patches
it into the call site. In some circumstances it would be nice to be able to
create the instruction and patch it later, and also some code might want
to check for errors in the branch creation before doing the patching. A
future patch will change create_branch() to check for errors.

For callers that don't care, replace create_branch() with patch_branch(),
which just creates the branch and patches it directly.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/crash_dump.c          |    4 ++--
 arch/powerpc/lib/code-patching.c          |   11 ++++++++---
 arch/powerpc/platforms/86xx/mpc86xx_smp.c |    2 +-
 arch/powerpc/platforms/powermac/smp.c     |    2 +-
 include/asm-powerpc/code-patching.h       |    5 +++--
 5 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 35b9a66..ee2dac5 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -42,8 +42,8 @@ static void __init create_trampoline(unsigned long addr)
 	 * branch to "addr" we jump to ("addr" + 32 MB). Although it requires
 	 * two instructions it doesn't require any registers.
 	 */
-	create_instruction(addr, 0x60000000); /* nop */
-	create_branch(addr + 4, addr + PHYSICAL_START, 0);
+	patch_instruction(addr, 0x60000000); /* nop */
+	patch_branch(addr + 4, addr + PHYSICAL_START, 0);
 }
 
 void __init setup_kdump_trampoline(void)
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 7afae88..1391981 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -11,7 +11,7 @@
 #include <asm/code-patching.h>
 
 
-void create_instruction(unsigned long addr, unsigned int instr)
+void patch_instruction(unsigned long addr, unsigned int instr)
 {
 	unsigned int *p;
 	p  = (unsigned int *)addr;
@@ -19,7 +19,12 @@ void create_instruction(unsigned long addr, unsigned int instr)
 	asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync" : : "r" (p));
 }
 
-void create_branch(unsigned long addr, unsigned long target, int flags)
+void patch_branch(unsigned long addr, unsigned long target, int flags)
+{
+	patch_instruction(addr, create_branch(addr, target, flags));
+}
+
+unsigned int create_branch(unsigned long addr, unsigned long target, int flags)
 {
 	unsigned int instruction;
 
@@ -29,5 +34,5 @@ void create_branch(unsigned long addr, unsigned long target, int flags)
 	/* Mask out the flags and target, so they don't step on each other. */
 	instruction = 0x48000000 | (flags & 0x3) | (target & 0x03FFFFFC);
 
-	create_instruction(addr, instruction);
+	return instruction;
 }
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_smp.c b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
index 63f5585..7c5ac68 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_smp.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
@@ -72,7 +72,7 @@ smp_86xx_kick_cpu(int nr)
 
 	/* Setup fake reset vector to call __secondary_start_mpc86xx. */
 	target = (unsigned long) __secondary_start_mpc86xx;
-	create_branch((unsigned long)vector, target, BRANCH_SET_LINK);
+	patch_branch((unsigned long)vector, target, BRANCH_SET_LINK);
 
 	/* Kick that CPU */
 	smp_86xx_release_core(nr);
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index bf202f7..ff483cb 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -805,7 +805,7 @@ static void __devinit smp_core99_kick_cpu(int nr)
 	 *   b __secondary_start_pmac_0 + nr*8 - KERNELBASE
 	 */
 	target = (unsigned long) __secondary_start_pmac_0 + nr * 8;
-	create_branch((unsigned long)vector, target, BRANCH_SET_LINK);
+	patch_branch((unsigned long)vector, target, BRANCH_SET_LINK);
 
 	/* Put some life in our friend */
 	pmac_call_feature(PMAC_FTR_RESET_CPU, NULL, nr, 0);
diff --git a/include/asm-powerpc/code-patching.h b/include/asm-powerpc/code-patching.h
index 0b91fdf..41ecae8 100644
--- a/include/asm-powerpc/code-patching.h
+++ b/include/asm-powerpc/code-patching.h
@@ -19,7 +19,8 @@
 #define BRANCH_SET_LINK	0x1
 #define BRANCH_ABSOLUTE	0x2
 
-extern void create_branch(unsigned long addr, unsigned long target, int flags);
-extern void create_instruction(unsigned long addr, unsigned int instr);
+unsigned int create_branch(unsigned long addr, unsigned long target, int flags);
+void patch_branch(unsigned long addr, unsigned long target, int flags);
+void patch_instruction(unsigned long addr, unsigned int instr);
 
 #endif /* _ASM_POWERPC_CODE_PATCHING_H */
-- 
1.5.5
