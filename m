Return-Path: <anton@ozlabs.org>
Date: Wed, 10 Feb 2010 22:02:36 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 2/6] powerpc: Use lwarx/ldarx hint in bit locks
Message-ID: <20100210110236.GB3399@kryten>
References: <20100210105728.GA3399@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100210105728.GA3399@kryten>
Cc: npiggin@suse.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This patch implements the lwarx/ldarx hint bit for bit locks.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/include/asm/asm-compat.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/asm-compat.h	2010-02-10 17:16:07.003090026 +1100
+++ powerpc.git/arch/powerpc/include/asm/asm-compat.h	2010-02-10 17:16:39.144321846 +1100
@@ -2,6 +2,7 @@
 #define _ASM_POWERPC_ASM_COMPAT_H
 
 #include <asm/types.h>
+#include <asm/ppc-opcode.h>
 
 #ifdef __ASSEMBLY__
 #  define stringify_in_c(...)	__VA_ARGS__
@@ -24,7 +25,7 @@
 #define PPC_LONG	stringify_in_c(.llong)
 #define PPC_LONG_ALIGN	stringify_in_c(.balign 8)
 #define PPC_TLNEI	stringify_in_c(tdnei)
-#define PPC_LLARX	stringify_in_c(ldarx)
+#define PPC_LLARX(t, a, b, eh)	PPC_LDARX(t, a, b, eh)
 #define PPC_STLCX	stringify_in_c(stdcx.)
 #define PPC_CNTLZL	stringify_in_c(cntlzd)
 
@@ -46,7 +47,7 @@
 #define PPC_LONG	stringify_in_c(.long)
 #define PPC_LONG_ALIGN	stringify_in_c(.balign 4)
 #define PPC_TLNEI	stringify_in_c(twnei)
-#define PPC_LLARX	stringify_in_c(lwarx)
+#define PPC_LLARX(t, a, b, eh)	PPC_LWARX(t, a, b, eh)
 #define PPC_STLCX	stringify_in_c(stwcx.)
 #define PPC_CNTLZL	stringify_in_c(cntlzw)
 #define PPC_MTOCRF	stringify_in_c(mtcrf)
