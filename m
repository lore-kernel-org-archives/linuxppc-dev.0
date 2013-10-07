Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9F0F32C014B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 04:36:28 +1100 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 8 Oct 2013 03:36:28 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 997FA2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 04:28:49 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r97GW4en7340086
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 03:32:33 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r97GmhlX024983
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 03:48:43 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V2 08/14] kvm: powerpc: book3s: Add is_hv_enabled to
 kvmppc_ops
Date: Mon,  7 Oct 2013 22:17:56 +0530
Message-Id: <1381164482-31001-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1381164482-31001-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1381164482-31001-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This help us to identify whether we are running with hypervisor mode KVM
enabled. The change is needed so that we can have both HV and PR kvm
enabled in the same kernel.

If both HV and PR KVM are included, interrupts come in to the HV version
of the kvmppc_interrupt code, which then jumps to the PR handler,
renamed to kvmppc_interrupt_pr, if the guest is a PR guest.

Allowing both PR and HV in the same kernel required some changes to
kvm_dev_ioctl_check_extension(), since the values returned now can't
be selected with #ifdefs as much as previously. We look at is_hv_enabled
to return the right value when checking for capabilities.For capabilities that
are only provided by HV KVM, we return the HV value only if
is_hv_enabled is true. For capabilities provided by PR KVM but not HV,
we return the PR value only if is_hv_enabled is false.

NOTE: in later patch we replace is_hv_enabled with a static inline
function comparing kvm_ppc_ops

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_book3s.h | 53 ----------------------------------
 arch/powerpc/include/asm/kvm_ppc.h    |  5 ++--
 arch/powerpc/kvm/book3s.c             | 44 ++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv.c          |  1 +
 arch/powerpc/kvm/book3s_pr.c          |  1 +
 arch/powerpc/kvm/book3s_xics.c        |  2 +-
 arch/powerpc/kvm/powerpc.c            | 54 +++++++++++++++++++----------------
 7 files changed, 79 insertions(+), 81 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 315a5d6..4a594b7 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -301,59 +301,6 @@ static inline ulong kvmppc_get_fault_dar(struct kvm_vcpu *vcpu)
 	return vcpu->arch.fault_dar;
 }
 
