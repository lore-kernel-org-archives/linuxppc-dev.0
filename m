Return-Path: <linuxppc-dev+bounces-21030-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E616CD343F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 05:09:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJm7P5K3rz3brt;
	Mon, 18 May 2026 15:09:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779080961;
	cv=none; b=C7xk1Yc3RKQiTqgtQ5No/YOqRngVcgMGUvgKDmCPeuHIzgdggBfIAyU+Ae2HMQbkJ8vDBeDZ78IQ8vWPz5l48q+hFUoEL2VTIFmLHZqrGkM9nemIFdUFIPdFpcBNUuWLH9Q2TCPlac0QWkHXBPVTIqGwJmCy3zCRlCX07IhnrdxbMN4OIn6CA7QS9CWbs7Nb0HggxrMVb4tdXGwszLQXVgtbAYCLcNdlObM6zKTZ5R2+hdxI4bRW+RRklWSIl2K4qmdf6TJstONT5ILwhzrWpR6fogjJWGoSTzUsPz2MZkrsn1xXxZAwwlY5J4kfDX6ihJtIxp62YtDxYsKoimia0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779080961; c=relaxed/relaxed;
	bh=94KWRNC8OKvPEX0+yu/PKUH/bkCG2KrNhd9mwu7tC6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gavhNVnxwGP3cCXLjKCK8baecm/9bwSTloq6q9w1miy6ny+E7J3VCTXFSuOh6STxxdG8Fxi1K0MQDMQCM1JAueabFyHo92XylUv/LsTGlxNH4HYcAA+V5q3DkNL6IkZpwCxUIv3EJIeQs6zcYv1STCRB9WAqCCi9bb8hDocQJi0qQdsN9m2WGwWmPJhSJvV+exUTpZv2rBwpCwrflYb4I/HtUUUbkb3qIPYC9aOpNr3/6LqJ89f1aLgfJSdq/Ku4vqEh5VmxmhTZiBiXrz48iEsyFzR+WjbdO8Jfs9Ta8H36Wv7xwjysiO0bLoCBblYdH575ALs3Xymoab2yUza9cg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XsCNic2f; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XsCNic2f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJm7N7203z2yRF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 15:09:20 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HKohq6896528;
	Mon, 18 May 2026 05:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=94KWRNC8OKvPEX0+y
	u/PKUH/bkCG2KrNhd9mwu7tC6g=; b=XsCNic2f9QZr6R1bjevEvBf3rUiiT/W67
	mj27S7y2tRNjuVw0sPs4hJSZob+FtYaNArI1d3zJeTfrE+dlyZf3WaD+NOe7mdwP
	DffBF3DEJel8CkYzeEHdcS24gGnjV6sFJ5OTrwosUB+m3O9QtQHb06NW8qRpOL+i
	5eYoXV5asFdz8hYI0+ccRtudyQuBsVvPPE+aVn7jFadLHTycUJ2MLF+cRIKgTiy1
	aRUueO0cDbc/4AERkgWKtnoI/uBx6xS824U7UuAMz6iRocO99i8ACiM6QyctZh3U
	I+OlUvXyTK+KKvjRY5MIM5Z47z4RSNINfAk22mquplVJ/AIXdO/ZA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6havwub3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:09:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I5931n026796;
	Mon, 18 May 2026 05:09:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wpveyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:09:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I59Cme23528106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 05:09:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57F5D2004D;
	Mon, 18 May 2026 05:09:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C01FC20049;
	Mon, 18 May 2026 05:09:09 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.124.214.53])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 05:09:09 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH 3/3] powerpc/kexec: fix double get_cpu() imbalance in kexec_prepare_cpus
