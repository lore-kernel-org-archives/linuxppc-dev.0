Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTjTV3B7GzDvyT
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 14:30:06 +1100 (AEDT)
Date: Thu, 1 Dec 2016 14:30:04 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] KVM: PPC: Book3S: Move prototypes for KVM functions into
 kvm_ppc.h
Message-ID: <20161201033004.2yh4txylpayxzmpu@oak.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves the prototypes for functions that are only called from
assembler code out of asm/asm-prototypes.h into asm/kvm_ppc.h.
The prototypes were added in commit ebe4535fbe7a ("KVM: PPC:
Book3S HV: sparse: prototypes for functions called from assembler",
2016-10-10), but given that the functions are KVM functions,
having them in a KVM header will be better for long-term
maintenance.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
[For information; I intend to merge this through the KVM tree.]

 arch/powerpc/include/asm/asm-prototypes.h | 44 -------------------------------
 arch/powerpc/include/asm/kvm_ppc.h        | 42 +++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_64_vio_hv.c       |  1 -
 arch/powerpc/kvm/book3s_hv_builtin.c      |  1 -
 arch/powerpc/kvm/book3s_hv_ras.c          |  2 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c       |  1 -
 arch/powerpc/kvm/book3s_hv_rm_xics.c      |  1 -
 7 files changed, 43 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 6c853bc..d149273 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -14,9 +14,6 @@
 
 #include <linux/threads.h>
 #include <linux/kprobes.h>
-#ifdef CONFIG_KVM
-#include <linux/kvm_host.h>
-#endif
 
 #include <uapi/asm/ucontext.h>
 
@@ -112,45 +109,4 @@ void early_setup_secondary(void);
 /* time */
 void accumulate_stolen_time(void);
 
-/* kvm */
-#ifdef CONFIG_KVM
-long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
-			 unsigned long ioba, unsigned long tce);
-long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
-				  unsigned long liobn, unsigned long ioba,
-				  unsigned long tce_list, unsigned long npages);
-long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
-			   unsigned long liobn, unsigned long ioba,
-			   unsigned long tce_value, unsigned long npages);
-long int kvmppc_rm_h_confer(struct kvm_vcpu *vcpu, int target,
-                            unsigned int yield_count);
-long kvmppc_h_random(struct kvm_vcpu *vcpu);
-void kvmhv_commence_exit(int trap);
-long kvmppc_realmode_machine_check(struct kvm_vcpu *vcpu);
-void kvmppc_subcore_enter_guest(void);
-void kvmppc_subcore_exit_guest(void);
-long kvmppc_realmode_hmi_handler(void);
-long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
-                    long pte_index, unsigned long pteh, unsigned long ptel);
-long kvmppc_h_remove(struct kvm_vcpu *vcpu, unsigned long flags,
-                     unsigned long pte_index, unsigned long avpn);
-long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu);
-long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
-                      unsigned long pte_index, unsigned long avpn,
-                      unsigned long va);
-long kvmppc_h_read(struct kvm_vcpu *vcpu, unsigned long flags,
-                   unsigned long pte_index);
-long kvmppc_h_clear_ref(struct kvm_vcpu *vcpu, unsigned long flags,
-                        unsigned long pte_index);
-long kvmppc_h_clear_mod(struct kvm_vcpu *vcpu, unsigned long flags,
-                        unsigned long pte_index);
-long kvmppc_hpte_hv_fault(struct kvm_vcpu *vcpu, unsigned long addr,
-                          unsigned long slb_v, unsigned int status, bool data);
-unsigned long kvmppc_rm_h_xirr(struct kvm_vcpu *vcpu);
-int kvmppc_rm_h_ipi(struct kvm_vcpu *vcpu, unsigned long server,
-                    unsigned long mfrr);
-int kvmppc_rm_h_cppr(struct kvm_vcpu *vcpu, unsigned long cppr);
-int kvmppc_rm_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr);
-#endif
-
 #endif /* _ASM_POWERPC_ASM_PROTOTYPES_H */
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index a5b94be..2da67bf 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -511,6 +511,48 @@ static inline int kvmppc_xics_hcall(struct kvm_vcpu *vcpu, u32 cmd)
 #endif
 
 /*
+ * Prototypes for functions called only from assembler code.
+ * Having prototypes reduces sparse errors.
+ */
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
+/*
  * Host-side operations we want to set up while running in real
  * mode in the guest operating on the xics.
  * Currently only VCPU wakeup is supported.
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 66e9827..e4c4ea9 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -39,7 +39,6 @@
 #include <asm/udbg.h>
 #include <asm/iommu.h>
 #include <asm/tce.h>
-#include <asm/asm-prototypes.h>
 
 #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
 
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index 11561f0..5bb24be 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -26,7 +26,6 @@
 #include <asm/dbell.h>
 #include <asm/cputhreads.h>
 #include <asm/io.h>
-#include <asm/asm-prototypes.h>
 #include <asm/opal.h>
 #include <asm/smp.h>
 
diff --git a/arch/powerpc/kvm/book3s_hv_ras.c b/arch/powerpc/kvm/book3s_hv_ras.c
index be1cee5..7ef0993 100644
--- a/arch/powerpc/kvm/book3s_hv_ras.c
+++ b/arch/powerpc/kvm/book3s_hv_ras.c
@@ -16,7 +16,7 @@
 #include <asm/machdep.h>
 #include <asm/cputhreads.h>
 #include <asm/hmi.h>
-#include <asm/asm-prototypes.h>
+#include <asm/kvm_ppc.h>
 
 /* SRR1 bits for machine check on POWER7 */
 #define SRR1_MC_LDSTERR		(1ul << (63-42))
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 378b962..9ef3c4b 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -21,7 +21,6 @@
 #include <asm/hvcall.h>
 #include <asm/synch.h>
 #include <asm/ppc-opcode.h>
-#include <asm/asm-prototypes.h>
 
 /* Translate address of a vmalloc'd thing to a linear map address */
 static void *real_vmalloc_addr(void *x)
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index 6a4c4d75..06edc43 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -24,7 +24,6 @@
 #include <asm/pnv-pci.h>
 #include <asm/opal.h>
 #include <asm/smp.h>
-#include <asm/asm-prototypes.h>
 
 #include "book3s_xics.h"
 
-- 
2.10.2
