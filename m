Return-Path: <linuxppc-dev+bounces-21608-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753CCCD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 18:09:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQd121tNwz2yY0;
	Thu, 28 May 2026 04:09:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779905350;
	cv=none; b=CfeHXlpJIOcaaAsLUsF+2sGDsWQMTV4+4FEru3ZUAUtAHK5j9UNqOwqjV9qavcpiB2h6RbGf/9jQpkQ0MnEW1PphP1kBvCRAzgEMbfk1RBkKeRjTbwfKXSq0h672zLfaL/66AV4lUzivVC7aGGR1aHjohmoXioKMUybxPYeIH6paLJmQ9DmSxJIafqktXg+tGqv97yQlIAKomvzIlwZIGIXvDmIfZjd989zuMwgeKejRqetoh8kfh6jJOtRJKE40/j5zC9VXcE3eBuVG2NmxxtWkHdqPyxl6xWgOqFw2HTDu4x6RNfpk9LcLopmvwVr+dAOU+DTzMXmBm1x2kWKnPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779905350; c=relaxed/relaxed;
	bh=UAYJMGHqRvUjpDgGjN0gjb0WF60PTnqNAsmxL6LbVNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2dXlxY6wEYF1FBuc3T3nxwKS5ceFwrHN5qg1+kFqzcEKcZd+NlEfOaCGVGBjJoeEXn5BbZ4XmogsoRMTtin7LQLFJPVzeBgY4Edk7BjQ2NONM5ecTU5KN2ECtxrLJyVrsS3jermjJD5VtN042COYVOaaEtsRGPiHxcsc30/SljdbPL+JrLWGWs9Tmzk5teaQ5J2t0M75oFGourK8dwwT3eJOlANt3Xim9JikXeBIB4X5C03wfhcsvw+AGEsiz80O7DrKBhxZDNZME+SNLiOqL7XEJZShuB0QqtlRlMe+R46Z9GAfxEjW+7ncThi3KBeqfGRXNRE/54Os7acI1lAQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ViXqLdFy; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adityag@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ViXqLdFy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adityag@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQd105dDtz2ySC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 04:09:08 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RD13E2346180;
	Wed, 27 May 2026 18:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UAYJMGHqRvUjpDgGj
	N0gjb0WF60PTnqNAsmxL6LbVNM=; b=ViXqLdFyHHYHjAraTIyiT4hagin3b1GBh
	Rn2EdPYUCib84qEDBiS0MorRe+wRpi2K4Q597MXVnx5sbCAZZsbl4czQGl6g1PsW
	HzLKD0XUumsVabGouZM5n2OSPXuhBVsR6oNrA79YxFcFSMx7yxHlLU0/lmNFYZBI
	ysgjLGFCpYFbTjYYM9MG/ugowoyDYNhWto/qdHlUqMP6xTJqUcjdH9RhsuXU2nyD
	IEGaRCN9c4FFlh6rj5p/dKo4OvLialfqbVcLx83NSAJwk33O972E3my2Qf3k8xgk
	DDi0hwCguyOVBc5aITFt/yVstaUV0e70k95/kUdtdgmomx4/iUCYw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nutwje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 18:09:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64RHs5LZ010647;
	Wed, 27 May 2026 18:08:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb4b1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 18:08:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64RI8taM61800922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 18:08:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FBE920043;
	Wed, 27 May 2026 18:08:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5533F20040;
	Wed, 27 May 2026 18:08:51 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.124.220.41])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 18:08:51 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Anastasio <sanastasio@raptorengineering.com>
