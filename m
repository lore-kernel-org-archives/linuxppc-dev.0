Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99136C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:49:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D1FA20652
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1FA20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445V3z04pDzDqTN
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 22:49:03 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 445Td21GzVzDqWY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 22:29:09 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1MBO7Vr040618
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:29:01 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qtefsndb5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:29:00 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@kaod.org>;
 Fri, 22 Feb 2019 11:28:58 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Feb 2019 11:28:54 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1MBSr5G59572458
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 22 Feb 2019 11:28:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9301811C050;
 Fri, 22 Feb 2019 11:28:53 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 768D711C04C;
 Fri, 22 Feb 2019 11:28:53 +0000 (GMT)
Received: from smtp.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.1])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 Feb 2019 11:28:53 +0000 (GMT)
Received: from zorba.kaod.org.com (sig-9-145-77-130.uk.ibm.com [9.145.77.130])
 by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id
 B7A7322026B; Fri, 22 Feb 2019 12:28:52 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v2 08/16] KVM: PPC: Book3S HV: XIVE: add a control to sync the
 sources
Date: Fri, 22 Feb 2019 12:28:32 +0100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222112840.25000-1-clg@kaod.org>
References: <20190222112840.25000-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022211-0012-0000-0000-000002F8DF9B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022211-0013-0000-0000-00002130792F
Message-Id: <20190222112840.25000-9-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-22_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=781 adultscore=0 classifier=spam adjust=0 reason=mlx
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

This control will be used by the H_INT_SYNC hcall from QEMU.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/include/uapi/asm/kvm.h        |  1 +
 arch/powerpc/kvm/book3s_xive_native.c      | 34 ++++++++++++++++++++++
 Documentation/virtual/kvm/devices/xive.txt |  9 ++++++
 3 files changed, 44 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 7ae8cb22af7d..289c504b7c1d 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -681,6 +681,7 @@ struct kvm_ppc_cpu_char {
 #define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source attributes */
 #define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source attributes */
 #define KVM_DEV_XIVE_GRP_EQ_CONFIG	4	/* 64-bit eq attributes */
+#define KVM_DEV_XIVE_GRP_SOURCE_SYNC	5       /* 64-bit source attributes */
 
 /* Layout of 64-bit XIVE source attribute values */
 #define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index bb3e121c918a..dd2a9d411fe7 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -341,6 +341,36 @@ static int kvmppc_xive_native_set_source_config(struct kvmppc_xive *xive,
 						       priority, eisn);
 }
 
+static int kvmppc_xive_native_sync_source(struct kvmppc_xive *xive,
+					  long irq, u64 addr)
+{
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	struct xive_irq_data *xd;
+	u32 hw_num;
+	u16 src;
+
+	pr_devel("%s irq=0x%lx", __func__, irq);
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
+	arch_spin_lock(&sb->lock);
+
+	kvmppc_xive_select_irq(state, &hw_num, &xd);
+	xive_native_sync_source(hw_num);
+
+	arch_spin_unlock(&sb->lock);
+
+	return 0;
+}
+
 static int xive_native_validate_queue_size(u32 qsize)
 {
 	switch (qsize) {
@@ -631,6 +661,9 @@ static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
 	case KVM_DEV_XIVE_GRP_EQ_CONFIG:
 		return kvmppc_xive_native_set_queue_config(xive, attr->attr,
 							   attr->addr);
+	case KVM_DEV_XIVE_GRP_SOURCE_SYNC:
+		return kvmppc_xive_native_sync_source(xive, attr->attr,
+						      attr->addr);
 	}
 	return -ENXIO;
 }
@@ -660,6 +693,7 @@ static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
 		break;
 	case KVM_DEV_XIVE_GRP_SOURCE:
 	case KVM_DEV_XIVE_GRP_SOURCE_CONFIG:
+	case KVM_DEV_XIVE_GRP_SOURCE_SYNC:
 		if (attr->attr >= KVMPPC_XIVE_FIRST_IRQ &&
 		    attr->attr < KVMPPC_XIVE_NR_IRQS)
 			return 0;
diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/virtual/kvm/devices/xive.txt
index f1d007f485a9..267634eae9e0 100644
--- a/Documentation/virtual/kvm/devices/xive.txt
+++ b/Documentation/virtual/kvm/devices/xive.txt
@@ -86,3 +86,12 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
     -EFAULT: Invalid user pointer for attr->addr.
     -ENOMEM: Invalid queue address
     -EIO:    Configuration of the underlying HW failed
+
+  5. KVM_DEV_XIVE_GRP_SOURCE_SYNC (write only)
+  Synchronize the source to flush event notification
+  Attributes:
+    Interrupt source number  (64-bit)
+  Errors:
+    -ENOENT: Unknown source number
+    -EINVAL: Not initialized source number, invalid priority or
+             invalid CPU number.
-- 
2.20.1

