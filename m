Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwbLh49khzDqCM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 22:12:44 +1000 (AEST)
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Thu, 28 Apr 2016 17:42:29 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 593F7DA8C0B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 16:27:40 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3SAteup3277034
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 16:25:40 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3SAtaWQ002721
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 16:25:40 +0530
Message-ID: <5721EC0E.8040506@linux.vnet.ibm.com>
Date: Thu, 28 Apr 2016 18:55:10 +0800
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
CC: "'Peter Zijlstra (Intel)\"" <peterz@infradead.org>,
 Waiman Long <waiman.long@hpe.com>, Boqun Feng <boqun.feng@gmail.com>,
 Paul Mackerras <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, jeremy@goop.org,
 chrisw@sous-sol.org, akataria@vmware.com, rusty@rustcorp.com.au,
 gwshan@linux.vnet.ibm.com, adam.buchbinder@gmail.com,
 tglx@linutronix.de, marc.zyngier@arm.com
Subject: [PATCH resend] powerpc: enable qspinlock and its virtualization
 support
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

This patch aims to enable qspinlock on PPC. And on pseries platform, it also support
paravirt qspinlock.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/qspinlock.h               | 37 +++++++++++++++
 arch/powerpc/include/asm/qspinlock_paravirt.h      | 36 +++++++++++++++
 .../powerpc/include/asm/qspinlock_paravirt_types.h | 13 ++++++
 arch/powerpc/include/asm/spinlock.h                | 31 ++++++++-----
 arch/powerpc/include/asm/spinlock_types.h          |  4 ++
 arch/powerpc/kernel/paravirt.c                     | 52 ++++++++++++++++++++++
 arch/powerpc/lib/locks.c                           | 32 +++++++++++++
 arch/powerpc/platforms/pseries/setup.c             |  5 +++
 8 files changed, 198 insertions(+), 12 deletions(-)
 create mode 100644 arch/powerpc/include/asm/qspinlock.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt_types.h
 create mode 100644 arch/powerpc/kernel/paravirt.c

diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
new file mode 100644
index 0000000..d4e4dc3
--- /dev/null
+++ b/arch/powerpc/include/asm/qspinlock.h
@@ -0,0 +1,37 @@
+#ifndef _ASM_POWERPC_QSPINLOCK_H
+#define _ASM_POWERPC_QSPINLOCK_H
+
+#include <asm-generic/qspinlock_types.h>
+
+#define SPIN_THRESHOLD	(1 << 15)
+#define	queued_spin_unlock queued_spin_unlock
+
+static inline void native_queued_spin_unlock(struct qspinlock *lock)
+{
+	/* no load/store can be across the unlock()*/
+	smp_store_release((u8 *)lock, 0);
+}
+
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+
+#include <asm/qspinlock_paravirt.h>
+
+static inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+{
+	pv_queued_spin_lock(lock, val);
+}
+
+static inline void queued_spin_unlock(struct qspinlock *lock)
+{
+	pv_queued_spin_unlock(lock);
+}
+#else
+static inline void queued_spin_unlock(struct qspinlock *lock)
+{
+	native_queued_spin_unlock(lock);
+}
+#endif
+
+#include <asm-generic/qspinlock.h>
+
+#endif /* _ASM_POWERPC_QSPINLOCK_H */
diff --git a/arch/powerpc/include/asm/qspinlock_paravirt.h b/arch/powerpc/include/asm/qspinlock_paravirt.h
new file mode 100644
index 0000000..86e81c3
--- /dev/null
+++ b/arch/powerpc/include/asm/qspinlock_paravirt.h
@@ -0,0 +1,36 @@
+#ifndef CONFIG_PARAVIRT_SPINLOCKS
+#error "do not include this file"
+#endif
+
+#ifndef _ASM_QSPINLOCK_PARAVIRT_H
+#define _ASM_QSPINLOCK_PARAVIRT_H
+
+#include  <asm/qspinlock_paravirt_types.h>
+
+extern void pv_lock_init(void);
+extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+extern void __pv_init_lock_hash(void);
+extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+extern void __pv_queued_spin_unlock(struct qspinlock *lock);
+
+static inline void pv_queued_spin_lock(struct qspinlock *lock, u32 val)
+{
+	pv_lock_op.lock(lock, val);
+}
+
+static inline void pv_queued_spin_unlock(struct qspinlock *lock)
+{
+	pv_lock_op.unlock(lock);
+}
+
+static inline void pv_wait(u8 *ptr, u8 val)
+{
+	pv_lock_op.wait(ptr, val, -1);
+}
+
+static inline void pv_kick(int cpu)
+{
+	pv_lock_op.kick(cpu);
+}
+
+#endif
diff --git a/arch/powerpc/include/asm/qspinlock_paravirt_types.h b/arch/powerpc/include/asm/qspinlock_paravirt_types.h
new file mode 100644
index 0000000..e1fdeb0
--- /dev/null
+++ b/arch/powerpc/include/asm/qspinlock_paravirt_types.h
@@ -0,0 +1,13 @@
+#ifndef _ASM_QSPINLOCK_PARAVIRT_TYPES_H
+#define _ASM_QSPINLOCK_PARAVIRT_TYPES_H
+
+struct pv_lock_ops {
+	void (*lock)(struct qspinlock *lock, u32 val);
+	void (*unlock)(struct qspinlock *lock);
+	void (*wait)(u8 *ptr, u8 val, int cpu);
+	void (*kick)(int cpu);
+};
+
+extern struct pv_lock_ops pv_lock_op;
+
+#endif
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 523673d..3b65372 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -52,6 +52,24 @@
 #define SYNC_IO
 #endif
 