Cc: sashiko-bot@kernel.org, linux-pci@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: [PATCH v2 3/3] ppc/pnv: Refactor PNV PCI Hotplug to group PCIe functions
Date: Wed, 27 May 2026 23:38:16 +0530
Message-ID: <20260527180816.2749186-4-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527180816.2749186-1-adityag@linux.ibm.com>
References: <20260527180816.2749186-1-adityag@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE4MiBTYWx0ZWRfX0cGsU2ChPcR7
 kEvfwCvjFFnAPfDhKEZ90SYfRfLwvRQ7GNKy1L81XLAdcJ+vbZweejFoFRVWUt2MzmaQI9u/nfI
 Hu4VGYyAOq5awGrBsJDxz5mU3NqxyreVx1X3mYofLeqTcBCustXIGGcoHPCeyvy7Q3Tdb89Kw3S
 wK9B2IsT6lwrba/jDnH0e7j9uvkX8meTCh/K7z9cEx085asFRXcZILBAyAEzg1CAikV4Zk910o1
 PzV9RpiGD95dXcRIOjqq36/Sx7tIjYlZb8J5w5kWwRnoUC7vLU1j3o5l1dLjbyqc1/gdM0RijcI
 xF81wJCtmeRTnQ5GzSIO2tQePQO8CSMkC+T4qZM5bI4TXQRUERiC8JGfT5TMeAQ5koGrSySowWg
 PrqbZ5x7DGnEsl9pnHw1GbAWMOj6hyDzxmilw1VmKrZ/Y9rtO8xjocEJyPoTzjDYFUOqmIpvCgJ
 6XHy8GvuaoEJF1C319w==
X-Authority-Analysis: v=2.4 cv=UtJT8ewB c=1 sm=1 tr=0 ts=6a17333c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=NniskMT7brAqY532XZ8A:9
X-Proofpoint-ORIG-GUID: xg2bGjhoh-etWC96kx-Tadq8nqJCgNox
X-Proofpoint-GUID: wXlQTDsk49ujJxtTvnsFA49CxQuXowOJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1011 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270182

With the refactor change to pnv_php.c, pnv_php_* and pcie_* are mixed
up.

Move and group pcie, opencapi, and pnv_php*.

No functional change. Only moves code, and no logic has been modified.

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 drivers/pci/hotplug/pnv_php.c | 559 +++++++++++++++++-----------------
 1 file changed, 279 insertions(+), 280 deletions(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 997412eea486..dd8e00b879e1 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -38,46 +38,125 @@ static DEFINE_SPINLOCK(pnv_php_lock);
 static void pnv_php_register(struct device_node *dn);
 static void pnv_php_unregister_one(struct device_node *dn);
 static void pnv_php_unregister(struct device_node *dn);
+static irqreturn_t pnv_php_interrupt(int irq, void *data);
+static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
+				bool disable_device, bool disable_msi);
 
-static void pcie_enable_irq(struct pnv_php_slot *php_slot);
-static int pcie_check_link_active(struct pci_dev *pdev);
-static void pcie_detect_surprise_removal(struct pnv_php_slot *php_slot);
-
-static void pcie_fixup_presence_state(struct pnv_php_slot *php_slot, u8 *presence)
+static void pcie_init_irq(struct pnv_php_slot *php_slot, int irq)
 {
-	if (pci_pcie_type(php_slot->pdev) == PCI_EXP_TYPE_DOWNSTREAM &&
-	    *presence == OPAL_PCI_SLOT_EMPTY) {
-		/*
-		 * Similar to pciehp_hpc, check whether the Link Active
-		 * bit is set to account for broken downstream bridges
-		 * that don't properly assert Presence Detect State, as
-		 * was observed on the Microsemi Switchtec PM8533 PFX
-		 * [11f8:8533].
-		 */
-		if (pcie_check_link_active(php_slot->pdev) > 0)
-			*presence = OPAL_PCI_SLOT_PRESENT;
+	struct pci_dev *pdev = php_slot->pdev;
+	u32 broken_pdc = 0;
+	u16 sts, ctrl;
+	int ret;
+
+	/* Check PDC (Presence Detection Change) is broken or not */
+	ret = of_property_read_u32(php_slot->dn, "ibm,slot-broken-pdc",
+				   &broken_pdc);
+	if (!ret && broken_pdc)
+		php_slot->flags |= PNV_PHP_FLAG_BROKEN_PDC;
+
+	/* Clear pending interrupts */
+	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &sts);
+	if (php_slot->flags & PNV_PHP_FLAG_BROKEN_PDC)
+		sts |= PCI_EXP_SLTSTA_DLLSC;
+	else
+		sts |= (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC);
+	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, sts);
+
+	/* Request the interrupt */
+	ret = request_irq(irq, pnv_php_interrupt, IRQF_SHARED,
+			  php_slot->name, php_slot);
+	if (ret) {
+		pnv_php_disable_irq(php_slot, true, true);
+		SLOT_WARN(php_slot, "Error %d enabling IRQ %d\n", ret, irq);
+		return;
 	}
