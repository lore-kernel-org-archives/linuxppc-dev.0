Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvvXy2S6kzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 19:19:14 +1000 (AEST)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Wed, 27 Apr 2016 19:19:12 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 47EC73578069
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 19:18:33 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3R9IFOK29229224
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 19:18:28 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3R9HM0O032751
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 19:17:22 +1000
Message-ID: <5720837D.6050807@linux.vnet.ibm.com>
Date: Wed, 27 Apr 2016 17:16:45 +0800
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
CC: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 boqun.feng@gmail.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
 tglx@linutronix.de
Subject: [PATCH V4] powerpc: Implement {cmp}xchg for u8 and u16
References: <5715D04E.9050009@linux.vnet.ibm.com>
 <571782F0.2020201@linux.vnet.ibm.com>
In-Reply-To: <571782F0.2020201@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>

Implement xchg{u8,u16}{local,relaxed}, and
cmpxchg{u8,u16}{,local,acquire,relaxed}.

It works on all ppc.

remove volatile of first parameter in __cmpxchg_local and __cmpxchg

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
change from v3:
	rewrite in asm for the LL/SC.
	remove volatile in __cmpxchg_local and __cmpxchg.
change from v2:
	in the do{}while(), we save one load and use corresponding cmpxchg suffix.
	Also add corresponding __cmpxchg_u32 function declaration in the __XCHG_GEN 
change from V1:
	rework totally.
---
 arch/powerpc/include/asm/cmpxchg.h | 109 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index 44efe73..8a3735f 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -7,6 +7,71 @@
 #include <asm/asm-compat.h>
 #include <linux/bug.h>
 
+#ifdef __BIG_ENDIAN
+#define BITOFF_CAL(size, off)	((sizeof(u32) - size - off) * BITS_PER_BYTE)
+#else
+#define BITOFF_CAL(size, off)	(off * BITS_PER_BYTE)
+#endif
+
+#define XCHG_GEN(type, sfx, cl)				\
+static inline u32 __xchg_##type##sfx(void *p, u32 val)		\
+{								\
+	unsigned int prev, prev_mask, tmp, bitoff, off;		\
+								\
+	off = (unsigned long)p % sizeof(u32);			\
+	bitoff = BITOFF_CAL(sizeof(type), off);			\
+	p -= off;						\
+	val <<= bitoff;						\
+	prev_mask = (u32)(type)-1 << bitoff;			\
+								\
+	__asm__ __volatile__(					\
+"1:	lwarx   %0,0,%3\n"					\
+"	andc	%1,%0,%5\n"					\
+"	or	%1,%1,%4\n"					\
+	PPC405_ERR77(0,%3)					\
+"	stwcx.	%1,0,%3\n"					\
+"	bne-	1b\n"						\
+	: "=&r" (prev), "=&r" (tmp), "+m" (*(u32*)p)		\
+	: "r" (p), "r" (val), "r" (prev_mask)			\
+	: "cc", cl);						\
+								\
+	return prev >> bitoff;					\
+}
+
+#define CMPXCHG_GEN(type, sfx, br, br2, cl)			\
+static inline							\
+u32 __cmpxchg_##type##sfx(void *p, u32 old, u32 new)		\
+{								\
+	unsigned int prev, prev_mask, tmp, bitoff, off;		\
+								\
+	off = (unsigned long)p % sizeof(u32);			\
+	bitoff = BITOFF_CAL(sizeof(type), off);			\
+	p -= off;						\
+	old <<= bitoff;						\
+	new <<= bitoff;						\
+	prev_mask = (u32)(type)-1 << bitoff;			\
+								\
+	__asm__ __volatile__(					\
+	br							\
+"1:	lwarx   %0,0,%3\n"					\
+"	and	%1,%0,%6\n"					\
+"	cmpw	0,%1,%4\n"					\
+"	bne-	2f\n"						\
+"	andc	%1,%0,%6\n"					\
+"	or	%1,%1,%5\n"					\
+	PPC405_ERR77(0,%3)					\
+"	stwcx.  %1,0,%3\n"					\
+"	bne-    1b\n"						\
+	br2							\
+	"\n"							\
+"2:"								\
+	: "=&r" (prev), "=&r" (tmp), "+m" (*(u32*)p)		\
+	: "r" (p), "r" (old), "r" (new), "r" (prev_mask)	\
+	: "cc", cl);						\
+								\
+	return prev >> bitoff;					\
+}
+
 /*
  * Atomic exchange
  *
@@ -14,6 +79,11 @@
  * the previous value stored there.
  */
 
