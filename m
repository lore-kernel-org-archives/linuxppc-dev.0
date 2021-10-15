Return-Path: <SRS0=ZqAX=PD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E0AC433F5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Oct 2021 17:40:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E8561184
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Oct 2021 17:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 50E8561184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HWD746p1qz3c6S
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Oct 2021 04:40:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pl+g4TF5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=nathanl@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=pl+g4TF5; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HWD6J578Xz2yQC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Oct 2021 04:39:20 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19FGbRBA025207; 
 Fri, 15 Oct 2021 13:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=/10yQ8WwPoe/0CahSmZSVIBcmLTlpF2iZsUx2OMLpbo=;
 b=pl+g4TF57acF2ahiYrvozNqnl5KJVGVizWOcZnQ6yOi7Boj1dynAZ1a9rsmrBJ8V0aAc
 oWOfEQP1VARd2GnXwq2NzQyCWbRlDXWtKGO2hOkHaRtMUbZqaA1wX0pNLPBWqLcmZHWE
 dOp5/yQj3w2ieDaPQEpOhj8G9T7met4CJeFIMrUrrYxVgQtS0wnD6z9CKfkxPgeGCvhO
 7luhBUCMS/VQy3t5Q+yOBqSZv0M5Dn+iqta+gUSczuh+5goocjVvTx1jpd3MjRXl1lDE
 11ysjuOGAe1+IG2jURFW19+IfP9nrFwG93bFfkn9Me6Ll4yDEl/+7x1RB0i/Qdxiu5Qe sQ== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3bps2tuped-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Oct 2021 13:39:05 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19FH6UsU018669;
 Fri, 15 Oct 2021 17:39:05 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma03dal.us.ibm.com with ESMTP id 3bk2qe8b5t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Oct 2021 17:39:04 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 19FHd3mb17826218
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Oct 2021 17:39:03 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 96AA9BE051;
 Fri, 15 Oct 2021 17:39:03 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55BA7BE04F;
 Fri, 15 Oct 2021 17:39:03 +0000 (GMT)
Received: from localhost (unknown [9.211.119.24])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 15 Oct 2021 17:39:03 +0000 (GMT)
From: Nathan Lynch <nathanl@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/smp: do not decrement idle task preempt count in
 CPU offline
Date: Fri, 15 Oct 2021 12:39:02 -0500
Message-Id: <20211015173902.2278118-1-nathanl@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZFQG2YXJTDrb6k5Un_xTlnSzuldUR0fk
X-Proofpoint-ORIG-GUID: ZFQG2YXJTDrb6k5Un_xTlnSzuldUR0fk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-15_06,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=924 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110150106
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: srikar@linux.vnet.ibm.com, peterz@infradead.org,
 linux-kernel@vger.kernel.org, valentin.schneider@arm.com, clg@kaod.org,
 mingo@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

With PREEMPT_COUNT=y, when a CPU is offlined and then onlined again, we
get:

BUG: scheduling while atomic: swapper/1/0/0x00000000
no locks held by swapper/1/0.
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.15.0-rc2+ #100
Call Trace:
 dump_stack_lvl+0xac/0x108
 __schedule_bug+0xac/0xe0
 __schedule+0xcf8/0x10d0
 schedule_idle+0x3c/0x70
 do_idle+0x2d8/0x4a0
 cpu_startup_entry+0x38/0x40
 start_secondary+0x2ec/0x3a0
 start_secondary_prolog+0x10/0x14

This is because powerpc's arch_cpu_idle_dead() decrements the idle task's
preempt count, for reasons explained in commit a7c2bb8279d2 ("powerpc:
Re-enable preemption before cpu_die()"), specifically "start_secondary()
expects a preempt_count() of 0."

However, since commit 2c669ef6979c ("powerpc/preempt: Don't touch the idle
task's preempt_count during hotplug") and commit f1a0a376ca0c ("sched/core:
Initialize the idle task with preemption disabled"), that justification no
longer holds.

The idle task isn't supposed to re-enable preemption, so remove the
vestigial preempt_enable() from the CPU offline path.

Tested with pseries and powernv in qemu, and pseries on PowerVM.

Fixes: 2c669ef6979c ("powerpc/preempt: Don't touch the idle task's preempt_count during hotplug")
Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
---

Notes:
    Changes since v1:
    
    - remove incorrect Fixes: tag, add Valentin's r-b.

 arch/powerpc/kernel/smp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 9cc7d3dbf439..605bab448f84 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1730,8 +1730,6 @@ void __cpu_die(unsigned int cpu)
 
 void arch_cpu_idle_dead(void)
 {
-	sched_preempt_enable_no_resched();
-
 	/*
 	 * Disable on the down path. This will be re-enabled by
 	 * start_secondary() via start_secondary_resume() below
-- 
2.31.1

