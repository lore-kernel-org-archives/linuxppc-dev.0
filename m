Return-Path: <bgill@freescale.com>
Date: Mon, 19 Sep 2005 17:01:54 -0500 (CDT)
From: Becky Bruce <bgill@freescale.com>
To: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Message-ID: <Pine.LNX.4.61.0509191659290.18080@cde-tx32-ldt329.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [PATCH] powerpc Merge bug.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Resending per Paul's request.....

ppc32/ppc64: Merge bug.h into include/asm-powerpc

This patch merges bug.h into include/asm-powerpc.  Changed the data
structure for bug_entry such that line is always an int on both 32 and
64-bit platforms; removed casts to int from the 64-bit trap code to
reflect this.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
Signed-off-by: Becky Bruce <Becky.Bruce@freescale.com>

---
commit fcaf8560dc918048b43867d79efa5b26bd6a9a81
tree 079802fdb229c0e3721b893235e2ef912e30d7cd
parent dfe2ac4994952cadc891f095668f9e582d4402b3
author Becky Bruce <becky.bruce@freescale.com> Fri, 09 Sep 2005 11:15:22 -0500
committer Becky Bruce <becky.bruce@freescale.com> Fri, 09 Sep 2005 11:15:22 -0500

 arch/ppc/kernel/traps.c   |    2 +
 arch/ppc64/kernel/traps.c |    4 +-
 include/asm-powerpc/bug.h |   81 +++++++++++++++++++++++++++++++++++++++++++++
 include/asm-ppc/bug.h     |   58 --------------------------------
 include/asm-ppc64/bug.h   |   69 --------------------------------------
 5 files changed, 84 insertions(+), 130 deletions(-)

diff --git a/arch/ppc/kernel/traps.c b/arch/ppc/kernel/traps.c
--- a/arch/ppc/kernel/traps.c
+++ b/arch/ppc/kernel/traps.c
@@ -553,7 +553,7 @@ extern struct bug_entry __start___bug_ta
 #define module_find_bug(x)	NULL
 #endif
 
-static struct bug_entry *find_bug(unsigned long bugaddr)
+struct bug_entry *find_bug(unsigned long bugaddr)
 {
 	struct bug_entry *bug;
 
diff --git a/arch/ppc64/kernel/traps.c b/arch/ppc64/kernel/traps.c
--- a/arch/ppc64/kernel/traps.c
+++ b/arch/ppc64/kernel/traps.c
@@ -389,12 +389,12 @@ check_bug_trap(struct pt_regs *regs)
 		/* this is a WARN_ON rather than BUG/BUG_ON */
 		printk(KERN_ERR "Badness in %s at %s:%d\n",
 		       bug->function, bug->file,
-		      (unsigned int)bug->line & ~BUG_WARNING_TRAP);
+		       bug->line & ~BUG_WARNING_TRAP);
 		show_stack(current, (void *)regs->gpr[1]);
 		return 1;
 	}
 	printk(KERN_CRIT "kernel BUG in %s at %s:%d!\n",
-	       bug->function, bug->file, (unsigned int)bug->line);
+	       bug->function, bug->file, bug->line);
 	return 0;
 }
 