-}
 
-static void pcie_fundamental_reset(struct pnv_php_slot *php_slot)
-{
-	pci_set_pcie_reset_state(php_slot->pdev, pcie_warm_reset);
-	msleep(250);
-	pci_set_pcie_reset_state(php_slot->pdev, pcie_deassert_reset);
+	/* Enable the interrupts */
+	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &ctrl);
+	if (php_slot->flags & PNV_PHP_FLAG_BROKEN_PDC) {
+		ctrl &= ~PCI_EXP_SLTCTL_PDCE;
+		ctrl |= (PCI_EXP_SLTCTL_HPIE |
+			 PCI_EXP_SLTCTL_DLLSCE);
+	} else {
+		ctrl |= (PCI_EXP_SLTCTL_HPIE |
+			 PCI_EXP_SLTCTL_PDCE |
+			 PCI_EXP_SLTCTL_DLLSCE);
+	}
+	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, ctrl);
+
+	/* The interrupt is initialized successfully when @irq is valid */
+	php_slot->irq = irq;
 }
 
-static void pnv_php_enable_irq(struct pnv_php_slot *php_slot)
+static int pcie_enable_msix(struct pnv_php_slot *php_slot)
 {
-	if (php_slot->backend_ops->enable_irq)
-		php_slot->backend_ops->enable_irq(php_slot);
+	struct pci_dev *pdev = php_slot->pdev;
+	struct msix_entry entry;
+	int nr_entries, ret;
+	u16 pcie_flag;
+
+	/* Get total number of MSIx entries */
+	nr_entries = pci_msix_vec_count(pdev);
+	if (nr_entries < 0)
+		return nr_entries;
+
+	/* Check hotplug MSIx entry is in range */
+	pcie_capability_read_word(pdev, PCI_EXP_FLAGS, &pcie_flag);
+	entry.entry = FIELD_GET(PCI_EXP_FLAGS_IRQ, pcie_flag);
+	if (entry.entry >= nr_entries)
+		return -ERANGE;
+
+	/* Enable MSIx */
+	ret = pci_enable_msix_exact(pdev, &entry, 1);
+	if (ret) {
+		SLOT_WARN(php_slot, "Error %d enabling MSIx\n", ret);
+		return ret;
+	}
+
+	return entry.vector;
 }
 
