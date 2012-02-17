Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B1241B700E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 04:14:09 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 20/30] KVM: PPC: rename CONFIG_KVM_E500 -> CONFIG_KVM_E500V2
Date: Fri, 17 Feb 2012 18:13:47 +0100
Message-Id: <1329498837-11717-21-git-send-email-agraf@suse.de>
In-Reply-To: <1329498837-11717-1-git-send-email-agraf@suse.de>
References: <1329498837-11717-1-git-send-email-agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The CONFIG_KVM_E500 option really indicates that we're running on a V2 machine,
not on a machine of the generic E500 class. So indicate that properly and
change the config name accordingly.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/Kconfig    |    8 ++++----
 arch/powerpc/kvm/Makefile   |    4 ++--
 arch/powerpc/kvm/booke.c    |    2 +-
 arch/powerpc/kvm/e500.h     |    6 +++---
 arch/powerpc/kvm/e500_tlb.c |    2 +-
 arch/powerpc/kvm/powerpc.c  |    8 ++++----
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 58f6e68..44a998d 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -109,7 +109,7 @@ config KVM_440
 
 config KVM_EXIT_TIMING
 	bool "Detailed exit timing"
-	depends on KVM_440 || KVM_E500 || KVM_E500MC
+	depends on KVM_440 || KVM_E500V2 || KVM_E500MC
 	---help---
 	  Calculate elapsed time for every exit/enter cycle. A per-vcpu
 	  report is available in debugfs kvm/vm#_vcpu#_timing.
@@ -118,14 +118,14 @@ config KVM_EXIT_TIMING
 
 	  If unsure, say N.
 
-config KVM_E500
-	bool "KVM support for PowerPC E500 processors"
+config KVM_E500V2
+	bool "KVM support for PowerPC E500v2 processors"
 	depends on EXPERIMENTAL && E500
 	select KVM
 	select KVM_MMIO
 	---help---
 	  Support running unmodified E500 guest kernels in virtual machines on
-	  E500 host processors.
+	  E500v2 host processors.
 
 	  This module provides access to the hardware capabilities through
 	  a character device node named /dev/kvm.
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index 62febd7..25225ae 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -36,7 +36,7 @@ kvm-e500-objs := \
 	e500.o \
 	e500_tlb.o \
 	e500_emulate.o
-kvm-objs-$(CONFIG_KVM_E500) := $(kvm-e500-objs)
+kvm-objs-$(CONFIG_KVM_E500V2) := $(kvm-e500-objs)
 
 kvm-e500mc-objs := \
 	$(common-objs-y) \
@@ -98,7 +98,7 @@ kvm-objs-$(CONFIG_KVM_BOOK3S_32) := $(kvm-book3s_32-objs)
 kvm-objs := $(kvm-objs-m) $(kvm-objs-y)
 
 obj-$(CONFIG_KVM_440) += kvm.o
-obj-$(CONFIG_KVM_E500) += kvm.o
+obj-$(CONFIG_KVM_E500V2) += kvm.o
 obj-$(CONFIG_KVM_E500MC) += kvm.o
 obj-$(CONFIG_KVM_BOOK3S_64) += kvm.o
 obj-$(CONFIG_KVM_BOOK3S_32) += kvm.o
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index ecfcf6d..12a2b0b 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -766,7 +766,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		gpa_t gpaddr;
 		gfn_t gfn;
 
-#ifdef CONFIG_KVM_E500
+#ifdef CONFIG_KVM_E500V2
 		if (!(vcpu->arch.shared->msr & MSR_PR) &&
 		    (eaddr & PAGE_MASK) == vcpu->arch.magic_page_ea) {
 			kvmppc_map_magic(vcpu);
diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
index 3143085..7967f3f 100644
--- a/arch/powerpc/kvm/e500.h
+++ b/arch/powerpc/kvm/e500.h
@@ -39,7 +39,7 @@ struct tlbe_priv {
 	struct tlbe_ref ref; /* TLB0 only -- TLB1 uses tlb_refs */
 };
 
-#ifdef CONFIG_KVM_E500
+#ifdef CONFIG_KVM_E500V2
 struct vcpu_id_table;
 #endif
 
@@ -89,7 +89,7 @@ struct kvmppc_vcpu_e500 {
 	u64 *g2h_tlb1_map;
 	unsigned int *h2g_tlb1_rmap;
 
-#ifdef CONFIG_KVM_E500
+#ifdef CONFIG_KVM_E500V2
 	u32 pid[E500_PID_NUM];
 
 	/* vcpu id table */
@@ -136,7 +136,7 @@ void kvmppc_get_sregs_e500_tlb(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
 int kvmppc_set_sregs_e500_tlb(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
 
 
-#ifdef CONFIG_KVM_E500
+#ifdef CONFIG_KVM_E500V2
 unsigned int kvmppc_e500_get_sid(struct kvmppc_vcpu_e500 *vcpu_e500,
 				 unsigned int as, unsigned int gid,
 				 unsigned int pr, int avoid_recursion);
diff --git a/arch/powerpc/kvm/e500_tlb.c b/arch/powerpc/kvm/e500_tlb.c
index e232bb4..279e10a 100644
--- a/arch/powerpc/kvm/e500_tlb.c
+++ b/arch/powerpc/kvm/e500_tlb.c
@@ -156,7 +156,7 @@ static inline void write_host_tlbe(struct kvmppc_vcpu_e500 *vcpu_e500,
 	}
 }
 
-#ifdef CONFIG_KVM_E500
+#ifdef CONFIG_KVM_E500V2
 void kvmppc_map_magic(struct kvm_vcpu *vcpu)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500 = to_e500(vcpu);
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 58a084f..26c6a8d 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -74,7 +74,7 @@ int kvmppc_kvm_pv(struct kvm_vcpu *vcpu)
 	}
 	case HC_VENDOR_KVM | KVM_HC_FEATURES:
 		r = HC_EV_SUCCESS;
-#if defined(CONFIG_PPC_BOOK3S) || defined(CONFIG_KVM_E500)
+#if defined(CONFIG_PPC_BOOK3S) || defined(CONFIG_KVM_E500V2)
 		/* XXX Missing magic page on 44x */
 		r2 |= (1 << KVM_FEATURE_MAGIC_PAGE);
 #endif
@@ -230,7 +230,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_PPC_PAIRED_SINGLES:
 	case KVM_CAP_PPC_OSI:
 	case KVM_CAP_PPC_GET_PVINFO:
-#if defined(CONFIG_KVM_E500) || defined(CONFIG_KVM_E500MC)
+#if defined(CONFIG_KVM_E500V2) || defined(CONFIG_KVM_E500MC)
 	case KVM_CAP_SW_TLB:
 #endif
 		r = 1;
@@ -638,7 +638,7 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 		r = 0;
 		vcpu->arch.papr_enabled = true;
 		break;
-#if defined(CONFIG_KVM_E500) || defined(CONFIG_KVM_E500MC)
+#if defined(CONFIG_KVM_E500V2) || defined(CONFIG_KVM_E500MC)
 	case KVM_CAP_SW_TLB: {
 		struct kvm_config_tlb cfg;
 		void __user *user_ptr = (void __user *)(uintptr_t)cap->args[0];
@@ -715,7 +715,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		break;
 	}
 
-#if defined(CONFIG_KVM_E500) || defined(CONFIG_KVM_E500MC)
+#if defined(CONFIG_KVM_E500V2) || defined(CONFIG_KVM_E500MC)
 	case KVM_DIRTY_TLB: {
 		struct kvm_dirty_tlb dirty;
 		r = -EFAULT;
-- 
1.6.0.2
