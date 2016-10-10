Return-Path: <dja@axtens.net>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ssgzr2XTYzDrPL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 11:31:52 +1100 (AEDT)
Received: by mail-pa0-x241.google.com with SMTP id hh10so6038623pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Oct 2016 17:31:52 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, paulus@samba.org
Cc: Daniel Axtens <dja@axtens.net>
Subject: [PATCH 2/2] KVM: PPC: sparse: prototypes for functions called from
 assembler
Date: Mon, 10 Oct 2016 11:31:20 +1100
Message-Id: <1476059480-18145-2-git-send-email-dja@axtens.net>
In-Reply-To: <1476059480-18145-1-git-send-email-dja@axtens.net>
References: <1476059480-18145-1-git-send-email-dja@axtens.net>
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
This reduces sparse warnings.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/include/asm/asm-prototypes.h | 44 +++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_64_vio_hv.c       |  1 +
 arch/powerpc/kvm/book3s_hv_builtin.c      |  1 +
 arch/powerpc/kvm/book3s_hv_ras.c          |  1 +
 arch/powerpc/kvm/book3s_hv_rm_mmu.c       |  1 +
 arch/powerpc/kvm/book3s_hv_rm_xics.c      |  1 +
 6 files changed, 49 insertions(+)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index d1492736d852..6c853bcd11fa 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -14,6 +14,9 @@
 
 #include <linux/threads.h>
 #include <linux/kprobes.h>
+#ifdef CONFIG_KVM
+#include <linux/kvm_host.h>
+#endif
 
 #include <uapi/asm/ucontext.h>
 
@@ -109,4 +112,45 @@ void early_setup_secondary(void);
 /* time */
 void accumulate_stolen_time(void);
 
+/* kvm */
+#ifdef CONFIG_KVM
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
+#endif
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
index 0c84d6bc8356..90a0b274e699 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -26,6 +26,7 @@
 #include <asm/dbell.h>
 #include <asm/cputhreads.h>
 #include <asm/io.h>
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
index 82ff5de8b1e7..6de32e610c5d 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -23,6 +23,7 @@
 #include <asm/ppc-opcode.h>
 #include <asm/pnv-pci.h>
 #include <asm/opal.h>
+#include <asm/asm-prototypes.h>
 
 #include "book3s_xics.h"
 
-- 
2.7.4
