Return-Path: <linuxppc-dev+bounces-20240-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C989FF8868
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 13:07:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4ghV5wN3z2xld;
	Tue, 28 Apr 2026 23:07:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777381658;
	cv=none; b=kiA8a6S/TaUPjNSqz4CC01Cjd+XpkGClY+ram7yxrnn1elPRGnTHNIVVVFCMUGH3ILdiWzXZojTw2CTrnRnuPZ0kHdowOQtAogHG5bMxmpB1nuE61iAnqUKRFknPGHpZQzZ9q/WERc3L+/Cg7TYYf/6l9TVbBjrtw4UDpSvesAgVh55jvZ/Auk7p7rQcfYUIdM4SYq0ihK0emZV0U8dqHU7sGDB9kORfL4xZQIy1JX3p9AGIvrcGuXjCOiR9BfRVlcs+a7bZd66iLA4lxHA5bV1HDy4jAIYrrvfkI/gzfQ1GG7J22VD0+Arz9jmJWUf5fSfd9A3XqVdxdRD+naxUww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777381658; c=relaxed/relaxed;
	bh=gCPr4yBhBB7M8hYyxwfQYfDGMLYQtxXEbNoae5c28Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RCjmmzJoV8tC3ieAKmfnbTCsD23z1bdsyKb2BokEveqHyZpMJ5MvnyeuhvT9i0DzTkMBJCxvzoODSKwljRCqBWsBhOqKG3YUueQ9Bw7nmYGAYYNbhKoZTwx85PkqUtajfAYk1Xgb6fLB93hi0r3pJBo5IzJ4vaDo8DhyUwS6b2HKMG4RrpvJk+xSQWMuw2LFeiRqLBGxQpNMzwvulTM9O5Es3BE8mKRSWczZheFvJNHjuCsUPOmJd159sMPpJgPtkMlXnxLSpJsJb/sr2xF9ZjLzVasW3bmibSHiAU/kch7SMmrGBagARl5Ds1eQg8RFPRizPxfQ/YuWbXskcCubwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=G/ocJf4z; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=G/ocJf4z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4ghT1w8Nz2xWP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 23:07:36 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S649rX2992108;
	Tue, 28 Apr 2026 13:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=gCPr4yBhBB7M8hYyxwfQYfDGMLYQtxXEbNoae5c28
	Rg=; b=G/ocJf4ziA5T/3LpfPXebLIXEtK/sgre4GzIGPFuJdnzbE4herI51opM8
	l+3g1JXTVbLs6Fk2LtUtCQevM0p8cXrkdEooECNwV7OyIdn6nN8F2WD4F6rEBJRf
	6Tci7uU8Zk4vUxQfiG/rb2MJKn1qUlckDA9IR8ccV+HnbVNqLj1rtw4JgOV9JGlZ
	thftnVL1HuAtVTz0TsJVAsEXenerFBIZNFHCIvuKMyKnMtaW2GI2b0SbIp8N9Hb+
	HOMx5igRvFWS5dqWck4OCpyJhr0KIHdG8v/nhD1lOPcB2WuTq1ECzVA0oMBpP6rz
	ZiZXULreqwikdqfTnZAhJwY1F0ilg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44nnn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 13:07:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SCw4p9032349;
	Tue, 28 Apr 2026 13:07:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamy9hvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 13:07:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SD7JbA29491768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 13:07:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B40420043;
	Tue, 28 Apr 2026 13:07:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C48420040;
	Tue, 28 Apr 2026 13:07:17 +0000 (GMT)
Received: from ltcd48-lp3.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 13:07:17 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com
Cc: christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        nnmlinux@linux.ibm.com, mahesh@linux.ibm.com, vaibhav@linux.ibm.com,
        sbhat@linux.ibm.com
Subject: [PATCH 1/1] powerpc/pseries/pci: quirks: Add pseries TG3 D3hot delay quirk for EEH stability
Date: Tue, 28 Apr 2026 05:35:29 -0400
Message-ID: <20260428093529.7618-1-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
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
X-Proofpoint-ORIG-GUID: JjcOzpQw7GYec8_6uW_jwYi9_NycNbR0
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f0b10c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=aqhxxquPscKkPkbc_e4A:9
X-Proofpoint-GUID: FrrUsR-Y5D1ACdhaXo4TKElw8BYYDCfS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDExOCBTYWx0ZWRfX7OK290+s3wjC
 /SqUA9UQrQBSHlgoA9YPqHao6cr4pApyoMNAVueAIhN4ahzVwQl7/I4KqKNAX3f6FHSMP0KGPm/
 yfljAZc+mF3nqWZKJ+pQa2seuXGJvrzdtDmg18hSUUOvJejhM+9CMJja05rRfL2wBiHxP7vIag5
 /p6LcOKsrZgoo237AXvlR8QuVZawbei4FYPzCkRXvrw3K6MkkrRwY2ayl3Ks4C3POdMweEb8uSU
 cxOlkjaHnMjr91umKBtUNEtm5Y01K+PkJyeVNggGUFI4eNSBSGJpVImzZAE9BeVKFfRh8WRVj/r
 +XgJW/xfpszhSqaP0kCH8GPD1ARnFXMDQy91kmjQBhPR3n+p5D7Vc64NRahtRUvYPDdkRJgE9JI
 vATpHeF+VEryxW8IMX+Vi84pn1HTCZucCxuw2S6q9CI6dNNy+bFZ85EC8gqkqEpK+Y7AGl5CAoC
 c6sw1m/im8sJUCy3+mA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280118

On pseries platforms, binding Broadcom PCIe NIC devices to the vfio-pci
driver frequently triggers an unintended EEH (Extended Error Handling)
isolation event.

This occurs because the device firmware violates PCIe specification
recovery timings when transitioning from the D3hot to D0 power state
during the binding process. The strict pseries PHB catches the
resulting Unsupported Request during the subsequent configuration
space read, assuming a device failure.

Add a pseries-specific PCI fixup quirk for Broadcom devices to
explicitly extend the `d3hot_delay` to 200ms. This forces the PCI
core to sleep long enough for the firmware to safely complete the
D0 transition before attempting config reads, ensuring a clean VFIO
passthrough initialization.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/pci.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 84e4ffe957a8..5f3cf9a7bdd3 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -291,3 +291,24 @@ int pseries_root_bridge_prepare(struct pci_host_bridge *bridge)
 	bus->cur_bus_speed = prop_to_pci_speed(pcie_link_speed_stats[1]);
 	return 0;
 }
+
+/*
+ * Workaround for sluggish PCIe device firmware.
+ *
+ * The device violates the PCIe spec recovery timing when transitioning
+ * from D3hot to D0. On standard architectures this is often ignored, but
+ * the strict PowerPC pseries PHB catches the Unsupported Request during
+ * the subsequent config read and triggers an EEH.
+ *
+ * We inject a longer delay to ensure the device is ready before the PCI
+ * core attempts to access configuration space.
+ */
+static void quirk_pseries_d0_wake_delay(struct pci_dev *dev)
+{
+	dev->d3hot_delay = 200;
+	pci_info(dev, "pseries  Quirk:D3hot->D0 delay %d ms to prevent EEH\n",
+		 dev->d3hot_delay);
+}
+/* Blanket application to ALL Broadcom PCI devices */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
+			PCI_ANY_ID, quirk_pseries_d0_wake_delay);
-- 
2.51.1


