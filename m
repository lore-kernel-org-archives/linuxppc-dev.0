Return-Path: <SRS0=0xlf=J3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12185C433ED
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Apr 2021 08:08:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9080B610FA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Apr 2021 08:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9080B610FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FWlPK1vrSz3dh9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Apr 2021 18:08:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (domain owner discourages use of this
 host) smtp.mailfrom=kaod.org (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=clg@kaod.org;
 receiver=<UNKNOWN>)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FWlJf4nScz30JY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Apr 2021 18:04:34 +1000 (AEST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13U83EPG157368; Fri, 30 Apr 2021 04:04:22 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3889t26cc2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Apr 2021 04:04:21 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13U849tG023345;
 Fri, 30 Apr 2021 08:04:19 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma06ams.nl.ibm.com with ESMTP id 384akhaxqs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Apr 2021 08:04:19 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 13U83qNe29884762
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Apr 2021 08:03:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5801C42049;
 Fri, 30 Apr 2021 08:04:17 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3528342041;
 Fri, 30 Apr 2021 08:04:17 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Fri, 30 Apr 2021 08:04:17 +0000 (GMT)
Received: from yukon.ibmuc.com (unknown [9.171.40.192])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id B58ED2200B7;
 Fri, 30 Apr 2021 10:04:16 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 10/31] powerpc/pseries/pci: Add support of MSI domains to PHB
 hotplug
Date: Fri, 30 Apr 2021 10:03:46 +0200
Message-Id: <20210430080407.4030767-11-clg@kaod.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210430080407.4030767-1-clg@kaod.org>
References: <20210430080407.4030767-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D6HSpYs357OKTJ-5JM55Nx_3deP7S3qR
X-Proofpoint-ORIG-GUID: D6HSpYs357OKTJ-5JM55Nx_3deP7S3qR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-30_05:2021-04-28,
 2021-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=871
 impostorscore=0 bulkscore=0 clxscore=1034 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104300056
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Simply allocate or release the MSI domains when a PHB is inserted in
or removed from the machine.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 arch/powerpc/platforms/pseries/pseries.h   |  1 +
 arch/powerpc/platforms/pseries/msi.c       | 10 ++++++++++
 arch/powerpc/platforms/pseries/pci_dlpar.c |  4 ++++
 3 files changed, 15 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/plat=
forms/pseries/pseries.h
index 91cf2afcf423..57bf4c2091e1 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -88,6 +88,7 @@ int pseries_root_bridge_prepare(struct pci_host_bridge =
*bridge);
=20
 extern struct pci_controller_ops pseries_pci_controller_ops;
 int pseries_msi_allocate_domains(struct pci_controller *phb);
+void pseries_msi_free_domains(struct pci_controller *phb);
=20
 unsigned long pseries_memory_block_size(void);
=20
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platform=
s/pseries/msi.c
index da9d63a088bb..d1470941cadf 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -733,6 +733,16 @@ int pseries_msi_allocate_domains(struct pci_controll=
er *phb)
 	return __pseries_msi_allocate_domains(phb, count);
 }
=20
+void pseries_msi_free_domains(struct pci_controller *phb)
+{
+	if (phb->msi_domain)
+		irq_domain_remove(phb->msi_domain);
+	if (phb->dev_domain)
+		irq_domain_remove(phb->dev_domain);
+	if (phb->fwnode)
+		irq_domain_free_fwnode(phb->fwnode);
+}
+
 static void rtas_msi_pci_irq_fixup(struct pci_dev *pdev)
 {
 	/* No LSI -> leave MSIs (if any) configured */
diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/pl=
atforms/pseries/pci_dlpar.c
index f9ae17e8a0f4..cf8a2e7a0f2c 100644
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -33,6 +33,8 @@ struct pci_controller *init_phb_dynamic(struct device_n=
ode *dn)
=20
 	pci_devs_phb_init_dynamic(phb);
=20
+	pseries_msi_allocate_domains(phb);
+
 	/* Create EEH devices for the PHB */
 	eeh_phb_pe_create(phb);
=20
@@ -73,6 +75,8 @@ int remove_phb_dynamic(struct pci_controller *phb)
 		}
 	}
=20
+	pseries_msi_free_domains(phb);
+
 	/* Remove the PCI bus and unregister the bridge device from sysfs */
 	phb->bus =3D NULL;
 	pci_remove_bus(b);
--=20
2.26.3

