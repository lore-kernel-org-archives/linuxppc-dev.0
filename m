Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rF4xn5T0HzDqW9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 18:21:49 +1000 (AEST)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Wed, 25 May 2016 18:21:49 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D12B92CE805E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 18:21:30 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4P8LJGL28508354
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 18:21:22 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4P8K7Z0015005
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 18:20:08 +1000
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 jeremy@goop.org, chrisw@sous-sol.org, akataria@vmware.com,
 rusty@rustcorp.com.au, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v3 1/6] qspinlock: powerpc support qspinlock
Date: Wed, 25 May 2016 16:18:04 +0800
Message-Id: <1464164289-6124-2-git-send-email-xinhui.pan@linux.vnet.ibm.com>
In-Reply-To: <1464164289-6124-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1464164289-6124-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Base code to enable qspinlock on powerpc. this patch add some #ifdef
here and there. Although there is no paravirt related code, we can
successfully build a qspinlock kernel after apply this patch.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/qspinlock.h      | 22 ++++++++++++++++++++++
 arch/powerpc/include/asm/spinlock.h       | 27 +++++++++++++++------------
 arch/powerpc/include/asm/spinlock_types.h |  4 ++++
 arch/powerpc/lib/locks.c                  |  4 ++++
 4 files changed, 45 insertions(+), 12 deletions(-)
 create mode 100644 arch/powerpc/include/asm/qspinlock.h

diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
new file mode 100644
index 0000000..5883954
--- /dev/null
+++ b/arch/powerpc/include/asm/qspinlock.h
@@ -0,0 +1,22 @@
+#ifndef _ASM_POWERPC_QSPINLOCK_H
+#define _ASM_POWERPC_QSPINLOCK_H
+
+#include <asm-generic/qspinlock_types.h>
+
+#define SPIN_THRESHOLD (1 << 15)
+#define queued_spin_unlock queued_spin_unlock
+
+static inline void native_queued_spin_unlock(struct qspinlock *lock)
+{
+	/* no load/store can be across the unlock()*/
+	smp_store_release((u8 *)lock, 0);
+}
+
+static inline void queued_spin_unlock(struct qspinlock *lock)
+{
+	native_queued_spin_unlock(lock);
+}
+
+#include <asm-generic/qspinlock.h>
+
+#endif /* _ASM_POWERPC_QSPINLOCK_H */
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 523673d..4359ee6 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -52,6 +52,20 @@
 #define SYNC_IO
 #endif
 
+#if defined(CONFIG_PPC_SPLPAR)
+/* We only yield to the hypervisor if we are in shared processor mode */
+#define SHARED_PROCESSOR (lppaca_shared_proc(local_paca->lppaca_ptr))
+extern void __spin_yield(arch_spinlock_t *lock);
+extern void __rw_yield(arch_rwlock_t *lock);
+#else /* SPLPAR */
+#define __spin_yield(x)	barrier()
+#define __rw_yield(x)	barrier()
+#define SHARED_PROCESSOR	0
+#endif
+
+#ifdef CONFIG_QUEUED_SPINLOCKS
+#include <asm/qspinlock.h>
+#else
 static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 {
 	return lock.slock == 0;
@@ -106,18 +120,6 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
  * held.  Conveniently, we have a word in the paca that holds this
  * value.
  */
-
-#if defined(CONFIG_PPC_SPLPAR)
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
@@ -169,6 +171,7 @@ extern void arch_spin_unlock_wait(arch_spinlock_t *lock);
 	do { while (arch_spin_is_locked(lock)) cpu_relax(); } while (0)
 #endif
 
+#endif /* !CONFIG_QUEUED_SPINLOCKS */
 /*
  * Read-write spinlocks, allowing multiple readers
  * but only one writer.
diff --git a/arch/powerpc/include/asm/spinlock_types.h b/arch/powerpc/include/asm/spinlock_types.h
index 2351adc..bd7144e 100644
--- a/arch/powerpc/include/asm/spinlock_types.h
+++ b/arch/powerpc/include/asm/spinlock_types.h
@@ -5,11 +5,15 @@
 # error "please don't include this file directly"
 #endif
 
+#ifdef CONFIG_QUEUED_SPINLOCKS
+#include <asm-generic/qspinlock_types.h>
+#else
 typedef struct {
 	volatile unsigned int slock;
 } arch_spinlock_t;
 
 #define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 }
+#endif
 
 typedef struct {
 	volatile signed int lock;
diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
index f7deebd..a9ebd71 100644
--- a/arch/powerpc/lib/locks.c
+++ b/arch/powerpc/lib/locks.c
@@ -23,6 +23,7 @@
 #include <asm/hvcall.h>
 #include <asm/smp.h>
 
+#ifndef CONFIG_QUEUED_SPINLOCKS
 void __spin_yield(arch_spinlock_t *lock)
 {
 	unsigned int lock_value, holder_cpu, yield_count;
@@ -42,6 +43,7 @@ void __spin_yield(arch_spinlock_t *lock)
 		get_hard_smp_processor_id(holder_cpu), yield_count);
 }
 EXPORT_SYMBOL_GPL(__spin_yield);
+#endif
 
 /*
  * Waiting for a read lock or a write lock on a rwlock...
@@ -69,6 +71,7 @@ void __rw_yield(arch_rwlock_t *rw)
 }
 #endif
 
+#ifndef CONFIG_QUEUED_SPINLOCKS
 void arch_spin_unlock_wait(arch_spinlock_t *lock)
 {
 	smp_mb();
@@ -84,3 +87,4 @@ void arch_spin_unlock_wait(arch_spinlock_t *lock)
 }
 
 EXPORT_SYMBOL(arch_spin_unlock_wait);
+#endif
-- 
1.9.1
