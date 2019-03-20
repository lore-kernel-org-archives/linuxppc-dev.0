Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B3FC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 03:00:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 084D920857
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 03:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084D920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PF5v1nhJzDqH5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 14:00:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sbobroff@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PF3w59BFzDqFM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 13:58:36 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2K2s9Dq026821
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 22:58:33 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rbcnv13ej-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 22:58:33 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Wed, 20 Mar 2019 02:58:27 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Mar 2019 02:58:25 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2K2wSvW45547650
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 02:58:28 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77DB552051
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 02:58:28 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 27E3552050
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 02:58:28 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 282B7A024A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 13:58:27 +1100 (AEDT)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/8] powerpc/64: Adjust order in pcibios_init()
Date: Wed, 20 Mar 2019 13:58:20 +1100
X-Mailer: git-send-email 2.19.0.2.gcad72f5712
In-Reply-To: <cover.1553050609.git.sbobroff@linux.ibm.com>
References: <cover.1553050609.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032002-0008-0000-0000-000002CF5B11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032002-0009-0000-0000-0000223B703D
Message-Id: <fcdb48612cb4cb777ed33a617b932b054170b074.1553050609.git.sbobroff@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-20_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903200018
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The pcibios_init() function for 64 bit PowerPC currently calls
pci_bus_add_devices() before pcibios_resource_survey(), which seems
incorrect because it adds devices and attempts to bind their drivers
before allocating their resources (although no problems seem to be
apparent).

So move the call to pci_bus_add_devices() to after
pcibios_resource_survey(), while extracting call to the
pcibios_fixup() hook so that it remains in the same location.

This will also allow the ppc_md.pcibios_bus_add_device() hooks to
perform actions that depend on PCI resources, both during rescanning
(where this is already the case) and at boot time, to support future
work.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 arch/powerpc/kernel/pci-common.c |  4 ----
 arch/powerpc/kernel/pci_32.c     |  4 ++++
 arch/powerpc/kernel/pci_64.c     | 12 +++++++++---
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index ff4b7539cbdf..3146eb73e3b3 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1383,10 +1383,6 @@ void __init pcibios_resource_survey(void)
 		pr_debug("PCI: Assigning unassigned resources...\n");
 		pci_assign_unassigned_resources();
 	}
-
-	/* Call machine dependent fixup */
-	if (ppc_md.pcibios_fixup)
-		ppc_md.pcibios_fixup();
 }
 
 /* This is used by the PCI hotplug driver to allocate resource
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index d3f04f2d8249..40aaa1a6e193 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -259,6 +259,10 @@ static int __init pcibios_init(void)
 	/* Call common code to handle resource allocation */
 	pcibios_resource_survey();
 
+	/* Call machine dependent fixup */
+	if (ppc_md.pcibios_fixup)
+		ppc_md.pcibios_fixup();
+
 	/* Call machine dependent post-init code */
 	if (ppc_md.pcibios_after_init)
 		ppc_md.pcibios_after_init();
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 9d8c10d55407..6f16f30031d7 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -58,14 +58,20 @@ static int __init pcibios_init(void)
 	pci_add_flags(PCI_ENABLE_PROC_DOMAINS | PCI_COMPAT_DOMAIN_0);
 
 	/* Scan all of the recorded PCI controllers.  */
-	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
 		pcibios_scan_phb(hose);
-		pci_bus_add_devices(hose->bus);
-	}
 
 	/* Call common code to handle resource allocation */
 	pcibios_resource_survey();
 
+	/* Add devices. */
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
+		pci_bus_add_devices(hose->bus);
+
+	/* Call machine dependent fixup */
+	if (ppc_md.pcibios_fixup)
+		ppc_md.pcibios_fixup();
+
 	printk(KERN_DEBUG "PCI: Probing PCI hardware done\n");
 
 	return 0;
-- 
2.19.0.2.gcad72f5712

