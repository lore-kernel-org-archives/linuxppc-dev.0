Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26225C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:45:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D5AB20643
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5AB20643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445TzY0QxFzDqQH
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 22:45:13 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 445Td06CNDzDqWM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 22:29:08 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1MBRmiJ091275
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:29:01 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qtg7vg1wq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:29:01 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@kaod.org>;
 Fri, 22 Feb 2019 11:28:59 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Feb 2019 11:28:56 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1MBStds30605472
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Feb 2019 11:28:55 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2FCE0A405B;
 Fri, 22 Feb 2019 11:28:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12072A4054;
 Fri, 22 Feb 2019 11:28:55 +0000 (GMT)
Received: from smtp.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.1])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 Feb 2019 11:28:55 +0000 (GMT)
Received: from zorba.kaod.org.com (sig-9-145-77-130.uk.ibm.com [9.145.77.130])
 by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id
 52D6622026B; Fri, 22 Feb 2019 12:28:54 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v2 10/16] KVM: PPC: Book3S HV: XIVE: add get/set accessors for
 the VP XIVE state
Date: Fri, 22 Feb 2019 12:28:34 +0100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222112840.25000-1-clg@kaod.org>
References: <20190222112840.25000-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022211-0012-0000-0000-000002F8DF9C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022211-0013-0000-0000-000021307934
Message-Id: <20190222112840.25000-11-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-22_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=603 adultscore=0 classifier=spam adjust=0 reason=mlx
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

At a VCPU level, the state of the thread interrupt management
registers needs to be collected. These registers are cached under the
'xive_saved_state.w01' field of the VCPU when the VPCU context is
pulled from the HW thread. An OPAL call retrieves the backup of the
IPB register in the underlying XIVE NVT structure and merges it in the
KVM state.

The structures of the interface between QEMU and KVM provisions some
extra room (two u64) for further extensions if more state needs to be
transferred back to QEMU.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/include/asm/kvm_ppc.h         | 11 +++
 arch/powerpc/include/uapi/asm/kvm.h        |  2 +
 arch/powerpc/kvm/book3s.c                  | 24 +++++++
 arch/powerpc/kvm/book3s_xive_native.c      | 82 ++++++++++++++++++++++
 Documentation/virtual/kvm/devices/xive.txt | 19 +++++
 5 files changed, 138 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 1e61877fe147..664c65051612 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -272,6 +272,7 @@ union kvmppc_one_reg {
 		u64	addr;
 		u64	length;
 	}	vpaval;
+	u64	xive_timaval[4];
 };
 
 struct kvmppc_ops {
@@ -604,6 +605,10 @@ extern int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
 extern void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu);
 extern void kvmppc_xive_native_init_module(void);
 extern void kvmppc_xive_native_exit_module(void);
+extern int kvmppc_xive_native_get_vp(struct kvm_vcpu *vcpu,
+				     union kvmppc_one_reg *val);
+extern int kvmppc_xive_native_set_vp(struct kvm_vcpu *vcpu,
+				     union kvmppc_one_reg *val);
 
 #else
 static inline int kvmppc_xive_set_xive(struct kvm *kvm, u32 irq, u32 server,
@@ -636,6 +641,12 @@ static inline int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
 static inline void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu) { }
 static inline void kvmppc_xive_native_init_module(void) { }
 static inline void kvmppc_xive_native_exit_module(void) { }
+static inline int kvmppc_xive_native_get_vp(struct kvm_vcpu *vcpu,
+					    union kvmppc_one_reg *val)
+{ return 0; }
+static inline int kvmppc_xive_native_set_vp(struct kvm_vcpu *vcpu,
+					    union kvmppc_one_reg *val)
+{ return -ENOENT; }
 
 #endif /* CONFIG_KVM_XIVE */
 
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index cd78ad1020fe..42d4ef93ec2d 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -480,6 +480,8 @@ struct kvm_ppc_cpu_char {
 #define  KVM_REG_PPC_ICP_PPRI_SHIFT	16	/* pending irq priority */
 #define  KVM_REG_PPC_ICP_PPRI_MASK	0xff
 
+#define KVM_REG_PPC_VP_STATE	(KVM_REG_PPC | KVM_REG_SIZE_U256 | 0x8d)
+
 /* Device control API: PPC-specific devices */
 #define KVM_DEV_MPIC_GRP_MISC		1
 #define   KVM_DEV_MPIC_BASE_ADDR	0	/* 64-bit */
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 96d43f091255..f85a9211f30c 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -641,6 +641,18 @@ int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
 				*val = get_reg_val(id, kvmppc_xics_get_icp(vcpu));
 			break;
 #endif /* CONFIG_KVM_XICS */
+#ifdef CONFIG_KVM_XIVE
+		case KVM_REG_PPC_VP_STATE:
+			if (!vcpu->arch.xive_vcpu) {
+				r = -ENXIO;
+				break;
+			}
+			if (xive_enabled())
+				r = kvmppc_xive_native_get_vp(vcpu, val);
+			else
+				r = -ENXIO;
+			break;
+#endif /* CONFIG_KVM_XIVE */
 		case KVM_REG_PPC_FSCR:
 			*val = get_reg_val(id, vcpu->arch.fscr);
 			break;
@@ -714,6 +726,18 @@ int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id,
 				r = kvmppc_xics_set_icp(vcpu, set_reg_val(id, *val));
 			break;
 #endif /* CONFIG_KVM_XICS */
+#ifdef CONFIG_KVM_XIVE
+		case KVM_REG_PPC_VP_STATE:
+			if (!vcpu->arch.xive_vcpu) {
+				r = -ENXIO;
+				break;
+			}
+			if (xive_enabled())
+				r = kvmppc_xive_native_set_vp(vcpu, val);
+			else
+				r = -ENXIO;
+			break;
+#endif /* CONFIG_KVM_XIVE */
 		case KVM_REG_PPC_FSCR:
 			vcpu->arch.fscr = set_reg_val(id, *val);
 			break;
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index 3debc876d5a0..132bff52d70a 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -845,6 +845,88 @@ static int kvmppc_xive_native_create(struct kvm_device *dev, u32 type)
 	return ret;
 }
 
