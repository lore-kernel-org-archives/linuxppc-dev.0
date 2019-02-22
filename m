Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9987C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:43:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 324C5206BB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 324C5206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445Tx32f31zDqWY
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 22:43:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445Tcz3XrDzDqWM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 22:29:07 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1MBO84F107156
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:28:59 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qtg1trk64-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:28:59 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@kaod.org>;
 Fri, 22 Feb 2019 11:28:57 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Feb 2019 11:28:53 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1MBSqTE28770426
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 22 Feb 2019 11:28:52 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31092AE059;
 Fri, 22 Feb 2019 11:28:52 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1383CAE055;
 Fri, 22 Feb 2019 11:28:52 +0000 (GMT)
Received: from smtp.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.1])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 Feb 2019 11:28:52 +0000 (GMT)
Received: from zorba.kaod.org.com (sig-9-145-77-130.uk.ibm.com [9.145.77.130])
 by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id
 1FA9022026B; Fri, 22 Feb 2019 12:28:51 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v2 06/16] KVM: PPC: Book3S HV: XIVE: add controls for the EQ
 configuration
Date: Fri, 22 Feb 2019 12:28:30 +0100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222112840.25000-1-clg@kaod.org>
References: <20190222112840.25000-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022211-4275-0000-0000-00000312A5A4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022211-4276-0000-0000-00003820DCCB
Message-Id: <20190222112840.25000-7-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-22_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
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

These controls will be used by the H_INT_SET_QUEUE_CONFIG and
H_INT_GET_QUEUE_CONFIG hcalls from QEMU. They will also be used to
restore the configuration of the XIVE EQs in the KVM device and to
capture the internal runtime state of the EQs. Both 'get' and 'set'
rely on an OPAL call to access from the XIVE interrupt controller the
EQ toggle bit and EQ index which are updated by the HW when event
notifications are enqueued in the EQ.

The value of the guest physical address of the event queue is saved in
the XIVE internal xive_q structure for later use. That is when
migration needs to mark the EQ pages dirty to capture a consistent
memory state of the VM.

To be noted that H_INT_SET_QUEUE_CONFIG does not require the extra
OPAL call setting the EQ toggle bit and EQ index to configure the EQ,
but restoring the EQ state will.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/include/asm/xive.h            |   2 +
 arch/powerpc/include/uapi/asm/kvm.h        |  21 +++
 arch/powerpc/kvm/book3s_xive.h             |   2 +
 arch/powerpc/kvm/book3s_xive.c             |  15 +-
 arch/powerpc/kvm/book3s_xive_native.c      | 207 +++++++++++++++++++++
 Documentation/virtual/kvm/devices/xive.txt |  29 +++
 6 files changed, 270 insertions(+), 6 deletions(-)

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
index 91899c7f9abd..177e43f3edaf 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -679,6 +679,7 @@ struct kvm_ppc_cpu_char {
 #define KVM_DEV_XIVE_GRP_CTRL		1
 #define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source attributes */
 #define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source attributes */
+#define KVM_DEV_XIVE_GRP_EQ_CONFIG	4	/* 64-bit eq attributes */
 
 /* Layout of 64-bit XIVE source attribute values */
 #define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
@@ -694,4 +695,24 @@ struct kvm_ppc_cpu_char {
 #define KVM_XIVE_SOURCE_EISN_SHIFT	33
 #define KVM_XIVE_SOURCE_EISN_MASK	0xfffffffe00000000ULL
 
+/* Layout of 64-bit eq attribute */
+#define KVM_XIVE_EQ_PRIORITY_SHIFT	0
+#define KVM_XIVE_EQ_PRIORITY_MASK	0x7
+#define KVM_XIVE_EQ_SERVER_SHIFT	3
+#define KVM_XIVE_EQ_SERVER_MASK		0xfffffff8ULL
+
+/* Layout of 64-bit eq attribute values */
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
index ab3ac152980d..6660d138c6b7 100644
--- a/arch/powerpc/kvm/book3s_xive.h
+++ b/arch/powerpc/kvm/book3s_xive.h
@@ -267,6 +267,8 @@ struct kvmppc_xive_src_block *kvmppc_xive_create_src_block(
 	struct kvmppc_xive *xive, int irq);
 void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb);
 int kvmppc_xive_select_target(struct kvm *kvm, u32 *server, u8 prio);
+int kvmppc_xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio,
+				  bool single_escalation);
 
 #endif /* CONFIG_KVM_XICS */
 #endif /* _KVM_PPC_BOOK3S_XICS_H */
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 086da91d7c6e..7431e31bc541 100644
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
@@ -1219,7 +1221,8 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
 		if (xive->qmap & (1 << i)) {
 			r = xive_provision_queue(vcpu, i);
 			if (r == 0 && !xive->single_escalation)
-				xive_attach_escalation(vcpu, i);
+				kvmppc_xive_attach_escalation(
+					vcpu, i, xive->single_escalation);
 			if (r)
 				goto bail;
 		} else {
@@ -1234,7 +1237,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
 	}
 
 	/* If not done above, attach priority 0 escalation */
-	r = xive_attach_escalation(vcpu, 0);
+	r = kvmppc_xive_attach_escalation(vcpu, 0, xive->single_escalation);
 	if (r)
 		goto bail;
 
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index cb5a5c6e05af..34a35bcf550c 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -341,6 +341,201 @@ static int kvmppc_xive_native_set_source_config(struct kvmppc_xive *xive,
 						       priority, eisn);
 }
 
+static int xive_native_validate_queue_size(u32 qsize)
+{
+	switch (qsize) {
+	case 12:
+	case 16:
+	case 21:
+	case 24:
+	case 0:
+		return 0;
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
+	 * Demangle priority/server tuple from the EQ index
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
+		return -ENOMEM;
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
+	rc = xive_native_set_queue_state(xc->vp_id, priority, kvm_eq.qtoggle,
+					 kvm_eq.qindex);
+	if (rc)
+		goto error;
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
+	 * Demangle priority/server tuple from the EQ index
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
@@ -355,6 +550,9 @@ static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
 	case KVM_DEV_XIVE_GRP_SOURCE_CONFIG:
 		return kvmppc_xive_native_set_source_config(xive, attr->attr,
 							    attr->addr);
+	case KVM_DEV_XIVE_GRP_EQ_CONFIG:
+		return kvmppc_xive_native_set_queue_config(xive, attr->attr,
+							   attr->addr);
 	}
 	return -ENXIO;
 }
@@ -362,6 +560,13 @@ static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
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
 
@@ -377,6 +582,8 @@ static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
 		    attr->attr < KVMPPC_XIVE_NR_IRQS)
 			return 0;
 		break;
+	case KVM_DEV_XIVE_GRP_EQ_CONFIG:
+		return 0;
 	}
 	return -ENXIO;
 }
diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/virtual/kvm/devices/xive.txt
index 4f513a1880c7..c0b5d9bd43fb 100644
--- a/Documentation/virtual/kvm/devices/xive.txt
+++ b/Documentation/virtual/kvm/devices/xive.txt
@@ -52,3 +52,32 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
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
+    -EINVAL: Invalid priority or invalid queue size
+    -EFAULT: Invalid user pointer for attr->addr.
+    -ENOMEM: Invalid queue address
+    -EIO:    Configuration of the underlying HW failed
-- 
2.20.1

