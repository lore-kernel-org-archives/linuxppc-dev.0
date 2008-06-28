Return-Path: <bart.vanassche@gmail.com>
Received: from mailpush2.euphonynet.be (jester.euphonynet.be [212.87.96.13])
	by ozlabs.org (Postfix) with ESMTP id 47D50DDEFD
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 17:26:13 +1000 (EST)
From: Bart Van Assche <bart.vanassche@gmail.com>
To: Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@ozlabs.org
Subject: [PATCH 2.6.25.9] Make sure that include/asm-powerpc/spinlock.h does
	not trigger compilation warnings
Date: Sat, 28 Jun 2008 08:51:35 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200806280851.35417.bart.vanassche@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When compiling kernel modules for ppc that include <linux/spinlock.h>, gcc
prints a warning message every time it encounters a function declaration where
the inline keyword appears after the return type. The patch below makes sure
that the order of the inline keyword and the return type is as gcc expects it.
Additionally, the __inline__ keyword is replaced by inline, as checkpatch
expects.

Signed-off-by: Bart Van Assche <bart.vanassche@gmail.com>

diff -uprN orig/linux-2.6.25.9/include/asm-powerpc/spinlock.h linux-2.6.25.9/include/asm-powerpc/spinlock.h
--- orig/linux-2.6.25.9/include/asm-powerpc/spinlock.h	2008-06-24 23:09:06.000000000 +0200
+++ linux-2.6.25.9/include/asm-powerpc/spinlock.h	2008-06-28 08:34:52.000000000 +0200
@@ -53,7 +53,7 @@
  * This returns the old value in the lock, so we succeeded
  * in getting the lock if the return value is 0.
  */
-static __inline__ unsigned long __spin_trylock(raw_spinlock_t *lock)
+static inline unsigned long __spin_trylock(raw_spinlock_t *lock)
 {
 	unsigned long tmp, token;
 
@@ -72,7 +72,7 @@ static __inline__ unsigned long __spin_t
 	return tmp;
 }
 
-static int __inline__ __raw_spin_trylock(raw_spinlock_t *lock)
+static inline int __raw_spin_trylock(raw_spinlock_t *lock)
 {
 	CLEAR_IO_SYNC;
 	return __spin_trylock(lock) == 0;
@@ -103,7 +103,7 @@ extern void __rw_yield(raw_rwlock_t *loc
 #define SHARED_PROCESSOR	0
 #endif
 
-static void __inline__ __raw_spin_lock(raw_spinlock_t *lock)
+static inline void __raw_spin_lock(raw_spinlock_t *lock)
 {
 	CLEAR_IO_SYNC;
 	while (1) {
@@ -118,7 +118,8 @@ static void __inline__ __raw_spin_lock(r
 	}
 }
 
-static void __inline__ __raw_spin_lock_flags(raw_spinlock_t *lock, unsigned long flags)
+static inline
+void __raw_spin_lock_flags(raw_spinlock_t *lock, unsigned long flags)
 {
 	unsigned long flags_dis;
 
@@ -138,7 +139,7 @@ static void __inline__ __raw_spin_lock_f
 	}
 }
 
-static __inline__ void __raw_spin_unlock(raw_spinlock_t *lock)
+static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
 	SYNC_IO;
 	__asm__ __volatile__("# __raw_spin_unlock\n\t"
@@ -179,7 +180,7 @@ extern void __raw_spin_unlock_wait(raw_s
  * This returns the old value in the lock + 1,
  * so we got a read lock if the return value is > 0.
  */
-static long __inline__ __read_trylock(raw_rwlock_t *rw)
+static inline long __read_trylock(raw_rwlock_t *rw)
 {
 	long tmp;
 
@@ -203,7 +204,7 @@ static long __inline__ __read_trylock(ra
  * This returns the old value in the lock,
  * so we got the write lock if the return value is 0.
  */
-static __inline__ long __write_trylock(raw_rwlock_t *rw)
+static inline long __write_trylock(raw_rwlock_t *rw)
 {
 	long tmp, token;
 
@@ -223,7 +224,7 @@ static __inline__ long __write_trylock(r
 	return tmp;
 }
 
-static void __inline__ __raw_read_lock(raw_rwlock_t *rw)
+static inline void __raw_read_lock(raw_rwlock_t *rw)
 {
 	while (1) {
 		if (likely(__read_trylock(rw) > 0))
@@ -237,7 +238,7 @@ static void __inline__ __raw_read_lock(r
 	}
 }
 
-static void __inline__ __raw_write_lock(raw_rwlock_t *rw)
+static inline void __raw_write_lock(raw_rwlock_t *rw)
 {
 	while (1) {
 		if (likely(__write_trylock(rw) == 0))
@@ -251,17 +252,17 @@ static void __inline__ __raw_write_lock(
 	}
 }
 
-static int __inline__ __raw_read_trylock(raw_rwlock_t *rw)
+static inline int __raw_read_trylock(raw_rwlock_t *rw)
 {
 	return __read_trylock(rw) > 0;
 }
 
-static int __inline__ __raw_write_trylock(raw_rwlock_t *rw)
+static inline int __raw_write_trylock(raw_rwlock_t *rw)
 {
 	return __write_trylock(rw) == 0;
 }
 
-static void __inline__ __raw_read_unlock(raw_rwlock_t *rw)
+static inline void __raw_read_unlock(raw_rwlock_t *rw)
 {
 	long tmp;
 
@@ -278,7 +279,7 @@ static void __inline__ __raw_read_unlock
 	: "cr0", "memory");
 }
 
-static __inline__ void __raw_write_unlock(raw_rwlock_t *rw)
+static inline void __raw_write_unlock(raw_rwlock_t *rw)
 {
 	__asm__ __volatile__("# write_unlock\n\t"
 				LWSYNC_ON_SMP: : :"memory");
