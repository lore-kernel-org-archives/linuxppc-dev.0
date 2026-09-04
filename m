Return-Path: <linuxppc-dev+bounces-26515-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06676C624DB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 02:58:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbh4Q6vGxz2xlJ;
	Fri, 04 Sep 2026 12:58:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788490726;
	cv=none; b=S7Z1nbYzMMYurleoZCfT2Y+fvg8QIWdffvqF1QfjirLqx2fxa6d1of1V+Ocg6Ty76XsFDatqOXCugV71IRXAemgXcL25txRMScQ9WEztOKYi2I+cBIjiNaxRW3sC4m9EfFgPEI9cSOIZ443i10+zPXkns2peJaR/MZIf9UE3YK77SUDRjuiS94yXxCclstq0gF9o9T8CH6RuOmaZE5QnrlhLTI/+cBCw3/up/lEMziULqCU9IIQIk4a7xcXfRX+TFqVy4apaF3XIHnYplrDU3EHWpfzNC0OG7RO0Te4j+VCmLCwpDmcOyJlaEQb+V4KcwH9zKCVeAh+5ZqJA/89Fjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788490726; c=relaxed/relaxed;
	bh=MS9O0KQITrNvh4YnJynMJV63sZc3hghW0hjdnMkCTTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GyA3+vracEX+ti6weFxykiQU6lwa4nWxT6P2+x9Py/IVPsC3LFVCJYDy94DoAQb4/070LzYvLrVDsI6htMg+10G0bnVwlOYE/ZxPYShtxjgRV2oXycEXdRGsHgBFluxYjXz/X9YiWD30Jv8TuIbXOXxYf7127wG+X/2A31TctEWfhFHzOcxmD0AFjxXFepsOtyVTjZYA+D/4iMpRb4YAmYzWRy4e0E4WwW8EMPmxLJapiFH8jbgj5v2sD8jlXwBRKGBAkJY7T8+NY2oyV+o9EjY+i3l1mECes0quQ4IE6ALQ3keQpzxwUkMPHlwp22DBxSyuGFcGMBf1nbCIIxAdFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sBjjob1O; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sBjjob1O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbh4P24HMz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 12:58:44 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68401mao210605;
	Fri, 4 Sep 2026 02:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=MS9O0KQITrNvh4YnJynMJV63sZc3hghW0hjdnMkCT
	Tg=; b=sBjjob1OO7+Cb0NmsZB/kBEVCwxo5A5m/sGiWk9Rcg1F9TptM8fu9NQgP
	/ubv4ZX9vg7sfnCqJ7KqMqZOAxuqhrAV2IyuXyiO2dNfoGdBkZ3eYIwLj6r83qTX
	523OdQlkwrbI6AN8suFqcs0Sn0Itr8RCMwrVE2MVjkonIFHG+gyEXHwgaB2mmlVj
	Xxlnhe+lbIMU5inOroRQZIPLjNvWeNEHWjD5WEujmW8si918+sHPFiwJoHepAECz
	weTY+TqsLKZbXw9KZcSwl6oqdu7nUMOWZLugmPUSkf0gt/Pk/gY/DMGTzY02HY+L
	9GyQ+VKvqPcrK7WP3Q5eEGgkG+DFQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq558bq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 02:58:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6842uhLw004484;
	Fri, 4 Sep 2026 02:58:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarkjrq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 02:58:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6842wZV951511604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 02:58:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F41B20043;
	Fri,  4 Sep 2026 02:58:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CA9820040;
	Fri,  4 Sep 2026 02:58:32 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.84.232.156])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 02:58:32 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Cc: Christophe Leroy <chleroy@kernel.org>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>,
        "Nysal Jan K . A ." <nysal@linux.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: [PATCH v2] powerpc/entry: Fix double accounting of user time on interrupt entry
Date: Fri,  4 Sep 2026 08:28:30 +0530
Message-ID: <20260904025831.3439809-1-aboorvad@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDAyMSBTYWx0ZWRfX9RCQErDH+Gr1
 QbEMzG5gub3ajO4r4tQ793QXwjIFaWjI0cOQunvNjA3Nrge7vxbvB+vCuzXW8fTZlbtJY/1mFdr
 WusE+lOgyhp7w9oP9sCQVacIP0CmjJjF0kCDXzy6wXNLndCBQEQ+0UAKtF4p12gDdC0fP1Um75C
 5OpERmAl0Bx4yw/TCUWnEEJ0L/DJnlIXAA0MndE+VDuqNPbep4JWBpSUEM6UVdnCBT/14SLokW7
 IdUQz1r4LBwEuC8ZGV5Glk/srrYka7hWJkwuKPuBQWII4ERGZJSl/WbO9u0yZR0NcO+I5OqfQuZ
 X/5chKa9qNvp38IrttLrvtdiqoRzOW4tEMBtxQAwYxAW3gtOT/Ixdv0OzeoAfy+fXN+V0yV9NKX
 sSJDPofA+BBjCtnBogFLCwTHcQI/6Q8gF8dDV+zb8OYm3r7gT67pUplMSjzOvViRXbWYSzHFQ0Y
 edEcneX4VL499UNEiPQ==
