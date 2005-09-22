Return-Path: <jdl@jdl.com>
From: Jon Loeliger <jdl@freescale.com>
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Date: Thu, 22 Sep 2005 14:55:30 -0500
Message-Id: <E1EIXAI-0006Q0-OS@jdl.com>
Sender: Jon Loeliger <jdl@jdl.com>
Subject: PATCH powerpc Merge asm-ppc*/rwsem.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Merge asm-ppc*/rwsem.h into include/asm-powerpc.
Removed smp_*mb() memory barriers from the ppc32 code
as they are now burried in the atomic_*() functions as
suggested by Paul, implemented by Arnd, and pushed out
by Becky.  I am not the droid you are looking for.

This patch depends on Becky's atomic.h merge patch.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
---

 include/asm-powerpc/rwsem.h |  163 +++++++++++++++++++++++++++++++++++++++++
 include/asm-ppc/rwsem.h     |  172 -------------------------------------------
 include/asm-ppc64/rwsem.h   |  167 ------------------------------------------
 3 files changed, 163 insertions(+), 339 deletions(-)


diff --git a/include/asm-powerpc/rwsem.h b/include/asm-powerpc/rwsem.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/rwsem.h
@@ -0,0 +1,163 @@
+#ifndef _ASM_POWERPC_RWSEM_H
+#define _ASM_POWERPC_RWSEM_H
+
+#ifdef __KERNEL__
+
+/*
+ * include/asm-ppc64/rwsem.h: R/W semaphores for PPC using the stuff
+ * in lib/rwsem.c.  Adapted largely from include/asm-i386/rwsem.h
+ * by Paul Mackerras <paulus@samba.org>.
+ */
+
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <asm/atomic.h>
+#include <asm/system.h>
+
+/*
+ * the semaphore definition
+ */
+struct rw_semaphore {
+	/* XXX this should be able to be an atomic_t  -- paulus */
+	signed int		count;
+#define RWSEM_UNLOCKED_VALUE		0x00000000
+#define RWSEM_ACTIVE_BIAS		0x00000001
+#define RWSEM_ACTIVE_MASK		0x0000ffff
+#define RWSEM_WAITING_BIAS		(-0x00010000)
+#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
+#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
+	spinlock_t		wait_lock;
+	struct list_head	wait_list;
+#if RWSEM_DEBUG
+	int			debug;
+#endif
+};
+
+/*
+ * initialisation
+ */
+#if RWSEM_DEBUG
+#define __RWSEM_DEBUG_INIT      , 0
+#else
+#define __RWSEM_DEBUG_INIT	/* */
+#endif
+
+#define __RWSEM_INITIALIZER(name) \
+	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
+	  LIST_HEAD_INIT((name).wait_list) \
+	  __RWSEM_DEBUG_INIT }
+
+#define DECLARE_RWSEM(name)		\
+	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
+
+extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
+extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
+extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem);
+extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
+
+static inline void init_rwsem(struct rw_semaphore *sem)
+{
+	sem->count = RWSEM_UNLOCKED_VALUE;
+	spin_lock_init(&sem->wait_lock);
+	INIT_LIST_HEAD(&sem->wait_list);
+#if RWSEM_DEBUG
+	sem->debug = 0;
+#endif
+}
+
+/*
+ * lock for reading
+ */
+static inline void __down_read(struct rw_semaphore *sem)
+{
+	if (unlikely(atomic_inc_return((atomic_t *)(&sem->count)) <= 0))
+		rwsem_down_read_failed(sem);
+}
+
+static inline int __down_read_trylock(struct rw_semaphore *sem)
+{
+	int tmp;
+
+	while ((tmp = sem->count) >= 0) {
+		if (tmp == cmpxchg(&sem->count, tmp,
+				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
+			return 1;
+		}
+	}
+	return 0;
+}
+
+/*
+ * lock for writing
+ */
+static inline void __down_write(struct rw_semaphore *sem)
+{
+	int tmp;
+
+	tmp = atomic_add_return(RWSEM_ACTIVE_WRITE_BIAS,
+				(atomic_t *)(&sem->count));
+	if (unlikely(tmp != RWSEM_ACTIVE_WRITE_BIAS))
+		rwsem_down_write_failed(sem);
+}
+
+static inline int __down_write_trylock(struct rw_semaphore *sem)
+{
+	int tmp;
+
+	tmp = cmpxchg(&sem->count, RWSEM_UNLOCKED_VALUE,
+		      RWSEM_ACTIVE_WRITE_BIAS);
+	return tmp == RWSEM_UNLOCKED_VALUE;
+}
+
+/*
+ * unlock after reading
+ */
+static inline void __up_read(struct rw_semaphore *sem)
+{
+	int tmp;
+
+	tmp = atomic_dec_return((atomic_t *)(&sem->count));
+	if (unlikely(tmp < -1 && (tmp & RWSEM_ACTIVE_MASK) == 0))
+		rwsem_wake(sem);
+}
+
+/*
+ * unlock after writing
+ */
+static inline void __up_write(struct rw_semaphore *sem)
+{
+	if (unlikely(atomic_sub_return(RWSEM_ACTIVE_WRITE_BIAS,
+			      (atomic_t *)(&sem->count)) < 0))
+		rwsem_wake(sem);
+}
+
+/*
+ * implement atomic add functionality
+ */
+static inline void rwsem_atomic_add(int delta, struct rw_semaphore *sem)
+{
+	atomic_add(delta, (atomic_t *)(&sem->count));
+}
+
+/*
+ * downgrade write lock to read lock
+ */
+static inline void __downgrade_write(struct rw_semaphore *sem)
+{
+	int tmp;
+
+	tmp = atomic_add_return(-RWSEM_WAITING_BIAS, (atomic_t *)(&sem->count));
+	if (tmp < 0)
+		rwsem_downgrade_wake(sem);
+}
+
+/*
+ * implement exchange and add functionality
+ */
+static inline int rwsem_atomic_update(int delta, struct rw_semaphore *sem)
+{
+	return atomic_add_return(delta, (atomic_t *)(&sem->count));
+}
+
+#endif	/* __KERNEL__ */
+#endif	/* _ASM_POWERPC_RWSEM_H */
diff --git a/include/asm-ppc/rwsem.h b/include/asm-ppc/rwsem.h
deleted file mode 100644
--- a/include/asm-ppc/rwsem.h
+++ /dev/null
@@ -1,172 +0,0 @@
-/*
- * include/asm-ppc/rwsem.h: R/W semaphores for PPC using the stuff
- * in lib/rwsem.c.  Adapted largely from include/asm-i386/rwsem.h
- * by Paul Mackerras <paulus@samba.org>.
- */
-
-#ifndef _PPC_RWSEM_H
-#define _PPC_RWSEM_H
-
-#ifdef __KERNEL__
-#include <linux/list.h>
-#include <linux/spinlock.h>
-#include <asm/atomic.h>
-#include <asm/system.h>
-
-/*
- * the semaphore definition
- */
-struct rw_semaphore {
-	/* XXX this should be able to be an atomic_t  -- paulus */
-	signed long		count;
-#define RWSEM_UNLOCKED_VALUE		0x00000000
-#define RWSEM_ACTIVE_BIAS		0x00000001
-#define RWSEM_ACTIVE_MASK		0x0000ffff
-#define RWSEM_WAITING_BIAS		(-0x00010000)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-#if RWSEM_DEBUG
-	int			debug;
-#endif
-};
-
-/*
- * initialisation
- */
-#if RWSEM_DEBUG
-#define __RWSEM_DEBUG_INIT      , 0
-#else
-#define __RWSEM_DEBUG_INIT	/* */
-#endif
-
-#define __RWSEM_INITIALIZER(name) \
-	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
-	  LIST_HEAD_INIT((name).wait_list) \
-	  __RWSEM_DEBUG_INIT }
-
-#define DECLARE_RWSEM(name)		\
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
-
-extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
-
-static inline void init_rwsem(struct rw_semaphore *sem)
-{
-	sem->count = RWSEM_UNLOCKED_VALUE;
-	spin_lock_init(&sem->wait_lock);
-	INIT_LIST_HEAD(&sem->wait_list);
-#if RWSEM_DEBUG
-	sem->debug = 0;
-#endif
-}
-
-/*
- * lock for reading
- */
-static inline void __down_read(struct rw_semaphore *sem)
-{
-	if (atomic_inc_return((atomic_t *)(&sem->count)) > 0)
-		smp_wmb();
-	else
-		rwsem_down_read_failed(sem);
-}
-
-static inline int __down_read_trylock(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	while ((tmp = sem->count) >= 0) {
-		if (tmp == cmpxchg(&sem->count, tmp,
-				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
-			smp_wmb();
-			return 1;
-		}
-	}
-	return 0;
-}
-
-/*
- * lock for writing
- */
-static inline void __down_write(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	tmp = atomic_add_return(RWSEM_ACTIVE_WRITE_BIAS,
-				(atomic_t *)(&sem->count));
-	if (tmp == RWSEM_ACTIVE_WRITE_BIAS)
-		smp_wmb();
-	else
-		rwsem_down_write_failed(sem);
-}
-
-static inline int __down_write_trylock(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	tmp = cmpxchg(&sem->count, RWSEM_UNLOCKED_VALUE,
-		      RWSEM_ACTIVE_WRITE_BIAS);
-	smp_wmb();
-	return tmp == RWSEM_UNLOCKED_VALUE;
-}
-
-/*
- * unlock after reading
- */
-static inline void __up_read(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	smp_wmb();
-	tmp = atomic_dec_return((atomic_t *)(&sem->count));
-	if (tmp < -1 && (tmp & RWSEM_ACTIVE_MASK) == 0)
-		rwsem_wake(sem);
-}
-
-/*
- * unlock after writing
- */
-static inline void __up_write(struct rw_semaphore *sem)
-{
-	smp_wmb();
-	if (atomic_sub_return(RWSEM_ACTIVE_WRITE_BIAS,
-			      (atomic_t *)(&sem->count)) < 0)
-		rwsem_wake(sem);
-}
-
-/*
- * implement atomic add functionality
- */
-static inline void rwsem_atomic_add(int delta, struct rw_semaphore *sem)
-{
-	atomic_add(delta, (atomic_t *)(&sem->count));
-}
-
-/*
- * downgrade write lock to read lock
- */
-static inline void __downgrade_write(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	smp_wmb();
-	tmp = atomic_add_return(-RWSEM_WAITING_BIAS, (atomic_t *)(&sem->count));
-	if (tmp < 0)
-		rwsem_downgrade_wake(sem);
-}
-
-/*
- * implement exchange and add functionality
- */
-static inline int rwsem_atomic_update(int delta, struct rw_semaphore *sem)
-{
-	smp_mb();
-	return atomic_add_return(delta, (atomic_t *)(&sem->count));
-}
-
-#endif /* __KERNEL__ */
-#endif /* _PPC_RWSEM_XADD_H */
diff --git a/include/asm-ppc64/rwsem.h b/include/asm-ppc64/rwsem.h
deleted file mode 100644
--- a/include/asm-ppc64/rwsem.h
+++ /dev/null
@@ -1,167 +0,0 @@
-/*
- * include/asm-ppc64/rwsem.h: R/W semaphores for PPC using the stuff
- * in lib/rwsem.c.  Adapted largely from include/asm-i386/rwsem.h
- * by Paul Mackerras <paulus@samba.org>.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#ifndef _PPC64_RWSEM_H
-#define _PPC64_RWSEM_H
-
-#ifdef __KERNEL__
-#include <linux/list.h>
-#include <linux/spinlock.h>
-#include <asm/atomic.h>
-#include <asm/system.h>
-
-/*
- * the semaphore definition
- */
-struct rw_semaphore {
-	/* XXX this should be able to be an atomic_t  -- paulus */
-	signed int		count;
-#define RWSEM_UNLOCKED_VALUE		0x00000000
-#define RWSEM_ACTIVE_BIAS		0x00000001
-#define RWSEM_ACTIVE_MASK		0x0000ffff
-#define RWSEM_WAITING_BIAS		(-0x00010000)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-#if RWSEM_DEBUG
-	int			debug;
-#endif
-};
-
-/*
- * initialisation
- */
-#if RWSEM_DEBUG
-#define __RWSEM_DEBUG_INIT      , 0
-#else
-#define __RWSEM_DEBUG_INIT	/* */
-#endif
-
-#define __RWSEM_INITIALIZER(name) \
-	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
-	  LIST_HEAD_INIT((name).wait_list) \
-	  __RWSEM_DEBUG_INIT }
-
-#define DECLARE_RWSEM(name)		\
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
-
-extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
-
-static inline void init_rwsem(struct rw_semaphore *sem)
-{
-	sem->count = RWSEM_UNLOCKED_VALUE;
-	spin_lock_init(&sem->wait_lock);
-	INIT_LIST_HEAD(&sem->wait_list);
-#if RWSEM_DEBUG
-	sem->debug = 0;
-#endif
-}
-
-/*
- * lock for reading
- */
-static inline void __down_read(struct rw_semaphore *sem)
-{
-	if (unlikely(atomic_inc_return((atomic_t *)(&sem->count)) <= 0))
-		rwsem_down_read_failed(sem);
-}
-
-static inline int __down_read_trylock(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	while ((tmp = sem->count) >= 0) {
-		if (tmp == cmpxchg(&sem->count, tmp,
-				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
-			return 1;
-		}
-	}
-	return 0;
-}
-
-/*
- * lock for writing
- */
-static inline void __down_write(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	tmp = atomic_add_return(RWSEM_ACTIVE_WRITE_BIAS,
-				(atomic_t *)(&sem->count));
-	if (unlikely(tmp != RWSEM_ACTIVE_WRITE_BIAS))
-		rwsem_down_write_failed(sem);
-}
-
-static inline int __down_write_trylock(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	tmp = cmpxchg(&sem->count, RWSEM_UNLOCKED_VALUE,
-		      RWSEM_ACTIVE_WRITE_BIAS);
-	return tmp == RWSEM_UNLOCKED_VALUE;
-}
-
-/*
- * unlock after reading
- */
-static inline void __up_read(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	tmp = atomic_dec_return((atomic_t *)(&sem->count));
-	if (unlikely(tmp < -1 && (tmp & RWSEM_ACTIVE_MASK) == 0))
-		rwsem_wake(sem);
-}
-
-/*
- * unlock after writing
- */
-static inline void __up_write(struct rw_semaphore *sem)
-{
-	if (unlikely(atomic_sub_return(RWSEM_ACTIVE_WRITE_BIAS,
-			      (atomic_t *)(&sem->count)) < 0))
-		rwsem_wake(sem);
-}
-
-/*
- * implement atomic add functionality
- */
-static inline void rwsem_atomic_add(int delta, struct rw_semaphore *sem)
-{
-	atomic_add(delta, (atomic_t *)(&sem->count));
-}
-
-/*
- * downgrade write lock to read lock
- */
-static inline void __downgrade_write(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	tmp = atomic_add_return(-RWSEM_WAITING_BIAS, (atomic_t *)(&sem->count));
-	if (tmp < 0)
-		rwsem_downgrade_wake(sem);
-}
-
-/*
- * implement exchange and add functionality
- */
-static inline int rwsem_atomic_update(int delta, struct rw_semaphore *sem)
-{
-	return atomic_add_return(delta, (atomic_t *)(&sem->count));
-}
-
-#endif /* __KERNEL__ */
-#endif /* _PPC_RWSEM_XADD_H */
