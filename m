Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEF9C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:36:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00EAE2075A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00EAE2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445TnH0dZ4zDqXC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 22:36:19 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 445Tcr1JSBzDqWw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 22:28:59 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1MBOJ0U119780
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:28:57 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qtf6e38j4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:28:56 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@kaod.org>;
 Fri, 22 Feb 2019 11:28:54 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Feb 2019 11:28:52 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1MBSpM526214554
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Feb 2019 11:28:51 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 482044C046;
 Fri, 22 Feb 2019 11:28:51 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27DE64C04A;
 Fri, 22 Feb 2019 11:28:51 +0000 (GMT)
Received: from smtp.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.1])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 Feb 2019 11:28:51 +0000 (GMT)
Received: from zorba.kaod.org.com (sig-9-145-77-130.uk.ibm.com [9.145.77.130])
 by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id
 67553220296; Fri, 22 Feb 2019 12:28:50 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v2 05/16] KVM: PPC: Book3S HV: XIVE: add a control to
 configure a source
Date: Fri, 22 Feb 2019 12:28:29 +0100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222112840.25000-1-clg@kaod.org>
References: <20190222112840.25000-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022211-0020-0000-0000-00000319EFA2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022211-0021-0000-0000-0000216B46FD
Message-Id: <20190222112840.25000-6-clg@kaod.org>
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

This control will be used by the H_INT_SET_SOURCE_CONFIG hcall from
QEMU and also to restore the configuration of the source in the KVM
device.

The XIVE internal IRQ structure is extended with the value of the
Effective Interrupt Source Number. The EISN is the interrupt number
pushed in the event queue that the guest OS will use to dispatch
events internally. Caching the EISN value in KVM ease the test when
checking if a reconfiguration is indeed needed.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/include/uapi/asm/kvm.h        | 11 +++
 arch/powerpc/kvm/book3s_xive.h             |  4 +
 arch/powerpc/kvm/book3s_xive.c             |  5 +-
 arch/powerpc/kvm/book3s_xive_native.c      | 97 ++++++++++++++++++++++
 Documentation/virtual/kvm/devices/xive.txt | 20 +++++
 5 files changed, 135 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index a9ad99f2a11b..91899c7f9abd 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -678,9 +678,20 @@ struct kvm_ppc_cpu_char {
 /* POWER9 XIVE Native Interrupt Controller */
 #define KVM_DEV_XIVE_GRP_CTRL		1
 #define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source attributes */
+#define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source attributes */
 
 /* Layout of 64-bit XIVE source attribute values */
 #define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
 #define KVM_XIVE_LEVEL_ASSERTED		(1ULL << 1)
 
+/* Layout of 64-bit XIVE source configuration attribute values */
+#define KVM_XIVE_SOURCE_PRIORITY_SHIFT	0
+#define KVM_XIVE_SOURCE_PRIORITY_MASK	0x7
+#define KVM_XIVE_SOURCE_SERVER_SHIFT	3
+#define KVM_XIVE_SOURCE_SERVER_MASK	0xfffffff8ULL
+#define KVM_XIVE_SOURCE_MASK_SHIFT	32
+#define KVM_XIVE_SOURCE_MASK_MASK	0x100000000ULL
+#define KVM_XIVE_SOURCE_EISN_SHIFT	33
+#define KVM_XIVE_SOURCE_EISN_MASK	0xfffffffe00000000ULL
+
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xive.h
index f22f2d46d0f0..ab3ac152980d 100644
--- a/arch/powerpc/kvm/book3s_xive.h
+++ b/arch/powerpc/kvm/book3s_xive.h
@@ -61,6 +61,9 @@ struct kvmppc_xive_irq_state {
 	bool saved_p;
 	bool saved_q;
 	u8 saved_scan_prio;
+
+	/* Xive native */
+	u32 eisn;			/* Guest Effective IRQ number */
 };
 
 /* Select the "right" interrupt (IPI vs. passthrough) */
@@ -263,6 +266,7 @@ int kvmppc_xive_debug_show_queues(struct seq_file *m, struct kvm_vcpu *vcpu);
 struct kvmppc_xive_src_block *kvmppc_xive_create_src_block(
 	struct kvmppc_xive *xive, int irq);
 void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb);
