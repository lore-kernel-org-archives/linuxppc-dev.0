Return-Path: <SRS0=vpml=PP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03286C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 19:19:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E99206B7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 19:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E99206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YQFH6ptNzDqJs
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 06:19:47 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YQ2X1SXczDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 06:10:27 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x07J3pxe055342
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Jan 2019 14:10:24 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pv9atm3hx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Jan 2019 14:10:24 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@kaod.org>;
 Mon, 7 Jan 2019 19:10:21 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 7 Jan 2019 19:10:18 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x07JAHuD41418816
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 7 Jan 2019 19:10:17 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA8794C04A;
 Mon,  7 Jan 2019 19:10:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9EEC84C040;
 Mon,  7 Jan 2019 19:10:17 +0000 (GMT)
Received: from smtp.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.1])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  7 Jan 2019 19:10:17 +0000 (GMT)
Received: from zorba.kaod.org.com (sig-9-145-153-156.de.ibm.com
 [9.145.153.156])
 by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id D6FC12201CD;
 Mon,  7 Jan 2019 20:10:16 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 17/19] KVM: PPC: Book3S HV: add get/set accessors for the VP
 XIVE state
Date: Mon,  7 Jan 2019 20:10:04 +0100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107184331.8429-1-clg@kaod.org>
References: <20190107184331.8429-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19010719-0028-0000-0000-000003358579
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010719-0029-0000-0000-000023F29044
Message-Id: <20190107191006.10648-1-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-07_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=543 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901070160
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

At a VCPU level, the state of the thread context interrupt management
registers needs to be collected. These registers are cached under the
'xive_saved_state.w01' field of the VCPU when the VPCU context is
pulled from the HW thread. An OPAL call retrieves the backup of the
IPB register in the NVT structure and merges it in the KVM state.

The structures of the interface between QEMU and KVM provisions some
extra room (two u64) for further extensions if more state needs to be
transferred back to QEMU.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/include/asm/kvm_ppc.h    |  5 ++
 arch/powerpc/include/uapi/asm/kvm.h   |  2 +
 arch/powerpc/kvm/book3s.c             | 24 +++++++++
 arch/powerpc/kvm/book3s_xive_native.c | 78 +++++++++++++++++++++++++++
 4 files changed, 109 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 4cc897039485..49c488af168c 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -270,6 +270,7 @@ union kvmppc_one_reg {
 		u64	addr;
 		u64	length;
 	}	vpaval;
+	u64	xive_timaval[4];
 };
 
 struct kvmppc_ops {
@@ -603,6 +604,8 @@ extern void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu);
 extern void kvmppc_xive_native_init_module(void);
 extern void kvmppc_xive_native_exit_module(void);
 extern int kvmppc_xive_native_hcall(struct kvm_vcpu *vcpu, u32 cmd);
+extern int kvmppc_xive_native_get_vp(struct kvm_vcpu *vcpu, union kvmppc_one_reg *val);
+extern int kvmppc_xive_native_set_vp(struct kvm_vcpu *vcpu, union kvmppc_one_reg *val);
 
 #else
 static inline int kvmppc_xive_set_xive(struct kvm *kvm, u32 irq, u32 server,
@@ -637,6 +640,8 @@ static inline void kvmppc_xive_native_init_module(void) { }
 static inline void kvmppc_xive_native_exit_module(void) { }
 static inline int kvmppc_xive_native_hcall(struct kvm_vcpu *vcpu, u32 cmd)
 	{ return 0; }
+static inline int kvmppc_xive_native_get_vp(struct kvm_vcpu *vcpu, union kvmppc_one_reg *val) { return 0; }
+static inline int kvmppc_xive_native_set_vp(struct kvm_vcpu *vcpu, union kvmppc_one_reg *val) { return -ENOENT; }
 
 #endif /* CONFIG_KVM_XIVE */
 
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 95302558ce10..3c958c39a782 100644
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
index de7eed191107..5ad658077a35 100644
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
index f4eb71eafc57..1aefb366df0b 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -424,6 +424,84 @@ static int xive_native_validate_queue_size(u32 qsize)
 	}
 }
 
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
+	 *
+	 * TODO: P10 support.
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
+	/* Thread context registers. only restore IPB and CPPR ? */
+	vcpu->arch.xive_saved_state.w01 = val->xive_timaval[0];
+
+	/*
+	 * There is no need to restore the XIVE internal state (IPB
+	 * stored in the NVT) as the IPB register was merged in KVM VP
+	 * state.
+	 */
+	return 0;
+}
+
 static int kvmppc_xive_native_set_source(struct kvmppc_xive *xive, long irq,
 					 u64 addr)
 {
-- 
2.20.1

