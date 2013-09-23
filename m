Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 36/39] powerpc/kvm/book3s_hv: Add little endian guest support
Date: Mon, 23 Sep 2013 12:05:10 +1000
Message-Id: <1379901913-5945-37-git-send-email-anton@samba.org>
In-Reply-To: <1379901913-5945-1-git-send-email-anton@samba.org>
References: <1379901913-5945-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for the H_SET_MODE hcall so we can select the
endianness of our exceptions.

We create a guest MSR from scratch when delivering exceptions in
a few places and instead of extracing the LPCR[ILE] and inserting
it into MSR_LE each time simply create a new variable intr_msr which
contains the entire MSR to use.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_host.h     |  1 +
 arch/powerpc/kernel/asm-offsets.c       |  1 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c     |  2 +-
 arch/powerpc/kvm/book3s_hv.c            | 44 +++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 15 ++++-------
 5 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 3328353..50f204e 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -605,6 +605,7 @@ struct kvm_vcpu_arch {
 	spinlock_t tbacct_lock;
 	u64 busy_stolen;
 	u64 busy_preempt;
+	unsigned long intr_msr;
 #endif
 };
 
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index d8958be..3967b15 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -490,6 +490,7 @@ int main(void)
 	DEFINE(VCPU_DAR, offsetof(struct kvm_vcpu, arch.shregs.dar));
 	DEFINE(VCPU_VPA, offsetof(struct kvm_vcpu, arch.vpa.pinned_addr));
 	DEFINE(VCPU_VPA_DIRTY, offsetof(struct kvm_vcpu, arch.vpa.dirty));
+	DEFINE(VCPU_INTR_MSR, offsetof(struct kvm_vcpu, arch.intr_msr));
 #endif
 #ifdef CONFIG_PPC_BOOK3S
 	DEFINE(VCPU_VCPUID, offsetof(struct kvm_vcpu, vcpu_id));
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 043eec8..30459bd 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -266,7 +266,7 @@ void kvmppc_mmu_destroy(struct kvm_vcpu *vcpu)
 
 static void kvmppc_mmu_book3s_64_hv_reset_msr(struct kvm_vcpu *vcpu)
 {
-	kvmppc_set_msr(vcpu, MSR_SF | MSR_ME);
+	kvmppc_set_msr(vcpu, vcpu->arch.intr_msr);
 }
 
 /*
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 62a2b5a..c9b90b8 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -503,6 +503,43 @@ static void kvmppc_create_dtl_entry(struct kvm_vcpu *vcpu,
 	vcpu->arch.dtl.dirty = true;
 }
 
+static int kvmppc_h_set_mode(struct kvm_vcpu *vcpu, unsigned long mflags,
+			     unsigned long resource, unsigned long value1,
+			     unsigned long value2)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_vcpu *v;
+	int n;
+
+	if (resource == 4) {
+		if (value1)
+			return H_P3;
+		if (value2)
+			return H_P4;
+
+		switch (mflags) {
+		case 0:
+			kvm->arch.lpcr &= ~LPCR_ILE;
+			kvm_for_each_vcpu(n, v, kvm)
+				v->arch.intr_msr &= ~MSR_LE;
+			kick_all_cpus_sync();
+			return H_SUCCESS;
+
+		case 1:
+			kvm->arch.lpcr |= LPCR_ILE;
+			kvm_for_each_vcpu(n, v, kvm)
+				v->arch.intr_msr |= MSR_LE;
+			kick_all_cpus_sync();
+			return H_SUCCESS;
+
+		default:
+			return H_UNSUPPORTED_FLAG_START;
+		}
+	}
+
+	return H_P2;
+}
+
 int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 {
 	unsigned long req = kvmppc_get_gpr(vcpu, 3);
@@ -557,6 +594,12 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 
 		/* Send the error out to userspace via KVM_RUN */
 		return rc;
+	case H_SET_MODE:
+		ret = kvmppc_h_set_mode(vcpu, kvmppc_get_gpr(vcpu, 4),
+					kvmppc_get_gpr(vcpu, 5),
+					kvmppc_get_gpr(vcpu, 6),
+					kvmppc_get_gpr(vcpu, 7));
+		break;
 
 	case H_XIRR:
 	case H_CPPR:
@@ -924,6 +967,7 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 	spin_lock_init(&vcpu->arch.vpa_update_lock);
 	spin_lock_init(&vcpu->arch.tbacct_lock);
 	vcpu->arch.busy_preempt = TB_NIL;
+	vcpu->arch.intr_msr = MSR_SF | MSR_ME;
 
 	kvmppc_mmu_book3s_hv_init(vcpu);
 
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 294b7af..7b7bcea 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -521,8 +521,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
 12:	mr	r6,r10
 	mr	r10,r0
 	mr	r7,r11
-	li	r11,(MSR_ME << 1) | 1	/* synthesize MSR_SF | MSR_ME */
-	rotldi	r11,r11,63
+	ld	r11,VCPU_INTR_MSR(r4)
 	b	5f
 11:	beq	5f
 	mfspr	r0,SPRN_DEC
@@ -758,8 +757,7 @@ do_ext_interrupt:
 	mtspr	SPRN_SRR0, r10
 	mtspr	SPRN_SRR1, r11
 	li	r10, BOOK3S_INTERRUPT_EXTERNAL
-	li	r11, (MSR_ME << 1) | 1	/* synthesize MSR_SF | MSR_ME */
-	rotldi	r11, r11, 63
+	ld	r11,VCPU_INTR_MSR(r9)
 2:	mr	r4, r9
 	mtspr	SPRN_LPCR, r8
 	b	fast_guest_return
@@ -1300,8 +1298,7 @@ kvmppc_hdsi:
 	mtspr	SPRN_SRR0, r10
 	mtspr	SPRN_SRR1, r11
 	li	r10, BOOK3S_INTERRUPT_DATA_STORAGE
-	li	r11, (MSR_ME << 1) | 1	/* synthesize MSR_SF | MSR_ME */
-	rotldi	r11, r11, 63
+	ld	r11,VCPU_INTR_MSR(r9)
 fast_interrupt_c_return:
 6:	ld	r7, VCPU_CTR(r9)
 	lwz	r8, VCPU_XER(r9)
@@ -1370,8 +1367,7 @@ kvmppc_hisi:
 1:	mtspr	SPRN_SRR0, r10
 	mtspr	SPRN_SRR1, r11
 	li	r10, BOOK3S_INTERRUPT_INST_STORAGE
-	li	r11, (MSR_ME << 1) | 1	/* synthesize MSR_SF | MSR_ME */
-	rotldi	r11, r11, 63
+	ld	r11,VCPU_INTR_MSR(r9)
 	b	fast_interrupt_c_return
 
 3:	ld	r6, VCPU_KVM(r9)	/* not relocated, use VRMA */
@@ -1697,8 +1693,7 @@ machine_check_realmode:
 	beq	mc_cont
 	/* If not, deliver a machine check.  SRR0/1 are already set */
 	li	r10, BOOK3S_INTERRUPT_MACHINE_CHECK
-	li	r11, (MSR_ME << 1) | 1	/* synthesize MSR_SF | MSR_ME */
-	rotldi	r11, r11, 63
+	ld	r11,VCPU_INTR_MSR(r9)
 	b	fast_interrupt_c_return
 
 secondary_too_late:
-- 
1.8.1.2
