Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9D7F52C0126
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 03:48:51 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 8 Oct 2013 02:48:51 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 503802CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 03:48:48 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r97Gma4910092922
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 03:48:36 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r97GmWEx024805
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 03:48:33 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V2 04/14] kvm: powerpc: book3s: Add a new config variable
 CONFIG_KVM_BOOK3S_HV_POSSIBLE
Date: Mon,  7 Oct 2013 22:17:52 +0530
Message-Id: <1381164482-31001-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

This help ups to select the relevant code in the kernel code
when we later move HV and PR bits as seperate modules. The patch
also makes the config options for PR KVM selectable

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_book3s.h     |  2 --
 arch/powerpc/include/asm/kvm_book3s_64.h  |  6 +++---
 arch/powerpc/include/asm/kvm_book3s_asm.h |  2 +-
 arch/powerpc/include/asm/kvm_host.h       | 10 +++++-----
 arch/powerpc/include/asm/kvm_ppc.h        |  2 +-
 arch/powerpc/kernel/asm-offsets.c         |  8 ++++----
 arch/powerpc/kernel/idle_power7.S         |  2 +-
 arch/powerpc/kvm/Kconfig                  | 18 +++++++++++++++++-
 arch/powerpc/kvm/Makefile                 | 12 ++++++++----
 arch/powerpc/kvm/book3s_exports.c         |  5 +++--
 10 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 5c07d10..99ef871 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -199,8 +199,6 @@ static inline struct kvmppc_vcpu_book3s *to_book3s(struct kvm_vcpu *vcpu)
 	return vcpu->arch.book3s;
 }
 
-extern void kvm_return_point(void);
-
 /* Also add subarch specific defines */
 
 #ifdef CONFIG_KVM_BOOK3S_32_HANDLER
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index e6ee7fd..bf0fa8b 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -35,7 +35,7 @@ static inline void svcpu_put(struct kvmppc_book3s_shadow_vcpu *svcpu)
 
 #define SPAPR_TCE_SHIFT		12
 
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 #define KVM_DEFAULT_HPT_ORDER	24	/* 16MB HPT by default */
 extern unsigned long kvm_rma_pages;
 #endif
@@ -278,7 +278,7 @@ static inline int is_vrma_hpte(unsigned long hpte_v)
 		(HPTE_V_1TB_SEG | (VRMA_VSID << (40 - 16)));
 }
 
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 /*
  * Note modification of an HPTE; set the HPTE modified bit
  * if anyone is interested.
@@ -289,6 +289,6 @@ static inline void note_hpte_modification(struct kvm *kvm,
 	if (atomic_read(&kvm->arch.hpte_mod_interest))
 		rev->guest_rpte |= HPTE_GR_MODIFIED;
 }
-#endif /* CONFIG_KVM_BOOK3S_64_HV */
+#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 
 #endif /* __ASM_KVM_BOOK3S_64_H__ */
diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/include/asm/kvm_book3s_asm.h
index 6273711..0bd9348 100644
--- a/arch/powerpc/include/asm/kvm_book3s_asm.h
+++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
@@ -83,7 +83,7 @@ struct kvmppc_host_state {
 	u8 restore_hid5;
 	u8 napping;
 
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	u8 hwthread_req;
 	u8 hwthread_state;
 	u8 host_ipi;
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index a0ca1f4..e86db97 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -229,15 +229,15 @@ struct revmap_entry {
 #define KVMPPC_GOT_PAGE		0x80
 
 struct kvm_arch_memory_slot {
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	unsigned long *rmap;
 	unsigned long *slot_phys;
-#endif /* CONFIG_KVM_BOOK3S_64_HV */
+#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 };
 
 struct kvm_arch {
 	unsigned int lpid;
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	unsigned long hpt_virt;
 	struct revmap_entry *revmap;
 	unsigned int host_lpid;
@@ -261,7 +261,7 @@ struct kvm_arch {
 	cpumask_t need_tlb_flush;
 	struct kvmppc_vcore *vcores[KVM_MAX_VCORES];
 	int hpt_cma_alloc;
-#endif /* CONFIG_KVM_BOOK3S_64_HV */
+#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	struct mutex hpt_mutex;
 #endif
@@ -597,7 +597,7 @@ struct kvm_vcpu_arch {
 	struct kvmppc_icp *icp; /* XICS presentation controller */
 #endif
 
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	struct kvm_vcpu_arch_shared shregs;
 
 	unsigned long pgfault_addr;
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index b15554a..1823f38 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -260,7 +260,7 @@ void kvmppc_set_pid(struct kvm_vcpu *vcpu, u32 pid);
 
 struct openpic;
 
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 extern void kvm_cma_reserve(void) __init;
 static inline void kvmppc_set_xics_phys(int cpu, unsigned long addr)
 {
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index c6c8675..3edce7b 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -442,7 +442,7 @@ int main(void)
 	DEFINE(VCPU_LR, offsetof(struct kvm_vcpu, arch.lr));
 	DEFINE(VCPU_CR, offsetof(struct kvm_vcpu, arch.cr));
 	DEFINE(VCPU_PC, offsetof(struct kvm_vcpu, arch.pc));
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	DEFINE(VCPU_MSR, offsetof(struct kvm_vcpu, arch.shregs.msr));
 	DEFINE(VCPU_SRR0, offsetof(struct kvm_vcpu, arch.shregs.srr0));
 	DEFINE(VCPU_SRR1, offsetof(struct kvm_vcpu, arch.shregs.srr1));
@@ -473,7 +473,7 @@ int main(void)
 	DEFINE(KVM_LPID, offsetof(struct kvm, arch.lpid));
 
 	/* book3s */
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	DEFINE(KVM_SDR1, offsetof(struct kvm, arch.sdr1));
 	DEFINE(KVM_HOST_LPID, offsetof(struct kvm, arch.host_lpid));
 	DEFINE(KVM_HOST_LPCR, offsetof(struct kvm, arch.host_lpcr));
@@ -583,7 +583,7 @@ int main(void)
 	HSTATE_FIELD(HSTATE_RESTORE_HID5, restore_hid5);
 	HSTATE_FIELD(HSTATE_NAPPING, napping);
 
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	HSTATE_FIELD(HSTATE_HWTHREAD_REQ, hwthread_req);
 	HSTATE_FIELD(HSTATE_HWTHREAD_STATE, hwthread_state);
 	HSTATE_FIELD(HSTATE_KVM_VCPU, kvm_vcpu);
@@ -599,7 +599,7 @@ int main(void)
 	HSTATE_FIELD(HSTATE_DABR, dabr);
 	HSTATE_FIELD(HSTATE_DECEXP, dec_expires);
 	DEFINE(IPI_PRIORITY, IPI_PRIORITY);
-#endif /* CONFIG_KVM_BOOK3S_64_HV */
+#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 
 #ifdef CONFIG_PPC_BOOK3S_64
 	HSTATE_FIELD(HSTATE_CFAR, cfar);
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index e11863f..847e40e 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -84,7 +84,7 @@ _GLOBAL(power7_nap)
 	std	r9,_MSR(r1)
 	std	r1,PACAR1(r13)
 
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	/* Tell KVM we're napping */
 	li	r4,KVM_HWTHREAD_IN_NAP
 	stb	r4,HSTATE_HWTHREAD_STATE(r13)
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index d0665f2..a96d7c3 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -39,6 +39,9 @@ config KVM_BOOK3S_PR_POSSIBLE
 	select KVM_MMIO
 	select MMU_NOTIFIER
 
+config KVM_BOOK3S_HV_POSSIBLE
+	bool
+
 config KVM_BOOK3S_32
 	tristate "KVM support for PowerPC book3s_32 processors"
 	depends on PPC_BOOK3S_32 && !SMP && !PTE_64BIT
@@ -59,6 +62,7 @@ config KVM_BOOK3S_64
 	depends on PPC_BOOK3S_64
 	select KVM_BOOK3S_64_HANDLER
 	select KVM
+	select KVM_BOOK3S_PR_POSSIBLE if !KVM_BOOK3S_HV_POSSIBLE
 	---help---
 	  Support running unmodified book3s_64 and book3s_32 guest kernels
 	  in virtual machines on book3s_64 host processors.
@@ -71,6 +75,7 @@ config KVM_BOOK3S_64
 config KVM_BOOK3S_64_HV
 	bool "KVM support for POWER7 and PPC970 using hypervisor mode in host"
 	depends on KVM_BOOK3S_64
+	select KVM_BOOK3S_HV_POSSIBLE
 	select MMU_NOTIFIER
 	select CMA
 	---help---
@@ -89,9 +94,20 @@ config KVM_BOOK3S_64_HV
 	  If unsure, say N.
 
 config KVM_BOOK3S_64_PR
-	def_bool y
+	bool "KVM support without using hypervisor mode in host"
 	depends on KVM_BOOK3S_64 && !KVM_BOOK3S_64_HV
 	select KVM_BOOK3S_PR_POSSIBLE
+	---help---
+	  Support running guest kernels in virtual machines on processors
+	  without using hypervisor mode in the host, by running the
+	  guest in user mode (problem state) and emulating all
+	  privileged instructions and registers.
+
+	  This is not as fast as using hypervisor mode, but works on
+	  machines where hypervisor mode is not available or not usable,
+	  and can emulate processors that are different from the host
+	  processor, including emulating 32-bit processors on a 64-bit
+	  host.
 
 config KVM_BOOKE_HV
 	bool
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index 104e8dc..fa17b33 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -57,7 +57,6 @@ kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HANDLER) := \
 	book3s_64_vio_hv.o
 
 kvm-book3s_64-objs-$(CONFIG_KVM_BOOK3S_64_PR) := \
-	$(KVM)/coalesced_mmio.o \
 	fpu.o \
 	book3s_paired_singles.o \
 	book3s_pr.o \
@@ -69,10 +68,15 @@ kvm-book3s_64-objs-$(CONFIG_KVM_BOOK3S_64_PR) := \
 	book3s_64_mmu.o \
 	book3s_32_mmu.o
 
-kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_PR) += \
+ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
+kvm-book3s_64-module-objs := \
+	$(KVM)/coalesced_mmio.o
+
+kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HANDLER) += \
 	book3s_rmhandlers.o
+endif
 
-kvm-book3s_64-objs-$(CONFIG_KVM_BOOK3S_64_HV) := \
+kvm-book3s_64-objs-$(CONFIG_KVM_BOOK3S_64_HV)  += \
 	book3s_hv.o \
 	book3s_hv_interrupts.o \
 	book3s_64_mmu_hv.o
@@ -91,7 +95,7 @@ kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HV) += \
 kvm-book3s_64-objs-$(CONFIG_KVM_XICS) += \
 	book3s_xics.o
 
-kvm-book3s_64-module-objs := \
+kvm-book3s_64-module-objs += \
 	$(KVM)/kvm_main.o \
 	$(KVM)/eventfd.o \
 	powerpc.o \
diff --git a/arch/powerpc/kvm/book3s_exports.c b/arch/powerpc/kvm/book3s_exports.c
index 7057a02..852989a 100644
--- a/arch/powerpc/kvm/book3s_exports.c
+++ b/arch/powerpc/kvm/book3s_exports.c
@@ -20,9 +20,10 @@
 #include <linux/export.h>
 #include <asm/kvm_book3s.h>
 
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 EXPORT_SYMBOL_GPL(kvmppc_hv_entry_trampoline);
-#else
+#endif
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 EXPORT_SYMBOL_GPL(kvmppc_entry_trampoline);
 EXPORT_SYMBOL_GPL(kvmppc_load_up_fpu);
 #ifdef CONFIG_ALTIVEC
-- 
1.8.1.2