-static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
-				bool disable_device, bool disable_msi)
+static void pcie_enable_irq(struct pnv_php_slot *php_slot)
 {
-	if (php_slot->backend_ops->disable_irq)
-		php_slot->backend_ops->disable_irq(php_slot, disable_device,
-				disable_msi);
+	struct pci_dev *pdev = php_slot->pdev;
+	int irq, ret;
+
+	if (!pdev)
+		return;
+
+	/*
+	 * The MSI/MSIx interrupt might have been occupied by other
+	 * drivers. Don't populate the surprise hotplug capability
+	 * in that case.
+	 */
+	if (pci_dev_msi_enabled(pdev))
+		return;
+
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		SLOT_WARN(php_slot, "Error %d enabling device\n", ret);
+		return;
+	}
+
+	pci_set_master(pdev);
+
+	/* Enable MSIx interrupt */
+	irq = pcie_enable_msix(php_slot);
+	if (irq > 0) {
+		pcie_init_irq(php_slot, irq);
+		return;
+	}
+
+	/*
+	 * Use MSI if MSIx doesn't work. Fail back to legacy INTx
+	 * if MSI doesn't work either
+	 */
+	ret = pci_enable_msi(pdev);
+	if (!ret || pdev->irq) {
+		irq = pdev->irq;
+		pcie_init_irq(php_slot, irq);
+	}
 }
 
 static void pcie_disable_irq(struct pnv_php_slot *php_slot,
@@ -104,8 +183,176 @@ static void pcie_disable_irq(struct pnv_php_slot *php_slot,
 			pci_disable_msi(pdev);
 	}
 
-	if (disable_device)
-		pci_disable_device(pdev);
+	if (disable_device)
+		pci_disable_device(pdev);
+}
+
+static void pcie_get_attention_state(struct pnv_php_slot *php_slot, u8 *state)
+{
+	struct pci_dev *bridge = php_slot->pdev;
+	u16 status;
+
+	pcie_capability_read_word(bridge, PCI_EXP_SLTCTL, &status);
+	*state = (status & (PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC)) >> 6;
+}
+
+static void pcie_set_attention_state(struct pnv_php_slot *php_slot, u8 state)
+{
+	struct pci_dev *bridge = php_slot->pdev;
+	u16 new, mask;
+
+	php_slot->attention_state = state;
+	mask = PCI_EXP_SLTCTL_AIC;
+
+	if (state)
+		new = FIELD_PREP(PCI_EXP_SLTCTL_AIC, state);
+	else
+		new = PCI_EXP_SLTCTL_ATTN_IND_OFF;
+
+	pcie_capability_clear_and_set_word(bridge, PCI_EXP_SLTCTL, mask, new);
+}
+
+static int pcie_check_link_active(struct pci_dev *pdev)
+{
+	u16 lnk_status;
+	int ret;
+
+	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
+	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
+		return -ENODEV;
+
+	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
+
+	return ret;
+}
+
+static void pcie_fixup_presence_state(struct pnv_php_slot *php_slot, u8 *presence)
+{
+	if (pci_pcie_type(php_slot->pdev) == PCI_EXP_TYPE_DOWNSTREAM &&
+	    *presence == OPAL_PCI_SLOT_EMPTY) {
+		/*
+		 * Similar to pciehp_hpc, check whether the Link Active
+		 * bit is set to account for broken downstream bridges
+		 * that don't properly assert Presence Detect State, as
+		 * was observed on the Microsemi Switchtec PM8533 PFX
+		 * [11f8:8533].
+		 */
+		if (pcie_check_link_active(php_slot->pdev) > 0)
+			*presence = OPAL_PCI_SLOT_PRESENT;
+	}
+}
+
+static void pcie_fundamental_reset(struct pnv_php_slot *php_slot)
+{
+	pci_set_pcie_reset_state(php_slot->pdev, pcie_warm_reset);
+	msleep(250);
+	pci_set_pcie_reset_state(php_slot->pdev, pcie_deassert_reset);
+}
+
+static void pcie_detect_surprise_removal(struct pnv_php_slot *php_slot)
+{
+	struct pci_dev *pdev = php_slot->pdev;
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+	int i, rc;
+
+	if (!pdev)
+		return;
+
+	/*
+	 * When a device is surprise removed from a downstream bridge slot,
+	 * the upstream bridge port can still end up frozen due to related EEH
+	 * events, which will in turn block the MSI interrupts for slot hotplug
+	 * detection.
+	 *
+	 * Detect and thaw any frozen upstream PE after slot deactivation.
+	 */
+	edev = pci_dev_to_eeh_dev(pdev);
+	pe = edev ? edev->pe : NULL;
+	rc = eeh_pe_get_state(pe);
+	if ((rc == -ENODEV) || (rc == -ENOENT)) {
+		SLOT_WARN(
+			php_slot,
+			"Upstream bridge PE state unknown, hotplug detect may fail\n");
+	} else {
+		if (pe->state & EEH_PE_ISOLATED) {
+			SLOT_WARN(
+				php_slot,
+				"Upstream bridge PE %02x frozen, thawing...\n",
+				pe->addr);
+			for (i = 0; i < 3; i++)
+				if (!eeh_unfreeze_pe(pe))
+					break;
+			if (i >= 3)
+				SLOT_WARN(
+					php_slot,
+					"Unable to thaw PE %02x, hotplug detect will fail!\n",
+					pe->addr);
+			else
+				SLOT_WARN(php_slot,
+					  "PE %02x thawed successfully\n",
+					  pe->addr);
+		}
+	}
+}
+
+static int pcie_reset_slot(struct pnv_php_slot *php_slot, bool probe)
+{
+	struct pci_dev *bridge = php_slot->pdev;
+	uint16_t sts;
+
+	if (probe)
+		return 0;
+
+	/* mask our interrupt while resetting the bridge */
+	if (php_slot->irq > 0)
+		disable_irq(php_slot->irq);
+
+	pci_bridge_secondary_bus_reset(bridge);
+
+	/* clear any state changes that happened due to the reset */
+	pcie_capability_read_word(php_slot->pdev, PCI_EXP_SLTSTA, &sts);
+	sts &= (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC);
+	pcie_capability_write_word(php_slot->pdev, PCI_EXP_SLTSTA, sts);
+
+	if (php_slot->irq > 0)
+		enable_irq(php_slot->irq);
+
+	return 0;
+}
+
+static const struct pnv_php_backend_ops pnv_php_pcie_ops = {
+	.enable_irq              = pcie_enable_irq,
+	.disable_irq             = pcie_disable_irq,
+	.get_attention_state     = pcie_get_attention_state,
+	.set_attention_state     = pcie_set_attention_state,
+	.fixup_presence_state    = pcie_fixup_presence_state,
+	.fundamental_reset       = pcie_fundamental_reset,
+	.detect_surprise_removal = pcie_detect_surprise_removal,
+	.reset_slot              = pcie_reset_slot,
+};
+
+static int opencapi_reset_slot(struct pnv_php_slot *slot, bool probe)
+{
+	return probe ? 1 : -ENODEV;
+}
+
+static const struct pnv_php_backend_ops pnv_php_opencapi_ops = {
+	.reset_slot              = opencapi_reset_slot,
+};
+
+static void pnv_php_enable_irq(struct pnv_php_slot *php_slot)
+{
+	if (php_slot->backend_ops->enable_irq)
+		php_slot->backend_ops->enable_irq(php_slot);
+}
+
+static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
+				bool disable_device, bool disable_msi)
+{
+	if (php_slot->backend_ops->disable_irq)
+		php_slot->backend_ops->disable_irq(php_slot, disable_device,
+				disable_msi);
 }
 
 static void pnv_php_free_slot(struct kref *kref)
