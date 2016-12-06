Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tY2B03XNtzDvk7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 00:13:12 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB6D5bPJ102501
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 08:13:10 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 275w5hb8ct-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Dec 2016 08:13:10 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Tue, 6 Dec 2016 23:13:08 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 66CFA2CE805F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 00:13:05 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB6DD5iQ4063530
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Dec 2016 00:13:05 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB6DD4C9000527
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Dec 2016 00:13:05 +1100
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 longman@redhat.com, xinhui.pan@linux.vnet.ibm.com,
 virtualization@lists.linux-foundation.org, boqun.feng@gmail.com
Subject: [PATCH v9 4/6] powerpc/pv-qspinlock: powerpc support pv-qspinlock
Date: Tue,  6 Dec 2016 13:09:25 -0500
In-Reply-To: <1481047767-60255-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1481047767-60255-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Message-Id: <1481047767-60255-5-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The default pv-qspinlock uses qspinlock(native version of pv-qspinlock).
pv_lock initialization should be done in bootstage with irq disabled.
And if we run as a guest with powerKVM/pHyp shared_processor mode,
restore pv_lock_ops callbacks to pv-qspinlock(pv version) which makes
full use of virtualization.

There is a hash table, we store cpu number into it and the key is lock.
So everytime pv_wait can know who is the lock holder by searching the
lock. Also store the lock in a per_cpu struct, and remove it when we own
the lock. Then pv_wait can know which lock we are spinning on. But the
cpu in the hash table might not be the correct lock holder, as for
performace issue, we does not take care of hash conflict.

Also introduce spin_lock_holder, which tells who owns the lock now.
currently the only user is spin_unlock_wait.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/qspinlock.h               |  29 +++-
 arch/powerpc/include/asm/qspinlock_paravirt.h      |  36 +++++
 .../powerpc/include/asm/qspinlock_paravirt_types.h |  13 ++
 arch/powerpc/kernel/paravirt.c                     | 153 +++++++++++++++++++++
 arch/powerpc/lib/locks.c                           |   8 +-
 arch/powerpc/platforms/pseries/setup.c             |   5 +
 6 files changed, 241 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt_types.h
 create mode 100644 arch/powerpc/kernel/paravirt.c

diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
index 4c89256..8fd6349 100644
--- a/arch/powerpc/include/asm/qspinlock.h
+++ b/arch/powerpc/include/asm/qspinlock.h
@@ -15,7 +15,7 @@ static inline u8 *__qspinlock_lock_byte(struct qspinlock *lock)
 	return (u8 *)lock + 3 * IS_BUILTIN(CONFIG_CPU_BIG_ENDIAN);
 }
 
-static inline void queued_spin_unlock(struct qspinlock *lock)
+static inline void native_queued_spin_unlock(struct qspinlock *lock)
 {
 	/* release semantics is required */
 	smp_store_release(__qspinlock_lock_byte(lock), 0);
@@ -27,6 +27,33 @@ static inline int queued_spin_is_locked(struct qspinlock *lock)
 	return atomic_read(&lock->val);
 }
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+#include <asm/qspinlock_paravirt.h>
+/*
+ * try to know who is the lock holder, however it is not always true
+ * Return:
+ * -1, we did not know the lock holder.
+ * other value, likely is the lock holder.
+ */
+extern int spin_lock_holder(void *lock);
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
+#define spin_lock_holder(l) (-1)
+static inline void queued_spin_unlock(struct qspinlock *lock)
+{
+	native_queued_spin_unlock(lock);
+}
+#endif
+
 #include <asm-generic/qspinlock.h>
 
 /* we need override it as ppc has io_sync stuff */
