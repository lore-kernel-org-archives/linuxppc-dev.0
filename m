Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA34FC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 17:10:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EFD92082E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 17:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFD92082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fVzh0WQwzDq9H
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:10:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.43.205; helo=6.mo1.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 6.mo1.mail-out.ovh.net (6.mo1.mail-out.ovh.net [46.105.43.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fVsY1VdszDqKM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 03:05:36 +1000 (AEST)
Received: from player157.ha.ovh.net (unknown [10.109.146.19])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 11A6D169939
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 19:05:31 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-40-22.w86-201.abo.wanadoo.fr
 [86.201.133.22]) (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id F00B4492A354;
 Wed, 10 Apr 2019 17:05:23 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v5 04/16] KVM: PPC: Book3S HV: XIVE: add a control to
 initialize a source
Date: Wed, 10 Apr 2019 19:04:36 +0200
Message-Id: <20190410170448.3923-5-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410170448.3923-1-clg@kaod.org>
References: <20190410170448.3923-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2475572420681436119
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudejgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kvm@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The XIVE KVM device maintains a list of interrupt sources for the VM
which are allocated in the pool of generic interrupts (IPIs) of the
main XIVE IC controller. These are used for the CPU IPIs as well as
for virtual device interrupts. The IRQ number space is defined by
QEMU.

The XIVE device reuses the source structures of the XICS-on-XIVE
device for the source blocks (2-level tree) and for the source
interrupts. Under XIVE native, the source interrupt caches mostly
configuration information and is less used than under the XICS-on-XIVE
device in which hcalls are still necessary at run-time.

When a source is initialized in KVM, an IPI interrupt source is simply
allocated at the OPAL level and then MASKED. KVM only needs to know
about its type: LSI or MSI.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/uapi/asm/kvm.h        |   5 +
 arch/powerpc/kvm/book3s_xive.h             |  10 ++
 arch/powerpc/kvm/book3s_xive.c             |   8 +-
 arch/powerpc/kvm/book3s_xive_native.c      | 106 +++++++++++++++++++++
 Documentation/virtual/kvm/devices/xive.txt |  15 +++
 5 files changed, 140 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index be0ce1f17625..d468294c2a67 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -679,5 +679,10 @@ struct kvm_ppc_cpu_char {
 
 /* POWER9 XIVE Native Interrupt Controller */
 #define KVM_DEV_XIVE_GRP_CTRL		1
+#define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source identifier */
+
+/* Layout of 64-bit XIVE source attribute values */
+#define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
+#define KVM_XIVE_LEVEL_ASSERTED		(1ULL << 1)
 
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xive.h
index d366df69b9cb..1be921cb5dcb 100644
--- a/arch/powerpc/kvm/book3s_xive.h
+++ b/arch/powerpc/kvm/book3s_xive.h
@@ -12,6 +12,13 @@
 #ifdef CONFIG_KVM_XICS
 #include "book3s_xics.h"
 
+/*
+ * The XIVE Interrupt source numbers are within the range 0 to
+ * KVMPPC_XICS_NR_IRQS.
+ */
+#define KVMPPC_XIVE_FIRST_IRQ	0
+#define KVMPPC_XIVE_NR_IRQS	KVMPPC_XICS_NR_IRQS
+
 /*
  * State for one guest irq source.
  *
@@ -258,6 +265,9 @@ extern int (*__xive_vm_h_eoi)(struct kvm_vcpu *vcpu, unsigned long xirr);
  */
 void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu);
 int kvmppc_xive_debug_show_queues(struct seq_file *m, struct kvm_vcpu *vcpu);
+struct kvmppc_xive_src_block *kvmppc_xive_create_src_block(
+	struct kvmppc_xive *xive, int irq);
+void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb);
 
 #endif /* CONFIG_KVM_XICS */
 #endif /* _KVM_PPC_BOOK3S_XICS_H */
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index e7f1ada1c3de..6c9f9fd0855f 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -1480,8 +1480,8 @@ static int xive_get_source(struct kvmppc_xive *xive, long irq, u64 addr)
 	return 0;
 }
 
