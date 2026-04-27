Return-Path: <linuxppc-dev+bounces-20141-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE8FFF8860
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 04:47:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3rfB2Mx5z2yr0;
	Mon, 27 Apr 2026 14:47:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777265266;
	cv=none; b=cE2Y3DNaEfwFwu0qGXQ6darLzJlu74ILdbBiPnYj2Lql37RnsaD+tBIFPq7gORc6ipSWu1Sle63aLfh/SpgE2A4RPSqOUq/qGGwS1ZD6q/AoGrnEMlcYIpBvNBy9uzX2U2LFW1l1eFEp5/aNtlIai6s3o+TFXLqcFQV8/W8HPqjvdxgyktkP1q5rz3HDySjZUgoYup+z/4gyV7WjzvwQxcKeiS7026LWyxBvT+nqq8cslqhI3RGk7PjLzUzd24I7WTMpQayAjROkOm95KaJEnk8wiL1I8/afGKQEOGS8DYqnvTyQJlYQkFKNMSm9r2DHp1LNEBAB3Ebqk9HIqK3K9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777265266; c=relaxed/relaxed;
	bh=78ndu7eUGmfubw6W2rI7Ewwj6YgAOPRj8w6DmpeRpfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKcH4QSfOqR+QEnnwOFiLxJdCza4Wh2jvQU4aBZA36pymNgMylOCDyycsIB1Kj5M+429lHW7bBvOWxwgqG/X7s8XsigKo1SioF7+HW0MiaafUdkc9tjR4FjdIUbGYB2QX4C4PQzTr546Bwq9GydjgK1kFIyxu/FF7JmM4fmeNKBaRWFibMefwC0rbDXFPvu9uCD5rRNnooLhBGmB4RrG7D9Qm14NOAN8I9t1cIfhfMaScqwig0tydD2lfbPJx+QQ4+0d6D9PE2qKfwm+JbBTSL7jfU0tspRez5ZoDIxWVHRrJ3+qPL4NFg/UO5aWoVrRs8Az2lyZmSi7zZ/8iO7Llw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JClJBrDx; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JClJBrDx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3rf93GqPz2xlm
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 14:47:44 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QMtHx33309760;
	Mon, 27 Apr 2026 04:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=78ndu7eUGmfubw6W2
	rI7Ewwj6YgAOPRj8w6DmpeRpfo=; b=JClJBrDx7iaNQL7iytYQRQgG1BKSvgpV1
	K6yBDuQGvhW4OM6n121G1Jns4ENXzI/5lDnCht4fdF4Sm2dDhkzjrL/dylOv8myc
	9ebLQDoiH2YR3rPRDICcBSPNIe/yxR7xB6a+R2rny6KT74QW4+CIkOVGm9h/ELnl
	dinWebx+z9pX6Yx5KS36ZiL1Y/PGiR/DZh62fFnojdsemI61q9dxYL6rkAAk3dhR
	eMruoLUAW+KSJd/X3EuRKqApOXcAIAbqcl5H7sTCwF1LjmHeXihh8o8U9v9luLL3
	KYCgTAAfrQLtQHvURpoupyfHHVeHrKEze9Wt8i2tcY+oX25+ynBZQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1je71t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 04:47:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63R4ciPW017055;
	Mon, 27 Apr 2026 04:47:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5g3h0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 04:47:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63R4lYpc25100718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 04:47:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5625720043;
	Mon, 27 Apr 2026 04:47:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B76620040;
	Mon, 27 Apr 2026 04:47:32 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com (unknown [9.123.5.233])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Apr 2026 04:47:32 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, yury.norov@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org
Cc: sshegde@linux.ibm.com, chleroy@kernel.org, Yury Norov <ynorov@nvidia.com>
Subject: [PATCH v2 1/4] powerpc: Use cpumask_next_wrap instead
Date: Mon, 27 Apr 2026 10:17:12 +0530
Message-ID: <20260427044715.559137-2-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260427044715.559137-1-sshegde@linux.ibm.com>
References: <20260427044715.559137-1-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA0OCBTYWx0ZWRfX6Wg8xyUMudNR
 r1AHEBiMNDups3u8EhHWs9cvL7DthLLU1z4FL9KyRVLnlNeRL5rzw5cAZqZcMD1zNrzWlNvIwEZ
 DUhEdP4zlfW5V6e/mny6+bgPjiJOf4m/nKMVOFcppa3ADS2I+3rLjzH5xMId8O1ZGt6xCiZl2Yw
 roDs/IMfzMBYK5QkwvG2bX9M8wi3adhbexXBrIxhd9BRj7kBt/hjt2tRFdn+ryBUARKAHRoLIwY
 SQPYcIGEnfobZg1qne85Q4pHURb4J4efhBL93w1tXBsaKA7jdte4a14wbLkHZyEeiVuiO7QamYO
 lUBYq9TEbDDuTFLga2geR95S3qhyt6dKfT0cd2pbyWkqqmTPRKNW3O15aytFPWAneuhSbIBNe5N
 w16ZRsbsHS9scIQlRl4OfKUUopTal/tO3z5hva8vkV8JW+5dt8jHAUwi5/yt3o8h4fJ5xk2EPdO
 L6oh0lsR7W/EsfhlcBQ==
X-Proofpoint-GUID: KFXTZrPnqT85lnGg5SS8bjLHyT-drC2b
X-Proofpoint-ORIG-GUID: UkwPpNIjt16_QiddZzAt1P3xPH1XlK6E
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69eeea6b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8
 a=ekXyIRwq0AQAqslM44EA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270048

cpu = cpumask_next(cpu, mask)
if (cpu >= nr_cpu_ids)
    cpu = cpumask_first(mask)

Above block is identical to:
cpu = cpumask_next_wrap(cpu, mask)

Replace it, No change in functionality or performance.
Slightly simpler code.

Reviewed-by: Yury Norov <ynorov@nvidia.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/kernel/irq.c             | 5 +----
 arch/powerpc/mm/book3s64/hash_utils.c | 4 +---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index a0e8b998c9b5..f69de08ad347 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -370,10 +370,7 @@ int irq_choose_cpu(const struct cpumask *mask)
 do_round_robin:
 		raw_spin_lock_irqsave(&irq_rover_lock, flags);
 
-		irq_rover = cpumask_next(irq_rover, cpu_online_mask);
-		if (irq_rover >= nr_cpu_ids)
-			irq_rover = cpumask_first(cpu_online_mask);
-
+		irq_rover = cpumask_next_wrap(irq_rover, cpu_online_mask);
 		cpuid = irq_rover;
 
 		raw_spin_unlock_irqrestore(&irq_rover_lock, flags);
diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index 9dc5889d6ecb..e4fcf929cb33 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -1299,9 +1299,7 @@ static void stress_hpt_timer_fn(struct timer_list *timer)
 	if (!firmware_has_feature(FW_FEATURE_LPAR))
 		tlbiel_all();
 
-	next_cpu = cpumask_next(raw_smp_processor_id(), cpu_online_mask);
-	if (next_cpu >= nr_cpu_ids)
-		next_cpu = cpumask_first(cpu_online_mask);
+	next_cpu = cpumask_next_wrap(raw_smp_processor_id(), cpu_online_mask);
 	stress_hpt_timer.expires = jiffies + msecs_to_jiffies(10);
 	add_timer_on(&stress_hpt_timer, next_cpu);
 }
-- 
2.47.3


