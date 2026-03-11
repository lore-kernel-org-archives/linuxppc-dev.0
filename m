Return-Path: <linuxppc-dev+bounces-18060-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713081125823
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 13:44:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWBn14t9gz3cC9;
	Thu, 12 Mar 2026 00:44:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773236661;
	cv=none; b=k4fFB4n4BWk20CbaZkx9WzK653QkzvVW6WLFkoiKinflrC7VC0+rDITQJv4cFY48aCTCgMi+Ap8nE1IZSh+S1QAeEPqpBNcZ+LAk+RHP1cVda4c1QYEsP1fAyfIPMFaM8fibPRZ23IkVQRjLkpOFVGgrM8wSLUcC2jZtjwYfv3allejpjsrev0ibXx8ayhMwFL0/o9PJHnt3yhgxTneKnbHc6WquQ6Atlx0Sis3cGpa0tm8mN7hXBZC05UHpvKrAqmtKwrJlxD8a5zkofO/5TWxEo9DFsnq0Cf1cwjTWv376Dm9puyzwh8dFpz3YfQZSDItu60bACp2ztOvKmXyk8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773236661; c=relaxed/relaxed;
	bh=5k1WkWwJZfkjKD9Do2HFw1TYnOgPIRSt3Wavyyczgjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bF/VmYZXB1vaExyySwlbjRQ8JeWZmyB5xstSJm51Qu7cfBE9fzFdG+ERWDPhxCXfSmLFUx/eTHxmamUgcOK9Q3Q8Tw5AvaooCcZwOemXETRvaaFVBXxgjtJj3euM2evT3Oth4MfOa57tNQX4+nA9rGhM8mozPwIpUFyl6EFsLf7C5c6jePIZlrRQJycpE/j7b94MoVE+LCR54zGyn/pPO7dqJU1cm4TyX3QI8061UOcm3EOwvNfF7+YSDtl6wOiVd0jF2fk+xrE3QWnOB8K0Eg9VQx3jGYpDuXbpxD4q1HPULcGj8UtoQf7ghk6JolFBr+JvQZj1+l1ldvs6vUGmhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mzsfhPXh; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nilay@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mzsfhPXh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nilay@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWBn048Y0z303F
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 00:44:20 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BDCor61997845;
	Wed, 11 Mar 2026 13:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5k1WkWwJZfkjKD9Do2HFw1TYnOgPIRSt3Wavyyczg
	jw=; b=mzsfhPXhEvc4nwelrVH4U7BGp4dLGugt9eUu/imYDhVhctwImNUSLioAj
	uLSKcLhVXc0By3x0UNemgZDIYHLH61jcfNIgaapiDkCkanpVX/zvUsxWhjIqkDDz
	HcYOkvzBnTJyppe4tYFPwgNRcVlkGB2qR/mh6QvDdfUaJurtEjw3XnQ8k1lko7wK
	LiatXDmRRdn7H4YuewMaXT5OnpoYD1YNDCnay3F+fym4Zw7muFENYLccgvo2714O
	UjD6hX+1hjCTO3RulPQGIWCFD33y1xe/pTwt0W320beKIjo4Z1tBoRN9X0VvUt+0
	mZASAfqCvxL9zC7RactR91uTq/2cQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvmg78e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 13:43:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62BD1n1M024649;
	Wed, 11 Mar 2026 13:43:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jk5fph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 13:43:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62BDhmEi56492426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 13:43:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C8BA2004E;
	Wed, 11 Mar 2026 13:43:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88BF12004B;
	Wed, 11 Mar 2026 13:43:44 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.39.22.162])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 13:43:44 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: namcao@linutronix.de, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        maz@kernel.org, ritesh.list@gmail.com, gautam@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH] powerpc/xive: fix kmemleak caused by incorrect chip_data lookup
Date: Wed, 11 Mar 2026 19:13:31 +0530
Message-ID: <20260311134336.326996-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
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
X-Proofpoint-GUID: Lcapkis-v769aIZLGt4_AYUvHMxk2dEr
X-Proofpoint-ORIG-GUID: NPOW6rCHcgISKzW5iGNE44AI8M38VY9k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDExNCBTYWx0ZWRfX1X3eayjuss4d
 lj7WXGJ+/etTW4mzOjVPrFw2XaYt4mdut3eptIpy63Bp5y/YbWuhbAHali6s1mjEI1PG5ECLPW7
 307uXX246STKD3y72/FIhximP6MwbUM7sQYzmZ5C5F8XKtYsLzgI3qS1EKfE2xYgQsfFPtZapbr
 d0+y9W9k5mBDj8NkWY36Cbh4jrKJFS1tmnCpgU4l/BknXqtIS0/YS+A5yCsHOafHdkBTenEygD0
 zVwxGm3UrOD8is5Nn0ao+PqRiuylxHy3x0vH5GTnDedDD2jfFGzVDuMasLC9lYXfpTFKytt9lRq
 pFHfubE548R5nzNFK/7r+a0g9k4Nm03+vfIfjT+dtcTb9q2j9UW3eP6K3XTpAwObgRjsQZ3CD/r
 xcKwv2eiuXf+6yv3noMq7hKilQNI6CAZ0qaOpasuj92gmu0azaeDILxwuYvTRXZYMLkFhmCZCFG
 UB0ffsVa0fCc45Uxo5g==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69b17199 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=YDLeHvHTvU_vrB_0PgUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110114

