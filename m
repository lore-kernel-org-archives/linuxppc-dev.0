Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>,
	<linuxppc-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 23 Mar 2006 23:32:24 +1100
Subject: [PATCH 1/4] powerpc: Make BUG_ON & WARN_ON play nice with
	compile-time optimisations
Message-Id: <1143117144.850591.48752080269.qpush@concordia>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Change BUG_ON and WARN_ON to give the compiler a chance to perform
compile-time optimsations. Depending on the complexity of the condition,
the compiler may not do this very well, so if it's important check the
object code.

Current GCC's (4.x) produce good code as long as the condition does not
include a function call, including a static inline.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 include/asm-powerpc/bug.h |   30 ++++++++++++++++++++++++++++--
 1 files changed, 28 insertions(+), 2 deletions(-)

Index: to-merge/include/asm-powerpc/bug.h
===================================================================
--- to-merge.orig/include/asm-powerpc/bug.h
+++ to-merge/include/asm-powerpc/bug.h
@@ -30,6 +30,12 @@ struct bug_entry *find_bug(unsigned long
 
 #ifdef CONFIG_BUG
 
+/*
+ * BUG_ON() and WARN_ON() do their best to cooperate with compile-time
+ * optimisations. However depending on the complexity of the condition
+ * some compiler versions may not produce optimal results.
+ */
+
 #define BUG() do {							 \
 	__asm__ __volatile__(						 \
 		"1:	twi 31,0,0\n"					 \
@@ -40,17 +46,36 @@ struct bug_entry *find_bug(unsigned long
 } while (0)
 
 #define BUG_ON(x) do {						\
-	__asm__ __volatile__(					\
+	if (__builtin_constant_p(x)) {				\
+		if (x)						\
+			BUG();					\
+	} else {						\
+		__asm__ __volatile__(				\
 		"1:	"PPC_TLNEI"	%0,0\n"			\
 		".section __bug_table,\"a\"\n"			\
 		"\t"PPC_LONG"	1b,%1,%2,%3\n"		\
 		".previous"					\
 		: : "r" ((long)(x)), "i" (__LINE__),		\
 		    "i" (__FILE__), "i" (__FUNCTION__));	\
+	}							\
 } while (0)
 
-#define WARN_ON(x) do {						\
+#define WARN() do {						\
 	__asm__ __volatile__(					\
+		"1:	twi 31,0,0\n"				\
+		".section __bug_table,\"a\"\n"			\
+		"\t"PPC_LONG"	1b,%0,%1,%2\n"			\
+		".previous"					\
+		: : "i" (__LINE__ + BUG_WARNING_TRAP),		\
+		    "i" (__FILE__), "i" (__FUNCTION__));	\
+} while (0)
+
+#define WARN_ON(x) do {						\
+	if (__builtin_constant_p(x)) {				\
+		if (x)						\
+			WARN();					\
+	} else {						\
+		__asm__ __volatile__(				\
 		"1:	"PPC_TLNEI"	%0,0\n"			\
 		".section __bug_table,\"a\"\n"			\
 		"\t"PPC_LONG"	1b,%1,%2,%3\n"		\
@@ -58,6 +83,7 @@ struct bug_entry *find_bug(unsigned long
 		: : "r" ((long)(x)),				\
 		    "i" (__LINE__ + BUG_WARNING_TRAP),		\
 		    "i" (__FILE__), "i" (__FUNCTION__));	\
+	}							\
 } while (0)
 
 #define HAVE_ARCH_BUG
