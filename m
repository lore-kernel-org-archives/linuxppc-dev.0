Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tY2B61DFgzDvxR
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 00:13:17 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB6D5WuY029924
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 08:13:16 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 275w2uunjm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Dec 2016 08:13:15 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Tue, 6 Dec 2016 23:13:12 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3E6042CE805A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 00:13:11 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB6DDBm15243256
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Dec 2016 00:13:11 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB6DDA1R000630
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Dec 2016 00:13:11 +1100
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 longman@redhat.com, xinhui.pan@linux.vnet.ibm.com,
 virtualization@lists.linux-foundation.org, boqun.feng@gmail.com
Subject: [PATCH v9 6/6] powerpc/pv-qspinlock: Optimise native unlock path
Date: Tue,  6 Dec 2016 13:09:27 -0500
In-Reply-To: <1481047767-60255-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1481047767-60255-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Message-Id: <1481047767-60255-7-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Avoid a function call under native version of qspinlock. On powerNV,
bafore applying this patch, every unlock is expensive. This small
optimizes enhance the performance.

We use static_key with jump_lable which removes unnecessary loads of
lppaca and its stuff.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/qspinlock_paravirt.h | 18 +++++++++++++++++-
 arch/powerpc/kernel/paravirt.c                |  4 ++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/qspinlock_paravirt.h b/arch/powerpc/include/asm/qspinlock_paravirt.h
index d87cda0..8d39446 100644
--- a/arch/powerpc/include/asm/qspinlock_paravirt.h
+++ b/arch/powerpc/include/asm/qspinlock_paravirt.h
@@ -6,12 +6,14 @@
 #define _ASM_QSPINLOCK_PARAVIRT_H
 
 #include  <asm/qspinlock_paravirt_types.h>
+#include  <linux/jump_label.h>
 
 extern void pv_lock_init(void);
 extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 extern void __pv_init_lock_hash(void);
 extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 extern void __pv_queued_spin_unlock(struct qspinlock *lock);
+extern struct static_key_true sharedprocessor_key;
 
 static inline void pv_queued_spin_lock(struct qspinlock *lock, u32 val)
 {
@@ -20,7 +22,21 @@ static inline void pv_queued_spin_lock(struct qspinlock *lock, u32 val)
 
 static inline void pv_queued_spin_unlock(struct qspinlock *lock)
 {
-	pv_lock_op.unlock(lock);
+	/*
+	 * on powerNV and pSeries with jump_label, code will be
+	 *	PowerNV:		pSeries:
+	 *	nop;			b 2f;
+	 *	native unlock		2:
+	 *				pv unlock;
+	 * In this way, we can do unlock quick in native case.
+	 *
+	 * IF jump_label is not enabled, we fall back into
+	 * if condition, IOW, ld && cmp && bne.
+	 */
+	if (static_branch_likely(&sharedprocessor_key))
+		native_queued_spin_unlock(lock);
+	else
+		pv_lock_op.unlock(lock);
 }
 
 static inline void pv_wait(u8 *ptr, u8 val)
diff --git a/arch/powerpc/kernel/paravirt.c b/arch/powerpc/kernel/paravirt.c
index e697b17..a0a000e 100644
--- a/arch/powerpc/kernel/paravirt.c
+++ b/arch/powerpc/kernel/paravirt.c
@@ -140,6 +140,9 @@ struct pv_lock_ops pv_lock_op = {
 };
 EXPORT_SYMBOL(pv_lock_op);
 
+struct static_key_true sharedprocessor_key = STATIC_KEY_TRUE_INIT;
+EXPORT_SYMBOL(sharedprocessor_key);
+
 void __init pv_lock_init(void)
 {
 	if (SHARED_PROCESSOR) {
@@ -149,5 +152,6 @@ void __init pv_lock_init(void)
 		pv_lock_op.unlock = __pv_queued_spin_unlock;
 		pv_lock_op.wait = __pv_wait;
 		pv_lock_op.kick = __pv_kick;
+		static_branch_disable(&sharedprocessor_key);
 	}
 }
-- 
2.4.11
