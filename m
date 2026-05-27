Return-Path: <linuxppc-dev+bounces-21607-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A15CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 18:09:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQd0w1mqpz2yWK;
	Thu, 28 May 2026 04:09:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779905344;
	cv=none; b=fuaXIbQ+eeoZnJH0anhcRJDC6nHsckWxu905BZsGX6VYTXnEXuX6pkGsu/1Mg3NAMJZNvxWN1q5cgpNQ0jD6S5IgLB/qMZ9puMlGlsmGmNazEpJikQ9+SWTtrvlyGbv4MtzY6aVdzxe+7GX03PoKF33DUHCVCDUeg2VLTG9Pu11+JpDdsKUv2ZrIaafx/AOLyzgP4MwwaC6IxE6HjbiPWBXAtO4MllzQEyNigTAPcfDoM/y3eSauiVpZOqiESOEQHvEx+Ly9kKr7rKd3RywNvi1CmXO5rThWvzt4PpR4KAs32pbgbN7j8C00hkZBkDu98Ii1qPiKCZrblK/sm38dQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779905344; c=relaxed/relaxed;
	bh=rbrwwtxlGutlngBQoUm34N+K3fgrN4lZbrEiXJPoKHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiLm6Fe2npMZbh0CGboynqSOjh2xcbBPpjPiFKd7EvldeMYz3erjRya67KSKvzxJMUxqs/CL9D7SMn/5DMoSCjOEdPbl3xpn8PmgO6WnujpmXBpPx/elOflJ4x/L4lypVM6KvbGKkvwHqoMD2FeSFqHT/Y5RIKF2ikW1Qc2ZxQVj0e72QAQr6bDU+f1RAvGkt44AIIXAFfcSsLCDEoExOjAxegcZOcA+hS+sDjYqm9r3+j8nYTtLXeLMCouGvezQS9qDqWJEmoS9ruerz4uxSgw4LDZjiXuNKqqF+Bs3t8unzBUZQTgaIwrUxS1PCnmgUmXN9LwdYaDjR6oyxNc85Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KHqGgOTG; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adityag@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KHqGgOTG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adityag@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQd0v1k3tz2ySC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 04:09:03 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RCMxM93811477;
	Wed, 27 May 2026 18:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rbrwwtxlGutlngBQo
	Um34N+K3fgrN4lZbrEiXJPoKHY=; b=KHqGgOTGhM7E62zxCIFlQKyPqQVJLH3wm
	axnqxTkN+VIUnTRQMU8AMFlPgf5Ke41hHRsSrUmW28fU+AiFbC459XoJNNM8m0Ol
	4DjvDrni5+80rqf6murfq1/uyUFml6V8//5TJ1fUkMNEu+2PE/eGqZVQJdDBKthj
	7kqggaBg/fsdqVHZ70sJ+OK3ETksszl99KfuA+QJeCNeQnc5RZRfTafwfCJIVunQ
	Af/UkLxiD8StReFyxp3289iy/TU0yg8Jk+WVoeznHMpPXlHSUfJeaZnM6ns0HUVG
	rQzzjBpT+Cp1jrbY8cBbpabGqt/yOuHHCbDr7iKLoxPZugq0L6b1w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4qc2sky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 18:08:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64RHs4mk023480;
	Wed, 27 May 2026 18:08:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb4awj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 18:08:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64RI8oDb45220102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 18:08:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF64B20043;
	Wed, 27 May 2026 18:08:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF3DB20040;
	Wed, 27 May 2026 18:08:46 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.124.220.41])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 18:08:46 +0000 (GMT)
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
Subject: [PATCH v2 2/3] ppc/pnv: Refactor PNV PCI hotplug driver
Date: Wed, 27 May 2026 23:38:15 +0530
Message-ID: <20260527180816.2749186-3-adityag@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE4MiBTYWx0ZWRfX1ft8FJ5aDfc0
 j8UoJdMGPlm8Zu3g/9jdNyGJIa6u952C8CZmq3WxGRm1JsBTSBY4XtKRqLKEeO5XAM2xOg66UKl
 ZbhgLHE+FbDeWMNieo2vQuYSXX0ErNTFyFV3ksHeNIkFysSILz1K+KZ3bC+WnWEC2xNKcfooAhr
 i7nu6og+g7LyCnyCXf3rIvXt7sXeC2XhB03pj/wxwoyUBsixhWC/npMOhTyjy9q0E6BCigNDnI/
 ZPfyCY1wYSziy6rbQT7dXyEgEWFkwueLgBpJ9VdIkw8ItwWsM09vhWlQHqb5WMisEr1Lfyd5WMM
 FlWKoZP7kheGv2+Ke38jj8LpS+DPL0KkY2nGjoRS7SB8VLr5bh8agruq5Q/cJeGlGKfz/niQHlI
 VNQ/xMcnDlQus/7thk50mxAfWw6I0ZwfKNEb8h+nZD9++qWmvbab+NZHnq5U4oJ7DKuhbwsvMix
 7cx3r8PsNjKvLsDtSOQ==
