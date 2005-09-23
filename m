Return-Path: <bgill@freescale.com>
Date: Fri, 23 Sep 2005 11:07:36 -0500 (CDT)
From: Becky Bruce <bgill@freescale.com>
To: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Message-ID: <Pine.LNX.4.61.0509231104200.29342@cde-tx32-ldt329.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [PATCH] powerpc: merge semaphore.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powerpc: Merge semaphore.h

Adopted the ppc64 version of semaphore.h.  The 32-bit version used
smp_wmb(), but recent updates to atomic.h mean this is no longer required.
The 64-bit version made use of unlikely(), which has been retained in the
combined version.

This patch requires the recent atomic.h patch.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 76b1ba19ac14976b8cd288180bb939f429a70820
tree 330c84e832b71d9b803feaa340de40de689edc78
parent ab08c88845ac6e755db2ef806c36d1e469ef4180
author Becky Bruce <becky.bruce@freescale.com> Fri, 23 Sep 2005 11:01:14 -0500
committer Becky Bruce <becky.bruce@freescale.com> Fri, 23 Sep 2005 11:01:14 -0500

 include/asm-powerpc/semaphore.h |   98 ++++++++++++++++++++++++++++++++++
 include/asm-ppc/semaphore.h     |  111 ---------------------------------------
 include/asm-ppc64/semaphore.h   |   98 ----------------------------------
 3 files changed, 98 insertions(+), 209 deletions(-)

