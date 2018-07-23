Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Z4cX1NWgzDqtW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 01:08:12 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/5] powerpc/asm: Add a patch_site macro & helpers for
 patching instructions
Date: Tue, 24 Jul 2018 01:07:52 +1000
Message-Id: <20180723150756.11108-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a macro and some helper C functions for patching single asm
instructions.

The gas macro means we can do something like:

  1:	nop
  	patch_site 1b, patch__foo

Which is less visually distracting than defining a GLOBAL symbol at 1,
and also doesn't pollute the symbol table which can confuse eg. perf.

These are obviously similar to our existing feature sections, but are
not automatically patched based on CPU/MMU features, rather they are
designed to be manually patched by C code at some arbitrary point.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/code-patching-asm.h | 18 ++++++++++++++++++
 arch/powerpc/include/asm/code-patching.h     |  2 ++
 arch/powerpc/lib/code-patching.c             | 16 ++++++++++++++++
 3 files changed, 36 insertions(+)
 create mode 100644 arch/powerpc/include/asm/code-patching-asm.h

diff --git a/arch/powerpc/include/asm/code-patching-asm.h b/arch/powerpc/include/asm/code-patching-asm.h
new file mode 100644
index 000000000000..ed7b1448493a
--- /dev/null
+++ b/arch/powerpc/include/asm/code-patching-asm.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2018, Michael Ellerman, IBM Corporation.
+ */
+#ifndef _ASM_POWERPC_CODE_PATCHING_ASM_H
+#define _ASM_POWERPC_CODE_PATCHING_ASM_H
+
+/* Define a "site" that can be patched */
+.macro patch_site label name
+	.pushsection ".rodata"
+	.balign 4
+	.global \name
+\name:
+	.4byte	\label - .
+	.popsection
+.endm
+
+#endif /* _ASM_POWERPC_CODE_PATCHING_ASM_H */
diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index 812535f40124..b2051234ada8 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -32,6 +32,8 @@ unsigned int create_cond_branch(const unsigned int *addr,
 int patch_branch(unsigned int *addr, unsigned long target, int flags);
 int patch_instruction(unsigned int *addr, unsigned int instr);
 int raw_patch_instruction(unsigned int *addr, unsigned int instr);
+int patch_instruction_site(s32 *addr, unsigned int instr);
+int patch_branch_site(s32 *site, unsigned long target, int flags);
 
 int instr_is_relative_branch(unsigned int instr);
 int instr_is_relative_link_branch(unsigned int instr);
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index e0d881ab304e..850f3b8f4da5 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -195,6 +195,22 @@ int patch_branch(unsigned int *addr, unsigned long target, int flags)
 	return patch_instruction(addr, create_branch(addr, target, flags));
 }
 
+int patch_branch_site(s32 *site, unsigned long target, int flags)
+{
+	unsigned int *addr;
+
+	addr = (unsigned int *)((unsigned long)site + *site);
+	return patch_instruction(addr, create_branch(addr, target, flags));
+}
+
+int patch_instruction_site(s32 *site, unsigned int instr)
+{
+	unsigned int *addr;
+
+	addr = (unsigned int *)((unsigned long)site + *site);
+	return patch_instruction(addr, instr);
+}
+
 bool is_offset_in_branch_range(long offset)
 {
 	/*
-- 
2.14.1
