Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17671.54461.77700.184852@cargo.ozlabs.ibm.com>
Date: Wed, 13 Sep 2006 19:51:57 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix MMIO ops to provide expected barrier behaviour
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This changes the writeX family of functions to have a sync instruction
before the MMIO store rather than after, because the generally expected
behaviour is that the device receiving the MMIO store can be guaranteed
to see the effects of any preceding writes to normal memory.

To preserve ordering between writeX and readX, the readX family of
functions have had an eieio added before the load.

Although writeX followed by spin_unlock is not officially guaranteed
to keep the writeX inside the spin-locked region unless an mmiowb()
is used, there are currently drivers that depend on the previous
behaviour on powerpc, which was that the mmiowb wasn't actually required.
Therefore we have a per-cpu flag that is set by writeX, cleared by
__raw_spin_lock and mmiowb, and tested by __raw_spin_unlock.  If it is
set, __raw_spin_unlock does a sync and clears it.

Tested on G5 (PPC970) and POWER5.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
index fc23040..6e95578 100644
--- a/arch/powerpc/kernel/misc.S
+++ b/arch/powerpc/kernel/misc.S
@@ -74,11 +74,12 @@ _GLOBAL(_insb)
 	mtctr	r5
 	subi	r4,r4,1
 	blelr-
-00:	lbz	r5,0(r3)
-	eieio
+00:	eieio
+	lbz	r5,0(r3)
 	stbu	r5,1(r4)
 	bdnz	00b
-	IN_SYNC
+	twi	0,r5,0
+	isync
 	blr
 
 _GLOBAL(_outsb)
@@ -86,11 +87,10 @@ _GLOBAL(_outsb)
 	mtctr	r5
 	subi	r4,r4,1
 	blelr-
+	sync
 00:	lbzu	r5,1(r4)
 	stb	r5,0(r3)
-	EIEIO_32
 	bdnz	00b
-	SYNC_64
 	blr
 
 _GLOBAL(_insw)
@@ -98,11 +98,12 @@ _GLOBAL(_insw)
 	mtctr	r5
 	subi	r4,r4,2
 	blelr-
-00:	lhbrx	r5,0,r3
-	eieio
+00:	eieio
+	lhbrx	r5,0,r3
 	sthu	r5,2(r4)
 	bdnz	00b
-	IN_SYNC
+	twi	0,r5,0
+	isync
 	blr
 
 _GLOBAL(_outsw)
@@ -110,11 +111,10 @@ _GLOBAL(_outsw)
 	mtctr	r5
 	subi	r4,r4,2
 	blelr-
+	sync
 00:	lhzu	r5,2(r4)
-	EIEIO_32
 	sthbrx	r5,0,r3
 	bdnz	00b
-	SYNC_64
 	blr
 
 _GLOBAL(_insl)
@@ -122,11 +122,12 @@ _GLOBAL(_insl)
 	mtctr	r5
 	subi	r4,r4,4
 	blelr-
-00:	lwbrx	r5,0,r3
-	eieio
+00:	eieio
+	lwbrx	r5,0,r3
 	stwu	r5,4(r4)
 	bdnz	00b
-	IN_SYNC
+	twi	0,r5,0
+	isync
 	blr
 
 _GLOBAL(_outsl)
@@ -134,11 +135,10 @@ _GLOBAL(_outsl)
 	mtctr	r5
 	subi	r4,r4,4
 	blelr-
+	sync
 00:	lwzu	r5,4(r4)
 	stwbrx	r5,0,r3
-	EIEIO_32
 	bdnz	00b
-	SYNC_64
 	blr
 
 #ifdef CONFIG_PPC32
@@ -149,11 +149,12 @@ _GLOBAL(_insw_ns)
 	mtctr	r5
 	subi	r4,r4,2
 	blelr-
-00:	lhz	r5,0(r3)
-	eieio
+00:	eieio
+	lhz	r5,0(r3)
 	sthu	r5,2(r4)
 	bdnz	00b