@@ -427,20 +674,6 @@ static int pnv_php_get_power_state(struct hotplug_slot *slot, u8 *state)
 	return 0;
 }
 
-static int pcie_check_link_active(struct pci_dev *pdev)
-{
-	u16 lnk_status;
-	int ret;
-
-	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
-	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
-		return -ENODEV;
-
-	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
-
-	return ret;
-}
-
 static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
 {
 	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
@@ -465,15 +698,6 @@ static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
 	return ret;
 }
 
-static void pcie_get_attention_state(struct pnv_php_slot *php_slot, u8 *state)
-{
-	struct pci_dev *bridge = php_slot->pdev;
-	u16 status;
-
-	pcie_capability_read_word(bridge, PCI_EXP_SLTCTL, &status);
-	*state = (status & (PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC)) >> 6;
-}
-
 static int pnv_php_get_attention_state(struct hotplug_slot *slot, u8 *state)
 {
 	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
@@ -497,22 +721,6 @@ static int pnv_php_set_attention_state(struct hotplug_slot *slot, u8 state)
 	return 0;
 }
 
-static void pcie_set_attention_state(struct pnv_php_slot *php_slot, u8 state)
-{
-	struct pci_dev *bridge = php_slot->pdev;
-	u16 new, mask;
-
-	php_slot->attention_state = state;
-	mask = PCI_EXP_SLTCTL_AIC;
-
-	if (state)
-		new = FIELD_PREP(PCI_EXP_SLTCTL_AIC, state);
-	else
-		new = PCI_EXP_SLTCTL_ATTN_IND_OFF;
-
-	pcie_capability_clear_and_set_word(bridge, PCI_EXP_SLTCTL, mask, new);
-}
-
 static int pnv_php_activate_slot(struct pnv_php_slot *php_slot,
 				 struct hotplug_slot *slot)
 {
@@ -658,31 +866,6 @@ static int pnv_php_reset_slot(struct hotplug_slot *slot, bool probe)
 	return probe ? 0 : -ENODEV;
 }
 
