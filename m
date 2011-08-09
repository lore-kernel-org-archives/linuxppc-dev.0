Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 14921B732E
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2011 02:32:00 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 07/10] KVM: PPC: Add PAPR hypercall code for PR mode
Date: Tue,  9 Aug 2011 18:31:45 +0200
Message-Id: <1312907508-14599-8-git-send-email-agraf@suse.de>
In-Reply-To: <1312907508-14599-1-git-send-email-agraf@suse.de>
References: <1312907508-14599-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When running a PAPR guest, we need to handle a few hypercalls in kernel space,
most prominently the page table invalidation (to sync the shadows).

So this patch adds handling for a few PAPR hypercalls to PR mode KVM. I tried
to share the code with HV mode, but it ended up being a lot easier this way
around, as the two differ too much in those details.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_book3s.h |    1 +
 arch/powerpc/kvm/Makefile             |    1 +
 arch/powerpc/kvm/book3s_pr_papr.c     |  158 +++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/kvm/book3s_pr_papr.c

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 472437b..91d41fa 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -150,6 +150,7 @@ extern void kvmppc_load_up_altivec(void);
 extern void kvmppc_load_up_vsx(void);
 extern u32 kvmppc_alignment_dsisr(struct kvm_vcpu *vcpu, unsigned int inst);
 extern ulong kvmppc_alignment_dar(struct kvm_vcpu *vcpu, unsigned int inst);
