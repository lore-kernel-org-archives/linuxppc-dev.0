Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6E05D2C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 03:48:47 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 8 Oct 2013 02:48:32 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 89C112CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 03:48:30 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r97GmJsO63045784
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 03:48:19 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r97GmUMh024763
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 03:48:30 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V2 03/14] kvm: powerpc: book3s: pr: Rename KVM_BOOK3S_PR to
 KVM_BOOK3S_PR_POSSIBLE
Date: Mon,  7 Oct 2013 22:17:51 +0530
Message-Id: <1381164482-31001-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

With later patches supporting PR kvm as a kernel module, the changes
that has to be built into the main kernel binary to enable PR KVM module
is now selected via KVM_BOOK3S_PR_POSSIBLE

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h |  2 +-
 arch/powerpc/include/asm/kvm_book3s.h    |  4 ++--
 arch/powerpc/include/asm/kvm_book3s_64.h |  2 +-
 arch/powerpc/include/asm/kvm_host.h      |  2 +-
 arch/powerpc/include/asm/paca.h          |  2 +-
 arch/powerpc/kernel/asm-offsets.c        |  2 +-
 arch/powerpc/kernel/exceptions-64s.S     |  2 +-
 arch/powerpc/kvm/Kconfig                 |  6 +++---
 arch/powerpc/kvm/trace.h                 | 10 +++++-----
 9 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index b86c4db..fe1c62d 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -243,7 +243,7 @@ do_kvm_##n:								\
 #define KVM_HANDLER_SKIP(area, h, n)
 #endif
 
-#ifdef CONFIG_KVM_BOOK3S_PR
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 #define KVMTEST_PR(n)			__KVMTEST(n)
 #define KVM_HANDLER_PR(area, h, n)	__KVM_HANDLER(area, h, n)
 #define KVM_HANDLER_PR_SKIP(area, h, n)	__KVM_HANDLER_SKIP(area, h, n)
diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 0ec00f4..5c07d10 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -304,7 +304,7 @@ static inline ulong kvmppc_get_fault_dar(struct kvm_vcpu *vcpu)
 	return vcpu->arch.fault_dar;
 }
 
-#ifdef CONFIG_KVM_BOOK3S_PR
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 
 static inline unsigned long kvmppc_interrupt_offset(struct kvm_vcpu *vcpu)
 {
@@ -339,7 +339,7 @@ static inline bool kvmppc_critical_section(struct kvm_vcpu *vcpu)
 
 	return crit;
 }
