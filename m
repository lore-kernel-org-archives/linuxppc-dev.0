Return-Path: <anton@ozlabs.org>
Date: Wed, 10 Feb 2010 21:57:28 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 1/6] powerpc: Use lwarx hint in spinlocks
Message-ID: <20100210105728.GA3399@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: npiggin@suse.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Recent versions of the PowerPC architecture added a hint bit to the larx
instructions to differentiate between an atomic operation and a lock operation:

> 0 Other programs might attempt to modify the word in storage addressed by EA
> even if the subsequent Store Conditional succeeds.
> 
> 1 Other programs will not attempt to modify the word in storage addressed by
> EA until the program that has acquired the lock performs a subsequent store
> releasing the lock.

To avoid a binutils dependency this patch create macros for the extended lwarx
format and uses it in the spinlock code. To test this change I used a simple
test case that acquires and releases a global pthread mutex:

	pthread_mutex_lock(&mutex);
	pthread_mutex_unlock(&mutex);

On a 32 core POWER6, running 32 test threads we spend almost all our time in
the futex spinlock code:

    94.37%     perf  [kernel]                     [k] ._raw_spin_lock
               |          
               |--99.95%-- ._raw_spin_lock
               |          |          
               |          |--63.29%-- .futex_wake
               |          |          
               |          |--36.64%-- .futex_wait_setup

Which is a good test for this patch. The results (in lock/unlock operations per
second) are:

before: 1538203 ops/sec
after:  2189219 ops/sec

An improvement of 42%

A 32 core POWER7 improves even more:

before: 1279529 ops/sec
after:  2282076 ops/sec

An improvement of 78%

Signed-off-by: Anton Blanchard <anton@samba.org>
---

v2: We do this only for 64bit until we can verify all 32bit CPUs.

Tested so far: 970 (thanks Ben), POWER5, POWER6, POWER7
Still to test: RS64, POWER3, POWER4

Index: powerpc.git/arch/powerpc/include/asm/ppc-opcode.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/ppc-opcode.h	2010-02-10 15:28:58.453072362 +1100
+++ powerpc.git/arch/powerpc/include/asm/ppc-opcode.h	2010-02-10 15:33:08.963071793 +1100
@@ -24,6 +24,7 @@
 #define PPC_INST_ISEL_MASK		0xfc00003e
 #define PPC_INST_LSWI			0x7c0004aa
 #define PPC_INST_LSWX			0x7c00042a
+#define PPC_INST_LWARX			0x7c000029
 #define PPC_INST_LWSYNC			0x7c2004ac
 #define PPC_INST_LXVD2X			0x7c000698
 #define PPC_INST_MCRXR			0x7c000400
@@ -55,15 +56,28 @@
 #define __PPC_RA(a)	(((a) & 0x1f) << 16)
 #define __PPC_RB(b)	(((b) & 0x1f) << 11)
 #define __PPC_RS(s)	(((s) & 0x1f) << 21)
+#define __PPC_RT(s)	__PPC_RS(s)
 #define __PPC_XS(s)	((((s) & 0x1f) << 21) | (((s) & 0x20) >> 5))
 #define __PPC_T_TLB(t)	(((t) & 0x3) << 21)
 #define __PPC_WC(w)	(((w) & 0x3) << 21)
+/*
+ * Only use the larx hint bit on 64bit CPUs. Once we verify it doesn't have
+ * any side effects on all 32bit processors, we can do this all the time.
+ */
+#ifdef CONFIG_PPC64
+#define __PPC_EH(eh)	(((eh) & 0x1) << 0)
+#else
+#define __PPC_EH(eh)	0
+#endif
 
 /* Deal with instructions that older assemblers aren't aware of */
 #define	PPC_DCBAL(a, b)		stringify_in_c(.long PPC_INST_DCBAL | \
 					__PPC_RA(a) | __PPC_RB(b))
 #define	PPC_DCBZL(a, b)		stringify_in_c(.long PPC_INST_DCBZL | \
 					__PPC_RA(a) | __PPC_RB(b))
+#define PPC_LWARX(t, a, b, eh)	stringify_in_c(.long PPC_INST_LWARX | \
+					__PPC_RT(t) | __PPC_RA(a) | \
+					__PPC_RB(b) | __PPC_EH(eh))
 #define PPC_MSGSND(b)		stringify_in_c(.long PPC_INST_MSGSND | \
 					__PPC_RB(b))
 #define PPC_RFCI		stringify_in_c(.long PPC_INST_RFCI)
Index: powerpc.git/arch/powerpc/include/asm/spinlock.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/spinlock.h	2010-02-10 15:28:58.473072327 +1100
+++ powerpc.git/arch/powerpc/include/asm/spinlock.h	2010-02-10 15:29:29.454322618 +1100
@@ -27,6 +27,7 @@
 #endif
 #include <asm/asm-compat.h>
 #include <asm/synch.h>
+#include <asm/ppc-opcode.h>
 
 #define arch_spin_is_locked(x)		((x)->slock != 0)
 
@@ -60,7 +61,7 @@ static inline unsigned long __arch_spin_
 
 	token = LOCK_TOKEN;
 	__asm__ __volatile__(
-"1:	lwarx		%0,0,%2\n\
+"1:	" PPC_LWARX(%0,0,%2,1) "\n\
 	cmpwi		0,%0,0\n\
 	bne-		2f\n\
 	stwcx.		%1,0,%2\n\
@@ -186,7 +187,7 @@ static inline long __arch_read_trylock(a
 	long tmp;
 
 	__asm__ __volatile__(
-"1:	lwarx		%0,0,%1\n"
+"1:	" PPC_LWARX(%0,0,%1,1) "\n"
 	__DO_SIGN_EXTEND
 "	addic.		%0,%0,1\n\
 	ble-		2f\n"
@@ -211,7 +212,7 @@ static inline long __arch_write_trylock(
 
 	token = WRLOCK_TOKEN;
 	__asm__ __volatile__(
-"1:	lwarx		%0,0,%2\n\
+"1:	" PPC_LWARX(%0,0,%2,1) "\n\
 	cmpwi		0,%0,0\n\
 	bne-		2f\n"
 	PPC405_ERR77(0,%1)
