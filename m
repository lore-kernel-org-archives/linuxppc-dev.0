Return-Path: <linuxppc-dev+bounces-26041-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08320C5DF89
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2026 12:34:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRKW524Gwz2yFl;
	Fri, 21 Aug 2026 22:34:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787315665;
	cv=none; b=k1iIA50TK9Uyh3/i8JnI9y5K3u5bGsWTr7xkWBs90NTAUreD2JCyzZfotWcLotX8yN688evqnY2bucyE+j7n507DGx76jQZgWsxE44WvqiIKjnM7w+7SYD0NKfh3m+TvK85MXvu4Tll2dbX0r1o3ioPSjmBsMB2lvra+fk13ygAiFFG4hD6mOGP6EbVrzotWquVhceo9MobeSQTEveA6ZXZzRucd07pqAnXqemA6KENDYm0lgfUwoYI9sZ6Gi1ALX38ntH/obZlI+Hc5Pmi3guoIT8LCWig0rH8Bic8eXEMxhKnoDQA+EmSYiyHQ6oNmGo9N2pDXMT+np+A7vVAFrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787315665; c=relaxed/relaxed;
	bh=mXPpO1YGeM9k4SuCjfksGzRUcbRF1jin4g0NcVPtFbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MhE1q4vdoMmVlLURgaRB0TL4dUgAn/PNlxDmy7IPXY7h7a/O1YAqyvJQy83aVFBTfekHvxHxx4mp8IvFvKRpyBTUcgw84lEHat/+tM3VvjFi8SmAU1oONpQg4lkzynVmkZ/Otry98XrU7+ICqVh3qUu7EaXvqlFaGe65R99wNZjrftjAUAaACdOi/L2QqPd+H9LM/A4PKW6wSIFyC9cw5H49lyoGfsHHzmTa0mPf7lRZx0OESvWnsVCcY6lFrrA7B4nkpTPopu/78BsbgHEZlP+AglyrX4pcaFKrJltmQxyJXBHtVthi5YwWPm+ah/juNCSG+PIxzb2YTpG8ifQXVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kOx+uxLE; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=avinash@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kOx+uxLE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=avinash@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRKW35byVz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2026 22:34:22 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LC1oXY1466727;
	Fri, 21 Aug 2026 12:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=mXPpO1YGeM9k4SuCjfksGzRUcbRF1jin4g0NcVPtF
	bw=; b=kOx+uxLEaWJdMRw1X4iw3qWUyXGIghxJjn6N3S3wgaONK/mVAQUATvFfn
	T/CnK/Stf1KnC2YTbvZI0dK9fzSjN1ZjCbK+on7i+YJ36kXrELA9pN5hjxE9WQBi
	HTRVJomE5m+4ydqAuwbJhIvkdf+R8qCQRbND28mRWRL8BC3m9bwMp+PGQycFQ7He
	ftfC0FVi7dEKUXepBzsZS/WVAQTjRIGiUdRmQuTRT98bP9RQt3H4RMWfziHl/NdC
	EmRes8b5xMwv1CWOAjUshoG3TaF262BzkuOp/k7CbDnnZgJMqJ2hvt9hoQ2/sW2Q
	NX+dtx3JPjkAt11PLrzl795iRgIGw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4h6qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 12:34:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LCQNmX032578;
	Fri, 21 Aug 2026 12:34:09 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhmkyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 12:34:09 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LCY8Wh30671556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 12:34:08 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2798558067;
	Fri, 21 Aug 2026 12:34:08 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 762465805D;
	Fri, 21 Aug 2026 12:34:04 +0000 (GMT)
Received: from li-75d4d1cc-257f-11b2-a85c-f97fadd0f3fb.ibm.com.com (unknown [9.61.86.15])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 12:34:04 +0000 (GMT)
From: Avinash Roy <avinash@linux.ibm.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, bhelgaas@google.com
Cc: npiggin@gmail.com, chleroy@kernel.org, sbhat@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Avinash Roy <avinash.roy1@linux.ibm.com>
Subject: [PATCH v2] PCI: quirks: Add warm reset quirk for IBM Spyre accelerator
Date: Fri, 21 Aug 2026 18:04:01 +0530
Message-ID: <20260821123401.1375297-1-avinash@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
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
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a8845c2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TViotR2JPqG71lRTnZ4A:9
X-Proofpoint-ORIG-GUID: 8-Igf-cscOQ7Mqv9a2oQBrizT_PvQo9c
X-Proofpoint-GUID: NkqGL5Wu2kcVnl4tNioL_NjS1rGpr6PU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5NiBTYWx0ZWRfXyTUcspArcxBB
 NYnK1H4Rd4vwMuX9RndzyFS6xF0D9AtL+3KHQGu+yW+O0uhxkB/LbHtgNG0xfLuL7pXKs7Xsx3Z
 0Wjfik6ciglgqFi4pfu+hl39YiT6Rd4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5NiBTYWx0ZWRfXzSRn/e7ezT56
 c/r8GNnPMDdIl5sFjRJUFv2KQOTtq2x4OxHr8W8iwdRoH5G51eKLFRTwo8fQJwCbfI/JD+5Bqr7
 wmBnrDSJTR5QmDRBqwNJdBpsdqIS7Tmbn3SO09dbzG5Zr4Xj7vQvziHfhGaBojcfsR0VV3tRIV7
 2R9DG1iIQZ1lr6t41AlD+BG8OBQwniuB6P/WVlMzGkrjlveTDIHxVzlhN3Ng5nUeW8FdwvUbSAd
 StPyPN4oqf8yCgMiqvSxljA3LZBHgWxOfPl7ixhLPmcOSOCA11OYsJ92N4Z46b75IiskdaTeCzx
 HIZl6vWuPiSvHjUu9XNznERFNCjkN7gl2c/p/kJMgkqkrohj/+1PHQZ2o8ZzPqVJ3FxRHqnx0Wd
 SKSIa7ygxu6fKOFDmCjY3ZFplupd3cm8vsR5UfYfvfmqT59gcl4xj1Z7xyq+VbtE65xq433rCHo
 G1K42VbuokocJzhrGeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210096

