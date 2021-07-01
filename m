Return-Path: <SRS0=ZiU1=LZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A9DC11F69
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Jul 2021 13:38:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50B74613FD
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Jul 2021 13:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B74613FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GFzml0Sf0z3fVM
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Jul 2021 23:37:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (domain owner discourages use of this
 host) smtp.mailfrom=kaod.org (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=clg@kaod.org;
 receiver=<UNKNOWN>)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GFzYl35DRz3bc8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jul 2021 23:28:27 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 161D399t168502; Thu, 1 Jul 2021 09:28:15 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 39hdcaan75-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jul 2021 09:28:15 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 161DK457009382;
 Thu, 1 Jul 2021 13:28:13 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma04ams.nl.ibm.com with ESMTP id 39duv8jeak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jul 2021 13:28:13 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 161DSBnf29950422
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Jul 2021 13:28:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D803B13A09E;
 Thu,  1 Jul 2021 13:28:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A302213A0A0;
 Thu,  1 Jul 2021 13:28:10 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Thu,  1 Jul 2021 13:28:10 +0000 (GMT)
Received: from yukon.ibmuc.com (unknown [9.171.33.183])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id 0067A22016C;
 Thu,  1 Jul 2021 15:28:09 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 28/32] powerpc/powernv/pci: Set the IRQ chip data for
 P8/CXL devices
Date: Thu,  1 Jul 2021 15:27:46 +0200
Message-Id: <20210701132750.1475580-29-clg@kaod.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210701132750.1475580-1-clg@kaod.org>
References: <20210701132750.1475580-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -GR35hT6mIkfN5_Qp3qMzvzwctyrAfta
X-Proofpoint-ORIG-GUID: -GR35hT6mIkfN5_Qp3qMzvzwctyrAfta
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-07-01_07:2021-07-01,
 2021-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1034
 adultscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=736 suspectscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107010082
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
Cc: Frederic Barrat <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Before MSI domains, the default IRQ chip of PHB3 MSIs was patched by
pnv_set_msi_irq_chip() with the custom EOI handler pnv_ioda2_msi_eoi()
and the owning PHB was deduced from the 'ioda.irq_chip' field. This
path has been deprecated by the MSI domains but it is still in use by
the P8 CAPI 'cxl' driver.

Rewriting this driver to support MSI would be a waste of time.
Nevertheless, we can still remove the IRQ chip patch and set the IRQ
chip data instead. This is cleaner.

Cc: Frederic Barrat <fbarrat@linux.ibm.com>
Cc: Christophe Lombard <clombard@linux.vnet.ibm.com>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
index 6c4b37598bcc..aa97245eedbf 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1971,19 +1971,23 @@ int64_t pnv_opal_pci_msi_eoi(struct irq_chip *chi=
p, unsigned int hw_irq)
 	return opal_pci_msi_eoi(phb->opal_id, hw_irq);
 }
=20
+/*
+ * The IRQ data is mapped in the XICS domain, with OPAL HW IRQ numbers
+ */
 static void pnv_ioda2_msi_eoi(struct irq_data *d)
 {
 	int64_t rc;
 	unsigned int hw_irq =3D (unsigned int)irqd_to_hwirq(d);
-	struct irq_chip *chip =3D irq_data_get_irq_chip(d);
+	struct pci_controller *hose =3D irq_data_get_irq_chip_data(d);
+	struct pnv_phb *phb =3D hose->private_data;
=20
-	rc =3D pnv_opal_pci_msi_eoi(chip, hw_irq);
+	rc =3D opal_pci_msi_eoi(phb->opal_id, hw_irq);
 	WARN_ON_ONCE(rc);
=20
 	icp_native_eoi(d);
 }
=20
-
+/* P8/CXL only */
 void pnv_set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq)
 {
 	struct irq_data *idata;
@@ -2005,6 +2009,7 @@ void pnv_set_msi_irq_chip(struct pnv_phb *phb, unsi=
gned int virq)
 		phb->ioda.irq_chip.irq_eoi =3D pnv_ioda2_msi_eoi;
 	}
 	irq_set_chip(virq, &phb->ioda.irq_chip);
+	irq_set_chip_data(virq, phb->hose);
 }
=20
 static struct irq_chip pnv_pci_msi_irq_chip;
--=20
2.31.1