Index: powerpc.git/arch/powerpc/include/asm/bitops.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/bitops.h	2010-02-10 17:16:07.013074408 +1100
+++ powerpc.git/arch/powerpc/include/asm/bitops.h	2010-02-10 17:16:14.253072938 +1100
@@ -65,7 +65,7 @@ static __inline__ void fn(unsigned long 
 	unsigned long *p = (unsigned long *)_p;	\
 	__asm__ __volatile__ (			\
 	prefix					\
-"1:"	PPC_LLARX "%0,0,%3\n"			\
+"1:"	PPC_LLARX(%0,0,%3,0) "\n"		\
 	stringify_in_c(op) "%0,%0,%2\n"		\
 	PPC405_ERR77(0,%3)			\
 	PPC_STLCX "%0,0,%3\n"			\
@@ -103,31 +103,31 @@ static __inline__ void change_bit(int nr
 
 /* Like DEFINE_BITOP(), with changes to the arguments to 'op' and the output
  * operands. */
-#define DEFINE_TESTOP(fn, op, prefix, postfix)	\
-static __inline__ unsigned long fn(		\
-		unsigned long mask,		\
-		volatile unsigned long *_p)	\
-{						\
-	unsigned long old, t;			\
-	unsigned long *p = (unsigned long *)_p;	\
-	__asm__ __volatile__ (			\
-	prefix					\
-"1:"	PPC_LLARX "%0,0,%3\n"			\
-	stringify_in_c(op) "%1,%0,%2\n"		\
-	PPC405_ERR77(0,%3)			\
-	PPC_STLCX "%1,0,%3\n"			\
-	"bne- 1b\n"				\
-	postfix					\
-	: "=&r" (old), "=&r" (t)		\
-	: "r" (mask), "r" (p)			\
-	: "cc", "memory");			\
-	return (old & mask);			\
-}
-
-DEFINE_TESTOP(test_and_set_bits, or, LWSYNC_ON_SMP, ISYNC_ON_SMP)
-DEFINE_TESTOP(test_and_set_bits_lock, or, "", ISYNC_ON_SMP)
-DEFINE_TESTOP(test_and_clear_bits, andc, LWSYNC_ON_SMP, ISYNC_ON_SMP)
-DEFINE_TESTOP(test_and_change_bits, xor, LWSYNC_ON_SMP, ISYNC_ON_SMP)
+#define DEFINE_TESTOP(fn, op, prefix, postfix, eh)	\
+static __inline__ unsigned long fn(			\
+		unsigned long mask,			\
+		volatile unsigned long *_p)		\
+{							\
+	unsigned long old, t;				\
+	unsigned long *p = (unsigned long *)_p;		\
+	__asm__ __volatile__ (				\
+	prefix						\
+"1:"	PPC_LLARX(%0,0,%3,eh) "\n"			\
+	stringify_in_c(op) "%1,%0,%2\n"			\
+	PPC405_ERR77(0,%3)				\
+	PPC_STLCX "%1,0,%3\n"				\
+	"bne- 1b\n"					\
+	postfix						\
+	: "=&r" (old), "=&r" (t)			\
+	: "r" (mask), "r" (p)				\
+	: "cc", "memory");				\
+	return (old & mask);				\
+}
+
+DEFINE_TESTOP(test_and_set_bits, or, LWSYNC_ON_SMP, ISYNC_ON_SMP, 0)
+DEFINE_TESTOP(test_and_set_bits_lock, or, "", ISYNC_ON_SMP, 1)
+DEFINE_TESTOP(test_and_clear_bits, andc, LWSYNC_ON_SMP, ISYNC_ON_SMP, 0)
+DEFINE_TESTOP(test_and_change_bits, xor, LWSYNC_ON_SMP, ISYNC_ON_SMP, 0)
 
 static __inline__ int test_and_set_bit(unsigned long nr,
 				       volatile unsigned long *addr)
Index: powerpc.git/arch/powerpc/include/asm/local.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/local.h	2010-02-10 17:16:07.023072625 +1100
+++ powerpc.git/arch/powerpc/include/asm/local.h	2010-02-10 17:16:14.253072938 +1100
@@ -24,7 +24,7 @@ static __inline__ long local_add_return(
 	long t;
 
 	__asm__ __volatile__(
-"1:"	PPC_LLARX	"%0,0,%2		# local_add_return\n\
+"1:"	PPC_LLARX(%0,0,%2,0) "			# local_add_return\n\
 	add	%0,%1,%0\n"
 	PPC405_ERR77(0,%2)
 	PPC_STLCX	"%0,0,%2 \n\
@@ -43,7 +43,7 @@ static __inline__ long local_sub_return(
 	long t;
 
 	__asm__ __volatile__(
-"1:"	PPC_LLARX	"%0,0,%2		# local_sub_return\n\
+"1:"	PPC_LLARX(%0,0,%2,0) "			# local_sub_return\n\
 	subf	%0,%1,%0\n"
 	PPC405_ERR77(0,%2)
 	PPC_STLCX	"%0,0,%2 \n\
@@ -60,7 +60,7 @@ static __inline__ long local_inc_return(
 	long t;
 
 	__asm__ __volatile__(
-"1:"	PPC_LLARX	"%0,0,%1		# local_inc_return\n\
+"1:"	PPC_LLARX(%0,0,%1,0) "			# local_inc_return\n\
 	addic	%0,%0,1\n"
 	PPC405_ERR77(0,%1)
 	PPC_STLCX	"%0,0,%1 \n\
@@ -87,7 +87,7 @@ static __inline__ long local_dec_return(
 	long t;
 
 	__asm__ __volatile__(
-"1:"	PPC_LLARX	"%0,0,%1		# local_dec_return\n\
+"1:"	PPC_LLARX(%0,0,%1,0) "			# local_dec_return\n\
 	addic	%0,%0,-1\n"
 	PPC405_ERR77(0,%1)
 	PPC_STLCX	"%0,0,%1\n\
@@ -117,7 +117,7 @@ static __inline__ int local_add_unless(l
 	long t;
 
 	__asm__ __volatile__ (
-"1:"	PPC_LLARX	"%0,0,%1		# local_add_unless\n\
+"1:"	PPC_LLARX(%0,0,%1,0) "			# local_add_unless\n\
 	cmpw	0,%0,%3 \n\
 	beq-	2f \n\
 	add	%0,%2,%0 \n"
@@ -147,7 +147,7 @@ static __inline__ long local_dec_if_posi
 	long t;
 
 	__asm__ __volatile__(
-"1:"	PPC_LLARX	"%0,0,%1		# local_dec_if_positive\n\
+"1:"	PPC_LLARX(%0,0,%1,0) "			# local_dec_if_positive\n\
 	cmpwi	%0,1\n\
 	addi	%0,%0,-1\n\
 	blt-	2f\n"
Index: powerpc.git/arch/powerpc/include/asm/ppc-opcode.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/ppc-opcode.h	2010-02-10 17:16:07.013074408 +1100
+++ powerpc.git/arch/powerpc/include/asm/ppc-opcode.h	2010-02-10 17:16:14.263072384 +1100
@@ -22,6 +22,7 @@
 #define PPC_INST_DCBZL			0x7c2007ec
 #define PPC_INST_ISEL			0x7c00001e
 #define PPC_INST_ISEL_MASK		0xfc00003e
+#define PPC_INST_LDARX			0x7c0000a8
 #define PPC_INST_LSWI			0x7c0004aa
 #define PPC_INST_LSWX			0x7c00042a
 #define PPC_INST_LWARX			0x7c000029
@@ -75,6 +76,9 @@
 					__PPC_RA(a) | __PPC_RB(b))
 #define	PPC_DCBZL(a, b)		stringify_in_c(.long PPC_INST_DCBZL | \
 					__PPC_RA(a) | __PPC_RB(b))
+#define PPC_LDARX(t, a, b, eh)	stringify_in_c(.long PPC_INST_LDARX | \
+					__PPC_RT(t) | __PPC_RA(a) | \
+					__PPC_RB(b) | __PPC_EH(eh))
 #define PPC_LWARX(t, a, b, eh)	stringify_in_c(.long PPC_INST_LWARX | \
 					__PPC_RT(t) | __PPC_RA(a) | \
 					__PPC_RB(b) | __PPC_EH(eh))