diff --git a/arch/powerpc/include/asm/qspinlock_paravirt.h b/arch/powerpc/include/asm/qspinlock_paravirt.h
new file mode 100644
index 0000000..d87cda0
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
+	pv_lock_op.wait(ptr, val);
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
index 0000000..83611ed
--- /dev/null
+++ b/arch/powerpc/include/asm/qspinlock_paravirt_types.h
@@ -0,0 +1,13 @@
+#ifndef _ASM_QSPINLOCK_PARAVIRT_TYPES_H
+#define _ASM_QSPINLOCK_PARAVIRT_TYPES_H
+
+struct pv_lock_ops {
+	void (*lock)(struct qspinlock *lock, u32 val);
+	void (*unlock)(struct qspinlock *lock);
+	void (*wait)(u8 *ptr, u8 val);
+	void (*kick)(int cpu);
+};
+
+extern struct pv_lock_ops pv_lock_op;
+
+#endif
diff --git a/arch/powerpc/kernel/paravirt.c b/arch/powerpc/kernel/paravirt.c
new file mode 100644
index 0000000..e697b17
--- /dev/null
+++ b/arch/powerpc/kernel/paravirt.c
@@ -0,0 +1,153 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+#include <linux/hash.h>
+#include <linux/bootmem.h>
+
+/* +2 here is to make sure there is not many conflict*/
+#define NUM_LOCK_CPU_ENTRY_SHIFT (order_base_2(NR_CPUS) + 2)
+#define NUM_LOCK_CPU_ENTRY (1 << NUM_LOCK_CPU_ENTRY_SHIFT)
+/* we can only spin on 4 locks at same time on same cpu*/
+#define NUM_LOCKS_PER_CPU 4
+
+static u16 *hash_lock_cpu_ptr;
+
+struct locks_on_cpu {
+	void *l[NUM_LOCKS_PER_CPU];
+	int count;
+};
+
+static DEFINE_PER_CPU(struct locks_on_cpu, node);
+
+static u16 *hash(void *l)
+{
+	int val = hash_ptr(l, NUM_LOCK_CPU_ENTRY_SHIFT);
+
+	return &hash_lock_cpu_ptr[val];
+}
+
+static void __init init_hash(void)
+{
+	int size = NUM_LOCK_CPU_ENTRY * sizeof(*hash_lock_cpu_ptr);
+
+	hash_lock_cpu_ptr = memblock_virt_alloc(size, 0);
+	memset(hash_lock_cpu_ptr, 0, size);
+}
+
+#define lock_get_holder(l)	\
+		((int)(*hash(l) - 1))
+
+#define lock_set_holder(l)	\
+		(*hash(l) = raw_smp_processor_id() + 1)
+
+int spin_lock_holder(void *lock)
+{
+	/* we might run on PowerNV, which has no hash table ptr*/
+	if (hash_lock_cpu_ptr)
+		return lock_get_holder(lock);
+	return -1;
+}
+EXPORT_SYMBOL(spin_lock_holder);
+
+static void *this_cpu_lock(void)
+{
+	struct locks_on_cpu *this_node = this_cpu_ptr(&node);
+	int i = this_node->count - 1;
+
+	return this_node->l[i];
+}
+
+static void cpu_save_lock(void *l)
+{
+	struct locks_on_cpu *this_node = this_cpu_ptr(&node);
+	int i = this_node->count++;
+
+	this_node->l[i] = l;
+}
+
+static void cpu_remove_lock(void *l)
+{
+	__this_cpu_dec(node.count);
+}
+
+static void __native_queued_spin_unlock(struct qspinlock *lock)
+{
+	native_queued_spin_unlock(lock);
+}
+
+static void __pv_lock(struct qspinlock *lock, u32 val)
+{
+	/*
+	 * save the lock we are spinning on
+	 * pv_wait need know this lock
+	 */
+	cpu_save_lock(lock);
+
+	__pv_queued_spin_lock_slowpath(lock, val);
+
+	/* as we win the lock, remove it*/
+	cpu_remove_lock(lock);
+
+	/*
+	 * let other spinner know who is the lock holder
+	 * we does not need to unset lock holder in unlock()
+	 */
+	lock_set_holder(lock);
+}
+
+static void __pv_wait(u8 *ptr, u8 val)
+{
+	void *l = this_cpu_lock();
+	int cpu;
+	int always_confer = !in_interrupt();
+
+	while (READ_ONCE(*ptr) == val) {
+		HMT_low();
+		/*
+		 * the lock might be unlocked once and locked again
+		 */
+		cpu = lock_get_holder(l);
+
+		/*
+		 * the default behavior of __spin_yield_cpu is yielding
+		 * our cpu slices to target vcpu or lpar(pHyp or KVM).
+		 * consider the latency of hcall itself and the priority of
+		 * current task, we can do a optimisation.
+		 * IOW, if we are in interrupt, and the target vcpu is running
+		 * we do not yield ourself to lpar.
+		 */
+		__spin_yield_cpu(cpu, always_confer);
+	}
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
+	.wait = NULL,
+	.kick = NULL,
+};
+EXPORT_SYMBOL(pv_lock_op);
+
+void __init pv_lock_init(void)
+{
+	if (SHARED_PROCESSOR) {
+		init_hash();
+		__pv_init_lock_hash();
+		pv_lock_op.lock = __pv_lock;
+		pv_lock_op.unlock = __pv_queued_spin_unlock;
+		pv_lock_op.wait = __pv_wait;
+		pv_lock_op.kick = __pv_kick;
+	}
+}
diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
index dff0bfa..b50c16a 100644
--- a/arch/powerpc/lib/locks.c
+++ b/arch/powerpc/lib/locks.c
@@ -180,8 +180,12 @@ void queued_spin_unlock_wait(struct qspinlock *lock)
 	 * smp_mb() before, we guarantee that all the memory accesses before
 	 * unlock_wait() must be observed by the next lock critical section.
 	 */
-	while (atomic_read(&lock->val) & _Q_LOCKED_MASK)
-		cpu_relax();
+	while (atomic_read(&lock->val) & _Q_LOCKED_MASK) {
+		HMT_low();
+		if (SHARED_PROCESSOR)
+			__spin_yield_cpu(spin_lock_holder(lock), 0);
+	}
+	HMT_medium();
 done:
 	smp_mb();
 }
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 97aa3f3..ca61ead 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -487,6 +487,11 @@ static void __init pSeries_setup_arch(void)
 	}
 
 	ppc_md.pcibios_root_bridge_prepare = pseries_root_bridge_prepare;
+
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+	pv_lock_init();
+#endif
+
 }
 
 static int __init pSeries_init_panel(void)
-- 
2.4.11
