Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <04ad14b4b4580d635c001cec3ec1d9121f4055f4.1212042061.git.michael@ellerman.id.au>
In-Reply-To: <33bba4965d9907a8a93e9f92fd5c3874a6e21f90.1212042061.git.michael@ellerman.id.au>
References: <33bba4965d9907a8a93e9f92fd5c3874a6e21f90.1212042061.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 5/6] Add tests for the code patching code,
	and introduce checking functions
Date: Thu, 29 May 2008 16:21:00 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some code I am working on wants to check that the code it's patching is
what it expects, so add three functions which check the passed instruction
to see what it is.

Add some tests for those routines, and also test the results of the existing
create_branch() function using the new routines.

It would be nice to have the test code enabled automatically for debug
kernels, but distros turn on DEBUG_KERNEL so we don't really have a config
symbol we can tie it off.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/Kconfig.debug          |    5 +
 arch/powerpc/lib/code-patching.c    |  140 +++++++++++++++++++++++++++++++++++
 include/asm-powerpc/code-patching.h |    4 +
 3 files changed, 149 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index a7d24e6..dc58939 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -57,6 +57,11 @@ config KGDB
 	  debugger.  See <http://kgdb.sourceforge.net/> for more information.
 	  Unless you are intending to debug the kernel, say N here.
 
+config CODE_PATCHING_SELFTEST
+	bool "Run self-tests of the code-patching code."
+	depends on DEBUG_KERNEL
+	default n
+
 choice
 	prompt "Serial Port"
 	depends on KGDB
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 2905c51..13e29eb 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/init.h>
 #include <asm/code-patching.h>
 
 
@@ -42,3 +43,142 @@ unsigned int create_branch(unsigned long addr, unsigned long target, int flags)
 
 	return instruction;
 }
