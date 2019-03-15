Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F097C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 12:11:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C23F520854
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 12:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23F520854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LPZL5Hy0zDqST
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 23:11:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.72.238; helo=9.mo177.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 9.mo177.mail-out.ovh.net (9.mo177.mail-out.ovh.net
 [46.105.72.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LPTt1P4dzDqSG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 23:07:42 +1100 (AEDT)
Received: from player793.ha.ovh.net (unknown [10.109.160.93])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 99705EA8E7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 13:07:38 +0100 (CET)
Received: from kaod.org (lfbn-1-2226-17.w90-76.abo.wanadoo.fr [90.76.48.17])
 (Authenticated sender: clg@kaod.org)
 by player793.ha.ovh.net (Postfix) with ESMTPSA id ABC3C3CD1DCE;
 Fri, 15 Mar 2019 12:07:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v3 06/17] KVM: PPC: Book3S HV: XIVE: add controls for the EQ
 configuration
Date: Fri, 15 Mar 2019 13:05:58 +0100
Message-Id: <20190315120609.25910-7-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190315120609.25910-1-clg@kaod.org>
References: <20190315120609.25910-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10775425061649812439
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrheehgdefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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

These controls will be used by the H_INT_SET_QUEUE_CONFIG and
H_INT_GET_QUEUE_CONFIG hcalls from QEMU to configure the underlying
Event Queue in the XIVE IC. They will also be used to restore the
configuration of the XIVE EQs and to capture the internal run-time
state of the EQs. Both 'get' and 'set' rely on an OPAL call to access
the EQ toggle bit and EQ index which are updated by the XIVE IC when
event notifications are enqueued in the EQ.

The value of the guest physical address of the event queue is saved in
the XIVE internal xive_q structure for later use. That is when
migration needs to mark the EQ pages dirty to capture a consistent
memory state of the VM.

To be noted that H_INT_SET_QUEUE_CONFIG does not require the extra
OPAL call setting the EQ toggle bit and EQ index to configure the EQ,
but restoring the EQ state will.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---

 Changes since v2 :
 
 - fixed comments on the KVM device attribute definitions
 - fixed check on supported EQ size to restrict to 64K pages
 - checked kvm_eq.flags that need to be zero
 - removed the OPAL call when EQ qtoggle bit and index are zero. 

 arch/powerpc/include/asm/xive.h            |   2 +
 arch/powerpc/include/uapi/asm/kvm.h        |  21 ++
 arch/powerpc/kvm/book3s_xive.h             |   2 +
 arch/powerpc/kvm/book3s_xive.c             |  15 +-
 arch/powerpc/kvm/book3s_xive_native.c      | 232 +++++++++++++++++++++
 Documentation/virtual/kvm/devices/xive.txt |  31 +++
 6 files changed, 297 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
index b579a943407b..46891f321606 100644
--- a/arch/powerpc/include/asm/xive.h
+++ b/arch/powerpc/include/asm/xive.h
@@ -73,6 +73,8 @@ struct xive_q {
 	u32			esc_irq;
 	atomic_t		count;
 	atomic_t		pending_count;
+	u64			guest_qpage;
+	u32			guest_qsize;
 };
 
 /* Global enable flags for the XIVE support */
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 12bb01baf0ae..1cd728c87d7c 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -679,6 +679,7 @@ struct kvm_ppc_cpu_char {
 #define KVM_DEV_XIVE_GRP_CTRL		1
 #define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source identifier */
 #define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source identifier */
+#define KVM_DEV_XIVE_GRP_EQ_CONFIG	4	/* 64-bit EQ identifier */
 
 /* Layout of 64-bit XIVE source attribute values */
 #define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
@@ -694,4 +695,24 @@ struct kvm_ppc_cpu_char {
 #define KVM_XIVE_SOURCE_EISN_SHIFT	33
 #define KVM_XIVE_SOURCE_EISN_MASK	0xfffffffe00000000ULL
 
+/* Layout of 64-bit EQ identifier */
+#define KVM_XIVE_EQ_PRIORITY_SHIFT	0
+#define KVM_XIVE_EQ_PRIORITY_MASK	0x7
+#define KVM_XIVE_EQ_SERVER_SHIFT	3
+#define KVM_XIVE_EQ_SERVER_MASK		0xfffffff8ULL
+
+/* Layout of EQ configuration values (64 bytes) */
+struct kvm_ppc_xive_eq {
+	__u32 flags;
+	__u32 qsize;
+	__u64 qpage;
+	__u32 qtoggle;
+	__u32 qindex;
+	__u8  pad[40];
+};
+
+#define KVM_XIVE_EQ_FLAG_ENABLED	0x00000001
+#define KVM_XIVE_EQ_FLAG_ALWAYS_NOTIFY	0x00000002
+#define KVM_XIVE_EQ_FLAG_ESCALATE	0x00000004
+
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xive.h
index ae26fe653d98..622f594d93e1 100644
--- a/arch/powerpc/kvm/book3s_xive.h
+++ b/arch/powerpc/kvm/book3s_xive.h
@@ -272,6 +272,8 @@ struct kvmppc_xive_src_block *kvmppc_xive_create_src_block(
 	struct kvmppc_xive *xive, int irq);
 void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb);
 int kvmppc_xive_select_target(struct kvm *kvm, u32 *server, u8 prio);
+int kvmppc_xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio,
+				  bool single_escalation);
 
 #endif /* CONFIG_KVM_XICS */
 #endif /* _KVM_PPC_BOOK3S_XICS_H */
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index e09f3addffe5..c1b7aa7dbc28 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -166,7 +166,8 @@ static irqreturn_t xive_esc_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio)
+int kvmppc_xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio,
+				  bool single_escalation)
 {
 	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
 	struct xive_q *q = &xc->queues[prio];
@@ -185,7 +186,7 @@ static int xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio)
 		return -EIO;
 	}
 
