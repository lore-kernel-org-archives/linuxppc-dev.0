Return-Path: <linuxppc-dev+bounces-20833-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CB1CD4F35
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 08:14:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFmTL4bbPz2xn3;
	Wed, 13 May 2026 18:14:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778660070;
	cv=none; b=KDIYqppyZrnTy4wLP3RtwSBU5VLnjsrTO3s1foM0ogUgqA5gbZHC+oYjUHafiKC1rrblamJgJDVCoqL9ojpXJp4JRvS7BeaM84/DPAZSBZzrLBnjFLM99hBQ8bqldgyswYQpWwLU+PnmKPcPJ2JZ7xUzMGfJdpQNpzLkzmzs5k5glK4dRG5YRy6VbEJuvEgbp+1VN44OAyBe+YJ13PVCwLITvaQtYn51jMeWHp+OvFX9k06AOS+dSQn8o7jbc3EBWaTDIzad39rLxXdEfU4BelLnhBQlNjZFAhPMSdySAVNdaOwnqg7/wSOPTemBk6GgDwf8nRtPM3BSRtZR59SNaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778660070; c=relaxed/relaxed;
	bh=5Sa3ADqpLBhgK6Pz8oYquXRH4ULvlnTgyvk6V0MBOvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dSpIVBegXVN8xferyOhthrw3AxfG6NkROYF9d70ENxhKOLbnyVTxPK06WX+WIn78zUP8VyayQHs87rMNal0vhtdpUBI11DjyF0RbAElQPhgXt2uh4Ffu+vQ3qZexSE2dMNqcvVcbchp68yA10wtR4nDDOZG2LjHaejLNWd7SfAOfN3mFHmOIFpRCHPtI1ujRU8YFY7t4JCsTUxiyr7ky2MjiB9Xs0VHrgAGC26CynCNdAzkiNH/Ibk0Ixm8pyGr7AgBj3UmOpneghb/FtPSPXKcSqu10k/Oe/HjH/ucDlt0aBgHxIHfPuDvbU/f2ZkmqBQU1h5ZBNIndPhU07py1YA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tAC5oq/N; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tAC5oq/N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFmTJ5KpGz2xlV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 18:14:27 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D2K3nv2611655;
	Wed, 13 May 2026 08:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5Sa3ADqpLBhgK6Pz8oYquXRH4ULvlnTgyvk6V0MBO
	vA=; b=tAC5oq/NGkhHDa+1JgyKJR763dD97wfcFtVVH+ndiIjMqbpS5QZl0aZ7h
	84KNWnq0xYfK0xVnN/X49ES/AiWIAtL2SHZBMvYsfmNtGpsAJGLR1K4xIEVTPBk+
	vnSmdvSzS4w88jG437s1WnVRxLzU3xrW5laKwfdL4YmVAQIga1Z272ffRTEXzJD5
	cEku10lLjFaQiw1kV0LeT6Y3Lav7iFYv7oLeurll07KBgmqiUpcj+QO0QczfgcjD
	iKBV0FLaNsjjq1hdepu+ZAJSMI/TaBQglEc2d+blElQPSeW+Jf1hvNwjDeFUhse3
	ZQWfJOyf73OlP4EGcV+k6OSNgii4A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nvdxrr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 08:14:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64D89MrY012526;
	Wed, 13 May 2026 08:14:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgxwfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 08:14:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64D8EIEZ57540952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 08:14:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D3692004E;
	Wed, 13 May 2026 08:14:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E42DD2004B;
	Wed, 13 May 2026 08:14:15 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.ibm.com.com (unknown [9.39.28.204])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 08:14:15 +0000 (GMT)
From: Sayali Patil <sayalip@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>, sshegde@linux.ibm.com,
        chleroy@kernel.org
Subject: [PATCH v2] powerpc/time: Remove redundant preempt_disable|enable() calls from arch_irq_work_raise() - part1
Date: Wed, 13 May 2026 13:44:13 +0530
Message-ID: <20260513081413.222490-1-sayalip@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Y/XIdBeN c=1 sm=1 tr=0 ts=6a0432df cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=Q_qF-8Ot7ODvqRfjXTAA:9
X-Proofpoint-GUID: aURig4lEGn4YcoKFGKmUmGdbxv6g4VDc
X-Proofpoint-ORIG-GUID: fWF2nkRwUBo--9j4nEBZrSExff7CEs3N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA4MiBTYWx0ZWRfX/AqQEB5w+HyM
 tBHfDw82+nvfmYh5zgxqQb40gdUNZBh6jZsZ1SI0iAd9PHflN4WeBaMXYatfXhdm0/61NWzbKHL
 vAGbbpYwVEZBFOtPaut/MRjQruqvrZ/DjBpPHpuyBTvxwDRfip7BMsZGUGxVT29LPcgGnE4GRkg
 Sn7uxgXkSBvwJqin3nEyCHz8+TMTXsUpcVKii24VktU26nxatkUbT6AHZvYuDl+nuatX0xT3yLK
 nZy+wWa4bktB645P2nH0j7HOO7S7hMpeWK7mNHnrZDOXNxrU3MIoVPntKxfdXv5XtDUQwUiM5Sr
 niHBCvoenfo38kawx1ohkgS7E/hWMshoB5wtQiR048W2weDItDadjRe5R2dYLzRmrxjYmxPBKSe
 V0CsFXoHcoKclx8UUygqMwY+CLGxFiA0YsEfBl58JxanHzU0mWMuhzLNrpDIfOgJ1O2fHiXiqW6
 3P55XqYKf1AkbViNDUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130082

A kernel panic is observed when handling machine check exceptions from
real mode.

  BUG: Unable to handle kernel data access on read at 0xc00000006be21300
  Oops: Kernel access of bad area, sig: 11 [#1]
  MSR:  8000000000001003 <SF,ME,RI,LE>  CR: 88222248  XER: 00000005
  CFAR: c00000000003ffc4 DAR: c00000006be21300 DSISR: 40000000 IRQMASK: 0
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

The arch_irq_work_raise() function executes in NMI context when called
from MCE handler. Hence we will not be preempted or scheduled out since
we are in NMI context with MSR[EE]=0. Therefore, it is safe to remove
the preempt_disable()/preempt_enable() calls from here.

Remove it to avoid accessing preempt_count from real mode context.

Fixes: cc15ff327569 ("powerpc/mce: Avoid using irq_work_queue() in realmode")
Suggested-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Acked-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>

---

v1->v2
 - Split the patch series into two parts; v2 part 2 of remaining two patches
   will be sent later due to changes required in 
   "lkdtm/powerpc: add PPC_RADIX_TLBIEL test for radix MCE validation".
 - Updated commit message as per review feedback.
 - Added comment for arch_irq_work_raise() to indicate it must be called
   with preemption disabled, as per review feedback.
 - Added Acked-By from Shrikanth and Reviewed-by tag from Ritesh.

v1: https://lore.kernel.org/all/cover.1778057685.git.sayalip@linux.ibm.com/
---
 arch/powerpc/kernel/time.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 4bbeb8644d3d..b4472288e0d4 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -458,6 +458,10 @@ DEFINE_PER_CPU(u8, irq_work_pending);
 
 #endif /* 32 vs 64 bit */
 
+/*
+ * Must be called with preemption disabled since it updates
+ * per-CPU irq_work state and programs the local CPU decrementer.
+ */
 void arch_irq_work_raise(void)
 {
 	/*
@@ -471,10 +475,8 @@ void arch_irq_work_raise(void)
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


