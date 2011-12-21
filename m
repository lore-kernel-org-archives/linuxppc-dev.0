Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
 [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id E62EBB71EC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 12:34:36 +1100 (EST)
Date: Tue, 20 Dec 2011 19:34:31 -0600
From: Scott Wood <scottwood@freescale.com>
To: <agraf@suse.de>
Subject: [RFC PATCH 08/16] KVM: PPC: e500: merge <asm/kvm_e500.h> into
 arch/powerpc/kvm/e500.h
Message-ID: <20111221013431.GH8378@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20111221013340.GA8368@schlenkerla.am.freescale.net>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Keeping two separate headers for e500-specific things was a
pain, and wasn't even organized along any logical boundary.

There was TLB stuff in <asm/kvm_e500.h> despite the existence of
arch/powerpc/kvm/e500_tlb.h, and nothing in <asm/kvm_e500.h> needed
to be referenced from outside arch/powerpc/kvm.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/kvm_e500.h |   96 -----------------------------------
 arch/powerpc/kvm/e500.h             |   82 ++++++++++++++++++++++++++++--
 2 files changed, 78 insertions(+), 100 deletions(-)
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
-- 
1.7.7.rc3.4.g8d714
