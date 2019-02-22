Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E4CC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:52:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B6320652
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B6320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445V7r6X7JzDqS3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 22:52:24 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 445Td171nmzDqWd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 22:29:09 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1MBO80X010332
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:29:02 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qtefad7pc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:29:02 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@kaod.org>;
 Fri, 22 Feb 2019 11:28:59 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Feb 2019 11:28:55 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1MBSsRS45154450
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Feb 2019 11:28:54 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76F354C046;
 Fri, 22 Feb 2019 11:28:54 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B5224C040;
 Fri, 22 Feb 2019 11:28:54 +0000 (GMT)
Received: from smtp.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.1])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 Feb 2019 11:28:54 +0000 (GMT)
Received: from zorba.kaod.org.com (sig-9-145-77-130.uk.ibm.com [9.145.77.130])
 by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id
 6D6EF220296; Fri, 22 Feb 2019 12:28:53 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v2 09/16] KVM: PPC: Book3S HV: XIVE: add a control to dirty
 the XIVE EQ pages
Date: Fri, 22 Feb 2019 12:28:33 +0100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222112840.25000-1-clg@kaod.org>
References: <20190222112840.25000-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022211-0016-0000-0000-0000025996BB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022211-0017-0000-0000-000032B3EB2E
Message-Id: <20190222112840.25000-10-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-22_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
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

When migration of a VM is initiated, a first copy of the RAM is
transferred to the destination before the VM is stopped, but there is
no guarantee that the EQ pages in which the event notification are
queued have not been modified.

To make sure migration will capture a consistent memory state, the
XIVE device should perform a XIVE quiesce sequence to stop the flow of
event notifications and stabilize the EQs. This is the purpose of the
KVM_DEV_XIVE_EQ_SYNC control which will also marks the EQ pages dirty
to force their transfer.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/include/uapi/asm/kvm.h        |  1 +
 arch/powerpc/kvm/book3s_xive_native.c      | 67 ++++++++++++++++++++++
 Documentation/virtual/kvm/devices/xive.txt | 29 ++++++++++
 3 files changed, 97 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 289c504b7c1d..cd78ad1020fe 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -678,6 +678,7 @@ struct kvm_ppc_cpu_char {
 /* POWER9 XIVE Native Interrupt Controller */
 #define KVM_DEV_XIVE_GRP_CTRL		1
 #define   KVM_DEV_XIVE_RESET		1
+#define   KVM_DEV_XIVE_EQ_SYNC		2
 #define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source attributes */
 #define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source attributes */
 #define KVM_DEV_XIVE_GRP_EQ_CONFIG	4	/* 64-bit eq attributes */
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index dd2a9d411fe7..3debc876d5a0 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -640,6 +640,70 @@ static int kvmppc_xive_reset(struct kvmppc_xive *xive)
 	return 0;
 }
 
+static void kvmppc_xive_native_sync_sources(struct kvmppc_xive_src_block *sb)
+{
+	int j;
+
+	for (j = 0; j < KVMPPC_XICS_IRQ_PER_ICS; j++) {
+		struct kvmppc_xive_irq_state *state = &sb->irq_state[j];
+		struct xive_irq_data *xd;
+		u32 hw_num;
+
+		if (!state->valid)
+			continue;
+		if (state->act_priority == MASKED)
+			continue;
+
+		arch_spin_lock(&sb->lock);
+		kvmppc_xive_select_irq(state, &hw_num, &xd);
+		xive_native_sync_source(hw_num);
+		xive_native_sync_queue(hw_num);
+		arch_spin_unlock(&sb->lock);
+	}
+}
+
+static int kvmppc_xive_native_vcpu_eq_sync(struct kvm_vcpu *vcpu)
+{
+	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+	unsigned int prio;
+
+	if (!xc)
+		return -ENOENT;
+
+	for (prio = 0; prio < KVMPPC_XIVE_Q_COUNT; prio++) {
+		struct xive_q *q = &xc->queues[prio];
+
+		if (!q->qpage)
+			continue;
+
+		/* Mark EQ page dirty for migration */
+		mark_page_dirty(vcpu->kvm, gpa_to_gfn(q->guest_qpage));
+	}
+	return 0;
+}
+
+static int kvmppc_xive_native_eq_sync(struct kvmppc_xive *xive)
+{
+	struct kvm *kvm = xive->kvm;
+	struct kvm_vcpu *vcpu;
+	unsigned int i;
+
+	pr_devel("%s\n", __func__);
+
+	for (i = 0; i <= xive->max_sbid; i++) {
+		if (xive->src_blocks[i])
+			kvmppc_xive_native_sync_sources(xive->src_blocks[i]);
+	}
+
+	mutex_lock(&kvm->lock);
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		kvmppc_xive_native_vcpu_eq_sync(vcpu);
+	}
+	mutex_unlock(&kvm->lock);
+
+	return 0;
+}
+
 static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
 				       struct kvm_device_attr *attr)
 {
@@ -650,6 +714,8 @@ static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
 		switch (attr->attr) {
 		case KVM_DEV_XIVE_RESET:
 			return kvmppc_xive_reset(xive);
+		case KVM_DEV_XIVE_EQ_SYNC:
+			return kvmppc_xive_native_eq_sync(xive);
 		}
 		break;
 	case KVM_DEV_XIVE_GRP_SOURCE:
@@ -688,6 +754,7 @@ static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
 	case KVM_DEV_XIVE_GRP_CTRL:
 		switch (attr->attr) {
 		case KVM_DEV_XIVE_RESET:
+		case KVM_DEV_XIVE_EQ_SYNC:
 			return 0;
 		}
 		break;
diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/virtual/kvm/devices/xive.txt
index 267634eae9e0..a26be635cff9 100644
--- a/Documentation/virtual/kvm/devices/xive.txt
+++ b/Documentation/virtual/kvm/devices/xive.txt
@@ -23,6 +23,12 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
     queues. To be used by kexec and kdump.
     Errors: none
 
+    1.2 KVM_DEV_XIVE_EQ_SYNC (write only)
+    Sync all the sources and queues and mark the EQ pages dirty. This
+    to make sure that a consistent memory state is captured when
+    migrating the VM.
+    Errors: none
+
   2. KVM_DEV_XIVE_GRP_SOURCE (write only)
   Initializes a new source in the XIVE device and mask it.
   Attributes:
@@ -95,3 +101,26 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
     -ENOENT: Unknown source number
     -EINVAL: Not initialized source number, invalid priority or
              invalid CPU number.
+
+* Migration:
+
+  Saving the state of a VM using the XIVE native exploitation mode
+  should follow a specific sequence. When the VM is stopped :
+
+  1. Mask all sources (PQ=01) to stop the flow of events.
+
+  2. Sync the XIVE device with the KVM control KVM_DEV_XIVE_EQ_SYNC to
+  flush any in-flight event notification and to stabilize the EQs. At
+  this stage, the EQ pages are marked dirty to make sure they are
+  transferred in the migration sequence.
+
+  3. Capture the state of the source targeting, the EQs configuration
+  and the state of thread interrupt context registers.
+
+  Restore is similar :
+
+  1. Restore the EQ configuration. As targeting depends on it.
+  2. Restore targeting
+  3. Restore the thread interrupt contexts
+  4. Restore the source states
+  5. Let the vCPU run
-- 
2.20.1

