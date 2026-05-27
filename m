Return-Path: <linuxppc-dev+bounces-21606-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D036CD5BD0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 18:09:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQd0q4yXxz2ySJ;
	Thu, 28 May 2026 04:08:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779905339;
	cv=none; b=BLub8wSK6pQqpEdjNkcZkPfJJOxxVLP6OP8vYOb7QE7PJueXWikMK9ZG9wllQl9xU6bXVzQnf9kb76R2WUMWC3ldVVmwOJ1jJ2woSxrbyhCcSlNIzcF7sR51wyxABHYA6zM/0JuqxXlj+1pvaKU4bNSL4tqL904mr5erB9coy8dra1Le9s8YevqPpLbynWyqpeLY9yJbjxC+1XKvB4EzQ+1gz4HokQ4fw73joiWCU8T7Vjt5I7XubbYhe0RhRUZuitg2N0tOl/KAaaQNe5m0z9GmBhRpfl4OI9Z6Kx+/GxXT1N4qbEAhslOoXAsg9k1gIKVONt1f+5Cq5RLhi4IOVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779905339; c=relaxed/relaxed;
	bh=TrOA5GJrGr69PnMdDgtk8L85vkg2hNUjDeGZFpXPS04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nY3dc/BUAyX2scRz8PHo8WCVm22Wn3dG1vugLN8aesjJUH3t6SuBp9bABC30dI/nWHPJQrPt9EF8nG5P67GJR4sxGn6rT1FAdtsZAjGBeb3FR9Qtrt9eZH+KXeH4yl3d/pHfT4RH4z4u+r322nl5961VX8uyTIBNJMHoT+5nN+jOMHjvSoIc5DxaUibKYpPP8T/VMQqGxPovTuYe39A3M0SuqKWPr1VPB6a82y0gX7qwWYAhXssINYiLwZ/3ypQqFR4NtBwCIljsrRN27rHXvdevb3928kXpgIYp7vL8vd055o1gbqK0s1kd9zidw36cGwPtlI7VinI9Nd1Y7psnPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hcMNQfAH; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adityag@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hcMNQfAH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adityag@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQd0q0FRDz2ySC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 04:08:58 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RCr7HX346650;
	Wed, 27 May 2026 18:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TrOA5GJrGr69PnMdD
	gtk8L85vkg2hNUjDeGZFpXPS04=; b=hcMNQfAHbkqYYoWDgdjGsN8/v3B8Fz7/C
	iqc4qsBrfsEWCj0QuW1F/njY401kN8jyHvJ9viCM7oNLBReAiHBfG1wd9CU3BtXl
	+ZTMos0/X8RvYklZrOLY8m2lUVTg77lPW9Q5YL1Ayru618n2Hwrvc4DyNpHOj49q
	pEfk/3dKIy6F9ZuQIo2VSZhqdByiSWtuM3MaTR+TDjcHgrymdEG6e1EfjousiWQZ
	MbdtmB0HOhsO020JCnngO47oDBmQLrCYJsAoSVssppIdIRZslU5BRImkzwNvEUlv
	nAdLjol5RmRaWcJnDTs40Y+pRwe3xr43QGTabOjExXFbHBzF8/3vA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nutwhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 18:08:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64RHs52f022906;
	Wed, 27 May 2026 18:08:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbvasb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 18:08:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64RI8kmu45482318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 18:08:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 541DD20043;
	Wed, 27 May 2026 18:08:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E536320040;
	Wed, 27 May 2026 18:08:41 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.124.220.41])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 18:08:41 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Anastasio <sanastasio@raptorengineering.com>
