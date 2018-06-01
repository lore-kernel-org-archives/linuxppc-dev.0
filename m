Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y80H1vQPzDrq6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 01:49:35 +1000 (AEST)
Message-Id: <41ac484c9a02b95d167b246d79fba9032975b75f.1527868006.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1527868006.git.christophe.leroy@c-s.fr>
References: <cover.1527868006.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 03/14] powerpc/405: move PPC405_ERR77 in asm-405.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  1 Jun 2018 15:49:31 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/asm-405.h           | 19 +++++++++++++++++++
 arch/powerpc/include/asm/asm-compat.h        | 13 -------------
 arch/powerpc/include/asm/atomic.h            |  1 +
 arch/powerpc/include/asm/bitops.h            |  1 +
 arch/powerpc/include/asm/book3s/32/pgtable.h |  2 --
 arch/powerpc/include/asm/cmpxchg.h           |  1 +
 arch/powerpc/include/asm/futex.h             |  1 +
 arch/powerpc/include/asm/nohash/32/pgtable.h |  1 +
 arch/powerpc/include/asm/spinlock.h          |  1 +
 arch/powerpc/kernel/entry_32.S               |  1 +
 arch/powerpc/kernel/head_40x.S               |  1 +
 11 files changed, 27 insertions(+), 15 deletions(-)
 create mode 100644 arch/powerpc/include/asm/asm-405.h

diff --git a/arch/powerpc/include/asm/asm-405.h b/arch/powerpc/include/asm/asm-405.h
new file mode 100644
index 000000000000..7270d3ae7c8e
--- /dev/null
+++ b/arch/powerpc/include/asm/asm-405.h
@@ -0,0 +1,19 @@
+#ifndef _ASM_POWERPC_ASM_405_H
+#define _ASM_POWERPC_ASM_405_H
+
+#include <asm/asm-const.h>
+
+#ifdef __KERNEL__
+#ifdef CONFIG_IBM405_ERR77
+/* Erratum #77 on the 405 means we need a sync or dcbt before every
+ * stwcx.  The old ATOMIC_SYNC_FIX covered some but not all of this.
+ */
+#define PPC405_ERR77(ra,rb)	stringify_in_c(dcbt	ra, rb;)
+#define	PPC405_ERR77_SYNC	stringify_in_c(sync;)
+#else
+#define PPC405_ERR77(ra,rb)
+#define PPC405_ERR77_SYNC
+#endif
+#endif
+
+#endif /* _ASM_POWERPC_ASM_405_H */
diff --git a/arch/powerpc/include/asm/asm-compat.h b/arch/powerpc/include/asm/asm-compat.h
index 7f2a7702596c..d2cf3593e987 100644
--- a/arch/powerpc/include/asm/asm-compat.h
+++ b/arch/powerpc/include/asm/asm-compat.h
@@ -70,17 +70,4 @@
 
 #endif
 
-#ifdef __KERNEL__
-#ifdef CONFIG_IBM405_ERR77
-/* Erratum #77 on the 405 means we need a sync or dcbt before every
- * stwcx.  The old ATOMIC_SYNC_FIX covered some but not all of this.
- */
-#define PPC405_ERR77(ra,rb)	stringify_in_c(dcbt	ra, rb;)
-#define	PPC405_ERR77_SYNC	stringify_in_c(sync;)
-#else
-#define PPC405_ERR77(ra,rb)
-#define PPC405_ERR77_SYNC
-#endif
-#endif
-
 #endif /* _ASM_POWERPC_ASM_COMPAT_H */
diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 682b3e6a1e21..cbdb0b7e60a3 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
+#include <asm/asm-405.h>
 
 #define ATOMIC_INIT(i)		{ (i) }
 
diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index b750ffef83c7..ff71566dadee 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -45,6 +45,7 @@
 #include <linux/compiler.h>
 #include <asm/asm-compat.h>
 #include <asm/synch.h>
+#include <asm/asm-405.h>
 
 /* PPC bit number conversion */
 #define PPC_BITLSHIFT(be)	(BITS_PER_LONG - 1 - (be))
diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index c615abdce119..231699ef6ebe 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -164,7 +164,6 @@ static inline unsigned long pte_update(pte_t *p,
 1:	lwarx	%0,0,%3\n\
 	andc	%1,%0,%4\n\
 	or	%1,%1,%5\n"
-	PPC405_ERR77(0,%3)
 "	stwcx.	%1,0,%3\n\
 	bne-	1b"
 	: "=&r" (old), "=&r" (tmp), "=m" (*p)
@@ -186,7 +185,6 @@ static inline unsigned long long pte_update(pte_t *p,
 	lwzx	%0,0,%3\n\
 	andc	%1,%L0,%5\n\
 	or	%1,%1,%6\n"
-	PPC405_ERR77(0,%3)
 "	stwcx.	%1,0,%4\n\
 	bne-	1b"
 	: "=&r" (old), "=&r" (tmp), "=m" (*p)
diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index 9b001f1f6b32..67ec1073ac97 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -7,6 +7,7 @@
 #include <asm/synch.h>
 #include <asm/asm-compat.h>
 #include <linux/bug.h>
+#include <asm/asm-405.h>
 
 #ifdef __BIG_ENDIAN
 #define BITOFF_CAL(size, off)	((sizeof(u32) - size - off) * BITS_PER_BYTE)
diff --git a/arch/powerpc/include/asm/futex.h b/arch/powerpc/include/asm/futex.h
index 1a944c18c539..76c8648d0fa8 100644
--- a/arch/powerpc/include/asm/futex.h
+++ b/arch/powerpc/include/asm/futex.h
@@ -9,6 +9,7 @@
 #include <asm/errno.h>
 #include <asm/synch.h>
 #include <asm/asm-compat.h>
+#include <asm/asm-405.h>
 
 #define __futex_atomic_op(insn, ret, oldval, uaddr, oparg) \
   __asm__ __volatile ( \
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 987a658b18e1..62e48ecb9dcc 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -9,6 +9,7 @@
 #include <linux/sched.h>
 #include <linux/threads.h>
 #include <asm/io.h>			/* For sub-arch specific PPC_PIN_SIZE */
+#include <asm/asm-405.h>
 
 extern unsigned long ioremap_bot;
 
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 72dc4ddc2972..7ec38f4ee927 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -27,6 +27,7 @@
 #include <asm/asm-compat.h>
 #include <asm/synch.h>
 #include <asm/ppc-opcode.h>
+#include <asm/asm-405.h>
 
 #ifdef CONFIG_PPC64
 /* use 0x800000yy when locked, where yy == CPU number */
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index eb8d01bae8c6..20315b948f21 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -33,6 +33,7 @@
 #include <asm/unistd.h>
 #include <asm/ptrace.h>
 #include <asm/export.h>
+#include <asm/asm-405.h>
 
 /*
  * MSR_KERNEL is > 0x10000 on 4xx/Book-E since it include MSR_CE.
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 41374a468d1c..b19d78410511 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -42,6 +42,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
 #include <asm/export.h>
+#include <asm/asm-405.h>
 
 /* As with the other PowerPC ports, it is expected that when code
  * execution begins here, the following registers contain valid, yet
-- 
2.13.3
