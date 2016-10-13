Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svflq4G9KzDt13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 16:43:19 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id r16so4283557pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 22:43:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/3] powerpc: relative exception tables
Date: Thu, 13 Oct 2016 16:42:54 +1100
Message-Id: <20161013054255.7205-3-npiggin@gmail.com>
In-Reply-To: <20161013054255.7205-1-npiggin@gmail.com>
References: <20161013054255.7205-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This halves the exception table size on 64-bit builds, and it
allows build-time sorting of exception tables to work on
relocated kernels.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/linkage.h                | 20 ++++++++---------
 arch/powerpc/include/asm/uaccess.h                | 27 ++++++++++++++---------
 arch/powerpc/kernel/kprobes.c                     |  2 +-
 arch/powerpc/kernel/traps.c                       |  2 +-
 arch/powerpc/mm/fault.c                           |  2 +-
 arch/powerpc/platforms/embedded6xx/holly.c        |  2 +-
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |  2 +-
 arch/powerpc/sysdev/fsl_rio.c                     |  2 +-
 8 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/linkage.h b/arch/powerpc/include/asm/linkage.h
index fcb9e0d..6898bf5 100644
--- a/arch/powerpc/include/asm/linkage.h
+++ b/arch/powerpc/include/asm/linkage.h
@@ -16,20 +16,20 @@
 /*
  * Helper macro for exception table entries
  */
-#define EX_TABLE(_fault, _target)	\
-	".section __ex_table,\"a\"\n"	\
-		PPC_LONG_ALIGN "\n"	\
-		PPC_LONG #_fault "\n"	\
-		PPC_LONG #_target "\n"	\
+#define EX_TABLE(_fault, _target)			\
+	".section __ex_table,\"a\"\n"			\
+		".balign 4\n"				\
+		".long (" #_fault  ") - . \n"		\
+		".long (" #_target ") - . \n"		\
 	".previous\n"
 
 #else /* __ASSEMBLY__ */
 
-#define EX_TABLE(_fault, _target)	\
-	.section __ex_table,"a"	;	\
-		PPC_LONG_ALIGN ;	\
-		PPC_LONG _fault	;	\
-		PPC_LONG _target ;	\
+#define EX_TABLE(_fault, _target)			\
+	.section __ex_table,"a"	;			\
+		.balign 4;				\
+		.long (_fault) - . ;			\
+		.long (_target) - . ;			\
 	.previous
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index caff75e..f485a01 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -63,23 +63,30 @@
 	 __access_ok((__force unsigned long)(addr), (size), get_fs()))
 
 /*
- * The exception table consists of pairs of addresses: the first is the
- * address of an instruction that is allowed to fault, and the second is
+ * The exception table consists of pairs of relative addresses: the first is
+ * the address of an instruction that is allowed to fault, and the second is
  * the address at which the program should continue.  No registers are
- * modified, so it is entirely up to the continuation code to figure out
- * what to do.
+ * modified, so it is entirely up to the continuation code to figure out what
+ * to do.
  *
- * All the routines below use bits of fixup code that are out of line
- * with the main instruction path.  This means when everything is well,
- * we don't even have to jump over them.  Further, they do not intrude
- * on our cache or tlb entries.
+ * All the routines below use bits of fixup code that are out of line with the
+ * main instruction path.  This means when everything is well, we don't even
+ * have to jump over them.  Further, they do not intrude on our cache or tlb
+ * entries.
  */
 
+#define ARCH_HAS_RELATIVE_EXTABLE
+
 struct exception_table_entry {
-	unsigned long insn;
-	unsigned long fixup;
+	int insn;
+	int fixup;
 };
 
+static inline unsigned long extable_fixup(const struct exception_table_entry *x)
+{
+	return (unsigned long)&x->fixup + x->fixup;
+}
+
 /*
  * These are the main single-value transfer routines.  They automatically
  * use the right size if we just have the right pointer type.
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index e785cc9..9479d8e 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -449,7 +449,7 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 		 * zero, try to fix up.
 		 */
 		if ((entry = search_exception_tables(regs->nip)) != NULL) {
-			regs->nip = entry->fixup;
+			regs->nip = extable_fixup(entry);
 			return 1;
 		}
 
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index a1f8f56..ec5fd09 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -366,7 +366,7 @@ static inline int check_io_access(struct pt_regs *regs)
 			       (*nip & 0x100)? "OUT to": "IN from",
 			       regs->gpr[rb] - _IO_BASE, nip);
 			regs->msr |= MSR_RI;
-			regs->nip = entry->fixup;
+			regs->nip = extable_fixup(entry);
 			return 1;
 		}
 	}
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index d0b137d..73932f4 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -512,7 +512,7 @@ void bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
 
 	/* Are we prepared to handle this fault?  */
 	if ((entry = search_exception_tables(regs->nip)) != NULL) {
-		regs->nip = entry->fixup;
+		regs->nip = extable_fixup(entry);
 		return;
 	}
 
diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
index dfd3100..0409714 100644
--- a/arch/powerpc/platforms/embedded6xx/holly.c
+++ b/arch/powerpc/platforms/embedded6xx/holly.c
@@ -263,7 +263,7 @@ static int ppc750_machine_check_exception(struct pt_regs *regs)
 	if ((entry = search_exception_tables(regs->nip)) != NULL) {
 		tsi108_clear_pci_cfg_error();
 		regs->msr |= MSR_RI;
-		regs->nip = entry->fixup;
+		regs->nip = extable_fixup(entry);
 		return 1;
 	}
 	return 0;
diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
index f97bab8..9de100e 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -174,7 +174,7 @@ static int mpc7448_machine_check_exception(struct pt_regs *regs)
 	if ((entry = search_exception_tables(regs->nip)) != NULL) {
 		tsi108_clear_pci_cfg_error();
 		regs->msr |= MSR_RI;
-		regs->nip = entry->fixup;
+		regs->nip = extable_fixup(entry);
 		return 1;
 	}
 	return 0;
diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index 8ca4057..28fb243 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -110,7 +110,7 @@ int fsl_rio_mcheck_exception(struct pt_regs *regs)
 			out_be32((u32 *)(rio_regs_win + RIO_LTLEDCSR),
 				 0);
 			regs->msr |= MSR_RI;
-			regs->nip = entry->fixup;
+			regs->nip = extable_fixup(entry);
 			return 1;
 		}
 	}
-- 
2.9.3
