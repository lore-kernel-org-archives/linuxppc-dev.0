Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <bda40d2750deae8e742dc9d115a6aab4843701ee.1214271072.git.michael@ellerman.id.au>
In-Reply-To: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
References: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 02/14] powerpc: Allow create_branch() to return errors
Date: Tue, 24 Jun 2008 11:32:22 +1000 (EST)
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

While we're touching all the callers, change to using unsigned int *, as
this seems to match usage better. That allows (and requires) us to remove
the volatile in the definition of vector in powermac/smp.c and mpc86xx_smp.c,
that's correct because now that we're passing vector as an unsigned int *
the compiler knows that it's value might change across the patch_branch()
call.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/crash_dump.c          |    6 ++++--
 arch/powerpc/lib/code-patching.c          |   20 ++++++++++++--------
 arch/powerpc/platforms/86xx/mpc86xx_smp.c |    5 ++---
 arch/powerpc/platforms/powermac/smp.c     |    5 ++---
 include/asm-powerpc/code-patching.h       |    6 ++++--
 5 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 35b9a66..2664854 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -34,6 +34,8 @@ void __init reserve_kdump_trampoline(void)
 
 static void __init create_trampoline(unsigned long addr)
 {
+	unsigned int *p = (unsigned int *)addr;
+
 	/* The maximum range of a single instruction branch, is the current
 	 * instruction's address + (32 MB - 4) bytes. For the trampoline we
 	 * need to branch to current address + 32 MB. So we insert a nop at
@@ -42,8 +44,8 @@ static void __init create_trampoline(unsigned long addr)
 	 * branch to "addr" we jump to ("addr" + 32 MB). Although it requires
 	 * two instructions it doesn't require any registers.
 	 */
-	create_instruction(addr, 0x60000000); /* nop */
-	create_branch(addr + 4, addr + PHYSICAL_START, 0);
+	patch_instruction(p, 0x60000000); /* nop */
+	patch_branch(++p, addr + PHYSICAL_START, 0);
 }
 
 void __init setup_kdump_trampoline(void)
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 7afae88..638dde3 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -11,23 +11,27 @@
 #include <asm/code-patching.h>
 
 
-void create_instruction(unsigned long addr, unsigned int instr)
+void patch_instruction(unsigned int *addr, unsigned int instr)
 {
-	unsigned int *p;
-	p  = (unsigned int *)addr;
-	*p = instr;
-	asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync" : : "r" (p));
+	*addr = instr;
+	asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync" : : "r" (addr));
 }
 
-void create_branch(unsigned long addr, unsigned long target, int flags)
+void patch_branch(unsigned int *addr, unsigned long target, int flags)
+{
+	patch_instruction(addr, create_branch(addr, target, flags));
+}
+
+unsigned int create_branch(const unsigned int *addr,
+			   unsigned long target, int flags)
 {
 	unsigned int instruction;
 
 	if (! (flags & BRANCH_ABSOLUTE))
-		target = target - addr;
+		target = target - (unsigned long)addr;
 
 	/* Mask out the flags and target, so they don't step on each other. */
 	instruction = 0x48000000 | (flags & 0x3) | (target & 0x03FFFFFC);
 
-	create_instruction(addr, instruction);
+	return instruction;
 }
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_smp.c b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
index 63f5585..835f2dc 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_smp.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
@@ -57,8 +57,7 @@ smp_86xx_kick_cpu(int nr)
 	unsigned int save_vector;
 	unsigned long target, flags;
 	int n = 0;
-	volatile unsigned int *vector
-		 = (volatile unsigned int *)(KERNELBASE + 0x100);
+	unsigned int *vector = (unsigned int *)(KERNELBASE + 0x100);
 
 	if (nr < 0 || nr >= NR_CPUS)
 		return;
@@ -72,7 +71,7 @@ smp_86xx_kick_cpu(int nr)
 
 	/* Setup fake reset vector to call __secondary_start_mpc86xx. */
 	target = (unsigned long) __secondary_start_mpc86xx;
-	create_branch((unsigned long)vector, target, BRANCH_SET_LINK);
+	patch_branch(vector, target, BRANCH_SET_LINK);
 
 	/* Kick that CPU */
 	smp_86xx_release_core(nr);
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index bf202f7..4ae3d00 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -787,8 +787,7 @@ static void __devinit smp_core99_kick_cpu(int nr)
 {
 	unsigned int save_vector;
 	unsigned long target, flags;
-	volatile unsigned int *vector
-		 = ((volatile unsigned int *)(KERNELBASE+0x100));
+	unsigned int *vector = (unsigned int *)(KERNELBASE+0x100);
 
 	if (nr < 0 || nr > 3)
 		return;
@@ -805,7 +804,7 @@ static void __devinit smp_core99_kick_cpu(int nr)
 	 *   b __secondary_start_pmac_0 + nr*8 - KERNELBASE
 	 */
 	target = (unsigned long) __secondary_start_pmac_0 + nr * 8;
-	create_branch((unsigned long)vector, target, BRANCH_SET_LINK);
+	patch_branch(vector, target, BRANCH_SET_LINK);
 
 	/* Put some life in our friend */
 	pmac_call_feature(PMAC_FTR_RESET_CPU, NULL, nr, 0);
diff --git a/include/asm-powerpc/code-patching.h b/include/asm-powerpc/code-patching.h
index 0b91fdf..fdb187c 100644
--- a/include/asm-powerpc/code-patching.h
+++ b/include/asm-powerpc/code-patching.h
@@ -19,7 +19,9 @@
 #define BRANCH_SET_LINK	0x1
 #define BRANCH_ABSOLUTE	0x2
 
-extern void create_branch(unsigned long addr, unsigned long target, int flags);
-extern void create_instruction(unsigned long addr, unsigned int instr);
+unsigned int create_branch(const unsigned int *addr,
+			   unsigned long target, int flags);
+void patch_branch(unsigned int *addr, unsigned long target, int flags);
+void patch_instruction(unsigned int *addr, unsigned int instr);
 
 #endif /* _ASM_POWERPC_CODE_PATCHING_H */
-- 
1.5.5