Cc: sashiko-bot@kernel.org, linux-pci@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        stable@vger.kernel.org
Subject: [PATCH v2 1/3] ppc/pnv: Add null checks for OpenCapi PHBs
Date: Wed, 27 May 2026 23:38:14 +0530
Message-ID: <20260527180816.2749186-2-adityag@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE4MiBTYWx0ZWRfX8OeyhjEM6epN
 K9LbzxOdJPbJYetzp5DubvcWmOQiksAPUfptT4FPSQulUiqYEdEw7ozZR4dnT3fE7qd4bCMdK+6
 qFMgWgIv1VMdf4VpPA00zP/VhR7Yj26SnXLiR6D92lUL8c5HNbzj3hsvBc2hDtidqvLmZpoCljr
 Q/AIiMG8LYH2exgW6NNh0PXRDpmcO/oaiTw8VmwtNkpThcosBKtnjGcbY24Pk0A/5Rua6krvjnw
 lJjywddcC3zGl6SV64qzR5lWgr9NBGSV5tW4WxI/Gd7Lpl+kBVtCXCnc4ORNmBe0oAh91u7mXP8
 At7vCSSg226ZIfcCMvNi/+fQmXfG7bJt0uZRtnGZNO9MOxjNNXaPei6pgTwWS0tlDv/GxrP+kDW
 ADQ4aqr/Uav4Cf7hxDdGxS4XFcGuIWkD3MRScAu15KRrgX0hsRuKGhiqHE2sckow4L0lxkAYmnH
 Bs3f0VbXXCDC042yfZg==
X-Authority-Analysis: v=2.4 cv=UtJT8ewB c=1 sm=1 tr=0 ts=6a173333 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=2CTBcJULQSvMIThFTPkA:9
X-Proofpoint-ORIG-GUID: 7JLdXtoD7sCI2m37uW2x3VWRzRfLXjXA
X-Proofpoint-GUID: OHo431b-WlO5WFm2Lig5AZRtFZWIy2rs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1011 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270182

For opencapi phb direct slots, the .pdev for php_slots will be NULL

Various sections of the code in pnv_php can do a null dereference and
crash the kernel.

