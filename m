Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <17f99785c873d7c70807f0ed33fb42466a6f9a4b.1212042061.git.michael@ellerman.id.au>
In-Reply-To: <33bba4965d9907a8a93e9f92fd5c3874a6e21f90.1212042061.git.michael@ellerman.id.au>
References: <33bba4965d9907a8a93e9f92fd5c3874a6e21f90.1212042061.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 6/6] Add PPC_NOP_INSTR,
	a hash define for the preferred nop instruction
Date: Thu, 29 May 2008 16:21:01 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A bunch of code has hard-coded the value for a "nop" instruction, it
would be nice to have a #define for it.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/cputable.c      |    3 ++-
 arch/powerpc/kernel/crash_dump.c    |    2 +-
 arch/powerpc/kernel/module_64.c     |    3 ++-
 include/asm-powerpc/code-patching.h |    2 ++
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index e44d553..887e190 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 
 #include <asm/oprofile_impl.h>
+#include <asm/code-patching.h>
 #include <asm/cputable.h>
 #include <asm/prom.h>		/* for PTRRELOC on ARCH=ppc */
 
@@ -1613,7 +1614,7 @@ void do_feature_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 		pend = ((unsigned int *)fcur) + (fcur->end_off / 4);
 
 		for (p = pstart; p < pend; p++) {
-			*p = 0x60000000u;
+			*p = PPC_NOP_INSTR;
 			asm volatile ("dcbst 0, %0" : : "r" (p));
 		}
 		asm volatile ("sync" : : : "memory");
diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index ee2dac5..2f5e04f 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -42,7 +42,7 @@ static void __init create_trampoline(unsigned long addr)
 	 * branch to "addr" we jump to ("addr" + 32 MB). Although it requires
 	 * two instructions it doesn't require any registers.
 	 */
-	patch_instruction(addr, 0x60000000); /* nop */
+	patch_instruction(addr, PPC_NOP_INSTR); /* nop */
 	patch_branch(addr + 4, addr + PHYSICAL_START, 0);
 }
 
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 3a82b02..d5e569a 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -24,6 +24,7 @@
 #include <asm/module.h>
 #include <asm/uaccess.h>
 #include <asm/firmware.h>
+#include <asm/code-patching.h>
 #include <linux/sort.h>
 
 #include "setup.h"
@@ -346,7 +347,7 @@ static unsigned long stub_for_addr(Elf64_Shdr *sechdrs,
    restore r2. */
 static int restore_r2(u32 *instruction, struct module *me)
 {
-	if (*instruction != 0x60000000) {
+	if (*instruction != PPC_NOP_INSTR) {
 		printk("%s: Expect noop after relocate, got %08x\n",
 		       me->name, *instruction);
 		return 0;
diff --git a/include/asm-powerpc/code-patching.h b/include/asm-powerpc/code-patching.h
index 8b54373..f33d16e 100644
--- a/include/asm-powerpc/code-patching.h
+++ b/include/asm-powerpc/code-patching.h
@@ -12,6 +12,8 @@
 
 #include <asm/types.h>
 
+#define PPC_NOP_INSTR	0x60000000
+
 /* Flags for create_branch:
  * "b"   == create_branch(addr, target, 0);
  * "ba"  == create_branch(addr, target, BRANCH_ABSOLUTE);
-- 
1.5.5
