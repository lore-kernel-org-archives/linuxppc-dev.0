Return-Path: <linuxppc-dev+bounces-20510-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B3FCD3436
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 09:06:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9Tyg29hJz2xpp;
	Wed, 06 May 2026 19:06:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778058395;
	cv=none; b=AjsrermrovVGIB26CN4K19F6SavJeauQ4ZPDl37QFlgGN9RnZCHO+JT8fzgdM1FFE726TUTTq4uFJOA65JipXVQLbFpVH2HfxehQOM0HQ8dBk7ORecdRCkw6MzUzf1R0dhGNrnvNU/D2f8Rj6kjnqenP1zecZcOI3vxy3ZTp+1s29WPO0xILZn4E56KJMGAihGuEpb03CnRaKlSs1eir4bPaBR3dUfpqyPGxemC9C0MuJM1Ns4AZxBqy62wG9XDF5myDH3oZ2NnOvBuhR8v0LvEZcYNp4eS6lae885AI0UunO5JAmAojXlKvw7Tf7SCsda4KpbsL1j/26EoMYbmGDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778058395; c=relaxed/relaxed;
	bh=qooOZb/B2Ompg/B1DlGA3rpHr2gG72y6Bq3BkqGDnjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luuRNsGWFYrERqkJrQ/qDFYtYwZ3rwNL3cNCyzjrMh4DOXaM5ZLjVExQxjQRFKPN8ZhddvtKUXMugBJt2ykfp25COedJycsUlFlRnKNDA+SSFCDOx0lyIDVO0RERydQQ87Bu7LgSxz+gWOOn6dYQZI/UU+qKSc5nOkfBpgN1d1LlBe7WbogFAYf9V4exgbXcOO+V/ITKq5M+8PQfc6+XWBh9L7YXCM4/3wGVNbTLIXewaZihWQnGXEKMKkrh74RkcTcvSyhpWNi8vkufNMqleO+hfP2N33xh7Iq9/lxSF74h3zR7chYRf2dlBEhFbAFh7hr3+yrP6ZQ6maTzvegmwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qxSwRYMN; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qxSwRYMN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9Tyd6pW3z2xdR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 19:06:32 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645IhtKl2752196;
	Wed, 6 May 2026 09:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qooOZb/B2Ompg/B1D
	lGA3rpHr2gG72y6Bq3BkqGDnjs=; b=qxSwRYMNB3jXRpIeMTa7LGmqIJas+LUvJ
	lRFJH7aoxoAUIdGRmaK6mmx0rrFs+ARHPl6HOPAdSpT/c+IX+O4UbCe9NKkzs0Sj
	f8HChYVBnWx3yFS0gI3vu5XdsQvoRnWPBQ9Y348eXPxWCRrg5ReefURdY3RtDs4K
	Q8vgxdDlqtw6Nfo4L9CSD9DW6jw1Uuy+Gu6QGsXW0/VaN+ELG5ed7E6n5pdxFKER
	qPKX4zGbRi8WzyHbm4sj7cVRQE58FEgZ14FQwmrvNK4Szb68moo5u6y9lD9jfbpx
	sp9UMgv9Dl9rEFwLgOt5fUMzz7z1Wm1LP/PreOXfkwUwlnBsMnHpA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4qrqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 09:06:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6468saet031282;
	Wed, 6 May 2026 09:06:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgdb4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 09:06:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64696OKb14156150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 09:06:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61DB22004B;
	Wed,  6 May 2026 09:06:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D202C20040;
	Wed,  6 May 2026 09:06:21 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 09:06:21 +0000 (GMT)
From: Sayali Patil <sayalip@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>, sshegde@linux.ibm.com,
        chleroy@kernel.org