-#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
-
-static inline unsigned long kvmppc_interrupt_offset(struct kvm_vcpu *vcpu)
-{
-	return to_book3s(vcpu)->hior;
-}
-
-static inline void kvmppc_update_int_pending(struct kvm_vcpu *vcpu,
-			unsigned long pending_now, unsigned long old_pending)
-{
-	if (pending_now)
-		vcpu->arch.shared->int_pending = 1;
-	else if (old_pending)
-		vcpu->arch.shared->int_pending = 0;
-}
-
-static inline bool kvmppc_critical_section(struct kvm_vcpu *vcpu)
-{
-	ulong crit_raw = vcpu->arch.shared->critical;
-	ulong crit_r1 = kvmppc_get_gpr(vcpu, 1);
-	bool crit;
-
-	/* Truncate crit indicators in 32 bit mode */
-	if (!(vcpu->arch.shared->msr & MSR_SF)) {
-		crit_raw &= 0xffffffff;
-		crit_r1 &= 0xffffffff;
-	}
-
-	/* Critical section when crit == r1 */
-	crit = (crit_raw == crit_r1);
-	/* ... and we're in supervisor mode */
-	crit = crit && !(vcpu->arch.shared->msr & MSR_PR);
-
-	return crit;
-}
-#else /* CONFIG_KVM_BOOK3S_PR_POSSIBLE */
-
-static inline unsigned long kvmppc_interrupt_offset(struct kvm_vcpu *vcpu)
-{
-	return 0;
-}
-
-static inline void kvmppc_update_int_pending(struct kvm_vcpu *vcpu,
-			unsigned long pending_now, unsigned long old_pending)
-{
-}
-
-static inline bool kvmppc_critical_section(struct kvm_vcpu *vcpu)
-{
-	return false;
-}
-#endif
-
 /* Magic register values loaded into r3 and r4 before the 'sc' assembly
  * instruction for the OSI hypercalls */
 #define OSI_SC_MAGIC_R3			0x113724FA
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 326033c..c13f15d 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -180,6 +180,7 @@ union kvmppc_one_reg {
 };
 
 struct kvmppc_ops {
+	bool is_hv_enabled;
 	int (*get_sregs)(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
 	int (*set_sregs)(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
 	int (*get_one_reg)(struct kvm_vcpu *vcpu, u64 id,
@@ -309,10 +310,10 @@ static inline void kvmppc_set_xics_phys(int cpu, unsigned long addr)
 
 static inline u32 kvmppc_get_xics_latch(void)
 {
-	u32 xirr = get_paca()->kvm_hstate.saved_xirr;
+	u32 xirr;
 
+	xirr = get_paca()->kvm_hstate.saved_xirr;
 	get_paca()->kvm_hstate.saved_xirr = 0;
-
 	return xirr;
 }
 
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 784a1d5..493aff7 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -69,6 +69,50 @@ void kvmppc_core_load_guest_debugstate(struct kvm_vcpu *vcpu)
 {
 }
 
+static inline unsigned long kvmppc_interrupt_offset(struct kvm_vcpu *vcpu)
+{
+	if (!kvmppc_ops->is_hv_enabled)
+		return to_book3s(vcpu)->hior;
+	return 0;
+}
+
+static inline void kvmppc_update_int_pending(struct kvm_vcpu *vcpu,
+			unsigned long pending_now, unsigned long old_pending)
+{
+	if (kvmppc_ops->is_hv_enabled)
+		return;
+	if (pending_now)
+		vcpu->arch.shared->int_pending = 1;
+	else if (old_pending)
+		vcpu->arch.shared->int_pending = 0;
+}
+
+static inline bool kvmppc_critical_section(struct kvm_vcpu *vcpu)
+{
+	ulong crit_raw;
+	ulong crit_r1;
+	bool crit;
+
+	if (kvmppc_ops->is_hv_enabled)
+		return false;
+
+	crit_raw = vcpu->arch.shared->critical;
+	crit_r1 = kvmppc_get_gpr(vcpu, 1);
+
+	/* Truncate crit indicators in 32 bit mode */
+	if (!(vcpu->arch.shared->msr & MSR_SF)) {
+		crit_raw &= 0xffffffff;
+		crit_r1 &= 0xffffffff;
+	}
+
+	/* Critical section when crit == r1 */
+	crit = (crit_raw == crit_r1);
+	/* ... and we're in supervisor mode */
+	crit = crit && !(vcpu->arch.shared->msr & MSR_PR);
+
+	return crit;
+}
+
 void kvmppc_inject_interrupt(struct kvm_vcpu *vcpu, int vec, u64 flags)
 {
 	vcpu->arch.shared->srr0 = kvmppc_get_pc(vcpu);
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index eb72140..540438d 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2159,6 +2159,7 @@ static long kvm_arch_vm_ioctl_hv(struct file *filp,
 }
 
 static struct kvmppc_ops kvmppc_hv_ops = {
+	.is_hv_enabled = true,
 	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_hv,
 	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_hv,
 	.get_one_reg = kvmppc_get_one_reg_hv,
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 05d28cf..b6a525d 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1523,6 +1523,7 @@ static long kvm_arch_vm_ioctl_pr(struct file *filp,
 }
 
 static struct kvmppc_ops kvmppc_pr_ops = {
+	.is_hv_enabled = false,
 	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_pr,
 	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_pr,
 	.get_one_reg = kvmppc_get_one_reg_pr,
diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index 51ed1ea..cef3de9 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -818,7 +818,7 @@ int kvmppc_xics_hcall(struct kvm_vcpu *vcpu, u32 req)
 	}
 
 	/* Check for real mode returning too hard */
-	if (xics->real_mode)
+	if (xics->real_mode && kvmppc_ops->is_hv_enabled)
 		return kvmppc_xics_rm_complete(vcpu, req);
 
 	switch (req) {
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 5e3ab80..4481417 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -52,7 +52,6 @@ int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
-#ifndef CONFIG_KVM_BOOK3S_64_HV
 /*
  * Common checks before entering the guest world.  Call with interrupts
  * disabled.
@@ -127,7 +126,6 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
 
 	return r;
 }
-#endif /* CONFIG_KVM_BOOK3S_64_HV */
 
 int kvmppc_kvm_pv(struct kvm_vcpu *vcpu)
 {
@@ -194,11 +192,9 @@ int kvmppc_sanity_check(struct kvm_vcpu *vcpu)
 	if ((vcpu->arch.cpu_type != KVM_CPU_3S_64) && vcpu->arch.papr_enabled)
 		goto out;
 
-#ifdef CONFIG_KVM_BOOK3S_64_HV
 	/* HV KVM can only do PAPR mode for now */
-	if (!vcpu->arch.papr_enabled)
+	if (!vcpu->arch.papr_enabled && kvmppc_ops->is_hv_enabled)
 		goto out;
-#endif
 
 #ifdef CONFIG_KVM_BOOKE_HV
 	if (!cpu_has_feature(CPU_FTR_EMB_HV))
@@ -322,22 +318,26 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_DEVICE_CTRL:
 		r = 1;
 		break;
-#ifndef CONFIG_KVM_BOOK3S_64_HV
 	case KVM_CAP_PPC_PAIRED_SINGLES:
 	case KVM_CAP_PPC_OSI:
 	case KVM_CAP_PPC_GET_PVINFO:
 #if defined(CONFIG_KVM_E500V2) || defined(CONFIG_KVM_E500MC)
 	case KVM_CAP_SW_TLB:
 #endif
-#ifdef CONFIG_KVM_MPIC
-	case KVM_CAP_IRQ_MPIC:
-#endif
-		r = 1;
+		/* We support this only for PR */
+		r = !kvmppc_ops->is_hv_enabled;
 		break;
+#ifdef CONFIG_KVM_MMIO
 	case KVM_CAP_COALESCED_MMIO:
 		r = KVM_COALESCED_MMIO_PAGE_OFFSET;
 		break;
 #endif
+#ifdef CONFIG_KVM_MPIC
+	case KVM_CAP_IRQ_MPIC:
+		r = 1;
+		break;
+#endif
+
 #ifdef CONFIG_PPC_BOOK3S_64
 	case KVM_CAP_SPAPR_TCE:
 	case KVM_CAP_PPC_ALLOC_HTAB:
@@ -348,32 +348,37 @@ int kvm_dev_ioctl_check_extension(long ext)
 		r = 1;
 		break;
 #endif /* CONFIG_PPC_BOOK3S_64 */
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	case KVM_CAP_PPC_SMT:
-		r = threads_per_core;
+		if (kvmppc_ops->is_hv_enabled)
+			r = threads_per_core;
+		else
+			r = 0;
 		break;
 	case KVM_CAP_PPC_RMA:
-		r = 1;
+		r = kvmppc_ops->is_hv_enabled;
 		/* PPC970 requires an RMA */
-		if (cpu_has_feature(CPU_FTR_ARCH_201))
+		if (r && cpu_has_feature(CPU_FTR_ARCH_201))
 			r = 2;
 		break;
 #endif
 	case KVM_CAP_SYNC_MMU:
-#ifdef CONFIG_KVM_BOOK3S_64_HV
-		r = cpu_has_feature(CPU_FTR_ARCH_206) ? 1 : 0;
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+		if (kvmppc_ops->is_hv_enabled)
+			r = cpu_has_feature(CPU_FTR_ARCH_206) ? 1 : 0;
+		else
+			r = 0;
 #elif defined(KVM_ARCH_WANT_MMU_NOTIFIER)
 		r = 1;
 #else
 		r = 0;
-		break;
 #endif
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+		break;
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	case KVM_CAP_PPC_HTAB_FD:
-		r = 1;
+		r = kvmppc_ops->is_hv_enabled;
 		break;
 #endif
-		break;
 	case KVM_CAP_NR_VCPUS:
 		/*
 		 * Recommending a number of CPUs is somewhat arbitrary; we
@@ -381,11 +386,10 @@ int kvm_dev_ioctl_check_extension(long ext)
 		 * will have secondary threads "offline"), and for other KVM
 		 * implementations just count online CPUs.
 		 */
-#ifdef CONFIG_KVM_BOOK3S_64_HV
-		r = num_present_cpus();
-#else
-		r = num_online_cpus();
-#endif
+		if (kvmppc_ops->is_hv_enabled)
+			r = num_present_cpus();
+		else
+			r = num_online_cpus();
 		break;
 	case KVM_CAP_MAX_VCPUS:
 		r = KVM_MAX_VCPUS;
-- 
1.8.1.2
