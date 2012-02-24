Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1D39DB6FA2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2012 01:26:42 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 07/37] KVM: PPC: e500: merge <asm/kvm_e500.h> into
 arch/powerpc/kvm/e500.h
Date: Fri, 24 Feb 2012 15:26:01 +0100
Message-Id: <1330093591-19523-8-git-send-email-agraf@suse.de>
In-Reply-To: <1330093591-19523-1-git-send-email-agraf@suse.de>
References: <1330093591-19523-1-git-send-email-agraf@suse.de>
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

From: Scott Wood <scottwood@freescale.com>

Keeping two separate headers for e500-specific things was a
pain, and wasn't even organized along any logical boundary.

There was TLB stuff in <asm/kvm_e500.h> despite the existence of
arch/powerpc/kvm/e500_tlb.h, and nothing in <asm/kvm_e500.h> needed
to be referenced from outside arch/powerpc/kvm.

Signed-off-by: Scott Wood <scottwood@freescale.com>
[agraf: fix bisectability]
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_e500.h |   96 -----------------------------------
 arch/powerpc/kvm/e500.c             |    1 -
 arch/powerpc/kvm/e500.h             |   82 ++++++++++++++++++++++++++++--
 arch/powerpc/kvm/e500_emulate.c     |    1 -
 arch/powerpc/kvm/e500_tlb.c         |    1 -
 5 files changed, 78 insertions(+), 103 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/kvm_e500.h

diff --git a/arch/powerpc/include/asm/kvm_e500.h b/arch/powerpc/include/asm/kvm_e500.h
deleted file mode 100644
index 8cd50a5..0000000
--- a/arch/powerpc/include/asm/kvm_e500.h
+++ /dev/null
@@ -1,96 +0,0 @@
-/*
- * Copyright (C) 2008-2011 Freescale Semiconductor, Inc. All rights reserved.
- *
- * Author: Yu Liu, <yu.liu@freescale.com>
- *
- * Description:
- * This file is derived from arch/powerpc/include/asm/kvm_44x.h,
- * by Hollis Blanchard <hollisb@us.ibm.com>.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, version 2, as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_KVM_E500_H__
-#define __ASM_KVM_E500_H__
-
-#include <linux/kvm_host.h>
-
-#define BOOKE_INTERRUPT_SIZE 36
-
-#define E500_PID_NUM   3
-#define E500_TLB_NUM   2
-
-#define E500_TLB_VALID 1
-#define E500_TLB_DIRTY 2
-
-struct tlbe_ref {
-	pfn_t pfn;
-	unsigned int flags; /* E500_TLB_* */
-};
-
-struct tlbe_priv {
-	struct tlbe_ref ref; /* TLB0 only -- TLB1 uses tlb_refs */
-};
-
-struct vcpu_id_table;
-
-struct kvmppc_e500_tlb_params {
-	int entries, ways, sets;
-};
-
-struct kvmppc_vcpu_e500 {
-	/* Unmodified copy of the guest's TLB -- shared with host userspace. */
-	struct kvm_book3e_206_tlb_entry *gtlb_arch;
-
-	/* Starting entry number in gtlb_arch[] */
-	int gtlb_offset[E500_TLB_NUM];
-
-	/* KVM internal information associated with each guest TLB entry */
-	struct tlbe_priv *gtlb_priv[E500_TLB_NUM];
-
-	struct kvmppc_e500_tlb_params gtlb_params[E500_TLB_NUM];
-
-	unsigned int gtlb_nv[E500_TLB_NUM];
-
-	/*
-	 * information associated with each host TLB entry --
-	 * TLB1 only for now.  If/when guest TLB1 entries can be
-	 * mapped with host TLB0, this will be used for that too.
-	 *
-	 * We don't want to use this for guest TLB0 because then we'd
-	 * have the overhead of doing the translation again even if
-	 * the entry is still in the guest TLB (e.g. we swapped out
-	 * and back, and our host TLB entries got evicted).
-	 */
-	struct tlbe_ref *tlb_refs[E500_TLB_NUM];
-	unsigned int host_tlb1_nv;
-
-	u32 host_pid[E500_PID_NUM];
-	u32 pid[E500_PID_NUM];
-	u32 svr;
-
-	/* vcpu id table */
-	struct vcpu_id_table *idt;
-
-	u32 l1csr0;
-	u32 l1csr1;
-	u32 hid0;
-	u32 hid1;
-	u32 tlb0cfg;
-	u32 tlb1cfg;
-	u64 mcar;
-
-	struct page **shared_tlb_pages;
-	int num_shared_tlb_pages;
-
-	struct kvm_vcpu vcpu;
-};
-
-static inline struct kvmppc_vcpu_e500 *to_e500(struct kvm_vcpu *vcpu)
-{
-	return container_of(vcpu, struct kvmppc_vcpu_e500, vcpu);
-}
-
-#endif /* __ASM_KVM_E500_H__ */
diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index 5c450ba..76b35d8 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -20,7 +20,6 @@
 #include <asm/reg.h>
 #include <asm/cputable.h>
 #include <asm/tlbflush.h>