-static int pcie_reset_slot(struct pnv_php_slot *php_slot, bool probe)
-{
-	struct pci_dev *bridge = php_slot->pdev;
-	uint16_t sts;
-
-	if (probe)
-		return 0;
-
-	/* mask our interrupt while resetting the bridge */
-	if (php_slot->irq > 0)
-		disable_irq(php_slot->irq);
-
-	pci_bridge_secondary_bus_reset(bridge);
-
-	/* clear any state changes that happened due to the reset */
-	pcie_capability_read_word(php_slot->pdev, PCI_EXP_SLTSTA, &sts);
-	sts &= (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC);
-	pcie_capability_write_word(php_slot->pdev, PCI_EXP_SLTSTA, sts);
-
-	if (php_slot->irq > 0)
-		enable_irq(php_slot->irq);
-
-	return 0;
-}
-
 static int pnv_php_enable_slot(struct hotplug_slot *slot)
 {
 	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
@@ -800,26 +983,6 @@ static void pnv_php_release(struct pnv_php_slot *php_slot)
 	pnv_php_put_slot(php_slot->parent);
 }
 
-static const struct pnv_php_backend_ops pnv_php_pcie_ops = {
-	.enable_irq              = pcie_enable_irq,
-	.disable_irq             = pcie_disable_irq,
-	.get_attention_state     = pcie_get_attention_state,
-	.set_attention_state     = pcie_set_attention_state,
-	.fixup_presence_state    = pcie_fixup_presence_state,
-	.fundamental_reset       = pcie_fundamental_reset,
-	.detect_surprise_removal = pcie_detect_surprise_removal,
-	.reset_slot              = pcie_reset_slot,
-};
-
-static int opencapi_reset_slot(struct pnv_php_slot *slot, bool probe)
-{
-	return probe ? 1 : -ENODEV;
-}
-
-static const struct pnv_php_backend_ops pnv_php_opencapi_ops = {
-	.reset_slot              = opencapi_reset_slot,
-};
-
 static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
 {
 	struct pnv_php_slot *php_slot;
@@ -934,34 +1097,6 @@ static int pnv_php_register_slot(struct pnv_php_slot *php_slot)
 	return 0;
 }
 
-static int pcie_enable_msix(struct pnv_php_slot *php_slot)
-{
-	struct pci_dev *pdev = php_slot->pdev;
-	struct msix_entry entry;
-	int nr_entries, ret;
-	u16 pcie_flag;
-
-	/* Get total number of MSIx entries */
-	nr_entries = pci_msix_vec_count(pdev);
-	if (nr_entries < 0)
-		return nr_entries;
-
-	/* Check hotplug MSIx entry is in range */
-	pcie_capability_read_word(pdev, PCI_EXP_FLAGS, &pcie_flag);
-	entry.entry = FIELD_GET(PCI_EXP_FLAGS_IRQ, pcie_flag);
-	if (entry.entry >= nr_entries)
-		return -ERANGE;
-
-	/* Enable MSIx */
-	ret = pci_enable_msix_exact(pdev, &entry, 1);
-	if (ret) {
-		SLOT_WARN(php_slot, "Error %d enabling MSIx\n", ret);
-		return ret;
-	}
-
-	return entry.vector;
-}
-
 static void
 pnv_php_detect_clear_surprise_removal_freeze(struct pnv_php_slot *php_slot)
 {
@@ -969,53 +1104,6 @@ pnv_php_detect_clear_surprise_removal_freeze(struct pnv_php_slot *php_slot)
 		php_slot->backend_ops->detect_surprise_removal(php_slot);
 }
 
