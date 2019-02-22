Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EDCC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:39:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40E1F2075A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E1F2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445Trz2wY2zDqS3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 22:39:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445Tcr3CkfzDqWy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 22:29:00 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1MBOJNk119762
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:28:58 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qtf6e38k4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:28:57 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@kaod.org>;
 Fri, 22 Feb 2019 11:28:55 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Feb 2019 11:28:51 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1MBSoT241877758
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Feb 2019 11:28:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 806935204F;
 Fri, 22 Feb 2019 11:28:50 +0000 (GMT)
Received: from smtp.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.1])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 64ED05204E;
 Fri, 22 Feb 2019 11:28:50 +0000 (GMT)
Received: from zorba.kaod.org.com (sig-9-145-77-130.uk.ibm.com [9.145.77.130])
 by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id
 89BA722026B; Fri, 22 Feb 2019 12:28:49 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v2 04/16] KVM: PPC: Book3S HV: XIVE: add a control to
 initialize a source
Date: Fri, 22 Feb 2019 12:28:28 +0100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222112840.25000-1-clg@kaod.org>
References: <20190222112840.25000-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022211-0028-0000-0000-0000034BB54F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022211-0029-0000-0000-00002409FDC1
Message-Id: <20190222112840.25000-5-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-22_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=778 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902220081
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

The associated HW interrupt source is simply allocated at the OPAL/HW
level and then MASKED. KVM only needs to know about its type: LSI or
MSI.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/include/uapi/asm/kvm.h        |   5 +
 arch/powerpc/kvm/book3s_xive.h             |  10 ++
 arch/powerpc/kvm/book3s_xive.c             |   8 +-
 arch/powerpc/kvm/book3s_xive_native.c      | 114 +++++++++++++++++++++
 Documentation/virtual/kvm/devices/xive.txt |  15 +++
 5 files changed, 148 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index b002c0c67787..a9ad99f2a11b 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -677,5 +677,10 @@ struct kvm_ppc_cpu_char {
 
 /* POWER9 XIVE Native Interrupt Controller */
 #define KVM_DEV_XIVE_GRP_CTRL		1
+#define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source attributes */
+
+/* Layout of 64-bit XIVE source attribute values */
+#define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
+#define KVM_XIVE_LEVEL_ASSERTED		(1ULL << 1)
 
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xive.h
index bcb1bbcf0359..f22f2d46d0f0 100644
--- a/arch/powerpc/kvm/book3s_xive.h
+++ b/arch/powerpc/kvm/book3s_xive.h
@@ -12,6 +12,13 @@
 #ifdef CONFIG_KVM_XICS
 #include "book3s_xics.h"
 
+/*
+ * The XIVE IRQ number space is aligned with the XICS IRQ number
+ * space, CPU IPIs being allocated in the first 4K.
+ */
+#define KVMPPC_XIVE_FIRST_IRQ	0
+#define KVMPPC_XIVE_NR_IRQS	KVMPPC_XICS_NR_IRQS
+
 /*
  * State for one guest irq source.
  *
@@ -253,6 +260,9 @@ extern int (*__xive_vm_h_eoi)(struct kvm_vcpu *vcpu, unsigned long xirr);
  */
 void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu);
 int kvmppc_xive_debug_show_queues(struct seq_file *m, struct kvm_vcpu *vcpu);
+struct kvmppc_xive_src_block *kvmppc_xive_create_src_block(
+	struct kvmppc_xive *xive, int irq);
+void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb);
 
 #endif /* CONFIG_KVM_XICS */
 #endif /* _KVM_PPC_BOOK3S_XICS_H */
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index d1cc18a5b1c4..6f950ecb3592 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -1485,8 +1485,8 @@ static int xive_get_source(struct kvmppc_xive *xive, long irq, u64 addr)
 	return 0;
 }
 
-static struct kvmppc_xive_src_block *xive_create_src_block(struct kvmppc_xive *xive,
-							   int irq)
+struct kvmppc_xive_src_block *kvmppc_xive_create_src_block(
+	struct kvmppc_xive *xive, int irq)
 {
 	struct kvm *kvm = xive->kvm;
 	struct kvmppc_xive_src_block *sb;
@@ -1565,7 +1565,7 @@ static int xive_set_source(struct kvmppc_xive *xive, long irq, u64 addr)
 	sb = kvmppc_xive_find_source(xive, irq, &idx);
 	if (!sb) {
 		pr_devel("No source, creating source block...\n");
-		sb = xive_create_src_block(xive, irq);
+		sb = kvmppc_xive_create_src_block(xive, irq);
 		if (!sb) {
 			pr_devel("Failed to create block...\n");
 			return -ENOMEM;
@@ -1789,7 +1789,7 @@ static void kvmppc_xive_cleanup_irq(u32 hw_num, struct xive_irq_data *xd)
 	xive_cleanup_irq_data(xd);
 }
 
-static void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb)
+void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb)
 {
 	int i;
 
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index 1f3da47a4a6a..a9b2d2d9af99 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -31,6 +31,29 @@
 
 #include "book3s_xive.h"
 
+/*
+ * TODO: introduce a common template file with the XIVE native layer
+ * and the XICS-on-XIVE glue for the utility functions
+ */
+#define __x_eoi_page(xd)	((void __iomem *)((xd)->eoi_mmio))
+#define __x_trig_page(xd)	((void __iomem *)((xd)->trig_mmio))
+#define __x_readq	__raw_readq
+#define __x_writeq	__raw_writeq
+
+static u8 xive_vm_esb_load(struct xive_irq_data *xd, u32 offset)
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
+
 static void kvmppc_xive_native_cleanup_queue(struct kvm_vcpu *vcpu, int prio)
 {
 	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
@@ -153,12 +176,89 @@ int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
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
+	/*
+	 * If the source doesn't already have an IPI, allocate
+	 * one and get the corresponding data
+	 */
+	if (!state->ipi_number) {
+		state->ipi_number = xive_native_alloc_irq();
+		if (state->ipi_number == 0) {
+			pr_err("Failed to allocate IRQ !\n");
+			return -ENXIO;
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
@@ -175,6 +275,11 @@ static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
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
@@ -183,6 +288,7 @@ static void kvmppc_xive_native_free(struct kvm_device *dev)
 {
 	struct kvmppc_xive *xive = dev->private;
 	struct kvm *kvm = xive->kvm;
+	int i;
 
 	debugfs_remove(xive->dentry);
 
@@ -191,6 +297,14 @@ static void kvmppc_xive_native_free(struct kvm_device *dev)
 	if (kvm)
 		kvm->arch.xive = NULL;
 
+	/* Mask and free interrupts */
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

