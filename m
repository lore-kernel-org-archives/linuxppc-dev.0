Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKqP13GXjzDvt1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 18:28:53 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 08/13] KVM: PPC: Book3S HV: Add new POWER9 guest-accessible
 SPRs
Date: Fri, 18 Nov 2016 18:28:37 +1100
Message-Id: <1479454122-26994-9-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
References: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds code to handle two new guest-accessible special-purpose
registers on POWER9: TIDR (thread ID register) and PSSCR (processor
stop status and control register).  They are context-switched
between host and guest, and the guest values can be read and set
via the one_reg interface.

The PSSCR contains some fields which are guest-accessible and some
which are only accessible in hypervisor mode.  We only allow the
guest-accessible fields to be read or set by userspace.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 Documentation/virtual/kvm/api.txt       |  2 ++
 arch/powerpc/include/asm/kvm_host.h     |  2 ++
 arch/powerpc/include/uapi/asm/kvm.h     |  4 ++++
 arch/powerpc/kernel/asm-offsets.c       |  2 ++
 arch/powerpc/kvm/book3s_hv.c            | 12 ++++++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 39 +++++++++++++++++++++++++++++++--
 6 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 739db9a..40b2bfc 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2023,6 +2023,8 @@ registers, find a list below:
   PPC   | KVM_REG_PPC_WORT              | 64
   PPC	| KVM_REG_PPC_SPRG9             | 64
   PPC	| KVM_REG_PPC_DBSR              | 32
