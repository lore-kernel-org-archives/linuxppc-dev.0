Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0664EC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 03:13:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C3F02183E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 03:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3F02183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PFPR2fTWzDqHg
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 14:13:47 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PF3x6H84zDqFZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 13:58:37 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2K2sBuJ026917
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 22:58:35 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rbcnv13fd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 22:58:35 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Wed, 20 Mar 2019 02:58:31 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Mar 2019 02:58:28 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2K2wUYg43057232
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 02:58:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E78711C04C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 02:58:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CC8411C04A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 02:58:29 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 02:58:29 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 34C07A0385
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 13:58:27 +1100 (AEDT)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 7/8] powerpc/eeh: EEH for pSeries hot plug
Date: Wed, 20 Mar 2019 13:58:26 +1100
X-Mailer: git-send-email 2.19.0.2.gcad72f5712
In-Reply-To: <cover.1553050609.git.sbobroff@linux.ibm.com>
References: <cover.1553050609.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032002-0012-0000-0000-00000304EFEB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032002-0013-0000-0000-0000213C00EF
Message-Id: <ec3ab4f1b484d37ff0864b439612c01e7ee42948.1553050609.git.sbobroff@linux.ibm.com>
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

On PowerNV and pSeries, devices currently acquire EEH support from
several different places: Boot-time devices from eeh_probe_devices()
and eeh_addr_cache_build(), Virtual Function devices from the pcibios
bus add device hooks and hot plugged devices from pci_hp_add_devices()
(with other platforms using other methods as well).  Unfortunately,
pSeries machines currently discover hot plugged devices using
pci_rescan_bus(), not pci_hp_add_devices(), and so those devices do
not receive EEH support.

Rather than adding another case for pci_rescan_bus(), this change
widens the scope of the pcibios bus add device hooks so that they can
handle all devices. As a side effect this also supports devices
discovered after manually rescanning via /sys/bus/pci/rescan.

Note that on PowerNV, this change allows the EEH subsystem to become
enabled after boot as long as it has not been forced off, which was
not previously possible (it was already possible on pSeries).

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 arch/powerpc/kernel/eeh.c                    |  2 +-
 arch/powerpc/kernel/of_platform.c            |  3 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c |  8 ++-
 arch/powerpc/platforms/pseries/eeh_pseries.c | 54 ++++++++++----------
 4 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 7a406d58d2c0..217e14bb1fb6 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1291,7 +1291,7 @@ void eeh_add_device_late(struct pci_dev *dev)
 	struct pci_dn *pdn;
 	struct eeh_dev *edev;
 
-	if (!dev || !eeh_enabled())
+	if (!dev)
 		return;
 
 	pr_debug("EEH: Adding device %s\n", pci_name(dev));
diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index becaec990140..d5818e9c4069 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -86,7 +86,8 @@ static int of_pci_phb_probe(struct platform_device *dev)
 	pcibios_claim_one_bus(phb->bus);
 
 	/* Finish EEH setup */
