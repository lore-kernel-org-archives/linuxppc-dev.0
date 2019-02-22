Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E79C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 12:01:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C75E220818
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 12:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75E220818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445VLh715szDq7N
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 23:01:48 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 445TdF0T0DzDqWW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 22:29:20 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1MBOC5P066835
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:29:18 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qtddtrahc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:28:58 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@kaod.org>;
 Fri, 22 Feb 2019 11:28:56 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Feb 2019 11:28:54 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1MBSqgX57802782
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Feb 2019 11:28:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA333A405B;
 Fri, 22 Feb 2019 11:28:52 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF645A4054;
 Fri, 22 Feb 2019 11:28:52 +0000 (GMT)
Received: from smtp.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.1])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 Feb 2019 11:28:52 +0000 (GMT)
Received: from zorba.kaod.org.com (sig-9-145-77-130.uk.ibm.com [9.145.77.130])
 by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id
 0BA65220296; Fri, 22 Feb 2019 12:28:51 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v2 07/16] KVM: PPC: Book3S HV: XIVE: add a global reset control
Date: Fri, 22 Feb 2019 12:28:31 +0100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222112840.25000-1-clg@kaod.org>
References: <20190222112840.25000-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022211-0020-0000-0000-00000319EFA3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022211-0021-0000-0000-0000216B4700
Message-Id: <20190222112840.25000-8-clg@kaod.org>
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

This control is to be used by the H_INT_RESET hcall from QEMU. Its
purpose is to clear all configuration of the sources and EQs. This is
necessary in case of a kexec (for a kdump kernel for instance) to make
sure that no remaining configuration is left from the previous boot
setup so that the new kernel can start safely from a clean state.

The queue 7 is ignored when the KVM device is configured to run in
single escalation mode. Prio 7 is used by escalations.

The XIVE VP is kept enabled as the vCPU is still active and connected
to the XIVE device.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/include/uapi/asm/kvm.h        |  1 +
 arch/powerpc/kvm/book3s_xive_native.c      | 82 ++++++++++++++++++++++
 Documentation/virtual/kvm/devices/xive.txt |  5 ++
 3 files changed, 88 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 177e43f3edaf..7ae8cb22af7d 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -677,6 +677,7 @@ struct kvm_ppc_cpu_char {
 
 /* POWER9 XIVE Native Interrupt Controller */
 #define KVM_DEV_XIVE_GRP_CTRL		1
+#define   KVM_DEV_XIVE_RESET		1
 #define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source attributes */
 #define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source attributes */
 #define KVM_DEV_XIVE_GRP_EQ_CONFIG	4	/* 64-bit eq attributes */
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index 34a35bcf550c..bb3e121c918a 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -536,6 +536,80 @@ static int kvmppc_xive_native_get_queue_config(struct kvmppc_xive *xive,
 	return 0;
 }
 
+static void kvmppc_xive_reset_sources(struct kvmppc_xive_src_block *sb)
+{
+	int i;
+
+	for (i = 0; i < KVMPPC_XICS_IRQ_PER_ICS; i++) {
+		struct kvmppc_xive_irq_state *state = &sb->irq_state[i];
+
+		if (!state->valid)
+			continue;
+
+		if (state->act_priority == MASKED)
+			continue;
+
+		arch_spin_lock(&sb->lock);
+		state->eisn = 0;
+		state->act_server = 0;
+		state->act_priority = MASKED;
+		xive_vm_esb_load(&state->ipi_data, XIVE_ESB_SET_PQ_01);
+		xive_native_configure_irq(state->ipi_number, 0, MASKED, 0);
+		if (state->pt_number) {
+			xive_vm_esb_load(state->pt_data, XIVE_ESB_SET_PQ_01);
+			xive_native_configure_irq(state->pt_number,
+						  0, MASKED, 0);
+		}
+		arch_spin_unlock(&sb->lock);
+	}
+}
+
+static int kvmppc_xive_reset(struct kvmppc_xive *xive)
+{
+	struct kvm *kvm = xive->kvm;
+	struct kvm_vcpu *vcpu;
+	unsigned int i;
+
+	pr_devel("%s\n", __func__);
+
+	mutex_lock(&kvm->lock);
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+		unsigned int prio;
+
+		if (!xc)
+			continue;
+
+		kvmppc_xive_disable_vcpu_interrupts(vcpu);
+
+		for (prio = 0; prio < KVMPPC_XIVE_Q_COUNT; prio++) {
+
+			/* Single escalation, no queue 7 */
+			if (prio == 7 && xive->single_escalation)
+				break;
+
+			if (xc->esc_virq[prio]) {
+				free_irq(xc->esc_virq[prio], vcpu);
+				irq_dispose_mapping(xc->esc_virq[prio]);
+				kfree(xc->esc_virq_names[prio]);
+				xc->esc_virq[prio] = 0;
+			}
+
+			kvmppc_xive_native_cleanup_queue(vcpu, prio);
+		}
+	}
+
+	for (i = 0; i <= xive->max_sbid; i++) {
+		if (xive->src_blocks[i])
+			kvmppc_xive_reset_sources(xive->src_blocks[i]);
+	}
+
+	mutex_unlock(&kvm->lock);
+
+	return 0;
+}
+
 static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
 				       struct kvm_device_attr *attr)
 {
@@ -543,6 +617,10 @@ static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
 
 	switch (attr->group) {
 	case KVM_DEV_XIVE_GRP_CTRL:
+		switch (attr->attr) {
+		case KVM_DEV_XIVE_RESET:
+			return kvmppc_xive_reset(xive);
+		}
 		break;
 	case KVM_DEV_XIVE_GRP_SOURCE:
 		return kvmppc_xive_native_set_source(xive, attr->attr,
@@ -575,6 +653,10 @@ static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
 {
 	switch (attr->group) {
 	case KVM_DEV_XIVE_GRP_CTRL:
+		switch (attr->attr) {
+		case KVM_DEV_XIVE_RESET:
+			return 0;
+		}
 		break;
 	case KVM_DEV_XIVE_GRP_SOURCE:
 	case KVM_DEV_XIVE_GRP_SOURCE_CONFIG:
diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/virtual/kvm/devices/xive.txt
index c0b5d9bd43fb..f1d007f485a9 100644
--- a/Documentation/virtual/kvm/devices/xive.txt
+++ b/Documentation/virtual/kvm/devices/xive.txt
@@ -17,6 +17,11 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
 
   1. KVM_DEV_XIVE_GRP_CTRL
   Provides global controls on the device
+  Attributes:
+    1.1 KVM_DEV_XIVE_RESET (write only)
+    Resets the interrupt controller configuration for sources and event
+    queues. To be used by kexec and kdump.
+    Errors: none
 
   2. KVM_DEV_XIVE_GRP_SOURCE (write only)
   Initializes a new source in the XIVE device and mask it.
-- 
2.20.1

