Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x231.google.com (mail-yk0-x231.google.com
 [IPv6:2607:f8b0:4002:c07::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 065231A09DC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 22:33:45 +1100 (AEDT)
Received: by ykfs63 with SMTP id s63so16327538ykf.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 04:33:42 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc: spinlock: refactor codes wrapped by
 PPC_HAS_LOCK_OWNER
Date: Mon, 16 Mar 2015 19:33:16 +0800
Message-Id: <1426505597-1042-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1426505597-1042-1-git-send-email-haokexin@gmail.com>
References: <1426505597-1042-1-git-send-email-haokexin@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move all of them to one place. No function change.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/include/asm/spinlock.h | 71 ++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 41 deletions(-)

diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 38f40ea63a8c..cbc9511df409 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -30,6 +30,20 @@
 
 #define smp_mb__after_unlock_lock()	smp_mb()  /* Full ordering for lock. */
 
+/*
+ * On a system with shared processors (that is, where a physical
+ * processor is multiplexed between several virtual processors),
+ * there is no point spinning on a lock if the holder of the lock
+ * isn't currently scheduled on a physical processor.  Instead
+ * we detect this situation and ask the hypervisor to give the
+ * rest of our timeslice to the lock holder.
+ *
+ * So that we can tell which virtual processor is holding a lock,
+ * we put 0x80000000 | smp_processor_id() in the lock when it is
+ * held.  Conveniently, we have a word in the paca that holds this
+ * value.
+ */
+
 #ifdef CONFIG_PPC_HAS_LOCK_OWNER
 /* use 0x800000yy when locked, where yy == CPU number */
 #ifdef __BIG_ENDIAN__
@@ -37,9 +51,22 @@
 #else
 #define LOCK_TOKEN	(*(u32 *)(&get_paca()->paca_index))
 #endif
-#else
-#define LOCK_TOKEN	1
-#endif
+#define WRLOCK_TOKEN	LOCK_TOKEN	/* it's negative */
+
+/* We only yield to the hypervisor if we are in shared processor mode */
+#define SHARED_PROCESSOR (lppaca_shared_proc(local_paca->lppaca_ptr))
+extern void __spin_yield(arch_spinlock_t *lock);
+extern void __rw_yield(arch_rwlock_t *lock);
+extern void arch_spin_unlock_wait(arch_spinlock_t *lock);
+#else /* CONFIG_PPC_HAS_LOCK_OWNER */
+#define LOCK_TOKEN		1
+#define WRLOCK_TOKEN		(-1)
+#define SHARED_PROCESSOR	0
+#define __spin_yield(x)		barrier()
+#define __rw_yield(x)		barrier()
+#define arch_spin_unlock_wait(lock) \
+	do { while (arch_spin_is_locked(lock)) cpu_relax(); } while (0)
+#endif /* CONFIG_PPC_HAS_LOCK_OWNER */
 
 #if defined(CONFIG_PPC64) && defined(CONFIG_SMP)
 #define CLEAR_IO_SYNC	(get_paca()->io_sync = 0)
@@ -95,31 +122,6 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
 	return __arch_spin_trylock(lock) == 0;
 }
 
-/*
- * On a system with shared processors (that is, where a physical
- * processor is multiplexed between several virtual processors),
- * there is no point spinning on a lock if the holder of the lock
- * isn't currently scheduled on a physical processor.  Instead
- * we detect this situation and ask the hypervisor to give the
- * rest of our timeslice to the lock holder.
- *
- * So that we can tell which virtual processor is holding a lock,
- * we put 0x80000000 | smp_processor_id() in the lock when it is
- * held.  Conveniently, we have a word in the paca that holds this
- * value.
- */
-
-#if defined(CONFIG_PPC_HAS_LOCK_OWNER)
-/* We only yield to the hypervisor if we are in shared processor mode */
-#define SHARED_PROCESSOR (lppaca_shared_proc(local_paca->lppaca_ptr))
-extern void __spin_yield(arch_spinlock_t *lock);
-extern void __rw_yield(arch_rwlock_t *lock);
-#else /* SPLPAR */
-#define __spin_yield(x)	barrier()
-#define __rw_yield(x)	barrier()
-#define SHARED_PROCESSOR	0
-#endif
-
 static inline void arch_spin_lock(arch_spinlock_t *lock)
 {
 	CLEAR_IO_SYNC;
@@ -164,13 +166,6 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
 	lock->slock = 0;
 }
 
-#ifdef CONFIG_PPC_HAS_LOCK_OWNER
-extern void arch_spin_unlock_wait(arch_spinlock_t *lock);
-#else
-#define arch_spin_unlock_wait(lock) \
-	do { while (arch_spin_is_locked(lock)) cpu_relax(); } while (0)
-#endif
-
 /*
  * Read-write spinlocks, allowing multiple readers
  * but only one writer.
@@ -191,12 +186,6 @@ extern void arch_spin_unlock_wait(arch_spinlock_t *lock);
 #define __DO_SIGN_EXTEND
 #endif
 
-#ifdef CONFIG_PPC_HAS_LOCK_OWNER
-#define WRLOCK_TOKEN		LOCK_TOKEN	/* it's negative */
-#else
-#define WRLOCK_TOKEN		(-1)
-#endif
-
 /*
  * This returns the old value in the lock + 1,
  * so we got a read lock if the return value is > 0.
-- 
2.1.0
