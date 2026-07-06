Return-Path: <linuxppc-dev+bounces-23591-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAF8C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 08:27:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtyCR0YVBz3bps;
	Mon, 06 Jul 2026 18:27:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783326450;
	cv=none; b=mJnxw8qLPUwIIJM9QlPG0qclhxou6qRkD4RkGwohF87Rn5YPRp+9vSbQiQ8swoKUT7GTvZ5TuXHDdnrkaypPhkxTPUxAK19tAJ4UbbYL62Ae4io0mh7W3q8gy7j52gYKMBSzAgkTEJmW1txg3Vboe0xhi7uAYNgYXIvI8DjglA4AhC8Ck283FAA45/Mgd/TYXcj0yDnrxX0J/+O6D5ncP9X4XtpFJoiIWEL02Bhrij8t1P+4GSA0Y0an9hM0XfFKva0+7m89bWZdo44SC98yhUtBVvtLzneh2FpZxJ3OmzPZrXnyEAZjgbw2cvVYYXWtdHRl1msRUdOT17xcMWWRqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783326450; c=relaxed/relaxed;
	bh=NO6QizUZ6tNcUzDfp55QD4Ju2fz7WAV+UcPFNlRRI1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSq8ChaXD0hhYqBylsc2oTDXwwKeXzmyFuHLppaiJoCBNg5j8tcFlRdA+RHTd1gdtf/2jEHC5/hTSXYTSCq/qMB0TcP3w6vFU5oZmeQU7jmgo24PZzN1RvFHkHvtwBeU0h7tVCZy4+HI5cm0AeF30maruF4hpAFUj3KKRo9+0KySz9uY41nuu8zdEH4+9VkA/j7Boq6afn7CqkXccyO2PpYrrIDk4acsYlThU2btr02xZMR1pKj5s6XvLZmWK0aohhrnZddzMP/p/u0NE/V6WUgcTcYjVsOHJom8tBGYxC/gUH4qbhjjKRas/wvc2itBkm6H49l9RasDHn+yuoCfRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=q3qJQroq; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=q3qJQroq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtyCP65mNz2yT0
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 18:27:28 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MJZ1M1499728;
	Mon, 6 Jul 2026 08:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NO6QizUZ6tNcUzDfp
	55QD4Ju2fz7WAV+UcPFNlRRI1g=; b=q3qJQroqvadHMnCtJLlMq4htAoklRIoeb
	bLJezDGlLpnUlG5Dtq613ZWd8N0buqgoTTfkPbWnG0YKvRg1ju7FfUD5qEJrSnWe
	jFAKygBPwMR7TXuu7r36HbTKmsfaiFzlkNTWteJHiNO++Hecyv3FFJaaVYAG98K9
	ke0wMyjZTr0lSf8XB+rgRxHOURvK0P0zMJ1XNoNWZHhtw902Y1cNMxNkHomAzMfF
	67UOvsxOjWjeBUkptqjqB4lis6LUgzbDlGJUw8JTdiwYEujvXH9swETLdZ3tip07
	WUBgz3NZjM7I5AecBeedYR4ln6vXTzDDCa7k3QmfKB79xV6H356jQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsgyba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:27:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66684f3S024522;
	Mon, 6 Jul 2026 08:27:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfvgps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:27:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668RDTO49873352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:27:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A71B22004B;
	Mon,  6 Jul 2026 08:27:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57E0420040;
	Mon,  6 Jul 2026 08:27:11 +0000 (GMT)
Received: from li-609d1fcc-36b3-11b2-a85c-cc82146838dd.bl1-in.ibm.com (unknown [9.123.10.251])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:27:11 +0000 (GMT)
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mkchauras@gmail.com
Cc: linux-kernel@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, adityag@linux.ibm.com,
        mahesh@linux.ibm.com, Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Subject: [PATCH v2] powerpc/64s: Clarify copy_and_flush() cache sync loop comment
Date: Mon,  6 Jul 2026 13:57:08 +0530
Message-ID: <20260706082708.43918-1-nikhilks@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701182756.273019-1-nikhilks@linux.ibm.com>
References: <20260701182756.273019-1-nikhilks@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: zt5-GowiQNmNqbXcpvdrLMACwdKr0kee
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfXw6P6/sdf4SPM
 OIe37qPDx+zDfSL4k/whmmIjW+0ekgd40Ear/BGEHZdFs/xjzvCv1e2S/XC/onM81do3YObDMme
 lO4sNx0089dHSeZqbui9hQREbf0BFao=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4b66e6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=EMOAY_goFwyYI0LnCuEA:9
X-Proofpoint-GUID: ZniIbTu-OUuwlMyHTG6AXcOW3Rs5DHYc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfX5vhcNPrNU9O6
 s5oATm3xCVq/ewAeJFTpuZFv680Y+HA1hfDt+7lop8O9wJCiYzq5GEX/KXtRcA08nIvWt3EQ7yb
 xkamnsnKJfPAb+D/jMKvIv7XiFTo8//XtwJiJFNHPmgGKM9JAdrqxyHXnYGB2OXC2vLLFpaf7Wg
 HWEzzqgUV+tNTFWN6plhGhE9NRyQ2HLxAoejT4cCtb2IK0pzmXfrQP0R1ECC71OLv1zweg3sXzr
 y4plPAHbyuxQYzYwKAj8KUt2B69MLmShw+kxBAFGveK22WEyQLHY4qv52rrTrrcbmpGMZQd11n9
 HJOA1rYLMUrR8wz20wqKGqujTkrzG7dH6vT8Kk06MEsyJIf/CH84diu7H/IB8ae1O3xyp6pF31L
 9WUGNIFsKNp96DRArNibMqiDQkW7PC4TB4uEIjzDNuRVzXSLmhc9m7/NtEyGBg2UEXPNwj9Err+
 /oZMfmcA6m65Q8mva9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060083

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
 arch/powerpc/kernel/head_64.S | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 63432a33ec49..a54f6f979173 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -713,14 +713,18 @@ p_end: .8byte _end - copy_to_here
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
+4:	li	r0,8			/* r0 is the number of 8-byte words	*/
+					/* to copy per cache sync iteration.	*/
+					/* 8 words * 8 bytes = 64 bytes. 64B is	*/
+					/* the current default cache line size.	*/
+					/* This is a loop count, not a byte	*/
+					/* count. Increasing it may skip	*/
+					/* dcbst/icbi for lines in between and	*/
+					/* leave stale instructions in icache.	*/
+					/* This results in extra cache line	*/
+					/* flushes but operation is correct.	*/
+					/* Can't get cache line size from NACA	*/
+					/* as it is being moved too.		*/
 
 	mtctr	r0			/* put # words/line in ctr	*/
 3:	addi	r6,r6,8			/* copy a cache line		*/
-- 
2.43.5


