Return-Path: <linuxppc-dev+bounces-19840-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9EEF99C73
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Apr 2026 09:13:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fyQyh5ztYz2xfX;
	Sat, 18 Apr 2026 19:13:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776503596;
	cv=none; b=L8FpsvrbQPic9TwtBaW06O+7bvwkKZTksgxFI1kXHtGH6qSJKpzkWEiekSL02dTTTLIWNts/+GnSeYhLcTxgqvy4g/bkg3v+OuWwlEwV9T/NUGHipqxX4pxqQEVU1z1ePAA3Sa3CUjT6VHB46k99IvcCdKvt3+JN7bUKptf7ffSjpY+Aka0sNez3OrXTksJk/dp7C7BkceXGq6BBzjYPFvYzzAZ0K5keWvsJg98dKTe65guDqC2gJJyez8Lwx5RvXrct/qF9THvA2wlIlZmZTWkxSJVAWcZAHzCxppQ/3qE03M3rbdiaP7xtbl0uh1RhP1w7sS7dVJGeqt1gjdauCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776503596; c=relaxed/relaxed;
	bh=phM17PYLWKN5oOPWwYiBzeMwlYU5ympObxPTpKH/e1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fnR7nsbZXfCgjluw3SRm/H31l5FIuy2ymvyHqpzWjxou6/lQ8IHG07ZxwbMkuFQOqIZggAOxm7JpFbJUnrPFNFC/NepV5aU0+5o4I48ydYSWSe/l5DtUzCyQspN4chg2TmD9eZhYd1e+mYQeAV/OM1+Lh5awWw+vPgVKaX3TPbIHvZ5oDCUmQbzh57KpLvL51eWjZKuJTo8XiNtXDhxBa0CtKYVGP261yCzVCQRLdiP4TeKeoe2b5zNIaxNnKo9ichmofaJAiMQj/J3g0UaaGIba3gNoC0poc5ZPbAK3LsLHt2eVgK15w1PXXxnfFYVLWQJ/KQi7Ho8mwxOhD4eWOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ET3La1Zh; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ET3La1Zh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fyQyg3WwFz2xSG
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2026 19:13:14 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63I7NMMv3419088;
	Sat, 18 Apr 2026 09:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=phM17PYLWKN5oOPWwYiBzeMwlYU5ympObxPTpKH/e
	1M=; b=ET3La1Zh38hOqLcvPl78vTQN/yl356MlKavbCELNJXghKxUGS5K3jyGM3
	ffb3t+QHSHuqo2zrQ4NIAjJJaUYPe+T57RNpciHwVRlblX4Xpg9CFkIBT7u2+Jjj
	EYI50BF/Y/+5Y/sxnV7y7CuEo7WL0bLbNoCAtVjRlrlVQWYIceIxBwSXm7+PTf69
	97rCB1OPX2Jc8juFqdWB7GQ0gsYls1Lv0inzOuPm5CRVxjvtc8Je3QgZk37dqnaX
	BTslcwoQDIScs8g3yvtToEaetpGILNtzuZeHERzScC6+cRB9x/AJdKZZgDy4fdQL
	5kxK/M1PGnL0r7Nv2OuckEJ+WOZUA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2h98k7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Apr 2026 09:13:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63I9CCQI016443;
	Sat, 18 Apr 2026 09:13:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dm22k0qcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Apr 2026 09:13:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63I9CwTL40436030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Apr 2026 09:12:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C3EB20043;
	Sat, 18 Apr 2026 09:12:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5210E20040;
	Sat, 18 Apr 2026 09:12:55 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.124.217.81])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 18 Apr 2026 09:12:55 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/prom: Remove redundant early_init_dt_scan_root() call
Date: Sat, 18 Apr 2026 14:42:50 +0530
Message-ID: <20260418091250.134111-1-sourabhjain@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: BgySeo-Mw100IQuKMBQEiFcmO5ISJf6A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDA4MSBTYWx0ZWRfXy4lKyrHQAnbC
 rwr5Zgk1gPXQKsOEy0LG90VUazRfc9ZGArm4yAQ/okgXd8k+cBPIiTeXmWGQFUr0OkCPVTJvf5A
 33vIFdwDC5OT1m4pmx0NVzb+224Net9iCSQvhRQlhdKESZVbPLtumnh7OYBJ+xD5r2QdvMPcIhQ
 LhRBZxM3XxNeZbNHUfdcbI9Z8Ziexfi6YQ53BQvi2WFcwEx/7wiq5hJ12wtpcNHE1PASXH2vnDb
 JqHH7bnxRbw5Vn4SzbNXUQ81wRwkt3JMTGB8gS+DotVR4NoTE2wD/7RpuYrAF6PZb8hAXZctOa0
 fEokf+jPWwP/PBNZP4qg/52JPRy5tdFWZ0i7Yl0M5tsR+SVk3TtF43jsrQ4DeKCA+/TxP+iOT5d
 kLBW1imzNjxjV/OqXBQdZlwycATceu65CB0eAR3c61mTTj+cv+LXB2SS/uLdWv9PHVW5RZeetMy
 IViC5tk1QCRuxhJUb2g==
X-Authority-Analysis: v=2.4 cv=XLYAjwhE c=1 sm=1 tr=0 ts=69e34b1f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=Ch0cGf-TT9rgrewJZhwA:9
X-Proofpoint-GUID: 9h2YjxAOXVlyY7_AOnVzomCYEOCXC85l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604180081

Commit 554b66233623 ("of/fdt: Scan the root node properties earlier")
moved the invocation of early_init_dt_scan_root() into
early_init_dt_verify().

early_init_devtree() already calls early_init_dt_verify(), so the root
node properties are parsed before reaching the explicit call in this
function.

Keeping the call here results in scanning the root node twice. Remove
the redundant call and rely on the invocation from
early_init_dt_verify().

This change keeps the behavior the same and removes an unnecessary
duplicate call.

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/kernel/prom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 9ed9dde7d231..d218c8cc1f73 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -824,7 +824,6 @@ void __init early_init_devtree(void *params)
 	fadump_append_bootargs();
 
 	/* Scan memory nodes and rebuild MEMBLOCKs */
-	early_init_dt_scan_root();
 	early_init_dt_scan_memory_ppc();
 
 	/*
-- 
2.52.0


