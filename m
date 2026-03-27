Return-Path: <linuxppc-dev+bounces-18901-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FF210BA430
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 06:31:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhrQX5TjSz30Vf;
	Fri, 27 Mar 2026 17:31:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774593108;
	cv=none; b=Z7xvYl06io2URTjb8eR4mj9nXrjCbpTH9n9m/dYoxW9k1RYg2yInMkp9LvYKkWzhkw8W6uGPFblYE3nz4N19+CvwEGlhHTeP/NZwMdpCQDqOAEa02bUBKOh7uEWLhuR/+sg80ckz3/DkpdlZ6e4U4K+1M2RVQbSP4AV0h7BaT2Clw5Vcz2qbSfZUpIpOWYNJneW64W/NGdjKqYTrFeMQPiw7AbrQmHBl+UI2HuUY/XJ8/wWxP/zwR3KNh0+5d0XsyF1s+OFIVXUBVE9Xt5LW+HfKFGJOLLva6dQfWqCs/hoiIf7iaQyyIuY10dk9xLUXzOmn2nXuGKW2IWdeOuAukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774593108; c=relaxed/relaxed;
	bh=MG0gLMgXk4Y5PYCyEgHMY4ig/D0i/qmvbXdqch/lFT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNVG9WbgcTs8D/z14vMD5GAA5E47SR97xFMiGeACpLi1jfGX8a844Pukre5qQnmNM78EqpW0HsYxiqHo3xazNS84bYrug0YGoyuzO/B4LOTxdLpQIiRwVw+Wfg494iwC7uVLhD44yBbYJMkdbl6GGqgLV/eBL4YkmgJifra6Ir/ol08fChG/P0EsyTkM0KeanuLrzbhYMkjSgPAN+yIiMTDxFPjYU6w+od+W48akmd2JcUszUXZyPwbkrYYlqPnVQ0L3Ite7TcUqoSJnFuMxFH7udZM3vVBhksoy7q60DUZpNV3lrMTQr/MPCI8ElDVR5mp11R42G13k6wx8cLaxYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Vh3N73zM; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Vh3N73zM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhrQX0cz5z3f99
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 17:31:47 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QIdYfi2755971;
	Fri, 27 Mar 2026 06:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MG0gLMgXk4Y5PYCyE
	gHMY4ig/D0i/qmvbXdqch/lFT8=; b=Vh3N73zM3wu5IVf1Ld/q2ffoiX/ykVJfS
	6bfxIwrnldUZ8i+Wdmze98oJggbTYuv1c1kxmk2iy1awpHy5xo1JNDxjHCZ7cjyR
	pS8HVkBqDEQUWOmCR9Hv82oocoZ0z2nz24jUNqLZQ99X5X8S3NaXQLWWLmLj6nJt
	P+kRrSq0NZ8jINpbUHUJYkfJAWkrpSLRSJM8w3rlVWhCAcqmUR+lsMiSstwARweR
	JuB2/jGOn9ruvlaixyzEAvThIc8HdxaMkhRegIe/OkwVJeUqRyNq5Emhwsg1SfqZ
	5dYSz/0fjMJUKbdNCpHkvWivj5DiGycYgtZAkfnUU+NdMuBBIfHWQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumyrp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 06:31:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62R6NHwa008732;
	Fri, 27 Mar 2026 06:31:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnxang-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 06:31:42 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62R6VcsS51577288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 06:31:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EAC72004D;
	Fri, 27 Mar 2026 06:31:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01BE620040;
	Fri, 27 Mar 2026 06:31:37 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.223.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 06:31:36 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, yury.norov@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org
Cc: sshegde@linux.ibm.com, chleroy@kernel.org
Subject: [PATCH 2/2] powerpc: Few misc cpumask code refactors
Date: Fri, 27 Mar 2026 12:01:29 +0530
Message-ID: <20260327063129.127302-3-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260327063129.127302-1-sshegde@linux.ibm.com>
References: <20260327063129.127302-1-sshegde@linux.ibm.com>
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
X-Proofpoint-GUID: C2tF857s3sQbM-YVNdfDikMNihNPWZUY
X-Proofpoint-ORIG-GUID: L-A2DitEj_39Y-BNmfrcU4Wr2z7uC6St
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA0NSBTYWx0ZWRfX8RnHgLGvt73J
 CNkWt21gg+e3e9wb7JYk3IPnfu84IsNiE8kXBr4Cp23z5jSxL1WJyJYY3vunC/RZO8bqVLZwSAF
 87g2RjUu7AAkkXbcuwAB4rX3JTrpOG8gT/qN0kxRb2P6EL1uOQuEKnfDwz1geiUoyB3Ff40NO1V
 R+lQ0mL8pmhD6Ue7DRyIC/v2NNbN7UX5TAHo1eN5SvDj5qppNhmRkl1wCXZSO9fZ1Oxt0MM/bdA
 zezaqXAr23x2FzFnEGgdfEmxeclyqgYb0AOW4cP8mcpTUnNhuumY7G35atq+Q9BpTN/6/4fFm2l
 BITDc3RhP4K6BYTTSEIK1uyTskhNiQkXMFHX10j4fL+xboxa4Rx22N3vNDMnaV6mnaWfHrtKGJ0
 VruLRhbvpwNp9957sC5cMPOEcwtFi7T55LKBbdk3da3adrRwCUIuudLZ8Lf76hI6gSCwNZ6QguW
 Z4rrhidjs5nKFukg36A==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c6244f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=eCrYNZafU3mwZKoKmgAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270045

A few miscellanous changes in handling cpumask api's in the order
they appear:

- cpumask_next(cpu, mask) >= nr_cpu_ids is used to determine if
  cpu is the last CPU. 

- cpumask_next can take -1 as valid argument. So simplify cpuinfo
  iterator. /proc/cpuinfo shows same info with patch.

- cpumask_weight can't be more than nr_cpu_ids. So remove the pointless
  comparison.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/kernel/setup-common.c | 7 ++-----
 arch/powerpc/sysdev/xive/common.c  | 7 +++----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index b1761909c23f..47215eab296b 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -323,7 +323,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_putc(m, '\n');
 
 	/* If this is the last cpu, print the summary */
-	if (cpumask_next(cpu_id, cpu_online_mask) >= nr_cpu_ids)
+	if (cpu_id == cpumask_last(cpu_online_mask))
 		show_cpuinfo_summary(m);
 
 	return 0;
@@ -331,10 +331,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
-	if (*pos == 0)	/* just in case, cpu 0 is not the first */
-		*pos = cpumask_first(cpu_online_mask);
-	else
-		*pos = cpumask_next(*pos - 1, cpu_online_mask);
+	*pos = cpumask_next(*pos - 1, cpu_online_mask);
 	if ((*pos) < nr_cpu_ids)
 		return (void *)(unsigned long)(*pos + 1);
 	return NULL;
diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index b6446abe29a6..91dd3b364d7d 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -548,11 +548,10 @@ static void xive_dec_target_count(int cpu)
 static int xive_find_target_in_mask(const struct cpumask *mask,
 				    unsigned int fuzz)
 {
-	int cpu, first, num, i;
+	int cpu, first, i;
 
-	/* Pick up a starting point CPU in the mask based on  fuzz */
-	num = min_t(int, cpumask_weight(mask), nr_cpu_ids);
-	first = fuzz % num;
+	/* Pick up a starting point CPU in the mask based on fuzz */
+	first = fuzz % cpumask_weight(mask);
 
 	/* Locate it */
 	cpu = cpumask_first(mask);
-- 
2.47.3