-static struct kvmppc_xive_src_block *xive_create_src_block(struct kvmppc_xive *xive,
-							   int irq)
+struct kvmppc_xive_src_block *kvmppc_xive_create_src_block(
+	struct kvmppc_xive *xive, int irq)
 {
 	struct kvm *kvm = xive->kvm;
 	struct kvmppc_xive_src_block *sb;
@@ -1560,7 +1560,7 @@ static int xive_set_source(struct kvmppc_xive *xive, long irq, u64 addr)
 	sb = kvmppc_xive_find_source(xive, irq, &idx);
 	if (!sb) {
 		pr_devel("No source, creating source block...\n");
-		sb = xive_create_src_block(xive, irq);
+		sb = kvmppc_xive_create_src_block(xive, irq);
 		if (!sb) {
 			pr_devel("Failed to create block...\n");
 			return -ENOMEM;
@@ -1784,7 +1784,7 @@ static void kvmppc_xive_cleanup_irq(u32 hw_num, struct xive_irq_data *xd)
 	xive_cleanup_irq_data(xd);
 }
 
-static void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb)
+void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb)
 {
 	int i;
 
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index 6fa73cfd9d9c..5f2bd6c137b7 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -26,6 +26,17 @@
 
 #include "book3s_xive.h"
 
+static u8 xive_vm_esb_load(struct xive_irq_data *xd, u32 offset)
+{
+	u64 val;
+
+	if (xd->flags & XIVE_IRQ_FLAG_SHIFT_BUG)
+		offset |= offset << 4;
+
+	val = in_be64(xd->eoi_mmio + offset);
+	return (u8)val;
+}
+
 static void kvmppc_xive_native_cleanup_queue(struct kvm_vcpu *vcpu, int prio)
 {
 	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
@@ -154,12 +165,94 @@ int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
 	return rc;
 }
 
+static int kvmppc_xive_native_set_source(struct kvmppc_xive *xive, long irq,
+					 u64 addr)
+{
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	u64 __user *ubufp = (u64 __user *) addr;
+	u64 val;
+	u16 idx;
+	int rc;
+
+	pr_devel("%s irq=0x%lx\n", __func__, irq);
+
+	if (irq < KVMPPC_XIVE_FIRST_IRQ || irq >= KVMPPC_XIVE_NR_IRQS)
+		return -E2BIG;
+
+	sb = kvmppc_xive_find_source(xive, irq, &idx);
+	if (!sb) {
+		pr_debug("No source, creating source block...\n");
+		sb = kvmppc_xive_create_src_block(xive, irq);
+		if (!sb) {
+			pr_err("Failed to create block...\n");
+			return -ENOMEM;
+		}
+	}
+	state = &sb->irq_state[idx];
+
+	if (get_user(val, ubufp)) {
+		pr_err("fault getting user info !\n");
+		return -EFAULT;
+	}
+
+	arch_spin_lock(&sb->lock);
+
+	/*
+	 * If the source doesn't already have an IPI, allocate
+	 * one and get the corresponding data
+	 */
+	if (!state->ipi_number) {
+		state->ipi_number = xive_native_alloc_irq();
+		if (state->ipi_number == 0) {
+			pr_err("Failed to allocate IRQ !\n");
+			rc = -ENXIO;
+			goto unlock;
+		}
+		xive_native_populate_irq_data(state->ipi_number,
+					      &state->ipi_data);
+		pr_debug("%s allocated hw_irq=0x%x for irq=0x%lx\n", __func__,
+			 state->ipi_number, irq);
+	}
+
+	/* Restore LSI state */
+	if (val & KVM_XIVE_LEVEL_SENSITIVE) {
+		state->lsi = true;
+		if (val & KVM_XIVE_LEVEL_ASSERTED)
+			state->asserted = true;
+		pr_devel("  LSI ! Asserted=%d\n", state->asserted);
+	}
+
+	/* Mask IRQ to start with */
+	state->act_server = 0;
+	state->act_priority = MASKED;
+	xive_vm_esb_load(&state->ipi_data, XIVE_ESB_SET_PQ_01);
+	xive_native_configure_irq(state->ipi_number, 0, MASKED, 0);
+
+	/* Increment the number of valid sources and mark this one valid */
+	if (!state->valid)
+		xive->src_count++;
+	state->valid = true;
+
+	rc = 0;
+
+unlock:
+	arch_spin_unlock(&sb->lock);
+
+	return rc;
+}
+
 static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
 				       struct kvm_device_attr *attr)
 {
+	struct kvmppc_xive *xive = dev->private;
+
 	switch (attr->group) {
 	case KVM_DEV_XIVE_GRP_CTRL:
 		break;
+	case KVM_DEV_XIVE_GRP_SOURCE:
+		return kvmppc_xive_native_set_source(xive, attr->attr,
+						     attr->addr);
 	}
 	return -ENXIO;
 }
@@ -176,6 +269,11 @@ static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
 	switch (attr->group) {
 	case KVM_DEV_XIVE_GRP_CTRL:
 		break;
+	case KVM_DEV_XIVE_GRP_SOURCE:
+		if (attr->attr >= KVMPPC_XIVE_FIRST_IRQ &&
+		    attr->attr < KVMPPC_XIVE_NR_IRQS)
+			return 0;
+		break;
 	}
 	return -ENXIO;
 }
@@ -184,6 +282,7 @@ static void kvmppc_xive_native_free(struct kvm_device *dev)
 {
 	struct kvmppc_xive *xive = dev->private;
 	struct kvm *kvm = xive->kvm;
+	int i;
 
 	debugfs_remove(xive->dentry);
 
@@ -192,6 +291,13 @@ static void kvmppc_xive_native_free(struct kvm_device *dev)
 	if (kvm)
 		kvm->arch.xive = NULL;
 
+	for (i = 0; i <= xive->max_sbid; i++) {
+		if (xive->src_blocks[i])
+			kvmppc_xive_free_sources(xive->src_blocks[i]);
+		kfree(xive->src_blocks[i]);
+		xive->src_blocks[i] = NULL;
+	}
+
 	if (xive->vp_base != XIVE_INVALID_VP)
 		xive_native_free_vp_block(xive->vp_base);
 
diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/virtual/kvm/devices/xive.txt
index fdbd2ff92a88..cd8bfc37b72e 100644
--- a/Documentation/virtual/kvm/devices/xive.txt
+++ b/Documentation/virtual/kvm/devices/xive.txt
@@ -17,3 +17,18 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
 
   1. KVM_DEV_XIVE_GRP_CTRL
   Provides global controls on the device
+
+  2. KVM_DEV_XIVE_GRP_SOURCE (write only)
+  Initializes a new source in the XIVE device and mask it.
+  Attributes:
+    Interrupt source number  (64-bit)
+  The kvm_device_attr.addr points to a __u64 value:
+  bits:     | 63   ....  2 |   1   |   0
+  values:   |    unused    | level | type
+  - type:  0:MSI 1:LSI
+  - level: assertion level in case of an LSI.
+  Errors:
+    -E2BIG:  Interrupt source number is out of range
+    -ENOMEM: Could not create a new source block
+    -EFAULT: Invalid user pointer for attr->addr.
+    -ENXIO:  Could not allocate underlying HW interrupt
-- 
2.20.1

