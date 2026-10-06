Return-Path: <linuxppc-dev+bounces-28947-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3333CA5FED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 06:58:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzRt61Qvtz2yKn;
	Tue, 06 Oct 2026 17:58:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791269902;
	cv=none; b=kV+VwRKzYQKNqeBD/o6JPSVsacgobJfiXBJGN7Pk8mFgPEIlDnP39lc6G40tV8RHLwrypiv6VDOfSW7iMJL/1074YA8MJrwa7ZzST5nmRaXA+4qocwalnvYNpv8DtBNd9aMFMSOocMpqogd5XIW52j5oOg8U4SJdClWL6DaahP7KOUmCW9GJHutqGecDvolVrW77Kv5X3g1afx/eZM0Du8BSjBuO4ojN67Dy8wEW9LJpDjlQCinbuNrfg3Z7YWr5nCqYjr+zNn/7FrB3+cl5Al5aAclMzSMYFnOnChKwZzfi2TqM6oIzODTHqvFwz66F6B0GcGSbJCTG/mSREQo21g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791269902; c=relaxed/relaxed;
	bh=X481iIFA9zZ9td+6fPt4Wk3LINz3qaRsr5JuBCHFoWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iVAj0/SE5sNipABsjsru2VhZgDXdT51AJIfoW2Zyk4hcoF4FgHwon1m/D9Gvds+luqRu6oLG5Zn53Em1q3eAyko5Rn5H2wZt0qzJSTSQCEiOkTtZi6TsTUSYcranEvb0+JeMr9FtMJ6thtKRbsfMUy4C4nQxawZmzlroc/RLzdiNiHvmCCXSbbZRhVv/Ytgxp/qHgNI8+dFfgxzbSpdUmxbmqkXDKjFy63Tq73Bl6rqV+7t7ZUMSz29u1jX+bemZk174E5wzEFYiPlbbzWQuhL64w5OoDk0RzW67tRXet527TVq822mYdwn24EgwuuUKHBlWN+onptT241KYAM+S2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QC+Pp/8C; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QC+Pp/8C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzRt467sFz2yDm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 17:58:19 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6966bblI2785188;
	Tue, 6 Oct 2026 06:58:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=X481iIFA9zZ9td+6fPt4Wk3LINz3qaRsr5JuBCHFo
	Wo=; b=QC+Pp/8Cn3BDwk1HaoYTtehiQWDH/+ch34ugIVFYG2y0vIJV6RGM8pZzP
	6JhdNd6W3lA6oy4w/gehRGNJLFZj/0rL4tfm4sxMS/bEDyWVS4Sz/ltsDbe0vZN/
	ctMW7f9gjoXhjVnG8109ipsZ6xuXaXEBl/c0Bj9xTULhSVxpkBqJy90m5rsI6/gg
	3pigbOk12EdYSn9xxbucumTWiwWuP209Dcee5lpdiaNBmyd0nVVoBdXYol4UcTAt
	68uPaHLzjFuZ0HrCSM4YTAv4RFFDAXu/PVSTR2mBFHg5r4yoIdpzLyfHp9KLohFs
	dZTUORGDLmnRiOjsnzupT8XB/Djlg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jp0pu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 06:58:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6966lZFE4106913;
	Tue, 6 Oct 2026 06:58:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1ps0t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 06:58:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6966vuSA47841748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 06:57:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 379A82004E;
	Tue,  6 Oct 2026 06:57:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9851E20043;
	Tue,  6 Oct 2026 06:57:53 +0000 (GMT)
Received: from li-4c4c4544-0042-3610-8056-b8c04f473234.bl1-in.ibm.com (unknown [9.123.3.44])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 06:57:53 +0000 (GMT)
From: Jyoti Gupta <jyoti@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Subject: [PATCH v3] powerpc/mpic: Fix memory leak of mpic on error paths
Date: Tue,  6 Oct 2026 12:29:45 +0530
Message-ID: <20261006065945.391637-1-jyoti@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: GEwbNGWoetfqnbH1wg2HO4KjDWYrX_jU
X-Proofpoint-GUID: liciNR5XW2ikWJzXPm58izQxJvAT3zsm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAyNiBTYWx0ZWRfXw4Qi/kLJtr0M
 Gr/7T07tVhdUNG55pE6YDRHiH/XkSUOIEcdVPw2GEw+zlP/xsMfOVjI3Ii1XsKTe1/t7XQmSiU9
 xQ/nj2Xeu0qDRpdBFG/WfstOeqRPjL4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAyNiBTYWx0ZWRfXwSeFP6RcP5Gt
 5AEenmnbJPa1jfeMP0965NFjV1MSCFhO1ktnxi8L2TIs62GPZaTEXo+A2UW4E4GfobaT6PAgCZD
 cdXANE4tTRJxdWFf2G28+sBvSLUd3UlCpb2x6arhg9alEA0BEUdBMJ7ounsHA52wEo/rWYm+oeh
 ihG67+J6+Gd3ubJgDelCtxMhk6bqzgnHQ7ocv2gU7DJ2LSy5Uiyu+av0EUDqnkCXV00BuUcBIsT
 H79g+OomS2tfT1HQLwwSztn1hefUAcWDn2l+u66k3aQHduqfbEUSmcFDdutjg6nPAs8F2v4fWI/
 6zONUJ4kW11P9uYtDFpftXMn53Z74rGI2USn9QG6wXGhhmz7R0u2j+xvuHxM1w1xAO7TyRqnR7O
 gR7q2n6yQsOzadAJ21DP/FxB+jTIAwScIWB+ukRG9RuBl/nQU6z360Cyl+FQKj4XH1wvleifCr6
 0aTIQ0Aqfy3NmWCA6BA==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac49bfa cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=VyWIBLCL5DJSJingBiIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060026

mpic_alloc() allocates struct mpic (and optionally the protected
sources bitmap) but does not free them when mpic_setup_error_int() or
irq_domain_create_linear() fails, leaking the memory.

Free the bitmap and the mpic in the common error path before
dropping the device node reference.

Fixes: 996983b75ceb ("powerpc/mpic: Search for open-pic device-tree node if NULL")
Signed-off-by: Jyoti Gupta <jyoti@linux.ibm.com>
---

Changelog
===========
v2->v3:
 + Introduce 'err_free_mpic' unwind label to cleanly free mpic and mpic->protected
 + Link to v2: https://lore.kernel.org/all/20260930180919.335930-1-jyoti@linux.ibm.com/ 
 
---
---
arch/powerpc/sysdev/mpic.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 257886ec3f70..d799cf4da7bd 100644
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
@@ -1488,12 +1488,8 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 						 intvec_top,
 						 &mpic_host_ops, mpic);
 
-	/*
-	 * FIXME: The code leaks the MPIC object and mappings here; this
-	 * is very unlikely to fail but it ought to be fixed anyways.
-	 */
 	if (mpic->irqhost == NULL)
-		return NULL;
+		goto err_free_mpic;
 
 	/* Display version */
 	switch (greg_feature & MPIC_GREG_FEATURE_VERSION_MASK) {
@@ -1526,6 +1522,9 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 
 	return mpic;
 
+err_free_mpic:
+	bitmap_free(mpic->protected);
+	kfree(mpic);
 err_of_node_put:
 	of_node_put(node);
 	return NULL;
-- 
2.55.0


