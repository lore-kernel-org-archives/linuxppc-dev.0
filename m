Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 178D42C034F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 20:04:13 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 27 Sep 2013 15:34:07 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 89BFB3940062
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 15:33:47 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8RA41jr45809824
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 15:34:01 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8RA42vx020105
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 15:34:03 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 04/11] kvm: powerpc: book3s: Add a new config variable
 CONFIG_KVM_BOOK3S_HV
Date: Fri, 27 Sep 2013 15:33:46 +0530
Message-Id: <1380276233-17095-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This help ups to select the relevant code in the kernel code
when we later move HV and PR bits as seperate modules.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_book3s_64.h  |  6 +++---
 arch/powerpc/include/asm/kvm_book3s_asm.h |  2 +-
 arch/powerpc/include/asm/kvm_host.h       | 10 +++++-----
 arch/powerpc/include/asm/kvm_ppc.h        |  2 +-
 arch/powerpc/kernel/asm-offsets.c         |  8 ++++----
 arch/powerpc/kernel/exceptions-64s.S      |  2 +-
 arch/powerpc/kernel/idle_power7.S         |  2 +-
 arch/powerpc/kvm/Kconfig                  |  4 ++++
 arch/powerpc/kvm/book3s_exports.c         |  5 +++--
 arch/powerpc/kvm/book3s_xics.c            |  4 ++--
 10 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 86d638a..37af4ae 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -35,7 +35,7 @@ static inline void svcpu_put(struct kvmppc_book3s_shadow_vcpu *svcpu)
 
 #define SPAPR_TCE_SHIFT		12
 
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV
 #define KVM_DEFAULT_HPT_ORDER	24	/* 16MB HPT by default */
 extern unsigned long kvm_rma_pages;
 #endif
@@ -278,7 +278,7 @@ static inline int is_vrma_hpte(unsigned long hpte_v)
 		(HPTE_V_1TB_SEG | (VRMA_VSID << (40 - 16)));
 }
 
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV
 /*
  * Note modification of an HPTE; set the HPTE modified bit
  * if anyone is interested.
@@ -289,6 +289,6 @@ static inline void note_hpte_modification(struct kvm *kvm,
 	if (atomic_read(&kvm->arch.hpte_mod_interest))
 		rev->guest_rpte |= HPTE_GR_MODIFIED;
 }
-#endif /* CONFIG_KVM_BOOK3S_64_HV */
+#endif /* CONFIG_KVM_BOOK3S_HV */
 
 #endif /* __ASM_KVM_BOOK3S_64_H__ */
diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/include/asm/kvm_book3s_asm.h
index 360742a..1272178 100644
--- a/arch/powerpc/include/asm/kvm_book3s_asm.h
+++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
@@ -84,7 +84,7 @@ struct kvmppc_host_state {
 	u8 restore_hid5;
 	u8 napping;
 
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV
 	u8 hwthread_req;
 	u8 hwthread_state;
 	u8 host_ipi;
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 78627c2..283e52e 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -229,15 +229,15 @@ struct revmap_entry {
 #define KVMPPC_GOT_PAGE		0x80
 
 struct kvm_arch_memory_slot {
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV
 	unsigned long *rmap;
 	unsigned long *slot_phys;
-#endif /* CONFIG_KVM_BOOK3S_64_HV */
+#endif /* CONFIG_KVM_BOOK3S_HV */
 };
 
 struct kvm_arch {
 	unsigned int lpid;
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV
 	unsigned long hpt_virt;
 	struct revmap_entry *revmap;
 	unsigned int host_lpid;
@@ -261,7 +261,7 @@ struct kvm_arch {
 	cpumask_t need_tlb_flush;
 	struct kvmppc_vcore *vcores[KVM_MAX_VCORES];
 	int hpt_cma_alloc;
-#endif /* CONFIG_KVM_BOOK3S_64_HV */
+#endif /* CONFIG_KVM_BOOK3S_HV */
 #ifdef CONFIG_KVM_BOOK3S_PR
 	struct mutex hpt_mutex;
 	bool relon_disabled;
@@ -598,7 +598,7 @@ struct kvm_vcpu_arch {
 	struct kvmppc_icp *icp; /* XICS presentation controller */
 #endif
 
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV
 	struct kvm_vcpu_arch_shared shregs;
 
 	unsigned long pgfault_addr;
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index b15554a..9161bd1 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -260,7 +260,7 @@ void kvmppc_set_pid(struct kvm_vcpu *vcpu, u32 pid);
 
 struct openpic;
 
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV
 extern void kvm_cma_reserve(void) __init;
 static inline void kvmppc_set_xics_phys(int cpu, unsigned long addr)
 {
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 67b5d56..dd7ad4a 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -445,7 +445,7 @@ int main(void)
 	DEFINE(VCPU_LR, offsetof(struct kvm_vcpu, arch.lr));
 	DEFINE(VCPU_CR, offsetof(struct kvm_vcpu, arch.cr));
 	DEFINE(VCPU_PC, offsetof(struct kvm_vcpu, arch.pc));
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV
 	DEFINE(VCPU_MSR, offsetof(struct kvm_vcpu, arch.shregs.msr));
 	DEFINE(VCPU_SRR0, offsetof(struct kvm_vcpu, arch.shregs.srr0));
 	DEFINE(VCPU_SRR1, offsetof(struct kvm_vcpu, arch.shregs.srr1));
@@ -476,7 +476,7 @@ int main(void)
 	DEFINE(KVM_LPID, offsetof(struct kvm, arch.lpid));
 
 	/* book3s */
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV
 	DEFINE(KVM_SDR1, offsetof(struct kvm, arch.sdr1));
 	DEFINE(KVM_HOST_LPID, offsetof(struct kvm, arch.host_lpid));
 	DEFINE(KVM_HOST_LPCR, offsetof(struct kvm, arch.host_lpcr));
@@ -581,7 +581,7 @@ int main(void)
 	HSTATE_FIELD(HSTATE_RESTORE_HID5, restore_hid5);
 	HSTATE_FIELD(HSTATE_NAPPING, napping);
 
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV
 	HSTATE_FIELD(HSTATE_HWTHREAD_REQ, hwthread_req);
 	HSTATE_FIELD(HSTATE_HWTHREAD_STATE, hwthread_state);
 	HSTATE_FIELD(HSTATE_KVM_VCPU, kvm_vcpu);
@@ -597,7 +597,7 @@ int main(void)
 	HSTATE_FIELD(HSTATE_DABR, dabr);
 	HSTATE_FIELD(HSTATE_DECEXP, dec_expires);
 	DEFINE(IPI_PRIORITY, IPI_PRIORITY);
-#endif /* CONFIG_KVM_BOOK3S_64_HV */
+#endif /* CONFIG_KVM_BOOK3S_HV */
 
 #ifdef CONFIG_PPC_BOOK3S_64
 	HSTATE_FIELD(HSTATE_CFAR, cfar);
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 2a273be..9f2f352 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -126,7 +126,7 @@ BEGIN_FTR_SECTION
 	bgt	cr1,.
 	GET_PACA(r13)
 
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV
 	li	r0,KVM_HWTHREAD_IN_KERNEL
 	stb	r0,HSTATE_HWTHREAD_STATE(r13)
 	/* Order setting hwthread_state vs. testing hwthread_req */
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index e11863f..6aa4477 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -84,7 +84,7 @@ _GLOBAL(power7_nap)
 	std	r9,_MSR(r1)
 	std	r1,PACAR1(r13)
 
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV
 	/* Tell KVM we're napping */
 	li	r4,KVM_HWTHREAD_IN_NAP
 	stb	r4,HSTATE_HWTHREAD_STATE(r13)
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index ffaef2c..719c946 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -39,6 +39,9 @@ config KVM_BOOK3S_PR
 	select KVM_MMIO
 	select MMU_NOTIFIER
 
+config KVM_BOOK3S_HV
+	bool
+
 config KVM_BOOK3S_32
 	tristate "KVM support for PowerPC book3s_32 processors"
 	depends on PPC_BOOK3S_32 && !SMP && !PTE_64BIT
@@ -71,6 +74,7 @@ config KVM_BOOK3S_64
 config KVM_BOOK3S_64_HV
 	bool "KVM support for POWER7 and PPC970 using hypervisor mode in host"
 	depends on KVM_BOOK3S_64
+	select KVM_BOOK3S_HV
 	select MMU_NOTIFIER
 	select CMA
 	---help---
diff --git a/arch/powerpc/kvm/book3s_exports.c b/arch/powerpc/kvm/book3s_exports.c
index 7057a02..99504db 100644
--- a/arch/powerpc/kvm/book3s_exports.c
+++ b/arch/powerpc/kvm/book3s_exports.c
@@ -20,9 +20,10 @@
 #include <linux/export.h>
 #include <asm/kvm_book3s.h>
 
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV
 EXPORT_SYMBOL_GPL(kvmppc_hv_entry_trampoline);
-#else
+#endif
+#ifdef CONFIG_KVM_BOOK3S_PR
 EXPORT_SYMBOL_GPL(kvmppc_entry_trampoline);
 EXPORT_SYMBOL_GPL(kvmppc_load_up_fpu);
 #ifdef CONFIG_ALTIVEC
diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index a3a5cb8..f0c732e 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -1250,13 +1250,13 @@ static int kvmppc_xics_create(struct kvm_device *dev, u32 type)
 
 	xics_debugfs_init(xics);
 
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV
 	if (cpu_has_feature(CPU_FTR_ARCH_206)) {
 		/* Enable real mode support */
 		xics->real_mode = ENABLE_REALMODE;
 		xics->real_mode_dbg = DEBUG_REALMODE;
 	}
-#endif /* CONFIG_KVM_BOOK3S_64_HV */
+#endif /* CONFIG_KVM_BOOK3S_HV */
 
 	return 0;
 }
-- 
1.8.1.2