-	if (xc->xive->single_escalation)
+	if (single_escalation)
 		name = kasprintf(GFP_KERNEL, "kvm-%d-%d",
 				 vcpu->kvm->arch.lpid, xc->server_num);
 	else
@@ -217,7 +218,7 @@ static int xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio)
 	 * interrupt, thus leaving it effectively masked after
 	 * it fires once.
 	 */
-	if (xc->xive->single_escalation) {
+	if (single_escalation) {
 		struct irq_data *d = irq_get_irq_data(xc->esc_virq[prio]);
 		struct xive_irq_data *xd = irq_data_get_irq_handler_data(d);
 
@@ -291,7 +292,8 @@ static int xive_check_provisioning(struct kvm *kvm, u8 prio)
 			continue;
 		rc = xive_provision_queue(vcpu, prio);
 		if (rc == 0 && !xive->single_escalation)
-			xive_attach_escalation(vcpu, prio);
+			kvmppc_xive_attach_escalation(vcpu, prio,
+						      xive->single_escalation);
 		if (rc)
 			return rc;
 	}
@@ -1214,7 +1216,8 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
 		if (xive->qmap & (1 << i)) {
 			r = xive_provision_queue(vcpu, i);
 			if (r == 0 && !xive->single_escalation)
-				xive_attach_escalation(vcpu, i);
+				kvmppc_xive_attach_escalation(
+					vcpu, i, xive->single_escalation);
 			if (r)
 				goto bail;
 		} else {
@@ -1229,7 +1232,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
 	}
 
 	/* If not done above, attach priority 0 escalation */
-	r = xive_attach_escalation(vcpu, 0);
+	r = kvmppc_xive_attach_escalation(vcpu, 0, xive->single_escalation);
 	if (r)
 		goto bail;
 
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index b841d339f674..42e824658a30 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -340,6 +340,226 @@ static int kvmppc_xive_native_set_source_config(struct kvmppc_xive *xive,
 						       priority, masked, eisn);
 }
 