+#if defined(CONFIG_PPC_SPLPAR)
+/* We only yield to the hypervisor if we are in shared processor mode */
+#define SHARED_PROCESSOR (lppaca_shared_proc(local_paca->lppaca_ptr))
+extern void __spin_yield(arch_spinlock_t *lock);
+extern void __spin_yield_cpu(int cpu);
+extern void __spin_wake_cpu(int cpu);
+extern void __rw_yield(arch_rwlock_t *lock);
+#else /* SPLPAR */
+#define __spin_yield(x)	barrier()
+#define __spin_yield_cpu(x) barrier()
+#define __spin_wake_cpu(x) barrier()
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
@@ -106,18 +124,6 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
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
@@ -169,6 +175,7 @@ extern void arch_spin_unlock_wait(arch_spinlock_t *lock);
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
diff --git a/arch/powerpc/kernel/paravirt.c b/arch/powerpc/kernel/paravirt.c
new file mode 100644
index 0000000..355c9fb
--- /dev/null
+++ b/arch/powerpc/kernel/paravirt.c
@@ -0,0 +1,52 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/spinlock.h>
+
+static void __native_queued_spin_unlock(struct qspinlock *lock)
+{
+	native_queued_spin_unlock(lock);
+}
+
+static void __native_wait(u8 *ptr, u8 val, int cpu)
+{
+}
+
+static void __native_kick(int cpu)
+{
+}
+
+static void __pv_wait(u8 *ptr, u8 val, int cpu)
+{
+	HMT_low();
+	__spin_yield_cpu(cpu);
+	HMT_medium();
+}
+
+static void __pv_kick(int cpu)
+{
+	__spin_wake_cpu(cpu);
+}
+
+struct pv_lock_ops pv_lock_op = {
+	.lock = native_queued_spin_lock_slowpath,
+	.unlock = __native_queued_spin_unlock,
+	.wait = __native_wait,
+	.kick = __native_kick,
+};
+EXPORT_SYMBOL(pv_lock_op);
+
+void __init pv_lock_init(void)
+{
+	if (SHARED_PROCESSOR) {
+		__pv_init_lock_hash();
+		pv_lock_op.lock = __pv_queued_spin_lock_slowpath;
+		pv_lock_op.unlock = __pv_queued_spin_unlock;
+		pv_lock_op.wait = __pv_wait;
+		pv_lock_op.kick = __pv_kick;
+	}
+}
diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
index f7deebd..6e9d3bb 100644
--- a/arch/powerpc/lib/locks.c
+++ b/arch/powerpc/lib/locks.c
@@ -23,6 +23,35 @@
 #include <asm/hvcall.h>
 #include <asm/smp.h>
 
+void __spin_yield_cpu(int cpu)
+{
+	unsigned int holder_cpu = cpu, yield_count;
+
+	if (cpu == -1) {
+		plpar_hcall_norets(H_CEDE);
+		return;
+	}
+	BUG_ON(holder_cpu >= nr_cpu_ids);
+	yield_count = be32_to_cpu(lppaca_of(holder_cpu).yield_count);
+	if ((yield_count & 1) == 0)
+		return;		/* virtual cpu is currently running */
+	rmb();
+	plpar_hcall_norets(H_CONFER,
+		get_hard_smp_processor_id(holder_cpu), yield_count);
+}
+EXPORT_SYMBOL_GPL(__spin_yield_cpu);
+
+void __spin_wake_cpu(int cpu)
+{
+	unsigned int holder_cpu = cpu;
+
+	BUG_ON(holder_cpu >= nr_cpu_ids);
+	plpar_hcall_norets(H_PROD,
+		get_hard_smp_processor_id(holder_cpu));
+}
+EXPORT_SYMBOL_GPL(__spin_wake_cpu);
+
+#ifndef CONFIG_QUEUED_SPINLOCKS
 void __spin_yield(arch_spinlock_t *lock)
 {
 	unsigned int lock_value, holder_cpu, yield_count;
@@ -42,6 +71,7 @@ void __spin_yield(arch_spinlock_t *lock)
 		get_hard_smp_processor_id(holder_cpu), yield_count);
 }
 EXPORT_SYMBOL_GPL(__spin_yield);
+#endif
 
 /*
  * Waiting for a read lock or a write lock on a rwlock...
@@ -69,6 +99,7 @@ void __rw_yield(arch_rwlock_t *rw)
 }
 #endif
 
+#ifndef CONFIG_QUEUED_SPINLOCKS
 void arch_spin_unlock_wait(arch_spinlock_t *lock)
 {
 	smp_mb();
@@ -84,3 +115,4 @@ void arch_spin_unlock_wait(arch_spinlock_t *lock)
 }
 
 EXPORT_SYMBOL(arch_spin_unlock_wait);
+#endif
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 6e944fc..c9f056e 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -547,6 +547,11 @@ static void __init pSeries_setup_arch(void)
 				"%ld\n", rc);
 		}
 	}
+
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+	pv_lock_init();
+#endif
+
 }
 
 static int __init pSeries_init_panel(void)
-- 2.4.3