-	IN_SYNC
+	twi	0,r5,0
+	isync
 	blr
 
 #ifdef CONFIG_PPC32
@@ -164,11 +165,10 @@ _GLOBAL(_outsw_ns)
 	mtctr	r5
 	subi	r4,r4,2
 	blelr-
+	sync
 00:	lhzu	r5,2(r4)
 	sth	r5,0(r3)
-	EIEIO_32
 	bdnz	00b
-	SYNC_64
 	blr
 
 #ifdef CONFIG_PPC32
@@ -179,11 +179,12 @@ _GLOBAL(_insl_ns)
 	mtctr	r5
 	subi	r4,r4,4
 	blelr-
-00:	lwz	r5,0(r3)
-	eieio
+00:	eieio
+	lwz	r5,0(r3)
 	stwu	r5,4(r4)
 	bdnz	00b
-	IN_SYNC
+	twi	0,r5,0
+	isync
 	blr
 
 #ifdef CONFIG_PPC32
@@ -194,10 +195,9 @@ _GLOBAL(_outsl_ns)
 	mtctr	r5
 	subi	r4,r4,4
 	blelr-
+	sync
 00:	lwzu	r5,4(r4)
 	stw	r5,0(r3)
-	EIEIO_32
 	bdnz	00b
-	SYNC_64
 	blr
 
