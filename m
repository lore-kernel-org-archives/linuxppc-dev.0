Return-Path: <linuxppc-dev+bounces-23316-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676C9C43602
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 18:28:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gr7n85M8Nz2yf9;
	Thu, 02 Jul 2026 04:28:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782930508;
	cv=none; b=cx81b9FGz1ulwKWDb6JveFKHPr1o9adxZCon2a679W6rxk09jgKFcU+X3xxeQCpyXhLXJLqQEiwvaqbxhRx6thC+gAarlo2sEHOaIrvJKbcbzYyPPV3la3mXJ5pUWuo2tXXkB2EMNfg7gmGRQ2MLwKvaO/Ytoe29ta42nKtBQpRwZpBfe2DzFDpGriWxYQuVOe7Q8EjA/3ULKEFVRHeCKFeh6GoFCpKfvV1x6MnEsvTjT43ay7ffxe0NwoYcHC1b4L1wIqhtXOo1N9nHrqv5vvd5+fEK4UbeOLXE6Qle6TSWZWvkBrXuZuG4QY7S15FkF2Wk3+QCVNJIWc8pUpXzyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782930508; c=relaxed/relaxed;
	bh=X1klvz84/JPFyQwnyXVxQ/9oD2qFvCehPllIpI6WRXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZLe6gql5Gk8bEn1dLpQgA38qru/hrQbfh2OyfmXzOV9HSb2KlYo2Wjn2W0FEzkf0Jw0zPKXJRJEMGkNj/sUs4eN2lEFFS/3wgSf52XDou2AQdhEE0RBWfmIBlwYLAaS49ihz87FSHAkq3JFoJ50haI4ys0x5E9yt7fCGmJN9h/V1ZAcsAB77ioQqUjR1Mr/a8F5ycpggYxirGBrBvGIYIP71C76lK0oXeCsIZLnGz6h3CBmWVIwKWvziEBZdzLrjB8JPhD9Ppm79rxuKBUzXI+yGlW6OdiDJCVP9YTSVw4UZJaS9cELykcg7bI3F9N7VA3cNY+BOkzhW6v0FEgF2kg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JVE5sDsd; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JVE5sDsd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gr7n72m8cz2yS0
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 04:28:26 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661GnEDl1296133;
	Wed, 1 Jul 2026 18:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=X1klvz84/JPFyQwnyXVxQ/9oD2qFvCehPllIpI6WR
	XI=; b=JVE5sDsdyqPa1m97LdLPzkbIG4Jh/gnN91X7GcUeIgdmvq+azJowa76/m
	GZHIWgBqbRXeOUJrjdu06X+c0Zwek7f4KLMD5lu1JEX6DVGkY/cr6F0Sxg6NgbYx
	kcGKj8egXZ4KG9kG5yNIpUMv0U3JA0j/g+stYy4HEojCqhBeWPkLOKUxjPiDYaM0
	yK+WeRqSHCdOwUNlXcGoHT20QdF0tfdtIWKG5Ni7AM6+Xb5KaLmb/OUkZ/+eUYdk
	v4On+V2M2KlvYCD938nh+FkqUnquhRRuIJYJLyqc490ij++212kZtN3JIF20dkE6
	GQRfzAMa7uSRvbf7XRImtGG19leVA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjwrdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 18:28:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661IJjZT010272;
	Wed, 1 Jul 2026 18:28:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhygbm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 18:28:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661IS9rv59572546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 18:28:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96B3020043;
	Wed,  1 Jul 2026 18:28:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33AD820040;
	Wed,  1 Jul 2026 18:28:05 +0000 (GMT)
Received: from li-609d1fcc-36b3-11b2-a85c-cc82146838dd.ibm.com.com (unknown [9.67.145.84])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 18:28:04 +0000 (GMT)
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, adityag@linux.ibm.com,
        mahesh@linux.ibm.com, Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Subject: [PATCH] powerpc/64s: Clarify copy_and_flush() cache sync loop comment
Date: Wed,  1 Jul 2026 23:57:56 +0530
Message-ID: <20260701182756.273019-1-nikhilks@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE5NiBTYWx0ZWRfX+XtCNfIyo3xx
 l+MsbHy5P+9LjDeP8tR8dtoNHYKkyTb8rLfzr7u7+kEJpxisC1MyFhKQ6+1FvKIliulk7Ax3ZCM
 9tBZzEbJ3UMGQdiA8nbchqs1tH+nC/lsQ5w3f8pFy18ZnGo0uLXd2uZcZbccR1GSx241vKsCILC
 w2sMk+PooINEOqvYyARG+t5Ai3z3j5K1L/pp4IKp5oSy/lA6154toCoPbKzEQq87hWSFlzquXQU
 zbMqMkAi96oyfC9LwzEtcI6SMXLQMUXtY5plYDnD5TZ2LsY8ePNK06RXTteR6XYSMjxguFwk6cH
 Qm7wJkwSgZFC+rW9u3L4BGnvl4zgOSnyukFwcDXrhhpykpeQxJkuvs20XEEAlMSsljGUGpGdPdt
 ZkbJLRsUInsPRBZYSi1NMwn2RllFlSPkfegO0WlFo+YAnhcSdqCgXuJZkk68PmQt3AE8eim5MAf
 yL6NhYTiJGCts/FlM8w==
X-Proofpoint-GUID: K0vve0lmVJ3AQP3hYkme8l_AqZX_fK6J
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a455c3e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=EMOAY_goFwyYI0LnCuEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE5NiBTYWx0ZWRfX9K9z8Aj2WDpe
 bRYk4g7qiWTW8t/u1QkP1yfxYeR6ptDNhNJW1CTJbMrzhSnhp3S3sfmgxPdsghNib2TCrBiCVON
 NsM30pNXkHkftVLkOK0E2IguRCnvXVw=
X-Proofpoint-ORIG-GUID: lv69R5Hprg5FOucFlqhATlf1mwugKa84
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010196

The value loaded into r0 in copy_and_flush() represents the number of
8-byte words processed between cache synchronization operations.

The existing comment refers to cache line size, which can make it appear
that the value is a cache line size in bytes rather than a loop count.
Clarify the comment to explain that the loop processes 8 words (64 bytes)
per cache synchronization iteration, and that increasing the value would
skip cache maintenance for intermediate cache lines.

This is a comment-only change with no functional impact.

Signed-off-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
---
 arch/powerpc/kernel/head_64.S | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 63432a33ec49..e21c2bce8f7e 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -713,14 +713,14 @@ p_end: .8byte _end - copy_to_here
 _GLOBAL(copy_and_flush)
 	addi	r5,r5,-8
 	addi	r6,r6,-8
-4:	li	r0,8			/* Use the smallest common	*/
-					/* denominator cache line	*/
-					/* size.  This results in	*/
-					/* extra cache line flushes	*/
-					/* but operation is correct.	*/
-					/* Can't get cache line size	*/
-					/* from NACA as it is being	*/
-					/* moved too.			*/
+4:	li	r0,8			/* r0 is the number of 8-byte words       */
+					/* to copy per cache sync iteration.      */
+					/* 8 words * 8 bytes = 64 bytes. 64B is   */
+					/* the current default cache line size.   */
+					/* This is a loop count, not a byte       */
+					/* count. Increasing it will skip         */
+					/* dcbst/icbi for lines in between and    */
+					/* leave stale instructions in icache.    */
 
 	mtctr	r0			/* put # words/line in ctr	*/
 3:	addi	r6,r6,8			/* copy a cache line		*/
-- 
2.43.5


