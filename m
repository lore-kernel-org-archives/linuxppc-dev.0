Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0504606A324
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 08:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cwz66smE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVWCg3Z0Mz2y2R;
	Thu, 19 Nov 2026 19:02:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795075343;
	cv=none; b=VLCgTTEqF+uSIRXhkC/6g8xWIihCKKzA0tHKfKFJPH1BptXFtFjREB3XFh7iw7cxg2cK0nVCRJrGfF78ye845nWtNHZ153h11TJdNeQiFR2oHiAoRT8tR5viOIZNrZOotq4KyTj9yHbfYVLqujtjlBjCDQPy0sV1XBoNJc+Ff29Th0HSwjR/ODLlddy30iQXUq6IEX7LgLr6ggzL7gwseJsWFodCwgtSccHZ09TwLovkDuVWnAFfTRUpoqe0ldb1ZjSbQFEeHlJ2ibXB6qdzxWaM3c10yOepPxqBDBqUtfHI58VC85Zy5p4T/N1xRU8Fx6DrdkWg/C9jWN0vUHc8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795075343; c=relaxed/relaxed;
	bh=31F7U1b2JCUbc/EUGQuyU9kXUCzxNLz6H16BEaMugW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TZrrQ1tazcByl+9Z3EEoT4Vn1Cthl0Ecc4ws4y93tNyCuH2U7l8NwPUb8XZaXeSQ7quiocNI+ektfXqqyQNtoV+nxAt9hliRDcGM/dyFhw6VLYQfnwvUsrlQgMaUl07GY6tU7bgI2ed8YJnyLqNqs8Ec5pyKC0krPIA1fy0DSmss9xsauoF/GOyh429ih9i7zzKREE6VmVFJfNZepebW9XonECPhKFiBHzzkj5hKSsLROzuD3PVYuiB7IubEr0Em5LFDUkXXnjiFogYZEyr5edd1qZ55/jh5HR/XToZNKjbE/k/wepOYVOsdjzM8IutL5PVT8UubFOUShr9JVNu2wQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cwz66smE; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cwz66smE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVWCf1fyKz2y0B
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 19:02:22 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6v1v23437230;
	Thu, 19 Nov 2026 08:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=31F7U1b2JCUbc/EUGQuyU9kXUCzxNLz6H16BEaMug
	W4=; b=cwz66smEQoKZEceylq3hBnY5ZYpaRKubIEFIgcntBRq8i1tSW3502gZHC
	okmWaIaVwpvSoqFm682FiStBFr14jDg/TByiBqaEprkVU5xdoWdWAPhlKM/FtV0D
	GpljSBSi4G8xj4hoTeQKaWiSBDn/g0ipO3bD9SkTIwwg8kLl75OLmbgkRQH4Keyj
	NEZBrlnHLZNoTe4TumeynBJ6Et+F6NK1MB7kEb8lsovkFt1OF1uCPTZBYmqZTniN
	pxtqCIgeTZO1aZf02SkuMVPgu9kJJKE03DpOmN5KCogfT9HOfZJ+93NtMjTooL9C
	MapFlFuvYPghgcT9kUdohc50IVOSA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105t7g37-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 08:02:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ7561T2161163;
	Thu, 19 Nov 2026 08:02:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1v9x89ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 08:02:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ82CvC30802444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 08:02:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AA1A20065;
	Thu, 19 Nov 2026 08:02:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A22B2004E;
	Thu, 19 Nov 2026 08:02:08 +0000 (GMT)
Received: from li-4c4c4544-0042-3610-8056-b8c04f473234.ibmuc.com (unknown [9.67.189.13])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 08:02:08 +0000 (GMT)
From: Jyoti Gupta <jyoti@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, npiggin@gmail.com, chleroy@kernel.org,
        ritesh.list@gmail.com, sshegde@linux.ibm.com,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PATCH v4] powerpc/mpic: Fix memory leak of mpic on error paths