+int kvmppc_xive_select_target(struct kvm *kvm, u32 *server, u8 prio);
 
 #endif /* CONFIG_KVM_XICS */
 #endif /* _KVM_PPC_BOOK3S_XICS_H */
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 6f950ecb3592..086da91d7c6e 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -342,7 +342,7 @@ static int xive_try_pick_queue(struct kvm_vcpu *vcpu, u8 prio)
 	return atomic_add_unless(&q->count, 1, max) ? 0 : -EBUSY;
 }
 
-static int xive_select_target(struct kvm *kvm, u32 *server, u8 prio)
+int kvmppc_xive_select_target(struct kvm *kvm, u32 *server, u8 prio)
 {
 	struct kvm_vcpu *vcpu;
 	int i, rc;
@@ -535,7 +535,7 @@ static int xive_target_interrupt(struct kvm *kvm,
 	 * priority. The count for that new target will have
 	 * already been incremented.
 	 */
-	rc = xive_select_target(kvm, &server, prio);
+	rc = kvmppc_xive_select_target(kvm, &server, prio);
 
 	/*
 	 * We failed to find a target ? Not much we can do
@@ -1509,6 +1509,7 @@ struct kvmppc_xive_src_block *kvmppc_xive_create_src_block(
 
 	for (i = 0; i < KVMPPC_XICS_IRQ_PER_ICS; i++) {
 		sb->irq_state[i].number = (bid << KVMPPC_XICS_ICS_SHIFT) | i;
+		sb->irq_state[i].eisn = 0;
 		sb->irq_state[i].guest_priority = MASKED;
 		sb->irq_state[i].saved_priority = MASKED;
 		sb->irq_state[i].act_priority = MASKED;
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index a9b2d2d9af99..cb5a5c6e05af 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -248,6 +248,99 @@ static int kvmppc_xive_native_set_source(struct kvmppc_xive *xive, long irq,
 	return 0;
 }
 
+static int kvmppc_xive_native_update_source_config(struct kvmppc_xive *xive,
+					struct kvmppc_xive_src_block *sb,
+					struct kvmppc_xive_irq_state *state,
+					u32 server,
+					u8 priority,
+					u32 eisn)
+{
+	struct kvm *kvm = xive->kvm;
+	u32 hw_num;
+	int rc = 0;
+
+	/*
+	 * TODO: Do we need to safely mask and unmask a source ? can
+	 * we just let the guest handle the possible races ?
+	 */
+	arch_spin_lock(&sb->lock);
+
+	if (state->act_server == server && state->act_priority == priority &&
+	    state->eisn == eisn)
+		goto unlock;
+
+	pr_devel("new_act_prio=%d new_act_server=%d act_server=%d act_prio=%d\n",
+		 priority, server, state->act_server, state->act_priority);
+
+	kvmppc_xive_select_irq(state, &hw_num, NULL);
+
+	if (priority != MASKED) {
+		rc = kvmppc_xive_select_target(kvm, &server, priority);
+		if (rc)
+			goto unlock;
+
+		state->act_priority = priority;
+		state->act_server = server;
+		state->eisn = eisn;
+
+		rc = xive_native_configure_irq(hw_num, xive->vp_base + server,
+					       priority, eisn);
+	} else {
+		state->act_priority = MASKED;
+		state->act_server = 0;
+		state->eisn = 0;
+
+		rc = xive_native_configure_irq(hw_num, 0, MASKED, 0);
+	}
+
+unlock:
+	arch_spin_unlock(&sb->lock);
+	return rc;
+}
+
+static int kvmppc_xive_native_set_source_config(struct kvmppc_xive *xive,
+						long irq, u64 addr)
+{
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	u64 __user *ubufp = (u64 __user *) addr;
+	u16 src;
+	u64 kvm_cfg;
+	u32 server;
+	u8 priority;
+	u32 eisn;
+
+	sb = kvmppc_xive_find_source(xive, irq, &src);
+	if (!sb)
+		return -ENOENT;
+
+	state = &sb->irq_state[src];
+
+	if (!state->valid)
+		return -EINVAL;
+
+	if (get_user(kvm_cfg, ubufp))
+		return -EFAULT;
+
+	pr_devel("%s irq=0x%lx cfg=%016llx\n", __func__, irq, kvm_cfg);
+
+	priority = (kvm_cfg & KVM_XIVE_SOURCE_PRIORITY_MASK) >>
+		KVM_XIVE_SOURCE_PRIORITY_SHIFT;
+	server = (kvm_cfg & KVM_XIVE_SOURCE_SERVER_MASK) >>
+		KVM_XIVE_SOURCE_SERVER_SHIFT;
+	eisn = (kvm_cfg & KVM_XIVE_SOURCE_EISN_MASK) >>
+		KVM_XIVE_SOURCE_EISN_SHIFT;
+
+	if (priority != xive_prio_from_guest(priority)) {
+		pr_err("invalid priority for queue %d for VCPU %d\n",
+		       priority, server);
+		return -EINVAL;
+	}
+
+	return kvmppc_xive_native_update_source_config(xive, sb, state, server,
+						       priority, eisn);
+}
+
 static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
 				       struct kvm_device_attr *attr)
 {
@@ -259,6 +352,9 @@ static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
 	case KVM_DEV_XIVE_GRP_SOURCE:
 		return kvmppc_xive_native_set_source(xive, attr->attr,
 						     attr->addr);
+	case KVM_DEV_XIVE_GRP_SOURCE_CONFIG:
+		return kvmppc_xive_native_set_source_config(xive, attr->attr,
+							    attr->addr);
 	}
 	return -ENXIO;
 }
