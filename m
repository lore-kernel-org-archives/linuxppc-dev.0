Return-Path: <linuxppc-dev+bounces-21205-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8F9CD4F5E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 05:53:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL11h2WKlz2yDs;
	Wed, 20 May 2026 15:53:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779256424;
	cv=none; b=XyPatfxgr/kWktJtEubdoE94fxJmOwCs7bmhRGiqaaXGPB1RjN501yZnDSWSdn8Hp4MJwTmYBxU72g1x4D8WOai6F9Z1cd60fXGtrtNlQf5fLR1PjnlcMWWw/agzYpBrc0HbFyyyFbGIGu5d/j1HtKC7Ue6zL5LxUmSNH1d50Nv8LrkmbPrPfRm8ex2tVqDF31k5QUm4QNwsqmXvoAXxieDRdhBSXezeCAAvSTJ7sQJAlFLskOjvAl86PxQ4NA9/OQOAvmi3DbfqMwI5nqmmlseDKruQLUbxHVJjGl9+okw0QhChXbMh9DQyv9Z8b6IP/mlPswGwyTgfdNyf9hSh8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779256424; c=relaxed/relaxed;
	bh=ELJz6tOBuKE1LJ23ONfI6yuWIWAuaZAH66RoA1RhQJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DYtOaukAn/wpDWvNiJznyYzyujl5Y/yI3TKQzoAxeY1xEjiAkYQ5+ClVs2hyMgEQAOnOSlq/WauHrMPKBwK9NYQwLWQr9YSDbviNpOqyMlINLZI93ZAivyUxFXjoPM8ODkaqLIIwRaw4gaB+CVk+KsRjFqda+K0kMBHr4oaj0D79k4PHCHG9kY6FDmuqQeuNFaDJ+KkkL78XgRmWNSe+VtWnn6I0AWBPr0lFnzKrKw3tILy+cj5DX9HdvEeD3tKa2PC0ZSnHJlmAWIudeAtr62kdIJRck60A0plGU208Jeii6T1AcKmJZm0/0I7xFOTxeZDTcIKfgTDCpc1g/Iw93w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mhXo79Dm; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mhXo79Dm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL11f3QK5z2xy3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 15:53:42 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K0VH0Y3628517;
	Wed, 20 May 2026 05:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ELJz6tOBuKE1LJ23ONfI6yuWIWAuaZAH66RoA1RhQ
	Jg=; b=mhXo79Dm3nMpgbIPjesGbrFw5oTTGCexFEXt+lto0rBGD0S4Jx6xAt1Ob
	93jwOxZNbygFZjs7ig+KCjO/rN0hzE0lpUOcFewgkLrU2OGCyrUKMAiPkfQ7NPqX
	sKZADXe45v//bFrj6tC0WcPMq/3aw2jDlBafbnqaotYbMiTSgv3m3zuQO+H/uFfH
	Y7TqEX1V8KQgytGkzbl1+MVekp+/CNJaC3KU7Wv1cQogs7yrZ24Y6UwDxH5z/HDD
	eYkAxZqyQC+lWEw9SVKCgf3CTOk0pdAdUH1qqIvLcg6n43uktCpWDLY4Mxw2TCej
	Y680Yq/Cd/6cEBxwlkdEub/P0XHjg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6haw7mxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 05:53:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64K5dAZG011956;
	Wed, 20 May 2026 05:53:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75ky5qae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 05:53:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64K5rX4252625726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 05:53:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06B532004B;
	Wed, 20 May 2026 05:53:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EAD920043;
	Wed, 20 May 2026 05:53:29 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.ibm.com.com (unknown [9.124.214.77])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 05:53:29 +0000 (GMT)
From: Sayali Patil <sayalip@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        Christophe Leroy <chleroy@kernel.org>,
        Michael Ellerman <mpe@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH] powerpc/fadump: fix integer overflow in MIN_RMA size check
Date: Wed, 20 May 2026 11:23:27 +0530
Message-ID: <00e9b516b13316f7ce81b651957dad0441e56006.1779255851.git.sayalip@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA1MiBTYWx0ZWRfX15i6pPR1sV1N
 C8r1RhGiLqSHmT2UnlnN7l992JfQws8cnbWAN85PFwqyFFbF9aRvV7ZNBACQA9oFNO7X9SqV11V
 d7/ZkgbgzfwmCG94f/UD0l/athSyig8NkdSUUhIZtY59ImVyi84LMrl9QoCnM9cVfnSyTI0qLJH
 kuhqzUB84C+bLWlD4mSFDPm6mFecCG6/Pf0RLB65h8ad2uIX1fG5wxRYrBxCBZo1raJsfbPPAQg
 IDTwhblTKByYYqtABniU7O+vYB+s2hfT7CB3HGtTAnuyPzCItptjHXbis2YWCE2WSLsonfTUQbM
 Fo+zyNKNLPMpgb/du5I5QpG/15pcyrSHNcmKyG2Ngp8o825ZT/vbtFsVJ+ru3PjBg86ZNsAaC2v
 zwN6Yl8VK7IwHgz3SYoZ/Oiy5LkRSrMapCIlHsqpCZyBwh5OXK9MqEjBqf7yfCF9yQKRRJK3LEb
 haKDBZVxObuNUvTob+w==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0d4c61 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=xEzUMY8hw0MU3VbcfrQA:9
X-Proofpoint-ORIG-GUID: xF8pnIz1dKbxKyu8yaHW-9rNXLp6BBSP
X-Proofpoint-GUID: 2pLTHv-fU7tesTjD6dS34EDljLeOhvLO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200052

The MIN_RMA size checks in fadump_setup_param_area() use
(MIN_RMA * 1024 * 1024), which is evaluated in int and can
overflow when MIN_RMA is 2048 or larger. This triggers compiler
warnings such as:

warning: integer overflow in expression of type 'int'
results in '0' [-Woverflow]

Promote MIN_RMA to u64 before the multiplication so the expression
is evaluated in 64-bit and matches the surrounding physical address
and memory size calculations.

This fixes both the comparison against ppc64_rma_size and the
assignment to range_start.

Fixes: b7bb46062457 ("powerpc/fadump: fix additional param memory reservation for HASH MMU")
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 arch/powerpc/kernel/fadump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 501d43bf18f3..dea7f7105e42 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1759,10 +1759,10 @@ void __init fadump_setup_param_area(void)
 		 * 2. The range should be between MIN_RMA and RMA size (ppc64_rma_size)
 		 * 3. It must not overlap with the fadump reserved area.
 		 */
-		if (ppc64_rma_size < MIN_RMA*1024*1024)
+		if (ppc64_rma_size < (u64)MIN_RMA * 1024 * 1024)
 			return;
 
-		range_start = MIN_RMA * 1024 * 1024;
+		range_start = (u64)MIN_RMA * 1024 * 1024;
 		range_end = min(ppc64_rma_size, fw_dump.boot_mem_top);
 	}
 
-- 
2.52.0


