Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rnx6K18CQzDqwx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 17:09:13 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id i123so12917425pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 00:09:13 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, mpe@ellerman.id.au, paulus@samba.org,
 benh@kernel.crashing.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 agraf@suse.com, rkrcmar@redhat.com, sjitindarsingh@gmail.com
Subject: [PATCH V2 1/5] kvm/ppc/book3s: Move struct kvmppc_vcore from
 kvm_host.h to kvm_book3s.h
Date: Mon, 11 Jul 2016 17:08:28 +1000
Message-Id: <1468220912-22828-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The next commit will introduce a member to the kvmppc_vcore struct which
references MAX_SMT_THREADS which is defined in kvm_book3s_asm.h, however
this file isn't included in kvm_host.h directly. Thus compiling for
certain platforms such as pmac32_defconfig and ppc64e_defconfig with KVM
fails due to MAX_SMT_THREADS not being defined.

Move the struct kvmppc_vcore definition to kvm_book3s.h which explicitly
includes kvm_book3s_asm.h.

---
Change Log:

V1 -> V2:
	- Added patch to series

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/include/asm/kvm_book3s.h | 35 +++++++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/kvm_host.h   | 35 -----------------------------------
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 8f39796..a50c5fe 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -69,6 +69,41 @@ struct hpte_cache {
 	int pagesize;
 };
 
+/*
+ * Struct for a virtual core.
+ * Note: entry_exit_map combines a bitmap of threads that have entered
+ * in the bottom 8 bits and a bitmap of threads that have exited in the
+ * next 8 bits.  This is so that we can atomically set the entry bit
+ * iff the exit map is 0 without taking a lock.
+ */
+struct kvmppc_vcore {
+	int n_runnable;
+	int num_threads;
+	int entry_exit_map;
+	int napping_threads;
+	int first_vcpuid;
+	u16 pcpu;
+	u16 last_cpu;
+	u8 vcore_state;
+	u8 in_guest;
+	struct kvmppc_vcore *master_vcore;
+	struct list_head runnable_threads;
+	struct list_head preempt_list;
+	spinlock_t lock;
+	struct swait_queue_head wq;
+	spinlock_t stoltb_lock;	/* protects stolen_tb and preempt_tb */
+	u64 stolen_tb;
+	u64 preempt_tb;
+	struct kvm_vcpu *runner;
+	struct kvm *kvm;
+	u64 tb_offset;		/* guest timebase - host timebase */
+	ulong lpcr;
+	u32 arch_compat;
+	ulong pcr;
+	ulong dpdes;		/* doorbell state (POWER8) */
+	ulong conferring_threads;
+};
+
 struct kvmppc_vcpu_book3s {
 	struct kvmppc_sid_map sid_map[SID_MAP_NUM];
 	struct {
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index ec35af3..19c6731 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -275,41 +275,6 @@ struct kvm_arch {
 #endif
 };
 
-/*
- * Struct for a virtual core.
- * Note: entry_exit_map combines a bitmap of threads that have entered
- * in the bottom 8 bits and a bitmap of threads that have exited in the
- * next 8 bits.  This is so that we can atomically set the entry bit
- * iff the exit map is 0 without taking a lock.
- */
-struct kvmppc_vcore {
-	int n_runnable;
-	int num_threads;
-	int entry_exit_map;
-	int napping_threads;
-	int first_vcpuid;
-	u16 pcpu;
-	u16 last_cpu;
-	u8 vcore_state;
-	u8 in_guest;
-	struct kvmppc_vcore *master_vcore;
-	struct list_head runnable_threads;
-	struct list_head preempt_list;
-	spinlock_t lock;
-	struct swait_queue_head wq;
-	spinlock_t stoltb_lock;	/* protects stolen_tb and preempt_tb */
-	u64 stolen_tb;
-	u64 preempt_tb;
-	struct kvm_vcpu *runner;
-	struct kvm *kvm;
-	u64 tb_offset;		/* guest timebase - host timebase */
-	ulong lpcr;
-	u32 arch_compat;
-	ulong pcr;
-	ulong dpdes;		/* doorbell state (POWER8) */
-	ulong conferring_threads;
-};
-
 #define VCORE_ENTRY_MAP(vc)	((vc)->entry_exit_map & 0xff)
 #define VCORE_EXIT_MAP(vc)	((vc)->entry_exit_map >> 8)
 #define VCORE_IS_EXITING(vc)	(VCORE_EXIT_MAP(vc) != 0)
-- 
2.5.5