@@ -276,6 +372,7 @@ static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
 	case KVM_DEV_XIVE_GRP_CTRL:
 		break;
 	case KVM_DEV_XIVE_GRP_SOURCE:
+	case KVM_DEV_XIVE_GRP_SOURCE_CONFIG:
 		if (attr->attr >= KVMPPC_XIVE_FIRST_IRQ &&
 		    attr->attr < KVMPPC_XIVE_NR_IRQS)
 			return 0;
diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/virtual/kvm/devices/xive.txt
index cd8bfc37b72e..4f513a1880c7 100644
--- a/Documentation/virtual/kvm/devices/xive.txt
+++ b/Documentation/virtual/kvm/devices/xive.txt
@@ -32,3 +32,23 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
     -ENOMEM: Could not create a new source block
     -EFAULT: Invalid user pointer for attr->addr.
     -ENXIO:  Could not allocate underlying HW interrupt
+
+  3. KVM_DEV_XIVE_GRP_SOURCE_CONFIG (write only)
+  Configures source targeting
+  Attributes:
+    Interrupt source number  (64-bit)
+  The kvm_device_attr.addr points to a __u64 value:
+  bits:     | 63   ....  33 |  32  | 31 .. 3 |  2 .. 0
+  values:   |    eisn       | mask |  server | priority
+  - priority: 0-7 interrupt priority level
+  - server: CPU number chosen to handle the interrupt
+  - mask: mask flag (unused)
+  - eisn: Effective Interrupt Source Number
+  Errors:
+    -ENOENT: Unknown source number
+    -EINVAL: Not initialized source number, invalid priority or
+             invalid CPU number.
+    -EFAULT: Invalid user pointer for attr->addr.
+    -ENXIO:  CPU event queues not configured or configuration of the
+             underlying HW interrupt failed
+    -EBUSY:  No CPU available to serve interrupt
-- 
2.20.1