From: Shivaprasad G Bhat <sbhat@linux.ibm.com>

The IBM Spyre accelerator (PCI ID 1014:06a7) requires a dedicated warm
reset method for reliable EEH recovery on pSeries/ppc64 platforms.

FLR alone is insufficient because it does not re-initialize firmware
state machine for the current version of the card. The existing API
pci_set_pcie_reset_state() is used to drive the platform-level
PERST# using the EEH interfaces by adding a device specific quirk.

The reset function is placed in arch/powerpc/platforms/pseries/pci.c
where the EEH infrastructure is already present, declared in
pseries.h, and registered in the generic pci_dev_reset_methods[] table
in drivers/pci/quirks.c under a CONFIG_PPC_PSERIES guard.

This reset method is only registered when CONFIG_PPC_PSERIES is enabled,
so it is not available on other platforms.

Reset sequence:
  - Assert PERST# via pcie_warm_reset, hold 250 ms
  - Deassert PERST# via pcie_deassert_reset
  - Wait 250 ms for PCIe link retrain 	

Signed-off-by: Avinash Roy <avinash.roy1@linux.ibm.com>
Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>

---
Changelog
v1: https://lore.kernel.org/linux-pci/20260805125100.1-1-avinash.roy1@linux.ibm.com/

   Reworded the commit message to highlight the warm reset requirement being
   a need of the current card and not a platform deficiency.

diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 84e4ffe957a8..7aa58d57208f 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/string.h>
+#include <linux/delay.h>
 
 #include <asm/eeh.h>
 #include <asm/pci-bridge.h>
@@ -236,6 +237,41 @@ static void fixup_winbond_82c105(struct pci_dev* dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,
 			 fixup_winbond_82c105);
 
+/*
+ * Reset Spyre adapter using pci_set_pcie_reset_state()
+ * This is specifically for PPC platforms where EEH (Enhanced Error Handling)
+ * requires this reset method for proper device recovery.
+ */
+int reset_spyre(struct pci_dev *dev, bool probe)
+{
+	int ret;
+
+	if (probe)
+		return 0;
+
+	/* Assert warm reset */
+	ret = pci_set_pcie_reset_state(dev, pcie_warm_reset);
+	if (ret) {
+		pci_err(dev, "Failed to assert reset: %d\n", ret);
+		return ret;
+	}
+
+	/* Wait for reset to take effect */
+	msleep(250);
+
+	/* Deassert reset */
+	ret = pci_set_pcie_reset_state(dev, pcie_deassert_reset);
+	if (ret) {
+		pci_err(dev, "Failed to deassert reset: %d\n", ret);
+		return ret;
+	}
+
+	/* Wait for device to recover */
+	msleep(250);
+
+	return 0;
+}
+
 static enum pci_bus_speed prop_to_pci_speed(u32 prop)
 {
 	switch (prop) {
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 3968a6970fa8..79c194aeb3c6 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -92,6 +92,10 @@ extern struct pci_controller_ops pseries_pci_controller_ops;
 int pseries_msi_allocate_domains(struct pci_controller *phb);
 void pseries_msi_free_domains(struct pci_controller *phb);
 
+/* PCI device reset method for Spyre adapter */
+struct pci_dev;
+int reset_spyre(struct pci_dev *dev, bool probe);
+
 extern int CMO_PrPSP;
 extern int CMO_SecPSP;
 extern unsigned long CMO_PageSize;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f7846f..1b8ab5d9764b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4237,6 +4237,11 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
 	return 0;
 }
 
+#ifdef CONFIG_PPC_PSERIES
+/* Defined in arch/powerpc/platforms/pseries/pci.c */
+int reset_spyre(struct pci_dev *dev, bool probe);
+#endif
+
 static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
 		 reset_intel_82599_sfp_virtfn },
@@ -4252,6 +4257,10 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 		reset_chelsio_generic_dev },
 	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
 		reset_hinic_vf_dev },
+#ifdef CONFIG_PPC_PSERIES
+	{ PCI_VENDOR_ID_IBM, 0x06a7,
+		reset_spyre},
+#endif
 	{ 0 }
 };

