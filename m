Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <48f64aeaef7c61529488ddfadabdf67ec61a09f1.1214271072.git.michael@ellerman.id.au>
In-Reply-To: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
References: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 06/14] powerpc: Add tests of the code patching routines
Date: Tue, 24 Jun 2008 11:32:32 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add tests of the existing code patching routines, as well as the new
routines added in the last commit. The self-tests are run late in boot
when CONFIG_CODE_PATCHING_SELFTEST=y, which depends on DEBUG_KERNEL=y.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/Kconfig.debug       |    5 +
 arch/powerpc/lib/code-patching.c |  298 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 303 insertions(+), 0 deletions(-)

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
index 27957c4..0559fe0 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -8,6 +8,9 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/vmalloc.h>
+#include <linux/init.h>
+#include <asm/page.h>
 #include <asm/code-patching.h>
 
 
@@ -148,3 +151,298 @@ unsigned int translate_branch(const unsigned int *dest, const unsigned int *src)
 
 	return 0;
 }
+
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
+static void __init test_branch_iform(void)
+{
+	unsigned int instr;
+	unsigned long addr;
+
+	addr = (unsigned long)&instr;
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
+	/* Simplest case, branch to self with link */
+	check(instr_is_branch_iform(0x48000001));
+	/* All bits of targets set */
+	check(instr_is_branch_iform(0x4bfffffd));
+	/* Some bits of targets set */
+	check(instr_is_branch_iform(0x4bff00fd));
+	/* Must be a valid branch to start with */
+	check(!instr_is_branch_iform(0x7bfffffd));
+
+	/* Absolute branch to 0x100 */
+	instr = 0x48000103;
+	check(instr_is_branch_to_addr(&instr, 0x100));
+	/* Absolute branch to 0x420fc */
+	instr = 0x480420ff;
+	check(instr_is_branch_to_addr(&instr, 0x420fc));
+	/* Maximum positive relative branch, + 20MB - 4B */
+	instr = 0x49fffffc;
+	check(instr_is_branch_to_addr(&instr, addr + 0x1FFFFFC));
+	/* Smallest negative relative branch, - 4B */
+	instr = 0x4bfffffc;
+	check(instr_is_branch_to_addr(&instr, addr - 4));
+	/* Largest negative relative branch, - 32 MB */
+	instr = 0x4a000000;
+	check(instr_is_branch_to_addr(&instr, addr - 0x2000000));
+
+	/* Branch to self, with link */
+	instr = create_branch(&instr, addr, BRANCH_SET_LINK);
+	check(instr_is_branch_to_addr(&instr, addr));
+
+	/* Branch to self - 0x100, with link */
+	instr = create_branch(&instr, addr - 0x100, BRANCH_SET_LINK);
+	check(instr_is_branch_to_addr(&instr, addr - 0x100));
+
+	/* Branch to self + 0x100, no link */
+	instr = create_branch(&instr, addr + 0x100, 0);
+	check(instr_is_branch_to_addr(&instr, addr + 0x100));
+
+	/* Maximum relative negative offset, - 32 MB */
+	instr = create_branch(&instr, addr - 0x2000000, BRANCH_SET_LINK);
+	check(instr_is_branch_to_addr(&instr, addr - 0x2000000));
+
+	/* Out of range relative negative offset, - 32 MB + 4*/
+	instr = create_branch(&instr, addr - 0x2000004, BRANCH_SET_LINK);
+	check(instr == 0);
+
+	/* Out of range relative positive offset, + 32 MB */
+	instr = create_branch(&instr, addr + 0x2000000, BRANCH_SET_LINK);
+	check(instr == 0);
+
+	/* Unaligned target */
+	instr = create_branch(&instr, addr + 3, BRANCH_SET_LINK);
+	check(instr == 0);
+
+	/* Check flags are masked correctly */
+	instr = create_branch(&instr, addr, 0xFFFFFFFC);
+	check(instr_is_branch_to_addr(&instr, addr));
+	check(instr == 0x48000000);
+}
+
+static void __init test_create_function_call(void)
+{
+	unsigned int *iptr;
+	unsigned long dest;
+
+	/* Check we can create a function call */
+	iptr = (unsigned int *)ppc_function_entry(test_trampoline);
+	dest = ppc_function_entry(test_create_function_call);
+	patch_instruction(iptr, create_branch(iptr, dest, BRANCH_SET_LINK));
+	check(instr_is_branch_to_addr(iptr, dest));
+}
+
+static void __init test_branch_bform(void)
+{
+	unsigned long addr;
+	unsigned int *iptr, instr, flags;
+
+	iptr = &instr;
+	addr = (unsigned long)iptr;
+
+	/* The simplest case, branch to self, no flags */
+	check(instr_is_branch_bform(0x40000000));
+	/* All bits of target set, and flags */
+	check(instr_is_branch_bform(0x43ffffff));
+	/* High bit of opcode set, which is wrong */
+	check(!instr_is_branch_bform(0xc3ffffff));
+	/* Middle bits of opcode set, which is wrong */
+	check(!instr_is_branch_bform(0x7bffffff));
+
+	/* Absolute conditional branch to 0x100 */
+	instr = 0x43ff0103;
+	check(instr_is_branch_to_addr(&instr, 0x100));
+	/* Absolute conditional branch to 0x20fc */
+	instr = 0x43ff20ff;
+	check(instr_is_branch_to_addr(&instr, 0x20fc));
+	/* Maximum positive relative conditional branch, + 32 KB - 4B */
+	instr = 0x43ff7ffc;
+	check(instr_is_branch_to_addr(&instr, addr + 0x7FFC));
+	/* Smallest negative relative conditional branch, - 4B */
+	instr = 0x43fffffc;
+	check(instr_is_branch_to_addr(&instr, addr - 4));
+	/* Largest negative relative conditional branch, - 32 KB */
+	instr = 0x43ff8000;
+	check(instr_is_branch_to_addr(&instr, addr - 0x8000));
+
+	/* All condition code bits set & link */
+	flags = 0x3ff000 | BRANCH_SET_LINK;
+
+	/* Branch to self */
+	instr = create_cond_branch(iptr, addr, flags);
+	check(instr_is_branch_to_addr(&instr, addr));
+
+	/* Branch to self - 0x100 */
+	instr = create_cond_branch(iptr, addr - 0x100, flags);
+	check(instr_is_branch_to_addr(&instr, addr - 0x100));
+
+	/* Branch to self + 0x100 */
+	instr = create_cond_branch(iptr, addr + 0x100, flags);
+	check(instr_is_branch_to_addr(&instr, addr + 0x100));
+
+	/* Maximum relative negative offset, - 32 KB */
+	instr = create_cond_branch(iptr, addr - 0x8000, flags);
+	check(instr_is_branch_to_addr(&instr, addr - 0x8000));
+
+	/* Out of range relative negative offset, - 32 KB + 4*/
+	instr = create_cond_branch(iptr, addr - 0x8004, flags);
+	check(instr == 0);
+
+	/* Out of range relative positive offset, + 32 KB */
+	instr = create_cond_branch(iptr, addr + 0x8000, flags);
+	check(instr == 0);
+
+	/* Unaligned target */
+	instr = create_cond_branch(iptr, addr + 3, flags);
+	check(instr == 0);
+
+	/* Check flags are masked correctly */
+	instr = create_cond_branch(iptr, addr, 0xFFFFFFFC);
+	check(instr_is_branch_to_addr(&instr, addr));
+	check(instr == 0x43FF0000);
+}
+
+static void __init test_translate_branch(void)
+{
+	unsigned long addr;
+	unsigned int *p, *q;
+	void *buf;
+
+	buf = vmalloc(PAGE_ALIGN(0x2000000 + 1));
+	check(buf);
+	if (!buf)
+		return;
+
+	/* Simple case, branch to self moved a little */
+	p = buf;
+	addr = (unsigned long)p;
+	patch_branch(p, addr, 0);
+	check(instr_is_branch_to_addr(p, addr));
+	q = p + 1;
+	patch_instruction(q, translate_branch(q, p));
+	check(instr_is_branch_to_addr(q, addr));
+
+	/* Maximum negative case, move b . to addr + 32 MB */
+	p = buf;
+	addr = (unsigned long)p;
+	patch_branch(p, addr, 0);
+	q = buf + 0x2000000;
+	patch_instruction(q, translate_branch(q, p));
+	check(instr_is_branch_to_addr(p, addr));
+	check(instr_is_branch_to_addr(q, addr));
+	check(*q == 0x4a000000);
+
+	/* Maximum positive case, move x to x - 32 MB + 4 */
+	p = buf + 0x2000000;
+	addr = (unsigned long)p;
+	patch_branch(p, addr, 0);
+	q = buf + 4;
+	patch_instruction(q, translate_branch(q, p));
+	check(instr_is_branch_to_addr(p, addr));
+	check(instr_is_branch_to_addr(q, addr));
+	check(*q == 0x49fffffc);
+
+	/* Jump to x + 16 MB moved to x + 20 MB */
+	p = buf;
+	addr = 0x1000000 + (unsigned long)buf;
+	patch_branch(p, addr, BRANCH_SET_LINK);
+	q = buf + 0x1400000;
+	patch_instruction(q, translate_branch(q, p));
+	check(instr_is_branch_to_addr(p, addr));
+	check(instr_is_branch_to_addr(q, addr));
+
+	/* Jump to x + 16 MB moved to x - 16 MB + 4 */
+	p = buf + 0x1000000;
+	addr = 0x2000000 + (unsigned long)buf;
+	patch_branch(p, addr, 0);
+	q = buf + 4;
+	patch_instruction(q, translate_branch(q, p));
+	check(instr_is_branch_to_addr(p, addr));
+	check(instr_is_branch_to_addr(q, addr));
+
+
+	/* Conditional branch tests */
+
+	/* Simple case, branch to self moved a little */
+	p = buf;
+	addr = (unsigned long)p;
+	patch_instruction(p, create_cond_branch(p, addr, 0));
+	check(instr_is_branch_to_addr(p, addr));
+	q = p + 1;
+	patch_instruction(q, translate_branch(q, p));
+	check(instr_is_branch_to_addr(q, addr));
+
+	/* Maximum negative case, move b . to addr + 32 KB */
+	p = buf;
+	addr = (unsigned long)p;
+	patch_instruction(p, create_cond_branch(p, addr, 0xFFFFFFFC));
+	q = buf + 0x8000;
+	patch_instruction(q, translate_branch(q, p));
+	check(instr_is_branch_to_addr(p, addr));
+	check(instr_is_branch_to_addr(q, addr));
+	check(*q == 0x43ff8000);
+
+	/* Maximum positive case, move x to x - 32 KB + 4 */
+	p = buf + 0x8000;
+	addr = (unsigned long)p;
+	patch_instruction(p, create_cond_branch(p, addr, 0xFFFFFFFC));
+	q = buf + 4;
+	patch_instruction(q, translate_branch(q, p));
+	check(instr_is_branch_to_addr(p, addr));
+	check(instr_is_branch_to_addr(q, addr));
+	check(*q == 0x43ff7ffc);
+
+	/* Jump to x + 12 KB moved to x + 20 KB */
+	p = buf;
+	addr = 0x3000 + (unsigned long)buf;
+	patch_instruction(p, create_cond_branch(p, addr, BRANCH_SET_LINK));
+	q = buf + 0x5000;
+	patch_instruction(q, translate_branch(q, p));
+	check(instr_is_branch_to_addr(p, addr));
+	check(instr_is_branch_to_addr(q, addr));
+
+	/* Jump to x + 8 KB moved to x - 8 KB + 4 */
+	p = buf + 0x2000;
+	addr = 0x4000 + (unsigned long)buf;
+	patch_instruction(p, create_cond_branch(p, addr, 0));
+	q = buf + 4;
+	patch_instruction(q, translate_branch(q, p));
+	check(instr_is_branch_to_addr(p, addr));
+	check(instr_is_branch_to_addr(q, addr));
+
+	/* Free the buffer we were using */
+	vfree(buf);
+}
+
+static int __init test_code_patching(void)
+{
+	printk(KERN_DEBUG "Running code patching self-tests ...\n");
+
+	test_branch_iform();
+	test_branch_bform();
+	test_create_function_call();
+	test_translate_branch();
+
+	return 0;
+}
+late_initcall(test_code_patching);
+
+#endif /* CONFIG_CODE_PATCHING_SELFTEST */
-- 
1.5.5