+
+int instr_is_branch_iform(unsigned int instr)
+{
+	unsigned int opcode;
+
+	opcode = (instr >> 26) & 0x3F;
+
+	return opcode == 18;
+}
+
+int instr_is_bl(unsigned int instr)
+{
+	return instr_is_branch_iform(instr) &&
+	       ((instr & BRANCH_SET_LINK) == 1) &&
+	       ((instr & BRANCH_ABSOLUTE) == 0);
+}
+
+int instr_is_branch_to_addr(unsigned int *instr, unsigned long addr)
+{
+	signed long imm;
+
+	if (!instr_is_branch_iform(*instr))
+		return 0;
+
+	imm = *instr & 0x3FFFFFC;
+
+	/* If the top bit of the immediate value is set this is negative */
+	if (imm & 0x2000000)
+		imm -= 0x4000000;
+
+	if ((*instr & BRANCH_ABSOLUTE) == 0)
+		imm += (unsigned long)instr;
+
+	return (unsigned long)imm == addr;
+}
+
+#ifdef CONFIG_CODE_PATCHING_SELFTEST
+
+static void __init test_trampoline(void)
+{
+	asm ("nop;\n");
+}
+
+#define check(x)	\
+	if (!(x)) printk("code-patching: test failed at line %d\n", __LINE__);
+
+static int __init test_code_patching(void)
+{
+	unsigned long addr, dest;
+	unsigned int instr;
+
+	addr = (unsigned long)&instr;
+
+	printk(KERN_DEBUG "Running code patching self-tests ...\n");
+
+	/* The simplest case, branch to self, no flags */
+	check(instr_is_branch_iform(0x48000000));
+	/* All bits of target set, and flags */
+	check(instr_is_branch_iform(0x4bffffff));
+	/* High bit of opcode set, which is wrong */
+	check(!instr_is_branch_iform(0xcbffffff));
+	/* Middle bits of opcode set, which is wrong */
+	check(!instr_is_branch_iform(0x7bffffff));
+
+	/* Simplest case, branch to self, with link */
+	check(instr_is_bl(0x48000001));
+	/* All bits of targets set, and link */
+	check(instr_is_bl(0x4bfffffd));
+	/* Some bits of targets set, and link */
+	check(instr_is_bl(0x4bff00fd));
+	/* All bits of targets set, no flags, ie. link is false */
+	check(!instr_is_bl(0x4bfffffc));
+	/* Must be a valid branch to start with */
+	check(!instr_is_bl(0x7bfffffd));
+
+	/* Absolute branch to 0x100 */
+	instr = 0x48000103;
+	check(instr_is_branch_to_addr(&instr, 0x100));
+	/* Absolute branch to 0x420fc */
+	instr = 0x480420ff;
+	check(instr_is_branch_to_addr(&instr, 0x420fc));
+
+	/* Maximum positive relative branch, + 20MB - 4B */
+	instr = 0x49fffffc;
+	check(instr_is_branch_to_addr(&instr, addr + 0x1FFFFFC));
+
+	/* Smallest negative relative branch, - 4B */
+	instr = 0x4bfffffc;
+	check(instr_is_branch_to_addr(&instr, addr - 4));
+
+	/* Largest negative relative branch, - 32 MB */
+	instr = 0x4a000000;
+	check(instr_is_branch_to_addr(&instr, addr - 0x2000000));
+
+
+	/* Branch to self, with link */
+	instr = create_branch(addr, addr, BRANCH_SET_LINK);
+	check(instr_is_branch_to_addr(&instr, addr));
+	check(instr_is_bl(instr));
+
+	/* Branch to self - 0x100, with link */
+	instr = create_branch(addr, addr - 0x100, BRANCH_SET_LINK);
+	check(instr_is_branch_to_addr(&instr, addr - 0x100));
+	check(instr_is_bl(instr));
+
+	/* Branch to self + 0x100, no link */
+	instr = create_branch(addr, addr + 0x100, 0);
+	check(instr_is_branch_to_addr(&instr, addr + 0x100));
+	check(!instr_is_bl(instr));
+
+	/* Maximum relative negative offset, - 32 MB */
+	instr = create_branch(addr, addr - 0x2000000, BRANCH_SET_LINK);
+	check(instr_is_branch_to_addr(&instr, addr - 0x2000000));
+	check(instr_is_bl(instr));
+
+	/* Out of range relative negative offset, - 32 MB + 4*/
+	instr = create_branch(addr, addr - 0x2000004, BRANCH_SET_LINK);
+	check(instr == 0);
+
+	/* Out of range relative positive offset, + 32 MB */
+	instr = create_branch(addr, addr + 0x2000000, BRANCH_SET_LINK);
+	check(instr == 0);
+
+	/* Unaligned target */
+	instr = create_branch(addr, addr + 3, BRANCH_SET_LINK);
+	check(instr == 0);
+
+	/* Check we can create a function call */
+	addr = ppc_function_entry(test_trampoline);
+	dest = ppc_function_entry(test_code_patching);
+	instr = create_branch(addr, dest, BRANCH_SET_LINK);
+	patch_instruction(addr, instr);
+	check(instr_is_branch_to_addr((unsigned int *)addr, dest));
+
+	return 0;
+}
+late_initcall(test_code_patching);
+
+#endif /* CONFIG_CODE_PATCHING_SELFTEST */
diff --git a/include/asm-powerpc/code-patching.h b/include/asm-powerpc/code-patching.h
index 0213a48..8b54373 100644
--- a/include/asm-powerpc/code-patching.h
+++ b/include/asm-powerpc/code-patching.h
@@ -25,6 +25,10 @@ unsigned int create_branch(unsigned long addr, unsigned long target, int flags);
 void patch_branch(unsigned long addr, unsigned long target, int flags);
 void patch_instruction(unsigned long addr, unsigned int instr);
 
+int instr_is_branch_iform(unsigned int instr);
+int instr_is_bl(unsigned int instr);
+int instr_is_branch_to_addr(unsigned int *instr, unsigned long addr);
+
 static inline unsigned long ppc_function_entry(void *func)
 {
 #ifdef CONFIG_PPC64
-- 
1.5.5
