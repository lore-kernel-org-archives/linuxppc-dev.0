Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rL2hw5HMYzDr1B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 19:57:52 +1000 (AEST)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Thu, 2 Jun 2016 03:27:34 -0600
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 waiman.long@hpe.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v5 4/6] pv-qspinlock: powerpc support pv-qspinlock
Date: Thu,  2 Jun 2016 17:26:28 +0800
Message-Id: <1464859590-5292-6-git-send-email-xinhui.pan@linux.vnet.ibm.com>
In-Reply-To: <1464859590-5292-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1464859590-5292-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As we need let pv-qspinlock-kernel run on all environment which might
have no powervm, we should runtime choose which qspinlock version to
use.

The default pv-qspinlock use native version. pv_lock initialization
should be done in bootstage with irq disabled. And if there is PHYP,
restore pv_lock_ops callbacks to pv version.

There is also a hash table, we store cpu number into it and the key is
lock. So everytime pv_wait can know who is the lock holder by searching
the lock. Also store the lock in a per_cpu struct, and remove it when we
own the lock. pv_wait need know which lock we are spinning on.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/qspinlock.h               |  15 +++
 arch/powerpc/include/asm/qspinlock_paravirt.h      |  38 +++++++
 .../powerpc/include/asm/qspinlock_paravirt_types.h |  13 +++
 arch/powerpc/kernel/paravirt.c                     | 121 +++++++++++++++++++++
 arch/powerpc/platforms/pseries/setup.c             |   5 +
 5 files changed, 192 insertions(+)
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt_types.h
 create mode 100644 arch/powerpc/kernel/paravirt.c

diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
index fc83cd2..61a0d00 100644
--- a/arch/powerpc/include/asm/qspinlock.h
+++ b/arch/powerpc/include/asm/qspinlock.h
@@ -16,10 +16,25 @@ static inline void native_queued_spin_unlock(struct qspinlock *lock)
 	smp_store_release(locked, 0);
 }
 
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
 static inline void queued_spin_unlock(struct qspinlock *lock)
 {
 	native_queued_spin_unlock(lock);
 }
+#endif
 
 #include <asm-generic/qspinlock.h>
 
diff --git a/arch/powerpc/include/asm/qspinlock_paravirt.h b/arch/powerpc/include/asm/qspinlock_paravirt.h
new file mode 100644
index 0000000..cd17a79
--- /dev/null
+++ b/arch/powerpc/include/asm/qspinlock_paravirt.h
@@ -0,0 +1,38 @@
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
+	CLEAR_IO_SYNC;
+	pv_lock_op.lock(lock, val);
+}
+
+static inline void pv_queued_spin_unlock(struct qspinlock *lock)
+{
+	SYNC_IO;
+	pv_lock_op.unlock(lock);
+}
+
+static inline void pv_wait(u8 *ptr, u8 val, int lockcpu)
+{
+	pv_lock_op.wait(ptr, val, lockcpu);
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
diff --git a/arch/powerpc/kernel/paravirt.c b/arch/powerpc/kernel/paravirt.c
new file mode 100644
index 0000000..2e87fa6
--- /dev/null
+++ b/arch/powerpc/kernel/paravirt.c
@@ -0,0 +1,121 @@
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
+#define NUM_LOCK_CPU_ENTRY_SHIFT 16
+#define NUM_LOCK_CPU_ENTRY (1 << NUM_LOCK_CPU_ENTRY_SHIFT)
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
+		((int)*hash(l) - 1)
+
+#define lock_set_holder(l)	\
+		(*hash(l) = raw_smp_processor_id() + 1)
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
+	this_cpu_dec(node.count);
+}
+
+static void __native_queued_spin_unlock(struct qspinlock *lock)
+{
+	native_queued_spin_unlock(lock);
+}
+
+static void __pv_lock(struct qspinlock *lock, u32 val)
+{
+	cpu_save_lock(lock);
+	__pv_queued_spin_lock_slowpath(lock, val);
+	cpu_remove_lock(lock);
+	lock_set_holder(lock);
+}
+
+static void __pv_unlock(struct qspinlock *lock)
+{
+	__pv_queued_spin_unlock(lock);
+}
+
+static void __pv_wait(u8 *ptr, u8 val, int cpu)
+{
+	void *l = this_cpu_lock();
+
+	HMT_low();
+	while (READ_ONCE(*ptr) == val) {
+		cpu = lock_get_holder(l);
+		__spin_yield_cpu(cpu);
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
+		pv_lock_op.unlock = __pv_unlock;
+		pv_lock_op.wait = __pv_wait;
+		pv_lock_op.kick = __pv_kick;
+	}
+}
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 9883bc7..928b338 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -549,6 +549,11 @@ static void __init pSeries_setup_arch(void)
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
-- 
2.4.11
