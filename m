Return-Path: <linuxppc-dev+bounces-18900-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7131810BA432
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 06:31:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhrQW0s5rz3bpd;
	Fri, 27 Mar 2026 17:31:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774593107;
	cv=none; b=hbTUSTjOhKISF1qHmaFL7fs4kV7VT8ET8K6PTqJ/XxzyXJwKlpNxVDImFTbsbr2ZZrgTAqy6rDU76nLOmsryLA8EoNckqBchB7LmVp+aSj/ftlLgwSt8+3GrdYEq/thE9/FLimN8q55S3GjfrZRu6gC4IQbYGfrQgklGgBOfJhu+12U1Q5cDn0Pqtwp7FJdwuFjsaJ3h3VQEYXI2Ob2u1XOSqK9n3UE80JCGrg22rSWRLsjdsW8lJKwu2mROahH0XKSUMu9cj3O2qtQ/ybbdtiMY//eYytKlqwV0a0YHMe4gUTKaFxM8YmAmYbRXb6Mvf2qXToVTUoJ2QxntB2/SPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774593107; c=relaxed/relaxed;
	bh=kHrJclyx4fRkw19BdE14EqszEcZdjrvYbNmlBV87tDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6uB6C6teYQJlblwOCwLH4nSrraUrtg9OheENMOkvVtY8tvH5lZn2ytftRF3t8tgrg4Q3drOkbR9UV8IUnRAlSono4Uwyw9+35BNyqkTHNqcTV2bcEY5BigPCBCeekKVIWnHFBSPqY43YN2rYDQ2mri3XV5S7+IjhPnTl1jkzexg8AZWnMn9uwGcWwORpuagrwyQ5TXUNY9AoAczSZs09sMn1u3aJYEoVs2zxg6nyjE5X1XAx0MScKsB+zhgKz+t0kvdMY0bkqBbL4rgek1mHAxrEj63cqwFg2GQW8ylvtMItvzNVUPiFmsOYBFde+GE+yjki1iBpmwC4vU9CGPcSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s9aIYS/W; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s9aIYS/W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhrQT6683z30Vf
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 17:31:45 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R0dvP63395859;
	Fri, 27 Mar 2026 06:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kHrJclyx4fRkw19Bd
	E14EqszEcZdjrvYbNmlBV87tDk=; b=s9aIYS/WwTcrgDLHwJvSy6Il3I+5K6VFZ
	UZRKmCuepQnTaUflnwOGXRvk7BA6cA1NbzZsWVVZ3Gxxd94f4ZBZFHvar4q6ONXj
	itBMvtyEbqEtQk1t8RR/wV4Ek0J3wSzPEpXjDVrzIV6NiNQxFwEFP5Ez3YN3pr3q
	im6ypLawQrAWjRpWCfNEPSESt9sR1ZZ1eX5K28CJwoCHuEyZFslvlne9P72OZGGB
	0f0hh7JuSumhG1ubys85N0WFZiT6LvwUKpd3mniMAgLkyJL1CM7NykovRIJ0sj2Q
	usScNqDQN6X7MMXHkB5DQtXFpkZkrjWTxws4eSe9KLNL3CnriJzzw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky0fmfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 06:31:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62R6KhbQ026864;
	Fri, 27 Mar 2026 06:31:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275m67mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 06:31:40 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62R6VaOd56688938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 06:31:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABD8D20040;
	Fri, 27 Mar 2026 06:31:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA6CE20043;
	Fri, 27 Mar 2026 06:31:34 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.223.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 06:31:34 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, yury.norov@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org
Cc: sshegde@linux.ibm.com, chleroy@kernel.org
Subject: [PATCH 1/2] powerpc: Use cpumask_next_wrap instead
Date: Fri, 27 Mar 2026 12:01:28 +0530
Message-ID: <20260327063129.127302-2-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA0NSBTYWx0ZWRfX57huGs15JTeP
 ZFGIYpmg+s/AvKciXdjzj4rhCFhpbTofkyK+kNQ5STy5tw+g0I2XcmCCBrMMxof7gwN8ISZRvu9
 nmna92Zh8cmbVgTCgcEBwbZoLrQ2wLibDeTe20z35gSjDWsoPuafKisQM1el/HDTwpaOoQoHS/S
 z7oronkceJILZlQWdKYaf+jup1+LzFzonznE/HvlKkvDu1S+hJ3caqIx1bO89QXOHfivpLveNRW
 oJwH3DIhLov+nepx+G7KvtFt4Zvp6LjpAPaBtoUd1AwDT2HW8pliXxuS57Xm+D7Dt+Kkb2uOmfD
 CcXey9Tc/HzwQaap8+5aKyMkSyNINUuT8qCiekbKAkoJQqqqBH3pUWgXOv76cacR1kQDqFn0yau
 F+AvHhuhvJX6fyCCQORXMA8VUY96xxPcOwWH8HiPZuNs83u9FlAJdniJOZD5XEGZj7M+f03GOqI
 0gUZzayOlcw0dqCZ6pw==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c6244d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=YLC4c4OjlnaWLdeJtCIA:9
X-Proofpoint-ORIG-GUID: xWL-AQGo3JNpyvPANPYgRB6HsqVJhcjx
X-Proofpoint-GUID: 3hADKyb82NFO8Nnbgqs5BvejbwVgLjIw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270045

cpu = cpumask_next(cpu, mask)
if (cpu >= nr_cpu_ids)
    cpu = cpumask_first(mask)

Above block is identical to:
cpu = cpumask_next_wrap(cpu, mask)

Replace it, No change in functionality or performance.
Slightly simpler code.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/kernel/irq.c             | 5 +----
 arch/powerpc/mm/book3s64/hash_utils.c | 4 +---
 arch/powerpc/sysdev/xive/common.c     | 5 +----
 3 files changed, 3 insertions(+), 11 deletions(-)

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
diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index e1a4f8a97393..b6446abe29a6 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -577,10 +577,7 @@ static int xive_find_target_in_mask(const struct cpumask *mask,
 		 */
 		if (cpu_online(cpu) && xive_try_pick_target(cpu))
 			return cpu;
-		cpu = cpumask_next(cpu, mask);
-		/* Wrap around */
-		if (cpu >= nr_cpu_ids)
-			cpu = cpumask_first(mask);
+		cpu = cpumask_next_wrap(cpu, mask);
 	} while (cpu != first);
 
 	return -1;
-- 
2.47.3