Date: Thu, 19 Nov 2026 13:31:18 +0530
Message-ID: <20261119080118.48688-1-jyoti@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6afead09 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=rRvahzxraNLFjGORCMYA:9
X-Proofpoint-ORIG-GUID: hp7CSNxdv2RSDV6YrnxB75-C-PWsPX8O
X-Proofpoint-GUID: Eazu0D4U2q2mVgim0ovRhR9VcWCyCTgf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMSBTYWx0ZWRfXxHnRtsGQZDS1
 8W9bav8SUlaNmCyO0ufJlYgI0yiVgabzjotFBWuciPe7DUYdFj9AHZMZvN/7XcohZ4wPT3p76ND
 tOht2YsYtlOL52jZfTKqSk0ucTz2arUrU7MFAr7VpDTrB0da6ufkaQXuECfCzh5mSaGobIfL9zt
 ci0HbSX69g5E0STJnhpWq8f6d2TzVcaTwkmbhSU/5eFuTTzpy0r406meFew4NYfnZ9xEuzcmtxe
 n4w9+7EkeCUW12nsokTiXxtbtWnY4SQIu63XFcBNBzEly70wVoN6yhXy4waeQBBSjlI2oRhRX5P
 /0nitcXEyIsloyx0CI3pqIhth5lDM/uYWdTmJXR1KfxODr0iSXRfHpM5DuJpb8QmzrO4t2Xg5gZ
 ZwE2BNdt+CTnuXqCUhQobvbysbKVqKGnKhmUK8syuS/DbEQRi3dXpZ8pSQ83ONaXuFQ8CzZ1Ouw
 nNKyAMG8CbeKZu2SXuA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMSBTYWx0ZWRfX3rgHTVATmmRf
 0tcCYIEmTHNO4mX28HY9vRp3jVkXTd22csMzDuhEOXyKTpo4CUxf8rl5MvBcI1TqdFxKP4Hoa5h
 lllhCwlcz6jD2IgrKcS2UGQIHORPu5w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190031
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

mpic_alloc() allocates struct mpic (and optionally the protected
sources bitmap) but does not free them when mpic_setup_error_int() or
irq_domain_create_linear() fails, leaking the memory.

Free the bitmap and the mpic in the common error path before
dropping the device node reference.

Fixes: 996983b75ceb ("powerpc/mpic: Search for open-pic device-tree node if NULL")
Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Jyoti Gupta <jyoti@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changelog:
v3->v4:
 - Retain the FIXME comment about the leaked MPIC mappings (they are not
   fixed for !CONFIG_PPC_DCR / !MPIC_USES_DCR), per Ritesh's feedback.
 - Added Suggested-by tag.
 - Collect Reviewed-by tags from Ritesh, Mukesh and Amit.
 - Link to v3: https://lore.kernel.org/all/20261006065945.391637-1-jyoti@linux.ibm.com/

v2->v3:
 - Introduce 'err_free_mpic' unwind label to cleanly free mpic and mpic->protected.
 - Link to v2: https://lore.kernel.org/all/20260930180919.335930-1-jyoti@linux.ibm.com/
---
 arch/powerpc/sysdev/mpic.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 257886ec3f70..ab33992a8698 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1389,7 +1389,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 		if (fsl_version >= 0x401) {
 			ret = mpic_setup_error_int(mpic, intvec_top - 13);
 			if (ret)
-				return NULL;
+				goto err_free_mpic;
 		}
 
 	}
@@ -1489,11 +1489,11 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 						 &mpic_host_ops, mpic);
 
 	/*
-	 * FIXME: The code leaks the MPIC object and mappings here; this
-	 * is very unlikely to fail but it ought to be fixed anyways.
+	 * FIXME: The code leaks the MPIC mappings here; this is very unlikely
+	 * to fail but it ought to be fixed anyways.
 	 */
 	if (mpic->irqhost == NULL)
-		return NULL;
+		goto err_free_mpic;
 
 	/* Display version */
 	switch (greg_feature & MPIC_GREG_FEATURE_VERSION_MASK) {
@@ -1526,6 +1526,9 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 
 	return mpic;
 
+err_free_mpic:
+	bitmap_free(mpic->protected);
+	kfree(mpic);
 err_of_node_put:
 	of_node_put(node);
 	return NULL;
-- 
2.55.0