+extern int kvmppc_h_pr(struct kvm_vcpu *vcpu, unsigned long cmd);
 
 static inline struct kvmppc_vcpu_book3s *to_book3s(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index 08428e2..4c66d51 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -43,6 +43,7 @@ kvm-book3s_64-objs-$(CONFIG_KVM_BOOK3S_64_PR) := \
 	fpu.o \
 	book3s_paired_singles.o \
 	book3s_pr.o \
+	book3s_pr_papr.o \
 	book3s_emulate.o \
 	book3s_interrupts.o \
 	book3s_mmu_hpte.o \
diff --git a/arch/powerpc/kvm/book3s_pr_papr.c b/arch/powerpc/kvm/book3s_pr_papr.c
new file mode 100644
index 0000000..b8ec55f
--- /dev/null
+++ b/arch/powerpc/kvm/book3s_pr_papr.c
@@ -0,0 +1,158 @@
+/*
+ * Copyright (C) 2011. Freescale Inc. All rights reserved.
+ *
+ * Authors:
+ *    Alexander Graf <agraf@suse.de>
+ *    Paul Mackerras <paulus@samba.org>
+ *
+ * Description:
+ *
+ * Hypercall handling for running PAPR guests in PR KVM on Book 3S
+ * processors.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ */
+
+#include <asm/uaccess.h>
+#include <asm/kvm_ppc.h>
+#include <asm/kvm_book3s.h>
+
+static unsigned long get_pteg_addr(struct kvm_vcpu *vcpu, long pte_index)
+{
+	struct kvmppc_vcpu_book3s *vcpu_book3s = to_book3s(vcpu);
+	unsigned long pteg_addr;
+
+	pte_index <<= 4;
+	pte_index &= ((1 << ((vcpu_book3s->sdr1 & 0x1f) + 11)) - 1) << 7 | 0x70;
+        pteg_addr = vcpu_book3s->sdr1 & 0xfffffffffffc0000ULL;
+	pteg_addr |= pte_index;
+
+	return pteg_addr;
+}
+
+static int kvmppc_h_pr_enter(struct kvm_vcpu *vcpu)
+{
+	long flags = kvmppc_get_gpr(vcpu, 4);
+	long pte_index = kvmppc_get_gpr(vcpu, 5);
+	unsigned long pteg[2 * 8];
+	unsigned long pteg_addr, i, *hpte;
+
+	pte_index &= ~7UL;
+	pteg_addr = get_pteg_addr(vcpu, pte_index);
+
+	copy_from_user(pteg, (void __user *)pteg_addr, sizeof(pteg));
+	hpte = pteg;
+
+	if (likely((flags & H_EXACT) == 0)) {
+		pte_index &= ~7UL;
+		for (i = 0; ; ++i) {
+			if (i == 8)
+				return H_PTEG_FULL;
+			if ((*hpte & HPTE_V_VALID) == 0)
+				break;
+			hpte += 2;
+		}
+	} else {
+		i = kvmppc_get_gpr(vcpu, 5) & 7UL;
+		hpte += i * 2;
+	}
+
+	hpte[0] = kvmppc_get_gpr(vcpu, 6);
+	hpte[1] = kvmppc_get_gpr(vcpu, 7);
+	copy_to_user((void __user *)pteg_addr, pteg, sizeof(pteg));
+	kvmppc_set_gpr(vcpu, 3, H_SUCCESS);
+	kvmppc_set_gpr(vcpu, 4, pte_index | i);
+
+	return EMULATE_DONE;
+}
+
+static int kvmppc_h_pr_remove(struct kvm_vcpu *vcpu)
+{
+	unsigned long flags= kvmppc_get_gpr(vcpu, 4);
+	unsigned long pte_index = kvmppc_get_gpr(vcpu, 5);
+	unsigned long avpn = kvmppc_get_gpr(vcpu, 6);
+	unsigned long v = 0, pteg, rb;
+	unsigned long pte[2];
+
+	pteg = get_pteg_addr(vcpu, pte_index);
+	copy_from_user(pte, (void __user *)pteg, sizeof(pte));
+
+	if ((pte[0] & HPTE_V_VALID) == 0 ||
+	    ((flags & H_AVPN) && (pte[0] & ~0x7fUL) != avpn) ||
+	    ((flags & H_ANDCOND) && (pte[0] & avpn) != 0)) {
+		kvmppc_set_gpr(vcpu, 3, H_NOT_FOUND);
+		return EMULATE_DONE;
+	}
+
+	copy_to_user((void __user *)pteg, &v, sizeof(v));
+
+	rb = compute_tlbie_rb(pte[0], pte[1], pte_index);
+	vcpu->arch.mmu.tlbie(vcpu, rb, rb & 1 ? true : false);
+
+	kvmppc_set_gpr(vcpu, 3, H_SUCCESS);
+	kvmppc_set_gpr(vcpu, 4, pte[0]);
+	kvmppc_set_gpr(vcpu, 5, pte[1]);
+
+	return EMULATE_DONE;
+}
+
+static int kvmppc_h_pr_protect(struct kvm_vcpu *vcpu)
+{
+	unsigned long flags = kvmppc_get_gpr(vcpu, 4);
+	unsigned long pte_index = kvmppc_get_gpr(vcpu, 5);
+	unsigned long avpn = kvmppc_get_gpr(vcpu, 6);
+	unsigned long rb, pteg, r, v;
+	unsigned long pte[2];
+
+	pteg = get_pteg_addr(vcpu, pte_index);
+	copy_from_user(pte, (void __user *)pteg, sizeof(pte));
+
+	if ((pte[0] & HPTE_V_VALID) == 0 ||
+	    ((flags & H_AVPN) && (pte[0] & ~0x7fUL) != avpn)) {
+		kvmppc_set_gpr(vcpu, 3, H_NOT_FOUND);
+		return EMULATE_DONE;
+	}
+
+	v = pte[0];
+	r = pte[1];
+	r &= ~(HPTE_R_PP0 | HPTE_R_PP | HPTE_R_N | HPTE_R_KEY_HI |
+	       HPTE_R_KEY_LO);
+	r |= (flags << 55) & HPTE_R_PP0;
+	r |= (flags << 48) & HPTE_R_KEY_HI;
+	r |= flags & (HPTE_R_PP | HPTE_R_N | HPTE_R_KEY_LO);
+
+	pte[1] = r;
+
+	rb = compute_tlbie_rb(v, r, pte_index);
+	vcpu->arch.mmu.tlbie(vcpu, rb, rb & 1 ? true : false);
+	copy_to_user((void __user *)pteg, pte, sizeof(pte));
+
+	kvmppc_set_gpr(vcpu, 3, H_SUCCESS);
+
+	return EMULATE_DONE;
+}
+
+int kvmppc_h_pr(struct kvm_vcpu *vcpu, unsigned long cmd)
+{
+	switch (cmd) {
+	case H_ENTER:
+		return kvmppc_h_pr_enter(vcpu);
+	case H_REMOVE:
+		return kvmppc_h_pr_remove(vcpu);
+	case H_PROTECT:
+		return kvmppc_h_pr_protect(vcpu);
+	case H_BULK_REMOVE:
+		/* We just flush all PTEs, so user space can
+		   handle the HPT modifications */
+		kvmppc_mmu_pte_flush(vcpu, 0, 0);
+		break;
+	case H_CEDE:
+		kvm_vcpu_block(vcpu);
+		vcpu->stat.halt_wakeup++;
+		return EMULATE_DONE;
+	}
+
+	return EMULATE_FAIL;
+}
-- 
1.6.0.2