+  PPC   | KVM_REG_PPC_TIDR              | 64
+  PPC   | KVM_REG_PPC_PSSCR             | 64
   PPC   | KVM_REG_PPC_TM_GPR0           | 64
           ...
   PPC   | KVM_REG_PPC_TM_GPR31          | 64
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 20ef27d..0d94608 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -517,6 +517,8 @@ struct kvm_vcpu_arch {
 	ulong tcscr;
 	ulong acop;
 	ulong wort;
+	ulong tid;
+	ulong psscr;
 	ulong shadow_srr1;
 #endif
 	u32 vrsave; /* also USPRG0 */
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index c93cf35..f0bae66 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -573,6 +573,10 @@ struct kvm_get_htab_header {
 #define KVM_REG_PPC_SPRG9	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xba)
 #define KVM_REG_PPC_DBSR	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xbb)
 
+/* POWER9 registers */
+#define KVM_REG_PPC_TIDR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbc)
+#define KVM_REG_PPC_PSSCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbd)
+
 /* Transactional Memory checkpointed state:
  * This is all GPRs, all VSX regs and a subset of SPRs
  */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index caec7bf..494241b 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -548,6 +548,8 @@ int main(void)
 	DEFINE(VCPU_TCSCR, offsetof(struct kvm_vcpu, arch.tcscr));
 	DEFINE(VCPU_ACOP, offsetof(struct kvm_vcpu, arch.acop));
 	DEFINE(VCPU_WORT, offsetof(struct kvm_vcpu, arch.wort));
+	DEFINE(VCPU_TID, offsetof(struct kvm_vcpu, arch.tid));
+	DEFINE(VCPU_PSSCR, offsetof(struct kvm_vcpu, arch.psscr));
 	DEFINE(VCORE_ENTRY_EXIT, offsetof(struct kvmppc_vcore, entry_exit_map));
 	DEFINE(VCORE_IN_GUEST, offsetof(struct kvmppc_vcore, in_guest));
 	DEFINE(VCORE_NAPPING_THREADS, offsetof(struct kvmppc_vcore, napping_threads));
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 5cbe3c3..59e18dfb 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1230,6 +1230,12 @@ static int kvmppc_get_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
 	case KVM_REG_PPC_WORT:
 		*val = get_reg_val(id, vcpu->arch.wort);
 		break;
+	case KVM_REG_PPC_TIDR:
+		*val = get_reg_val(id, vcpu->arch.tid);
+		break;
+	case KVM_REG_PPC_PSSCR:
+		*val = get_reg_val(id, vcpu->arch.psscr);
+		break;
 	case KVM_REG_PPC_VPA_ADDR:
 		spin_lock(&vcpu->arch.vpa_update_lock);
 		*val = get_reg_val(id, vcpu->arch.vpa.next_gpa);
@@ -1428,6 +1434,12 @@ static int kvmppc_set_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
 	case KVM_REG_PPC_WORT:
 		vcpu->arch.wort = set_reg_val(id, *val);
 		break;
+	case KVM_REG_PPC_TIDR:
+		vcpu->arch.tid = set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_PSSCR:
+		vcpu->arch.psscr = set_reg_val(id, *val) & PSSCR_GUEST_VIS;
+		break;
 	case KVM_REG_PPC_VPA_ADDR:
 		addr = set_reg_val(id, *val);
 		r = -EINVAL;
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index d422014..219a04f 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -523,6 +523,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
  *                                                                            *
  *****************************************************************************/
 
+/* Stack frame offsets */
+#define STACK_SLOT_TID		(112-16)
+#define STACK_SLOT_PSSCR	(112-24)
+
 .global kvmppc_hv_entry
 kvmppc_hv_entry:
 
@@ -700,6 +704,14 @@ kvmppc_got_guest:
 	mtspr	SPRN_PURR,r7
 	mtspr	SPRN_SPURR,r8
 
+	/* Save host values of some registers */
+BEGIN_FTR_SECTION
+	mfspr	r5, SPRN_TIDR
+	mfspr	r6, SPRN_PSSCR
+	std	r5, STACK_SLOT_TID(r1)
+	std	r6, STACK_SLOT_PSSCR(r1)
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
+
 BEGIN_FTR_SECTION
 	/* Set partition DABR */
 	/* Do this before re-enabling PMU to avoid P7 DABR corruption bug */
@@ -824,6 +836,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 	mtspr	SPRN_PID, r7
 	mtspr	SPRN_WORT, r8
 BEGIN_FTR_SECTION
+	/* POWER8-only registers */
 	ld	r5, VCPU_TCSCR(r4)
 	ld	r6, VCPU_ACOP(r4)
 	ld	r7, VCPU_CSIGR(r4)
@@ -832,7 +845,14 @@ BEGIN_FTR_SECTION
 	mtspr	SPRN_ACOP, r6
 	mtspr	SPRN_CSIGR, r7
 	mtspr	SPRN_TACR, r8
-END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
+FTR_SECTION_ELSE
+	/* POWER9-only registers */
+	ld	r5, VCPU_TID(r4)
+	ld	r6, VCPU_PSSCR(r4)
+	oris	r6, r6, PSSCR_EC@h	/* This makes stop trap to HV */
+	mtspr	SPRN_TIDR, r5
+	mtspr	SPRN_PSSCR, r6
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_300)
 8:
 
 	/*
@@ -1362,7 +1382,14 @@ BEGIN_FTR_SECTION
 	std	r6, VCPU_ACOP(r9)
 	std	r7, VCPU_CSIGR(r9)
 	std	r8, VCPU_TACR(r9)
-END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
+FTR_SECTION_ELSE
+	mfspr	r5, SPRN_TIDR
+	mfspr	r6, SPRN_PSSCR
+	std	r5, VCPU_TID(r9)
+	rldicl	r6, r6, 4, 50		/* r6 &= PSSCR_GUEST_VIS */
+	rotldi	r6, r6, 60
+	std	r6, VCPU_PSSCR(r9)
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_300)
 	/*
 	 * Restore various registers to 0, where non-zero values
 	 * set by the guest could disrupt the host.
@@ -1531,6 +1558,14 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	slbia
 	ptesync
 
+	/* Restore host values of some registers */
+BEGIN_FTR_SECTION
+	ld	r5, STACK_SLOT_TID(r1)
+	ld	r6, STACK_SLOT_PSSCR(r1)
+	mtspr	SPRN_TIDR, r5
+	mtspr	SPRN_PSSCR, r6
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
+
 	/*
 	 * POWER7/POWER8 guest -> host partition switch code.
 	 * We don't have to lock against tlbies but we do
-- 
2.7.4