diff --git a/include/asm-powerpc/semaphore.h b/include/asm-powerpc/semaphore.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/semaphore.h
@@ -0,0 +1,98 @@
+#ifndef _ASM_POWERPC_SEMAPHORE_H
+#define _ASM_POWERPC_SEMAPHORE_H
+
+/*
+ * Remove spinlock-based RW semaphores; RW semaphore definitions are
+ * now in rwsem.h and we use the generic lib/rwsem.c implementation.
+ * Rework semaphores to use atomic_dec_if_positive.
+ * -- Paul Mackerras (paulus@samba.org)
+ */
+
+#ifdef __KERNEL__
+
+#include <asm/atomic.h>
+#include <asm/system.h>
+#include <linux/wait.h>
+#include <linux/rwsem.h>
+
+struct semaphore {
+	/*
+	 * Note that any negative value of count is equivalent to 0,
+	 * but additionally indicates that some process(es) might be
+	 * sleeping on `wait'.
+	 */
+	atomic_t count;
+	wait_queue_head_t wait;
+};
+
+#define __SEMAPHORE_INITIALIZER(name, n)				\
+{									\
+	.count		= ATOMIC_INIT(n),				\
+	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
+}
+
+#define __MUTEX_INITIALIZER(name) \
+	__SEMAPHORE_INITIALIZER(name, 1)
+
+#define __DECLARE_SEMAPHORE_GENERIC(name, count) \
+	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
+
+#define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name, 1)
+#define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name, 0)
+
+static inline void sema_init (struct semaphore *sem, int val)
+{
+	atomic_set(&sem->count, val);
+	init_waitqueue_head(&sem->wait);
+}
+
+static inline void init_MUTEX (struct semaphore *sem)
+{
+	sema_init(sem, 1);
+}
+
+static inline void init_MUTEX_LOCKED (struct semaphore *sem)
+{
+	sema_init(sem, 0);
+}
+
+extern void __down(struct semaphore * sem);
+extern int  __down_interruptible(struct semaphore * sem);
+extern void __up(struct semaphore * sem);
+
+static inline void down(struct semaphore * sem)
+{
+	might_sleep();
+
+	/*
+	 * Try to get the semaphore, take the slow path if we fail.
+	 */
+	if (unlikely(atomic_dec_return(&sem->count) < 0))
+		__down(sem);
+}
+
+static inline int down_interruptible(struct semaphore * sem)
+{
+	int ret = 0;
+
+	might_sleep();
+
+	if (unlikely(atomic_dec_return(&sem->count) < 0))
+		ret = __down_interruptible(sem);
+	return ret;
+}
+
+static inline int down_trylock(struct semaphore * sem)
+{
+	return atomic_dec_if_positive(&sem->count) < 0;
+}
+
+static inline void up(struct semaphore * sem)
+{
+	if (unlikely(atomic_inc_return(&sem->count) <= 0))
+		__up(sem);
+}
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_POWERPC_SEMAPHORE_H */
diff --git a/include/asm-ppc/semaphore.h b/include/asm-ppc/semaphore.h
deleted file mode 100644
--- a/include/asm-ppc/semaphore.h
+++ /dev/null
@@ -1,111 +0,0 @@
-#ifndef _PPC_SEMAPHORE_H
-#define _PPC_SEMAPHORE_H
-
-/*
- * Swiped from asm-sparc/semaphore.h and modified
- * -- Cort (cort@cs.nmt.edu)
- *
- * Stole some rw spinlock-based semaphore stuff from asm-alpha/semaphore.h
- * -- Ani Joshi (ajoshi@unixbox.com)
- *
- * Remove spinlock-based RW semaphores; RW semaphore definitions are
- * now in rwsem.h and we use the generic lib/rwsem.c implementation.
- * Rework semaphores to use atomic_dec_if_positive.
- * -- Paul Mackerras (paulus@samba.org)
- */
-
-#ifdef __KERNEL__
-
-#include <asm/atomic.h>
-#include <asm/system.h>
-#include <linux/wait.h>
-#include <linux/rwsem.h>
-
-struct semaphore {
-	/*
-	 * Note that any negative value of count is equivalent to 0,
-	 * but additionally indicates that some process(es) might be
-	 * sleeping on `wait'.
-	 */
-	atomic_t count;
-	wait_queue_head_t wait;
-};
-
-#define __SEMAPHORE_INITIALIZER(name, n)				\
-{									\
-	.count		= ATOMIC_INIT(n),				\
-	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
-}
-
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name, 1)
-
-#define __DECLARE_SEMAPHORE_GENERIC(name, count) \
-	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
-
-#define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name, 1)
-#define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name, 0)
-
-static inline void sema_init (struct semaphore *sem, int val)
-{
-	atomic_set(&sem->count, val);
-	init_waitqueue_head(&sem->wait);
-}
-
-static inline void init_MUTEX (struct semaphore *sem)
-{
-	sema_init(sem, 1);
-}
-
-static inline void init_MUTEX_LOCKED (struct semaphore *sem)
-{
-	sema_init(sem, 0);
-}
-
-extern void __down(struct semaphore * sem);
-extern int  __down_interruptible(struct semaphore * sem);
-extern void __up(struct semaphore * sem);
-
-extern inline void down(struct semaphore * sem)
-{
-	might_sleep();
-
-	/*
-	 * Try to get the semaphore, take the slow path if we fail.
-	 */
-	if (atomic_dec_return(&sem->count) < 0)
-		__down(sem);
-	smp_wmb();
-}
-
-extern inline int down_interruptible(struct semaphore * sem)
-{
-	int ret = 0;
-
-	might_sleep();
-
-	if (atomic_dec_return(&sem->count) < 0)
-		ret = __down_interruptible(sem);
-	smp_wmb();
-	return ret;
-}
-
-extern inline int down_trylock(struct semaphore * sem)
-{
-	int ret;
-
-	ret = atomic_dec_if_positive(&sem->count) < 0;
-	smp_wmb();
-	return ret;
-}
-
-extern inline void up(struct semaphore * sem)
-{
-	smp_wmb();
-	if (atomic_inc_return(&sem->count) <= 0)
-		__up(sem);
-}
-
-#endif /* __KERNEL__ */
-
-#endif /* !(_PPC_SEMAPHORE_H) */
diff --git a/include/asm-ppc64/semaphore.h b/include/asm-ppc64/semaphore.h
deleted file mode 100644
--- a/include/asm-ppc64/semaphore.h
+++ /dev/null
@@ -1,98 +0,0 @@
-#ifndef _PPC64_SEMAPHORE_H
-#define _PPC64_SEMAPHORE_H
-
-/*
- * Remove spinlock-based RW semaphores; RW semaphore definitions are
- * now in rwsem.h and we use the generic lib/rwsem.c implementation.
- * Rework semaphores to use atomic_dec_if_positive.
- * -- Paul Mackerras (paulus@samba.org)
- */
-
-#ifdef __KERNEL__
-
-#include <asm/atomic.h>
-#include <asm/system.h>
-#include <linux/wait.h>
-#include <linux/rwsem.h>
-
-struct semaphore {
-	/*
-	 * Note that any negative value of count is equivalent to 0,
-	 * but additionally indicates that some process(es) might be
-	 * sleeping on `wait'.
-	 */
-	atomic_t count;
-	wait_queue_head_t wait;
-};
-
-#define __SEMAPHORE_INITIALIZER(name, n)				\
-{									\
-	.count		= ATOMIC_INIT(n),				\
-	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
-}
-
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name, 1)
-
-#define __DECLARE_SEMAPHORE_GENERIC(name, count) \
-	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
-
-#define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name, 1)
-#define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name, 0)
-
-static inline void sema_init (struct semaphore *sem, int val)
-{
-	atomic_set(&sem->count, val);
-	init_waitqueue_head(&sem->wait);
-}
-
-static inline void init_MUTEX (struct semaphore *sem)
-{
-	sema_init(sem, 1);
-}
-
-static inline void init_MUTEX_LOCKED (struct semaphore *sem)
-{
-	sema_init(sem, 0);
-}
-
-extern void __down(struct semaphore * sem);
-extern int  __down_interruptible(struct semaphore * sem);
-extern void __up(struct semaphore * sem);
-
-static inline void down(struct semaphore * sem)
-{
-	might_sleep();
-
-	/*
-	 * Try to get the semaphore, take the slow path if we fail.
-	 */
-	if (unlikely(atomic_dec_return(&sem->count) < 0))
-		__down(sem);
-}
-
-static inline int down_interruptible(struct semaphore * sem)
-{
-	int ret = 0;
-
-	might_sleep();
-
-	if (unlikely(atomic_dec_return(&sem->count) < 0))
-		ret = __down_interruptible(sem);
-	return ret;
-}
-
-static inline int down_trylock(struct semaphore * sem)
-{
-	return atomic_dec_if_positive(&sem->count) < 0;
-}
-
-static inline void up(struct semaphore * sem)
-{
-	if (unlikely(atomic_inc_return(&sem->count) <= 0))
-		__up(sem);
-}
-
-#endif /* __KERNEL__ */
-
-#endif /* !(_PPC64_SEMAPHORE_H) */