+XCHG_GEN(u8, _local, "memory");
+XCHG_GEN(u8, _relaxed, "cc");
+XCHG_GEN(u16, _local, "memory");
+XCHG_GEN(u16, _relaxed, "cc");
+
 static __always_inline unsigned long
 __xchg_u32_local(volatile void *p, unsigned long val)
 {
@@ -85,9 +155,13 @@ __xchg_u64_relaxed(u64 *p, unsigned long val)
 #endif
 
 static __always_inline unsigned long
-__xchg_local(volatile void *ptr, unsigned long x, unsigned int size)
+__xchg_local(void *ptr, unsigned long x, unsigned int size)
 {
 	switch (size) {
+	case 1:
+		return __xchg_u8_local(ptr, x);
+	case 2:
+		return __xchg_u16_local(ptr, x);
 	case 4:
 		return __xchg_u32_local(ptr, x);
 #ifdef CONFIG_PPC64
@@ -103,6 +177,10 @@ static __always_inline unsigned long
 __xchg_relaxed(void *ptr, unsigned long x, unsigned int size)
 {
 	switch (size) {
+	case 1:
+		return __xchg_u8_relaxed(ptr, x);
+	case 2:
+		return __xchg_u16_relaxed(ptr, x);
 	case 4:
 		return __xchg_u32_relaxed(ptr, x);
 #ifdef CONFIG_PPC64
@@ -131,6 +209,15 @@ __xchg_relaxed(void *ptr, unsigned long x, unsigned int size)
  * and return the old value of *p.
  */
 
+CMPXCHG_GEN(u8, , PPC_ATOMIC_ENTRY_BARRIER, PPC_ATOMIC_EXIT_BARRIER, "memory");
+CMPXCHG_GEN(u8, _local, , , "memory");
+CMPXCHG_GEN(u8, _acquire, , PPC_ACQUIRE_BARRIER, "memory");
+CMPXCHG_GEN(u8, _relaxed, , , "cc");
+CMPXCHG_GEN(u16, , PPC_ATOMIC_ENTRY_BARRIER, PPC_ATOMIC_EXIT_BARRIER, "memory");
+CMPXCHG_GEN(u16, _local, , , "memory");
+CMPXCHG_GEN(u16, _acquire, , PPC_ACQUIRE_BARRIER, "memory");
+CMPXCHG_GEN(u16, _relaxed, , , "cc");
+
 static __always_inline unsigned long
 __cmpxchg_u32(volatile unsigned int *p, unsigned long old, unsigned long new)
 {
@@ -312,10 +399,14 @@ __cmpxchg_u64_acquire(u64 *p, unsigned long old, unsigned long new)
 #endif
 
 static __always_inline unsigned long
-__cmpxchg(volatile void *ptr, unsigned long old, unsigned long new,
+__cmpxchg(void *ptr, unsigned long old, unsigned long new,
 	  unsigned int size)
 {
 	switch (size) {
+	case 1:
+		return __cmpxchg_u8(ptr, old, new);
+	case 2:
+		return __cmpxchg_u16(ptr, old, new);
 	case 4:
 		return __cmpxchg_u32(ptr, old, new);
 #ifdef CONFIG_PPC64
@@ -328,10 +419,14 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new,
 }
 
 static __always_inline unsigned long
-__cmpxchg_local(volatile void *ptr, unsigned long old, unsigned long new,
+__cmpxchg_local(void *ptr, unsigned long old, unsigned long new,
 	  unsigned int size)
 {
 	switch (size) {
+	case 1:
+		return __cmpxchg_u8_local(ptr, old, new);
+	case 2:
+		return __cmpxchg_u16_local(ptr, old, new);
 	case 4:
 		return __cmpxchg_u32_local(ptr, old, new);
 #ifdef CONFIG_PPC64
@@ -348,6 +443,10 @@ __cmpxchg_relaxed(void *ptr, unsigned long old, unsigned long new,
 		  unsigned int size)
 {
 	switch (size) {
+	case 1:
+		return __cmpxchg_u8_relaxed(ptr, old, new);
+	case 2:
+		return __cmpxchg_u16_relaxed(ptr, old, new);
 	case 4:
 		return __cmpxchg_u32_relaxed(ptr, old, new);
 #ifdef CONFIG_PPC64
@@ -364,6 +463,10 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 		  unsigned int size)
 {
 	switch (size) {
+	case 1:
+		return __cmpxchg_u8_acquire(ptr, old, new);
+	case 2:
+		return __cmpxchg_u16_acquire(ptr, old, new);
 	case 4:
 		return __cmpxchg_u32_acquire(ptr, old, new);
 #ifdef CONFIG_PPC64
-- 
2.4.3
