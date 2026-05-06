Return-Path: <linuxppc-dev+bounces-20512-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBE5CD3436
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 09:06:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9Tyj1V9Bz2xdh;
	Wed, 06 May 2026 19:06:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778058397;
	cv=none; b=WRWIjOGWsIU3onWa8lUnOdp/WsFi+OR1W92Txf+DoSyvCrwnpPMfgPA1a8y1JUBbZCh9d7zwqXVUD/CLvsj1LjMSC0le2W2wGGXL16VGlRzfx/gvIrAO1U+kwfIR8o1FqmPbNBBzSYCjmc0P9MUlI3V4ww03cecpdQXad11dSxEHAkxrGHBH4f91F7NDaZpc5193GKE/Qe3YCsKsxhL+KnkCOdS6NEEBfTF+EJK2DIEB2N4/JbyV0RBb1TH1OqYPuXJed4Tp0uqQbXg+oE7KTwRvmp+L9Z82U8wt2Ugbk/BkM2t850X05E3lEHwc8higB5AO1d0jBX0CZYk94Hl12w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778058397; c=relaxed/relaxed;
	bh=/OX0YmQ91ZbIkTbD/67h5JVJUVNat8e++/RtzSdSmVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hx1BbiQgQoK9rdsexCpBQay94ja5TJ+cNJJ7BlaUWmifjoCAMtcA9vSbfkRrfsZ4O/EoS3xn5SiacxVDs2T8hTS+xF1wO5j3hcQEu1pvG5RhqnLikUJNniPTkcJPUPfm526qLwvZwb2HpzQonfUUQnv/fY/JR7EcKf0lHXO3zZuLOwDJluAOHRFcxkkTuasuYMylaKox+nzSg2WtDrUOWvMKKStEpDwJw0fKgv8cFVm6o1RXBYWtSy1uhbUCXg5df5OWUVGYnZ1q9sZLaefPzWO4IflFPtVyx4q88k91/3GA797WI/ijMWkahtt9mGeSTU7MCJLuh8DTWSmkEFeZnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pBE9z69/; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pBE9z69/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9Tyh2T68z30Sx
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 19:06:35 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645Jkh4a3254680;
	Wed, 6 May 2026 09:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/OX0YmQ91ZbIkTbD/
	67h5JVJUVNat8e++/RtzSdSmVI=; b=pBE9z69/ryRd8l31HNoyCgtZzMk7rrAti
	QELE0LzqNG/EDjZzMbq47rnhQAZzYhw5cTKGhtTOpFhGO29nauIrojY7bO8BEY6j
	edqKVb1PkCv/ZUuwKv7uB5KKkk/IgLewzpaiPnXRd6yHRzly0rQWrkvDRZrJP65i
	a0zhGa3tV0c92lrPyjDC5lwh1ggKWKnqczHw7dmXYdQNvqHDlC6HxedqyCz2MKfN
	GEceHZADyC+DxZdCMayQFCkmTY7/CcqPS37z5Lz6s1g40XSPOyHAHU/ruZj9TrRp
	1yrVhP3nXRCnDXCuLPnotzDntJXXiFaXv0iQ5UkUCk9qSeZfj6hwA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6f7cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 09:06:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6468dZoH014266;
	Wed, 6 May 2026 09:06:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkjwghd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 09:06:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64696Lwe56230376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 09:06:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50C1920043;
	Wed,  6 May 2026 09:06:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEC9620040;
	Wed,  6 May 2026 09:06:18 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 09:06:18 +0000 (GMT)
From: Sayali Patil <sayalip@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>, sshegde@linux.ibm.com,
        chleroy@kernel.org
