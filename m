Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szMLv26DzzDvHq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 17:23:03 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9J6JXPe105350
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 02:23:01 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2660nkp966-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 02:23:01 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Wed, 19 Oct 2016 00:23:00 -0600
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
 will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com,
 pbonzini@redhat.com, bsingharora@gmail.com, boqun.feng@gmail.com,
 borntraeger@de.ibm.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v4 5/5] x86, kvm: support vcpu preempted check
Date: Wed, 19 Oct 2016 06:20:16 -0400
In-Reply-To: <1476872416-42752-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1476872416-42752-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Message-Id: <1476872416-42752-6-git-send-email-xinhui.pan@linux.vnet.ibm.com>
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
takes the cpu as parameter and return true if the cpu is preempted.  Then
kernel can break the spin loops upon on the retval of vcpu_is_preempted.

As kernel has used this interface, So lets support it.

We use one field of struct kvm_steal_time to indicate that if one vcpu
is running or not.

unix benchmark result:
host:  kernel 4.8.1, i5-4570, 4 cpus
guest: kernel 4.8.1, 8 vcpus

	test-case			after-patch	  before-patch
Execl Throughput                       |    18307.9 lps  |    11701.6 lps 
File Copy 1024 bufsize 2000 maxblocks  |  1352407.3 KBps |   790418.9 KBps
File Copy 256 bufsize 500 maxblocks    |   367555.6 KBps |   222867.7 KBps
File Copy 4096 bufsize 8000 maxblocks  |  3675649.7 KBps |  1780614.4 KBps
Pipe Throughput                        | 11872208.7 lps  | 11855628.9 lps 
Pipe-based Context Switching           |  1495126.5 lps  |  1490533.9 lps 
Process Creation                       |    29881.2 lps  |    28572.8 lps 
Shell Scripts (1 concurrent)           |    23224.3 lpm  |    22607.4 lpm 
Shell Scripts (8 concurrent)           |     3531.4 lpm  |     3211.9 lpm 
System Call Overhead                   | 10385653.0 lps  | 10419979.0 lps 

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/x86/include/asm/paravirt_types.h |  6 ++++++
 arch/x86/include/asm/spinlock.h       |  8 ++++++++
 arch/x86/include/uapi/asm/kvm_para.h  |  3 ++-
 arch/x86/kernel/kvm.c                 | 11 +++++++++++
 arch/x86/kernel/paravirt.c            | 11 +++++++++++
 arch/x86/kvm/x86.c                    | 12 ++++++++++++
 6 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 0f400c0..b1c7937 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -98,6 +98,10 @@ struct pv_time_ops {
 	unsigned long long (*steal_clock)(int cpu);
 };
 