+static int xive_native_validate_queue_size(u32 qsize)
+{
+	/*
+	 * We only support 64K pages for the moment. This is also
+	 * advertised in the DT property "ibm,xive-eq-sizes"
+	 */
+	switch (qsize) {
+	case 0: /* EQ reset */
+	case 16:
+		return 0;
+	case 12:
+	case 21:
+	case 24:
+	default:
+		return -EINVAL;
+	}
+}
+
+static int kvmppc_xive_native_set_queue_config(struct kvmppc_xive *xive,
+					       long eq_idx, u64 addr)
+{
+	struct kvm *kvm = xive->kvm;
+	struct kvm_vcpu *vcpu;
+	struct kvmppc_xive_vcpu *xc;
+	void __user *ubufp = (u64 __user *) addr;
+	u32 server;
+	u8 priority;
+	struct kvm_ppc_xive_eq kvm_eq;
+	int rc;
+	__be32 *qaddr = 0;
+	struct page *page;
+	struct xive_q *q;
+
+	/*
+	 * Demangle priority/server tuple from the EQ identifier
+	 */
+	priority = (eq_idx & KVM_XIVE_EQ_PRIORITY_MASK) >>
+		KVM_XIVE_EQ_PRIORITY_SHIFT;
+	server = (eq_idx & KVM_XIVE_EQ_SERVER_MASK) >>
+		KVM_XIVE_EQ_SERVER_SHIFT;
+
+	if (copy_from_user(&kvm_eq, ubufp, sizeof(kvm_eq)))
+		return -EFAULT;
+
+	vcpu = kvmppc_xive_find_server(kvm, server);
+	if (!vcpu) {
+		pr_err("Can't find server %d\n", server);
+		return -ENOENT;
+	}
+	xc = vcpu->arch.xive_vcpu;
+
+	if (priority != xive_prio_from_guest(priority)) {
+		pr_err("Trying to restore invalid queue %d for VCPU %d\n",
+		       priority, server);
+		return -EINVAL;
+	}
+	q = &xc->queues[priority];
+
+	pr_devel("%s VCPU %d priority %d fl:%x sz:%d addr:%llx g:%d idx:%d\n",
+		 __func__, server, priority, kvm_eq.flags,
+		 kvm_eq.qsize, kvm_eq.qpage, kvm_eq.qtoggle, kvm_eq.qindex);
+
+	/*
+	 * We can not tune the EQ configuration from user space. All
+	 * is done in OPAL.
+	 */
+	if (kvm_eq.flags != 0) {
+		pr_err("invalid flags %d\n", kvm_eq.flags);
+		return -EINVAL;
+	}
+
+	rc = xive_native_validate_queue_size(kvm_eq.qsize);
+	if (rc) {
+		pr_err("invalid queue size %d\n", kvm_eq.qsize);
+		return rc;
+	}
+
+	/* reset queue and disable queueing */
+	if (!kvm_eq.qsize) {
+		q->guest_qpage = 0;
+		q->guest_qsize = 0;
+
+		rc = xive_native_configure_queue(xc->vp_id, q, priority,
+						 NULL, 0, true);
+		if (rc) {
+			pr_err("Failed to reset queue %d for VCPU %d: %d\n",
+			       priority, xc->server_num, rc);
+			return rc;
+		}
+
+		if (q->qpage) {
+			put_page(virt_to_page(q->qpage));
+			q->qpage = NULL;
+		}
+
+		return 0;
+	}
+
+
+	page = gfn_to_page(kvm, gpa_to_gfn(kvm_eq.qpage));
+	if (is_error_page(page)) {
+		pr_warn("Couldn't get guest page for %llx!\n", kvm_eq.qpage);
+		return -EINVAL;
+	}
+	qaddr = page_to_virt(page) + (kvm_eq.qpage & ~PAGE_MASK);
+
+	/* Backup queue page guest address for migration */
+	q->guest_qpage = kvm_eq.qpage;
+	q->guest_qsize = kvm_eq.qsize;
+
+	rc = xive_native_configure_queue(xc->vp_id, q, priority,
+					 (__be32 *) qaddr, kvm_eq.qsize, true);
+	if (rc) {
+		pr_err("Failed to configure queue %d for VCPU %d: %d\n",
+		       priority, xc->server_num, rc);
+		put_page(page);
+		return rc;
+	}
+
+	/*
+	 * Only restore the queue state when needed. When doing the
+	 * H_INT_SET_SOURCE_CONFIG hcall, it should not.
+	 */
+	if (kvm_eq.qtoggle != 0 || kvm_eq.qindex != 0) {
+		rc = xive_native_set_queue_state(xc->vp_id, priority,
+						 kvm_eq.qtoggle,
+						 kvm_eq.qindex);
+		if (rc)
+			goto error;
+	}
+
+	rc = kvmppc_xive_attach_escalation(vcpu, priority,
+					   xive->single_escalation);
+error:
+	if (rc)
+		kvmppc_xive_native_cleanup_queue(vcpu, priority);
+	return rc;
+}
+
+static int kvmppc_xive_native_get_queue_config(struct kvmppc_xive *xive,
+					       long eq_idx, u64 addr)
+{
+	struct kvm *kvm = xive->kvm;
+	struct kvm_vcpu *vcpu;
+	struct kvmppc_xive_vcpu *xc;
+	struct xive_q *q;
+	void __user *ubufp = (u64 __user *) addr;
+	u32 server;
+	u8 priority;
+	struct kvm_ppc_xive_eq kvm_eq;
+	u64 qpage;
+	u64 qsize;
+	u64 qeoi_page;
+	u32 escalate_irq;
+	u64 qflags;
+	int rc;
+
+	/*
+	 * Demangle priority/server tuple from the EQ identifier
+	 */
+	priority = (eq_idx & KVM_XIVE_EQ_PRIORITY_MASK) >>
+		KVM_XIVE_EQ_PRIORITY_SHIFT;
+	server = (eq_idx & KVM_XIVE_EQ_SERVER_MASK) >>
+		KVM_XIVE_EQ_SERVER_SHIFT;
+
+	vcpu = kvmppc_xive_find_server(kvm, server);
+	if (!vcpu) {
+		pr_err("Can't find server %d\n", server);
+		return -ENOENT;
+	}
+	xc = vcpu->arch.xive_vcpu;
+
+	if (priority != xive_prio_from_guest(priority)) {
+		pr_err("invalid priority for queue %d for VCPU %d\n",
+		       priority, server);
+		return -EINVAL;
+	}
+	q = &xc->queues[priority];
+
+	memset(&kvm_eq, 0, sizeof(kvm_eq));
+
+	if (!q->qpage)
+		return 0;
+
+	rc = xive_native_get_queue_info(xc->vp_id, priority, &qpage, &qsize,
+					&qeoi_page, &escalate_irq, &qflags);
+	if (rc)
+		return rc;
+
+	/*
+	 * Return some information on the EQ configuration in
+	 * OPAL. This is purely informative for now as we can't really
+	 * tune the EQ configuration from user space.
+	 */
+	kvm_eq.flags = 0;
+	if (qflags & OPAL_XIVE_EQ_ENABLED)
+		kvm_eq.flags |= KVM_XIVE_EQ_FLAG_ENABLED;
+	if (qflags & OPAL_XIVE_EQ_ALWAYS_NOTIFY)
+		kvm_eq.flags |= KVM_XIVE_EQ_FLAG_ALWAYS_NOTIFY;
+	if (qflags & OPAL_XIVE_EQ_ESCALATE)
+		kvm_eq.flags |= KVM_XIVE_EQ_FLAG_ESCALATE;
+
+	kvm_eq.qsize = q->guest_qsize;
+	kvm_eq.qpage = q->guest_qpage;
+
+	rc = xive_native_get_queue_state(xc->vp_id, priority, &kvm_eq.qtoggle,
+					 &kvm_eq.qindex);
+	if (rc)
+		return rc;
+
+	pr_devel("%s VCPU %d priority %d fl:%x sz:%d addr:%llx g:%d idx:%d\n",
+		 __func__, server, priority, kvm_eq.flags,
+		 kvm_eq.qsize, kvm_eq.qpage, kvm_eq.qtoggle, kvm_eq.qindex);
+
+	if (copy_to_user(ubufp, &kvm_eq, sizeof(kvm_eq)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
 				       struct kvm_device_attr *attr)
 {
@@ -354,6 +574,9 @@ static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
 	case KVM_DEV_XIVE_GRP_SOURCE_CONFIG:
 		return kvmppc_xive_native_set_source_config(xive, attr->attr,
 							    attr->addr);
+	case KVM_DEV_XIVE_GRP_EQ_CONFIG:
+		return kvmppc_xive_native_set_queue_config(xive, attr->attr,
+							   attr->addr);
 	}
 	return -ENXIO;
 }
@@ -361,6 +584,13 @@ static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
 static int kvmppc_xive_native_get_attr(struct kvm_device *dev,
 				       struct kvm_device_attr *attr)
 {
+	struct kvmppc_xive *xive = dev->private;
+
+	switch (attr->group) {
+	case KVM_DEV_XIVE_GRP_EQ_CONFIG:
+		return kvmppc_xive_native_get_queue_config(xive, attr->attr,
+							   attr->addr);
+	}
 	return -ENXIO;
 }
 
@@ -376,6 +606,8 @@ static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
 		    attr->attr < KVMPPC_XIVE_NR_IRQS)
 			return 0;
 		break;