The kmemleak reports the following memory leak:

Unreferenced object 0xc0000002a7fbc640 (size 64):
  comm "kworker/8:1", pid 540, jiffies 4294937872
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 09 04 00 04 00 00  ................
    00 00 a7 81 00 00 0a c0 00 00 08 04 00 04 00 00  ................
  backtrace (crc 177d48f6):
    __kmalloc_cache_noprof+0x520/0x730
    xive_irq_alloc_data.constprop.0+0x40/0xe0
    xive_irq_domain_alloc+0xd0/0x1b0
    irq_domain_alloc_irqs_parent+0x44/0x6c
    pseries_irq_domain_alloc+0x1cc/0x354
    irq_domain_alloc_irqs_parent+0x44/0x6c
    msi_domain_alloc+0xb0/0x220
    irq_domain_alloc_irqs_locked+0x138/0x4d0
    __irq_domain_alloc_irqs+0x8c/0xfc
    __msi_domain_alloc_irqs+0x214/0x4d8
    msi_domain_alloc_irqs_all_locked+0x70/0xf8
    pci_msi_setup_msi_irqs+0x60/0x78
    __pci_enable_msix_range+0x54c/0x98c
    pci_alloc_irq_vectors_affinity+0x16c/0x1d4
    nvme_pci_enable+0xac/0x9c0 [nvme]
    nvme_probe+0x340/0x764 [nvme]

This occurs when allocating MSI-X vectors for an NVMe device. During
allocation the XIVE code creates a struct xive_irq_data and stores it
in irq_data->chip_data.

When the MSI-X irqdomain is later freed, xive_irq_free_data() is
responsible for retrieving this structure and freeing it. However,
after commit cc0cc23babc9 ("powerpc/xive: Untangle xive from child
interrupt controller drivers"), xive_irq_free_data() retrieves the
chip_data using irq_get_chip_data(), which looks up the data through
the child domain.

This is incorrect because the XIVE-specific irq data is associated with
the XIVE (parent) domain. As a result the lookup fails and the allocated
struct xive_irq_data is never freed, leading to the kmemleak report
shown above.

Fix this by retrieving the irq_data from the correct domain using
irq_domain_get_irq_data() and then accessing the chip_data via
irq_data_get_irq_chip_data().

Cc: stable@vger.kernel.org
Fixes: cc0cc23babc9 ("powerpc/xive: Untangle xive from child interrupt controller drivers")
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 arch/powerpc/sysdev/xive/common.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index e1a4f8a97393..6b1b7541ca31 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1038,13 +1038,19 @@ static struct xive_irq_data *xive_irq_alloc_data(unsigned int virq, irq_hw_numbe
 	return xd;
 }
 
-static void xive_irq_free_data(unsigned int virq)
+static void xive_irq_free_data(struct irq_domain *domain, unsigned int virq)
 {
-	struct xive_irq_data *xd = irq_get_chip_data(virq);
+	struct xive_irq_data *xd;
+	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
+
+	if (!data)
+		return;
 
+	xd = irq_data_get_irq_chip_data(data);
 	if (!xd)
 		return;
-	irq_set_chip_data(virq, NULL);
+
+	irq_domain_reset_irq_data(data);
 	xive_cleanup_irq_data(xd);
 	kfree(xd);
 }
@@ -1305,7 +1311,7 @@ static int xive_irq_domain_map(struct irq_domain *h, unsigned int virq,
 
 static void xive_irq_domain_unmap(struct irq_domain *d, unsigned int virq)
 {
-	xive_irq_free_data(virq);
+	xive_irq_free_data(d, virq);
 }
 
 static int xive_irq_domain_xlate(struct irq_domain *h, struct device_node *ct,
@@ -1443,7 +1449,7 @@ static void xive_irq_domain_free(struct irq_domain *domain,
 	pr_debug("%s %d #%d\n", __func__, virq, nr_irqs);
 
 	for (i = 0; i < nr_irqs; i++)
-		xive_irq_free_data(virq + i);
+		xive_irq_free_data(domain, virq + i);
 }
 #endif
 
-- 
2.53.0


