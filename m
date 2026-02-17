Return-Path: <linuxppc-dev+bounces-16910-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827EAE9A020
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Feb 2026 17:46:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fFnBJ58Gjz2xm3;
	Wed, 18 Feb 2026 04:46:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771350376;
	cv=none; b=X3/3EzVk9IAyDJx6yZ4EnXQKakKXzdiryTjkK2CDY2lj325RIhSWMS8sBTgr5/G19B5F7u3tBBYpVvRAYq7YVmjpu0GF9LAqF5dHivhxBDjuDEAqV22fVH6vHRHIHWZ8Et/i0YZvsrZpEaFfOqjhO/GkxfVHrGr9nYBVDcJvO8QFftNt4jfSavj47Q5Xu6jv4Ghn5hpxJzkeaq8wPLhNHQcGtA4X7K4nR6sl0/+dGPpGHkne/MbB486hsFLF2dd8JLlp+JRYUlprhUSHk/a8xJGpcDSUXHia3BNre3kAdD2WjIPGs/Lw4MSdzbk8lSU8c+Yse6/ZJzRZVIO2duorkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771350376; c=relaxed/relaxed;
	bh=3G0u7SK0ibdhCr4vMdf4WTAuV9tpPqMRjkiFzuavqTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lj/IzAQzrpMoHSqeOzeWOuu/ipCRQiyyjzEFQIy5WuiSzh6WywjLAFpL4WrHbgi3r+I/a4a+VvRhuAMbmGdWujt7i1oY21cOjmmRvXa+VKZeVUR7GWI/PkUn76Q3qQQjYQTkmjZMUbciahP/GLIJGAFB9aKmhN9rFYUCdEW5456Q64t7TNg44UTbVmtK5a8p7rvN6OKNQhuQ4fJTN7asuceouOU5NTQuox+iksx3dY7GmLnEltnNqpGILZpnyPjpadqB5yNTSawpUxI/m8pW7dDccF1kYnXUtU1UucJI4ZWmbfvAxhUAG+I3xd2GNP2FzeGnh0w0JxomSib0D/BtkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tXTDBxfx; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nilay@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tXTDBxfx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nilay@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fFnBH5bHtz2xjP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2026 04:46:14 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HAfAbH3648080;
	Tue, 17 Feb 2026 17:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=3G0u7SK0ibdhCr4vMdf4WTAuV9tpPqMRjkiFzuavq
	Ts=; b=tXTDBxfxu7mubZQfoC9l8yYAnkdd7UCVwRe6rt4/dLMvzfESGWIsQOrSb
	mZvgWyZeErDGJ/kvhdEhJ0eiGEfBfBu5G4eHjY9sxeNxGC+q0ZKBI5QjvfYrwaPr
	nnDStrDyua/JuaXRwyGIPwfu4kdgIC6ximLqEMilWjDVhhpGZzzTT/CjggMwsLrM
	6Q/80ExFtWUaIEgErPisyQQGrxN+8ReId31OI0nakYpL4NL6JSD7MHFJg7rJgwig
	rvKnS24PNUyEaThvJBXMYS9VjOU/DUtyiWEL5X7CilL9YogQGz+Fv1GkkUp1lEGO
	ZkRq3FLiIyot5Rtp5Iiwy5Tq5yFFg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6unedu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 17:45:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61HFtUZa017774;
	Tue, 17 Feb 2026 17:45:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb28byfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 17:45:57 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61HHjrWq46924108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 17:45:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C48E2004B;
	Tue, 17 Feb 2026 17:45:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AC5220040;
	Tue, 17 Feb 2026 17:45:48 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.87.129.74])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Feb 2026 17:45:48 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Cc: wangruikang@iscas.ac.cn, tglx@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        gjoyce@ibm.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH] powerpc/pci: Initialize msi_addr_mask for OF-created PCI devices
Date: Tue, 17 Feb 2026 23:15:26 +0530
Message-ID: <20260217174537.1154686-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
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
X-Authority-Analysis: v=2.4 cv=E+/AZKdl c=1 sm=1 tr=0 ts=6994a956 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=6ccs27PMiSGM24VvTn0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE0MCBTYWx0ZWRfXyPOKqDVHzmMq
 dm1biqlfm/jNyc9zFszH/lxDWCT6TFEc0QhYQT4F10mKnxYQ9SDNq+XzJuhxtiyuaRgnbF6MSax
 bRhdUwn9/4mf4urBvMGv3Z1Fk7tqRkye4ROP+LcQbaXMHHSo7BlwwCdIueBxtSMQuRBaYAH3Y08
 EVEYmsTMmVFe8AUya8Za5vWb85FDZuwAxy2YXaVqegRdHdpyKVkjMAM9Vrl2OH4Y6dWTTBoiS0h
 CQUg1TJgcAuOf4iWj2kbVgaePX7wrtY1UiPAOKj1JqPDKPvJVFzV7p/gdHnKgxIVaHHTmmMLjG/
 5yo+MuMfXMShs39FRnDvZ5BxFQDFmBdtHWM570QWse/X7kSaEYeimoDQbfaLAe8eKAn3LqEfXPg
 G2UWz4u0eTfhRlfKUkvUeZEnBeWvao8pZBok8Gw9eLslMG7D7ch1OY0YRJNmgfGDSI7zmqRUPVy
 6FC4n6MGFlKKegutQfQ==
X-Proofpoint-ORIG-GUID: lZj2HitPoHMptHL_54AK7TlOxGTEDrvT
X-Proofpoint-GUID: 0O4mTSN_morF-4_k6oCPTNua1YfSUZ9X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_02,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1011 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170140

Recent changes [1] replaced the use of no_64bit_msi with msi_addr_mask.
As a result, msi_addr_mask is now expected to be initialized to
DMA_BIT_MASK(64) when a pci_dev is set up. However, this initialization
was missed on powerpc due to differences in the device initialization
path compared to other architectures. Due to this, now pci device probe
method fails on powerpc system.

On powerpc systems, struct pci_dev instances are created from device
tree nodes via of_create_pci_dev(). Because msi_addr_mask was not
initialized there, it remained zero. Later, during MSI setup,
msi_verify_entries() validates the programmed MSI address against
pdev->msi_addr_mask. Since the mask was not set correctly, the
validation fails, causing PCI driver probe failures for devices on
powerpc systems.

Initialize pdev->msi_addr_mask to DMA_BIT_MASK(64) in
of_create_pci_dev() so that MSI address validation succeeds and device
probe works as expected.

[1] https://lore.kernel.org/all/20260129-pci-msi-addr-mask-v4-0-70da998f2750@iscas.ac.cn/

Fixes: 386ced19e9a3 ("PCI/MSI: Convert the boolean no_64bit_msi flag to a DMA address mask")
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 arch/powerpc/kernel/pci_of_scan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 756043dd06e9..26ec97ce6b40 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -211,6 +211,12 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
 	dev->current_state = PCI_UNKNOWN;	/* unknown power state */
 	dev->error_state = pci_channel_io_normal;
 	dev->dma_mask = 0xffffffff;
+	/*
+	 * Assume 64-bit addresses for MSI initially. Will be changed to 32-bit
+	 * if MSI (rather than MSI-X) capability does not have
+	 * PCI_MSI_FLAGS_64BIT. Can also be overridden by driver.
+	 */
+	dev->msi_addr_mask = DMA_BIT_MASK(64);
 
 	/* Early fixups, before probing the BARs */
 	pci_fixup_device(pci_fixup_early, dev);
-- 
2.52.0