Originally, the issue was hit during boot:

    [    1.568588] PowerPC PowerNV PCI Hotplug Driver version: 0.1
    [    1.569722] BUG: Kernel NULL pointer dereference at 0x00000074
    [    1.569811] Faulting instruction address: 0xc000000000b75fd0
    [    1.569890] Oops: Kernel access of bad area, sig: 11 [#1]
    [    1.569963] LE PAGE_SIZE=64K MMU=Hash  SMP NR_CPUS=2048 NUMA PowerNV
    ...
    [    1.571492] NIP [c000000000b75fd0] pnv_php_get_adapter_state+0x60/0x154
    [    1.571604] LR [c000000000b75fbc] pnv_php_get_adapter_state+0x4c/0x154
    [    1.571690] Call Trace:
    [    1.571725] [c000c0000688f990] [c000000000b75fbc] pnv_php_get_adapter_state+0x4c/0x154 (unreliable)
    [    1.571783] [c000c0000688fa20] [c000000000b78bd0] pnv_php_enable+0x94/0x378
    [    1.571951] [c000c0000688fac0] [c000000000b7912c] pnv_php_register_one.isra.0+0x11c/0x1e0

This occurs for hotplug slots on root buses where bus->self == NULL,
such as OpenCAPI PHB direct slots. An added debug print (not part of
this patch) confirmed it was opencapi:

    [    1.617227] pnv_php: slot 'OPENCAPI-0009' has NULL pdev (bus 0009:00, parent=NO (root bus))
    [    1.617308] pnv_php: slot 'OPENCAPI-0009' dn->full_name='pciex@603a000000000', compatible='ibm,power10-pau-opencapi-pciex'

This only required null check in 'pnv_php_get_adapter_state', which
caused the kernel to boot.

Even with 'pnv_php_get_adapter_state' null check, there are more
possible null dereferences pointed by sashiko, including cases where
userspace crashes the kernel, such as:

    $ cat /sys/bus/pci/slots/*/attention
    ...
    [  557.036295] Kernel attempted to read user page (6e) - exploit attempt? (uid: 0)
    [  557.036354] BUG: Kernel NULL pointer dereference on read at 0x0000006e
    [  557.036383] Faulting instruction address: 0xc000000000a83334
    [  557.036413] Oops: Kernel access of bad area, sig: 11 [#1]
    [  557.036449] LE PAGE_SIZE=64K MMU=Hash  SMP NR_CPUS=2048 NUMA PowerNV
    ...
    [  557.037749] [c000000046707a20] [c000000046707b90] 0xc000000046707b90 (unreliable)
    [  557.037795] [c000000046707a70] [0000000000000001] 0x1
    [  557.037850] [c000000046707ab0] [c000000000acb00c] attention_read_file+0x54/0xa8
    [  557.037910] [c000000046707b30] [c000000000abfbfc] pci_slot_attr_show+0x3c/0x58
    [  557.037977] [c000000046707b50] [c0000000008181ec] sysfs_kf_seq_show+0xd4/0x204
    [  557.038022] [c000000046707be0] [c000000000815004] kernfs_seq_show+0x44/0x58

Add null checks to prevent the null dereferences.

Cc: stable@vger.kernel.org
Fixes: 80f9fc236279 ("PCI: pnv_php: Work around switches with broken presence detection")
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 drivers/pci/hotplug/pnv_php.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index ff92a5c301b8..d0f5e8ad1f71 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -47,6 +47,9 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
 	struct pci_dev *pdev = php_slot->pdev;
 	u16 ctrl;
 
+	if (!pdev)
+		return;
+
 	if (php_slot->irq > 0) {
 		pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &ctrl);
 		ctrl &= ~(PCI_EXP_SLTCTL_HPIE |
@@ -414,7 +417,8 @@ static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
 	 */
 	ret = pnv_pci_get_presence_state(php_slot->id, &presence);
 	if (ret >= 0) {
-		if (pci_pcie_type(php_slot->pdev) == PCI_EXP_TYPE_DOWNSTREAM &&
+		if (php_slot->pdev &&
+			pci_pcie_type(php_slot->pdev) == PCI_EXP_TYPE_DOWNSTREAM &&
 			presence == OPAL_PCI_SLOT_EMPTY) {
 			/*
 			 * Similar to pciehp_hpc, check whether the Link Active
@@ -442,6 +446,11 @@ static int pnv_php_get_raw_indicator_status(struct hotplug_slot *slot, u8 *state
 	struct pci_dev *bridge = php_slot->pdev;
 	u16 status;
 
+	if (!bridge) {
+		*state = 0;
+		return 0;
+	}
+
 	pcie_capability_read_word(bridge, PCI_EXP_SLTCTL, &status);
 	*state = (status & (PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC)) >> 6;
 	return 0;
@@ -514,11 +523,13 @@ static int pnv_php_activate_slot(struct pnv_php_slot *php_slot,
 			 * fence / freeze.
 			 */
 			SLOT_WARN(php_slot, "Try %d...\n", i + 1);
-			pci_set_pcie_reset_state(php_slot->pdev,
-						 pcie_warm_reset);
-			msleep(250);
-			pci_set_pcie_reset_state(php_slot->pdev,
-						 pcie_deassert_reset);
+			if (php_slot->pdev) {
+				pci_set_pcie_reset_state(php_slot->pdev,
+							 pcie_warm_reset);
+				msleep(250);
+				pci_set_pcie_reset_state(php_slot->pdev,
+							 pcie_deassert_reset);
+			}
 
 			ret = pnv_php_set_slot_power_state(
 				slot, OPAL_PCI_SLOT_POWER_ON);
@@ -911,6 +922,9 @@ pnv_php_detect_clear_suprise_removal_freeze(struct pnv_php_slot *php_slot)
 	struct eeh_pe *pe;
 	int i, rc;
 
+	if (!pdev)
+		return;
+
 	/*
 	 * When a device is surprise removed from a downstream bridge slot,
 	 * the upstream bridge port can still end up frozen due to related EEH
@@ -1093,6 +1107,9 @@ static void pnv_php_enable_irq(struct pnv_php_slot *php_slot)
 	struct pci_dev *pdev = php_slot->pdev;
 	int irq, ret;
 
+	if (!pdev)
+		return;
+
 	/*
 	 * The MSI/MSIx interrupt might have been occupied by other
 	 * drivers. Don't populate the surprise hotplug capability
-- 
2.54.0


