Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t7x8p5mlzzDvP3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 16:14:02 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA25DS1X144299
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 01:14:00 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26f740km20-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Nov 2016 01:14:00 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Wed, 2 Nov 2016 15:13:57 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 316E52BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 16:13:54 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA25DsHg3670408
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 16:13:54 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA25DqxK008062
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 16:13:54 +1100
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, x86@kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
 will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com,
 pbonzini@redhat.com, bsingharora@gmail.com, boqun.feng@gmail.com,
 borntraeger@de.ibm.com, rkrcmar@redhat.com, David.Laight@ACULAB.COM,
 dave@stgolabs.net, konrad.wilk@oracle.com,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v7 06/11] x86,
 paravirt: Add interface to support kvm/xen vcpu preempted check
Date: Wed,  2 Nov 2016 05:08:33 -0400
In-Reply-To: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Message-Id: <1478077718-37424-7-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is to fix some lock holder preemption issues. Some other locks
implementation do a spin loop before acquiring the lock itself.
Currently kernel has an interface of bool vcpu_is_preempted(int cpu). It
takes the cpu as parameter and return true if the cpu is preempted.
Then kernel can break the spin loops upon the retval of
vcpu_is_preempted.

As kernel has used this interface, So lets support it.

To deal with kernel and kvm/xen, add vcpu_is_preempted into struct
pv_lock_ops.

Then kvm or xen could provide their own implementation to support
vcpu_is_preempted.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/paravirt_types.h | 2 ++
 arch/x86/include/asm/spinlock.h       | 8 ++++++++
 arch/x86/kernel/paravirt-spinlocks.c  | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 0f400c0..38c3bb7 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -310,6 +310,8 @@ struct pv_lock_ops {
 
 	void (*wait)(u8 *ptr, u8 val);
 	void (*kick)(int cpu);
+
+	bool (*vcpu_is_preempted)(int cpu);
 };
 
 /* This contains all the paravirt structures: we get a convenient
diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index 921bea7..0526f59 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -26,6 +26,14 @@
 extern struct static_key paravirt_ticketlocks_enabled;
 static __always_inline bool static_key_false(struct static_key *key);
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+#define vcpu_is_preempted vcpu_is_preempted
+static inline bool vcpu_is_preempted(int cpu)
+{
+	return pv_lock_ops.vcpu_is_preempted(cpu);
+}
+#endif
+
 #include <asm/qspinlock.h>
 
 /*
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index 2c55a00..2f204dd 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -21,12 +21,18 @@ bool pv_is_native_spin_unlock(void)
 		__raw_callee_save___native_queued_spin_unlock;
 }
 
+static bool native_vcpu_is_preempted(int cpu)
+{
+	return 0;
+}
+
 struct pv_lock_ops pv_lock_ops = {
 #ifdef CONFIG_SMP
 	.queued_spin_lock_slowpath = native_queued_spin_lock_slowpath,
 	.queued_spin_unlock = PV_CALLEE_SAVE(__native_queued_spin_unlock),
 	.wait = paravirt_nop,
 	.kick = paravirt_nop,
+	.vcpu_is_preempted = native_vcpu_is_preempted,
 #endif /* SMP */
 };
 EXPORT_SYMBOL(pv_lock_ops);
-- 
2.4.11