X-Proofpoint-ORIG-GUID: oLwQf3Cg5RhnoHr2Csc4yQnsJY5em0LN
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a9a33e1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=vAT63eVcdtpXN5Bls-IA:9
X-Proofpoint-GUID: tR4UP0n87co6_IJJne5qi5rYQOSaMm-m
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDAyMSBTYWx0ZWRfX4a9nwOt5rQFk
 I453HLdhGuayv6z2HzwtENOCTK3ZExwUzmFakBNzyTqfTPWJvuW9k5u3duhc9PgVkobREs+4kVq
 GeSZzXLNgnTarSyG0gTOJuXZ8Zvp/AM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_07,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040021

Since the switch to generic entry, an interrupt from user mode
accounts user time twice: once in arch_interrupt_enter_prepare()
and again in arch_enter_from_user_mode(), which irqentry_enter()
invokes for the same interrupt:

	arch_interrupt_enter_prepare()
	  account_cpu_user_entry()		/* first */
	irqentry_enter()
	  arch_enter_from_user_mode()
	    account_cpu_user_entry()		/* second */

The second call charges the same interval again, because
account_cpu_user_entry() accumulates the time spent in user mode
since the last return to user space.

The two calls come from the GENERIC_ENTRY preparation series,
where each step was a no-op on its own. Commit 09a9d3a8499d
("powerpc: introduce arch_enter_from_user_mode") added the hook
with the user-time accounting in it, but nothing called it yet.
Commit 893082ac769b ("powerpc: Prepare for IRQ entry exit")
copied interrupt_enter_prepare() verbatim into entry-common.h as
arch_interrupt_enter_prepare(); that copy was equally unused, as
handlers still called interrupt_enter_prepare().

Commit bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
made both live. On the syscall side it did the full conversion:
system_call_exception() now accounts once through the hook via
syscall_enter_from_user_mode(), rather than calling
account_cpu_user_entry() directly. On the interrupt side it
switched the handler macros to arch_interrupt_enter_prepare()
followed by irqentry_enter(), which also runs the hook, but the
accounting in arch_interrupt_enter_prepare() was not removed to
match. The double accounting starts with that commit.

With CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y this roughly doubles the
reported user time of any workload that takes interrupts. The
other accounting modes compile account_cpu_user_entry() to an
empty stub, so they are not affected.

Remove the accounting from arch_interrupt_enter_prepare() and rely
on arch_enter_from_user_mode(), which already runs for both
syscalls and interrupts. The duplicate account_stolen_time() call
is removed the same way.

On a pseries LPAR a busy loop reports 6s user time in 3s elapsed
(~210% CPU) before the fix, and 3s (~105% CPU) after it:

  $ python3 -c 'while True: pass' &
  $ sleep 3; ps -p $! -o etime,time,pcpu

            ELAPSED     TIME  %CPU
  Before      00:03 00:00:06   210
  After       00:03 00:00:03   105

A 50% load reports ~70% usr / 30% idle before the fix, and
~49% usr / 51% idle after it:

  $ taskset -c 6 stress-ng --cpu 1 --cpu-load 50 &
  $ mpstat -P 6 1

            CPU    %usr   %idle
  Before      6   69.74   30.26
  After       6   48.51   50.50

Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
Changes in v2:
 - Explain which commits introduced each accounting call and how
   they overlapped in commit message.
 - Drop the code comment.

v1: https://lore.kernel.org/linuxppc-dev/20260902050628.2553909-1-aboorvad@linux.ibm.com/

 arch/powerpc/include/asm/entry-common.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
index c5adb5006361..000fa925e26a 100644
--- a/arch/powerpc/include/asm/entry-common.h
+++ b/arch/powerpc/include/asm/entry-common.h
@@ -222,8 +222,6 @@ static inline void arch_interrupt_enter_prepare(struct pt_regs *regs)
 
 	if (user_mode(regs)) {
 		kuap_lock();
-		account_cpu_user_entry();
-		account_stolen_time();
 	} else {
 		kuap_save_and_lock(regs);
 		/*

base-commit: fb442a6673ff1046bf67754957d95880fdb394b5
-- 
2.54.0

