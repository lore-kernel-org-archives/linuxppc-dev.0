Return-Path: <SRS0=vpml=PP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2396AC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 19:30:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B6092085A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 19:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6092085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YQTj4rv1zDqPY
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 06:30:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.50.32; helo=7.mo69.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 2215 seconds by postgrey-1.36 at bilbo;
 Tue, 08 Jan 2019 06:22:31 AEDT
Received: from 7.mo69.mail-out.ovh.net (7.mo69.mail-out.ovh.net [46.105.50.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YQJR2bDPzDqHx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 06:22:30 +1100 (AEDT)
Received: from player737.ha.ovh.net (unknown [10.109.159.73])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 4AB7438706
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jan 2019 19:45:32 +0100 (CET)
Received: from kaod.org (lfbn-1-10605-110.w90-89.abo.wanadoo.fr
 [90.89.196.110]) (Authenticated sender: clg@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id 6A97B1866453;
 Mon,  7 Jan 2019 18:45:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 09/19] KVM: PPC: Book3S HV: add a SET_SOURCE control to the
 XIVE native device
Date: Mon,  7 Jan 2019 19:43:21 +0100
Message-Id: <20190107184331.8429-10-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107184331.8429-1-clg@kaod.org>
References: <20190107184331.8429-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11406491959938485207
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrvdejgdduudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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

Interrupt sources are simply created at the OPAL level and then
MASKED. KVM only needs to know about their type: LSI or MSI.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/include/uapi/asm/kvm.h           |  5 +
 arch/powerpc/kvm/book3s_xive_native.c         | 98 +++++++++++++++++++
 .../powerpc/kvm/book3s_xive_native_template.c | 27 +++++
 3 files changed, 130 insertions(+)
 create mode 100644 arch/powerpc/kvm/book3s_xive_native_template.c

diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 8b78b12aa118..6fc9660c5aec 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -680,5 +680,10 @@ struct kvm_ppc_cpu_char {
 #define   KVM_DEV_XIVE_GET_ESB_FD	1
 #define   KVM_DEV_XIVE_GET_TIMA_FD	2
 #define   KVM_DEV_XIVE_VC_BASE		3
+#define KVM_DEV_XIVE_GRP_SOURCES	2	/* 64-bit source attributes */
+
+/* Layout of 64-bit XIVE source attribute values */
+#define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
+#define KVM_XIVE_LEVEL_ASSERTED		(1ULL << 1)
 
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index 29a62914de55..2518640d4a58 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -31,6 +31,24 @@
 
 #include "book3s_xive.h"
 
+/*
+ * We still instantiate them here because we use some of the
+ * generated utility functions as well in this file.
+ */
+#define XIVE_RUNTIME_CHECKS
+#define X_PFX xive_vm_
+#define X_STATIC static
+#define X_STAT_PFX stat_vm_
+#define __x_tima		xive_tima
+#define __x_eoi_page(xd)	((void __iomem *)((xd)->eoi_mmio))
+#define __x_trig_page(xd)	((void __iomem *)((xd)->trig_mmio))
+#define __x_writeb	__raw_writeb
+#define __x_readw	__raw_readw
+#define __x_readq	__raw_readq
+#define __x_writeq	__raw_writeq
+
+#include "book3s_xive_native_template.c"
+
 static void xive_native_cleanup_queue(struct kvm_vcpu *vcpu, int prio)
 {
 	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
@@ -305,6 +323,78 @@ static int kvmppc_xive_native_get_tima_fd(struct kvmppc_xive *xive, u64 addr)
 	return put_user(ret, ubufp);
 }
 
+static int kvmppc_xive_native_set_source(struct kvmppc_xive *xive, long irq,
+					 u64 addr)
+{
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	u64 __user *ubufp = (u64 __user *) addr;
+	u64 val;
+	u16 idx;
+
+	pr_devel("%s irq=0x%lx\n", __func__, irq);
+
+	if (irq < KVMPPC_XIVE_FIRST_IRQ || irq >= KVMPPC_XIVE_NR_IRQS)
+		return -ENOENT;
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
+	/*
+	 * If the source doesn't already have an IPI, allocate
+	 * one and get the corresponding data
+	 */
+	if (!state->ipi_number) {
+		state->ipi_number = xive_native_alloc_irq();
+		if (state->ipi_number == 0) {
+			pr_err("Failed to allocate IRQ !\n");
+			return -ENOMEM;
+		}
+		xive_native_populate_irq_data(state->ipi_number,
+					      &state->ipi_data);
+		pr_debug("%s allocated hw_irq=0x%x for irq=0x%lx\n", __func__,
+			 state->ipi_number, irq);
+	}
+
+	arch_spin_lock(&sb->lock);
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
+	arch_spin_unlock(&sb->lock);
+
+	return 0;
+}
+
 static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
 				       struct kvm_device_attr *attr)
 {
@@ -317,6 +407,9 @@ static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
 			return kvmppc_xive_native_set_vc_base(xive, attr->addr);
 		}
 		break;
+	case KVM_DEV_XIVE_GRP_SOURCES:
+		return kvmppc_xive_native_set_source(xive, attr->attr,
+						     attr->addr);
 	}
 	return -ENXIO;
 }
@@ -353,6 +446,11 @@ static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
 			return 0;
 		}
 		break;
+	case KVM_DEV_XIVE_GRP_SOURCES:
+		if (attr->attr >= KVMPPC_XIVE_FIRST_IRQ &&
+		    attr->attr < KVMPPC_XIVE_NR_IRQS)
+			return 0;
+		break;
 	}
 	return -ENXIO;
 }
diff --git a/arch/powerpc/kvm/book3s_xive_native_template.c b/arch/powerpc/kvm/book3s_xive_native_template.c
new file mode 100644
index 000000000000..e7260da4a596
--- /dev/null
+++ b/arch/powerpc/kvm/book3s_xive_native_template.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017-2019, IBM Corporation.
+ */
+
+/* File to be included by other .c files */
+
+#define XGLUE(a, b) a##b
+#define GLUE(a, b) XGLUE(a, b)
+
+/*
+ * TODO: introduce a common template file with the XIVE native layer
+ * and the XICS-on-XIVE glue for the utility functions
+ */
+static u8 GLUE(X_PFX, esb_load)(struct xive_irq_data *xd, u32 offset)
+{
+	u64 val;
+
+	if (xd->flags & XIVE_IRQ_FLAG_SHIFT_BUG)
+		offset |= offset << 4;
+
+	val = __x_readq(__x_eoi_page(xd) + offset);
+#ifdef __LITTLE_ENDIAN__
+	val >>= 64-8;
+#endif
+	return (u8)val;
+}
-- 
2.20.1