Date: Mon, 18 May 2026 10:38:55 +0530
Message-ID: <20260518050855.1147242-4-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518050855.1147242-1-aboorvad@linux.ibm.com>
References: <20260518050855.1147242-1-aboorvad@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA0NiBTYWx0ZWRfX6vlLF8cI/gdx
 NCfSRaTq7ovQwNujtzzYQn7XpS0OyNNIvpx5UbC8YkE1Qe3doj9jsS6NCT1Q06sQhTQ/xpDNy1L
 8bphdQMJYycu3teU0RJIWVeaaAuvqHguP6naDwF330RWu+rpCyrFMQhH8fMsuk1sFl3RszEntAz
 yLQZ1RLNF5EkQZbzMwrpV8hK4PJvXCC6WI8JFsNWKHnGzMUChUVx7rSOzl2ynyDsapIISn0ClsQ
 QP2f+rhpVwC9O0azQIuGqsu7pYwVTqFpNiMAbrKNUmMDw0JQaxDP2KdECTv5NzcTshThq2AhUKi
 CooYuPhorGSgWtfMhrysx8jzKXTyZRA7AKTgb0vxL1wLCZF9zU2tBMtnGnsjuQxb9r1ih1xKjO7
 /u02W3RByurbGv0Je/xJNAaYTZSbVgRmvPtZ9STzCWpwW2BOPhkYZpo7stB6hrYV+6I3hnYKSe6
 ENKAtEWVDWQTUJUK6eQ==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0a9efd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=axsVtGY85TFwrCMB_VEA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: 1ge_qtbov3H-6wEiunApsu3qbZsLB4QB
X-Proofpoint-GUID: aBxZ37yXKtQSS6vZrZdCs4qGCQL_AiiP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180046

kexec_prepare_cpus_wait() calls get_cpu() internally to obtain the
current CPU id. kexec_prepare_cpus() calls kexec_prepare_cpus_wait()
twice -- once for KEXEC_STATE_IRQS_OFF and once for
KEXEC_STATE_REAL_MODE -- but only issues a single put_cpu() at the end,
leaving preempt_count elevated by one extra nesting level.

In practice the imbalance does not trigger a 'scheduling while atomic'
splat because the kexec path is a one-way trip: IRQs are already
disabled, no schedule() occurs after the leak, and
default_machine_kexec() overwrites preempt_count with HARDIRQ_OFFSET
before jumping into kexec_sequence() which never returns. However the
bookkeeping is still wrong.

Lift the get_cpu()/put_cpu() pair into kexec_prepare_cpus() so it is
called exactly once, and pass the CPU id to kexec_prepare_cpus_wait()
as a parameter. This keeps preempt_count correctly balanced.

Fixes: 1fc711f7ffb01 ("powerpc/kexec: Fix race in kexec shutdown")
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 arch/powerpc/kexec/core_64.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 825ab8a88f18e..9d7e5a1e6e5b8 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -164,12 +164,11 @@ static void kexec_smp_down(void *arg)
 	/* NOTREACHED */
 }
 
-static void kexec_prepare_cpus_wait(int wait_state)
+static void kexec_prepare_cpus_wait(int wait_state, int my_cpu)
 {
-	int my_cpu, i, notified=-1;
+	int i, notified = -1;
 
 	hw_breakpoint_disable();
-	my_cpu = get_cpu();
 	/* Make sure each CPU has at least made it to the state we need.
 	 *
 	 * FIXME: There is a (slim) chance of a problem if not all of the CPUs
@@ -246,6 +245,8 @@ static void wake_offline_cpus(void)
 
 static void kexec_prepare_cpus(void)
 {
+	int my_cpu;
+
 	wake_offline_cpus();
 	smp_call_function(kexec_smp_down, NULL, /* wait */0);
 	local_irq_disable();
@@ -254,7 +255,8 @@ static void kexec_prepare_cpus(void)
 	mb(); /* make sure IRQs are disabled before we say they are */
 	get_paca()->kexec_state = KEXEC_STATE_IRQS_OFF;
 
-	kexec_prepare_cpus_wait(KEXEC_STATE_IRQS_OFF);
+	my_cpu = get_cpu();
+	kexec_prepare_cpus_wait(KEXEC_STATE_IRQS_OFF, my_cpu);
 	/* we are sure every CPU has IRQs off at this point */
 	kexec_all_irq_disabled = 1;
 
@@ -262,13 +264,12 @@ static void kexec_prepare_cpus(void)
 	 * Before removing MMU mappings make sure all CPUs have entered real
 	 * mode:
 	 */
-	kexec_prepare_cpus_wait(KEXEC_STATE_REAL_MODE);
+	kexec_prepare_cpus_wait(KEXEC_STATE_REAL_MODE, my_cpu);
+	put_cpu();
 
 	/* after we tell the others to go down */
 	if (ppc_md.kexec_cpu_down)
 		ppc_md.kexec_cpu_down(0, 0);
-
-	put_cpu();
 }
 
 #else /* ! SMP */
-- 
2.54.0