-#include <asm/kvm_e500.h>
 #include <asm/kvm_ppc.h>
 
 #include "booke.h"
diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
index 02ecde2..51d13bd 100644
--- a/arch/powerpc/kvm/e500.h
+++ b/arch/powerpc/kvm/e500.h
@@ -1,11 +1,12 @@
 /*
  * Copyright (C) 2008-2011 Freescale Semiconductor, Inc. All rights reserved.
  *
- * Author: Yu Liu, yu.liu@freescale.com
+ * Author: Yu Liu <yu.liu@freescale.com>
  *
  * Description:
- * This file is based on arch/powerpc/kvm/44x_tlb.h,
- * by Hollis Blanchard <hollisb@us.ibm.com>.
+ * This file is based on arch/powerpc/kvm/44x_tlb.h and
+ * arch/powerpc/include/asm/kvm_44x.h by Hollis Blanchard <hollisb@us.ibm.com>,
+ * Copyright IBM Corp. 2007-2008
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, version 2, as
@@ -18,7 +19,80 @@
 #include <linux/kvm_host.h>
 #include <asm/mmu-book3e.h>
 #include <asm/tlb.h>
-#include <asm/kvm_e500.h>
+
+#define E500_PID_NUM   3
+#define E500_TLB_NUM   2
+
+#define E500_TLB_VALID 1
+#define E500_TLB_DIRTY 2
+
+struct tlbe_ref {
+	pfn_t pfn;
+	unsigned int flags; /* E500_TLB_* */
+};
+
+struct tlbe_priv {
+	struct tlbe_ref ref; /* TLB0 only -- TLB1 uses tlb_refs */
+};
+
+struct vcpu_id_table;
+
+struct kvmppc_e500_tlb_params {
+	int entries, ways, sets;
+};
+
+struct kvmppc_vcpu_e500 {
+	/* Unmodified copy of the guest's TLB -- shared with host userspace. */
+	struct kvm_book3e_206_tlb_entry *gtlb_arch;
+
+	/* Starting entry number in gtlb_arch[] */
+	int gtlb_offset[E500_TLB_NUM];
+
+	/* KVM internal information associated with each guest TLB entry */
+	struct tlbe_priv *gtlb_priv[E500_TLB_NUM];
+
+	struct kvmppc_e500_tlb_params gtlb_params[E500_TLB_NUM];
+
+	unsigned int gtlb_nv[E500_TLB_NUM];
+
+	/*
+	 * information associated with each host TLB entry --
+	 * TLB1 only for now.  If/when guest TLB1 entries can be
+	 * mapped with host TLB0, this will be used for that too.
+	 *
+	 * We don't want to use this for guest TLB0 because then we'd
+	 * have the overhead of doing the translation again even if
+	 * the entry is still in the guest TLB (e.g. we swapped out
+	 * and back, and our host TLB entries got evicted).
+	 */
+	struct tlbe_ref *tlb_refs[E500_TLB_NUM];
+	unsigned int host_tlb1_nv;
+
+	u32 host_pid[E500_PID_NUM];
+	u32 pid[E500_PID_NUM];
+	u32 svr;
+
+	/* vcpu id table */
+	struct vcpu_id_table *idt;
+
+	u32 l1csr0;
+	u32 l1csr1;
+	u32 hid0;
+	u32 hid1;
+	u32 tlb0cfg;
+	u32 tlb1cfg;
+	u64 mcar;
+
+	struct page **shared_tlb_pages;
+	int num_shared_tlb_pages;
+
+	struct kvm_vcpu vcpu;
+};
+
+static inline struct kvmppc_vcpu_e500 *to_e500(struct kvm_vcpu *vcpu)
+{
+	return container_of(vcpu, struct kvmppc_vcpu_e500, vcpu);
+}
 
 /* This geometry is the legacy default -- can be overridden by userspace */
 #define KVM_E500_TLB0_WAY_SIZE		128
diff --git a/arch/powerpc/kvm/e500_emulate.c b/arch/powerpc/kvm/e500_emulate.c
index 2a1a228..7e2d592 100644
--- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -14,7 +14,6 @@
 
 #include <asm/kvm_ppc.h>
 #include <asm/disassemble.h>
-#include <asm/kvm_e500.h>
 
 #include "booke.h"
 #include "e500.h"
diff --git a/arch/powerpc/kvm/e500_tlb.c b/arch/powerpc/kvm/e500_tlb.c
index 1d623a0..7d4a918 100644
--- a/arch/powerpc/kvm/e500_tlb.c
+++ b/arch/powerpc/kvm/e500_tlb.c
@@ -26,7 +26,6 @@
 #include <linux/vmalloc.h>
 #include <linux/hugetlb.h>
 #include <asm/kvm_ppc.h>
-#include <asm/kvm_e500.h>
 
 #include "../mm/mmu_decl.h"
 #include "e500.h"
-- 
1.6.0.2
