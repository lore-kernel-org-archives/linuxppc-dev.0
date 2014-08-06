Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0211.outbound.protection.outlook.com [207.46.163.211])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE8481A0009
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 02:33:54 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH] KVM: PPC: e500mc: Add support for single threaded vcpus on
 e6500 core
Date: Wed, 6 Aug 2014 19:33:28 +0300
Message-ID: <1407342808-15987-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ePAPR represents hardware threads as cpu node properties in device tree.
So with existing QEMU, hardware threads are simply exposed as vcpus with
one hardware thread.

The e6500 core shares TLBs between hardware threads. Without tlb write
conditional instruction, the Linux kernel uses per core mechanisms to
protect against duplicate TLB entries.

The guest is unable to detect real siblings threads, so it can't use a
TLB protection mechanism. An alternative solution is to use the hypervisor
to allocate different lpids to guest's vcpus running simultaneous on real
siblings threads. This patch moves lpid to vcpu level and allocates a pool
of lpids (equal to the number of threads per core) per VM.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 Please rebase this patch before
    [PATCH v3 5/5] KVM: PPC: Book3E: Enable e6500 core
 to proper handle SMP guests.

 arch/powerpc/include/asm/kvm_host.h |  5 ++++
 arch/powerpc/kernel/asm-offsets.c   |  4 +++
 arch/powerpc/kvm/e500_mmu_host.c    | 15 +++++-----
 arch/powerpc/kvm/e500mc.c           | 55 +++++++++++++++++++++++++------------
 4 files changed, 55 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 98d9dd5..1b0bb4a 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -227,7 +227,11 @@ struct kvm_arch_memory_slot {
 };
 
 struct kvm_arch {
+#ifdef CONFIG_KVM_BOOKE_HV
+	unsigned int lpid_pool[2];
+#else
 	unsigned int lpid;
+#endif
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	unsigned long hpt_virt;
 	struct revmap_entry *revmap;
@@ -435,6 +439,7 @@ struct kvm_vcpu_arch {
 	u32 eplc;
 	u32 epsc;
 	u32 oldpir;
+	u32 lpid;
 #endif
 
 #if defined(CONFIG_BOOKE)
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index ab9ae04..5a30b87 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -483,7 +483,11 @@ int main(void)
 	DEFINE(VCPU_SHARED_MAS6, offsetof(struct kvm_vcpu_arch_shared, mas6));
 
 	DEFINE(VCPU_KVM, offsetof(struct kvm_vcpu, kvm));
+#ifdef CONFIG_KVM_BOOKE_HV
+	DEFINE(KVM_LPID, offsetof(struct kvm_vcpu, arch.lpid));
+#else
 	DEFINE(KVM_LPID, offsetof(struct kvm, arch.lpid));
+#endif
 
 	/* book3s */
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index 4150826..a233cc6 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -69,7 +69,7 @@ static inline u32 e500_shadow_mas3_attrib(u32 mas3, int usermode)
  * writing shadow tlb entry to host TLB
  */
 static inline void __write_host_tlbe(struct kvm_book3e_206_tlb_entry *stlbe,
-				     uint32_t mas0)
+				     uint32_t mas0, uint32_t *lpid)
 {
 	unsigned long flags;
 
@@ -80,6 +80,8 @@ static inline void __write_host_tlbe(struct kvm_book3e_206_tlb_entry *stlbe,
 	mtspr(SPRN_MAS3, (u32)stlbe->mas7_3);
 	mtspr(SPRN_MAS7, (u32)(stlbe->mas7_3 >> 32));
 #ifdef CONFIG_KVM_BOOKE_HV
+	/* populate mas8 with latest LPID */
+	stlbe->mas8 = MAS8_TGS | *lpid;
 	mtspr(SPRN_MAS8, stlbe->mas8);
 #endif
 	asm volatile("isync; tlbwe" : : : "memory");
@@ -129,11 +131,12 @@ static inline void write_host_tlbe(struct kvmppc_vcpu_e500 *vcpu_e500,
 
 	if (tlbsel == 0) {
 		mas0 = get_host_mas0(stlbe->mas2);
-		__write_host_tlbe(stlbe, mas0);
+		__write_host_tlbe(stlbe, mas0, &vcpu_e500->vcpu.arch.lpid);
 	} else {
 		__write_host_tlbe(stlbe,
 				  MAS0_TLBSEL(1) |
-				  MAS0_ESEL(to_htlb1_esel(sesel)));
+				  MAS0_ESEL(to_htlb1_esel(sesel)),
+				  &vcpu_e500->vcpu.arch.lpid);
 	}
 }
 
@@ -318,9 +321,7 @@ static void kvmppc_e500_setup_stlbe(
 	stlbe->mas7_3 = ((u64)pfn << PAGE_SHIFT) |
 			e500_shadow_mas3_attrib(gtlbe->mas7_3, pr);
 
-#ifdef CONFIG_KVM_BOOKE_HV
-	stlbe->mas8 = MAS8_TGS | vcpu->kvm->arch.lpid;
-#endif
+	/* Set mas8 when executing tlbwe since LPID can change dynamically */
 }
 
 static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
@@ -632,7 +633,7 @@ int kvmppc_load_last_inst(struct kvm_vcpu *vcpu, enum instruction_type type,
 
 	local_irq_save(flags);
 	mtspr(SPRN_MAS6, (vcpu->arch.pid << MAS6_SPID_SHIFT) | addr_space);
-	mtspr(SPRN_MAS5, MAS5_SGS | vcpu->kvm->arch.lpid);
+	mtspr(SPRN_MAS5, MAS5_SGS | vcpu->arch.lpid);
 	asm volatile("tlbsx 0, %[geaddr]\n" : :
 		     [geaddr] "r" (geaddr));
 	mtspr(SPRN_MAS5, 0);
diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index aa48dc3..c0a0d9d 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -24,6 +24,7 @@
 #include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
 #include <asm/dbell.h>
+#include <asm/cputhreads.h>
 
 #include "booke.h"
 #include "e500.h"
@@ -48,10 +49,11 @@ void kvmppc_set_pending_interrupt(struct kvm_vcpu *vcpu, enum int_class type)
 		return;
 	}
 
-
-	tag = PPC_DBELL_LPID(vcpu->kvm->arch.lpid) | vcpu->vcpu_id;
+	preempt_disable();
+	tag = PPC_DBELL_LPID(vcpu->arch.lpid) | vcpu->vcpu_id;
 	mb();
 	ppc_msgsnd(dbell_type, 0, tag);
+	preempt_enable();
 }
 
 /* gtlbe must not be mapped by more than one host tlb entry */
@@ -60,12 +62,11 @@ void kvmppc_e500_tlbil_one(struct kvmppc_vcpu_e500 *vcpu_e500,
 {
 	unsigned int tid, ts;
 	gva_t eaddr;
-	u32 val, lpid;
+	u32 val;
 	unsigned long flags;
 
 	ts = get_tlb_ts(gtlbe);
 	tid = get_tlb_tid(gtlbe);
-	lpid = vcpu_e500->vcpu.kvm->arch.lpid;
 
 	/* We search the host TLB to invalidate its shadow TLB entry */
 	val = (tid << 16) | ts;
@@ -74,7 +75,7 @@ void kvmppc_e500_tlbil_one(struct kvmppc_vcpu_e500 *vcpu_e500,
 	local_irq_save(flags);
 
 	mtspr(SPRN_MAS6, val);
-	mtspr(SPRN_MAS5, MAS5_SGS | lpid);
+	mtspr(SPRN_MAS5, MAS5_SGS | vcpu_e500->vcpu.arch.lpid);
 
 	asm volatile("tlbsx 0, %[eaddr]\n" : : [eaddr] "r" (eaddr));
 	val = mfspr(SPRN_MAS1);
@@ -95,7 +96,7 @@ void kvmppc_e500_tlbil_all(struct kvmppc_vcpu_e500 *vcpu_e500)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	mtspr(SPRN_MAS5, MAS5_SGS | vcpu_e500->vcpu.kvm->arch.lpid);
+	mtspr(SPRN_MAS5, MAS5_SGS | vcpu_e500->vcpu.arch.lpid);
 	asm volatile("tlbilxlpid");
 	mtspr(SPRN_MAS5, 0);
 	local_irq_restore(flags);
@@ -115,10 +116,21 @@ static DEFINE_PER_CPU(struct kvm_vcpu *[KVMPPC_NR_LPIDS], last_vcpu_of_lpid);
 static void kvmppc_core_vcpu_load_e500mc(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500 = to_e500(vcpu);
+	int lpid_idx = 0;
 
 	kvmppc_booke_vcpu_load(vcpu, cpu);
 
-	mtspr(SPRN_LPID, vcpu->kvm->arch.lpid);
+	/* Get current core's thread index */
+	lpid_idx = mfspr(SPRN_PIR) % threads_per_core;
+	vcpu->arch.lpid = vcpu->kvm->arch.lpid_pool[lpid_idx];
+	vcpu->arch.eplc = EPC_EGS | (vcpu->arch.lpid << EPC_ELPID_SHIFT);
+	vcpu->arch.epsc = vcpu->arch.eplc;
+
+	if (vcpu->arch.oldpir != mfspr(SPRN_PIR))
+		pr_debug("vcpu 0x%p loaded on PID %d, lpid %d\n",
+			 vcpu, smp_processor_id(), (int)vcpu->arch.lpid);
+
+	mtspr(SPRN_LPID, vcpu->arch.lpid);
 	mtspr(SPRN_EPCR, vcpu->arch.shadow_epcr);
 	mtspr(SPRN_GPIR, vcpu->vcpu_id);
 	mtspr(SPRN_MSRP, vcpu->arch.shadow_msrp);
@@ -141,9 +153,9 @@ static void kvmppc_core_vcpu_load_e500mc(struct kvm_vcpu *vcpu, int cpu)
 	mtspr(SPRN_GESR, vcpu->arch.shared->esr);
 
 	if (vcpu->arch.oldpir != mfspr(SPRN_PIR) ||
-	    __get_cpu_var(last_vcpu_of_lpid)[vcpu->kvm->arch.lpid] != vcpu) {
+	    __get_cpu_var(last_vcpu_of_lpid)[vcpu->arch.lpid] != vcpu) {
 		kvmppc_e500_tlbil_all(vcpu_e500);
-		__get_cpu_var(last_vcpu_of_lpid)[vcpu->kvm->arch.lpid] = vcpu;
+		__get_cpu_var(last_vcpu_of_lpid)[vcpu->arch.lpid] = vcpu;
 	}
 }
 
@@ -203,8 +215,6 @@ int kvmppc_core_vcpu_setup(struct kvm_vcpu *vcpu)
 	vcpu->arch.shadow_epcr |= SPRN_EPCR_ICM;
 #endif
 	vcpu->arch.shadow_msrp = MSRP_UCLEP | MSRP_DEP | MSRP_PMMP;
-	vcpu->arch.eplc = EPC_EGS | (vcpu->kvm->arch.lpid << EPC_ELPID_SHIFT);
-	vcpu->arch.epsc = vcpu->arch.eplc;
 
 	vcpu->arch.pvr = mfspr(SPRN_PVR);
 	vcpu_e500->svr = mfspr(SPRN_SVR);
@@ -390,19 +400,30 @@ static void kvmppc_core_vcpu_free_e500mc(struct kvm_vcpu *vcpu)
 
 static int kvmppc_core_init_vm_e500mc(struct kvm *kvm)
 {
-	int lpid;
+	int i, lpid;
 
-	lpid = kvmppc_alloc_lpid();
-	if (lpid < 0)
-		return lpid;
+	/* The lpid pool supports only 2 entries now */
+	if (threads_per_core > 2)
+		return -ENOMEM;
+
+	/* Each VM allocates one LPID per HW thread index */
+	for (i = 0; i < threads_per_core; i++) {
+		lpid = kvmppc_alloc_lpid();
+		if (lpid < 0)
+			return lpid;
+
+		kvm->arch.lpid_pool[i] = lpid;
+	}
 
-	kvm->arch.lpid = lpid;
 	return 0;
 }
 
 static void kvmppc_core_destroy_vm_e500mc(struct kvm *kvm)
 {
-	kvmppc_free_lpid(kvm->arch.lpid);
+	int i;
+
+	for (i = 0; i < threads_per_core; i++)
+		kvmppc_free_lpid(kvm->arch.lpid_pool[i]);
 }
 
 static struct kvmppc_ops kvm_ops_e500mc = {
-- 
1.7.11.7
