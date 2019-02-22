Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FD9C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:32:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A00672070D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00672070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445TjN59jXzDqXS
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 22:32:56 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 445Tcr1C2KzDqWr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 22:28:57 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1MBRnFm091288
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:28:55 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qtg7vg1r9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:28:54 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@kaod.org>;
 Fri, 22 Feb 2019 11:28:52 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Feb 2019 11:28:49 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1MBSmOO60948604
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Feb 2019 11:28:48 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 16DBBA4060;
 Fri, 22 Feb 2019 11:28:48 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDF51A405C;
 Fri, 22 Feb 2019 11:28:47 +0000 (GMT)
Received: from smtp.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.1])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 Feb 2019 11:28:47 +0000 (GMT)
Received: from zorba.kaod.org.com (sig-9-145-77-130.uk.ibm.com [9.145.77.130])
 by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id
 06EE0220296; Fri, 22 Feb 2019 12:28:46 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v2 01/16] powerpc/xive: add OPAL extensions for the XIVE
 native exploitation support
Date: Fri, 22 Feb 2019 12:28:25 +0100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222112840.25000-1-clg@kaod.org>
References: <20190222112840.25000-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022211-0028-0000-0000-0000034BB54D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022211-0029-0000-0000-00002409FDBF
Message-Id: <20190222112840.25000-2-clg@kaod.org>
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

The support for XIVE native exploitation mode in Linux/KVM needs a
couple more OPAL calls to configure the sPAPR guest and to get/set the
state of the XIVE internal structures.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/include/asm/opal-api.h           | 11 ++-
 arch/powerpc/include/asm/opal.h               |  7 ++
 arch/powerpc/include/asm/xive.h               | 14 +++
 arch/powerpc/sysdev/xive/native.c             | 99 +++++++++++++++++++
 .../powerpc/platforms/powernv/opal-wrappers.S |  3 +
 5 files changed, 130 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 870fb7b239ea..cdfc54f78101 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -186,8 +186,8 @@
 #define OPAL_XIVE_FREE_IRQ			140
 #define OPAL_XIVE_SYNC				141
 #define OPAL_XIVE_DUMP				142
-#define OPAL_XIVE_RESERVED3			143
-#define OPAL_XIVE_RESERVED4			144
+#define OPAL_XIVE_GET_QUEUE_STATE		143
+#define OPAL_XIVE_SET_QUEUE_STATE		144
 #define OPAL_SIGNAL_SYSTEM_RESET		145
 #define OPAL_NPU_INIT_CONTEXT			146
 #define OPAL_NPU_DESTROY_CONTEXT		147
@@ -209,8 +209,11 @@
 #define OPAL_SENSOR_GROUP_ENABLE		163
 #define OPAL_PCI_GET_PBCQ_TUNNEL_BAR		164
 #define OPAL_PCI_SET_PBCQ_TUNNEL_BAR		165
-#define	OPAL_NX_COPROC_INIT			167
-#define OPAL_LAST				167
+#define OPAL_HANDLE_HMI2			166
+#define OPAL_NX_COPROC_INIT			167
+#define OPAL_NPU_SET_RELAXED_ORDER		168
+#define OPAL_NPU_GET_RELAXED_ORDER		169
+#define OPAL_XIVE_GET_VP_STATE			170
 
 #define QUIESCE_HOLD			1 /* Spin all calls at entry */
 #define QUIESCE_REJECT			2 /* Fail all calls with OPAL_BUSY */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index a55b01c90bb1..4e978d4dea5c 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -279,6 +279,13 @@ int64_t opal_xive_allocate_irq(uint32_t chip_id);
 int64_t opal_xive_free_irq(uint32_t girq);
 int64_t opal_xive_sync(uint32_t type, uint32_t id);
 int64_t opal_xive_dump(uint32_t type, uint32_t id);
+int64_t opal_xive_get_queue_state(uint64_t vp, uint32_t prio,
+				  __be32 *out_qtoggle,
+				  __be32 *out_qindex);
+int64_t opal_xive_set_queue_state(uint64_t vp, uint32_t prio,
+				  uint32_t qtoggle,
+				  uint32_t qindex);
+int64_t opal_xive_get_vp_state(uint64_t vp, __be64 *out_w01);
 int64_t opal_pci_set_p2p(uint64_t phb_init, uint64_t phb_target,
 			uint64_t desc, uint16_t pe_number);
 
diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
index 3c704f5dd3ae..b579a943407b 100644
--- a/arch/powerpc/include/asm/xive.h
+++ b/arch/powerpc/include/asm/xive.h
@@ -109,12 +109,26 @@ extern int xive_native_configure_queue(u32 vp_id, struct xive_q *q, u8 prio,
 extern void xive_native_disable_queue(u32 vp_id, struct xive_q *q, u8 prio);
 
 extern void xive_native_sync_source(u32 hw_irq);
+extern void xive_native_sync_queue(u32 hw_irq);
 extern bool is_xive_irq(struct irq_chip *chip);
 extern int xive_native_enable_vp(u32 vp_id, bool single_escalation);
 extern int xive_native_disable_vp(u32 vp_id);
 extern int xive_native_get_vp_info(u32 vp_id, u32 *out_cam_id, u32 *out_chip_id);
 extern bool xive_native_has_single_escalation(void);
 
+extern int xive_native_get_queue_info(u32 vp_id, uint32_t prio,
+				      u64 *out_qpage,
+				      u64 *out_qsize,
+				      u64 *out_qeoi_page,
+				      u32 *out_escalate_irq,
+				      u64 *out_qflags);
+
+extern int xive_native_get_queue_state(u32 vp_id, uint32_t prio, u32 *qtoggle,
+				       u32 *qindex);
+extern int xive_native_set_queue_state(u32 vp_id, uint32_t prio, u32 qtoggle,
+				       u32 qindex);
+extern int xive_native_get_vp_state(u32 vp_id, u64 *out_state);
+
 #else
 
 static inline bool xive_enabled(void) { return false; }
diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index 1ca127d052a6..0c037e933e55 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -437,6 +437,12 @@ void xive_native_sync_source(u32 hw_irq)
 }
 EXPORT_SYMBOL_GPL(xive_native_sync_source);
 
