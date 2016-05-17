Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r88fC5GGMzDqDv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 17:51:15 +1000 (AEST)
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Tue, 17 May 2016 13:21:10 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 073C2E005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 13:24:17 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4H7p2PH29753360
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 13:21:02 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4H7owgb018120
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 13:21:03 +0530
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 waiman.long@hpe.com, mnipxh@163.com, boqun.feng@gmail.com,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v2 4/6] pv-qspinlock: powerpc support pv-qspinlock
Date: Tue, 17 May 2016 15:49:45 +0800
Message-Id: <1463471387-5115-5-git-send-email-xinhui.pan@linux.vnet.ibm.com>
In-Reply-To: <1463471387-5115-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1463471387-5115-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
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
use. The default pv-qspinlock use native version. pv_lock initialization
should be done in bootstage with irq disabled. And if possible, restore
pv_lock_ops callbacks to pv version.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/qspinlock.h               | 17 +++++++++
 arch/powerpc/include/asm/qspinlock_paravirt.h      | 38 +++++++++++++++++++
 .../powerpc/include/asm/qspinlock_paravirt_types.h | 13 +++++++
 arch/powerpc/kernel/paravirt.c                     | 44 ++++++++++++++++++++++
 arch/powerpc/platforms/pseries/setup.c             |  5 +++
 5 files changed, 117 insertions(+)
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt_types.h
 create mode 100644 arch/powerpc/kernel/paravirt.c

diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
index 5883954..4728f6e 100644
--- a/arch/powerpc/include/asm/qspinlock.h
+++ b/arch/powerpc/include/asm/qspinlock.h
@@ -12,10 +12,27 @@ static inline void native_queued_spin_unlock(struct qspinlock *lock)
 	smp_store_release((u8 *)lock, 0);
 }
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+
+#define __ARCH_NEED_PV_HASH_LOOKUP
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
index 0000000..ea56c5f
--- /dev/null
+++ b/arch/powerpc/kernel/paravirt.c
@@ -0,0 +1,44 @@
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
+	.wait = NULL,
+	.kick = NULL,
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
-- 
1.9.1