diff --git a/include/asm-powerpc/eeh.h b/include/asm-powerpc/eeh.h
index 4df3e80..c8f0a94 100644
--- a/include/asm-powerpc/eeh.h
+++ b/include/asm-powerpc/eeh.h
@@ -229,6 +229,7 @@ static inline void eeh_memcpy_fromio(voi
 	void *destsave = dest;
 	unsigned long nsave = n;
 
+	__asm__ __volatile__ ("eieio" : : : "memory");
 	while(n && (!EEH_CHECK_ALIGN(vsrc, 4) || !EEH_CHECK_ALIGN(dest, 4))) {
 		*((u8 *)dest) = *((volatile u8 *)vsrc);
 		__asm__ __volatile__ ("eieio" : : : "memory");
diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
index 36c4c34..e97934a 100644
--- a/include/asm-powerpc/io.h
+++ b/include/asm-powerpc/io.h
@@ -19,6 +19,7 @@ #else
 #include <linux/compiler.h>
 #include <asm/page.h>
 #include <asm/byteorder.h>
+#include <asm/paca.h>
 #ifdef CONFIG_PPC_ISERIES 
 #include <asm/iseries/iseries_io.h>
 #endif  
@@ -162,7 +163,11 @@ extern void _outsw_ns(volatile u16 __iom
 extern void _insl_ns(volatile u32 __iomem *port, void *buf, int nl);
 extern void _outsl_ns(volatile u32 __iomem *port, const void *buf, int nl);
 
-#define mmiowb()
+static inline void mmiowb(void)
+{
+	__asm__ __volatile__ ("sync" : : : "memory");
+	get_paca()->io_sync = 0;
+}
 
 /*
  * output pause versions need a delay at least for the
@@ -278,22 +283,23 @@ static inline int in_8(const volatile un
 {
 	int ret;
 
-	__asm__ __volatile__("lbz%U1%X1 %0,%1; twi 0,%0,0; isync"
+	__asm__ __volatile__("eieio; lbz%U1%X1 %0,%1; twi 0,%0,0; isync"
 			     : "=r" (ret) : "m" (*addr));
 	return ret;
 }
 
 static inline void out_8(volatile unsigned char __iomem *addr, int val)
 {
-	__asm__ __volatile__("stb%U0%X0 %1,%0; sync"
+	__asm__ __volatile__("sync; stb%U0%X0 %1,%0"
 			     : "=m" (*addr) : "r" (val));
+	get_paca()->io_sync = 1;
 }
 
 static inline int in_le16(const volatile unsigned short __iomem *addr)
 {
 	int ret;
 
-	__asm__ __volatile__("lhbrx %0,0,%1; twi 0,%0,0; isync"
+	__asm__ __volatile__("eieio; lhbrx %0,0,%1; twi 0,%0,0; isync"
 			     : "=r" (ret) : "r" (addr), "m" (*addr));
 	return ret;
 }
@@ -302,28 +308,30 @@ static inline int in_be16(const volatile
 {
 	int ret;
 
-	__asm__ __volatile__("lhz%U1%X1 %0,%1; twi 0,%0,0; isync"
+	__asm__ __volatile__("eieio; lhz%U1%X1 %0,%1; twi 0,%0,0; isync"
 			     : "=r" (ret) : "m" (*addr));
 	return ret;
 }
 
 static inline void out_le16(volatile unsigned short __iomem *addr, int val)
 {
-	__asm__ __volatile__("sthbrx %1,0,%2; sync"
+	__asm__ __volatile__("sync; sthbrx %1,0,%2"
 			     : "=m" (*addr) : "r" (val), "r" (addr));
+	get_paca()->io_sync = 1;
 }
 
 static inline void out_be16(volatile unsigned short __iomem *addr, int val)
 {
-	__asm__ __volatile__("sth%U0%X0 %1,%0; sync"
+	__asm__ __volatile__("sync; sth%U0%X0 %1,%0"
 			     : "=m" (*addr) : "r" (val));
+	get_paca()->io_sync = 1;
 }
 
 static inline unsigned in_le32(const volatile unsigned __iomem *addr)
 {
 	unsigned ret;
 
-	__asm__ __volatile__("lwbrx %0,0,%1; twi 0,%0,0; isync"
+	__asm__ __volatile__("eieio; lwbrx %0,0,%1; twi 0,%0,0; isync"
 			     : "=r" (ret) : "r" (addr), "m" (*addr));
 	return ret;
 }
@@ -332,21 +340,23 @@ static inline unsigned in_be32(const vol
 {
 	unsigned ret;
 
-	__asm__ __volatile__("lwz%U1%X1 %0,%1; twi 0,%0,0; isync"
+	__asm__ __volatile__("eieio; lwz%U1%X1 %0,%1; twi 0,%0,0; isync"
 			     : "=r" (ret) : "m" (*addr));
 	return ret;
 }
 
 static inline void out_le32(volatile unsigned __iomem *addr, int val)
 {
-	__asm__ __volatile__("stwbrx %1,0,%2; sync" : "=m" (*addr)
+	__asm__ __volatile__("sync; stwbrx %1,0,%2" : "=m" (*addr)
 			     : "r" (val), "r" (addr));
+	get_paca()->io_sync = 1;
 }
 
 static inline void out_be32(volatile unsigned __iomem *addr, int val)
 {
-	__asm__ __volatile__("stw%U0%X0 %1,%0; sync"
+	__asm__ __volatile__("sync; stw%U0%X0 %1,%0"
 			     : "=m" (*addr) : "r" (val));
+	get_paca()->io_sync = 1;
 }
 
 static inline unsigned long in_le64(const volatile unsigned long __iomem *addr)
@@ -354,6 +364,7 @@ static inline unsigned long in_le64(cons
 	unsigned long tmp, ret;
 
 	__asm__ __volatile__(
+			     "eieio\n"
 			     "ld %1,0(%2)\n"
 			     "twi 0,%1,0\n"
 			     "isync\n"
@@ -372,7 +383,7 @@ static inline unsigned long in_be64(cons
 {
 	unsigned long ret;
 
-	__asm__ __volatile__("ld%U1%X1 %0,%1; twi 0,%0,0; isync"
+	__asm__ __volatile__("eieio; ld%U1%X1 %0,%1; twi 0,%0,0; isync"
 			     : "=r" (ret) : "m" (*addr));
 	return ret;
 }
@@ -389,14 +400,16 @@ static inline void out_le64(volatile uns
 			     "rldicl %1,%1,32,0\n"
 			     "rlwimi %0,%1,8,8,31\n"
 			     "rlwimi %0,%1,24,16,23\n"
-			     "std %0,0(%3)\n"
-			     "sync"
+			     "sync\n"
+			     "std %0,0(%3)"
 			     : "=&r" (tmp) , "=&r" (val) : "1" (val) , "b" (addr) , "m" (*addr));
+	get_paca()->io_sync = 1;
 }
 
 static inline void out_be64(volatile unsigned long __iomem *addr, unsigned long val)
 {
-	__asm__ __volatile__("std%U0%X0 %1,%0; sync" : "=m" (*addr) : "r" (val));
+	__asm__ __volatile__("sync; std%U0%X0 %1,%0" : "=m" (*addr) : "r" (val));
+	get_paca()->io_sync = 1;
 }
 
 #ifndef CONFIG_PPC_ISERIES 
diff --git a/include/asm-powerpc/paca.h b/include/asm-powerpc/paca.h
index 2d4585f..3d5d590 100644
--- a/include/asm-powerpc/paca.h
+++ b/include/asm-powerpc/paca.h
@@ -93,6 +93,7 @@ #endif /* CONFIG_PPC_ISERIES */
 	u64 saved_r1;			/* r1 save for RTAS calls */
 	u64 saved_msr;			/* MSR saved here by enter_rtas */
 	u8 proc_enabled;		/* irq soft-enable flag */
+	u8 io_sync;			/* writel() needs spin_unlock sync */
 
 	/* Stuff for accurate time accounting */
 	u64 user_time;			/* accumulated usermode TB ticks */
diff --git a/include/asm-powerpc/spinlock.h b/include/asm-powerpc/spinlock.h
index 895cb6d..c31e438 100644
--- a/include/asm-powerpc/spinlock.h
+++ b/include/asm-powerpc/spinlock.h
@@ -36,6 +36,19 @@ #else
 #define LOCK_TOKEN	1
 #endif
 
+#if defined(CONFIG_PPC64) && defined(CONFIG_SMP)
+#define CLEAR_IO_SYNC	(get_paca()->io_sync = 0)
+#define SYNC_IO		do {						\
+				if (unlikely(get_paca()->io_sync)) {	\
+					mb();				\
+					get_paca()->io_sync = 0;	\
+				}					\
+			} while (0)
+#else
+#define CLEAR_IO_SYNC
+#define SYNC_IO
+#endif
+
 /*
  * This returns the old value in the lock, so we succeeded
  * in getting the lock if the return value is 0.
@@ -61,6 +74,7 @@ static __inline__ unsigned long __spin_t
 
 static int __inline__ __raw_spin_trylock(raw_spinlock_t *lock)
 {
+	CLEAR_IO_SYNC;
 	return __spin_trylock(lock) == 0;
 }
 
@@ -91,6 +105,7 @@ #endif
 
 static void __inline__ __raw_spin_lock(raw_spinlock_t *lock)
 {
+	CLEAR_IO_SYNC;
 	while (1) {
 		if (likely(__spin_trylock(lock) == 0))
 			break;
@@ -107,6 +122,7 @@ static void __inline__ __raw_spin_lock_f
 {
 	unsigned long flags_dis;
 
+	CLEAR_IO_SYNC;
 	while (1) {
 		if (likely(__spin_trylock(lock) == 0))
 			break;
@@ -124,6 +140,7 @@ static void __inline__ __raw_spin_lock_f
 
 static __inline__ void __raw_spin_unlock(raw_spinlock_t *lock)
 {
+	SYNC_IO;
 	__asm__ __volatile__("# __raw_spin_unlock\n\t"
 				LWSYNC_ON_SMP: : :"memory");
 	lock->slock = 0;