-	eeh_add_device_tree_late(phb->bus);
+	if (!eeh_has_flag(EEH_FORCE_DISABLED))
+		eeh_add_device_tree_late(phb->bus);
 
 	/* Add probed PCI devices to the device model */
 	pci_bus_add_devices(phb->bus);
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 51c5b6bb9b0e..81b0923cc55f 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -47,7 +47,7 @@ void pnv_pcibios_bus_add_device(struct pci_dev *pdev)
 {
 	struct pci_dn *pdn = pci_get_pdn(pdev);
 
-	if (!pdev->is_virtfn)
+	if (eeh_has_flag(EEH_FORCE_DISABLED))
 		return;
 
 	pr_debug("%s: EEH: Setting up device %s.\n", __func__, pci_name(pdev));
@@ -479,7 +479,11 @@ static void *pnv_eeh_probe(struct pci_dn *pdn, void *data)
 	 * Enable EEH explicitly so that we will do EEH check
 	 * while accessing I/O stuff
 	 */
-	eeh_add_flag(EEH_ENABLED);
+	if (!eeh_has_flag(EEH_ENABLED)) {
+		enable_irq(eeh_event_irq);
+		eeh_add_flag(EEH_PHB_ENABLED);
+		eeh_add_flag(EEH_ENABLED);
+	}
 
 	/* Save memory bars */
 	eeh_save_bars(edev);
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index ae06878fbdea..e68c79164974 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -55,44 +55,44 @@ static int ibm_get_config_addr_info;
 static int ibm_get_config_addr_info2;
 static int ibm_configure_pe;
 
-#ifdef CONFIG_PCI_IOV
 void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
 {
 	struct pci_dn *pdn = pci_get_pdn(pdev);
-	struct pci_dn *physfn_pdn;
-	struct eeh_dev *edev;
 
-	if (!pdev->is_virtfn)
+	if (eeh_has_flag(EEH_FORCE_DISABLED))
 		return;
 
 	pr_debug("%s: EEH: Setting up device %s.\n", __func__, pci_name(pdev));
+#ifdef CONFIG_PCI_IOV
+	if (pdev->is_virtfn) {
+		struct pci_dn *physfn_pdn;
 
-	pdn->device_id  =  pdev->device;
-	pdn->vendor_id  =  pdev->vendor;
-	pdn->class_code =  pdev->class;
-	/*
-	 * Last allow unfreeze return code used for retrieval
-	 * by user space in eeh-sysfs to show the last command
-	 * completion from platform.
-	 */
-	pdn->last_allow_rc =  0;
-	physfn_pdn      =  pci_get_pdn(pdev->physfn);
-	pdn->pe_number  =  physfn_pdn->pe_num_map[pdn->vf_index];
-	edev = pdn_to_eeh_dev(pdn);
-
-	/*
-	 * The following operations will fail if VF's sysfs files
-	 * aren't created or its resources aren't finalized.
-	 */
+		pdn->device_id  =  pdev->device;
+		pdn->vendor_id  =  pdev->vendor;
+		pdn->class_code =  pdev->class;
+		/*
+		 * Last allow unfreeze return code used for retrieval
+		 * by user space in eeh-sysfs to show the last command
+		 * completion from platform.
+		 */
+		pdn->last_allow_rc =  0;
+		physfn_pdn      =  pci_get_pdn(pdev->physfn);
+		pdn->pe_number  =  physfn_pdn->pe_num_map[pdn->vf_index];
+	}
+#endif
 	eeh_add_device_early(pdn);
 	eeh_add_device_late(pdev);
-	edev->pe_config_addr =  (pdn->busno << 16) | (pdn->devfn << 8);
-	eeh_rmv_from_parent_pe(edev); /* Remove as it is adding to bus pe */
-	eeh_add_to_parent_pe(edev);   /* Add as VF PE type */
-	eeh_sysfs_add_device(pdev);
+#ifdef CONFIG_PCI_IOV
+	if (pdev->is_virtfn) {
+		struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
 
-}
+		edev->pe_config_addr =  (pdn->busno << 16) | (pdn->devfn << 8);
+		eeh_rmv_from_parent_pe(edev); /* Remove as it is adding to bus pe */
+		eeh_add_to_parent_pe(edev);   /* Add as VF PE type */
+	}
 #endif
+	eeh_sysfs_add_device(pdev);
+}
 
 /*
  * Buffer for reporting slot-error-detail rtas calls. Its here
@@ -159,10 +159,8 @@ static int pseries_eeh_init(void)
 	/* Set EEH probe mode */
 	eeh_add_flag(EEH_PROBE_MODE_DEVTREE | EEH_ENABLE_IO_FOR_LOG);
 
-#ifdef CONFIG_PCI_IOV
 	/* Set EEH machine dependent code */
 	ppc_md.pcibios_bus_add_device = pseries_pcibios_bus_add_device;
-#endif
 
 	return 0;
 }
-- 
2.19.0.2.gcad72f5712