-static void pcie_detect_surprise_removal(struct pnv_php_slot *php_slot)
-{
-	struct pci_dev *pdev = php_slot->pdev;
-	struct eeh_dev *edev;
-	struct eeh_pe *pe;
-	int i, rc;
-
-	if (!pdev)
-		return;
-
-	/*
-	 * When a device is surprise removed from a downstream bridge slot,
-	 * the upstream bridge port can still end up frozen due to related EEH
-	 * events, which will in turn block the MSI interrupts for slot hotplug
-	 * detection.
-	 *
-	 * Detect and thaw any frozen upstream PE after slot deactivation.
-	 */
-	edev = pci_dev_to_eeh_dev(pdev);
-	pe = edev ? edev->pe : NULL;
-	rc = eeh_pe_get_state(pe);
-	if ((rc == -ENODEV) || (rc == -ENOENT)) {
-		SLOT_WARN(
-			php_slot,
-			"Upstream bridge PE state unknown, hotplug detect may fail\n");
-	} else {
-		if (pe->state & EEH_PE_ISOLATED) {
-			SLOT_WARN(
-				php_slot,
-				"Upstream bridge PE %02x frozen, thawing...\n",
-				pe->addr);
-			for (i = 0; i < 3; i++)
-				if (!eeh_unfreeze_pe(pe))
-					break;
-			if (i >= 3)
-				SLOT_WARN(
-					php_slot,
-					"Unable to thaw PE %02x, hotplug detect will fail!\n",
-					pe->addr);
-			else
-				SLOT_WARN(php_slot,
-					  "PE %02x thawed successfully\n",
-					  pe->addr);
-		}
-	}
-}
-
 static void pnv_php_event_handler(struct work_struct *work)
 {
 	struct pnv_php_event *event =
@@ -1109,95 +1197,6 @@ static irqreturn_t pnv_php_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void pcie_init_irq(struct pnv_php_slot *php_slot, int irq)
-{
-	struct pci_dev *pdev = php_slot->pdev;
-	u32 broken_pdc = 0;
-	u16 sts, ctrl;
-	int ret;
-
-	/* Check PDC (Presence Detection Change) is broken or not */
-	ret = of_property_read_u32(php_slot->dn, "ibm,slot-broken-pdc",
-				   &broken_pdc);
-	if (!ret && broken_pdc)
-		php_slot->flags |= PNV_PHP_FLAG_BROKEN_PDC;
-
-	/* Clear pending interrupts */
-	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &sts);
-	if (php_slot->flags & PNV_PHP_FLAG_BROKEN_PDC)
-		sts |= PCI_EXP_SLTSTA_DLLSC;
-	else
-		sts |= (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC);
-	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, sts);
-
-	/* Request the interrupt */
-	ret = request_irq(irq, pnv_php_interrupt, IRQF_SHARED,
-			  php_slot->name, php_slot);
-	if (ret) {
-		pnv_php_disable_irq(php_slot, true, true);
-		SLOT_WARN(php_slot, "Error %d enabling IRQ %d\n", ret, irq);
-		return;
-	}
-
-	/* Enable the interrupts */
-	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &ctrl);
-	if (php_slot->flags & PNV_PHP_FLAG_BROKEN_PDC) {
-		ctrl &= ~PCI_EXP_SLTCTL_PDCE;
-		ctrl |= (PCI_EXP_SLTCTL_HPIE |
-			 PCI_EXP_SLTCTL_DLLSCE);
-	} else {
-		ctrl |= (PCI_EXP_SLTCTL_HPIE |
-			 PCI_EXP_SLTCTL_PDCE |
-			 PCI_EXP_SLTCTL_DLLSCE);
-	}
-	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, ctrl);
-
-	/* The interrupt is initialized successfully when @irq is valid */
-	php_slot->irq = irq;
-}
-
-static void pcie_enable_irq(struct pnv_php_slot *php_slot)
-{
-	struct pci_dev *pdev = php_slot->pdev;
-	int irq, ret;
-
-	if (!pdev)
-		return;
-
-	/*
-	 * The MSI/MSIx interrupt might have been occupied by other
-	 * drivers. Don't populate the surprise hotplug capability
-	 * in that case.
-	 */
-	if (pci_dev_msi_enabled(pdev))
-		return;
-
-	ret = pci_enable_device(pdev);
-	if (ret) {
-		SLOT_WARN(php_slot, "Error %d enabling device\n", ret);
-		return;
-	}
-
-	pci_set_master(pdev);
-
-	/* Enable MSIx interrupt */
-	irq = pcie_enable_msix(php_slot);
-	if (irq > 0) {
-		pcie_init_irq(php_slot, irq);
-		return;
-	}
-
-	/*
-	 * Use MSI if MSIx doesn't work. Fail back to legacy INTx
-	 * if MSI doesn't work either
-	 */
-	ret = pci_enable_msi(pdev);
-	if (!ret || pdev->irq) {
-		irq = pdev->irq;
-		pcie_init_irq(php_slot, irq);
-	}
-}
-
 static int pnv_php_register_one(struct device_node *dn)
 {
 	struct pnv_php_slot *php_slot;
-- 
2.54.0


