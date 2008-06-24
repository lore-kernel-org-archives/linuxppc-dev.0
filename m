Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <58cb99151247b693ccb4ffd6f624cd2efddeea0e.1214271072.git.michael@ellerman.id.au>
In-Reply-To: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
References: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 05/14] powerpc: Add new code patching routines
Date: Tue, 24 Jun 2008 11:32:29 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This commit adds some new routines for patching code, they will be used
in a following commit.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/lib/code-patching.c    |  107 +++++++++++++++++++++++++++++++++++
 include/asm-powerpc/code-patching.h |    8 +++
 2 files changed, 115 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 430f4c1..27957c4 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -41,3 +41,110 @@ unsigned int create_branch(const unsigned int *addr,
 
 	return instruction;
 }
+
+unsigned int create_cond_branch(const unsigned int *addr,
+				unsigned long target, int flags)
+{
+	unsigned int instruction;
+	long offset;
+
+	offset = target;
+	if (! (flags & BRANCH_ABSOLUTE))
+		offset = offset - (unsigned long)addr;
+
+	/* Check we can represent the target in the instruction format */
+	if (offset < -0x8000 || offset > 0x7FFF || offset & 0x3)
+		return 0;
+
+	/* Mask out the flags and target, so they don't step on each other. */
+	instruction = 0x40000000 | (flags & 0x3FF0003) | (offset & 0xFFFC);
+
+	return instruction;
+}
+
+static unsigned int branch_opcode(unsigned int instr)
+{
+	return (instr >> 26) & 0x3F;
+}
+
+static int instr_is_branch_iform(unsigned int instr)
+{
+	return branch_opcode(instr) == 18;
+}
+
+static int instr_is_branch_bform(unsigned int instr)
+{
+	return branch_opcode(instr) == 16;
+}
+
+int instr_is_relative_branch(unsigned int instr)
+{
+	if (instr & BRANCH_ABSOLUTE)
+		return 0;
+
+	return instr_is_branch_iform(instr) || instr_is_branch_bform(instr);
+}
+
+static unsigned long branch_iform_target(const unsigned int *instr)
+{
+	signed long imm;
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
+	return (unsigned long)imm;
+}
+
+static unsigned long branch_bform_target(const unsigned int *instr)
+{
+	signed long imm;
+
+	imm = *instr & 0xFFFC;
+
+	/* If the top bit of the immediate value is set this is negative */
+	if (imm & 0x8000)
+		imm -= 0x10000;
+
+	if ((*instr & BRANCH_ABSOLUTE) == 0)
+		imm += (unsigned long)instr;
+
+	return (unsigned long)imm;
+}
+
+unsigned long branch_target(const unsigned int *instr)
+{
+	if (instr_is_branch_iform(*instr))
+		return branch_iform_target(instr);
+	else if (instr_is_branch_bform(*instr))
+		return branch_bform_target(instr);
+
+	return 0;
+}
+
+int instr_is_branch_to_addr(const unsigned int *instr, unsigned long addr)
+{
+	if (instr_is_branch_iform(*instr) || instr_is_branch_bform(*instr))
+		return branch_target(instr) == addr;
+
+	return 0;
+}
+
+unsigned int translate_branch(const unsigned int *dest, const unsigned int *src)
+{
+	unsigned long target;
+
+	target = branch_target(src);
+
+	if (instr_is_branch_iform(*src))
+		return create_branch(dest, target, *src);
+	else if (instr_is_branch_bform(*src))
+		return create_cond_branch(dest, target, *src);
+
+	return 0;
+}
diff --git a/include/asm-powerpc/code-patching.h b/include/asm-powerpc/code-patching.h
index a45a7ff..40ad46b 100644
--- a/include/asm-powerpc/code-patching.h
+++ b/include/asm-powerpc/code-patching.h
@@ -23,9 +23,17 @@
 
 unsigned int create_branch(const unsigned int *addr,
 			   unsigned long target, int flags);
+unsigned int create_cond_branch(const unsigned int *addr,
+				unsigned long target, int flags);
 void patch_branch(unsigned int *addr, unsigned long target, int flags);
 void patch_instruction(unsigned int *addr, unsigned int instr);
 
+int instr_is_relative_branch(unsigned int instr);
+int instr_is_branch_to_addr(const unsigned int *instr, unsigned long addr);
+unsigned long branch_target(const unsigned int *instr);
+unsigned int translate_branch(const unsigned int *dest,
+			      const unsigned int *src);
+
 static inline unsigned long ppc_function_entry(void *func)
 {
 #ifdef CONFIG_PPC64
-- 
1.5.5
