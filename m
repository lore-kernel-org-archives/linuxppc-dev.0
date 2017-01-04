Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttfD76hqnzDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 16:16:07 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Steven Munroe <munroesj@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/9] powerpc: Move ARCH_DLINFO out of uapi
Date: Wed,  4 Jan 2017 16:15:27 +1100
Message-Id: <20170104051535.9454-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It's an kernel private macro, it doesn't belong there

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/elf.h      | 22 ++++++++++++++++++++++
 arch/powerpc/include/uapi/asm/elf.h | 23 -----------------------
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index ee46ffe..730c27e 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -136,4 +136,26 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 
 #endif /* CONFIG_SPU_BASE */
 
+/*
+ * The requirements here are:
+ * - keep the final alignment of sp (sp & 0xf)
+ * - make sure the 32-bit value at the first 16 byte aligned position of
+ *   AUXV is greater than 16 for glibc compatibility.
+ *   AT_IGNOREPPC is used for that.
+ * - for compatibility with glibc ARCH_DLINFO must always be defined on PPC,
+ *   even if DLINFO_ARCH_ITEMS goes to zero or is undefined.
+ * update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes
+ */
+#define ARCH_DLINFO							\
+do {									\
+	/* Handle glibc compatibility. */				\
+	NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);			\
+	NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);			\
+	/* Cache size items */						\
+	NEW_AUX_ENT(AT_DCACHEBSIZE, dcache_bsize);			\
+	NEW_AUX_ENT(AT_ICACHEBSIZE, icache_bsize);			\
+	NEW_AUX_ENT(AT_UCACHEBSIZE, ucache_bsize);			\
+	VDSO_AUX_ENT(AT_SYSINFO_EHDR, current->mm->context.vdso_base);	\
+} while (0)
+
 #endif /* _ASM_POWERPC_ELF_H */
diff --git a/arch/powerpc/include/uapi/asm/elf.h b/arch/powerpc/include/uapi/asm/elf.h
index 3a9e44c..b2c6fdd 100644
--- a/arch/powerpc/include/uapi/asm/elf.h
+++ b/arch/powerpc/include/uapi/asm/elf.h
@@ -162,29 +162,6 @@ typedef elf_vrreg_t elf_vrregset_t32[ELF_NVRREG32];
 typedef elf_fpreg_t elf_vsrreghalf_t32[ELF_NVSRHALFREG];
 #endif
 
-
-/*
- * The requirements here are:
- * - keep the final alignment of sp (sp & 0xf)
- * - make sure the 32-bit value at the first 16 byte aligned position of
- *   AUXV is greater than 16 for glibc compatibility.
- *   AT_IGNOREPPC is used for that.
- * - for compatibility with glibc ARCH_DLINFO must always be defined on PPC,
- *   even if DLINFO_ARCH_ITEMS goes to zero or is undefined.
- * update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes
- */
-#define ARCH_DLINFO							\
-do {									\
-	/* Handle glibc compatibility. */				\
-	NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);			\
-	NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);			\
-	/* Cache size items */						\
-	NEW_AUX_ENT(AT_DCACHEBSIZE, dcache_bsize);			\
-	NEW_AUX_ENT(AT_ICACHEBSIZE, icache_bsize);			\
-	NEW_AUX_ENT(AT_UCACHEBSIZE, ucache_bsize);			\
-	VDSO_AUX_ENT(AT_SYSINFO_EHDR, current->mm->context.vdso_base);	\
-} while (0)
-
 /* PowerPC64 relocations defined by the ABIs */
 #define R_PPC64_NONE    R_PPC_NONE
 #define R_PPC64_ADDR32  R_PPC_ADDR32  /* 32bit absolute address.  */
-- 
2.9.3
