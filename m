Return-Path: <SRS0=0xlf=J3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A635C433B4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Apr 2021 08:11:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0587C61186
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Apr 2021 08:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0587C61186
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FWlT757twz3fYR
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Apr 2021 18:11:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (domain owner discourages use of this
 host) smtp.mailfrom=kaod.org (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=clg@kaod.org;
 receiver=<UNKNOWN>)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FWlJm2tYMz304G
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Apr 2021 18:04:38 +1000 (AEST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13U83ZlB195913; Fri, 30 Apr 2021 04:04:21 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 388drsrh5f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Apr 2021 04:04:20 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13U80XGb027724;
 Fri, 30 Apr 2021 08:04:18 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma04ams.nl.ibm.com with ESMTP id 384ay8jxyk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Apr 2021 08:04:18 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 13U84GM741943538
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Apr 2021 08:04:16 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69AD111C04A;
 Fri, 30 Apr 2021 08:04:16 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 40FA611C050;
 Fri, 30 Apr 2021 08:04:16 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Fri, 30 Apr 2021 08:04:16 +0000 (GMT)
Received: from yukon.ibmuc.com (unknown [9.171.40.192])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id AA2E42200B7;
 Fri, 30 Apr 2021 10:04:15 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/31] powerpc/pseries/pci: Add a domain_free_irqs handler
Date: Fri, 30 Apr 2021 10:03:44 +0200
Message-Id: <20210430080407.4030767-9-clg@kaod.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210430080407.4030767-1-clg@kaod.org>
References: <20210430080407.4030767-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xmx8TeRlzuBL9zAatuyhCweHz5KO6DyW
X-Proofpoint-GUID: xmx8TeRlzuBL9zAatuyhCweHz5KO6DyW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-30_05:2021-04-28,
 2021-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 clxscore=1034 suspectscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=867 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104300056
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
Cc: Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The RTAS firmware can not disable one MSI at a time. It's all or
nothing. We need a custom free IRQ handler for that.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 arch/powerpc/platforms/pseries/msi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platform=
s/pseries/msi.c
index a9bd1e991df5..a41c448520d4 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -529,8 +529,24 @@ static int pseries_msi_ops_prepare(struct irq_domain=
 *domain, struct device *dev
 	return rtas_prepare_msi_irqs(pdev, nvec, type, arg);
 }
=20
+/*
+ * RTAS can not disable one MSI at a time. It's all or nothing. Do it
+ * at the end after all IRQs have been freed.
+ */
+static void pseries_msi_domain_free_irqs(struct irq_domain *domain,
+					 struct device *dev)
+{
+	if (WARN_ON_ONCE(!dev_is_pci(dev)))
+		return;
+
+	__msi_domain_free_irqs(domain, dev);
+
+	rtas_disable_msi(to_pci_dev(dev));
+}
+
 static struct msi_domain_ops pseries_pci_msi_domain_ops =3D {
 	.msi_prepare	=3D pseries_msi_ops_prepare,
+	.domain_free_irqs =3D pseries_msi_domain_free_irqs,
 };
=20
 static void pseries_msi_shutdown(struct irq_data *d)
--=20
2.26.3