X-Authority-Analysis: v=2.4 cv=KItqylFo c=1 sm=1 tr=0 ts=6a173337 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=sFtuphBWuyu6uFSNHX4A:9
X-Proofpoint-ORIG-GUID: dspj0QFFytavG6dFvfuLZOmaZBLDIRkK
X-Proofpoint-GUID: oU26Fy5jBHxQ_dTg_eNGo92AdHQEvOTg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270182

Currently the pnv_php driver handles both PCIe and OpenCAPI slots.

The slots has many common functionality, but many operations are pcie
specific, and assume the slot having a parent device, which isn't the
case with opencapi slots

This requires handling the case of parent device being NULL, at many
places, which can be hard to maintain and add code to.

Instead, have PCIe/OpenCAPI operations as .backend_ops in pnv_php_slot,
so that PCIe code is cleanly separated.
With this, future patches can just edit the PCIe/OpenCAPI specific ops,
instead of editing the common code.

No functional change is intended other than reset_slot for OpenCAPI
slots returning -ENODEV when not probing.

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 arch/powerpc/include/asm/pnv-pci.h |  16 +++
 drivers/pci/hotplug/pnv_php.c      | 160 +++++++++++++++++++----------
 2 files changed, 123 insertions(+), 53 deletions(-)

diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index 7e9a479951a3..f1020f1e61cd 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -27,6 +27,9 @@ extern int pnv_pci_set_power_state(uint64_t id, uint8_t state,
 int64_t pnv_opal_pci_msi_eoi(struct irq_data *d);
 bool is_pnv_opal_msi(struct irq_chip *chip);
 
+/* To be set for hotplug operations for PCIe/OpenCAPI */
+struct pnv_php_backend_ops;
+
 struct pnv_php_slot {
 	struct hotplug_slot		slot;
 	uint64_t			id;
@@ -50,10 +53,23 @@ struct pnv_php_slot {
 	void				*fdt;
 	void				*dt;
 	struct of_changeset		ocs;
+	const struct pnv_php_backend_ops *backend_ops;
 	struct pnv_php_slot		*parent;
 	struct list_head		children;
 	struct list_head		link;
 };
+
+struct pnv_php_backend_ops {
+	void (*enable_irq)(struct pnv_php_slot *slot);
+	void (*disable_irq)(struct pnv_php_slot *slot, bool disable_device, bool disable_msi);
+	void (*fixup_presence_state)(struct pnv_php_slot *slot, u8 *presence);
+	void  (*get_attention_state)(struct pnv_php_slot *slot, u8 *state);
+	void  (*set_attention_state)(struct pnv_php_slot *slot, u8 state);
+	void (*fundamental_reset)(struct pnv_php_slot *slot);
+	void (*detect_surprise_removal)(struct pnv_php_slot *slot);
+	int  (*reset_slot)(struct pnv_php_slot *slot, bool probe);
+};
+
 extern struct pnv_php_slot *pnv_php_find_slot(struct device_node *dn);
 extern int pnv_php_set_slot_power_state(struct hotplug_slot *slot,
 					uint8_t state);
diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index d0f5e8ad1f71..997412eea486 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -39,17 +39,53 @@ static void pnv_php_register(struct device_node *dn);
 static void pnv_php_unregister_one(struct device_node *dn);
 static void pnv_php_unregister(struct device_node *dn);
 
-static void pnv_php_enable_irq(struct pnv_php_slot *php_slot);
+static void pcie_enable_irq(struct pnv_php_slot *php_slot);
+static int pcie_check_link_active(struct pci_dev *pdev);
+static void pcie_detect_surprise_removal(struct pnv_php_slot *php_slot);
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
+static void pnv_php_enable_irq(struct pnv_php_slot *php_slot)
+{
+	if (php_slot->backend_ops->enable_irq)
+		php_slot->backend_ops->enable_irq(php_slot);
+}
 
 static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
 				bool disable_device, bool disable_msi)
+{
+	if (php_slot->backend_ops->disable_irq)
+		php_slot->backend_ops->disable_irq(php_slot, disable_device,
+				disable_msi);
+}
+
+static void pcie_disable_irq(struct pnv_php_slot *php_slot,
+				bool disable_device, bool disable_msi)
 {
 	struct pci_dev *pdev = php_slot->pdev;
 	u16 ctrl;
 
-	if (!pdev)
-		return;
-
 	if (php_slot->irq > 0) {
 		pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &ctrl);
 		ctrl &= ~(PCI_EXP_SLTCTL_HPIE |
@@ -417,19 +453,8 @@ static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
 	 */
 	ret = pnv_pci_get_presence_state(php_slot->id, &presence);
 	if (ret >= 0) {
-		if (php_slot->pdev &&
-			pci_pcie_type(php_slot->pdev) == PCI_EXP_TYPE_DOWNSTREAM &&
-			presence == OPAL_PCI_SLOT_EMPTY) {
-			/*
-			 * Similar to pciehp_hpc, check whether the Link Active
-			 * bit is set to account for broken downstream bridges
-			 * that don't properly assert Presence Detect State, as
-			 * was observed on the Microsemi Switchtec PM8533 PFX
-			 * [11f8:8533].
-			 */
-			if (pcie_check_link_active(php_slot->pdev) > 0)
-				presence = OPAL_PCI_SLOT_PRESENT;
-		}
+		if (php_slot->backend_ops->fixup_presence_state)
+			php_slot->backend_ops->fixup_presence_state(php_slot, &presence);
 
 		*state = presence;
 		ret = 0;
@@ -440,28 +465,24 @@ static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
 	return ret;
 }
 
-static int pnv_php_get_raw_indicator_status(struct hotplug_slot *slot, u8 *state)
+static void pcie_get_attention_state(struct pnv_php_slot *php_slot, u8 *state)
 {
-	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
 	struct pci_dev *bridge = php_slot->pdev;
 	u16 status;
 
-	if (!bridge) {
-		*state = 0;
-		return 0;
-	}
-
 	pcie_capability_read_word(bridge, PCI_EXP_SLTCTL, &status);
 	*state = (status & (PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC)) >> 6;
-	return 0;
 }
 
-
 static int pnv_php_get_attention_state(struct hotplug_slot *slot, u8 *state)
 {
 	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
 
-	pnv_php_get_raw_indicator_status(slot, &php_slot->attention_state);
+	if (php_slot->backend_ops->get_attention_state)
+		php_slot->backend_ops->get_attention_state(php_slot, &php_slot->attention_state);
+	else
+		php_slot->attention_state = 0;
+
 	*state = php_slot->attention_state;
 	return 0;
 }
@@ -469,13 +490,19 @@ static int pnv_php_get_attention_state(struct hotplug_slot *slot, u8 *state)
 static int pnv_php_set_attention_state(struct hotplug_slot *slot, u8 state)
 {
 	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
+
+	if (php_slot->backend_ops->set_attention_state)
+		php_slot->backend_ops->set_attention_state(php_slot, state);
+
+	return 0;
+}
+
+static void pcie_set_attention_state(struct pnv_php_slot *php_slot, u8 state)
+{
 	struct pci_dev *bridge = php_slot->pdev;
 	u16 new, mask;
 
 	php_slot->attention_state = state;
-	if (!bridge)
-		return 0;
-
 	mask = PCI_EXP_SLTCTL_AIC;
 
 	if (state)
@@ -484,8 +511,6 @@ static int pnv_php_set_attention_state(struct hotplug_slot *slot, u8 state)
 		new = PCI_EXP_SLTCTL_ATTN_IND_OFF;
 
 	pcie_capability_clear_and_set_word(bridge, PCI_EXP_SLTCTL, mask, new);
-
-	return 0;
 }
 
 static int pnv_php_activate_slot(struct pnv_php_slot *php_slot,
@@ -523,13 +548,8 @@ static int pnv_php_activate_slot(struct pnv_php_slot *php_slot,
 			 * fence / freeze.
 			 */
 			SLOT_WARN(php_slot, "Try %d...\n", i + 1);
-			if (php_slot->pdev) {
-				pci_set_pcie_reset_state(php_slot->pdev,
-							 pcie_warm_reset);
-				msleep(250);
-				pci_set_pcie_reset_state(php_slot->pdev,
-							 pcie_deassert_reset);
-			}
+			if (php_slot->backend_ops->fundamental_reset)
+				php_slot->backend_ops->fundamental_reset(php_slot);
 
 			ret = pnv_php_set_slot_power_state(
 				slot, OPAL_PCI_SLOT_POWER_ON);
@@ -633,16 +653,18 @@ static int pnv_php_enable(struct pnv_php_slot *php_slot, bool rescan)
 static int pnv_php_reset_slot(struct hotplug_slot *slot, bool probe)
 {
 	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
+	if (php_slot->backend_ops->reset_slot)
+		return php_slot->backend_ops->reset_slot(php_slot, probe);
+	return probe ? 0 : -ENODEV;
+}
+
+static int pcie_reset_slot(struct pnv_php_slot *php_slot, bool probe)
+{
 	struct pci_dev *bridge = php_slot->pdev;
 	uint16_t sts;
 
-	/*
-	 * The CAPI folks want pnv_php to drive OpenCAPI slots
-	 * which don't have a bridge. Only claim to support
-	 * reset_slot() if we have a bridge device (for now...)
-	 */
 	if (probe)
-		return !bridge;
+		return 0;
 
 	/* mask our interrupt while resetting the bridge */
 	if (php_slot->irq > 0)
@@ -778,6 +800,26 @@ static void pnv_php_release(struct pnv_php_slot *php_slot)
 	pnv_php_put_slot(php_slot->parent);
 }
 
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
 static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
 {
 	struct pnv_php_slot *php_slot;
@@ -830,6 +872,12 @@ static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
 	php_slot->power_state_check     = false;
 	php_slot->slot.ops              = &php_slot_ops;
 
+	/* OpenCAPI slots don't have a parent bridge */
+	if (php_slot->pdev)
+		php_slot->backend_ops = &pnv_php_pcie_ops;
+	else
+		php_slot->backend_ops = &pnv_php_opencapi_ops;
+
 	INIT_LIST_HEAD(&php_slot->children);
 	INIT_LIST_HEAD(&php_slot->link);
 
@@ -886,7 +934,7 @@ static int pnv_php_register_slot(struct pnv_php_slot *php_slot)
 	return 0;
 }
 
-static int pnv_php_enable_msix(struct pnv_php_slot *php_slot)
+static int pcie_enable_msix(struct pnv_php_slot *php_slot)
 {
 	struct pci_dev *pdev = php_slot->pdev;
 	struct msix_entry entry;
@@ -915,7 +963,13 @@ static int pnv_php_enable_msix(struct pnv_php_slot *php_slot)
 }
 
 static void
-pnv_php_detect_clear_suprise_removal_freeze(struct pnv_php_slot *php_slot)
+pnv_php_detect_clear_surprise_removal_freeze(struct pnv_php_slot *php_slot)
+{
+	if (php_slot->backend_ops->detect_surprise_removal)
+		php_slot->backend_ops->detect_surprise_removal(php_slot);
+}
+
+static void pcie_detect_surprise_removal(struct pnv_php_slot *php_slot)
 {
 	struct pci_dev *pdev = php_slot->pdev;
 	struct eeh_dev *edev;
@@ -972,7 +1026,7 @@ static void pnv_php_event_handler(struct work_struct *work)
 		pnv_php_enable_slot(&php_slot->slot);
 	} else {
 		pnv_php_disable_slot(&php_slot->slot);
-		pnv_php_detect_clear_suprise_removal_freeze(php_slot);
+		pnv_php_detect_clear_surprise_removal_freeze(php_slot);
 	}
 
 	kfree(event);
@@ -1055,7 +1109,7 @@ static irqreturn_t pnv_php_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void pnv_php_init_irq(struct pnv_php_slot *php_slot, int irq)
+static void pcie_init_irq(struct pnv_php_slot *php_slot, int irq)
 {
 	struct pci_dev *pdev = php_slot->pdev;
 	u32 broken_pdc = 0;
@@ -1102,7 +1156,7 @@ static void pnv_php_init_irq(struct pnv_php_slot *php_slot, int irq)
 	php_slot->irq = irq;
 }
 
-static void pnv_php_enable_irq(struct pnv_php_slot *php_slot)
+static void pcie_enable_irq(struct pnv_php_slot *php_slot)
 {
 	struct pci_dev *pdev = php_slot->pdev;
 	int irq, ret;
@@ -1127,9 +1181,9 @@ static void pnv_php_enable_irq(struct pnv_php_slot *php_slot)
 	pci_set_master(pdev);
 
 	/* Enable MSIx interrupt */
-	irq = pnv_php_enable_msix(php_slot);
+	irq = pcie_enable_msix(php_slot);
 	if (irq > 0) {
-		pnv_php_init_irq(php_slot, irq);
+		pcie_init_irq(php_slot, irq);
 		return;
 	}
 
@@ -1140,7 +1194,7 @@ static void pnv_php_enable_irq(struct pnv_php_slot *php_slot)
 	ret = pci_enable_msi(pdev);
 	if (!ret || pdev->irq) {
 		irq = pdev->irq;
-		pnv_php_init_irq(php_slot, irq);
+		pcie_init_irq(php_slot, irq);
 	}
 }
 
-- 
2.54.0


