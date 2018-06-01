Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y80j5QtSzF0WH
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 01:49:57 +1000 (AEST)
Message-Id: <fb1c89257279bfa937dab630c9c3cebb3f909293.1527868006.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1527868006.git.christophe.leroy@c-s.fr>
References: <cover.1527868006.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 14/14] powerpc: Split synch.h in two parts
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  1 Jun 2018 15:49:53 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

move feature-fixups related stuff from synch.h to synch-ftr.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/atomic.h                 |  1 +
 arch/powerpc/include/asm/barrier.h                |  1 +
 arch/powerpc/include/asm/bitops.h                 |  1 +
 arch/powerpc/include/asm/cmpxchg.h                |  1 +
 arch/powerpc/include/asm/spinlock.h               |  1 +
 arch/powerpc/include/asm/{synch.h => synch-ftr.h} | 22 +++--------------
 arch/powerpc/include/asm/synch.h                  | 30 -----------------------
 arch/powerpc/lib/feature-fixups-test.S            |  1 +
 8 files changed, 9 insertions(+), 49 deletions(-)
 copy arch/powerpc/include/asm/{synch.h => synch-ftr.h} (66%)

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index cbdb0b7e60a3..49a929ec5435 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -11,6 +11,7 @@
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
 #include <asm/asm-405.h>
+#include <asm/synch-ftr.h>
 
 #define ATOMIC_INIT(i)		{ (i) }
 
diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index 117d09df869f..6a2da24a2219 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -6,6 +6,7 @@
 #define _ASM_POWERPC_BARRIER_H
 
 #include <asm/asm-const.h>
+#include <asm/synch-ftr.h>
 
 /*
  * Memory barrier.
diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index ff71566dadee..b8bf2f5b75ce 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -44,6 +44,7 @@
 
 #include <linux/compiler.h>
 #include <asm/asm-compat.h>
+#include <asm/synch-ftr.h>
 #include <asm/synch.h>
 #include <asm/asm-405.h>
 
diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index 27183871eb3b..d94a67a1a574 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -4,6 +4,7 @@
 
 #ifdef __KERNEL__
 #include <linux/compiler.h>
+#include <asm/synch-ftr.h>
 #include <asm/synch.h>
 #include <linux/bug.h>
 #include <asm/asm-405.h>
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 685c72310f5d..182f950a4c5d 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -24,6 +24,7 @@
 #include <asm/paca.h>
 #include <asm/hvcall.h>
 #endif
+#include <asm/synch-ftr.h>
 #include <asm/synch.h>
 #include <asm/ppc-opcode.h>
 #include <asm/asm-405.h>
diff --git a/arch/powerpc/include/asm/synch.h b/arch/powerpc/include/asm/synch-ftr.h
similarity index 66%
copy from arch/powerpc/include/asm/synch.h
copy to arch/powerpc/include/asm/synch-ftr.h
index aca70fb43147..f86c536bd351 100644
--- a/arch/powerpc/include/asm/synch.h
+++ b/arch/powerpc/include/asm/synch-ftr.h
@@ -1,27 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_POWERPC_SYNCH_H 
-#define _ASM_POWERPC_SYNCH_H 
+#ifndef _ASM_POWERPC_SYNCH_FTR_H
+#define _ASM_POWERPC_SYNCH_FTR_H
 #ifdef __KERNEL__
 
 #include <asm/feature-fixups.h>
 #include <asm/asm-const.h>
 
-#ifndef __ASSEMBLY__
-extern unsigned int __start___lwsync_fixup, __stop___lwsync_fixup;
-extern void do_lwsync_fixups(unsigned long value, void *fixup_start,
-			     void *fixup_end);
-
-static inline void eieio(void)
-{
-	__asm__ __volatile__ ("eieio" : : : "memory");
-}
-
-static inline void isync(void)
-{
-	__asm__ __volatile__ ("isync" : : : "memory");
-}
-#endif /* __ASSEMBLY__ */
-
 #if defined(__powerpc64__)
 #    define LWSYNC	lwsync
 #elif defined(CONFIG_E500)
@@ -50,4 +34,4 @@ static inline void isync(void)
 #endif
 
 #endif /* __KERNEL__ */
-#endif	/* _ASM_POWERPC_SYNCH_H */
+#endif	/* _ASM_POWERPC_SYNCH_FTR_H */
diff --git a/arch/powerpc/include/asm/synch.h b/arch/powerpc/include/asm/synch.h
index aca70fb43147..48b23168ea9e 100644
--- a/arch/powerpc/include/asm/synch.h
+++ b/arch/powerpc/include/asm/synch.h
@@ -3,9 +3,6 @@
 #define _ASM_POWERPC_SYNCH_H 
 #ifdef __KERNEL__
 
-#include <asm/feature-fixups.h>
-#include <asm/asm-const.h>
-
 #ifndef __ASSEMBLY__
 extern unsigned int __start___lwsync_fixup, __stop___lwsync_fixup;
 extern void do_lwsync_fixups(unsigned long value, void *fixup_start,
@@ -22,32 +19,5 @@ static inline void isync(void)
 }
 #endif /* __ASSEMBLY__ */
 
-#if defined(__powerpc64__)
-#    define LWSYNC	lwsync
-#elif defined(CONFIG_E500)
-#    define LWSYNC					\
-	START_LWSYNC_SECTION(96);			\
-	sync;						\
-	MAKE_LWSYNC_SECTION_ENTRY(96, __lwsync_fixup);
-#else
-#    define LWSYNC	sync
-#endif
-
-#ifdef CONFIG_SMP
-#define __PPC_ACQUIRE_BARRIER				\
-	START_LWSYNC_SECTION(97);			\
-	isync;						\
-	MAKE_LWSYNC_SECTION_ENTRY(97, __lwsync_fixup);
-#define PPC_ACQUIRE_BARRIER	 "\n" stringify_in_c(__PPC_ACQUIRE_BARRIER)
-#define PPC_RELEASE_BARRIER	 stringify_in_c(LWSYNC) "\n"
-#define PPC_ATOMIC_ENTRY_BARRIER "\n" stringify_in_c(sync) "\n"
-#define PPC_ATOMIC_EXIT_BARRIER	 "\n" stringify_in_c(sync) "\n"
-#else
-#define PPC_ACQUIRE_BARRIER
-#define PPC_RELEASE_BARRIER
-#define PPC_ATOMIC_ENTRY_BARRIER
-#define PPC_ATOMIC_EXIT_BARRIER
-#endif
-
 #endif /* __KERNEL__ */
 #endif	/* _ASM_POWERPC_SYNCH_H */
diff --git a/arch/powerpc/lib/feature-fixups-test.S b/arch/powerpc/lib/feature-fixups-test.S
index ee7c5fd5fc64..8c781b2e467b 100644
--- a/arch/powerpc/lib/feature-fixups-test.S
+++ b/arch/powerpc/lib/feature-fixups-test.S
@@ -10,6 +10,7 @@
 
 #include <asm/feature-fixups.h>
 #include <asm/ppc_asm.h>
+#include <asm/synch-ftr.h>
 #include <asm/synch.h>
 #include <asm/asm-compat.h>
 
-- 
2.13.3