+	case KVM_DEV_XIVE_GRP_EQ_CONFIG:
+		return 0;
 	}
 	return -ENXIO;
 }
diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/virtual/kvm/devices/xive.txt
index 33c64b2cdbe8..a4de64f6e79c 100644
--- a/Documentation/virtual/kvm/devices/xive.txt
+++ b/Documentation/virtual/kvm/devices/xive.txt
@@ -53,3 +53,34 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
     -ENXIO:  CPU event queues not configured or configuration of the
              underlying HW interrupt failed
     -EBUSY:  No CPU available to serve interrupt
+
+  4. KVM_DEV_XIVE_GRP_EQ_CONFIG (read-write)
+  Configures an event queue of a CPU
+  Attributes:
+    EQ descriptor identifier (64-bit)
+  The EQ descriptor identifier is a tuple (server, priority) :
+  bits:     | 63   ....  32 | 31 .. 3 |  2 .. 0
+  values:   |    unused     |  server | priority
+  The kvm_device_attr.addr points to :
+    struct kvm_ppc_xive_eq {
+	__u32 flags;
+	__u32 qsize;
+	__u64 qpage;
+	__u32 qtoggle;
+	__u32 qindex;
+	__u8  pad[40];
+    };
+  - flags: queue flags
+  - qsize: queue size (power of 2)
+  - qpage: real address of queue
+  - qtoggle: current queue toggle bit
+  - qindex: current queue index
+  - pad: reserved for future use
+  Errors:
+    -ENOENT: Invalid CPU number
+    -EINVAL: Invalid priority
+    -EINVAL: Invalid flags
+    -EINVAL: Invalid queue size
+    -EINVAL: Invalid queue address
+    -EFAULT: Invalid user pointer for attr->addr.
+    -EIO:    Configuration of the underlying HW failed
-- 
2.20.1