+/*
+ * Interrupt Pending Buffer (IPB) offset
+ */
+#define TM_IPB_SHIFT 40
+#define TM_IPB_MASK  (((u64) 0xFF) << TM_IPB_SHIFT)
+
+int kvmppc_xive_native_get_vp(struct kvm_vcpu *vcpu, union kvmppc_one_reg *val)
+{
+	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+	u64 opal_state;
+	int rc;
+
+	if (!kvmppc_xive_enabled(vcpu))
+		return -EPERM;
+
+	if (!xc)
+		return -ENOENT;
+
+	/* Thread context registers. We only care about IPB and CPPR */
+	val->xive_timaval[0] = vcpu->arch.xive_saved_state.w01;
+
+	/*
+	 * Return the OS CAM line to print out the VP identifier in
+	 * the QEMU monitor. This is not restored.
+	 */
+	val->xive_timaval[1] = vcpu->arch.xive_cam_word;
+
+	/* Get the VP state from OPAL */
+	rc = xive_native_get_vp_state(xc->vp_id, &opal_state);
+	if (rc)
+		return rc;
+
+	/*
+	 * Capture the backup of IPB register in the NVT structure and
+	 * merge it in our KVM VP state.
+	 */
+	val->xive_timaval[0] |= cpu_to_be64(opal_state & TM_IPB_MASK);
+
+	pr_devel("%s NSR=%02x CPPR=%02x IBP=%02x PIPR=%02x w01=%016llx w2=%08x opal=%016llx\n",
+		 __func__,
+		 vcpu->arch.xive_saved_state.nsr,
+		 vcpu->arch.xive_saved_state.cppr,
+		 vcpu->arch.xive_saved_state.ipb,
+		 vcpu->arch.xive_saved_state.pipr,
+		 vcpu->arch.xive_saved_state.w01,
+		 (u32) vcpu->arch.xive_cam_word, opal_state);
+
+	return 0;
+}
+
+int kvmppc_xive_native_set_vp(struct kvm_vcpu *vcpu, union kvmppc_one_reg *val)
+{
+	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+	struct kvmppc_xive *xive = vcpu->kvm->arch.xive;
+
+	pr_devel("%s w01=%016llx vp=%016llx\n", __func__,
+		 val->xive_timaval[0], val->xive_timaval[1]);
+
+	if (!kvmppc_xive_enabled(vcpu))
+		return -EPERM;
+
+	if (!xc || !xive)
+		return -ENOENT;
+
+	/* We can't update the state of a "pushed" VCPU	 */
+	if (WARN_ON(vcpu->arch.xive_pushed))
+		return -EIO;
+
+	/*
+	 * Restore the thread context registers. IPB and CPPR should
+	 * be the only ones that matter.
+	 */
+	vcpu->arch.xive_saved_state.w01 = val->xive_timaval[0];
+
+	/*
+	 * There is no need to restore the XIVE internal state (IPB
+	 * stored in the NVT) as the IPB register was merged in KVM VP
+	 * state when captured.
+	 */
+	return 0;
+}
+
 static int xive_native_debug_show(struct seq_file *m, void *private)
 {
 	struct kvmppc_xive *xive = m->private;
diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/virtual/kvm/devices/xive.txt
index a26be635cff9..1b8957c50c53 100644
--- a/Documentation/virtual/kvm/devices/xive.txt
+++ b/Documentation/virtual/kvm/devices/xive.txt
@@ -102,6 +102,25 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
     -EINVAL: Not initialized source number, invalid priority or
              invalid CPU number.
 
+* VCPU state
+
+  The XIVE IC maintains VP interrupt state in an internal structure
+  called the NVT. When a VP is not dispatched on a HW processor
+  thread, this structure can be updated by HW if the VP is the target
+  of an event notification.
+
+  It is important for migration to capture the cached IPB from the NVT
+  as it synthesizes the priorities of the pending interrupts. We
+  capture a bit more to report debug information.
+
+  KVM_REG_PPC_VP_STATE (4 * 64bits)
+  bits:     |  63  ....  32  |  31  ....  0  |
+  values:   |   TIMA word0   |   TIMA word1  |
+  bits:     | 127       ..........       64  |
+  values:   |         VP CAM Line            |
+  bits:     | 255       ..........      128  |
+  values:   |            unused              |
+
 * Migration:
 
   Saving the state of a VM using the XIVE native exploitation mode
-- 
2.20.1