+struct pv_vcpu_ops {
+	bool (*vcpu_is_preempted)(int cpu);
+};
+
 struct pv_cpu_ops {
 	/* hooks for various privileged instructions */
 	unsigned long (*get_debugreg)(int regno);
@@ -318,6 +322,7 @@ struct pv_lock_ops {
 struct paravirt_patch_template {
 	struct pv_init_ops pv_init_ops;
 	struct pv_time_ops pv_time_ops;
+	struct pv_vcpu_ops pv_vcpu_ops;
 	struct pv_cpu_ops pv_cpu_ops;
 	struct pv_irq_ops pv_irq_ops;
 	struct pv_mmu_ops pv_mmu_ops;
@@ -327,6 +332,7 @@ struct paravirt_patch_template {
 extern struct pv_info pv_info;
 extern struct pv_init_ops pv_init_ops;
 extern struct pv_time_ops pv_time_ops;
+extern struct pv_vcpu_ops pv_vcpu_ops;
 extern struct pv_cpu_ops pv_cpu_ops;
 extern struct pv_irq_ops pv_irq_ops;
 extern struct pv_mmu_ops pv_mmu_ops;
diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index 921bea7..52fd942 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -26,6 +26,14 @@
 extern struct static_key paravirt_ticketlocks_enabled;
 static __always_inline bool static_key_false(struct static_key *key);
 
+#ifdef CONFIG_PARAVIRT
+#define vcpu_is_preempted vcpu_is_preempted
+static inline bool vcpu_is_preempted(int cpu)
+{
+	return pv_vcpu_ops.vcpu_is_preempted(cpu);
+}
+#endif
+
 #include <asm/qspinlock.h>
 
 /*
diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index 94dc8ca..e9c12a1 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -45,7 +45,8 @@ struct kvm_steal_time {
 	__u64 steal;
 	__u32 version;
 	__u32 flags;
-	__u32 pad[12];
+	__u32 preempted;
+	__u32 pad[11];
 };
 
 #define KVM_STEAL_ALIGNMENT_BITS 5
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index edbbfc8..0011bef 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -415,6 +415,15 @@ void kvm_disable_steal_time(void)
 	wrmsr(MSR_KVM_STEAL_TIME, 0, 0);
 }
 
+static bool kvm_vcpu_is_preempted(int cpu)
+{
+	struct kvm_steal_time *src;
+
+	src = &per_cpu(steal_time, cpu);
+
+	return !!src->preempted;
+}
+
 #ifdef CONFIG_SMP
 static void __init kvm_smp_prepare_boot_cpu(void)
 {
@@ -488,6 +497,8 @@ void __init kvm_guest_init(void)
 	kvm_guest_cpu_init();
 #endif
 
+	pv_vcpu_ops.vcpu_is_preempted = kvm_vcpu_is_preempted;
+
 	/*
 	 * Hard lockup detection is enabled by default. Disable it, as guests
 	 * can get false positives too easily, for example if the host is
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index bbf3d59..7adb7e9 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -122,6 +122,7 @@ static void *get_call_destination(u8 type)
 	struct paravirt_patch_template tmpl = {
 		.pv_init_ops = pv_init_ops,
 		.pv_time_ops = pv_time_ops,
+		.pv_vcpu_ops = pv_vcpu_ops,
 		.pv_cpu_ops = pv_cpu_ops,
 		.pv_irq_ops = pv_irq_ops,
 		.pv_mmu_ops = pv_mmu_ops,
@@ -203,6 +204,11 @@ static u64 native_steal_clock(int cpu)
 	return 0;
 }
 
+static bool native_vcpu_is_preempted(int cpu)
+{
+	return 0;
+}
+
 /* These are in entry.S */
 extern void native_iret(void);
 extern void native_usergs_sysret64(void);
@@ -312,6 +318,10 @@ struct pv_time_ops pv_time_ops = {
 	.steal_clock = native_steal_clock,
 };
 
+struct pv_vcpu_ops pv_vcpu_ops = {
+	.vcpu_is_preempted = native_vcpu_is_preempted,
+};
+
 __visible struct pv_irq_ops pv_irq_ops = {
 	.save_fl = __PV_IS_CALLEE_SAVE(native_save_fl),
 	.restore_fl = __PV_IS_CALLEE_SAVE(native_restore_fl),
@@ -458,6 +468,7 @@ struct pv_mmu_ops pv_mmu_ops __ro_after_init = {
 };
 
 EXPORT_SYMBOL_GPL(pv_time_ops);
+EXPORT_SYMBOL    (pv_vcpu_ops);
 EXPORT_SYMBOL    (pv_cpu_ops);
 EXPORT_SYMBOL    (pv_mmu_ops);
 EXPORT_SYMBOL_GPL(pv_info);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6c633de..0ffc5aa 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2057,6 +2057,8 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 		&vcpu->arch.st.steal, sizeof(struct kvm_steal_time))))
 		return;
 
+	vcpu->arch.st.steal.preempted = 0;
+
 	if (vcpu->arch.st.steal.version & 1)
 		vcpu->arch.st.steal.version += 1;  /* first time write, random junk */
 
@@ -2812,6 +2814,16 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
+	if (vcpu->arch.st.msr_val & KVM_MSR_ENABLED)
+		if (kvm_read_guest_cached(vcpu->kvm, &vcpu->arch.st.stime,
+					&vcpu->arch.st.steal,
+					sizeof(struct kvm_steal_time)) == 0) {
+			vcpu->arch.st.steal.preempted = 1;
+			kvm_write_guest_cached(vcpu->kvm, &vcpu->arch.st.stime,
+					&vcpu->arch.st.steal,
+					sizeof(struct kvm_steal_time));
+		}
+
 	kvm_x86_ops->vcpu_put(vcpu);
 	kvm_put_guest_fpu(vcpu);
 	vcpu->arch.last_host_tsc = rdtsc();
-- 
2.4.11
