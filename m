Return-Path: <dja@axtens.net>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sQJLD0FLwzDrgX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Sep 2016 09:26:44 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id cf3so4763686pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Sep 2016 16:26:43 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Daniel Axtens <dja@axtens.net>
Subject: [PATCH 2/3] powerpc/kvm: sparse: prototypes for functions called from
 assembler
Date: Fri,  2 Sep 2016 09:26:20 +1000
Message-Id: <1472772381-22696-2-git-send-email-dja@axtens.net>
In-Reply-To: <1472772381-22696-1-git-send-email-dja@axtens.net>
References: <1472772381-22696-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A bunch of KVM functions are only called from assembler.
Give them prototypes in asm-prototypes.h

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/include/asm/asm-prototypes.h | 39 +++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_64_vio_hv.c       |  1 +
 arch/powerpc/kvm/book3s_hv_builtin.c      |  1 +
 arch/powerpc/kvm/book3s_hv_ras.c          |  1 +
 arch/powerpc/kvm/book3s_hv_rm_mmu.c       |  1 +
 arch/powerpc/kvm/book3s_hv_rm_xics.c      |  1 +
 6 files changed, 44 insertions(+)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index e71b9097594c..600c7994e99e 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -72,4 +72,43 @@ void system_reset_exception(struct pt_regs *regs);
 void machine_check_exception(struct pt_regs *regs);
 void __kprobes emulation_assist_interrupt(struct pt_regs *regs);
 
+/* kvm */
+long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
+			 unsigned long ioba, unsigned long tce);
+long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
+				  unsigned long liobn, unsigned long ioba,
+				  unsigned long tce_list, unsigned long npages);
+long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
+			   unsigned long liobn, unsigned long ioba,
+			   unsigned long tce_value, unsigned long npages);
+long int kvmppc_rm_h_confer(struct kvm_vcpu *vcpu, int target,
+                            unsigned int yield_count);
+long kvmppc_h_random(struct kvm_vcpu *vcpu);
+void kvmhv_commence_exit(int trap);
+long kvmppc_realmode_machine_check(struct kvm_vcpu *vcpu);
+void kvmppc_subcore_enter_guest(void);
+void kvmppc_subcore_exit_guest(void);
+long kvmppc_realmode_hmi_handler(void);
+long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
+                    long pte_index, unsigned long pteh, unsigned long ptel);
+long kvmppc_h_remove(struct kvm_vcpu *vcpu, unsigned long flags,
+                     unsigned long pte_index, unsigned long avpn);
+long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu);
+long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
+                      unsigned long pte_index, unsigned long avpn,
+                      unsigned long va);
+long kvmppc_h_read(struct kvm_vcpu *vcpu, unsigned long flags,
+                   unsigned long pte_index);
+long kvmppc_h_clear_ref(struct kvm_vcpu *vcpu, unsigned long flags,
+                        unsigned long pte_index);
+long kvmppc_h_clear_mod(struct kvm_vcpu *vcpu, unsigned long flags,
+                        unsigned long pte_index);
+long kvmppc_hpte_hv_fault(struct kvm_vcpu *vcpu, unsigned long addr,
+                          unsigned long slb_v, unsigned int status, bool data);
+unsigned long kvmppc_rm_h_xirr(struct kvm_vcpu *vcpu);
+int kvmppc_rm_h_ipi(struct kvm_vcpu *vcpu, unsigned long server,
+                    unsigned long mfrr);
+int kvmppc_rm_h_cppr(struct kvm_vcpu *vcpu, unsigned long cppr);
+int kvmppc_rm_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr);
+
 #endif /* _ASM_POWERPC_ASM_PROTOTYPES_H */
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index d461c440889a..30f83cf1b98e 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -40,6 +40,7 @@
 #include <asm/iommu.h>
 #include <asm/tce.h>
 #include <asm/iommu.h>
+#include <asm/asm-prototypes.h>
 
 #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
 
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index 5f0380db3eab..b997000323a2 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -25,6 +25,7 @@
 #include <asm/xics.h>
 #include <asm/dbell.h>
 #include <asm/cputhreads.h>
+#include <asm/asm-prototypes.h>
 
 #define KVM_CMA_CHUNK_ORDER	18
 
diff --git a/arch/powerpc/kvm/book3s_hv_ras.c b/arch/powerpc/kvm/book3s_hv_ras.c
index 0fa70a9618d7..be1cee5dc032 100644
--- a/arch/powerpc/kvm/book3s_hv_ras.c
+++ b/arch/powerpc/kvm/book3s_hv_ras.c
@@ -16,6 +16,7 @@
 #include <asm/machdep.h>
 #include <asm/cputhreads.h>
 #include <asm/hmi.h>
+#include <asm/asm-prototypes.h>
 
 /* SRR1 bits for machine check on POWER7 */
 #define SRR1_MC_LDSTERR		(1ul << (63-42))
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 99b4e9d5dd23..6b3d01b024d7 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -21,6 +21,7 @@
 #include <asm/hvcall.h>
 #include <asm/synch.h>
 #include <asm/ppc-opcode.h>
+#include <asm/asm-prototypes.h>
 
 /* Translate address of a vmalloc'd thing to a linear map address */
 static void *real_vmalloc_addr(void *x)
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index 980d8a6f7284..8524382981a8 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -19,6 +19,7 @@
 #include <asm/synch.h>
 #include <asm/cputhreads.h>
 #include <asm/ppc-opcode.h>
+#include <asm/asm-prototypes.h>
 
 #include "book3s_xics.h"
 
-- 
2.7.4