-#else /* CONFIG_KVM_BOOK3S_PR */
+#else /* CONFIG_KVM_BOOK3S_PR_POSSIBLE */
 
 static inline unsigned long kvmppc_interrupt_offset(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 86d638a..e6ee7fd 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -20,7 +20,7 @@
 #ifndef __ASM_KVM_BOOK3S_64_H__
 #define __ASM_KVM_BOOK3S_64_H__
 
-#ifdef CONFIG_KVM_BOOK3S_PR
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 static inline struct kvmppc_book3s_shadow_vcpu *svcpu_get(struct kvm_vcpu *vcpu)
 {
 	preempt_disable();
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index ac40013..a0ca1f4 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -262,7 +262,7 @@ struct kvm_arch {
 	struct kvmppc_vcore *vcores[KVM_MAX_VCORES];
 	int hpt_cma_alloc;
 #endif /* CONFIG_KVM_BOOK3S_64_HV */
-#ifdef CONFIG_KVM_BOOK3S_PR
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	struct mutex hpt_mutex;
 #endif
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 77c91e7..aefe187 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -161,7 +161,7 @@ struct paca_struct {
 	struct dtl_entry *dtl_curr;	/* pointer corresponding to dtl_ridx */
 
 #ifdef CONFIG_KVM_BOOK3S_HANDLER
-#ifdef CONFIG_KVM_BOOK3S_PR
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	/* We use this to store guest state in */
 	struct kvmppc_book3s_shadow_vcpu shadow_vcpu;
 #endif
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index aae7b54..c6c8675 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -530,7 +530,7 @@ int main(void)
 	DEFINE(VCPU_SLB_SIZE, sizeof(struct kvmppc_slb));
 
 #ifdef CONFIG_PPC_BOOK3S_64
-#ifdef CONFIG_KVM_BOOK3S_PR
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	DEFINE(PACA_SVCPU, offsetof(struct paca_struct, shadow_vcpu));
 # define SVCPU_FIELD(x, f)	DEFINE(x, offsetof(struct paca_struct, shadow_vcpu.f))
 #else
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 580d97a..7b75008 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -424,7 +424,7 @@ data_access_check_stab:
 	mfspr	r9,SPRN_DSISR
 	srdi	r10,r10,60
 	rlwimi	r10,r9,16,0x20
-#ifdef CONFIG_KVM_BOOK3S_PR
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	lbz	r9,HSTATE_IN_GUEST(r13)
 	rlwimi	r10,r9,8,0x300
 #endif
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index ffaef2c..d0665f2 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -34,7 +34,7 @@ config KVM_BOOK3S_64_HANDLER
 	bool
 	select KVM_BOOK3S_HANDLER
 
-config KVM_BOOK3S_PR
+config KVM_BOOK3S_PR_POSSIBLE
 	bool
 	select KVM_MMIO
 	select MMU_NOTIFIER
@@ -44,7 +44,7 @@ config KVM_BOOK3S_32
 	depends on PPC_BOOK3S_32 && !SMP && !PTE_64BIT
 	select KVM
 	select KVM_BOOK3S_32_HANDLER
-	select KVM_BOOK3S_PR
+	select KVM_BOOK3S_PR_POSSIBLE
 	---help---
 	  Support running unmodified book3s_32 guest kernels
 	  in virtual machines on book3s_32 host processors.
@@ -91,7 +91,7 @@ config KVM_BOOK3S_64_HV
 config KVM_BOOK3S_64_PR
 	def_bool y
 	depends on KVM_BOOK3S_64 && !KVM_BOOK3S_64_HV
-	select KVM_BOOK3S_PR
+	select KVM_BOOK3S_PR_POSSIBLE
 
 config KVM_BOOKE_HV
 	bool
diff --git a/arch/powerpc/kvm/trace.h b/arch/powerpc/kvm/trace.h
index a088e9a..9e8368e 100644
--- a/arch/powerpc/kvm/trace.h
+++ b/arch/powerpc/kvm/trace.h
@@ -94,7 +94,7 @@ TRACE_EVENT(kvm_exit,
 		__field(	unsigned long,	pc		)
 		__field(	unsigned long,	msr		)
 		__field(	unsigned long,	dar		)
-#ifdef CONFIG_KVM_BOOK3S_PR
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 		__field(	unsigned long,	srr1		)
 #endif
 		__field(	unsigned long,	last_inst	)
@@ -105,7 +105,7 @@ TRACE_EVENT(kvm_exit,
 		__entry->pc		= kvmppc_get_pc(vcpu);
 		__entry->dar		= kvmppc_get_fault_dar(vcpu);
 		__entry->msr		= vcpu->arch.shared->msr;
-#ifdef CONFIG_KVM_BOOK3S_PR
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 		__entry->srr1		= vcpu->arch.shadow_srr1;
 #endif
 		__entry->last_inst	= vcpu->arch.last_inst;
@@ -115,7 +115,7 @@ TRACE_EVENT(kvm_exit,
 		" | pc=0x%lx"
 		" | msr=0x%lx"
 		" | dar=0x%lx"
-#ifdef CONFIG_KVM_BOOK3S_PR
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 		" | srr1=0x%lx"
 #endif
 		" | last_inst=0x%lx"
@@ -124,7 +124,7 @@ TRACE_EVENT(kvm_exit,
 		__entry->pc,
 		__entry->msr,
 		__entry->dar,
-#ifdef CONFIG_KVM_BOOK3S_PR
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 		__entry->srr1,
 #endif
 		__entry->last_inst
@@ -236,7 +236,7 @@ TRACE_EVENT(kvm_check_requests,
  *                         Book3S trace points                           *
  *************************************************************************/
 
-#ifdef CONFIG_KVM_BOOK3S_PR
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 
 TRACE_EVENT(kvm_book3s_reenter,
 	TP_PROTO(int r, struct kvm_vcpu *vcpu),
-- 
1.8.1.2