Subject: [PATCH 2/3] lkdtm/powerpc: add isync after slbmte to enforce SLB update ordering
Date: Wed,  6 May 2026 14:36:13 +0530
Message-ID: <4539b61bb6ff2e4fb89e89f760c11714d9ad26a1.1778057685.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1778057685.git.sayalip@linux.ibm.com>
References: <cover.1778057685.git.sayalip@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA4OCBTYWx0ZWRfX0969AEjLd5I9
 pZwDRhH2/H9CX6fF1mYDcR/Hs+hviNB9RZwuJc0PjTk+UNEDANwp3/aEwsKSYgwmyX7nnKl5FaY
 Dd18Ljwcj3b+s8SzGlrGkVyC1mWbFSHPG8g7wYjBDvNRjkT2gDH97DDcrKSpMmbpJwO88QtRawC
 Zt74FGLSkZgN+dypHFnhLaAJXdBXy0QIHXhYC6xVbl+uNqkETVmOa9japrzUV357XikV4FQz9S/
 5tMa7KgZFR3EyCzGdDV++nlRKMTHwtuAZv3vn9UaghiOgCOU98WA08CqhXu+sA9IqNgNjHEfqqV
 A4TYf7OquV1sEzblQENfxNxw5FIa9xj625CuURPA0jBLoYxH+yiGiDF8NGyQ65/C3aXINUvoINo
 tRlAVG6zygM4iSpPzDjn5XP5yo+hNmNDR4mWVEfwcCGGd2L/cxSDNN1jYan8dHqSPNQqw3ZJz3+
 AVD6zwC7RrfaEL8PSsg==
X-Proofpoint-ORIG-GUID: CMX9D9jXvKVn5u_CIba_zCvW4JPIw-i-
X-Proofpoint-GUID: mp04mQzhU-H8FN_c6NOy0rVnx9qpngQq
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fb0495 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=kezLWu8HVOdeeWrntvsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060088

The slbmte instruction modifies the Segment Lookaside Buffer, but without
a context synchronizing operation the CPU is not guaranteed to observe
the updated SLB state for subsequent instructions. This can result in
use of stale translation state when memory is accessed immediately after
SLB modifications.

Add isync after each slbmte in the PPC_SLB_MULTIHIT test to ensure proper
ordering of SLB updates before subsequent memory accesses.

This aligns with Power ISA context synchronization requirements for changes
in address translation state and improves the reliability of SLB multihit
injection tests in hash MMU mode.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 drivers/misc/lkdtm/powerpc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/lkdtm/powerpc.c b/drivers/misc/lkdtm/powerpc.c
index be385449911a..ef07e5201edf 100644
--- a/drivers/misc/lkdtm/powerpc.c
+++ b/drivers/misc/lkdtm/powerpc.c
@@ -17,11 +17,14 @@ static void insert_slb_entry(unsigned long p, int ssize, int page_size)
 		     : "r" (mk_vsid_data(p, ssize, flags)),
 		       "r" (mk_esid_data(p, ssize, SLB_NUM_BOLTED))
 		     : "memory");
+	isync();
 
 	asm volatile("slbmte %0,%1" :
 			: "r" (mk_vsid_data(p, ssize, flags)),
 			  "r" (mk_esid_data(p, ssize, SLB_NUM_BOLTED + 1))
 			: "memory");
+	isync();
+
 	preempt_enable();
 }
 
@@ -84,6 +87,7 @@ static void insert_dup_slb_entry_0(void)
 			: "r" (vsid),
 			  "r" (esid | SLB_NUM_BOLTED)
 			: "memory");
+	isync();
 
 	asm volatile("slbmfee  %0,%1" : "=r" (esid) : "r" (i));
 	asm volatile("slbmfev  %0,%1" : "=r" (vsid) : "r" (i));
@@ -93,6 +97,7 @@ static void insert_dup_slb_entry_0(void)
 			: "r" (vsid),
 			  "r" (esid | (SLB_NUM_BOLTED + 1))
 			: "memory");
+	isync();
 
 	pr_info("%s accessing test address 0x%lx: 0x%lx\n",
 		__func__, test_address, *test_ptr);
-- 
2.52.0