Subject: [PATCH 1/3] powerpc/time: remove preempt_disable/enable from arch_irq_work_raise()
Date: Wed,  6 May 2026 14:36:12 +0530
Message-ID: <a64fa7d86da51f78743bee26e16ae155c43016c7.1778057685.git.sayalip@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fb0491 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=ES_PRLIWHEyu4WWh1w8A:9
X-Proofpoint-ORIG-GUID: 3Wb57npoFTKTbM3wDPzFmvXjkmZgL2UQ
X-Proofpoint-GUID: dLKAQyOrL7NW9a9Ui_QOPVs6EZvcGSny
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA4OCBTYWx0ZWRfXzktigx1BSbPZ
 IHtLBu/QItIlVMumA4Qy+w3rweontkKbf461YJiWTk6ylknOPLa11FEnwbcSZR3V9WXlkEasQaH
 Fem+F+v9P7C04YfrngaSvsJ8kYeig0nCjfR88B4lM2uoiyDx6SaY/COEYTkKye2STS8lzla5wq5
 uD+kLosauHxIdpqPgdiVjhuIWs25QQx7pKJbOAg+m0YlMA9Sz8ovy3JNpQPhdN66OWkKtAv2Eqq
 NgJiD1HmrcI51L5pIHHWNGvyegTEKB+XzPqISi+Vws6qW5Mw6iFzjaN3cFtORhfDzUEX4juaB4a
 PmCn9AOVXcwm/ggx/tzxG6KV7K3xD128f2UI7gwYqhdLjBEn3ivo/FIUrWYpi2uhVEv/ul88OP8
 hdSCg2GjD26PJ3QlWxNvRQ5hvbBnmFhWh3unFuJiOL+cKeZuBDo3RudQ16jlvj+vKbSSKxObKJS
 Lup+/C+sIIOL9WpBwuQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060088

A kernel panic is observed when handling machine check exceptions from
real mode.

  BUG: Unable to handle kernel data access on read at 0xc00000006be21300
  Oops: Kernel access of bad area, sig: 11 [#1]
  NIP [c000000000029e40] arch_irq_work_raise+0x10/0x70
  LR [c00000000003ffc8] machine_check_queue_event+0xa8/0x150
  Call Trace:
  [c0000000179d3c70] [c00000000003ff64] machine_check_queue_event+0x44/0x150
  [c0000000179d3d30] [c0000000000084e0] machine_check_early_common+0x1f0/0x2c0

The crash occurs because arch_irq_work_raise() calls preempt_disable()
from machine check exception (MCE) handlers running in real mode. In
this context, accessing the preempt_count can fault, leading to the panic.

The preempt_disable()/preempt_enable() pair in arch_irq_work_raise()
was originally added by commit 0fe1ac48bef0 ("powerpc/perf_event: Fix
oops due to perf_event_do_pending call") to avoid races while raising
irq work from exception context.

Later, commit 471ba0e686cb ("irq_work: Do not raise an IPI when
queueing work on the local CPU") added preemption protection in
irq_work_queue() path, while commit 20b876918c06 ("irq_work: Use per
cpu atomics instead of regular atomics") added equivalent
protection in irq_work_queue_on() before reaching arch_irq_work_raise():

  irq_work_queue() / irq_work_queue_on()
    -> preempt_disable()
      -> __irq_work_queue_local()
        -> irq_work_raise()
          -> arch_irq_work_raise()

As a result, callers other than mce_irq_work_raise() already execute
with preemption disabled, making the additional
preempt_disable()/preempt_enable() pair in arch_irq_work_raise()
redundant.

Remove it to avoid accessing preempt_count from real mode context.

Fixes: cc15ff327569 ("powerpc/mce: Avoid using irq_work_queue() in realmode")
Suggested-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 arch/powerpc/kernel/time.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 4bbeb8644d3d..a99eb43f6ce9 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -471,10 +471,8 @@ void arch_irq_work_raise(void)
 	 * which could get tangled up if we're messing with the same state
 	 * here.
 	 */
-	preempt_disable();
 	set_irq_work_pending_flag();
 	set_dec(1);
-	preempt_enable();
 }
 
 static void set_dec_or_work(u64 val)
-- 
2.52.0