+void xive_native_sync_queue(u32 hw_irq)
+{
+	opal_xive_sync(XIVE_SYNC_QUEUE, hw_irq);
+}
+EXPORT_SYMBOL_GPL(xive_native_sync_queue);
+
 static const struct xive_ops xive_native_ops = {
 	.populate_irq_data	= xive_native_populate_irq_data,
 	.configure_irq		= xive_native_configure_irq,
@@ -711,3 +717,96 @@ bool xive_native_has_single_escalation(void)
 	return xive_has_single_esc;
 }
 EXPORT_SYMBOL_GPL(xive_native_has_single_escalation);
+
+int xive_native_get_queue_info(u32 vp_id, u32 prio,
+			       u64 *out_qpage,
+			       u64 *out_qsize,
+			       u64 *out_qeoi_page,
+			       u32 *out_escalate_irq,
+			       u64 *out_qflags)
+{
+	__be64 qpage;
+	__be64 qsize;
+	__be64 qeoi_page;
+	__be32 escalate_irq;
+	__be64 qflags;
+	s64 rc;
+
+	rc = opal_xive_get_queue_info(vp_id, prio, &qpage, &qsize,
+				      &qeoi_page, &escalate_irq, &qflags);
+	if (rc) {
+		pr_err("OPAL failed to get queue info for VCPU %d/%d : %lld\n",
+		       vp_id, prio, rc);
+		return -EIO;
+	}
+
+	if (out_qpage)
+		*out_qpage = be64_to_cpu(qpage);
+	if (out_qsize)
+		*out_qsize = be32_to_cpu(qsize);
+	if (out_qeoi_page)
+		*out_qeoi_page = be64_to_cpu(qeoi_page);
+	if (out_escalate_irq)
+		*out_escalate_irq = be32_to_cpu(escalate_irq);
+	if (out_qflags)
+		*out_qflags = be64_to_cpu(qflags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xive_native_get_queue_info);
+
+int xive_native_get_queue_state(u32 vp_id, u32 prio, u32 *qtoggle, u32 *qindex)
+{
+	__be32 opal_qtoggle;
+	__be32 opal_qindex;
+	s64 rc;
+
+	rc = opal_xive_get_queue_state(vp_id, prio, &opal_qtoggle,
+				       &opal_qindex);
+	if (rc) {
+		pr_err("OPAL failed to get queue state for VCPU %d/%d : %lld\n",
+		       vp_id, prio, rc);
+		return -EIO;
+	}
+
+	if (qtoggle)
+		*qtoggle = be32_to_cpu(opal_qtoggle);
+	if (qindex)
+		*qindex = be32_to_cpu(opal_qindex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xive_native_get_queue_state);
+
+int xive_native_set_queue_state(u32 vp_id, u32 prio, u32 qtoggle, u32 qindex)
+{
+	s64 rc;
+
+	rc = opal_xive_set_queue_state(vp_id, prio, qtoggle, qindex);
+	if (rc) {
+		pr_err("OPAL failed to set queue state for VCPU %d/%d : %lld\n",
+		       vp_id, prio, rc);
+		return -EIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xive_native_set_queue_state);
+
+int xive_native_get_vp_state(u32 vp_id, u64 *out_state)
+{
+	__be64 state;
+	s64 rc;
+
+	rc = opal_xive_get_vp_state(vp_id, &state);
+	if (rc) {
+		pr_err("OPAL failed to get vp state for VCPU %d : %lld\n",
+		       vp_id, rc);
+		return -EIO;
+	}
+
+	if (out_state)
+		*out_state = be64_to_cpu(state);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xive_native_get_vp_state);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index f4875fe3f8ff..3179953d6b56 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -309,6 +309,9 @@ OPAL_CALL(opal_xive_get_vp_info,		OPAL_XIVE_GET_VP_INFO);
 OPAL_CALL(opal_xive_set_vp_info,		OPAL_XIVE_SET_VP_INFO);
 OPAL_CALL(opal_xive_sync,			OPAL_XIVE_SYNC);
 OPAL_CALL(opal_xive_dump,			OPAL_XIVE_DUMP);
+OPAL_CALL(opal_xive_get_queue_state,		OPAL_XIVE_GET_QUEUE_STATE);
+OPAL_CALL(opal_xive_set_queue_state,		OPAL_XIVE_SET_QUEUE_STATE);
+OPAL_CALL(opal_xive_get_vp_state,		OPAL_XIVE_GET_VP_STATE);
 OPAL_CALL(opal_signal_system_reset,		OPAL_SIGNAL_SYSTEM_RESET);
 OPAL_CALL(opal_npu_init_context,		OPAL_NPU_INIT_CONTEXT);
 OPAL_CALL(opal_npu_destroy_context,		OPAL_NPU_DESTROY_CONTEXT);
-- 
2.20.1

