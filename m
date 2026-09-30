Return-Path: <linuxppc-dev+bounces-28599-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA3FCA5FC4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 18:09:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hw33Y1176z2y8d;
	Thu, 01 Oct 2026 04:09:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790791785;
	cv=none; b=X6zuVBRd0793C2/g6R6zw+JS2TYYqmAPynmol04cU78GNvYnQP2KRrirtsIOOGmcKFY1kaosnpn20ccpwHm1dzaXLzq0XoKWnn2qbHiWllf6ssenP6/EUvYNoZrdr9J4+mjRWJmu88WwfvJDJuep84TpOgwNQWThpBoJRcqP3/qpNualhoxgKI1Y9z0AQzzByGw2PsWPf4YLy9lSfMOJOzpJuSbnw37QGMSs4zoWu4Zsne9ZRMZLDx1MSCYxFtnVxcOTRYvBElzASzLoWXqxeOnG9Z7OiFrGGOECyQNHonovIrVtA8y7Xw9NHC4RjgLS5SD/nYrBnLVekmxGINsGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790791785; c=relaxed/relaxed;
	bh=fOdtxhVrtyJQ9ILNW3SJhQBtGRF48Wpq2LZd1ZVtX1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hYvPxLgniohnHRnuSwTX5EGFMdDvmit3GVNImS77Qw84LWpEVB5fNlXen6mZJO3kZdsLKoVLgP0125bgdcYKgBxuQrBf58X/y7ChjQoiHxLCc3gf8GFPsyDhmlZlABn/+d3X7IAaMwMzNjDXa6Hs6SZ/pTgdzPYZ3e5+PjSav8NPd4VC6c8m+KDOe3Zed2SDeGuEShZsto9ci04PIpB110CWh74ofXQYQoYZKGpvWHrUpFqXVPBVoiKC9rm382dpWjJMtErhB9gN9TdoHWS6F74suWM2QdZ2VVM7RhFCvagUNe0RqAfD7NggavX33WFqweIH3/wKtw1PhU+sJ8kZ0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=b7YKInIm; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=b7YKInIm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hw33X0P9tz2y24
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 04:09:43 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UI5NfN3708244;
	Wed, 30 Sep 2026 18:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=fOdtxhVrtyJQ9ILNW3SJhQBtGRF48Wpq2LZd1ZVtX
	1g=; b=b7YKInImKenFeOQVBbIr/1kumhY5sj5Lf//lIp76oCIodZookZW3/FBu5
	G1yU3lbuhCpeO3e64vEG9V4M631ja8XUsG5YzqZ5XTyeyFHAzrGW6TQCwB3qiBxL
	+Ca4xAm9FhvVUpPzUyBFS6mjVbZTpk0pFCHNgwUT6Fgwe5erSUe89jx/M8vs5lkA
	d1IeuxE2mx7BsQbTSu8DMfxjNYQhyGsGQWt3gLkX7pR9GbbvbOnlrFHenqx8NZNF
	k9rzyeZ9rAudW02EHQEZMa8LCuofTg0bl8LBiXDXORV2tjjtLetWP4vnBwrwruGr
	Q9BzzJTEMvA6DT2OiPNnRz2LIOIAg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5euh8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 18:09:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UHltnl2587494;
	Wed, 30 Sep 2026 18:09:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pbryy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 18:09:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UI9Tjx31064348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 18:09:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E62FA20049;
	Wed, 30 Sep 2026 18:09:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44C0920040;
	Wed, 30 Sep 2026 18:09:24 +0000 (GMT)
Received: from li-4c4c4544-0042-3610-8056-b8c04f473234.ibmuc.com (unknown [9.67.31.86])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 18:09:23 +0000 (GMT)
From: Jyoti Gupta <jyoti@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        sourabhjain@linux.ibm.com, amachhiw@linux.ibm.com, mkchauras@gmail.com
Subject: [PATCH v2] powerpc/mpic: Fix memory leak of mpic on error paths
Date: Wed, 30 Sep 2026 23:39:19 +0530
Message-ID: <20260930180919.335930-1-jyoti@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MyBTYWx0ZWRfX33owgyI/6On1
 CZWuIn+yacYs/zV+alorX/TxlQmPGdcafEU0cG+M7Nir9JW3uSdhL91EZvxLfvjQfTRBxouhSMU
 KB4XQ649cCA5g+IurnPmYwUwpStQ9E0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MyBTYWx0ZWRfX8PxgYPxSr2mF
 1o0rik8kcJ/Z+suiZCYIhZ1rD2efJW2+iuEC7JqiPjYB1/0cZLFXpb1ZjiVoIYQwEuOluk7TlrY
 VK1zvNq98DAl7TNt7sh/fVna/2ttcr3q63+W+RSaUn0sBhW+Ip/vn708Ax8duSpHC81TwaDp5sQ
 1UMZwSryylZAVqTc99YjPKlLehTQGIy6NHiR9EgmU2SwOhqFaF66+6fMcXTWY9H8YocxoqRL4Ai
 t3xQz8Xk3cuFop6Zu5D1n/Fe44vhEpDFi99MWradUyDtcFH5k1dBzGHRYaqTlWkm+RJanxQ8q6W
 vqNmekR4z/EgdEIchBo/QNb9vdlDDKKGMlclBGp6YUASfsNDld2KR2P9B/ALdPmnlMKrt/pmSkX
 Ppbs9jGNMw88dtMCcQxf5rk/nQYSeindRhnu4uHGwSDCS6zLjvW1B9qpjoqqceSdpmKU4GO8u/M
 IySzMHHSu+4X1GlOLjQ==
X-Proofpoint-GUID: 84AbBOAzfkPmoZ1qmxt31f5jAiU8aiN6
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abd505d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VyWIBLCL5DJSJingBiIA:9
X-Proofpoint-ORIG-GUID: 0Izb5SmfDGcs5UjpB35MwD4upfArpORA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300073

mpic_alloc() allocates struct mpic (and optionally the protected
sources bitmap) but does not free them when mpic_setup_error_int() or
irq_domain_create_linear() fails, leaking the memory.

Free the bitmap and the mpic in the common error path before dropping the
device node reference.

Fixes: 996983b75ceb ("powerpc/mpic: Search for open-pic device-tree node if NULL")
Signed-off-by: Jyoti Gupta <jyoti@linux.ibm.com>
---
 arch/powerpc/sysdev/mpic.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 257886ec3f70..b21a880777cc 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1389,7 +1389,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 		if (fsl_version >= 0x401) {
 			ret = mpic_setup_error_int(mpic, intvec_top - 13);
 			if (ret)
-				return NULL;
+				goto err_of_node_put;
 		}
 
 	}
@@ -1488,12 +1488,8 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 						 intvec_top,
 						 &mpic_host_ops, mpic);
 
-	/*
-	 * FIXME: The code leaks the MPIC object and mappings here; this
-	 * is very unlikely to fail but it ought to be fixed anyways.
-	 */
 	if (mpic->irqhost == NULL)
-		return NULL;
+		goto err_of_node_put;
 
 	/* Display version */
 	switch (greg_feature & MPIC_GREG_FEATURE_VERSION_MASK) {
@@ -1527,6 +1523,9 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	return mpic;
 
 err_of_node_put:
+	if (mpic)
+		bitmap_free(mpic->protected);
+	kfree(mpic);
 	of_node_put(node);
 	return NULL;
 }
-- 
2.55.0