diff --git a/include/asm-powerpc/bug.h b/include/asm-powerpc/bug.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/bug.h
@@ -0,0 +1,81 @@
+#ifndef _ASM_POWERPC_BUG_H
+#define _ASM_POWERPC_BUG_H
+
+/*
+ * Define an illegal instr to trap on the bug.
+ * We don't use 0 because that marks the end of a function
+ * in the ELF ABI.  That's "Boo Boo" in case you wonder...
+ */
+#define BUG_OPCODE .long 0x00b00b00  /* For asm */
+#define BUG_ILLEGAL_INSTR "0x00b00b00" /* For BUG macro */
+
+#ifndef __ASSEMBLY__
+
+#ifdef __powerpc64__
+#define BUG_TABLE_ENTRY(label, line, file, func) \
+	".llong " #label "\n .long " #line "\n .llong " #file ", " #func "\n"
+#define TRAP_OP(ra, rb) "1: tdnei " #ra ", " #rb "\n"
+#define DATA_TYPE long long
+#else 
+#define BUG_TABLE_ENTRY(label, line, file, func) \
+	".long " #label ", " #line ", " #file ", " #func "\n"
+#define TRAP_OP(ra, rb) "1: twnei " #ra ", " #rb "\n"
+#define DATA_TYPE int
+#endif /* __powerpc64__ */
+
+struct bug_entry {
+	unsigned long	bug_addr;
+	int		line;
+	const char	*file;
+	const char	*function;
+};
+
+struct bug_entry *find_bug(unsigned long bugaddr);
+
+/*
+ * If this bit is set in the line number it means that the trap
+ * is for WARN_ON rather than BUG or BUG_ON.
+ */
+#define BUG_WARNING_TRAP	0x1000000
+
+#ifdef CONFIG_BUG
+
+#define BUG() do {							 \
+	__asm__ __volatile__(						 \
+		"1:	twi 31,0,0\n"					 \
+		".section __bug_table,\"a\"\n\t"			 \
+		BUG_TABLE_ENTRY(1b,%0,%1,%2)				 \
+		".previous"						 \
+		: : "i" (__LINE__), "i" (__FILE__), "i" (__FUNCTION__)); \
+} while (0)
+
+#define BUG_ON(x) do {						\
+	__asm__ __volatile__(					\
+		TRAP_OP(%0,0)					\
+		".section __bug_table,\"a\"\n\t"		\
+		BUG_TABLE_ENTRY(1b,%1,%2,%3)			\
+		".previous"					\
+		: : "r" ((DATA_TYPE)(x)), "i" (__LINE__),	\
+		    "i" (__FILE__), "i" (__FUNCTION__));	\
+} while (0)
+
+#define WARN_ON(x) do {						\
+	__asm__ __volatile__(					\
+		TRAP_OP(%0,0)					\
+		".section __bug_table,\"a\"\n\t"		\
+		BUG_TABLE_ENTRY(1b,%1,%2,%3)			\
+		".previous"					\
+		: : "r" ((DATA_TYPE)(x)),			\
+		    "i" (__LINE__ + BUG_WARNING_TRAP),		\
+		    "i" (__FILE__), "i" (__FUNCTION__));	\
+} while (0)
+
+#define HAVE_ARCH_BUG
+#define HAVE_ARCH_BUG_ON
+#define HAVE_ARCH_WARN_ON
+#endif /* CONFIG_BUG */
+#endif /* __ASSEMBLY __ */
+
+#include <asm-generic/bug.h>
+
+#endif /* _ASM_POWERPC_BUG_H */
diff --git a/include/asm-ppc/bug.h b/include/asm-ppc/bug.h
deleted file mode 100644
--- a/include/asm-ppc/bug.h
+++ /dev/null
@@ -1,58 +0,0 @@
-#ifndef _PPC_BUG_H
-#define _PPC_BUG_H
-
-struct bug_entry {
-	unsigned long	bug_addr;
-	int		line;
-	const char	*file;
-	const char	*function;
-};
-
-/*
- * If this bit is set in the line number it means that the trap
- * is for WARN_ON rather than BUG or BUG_ON.
- */
-#define BUG_WARNING_TRAP	0x1000000
-
-#ifdef CONFIG_BUG
-#define BUG() do {							 \
-	__asm__ __volatile__(						 \
-		"1:	twi 31,0,0\n"					 \
-		".section __bug_table,\"a\"\n\t"			 \
-		"	.long 1b,%0,%1,%2\n"				 \
-		".previous"						 \
-		: : "i" (__LINE__), "i" (__FILE__), "i" (__FUNCTION__)); \
-} while (0)
-
-#define BUG_ON(x) do {							\
-	if (!__builtin_constant_p(x) || (x)) {				\
-		__asm__ __volatile__(					\
-			"1:	twnei %0,0\n"				\
-			".section __bug_table,\"a\"\n\t"		\
-			"	.long 1b,%1,%2,%3\n"			\
-			".previous"					\
-			: : "r" (x), "i" (__LINE__), "i" (__FILE__),	\
-			    "i" (__FUNCTION__));			\
-	}								\
-} while (0)
-
-#define WARN_ON(x) do {							\
-	if (!__builtin_constant_p(x) || (x)) {				\
-		__asm__ __volatile__(					\
-			"1:	twnei %0,0\n"				\
-			".section __bug_table,\"a\"\n\t"		\
-			"	.long 1b,%1,%2,%3\n"			\
-			".previous"					\
-			: : "r" (x), "i" (__LINE__ + BUG_WARNING_TRAP),	\
-			    "i" (__FILE__), "i" (__FUNCTION__));	\
-	}								\
-} while (0)
-
-#define HAVE_ARCH_BUG
-#define HAVE_ARCH_BUG_ON
-#define HAVE_ARCH_WARN_ON
-#endif
-
-#include <asm-generic/bug.h>
-
-#endif
diff --git a/include/asm-ppc64/bug.h b/include/asm-ppc64/bug.h
deleted file mode 100644
--- a/include/asm-ppc64/bug.h
+++ /dev/null
@@ -1,69 +0,0 @@
-#ifndef _PPC64_BUG_H
-#define _PPC64_BUG_H
-
-/*
- * Define an illegal instr to trap on the bug.
- * We don't use 0 because that marks the end of a function
- * in the ELF ABI.  That's "Boo Boo" in case you wonder...
- */
-#define BUG_OPCODE .long 0x00b00b00  /* For asm */
-#define BUG_ILLEGAL_INSTR "0x00b00b00" /* For BUG macro */
-
-#ifndef __ASSEMBLY__
-
-struct bug_entry {
-	unsigned long	bug_addr;
-	long		line;
-	const char	*file;
-	const char	*function;
-};
-
-struct bug_entry *find_bug(unsigned long bugaddr);
-
-/*
- * If this bit is set in the line number it means that the trap
- * is for WARN_ON rather than BUG or BUG_ON.
- */
-#define BUG_WARNING_TRAP	0x1000000
-
-#ifdef CONFIG_BUG
-
-#define BUG() do {							 \
-	__asm__ __volatile__(						 \
-		"1:	twi 31,0,0\n"					 \
-		".section __bug_table,\"a\"\n\t"			 \
-		"	.llong 1b,%0,%1,%2\n"				 \
-		".previous"						 \
-		: : "i" (__LINE__), "i" (__FILE__), "i" (__FUNCTION__)); \
-} while (0)
-
-#define BUG_ON(x) do {						\
-	__asm__ __volatile__(					\
-		"1:	tdnei %0,0\n"				\
-		".section __bug_table,\"a\"\n\t"		\
-		"	.llong 1b,%1,%2,%3\n"			\
-		".previous"					\
-		: : "r" ((long long)(x)), "i" (__LINE__),	\
-		    "i" (__FILE__), "i" (__FUNCTION__));	\
-} while (0)
-
-#define WARN_ON(x) do {						\
-	__asm__ __volatile__(					\
-		"1:	tdnei %0,0\n"				\
-		".section __bug_table,\"a\"\n\t"		\
-		"	.llong 1b,%1,%2,%3\n"			\
-		".previous"					\
-		: : "r" ((long long)(x)),			\
-		    "i" (__LINE__ + BUG_WARNING_TRAP),		\
-		    "i" (__FILE__), "i" (__FUNCTION__));	\
-} while (0)
-
-#define HAVE_ARCH_BUG
-#define HAVE_ARCH_BUG_ON
-#define HAVE_ARCH_WARN_ON
-#endif
-#endif
-
-#include <asm-generic/bug.h>
-
-#endif
