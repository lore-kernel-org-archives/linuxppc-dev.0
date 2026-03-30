Return-Path: <linuxppc-dev+bounces-18993-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB83FF4946
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 06:22:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkh4x0ks5z2xpt;
	Mon, 30 Mar 2026 17:22:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774851777;
	cv=none; b=YWoFoPukPVbPuTWzQBCs7DoLXxRqDG6zf47yOWYFafNteqzWCmAkH10Vt+MKF1uW2iRbiyAFHBjYGn5dmtHwj7q+AbwtCSb5STxiHTHLSzJz2U+3S61qxb7hjG2m54nBoqpVpCxIMxRhVl/ufC2hvy/+GHFgo/4G3kfkNfFFcibFEmBe1yPdoCRY7Ps+wy4PJeo8qfe9Sx+gLNCF5m32I7Yf7KY32NdkbdvfkUdQoEA/q/cNWAItQjiHbIg/h72j0Qz5Qoh+WoSZpl3/OpoJTgFhQDyNLrjgDjsa+NxDE/GhkqGEr0JE2mTkM4szO1BkE1CQj+yw8s3oaXLFcG0Xgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774851777; c=relaxed/relaxed;
	bh=FVBlHWdSeKR8TdoMvcZeU8gd/PJz6Tcr3SHPagrkDpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PREtW+lZBd3VC1LSQfx7LMEI1y0T/L859/4HO+c4sgsQ+zSL72ZlRYr0mKzdO9UYmx7UXz4nzf/KrVPnClSXl5KdLHKHRVw5vFY34f66lejdhhJMjQYxVZ8EKCmgvRAIlaYv1U90hLUCiVAf3K4+rc/lYbBDjpDJnTkX0Auk7zagTA4+pDYmuzyP0YF8RLiXtLBDZibX5VVrbjxxfDA5AO1iHPs2Hmlk0xj3Bgp/rTfSfENkL6QbTucDUQFECWJMFq6EvtN5sIr1gMX2rK+ahFbbaQUA0Q+IRx4sAvRucf4a4zQ/fzKQ5wm6CZOOkEQ/4x1IzYFDG77FBTHhif4KuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=a/pjaYrc; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=a/pjaYrc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkh4w1QHKz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 17:22:55 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62TBSKBf3068935;
	Mon, 30 Mar 2026 06:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=FVBlHWdSeKR8TdoMvcZeU8gd/PJz6Tcr3SHPagrkD
	pA=; b=a/pjaYrca+gp/835AYZEJsOOFFJe6nDeSazVfaf3BzlrEsmMYItl3clUl
	NB7YFAObElyuqyyuSBopzUmweE+dLLhnY6G3PTlU+rP3+xBfYBUl+2jDGRTTG06I
	FI0uBBrNRhSvnIXpKIR+OAX+gylD2W/LQnArlw1zxJ66jrIQgdg1+9jQMvpdLnoi
	Xg0pFKWl/vTunutZVgypGY4qkH3yv80fQ3WmrO8ECsbHx6xNQ0t0znMjPw2kuDzu
	L6I2nLiI1bPazgyx4xScw6rBdN4Ek2t9yeT3QU6fEx5Z2qNupubNv+6xhogOKQos
	NvpZGh28OkniZpWDEP/XgiFJamTJw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dc58sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 06:22:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62U0KD3F031552;
	Mon, 30 Mar 2026 06:22:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjkfv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 06:22:43 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62U6MdMO27918736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 06:22:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D246620043;
	Mon, 30 Mar 2026 06:22:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E008D20040;
	Mon, 30 Mar 2026 06:22:35 +0000 (GMT)
Received: from shivang.com (unknown [9.124.209.226])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Mar 2026 06:22:35 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        "Nysal Jan K.A." <nysal@linux.ibm.com>,
        Vishal Chourasia <vishalc@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Subject: [PATCH v2] pseries/kexec: skip resetting CPUs added by firmware but not started by the kernel
Date: Mon, 30 Mar 2026 11:52:06 +0530
Message-ID: <20260330062206.170437-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
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
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69ca16b4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=1UX6Do5GAAAA:8 a=GwHI3t_bLG2Gy7s121kA:9 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-GUID: WpSHN9E0uRoXOsRDJFxAYT1xNETN6j2D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA0NyBTYWx0ZWRfX+mYN+H/mHyF7
 WSiyWzSJHav/6KnTZGAYwojgs+a6oxlLTyvCWbs4GFnEq663Q4vB/4xhWnuBg16Hk6wKKpXXTTZ
 mZi1XIeFwD6/luOF1gmBL1gAtZs+7Id8TIKX3PXE3yOQhjUjqEBzhgrEIhI5bPWjyZ+XnwIKViI
 sxKEOjSjHXwI+s8Al5jkb89qmG7i70cAGbcj4k6IUxGeeQW0I0kVLSwNrTvFDges4H7sT5GMoh3
 I3aRqLBBXmoBlU8EFTg0qIHrshi4UI9sOvKSyoCZCFNU1Rkgzr5kuAELJRmMGis44u3gUcHVHCU
 131f5OfxhhfMHKOIcZrAc9M5L4qe9wKODFOjCnjV+5bfNlaBv4KdsnbxXFE/jPD6HwP/bm1+EWG
 IrOkJlBWgiokzCZ4iY5AMVZBmZ9FawM5BbNaYpGPYQ+imAHV1touEGF5DDLPXK+KNohpW2ZmZBB
 6ei5R/Ln8q9bJSCgqcg==
X-Proofpoint-ORIG-GUID: Z-ATcEZmtutxzXQclY42ABIn733UpUsV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1011 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300047

During DLPAR operations, the newly added CPUs start in halted mode.
The kernel then takes some time to initialize those CPUs internally and
start them using the "start-cpu" RTAS call. However, if a kexec crash
occurs in this window (before the new CPU has been initialized),
the kexec NMI will try to reset all other CPUs from the crashing CPU.
This leads to firmware starting the uninitialized CPUs as well.

This can cause the kdump kernel to hang during bring-up.

Sample Log:
  [175993.028231][ T1502] NIP [00007fffb953f394] 0x7fffb953f394
  [175993.028314][ T1502] LR [00007fffb953f394] 0x7fffb953f394
  [175993.028390][ T1502] --- interrupt: 3000
  [    5.519483][    T1] Processor 0 is stuck.
  [   11.089481][    T1] Processor 1 is stuck.

To fix this, only issue the system-reset hcall to CPUs that have
actually been started by the kernel.

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Srikar Dronamraju <srikar@linux.ibm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Nysal Jan K.A. <nysal@linux.ibm.com>
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
Changelog:

V2:
  * added set_crash_nmi_ipi to saperate crash's case from other nmi_ipi
    users

V1:
  * https://lore.kernel.org/all/20251205142825.44698-1-shivangu@linux.ibm.com/
---
 arch/powerpc/include/asm/smp.h       |  1 +
 arch/powerpc/kernel/smp.c            |  1 +
 arch/powerpc/platforms/pseries/smp.c | 29 +++++++++++++++++++++++++++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index e41b9ea42122..cb74201f5674 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -47,6 +47,7 @@ struct smp_ops_t {
 	void  (*cause_ipi)(int cpu);
 #endif
 	int   (*cause_nmi_ipi)(int cpu);
+	void  (*set_crash_nmi_ipi)(void);
 	void  (*probe)(void);
 	int   (*kick_cpu)(int nr);
 	int   (*prepare_cpu)(int nr);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 3467f86fd78f..3390ee8adf79 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -594,6 +594,7 @@ void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
 {
 	int cpu;
 
+	smp_ops->set_crash_nmi_ipi();
 	smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, crash_ipi_callback, 1000000);
 	if (kdump_in_progress() && crash_wake_offline) {
 		for_each_present_cpu(cpu) {
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index db99725e752b..c6c2baacca9a 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -51,6 +51,9 @@
  */
 static cpumask_var_t of_spin_mask;
 
+
+static int crash_nmi_ipi;
+
 /* Query where a cpu is now.  Return codes #defined in plpar_wrappers.h */
 int smp_query_cpu_stopped(unsigned int pcpu)
 {
@@ -171,12 +174,35 @@ static void dbell_or_ic_cause_ipi(int cpu)
 	ic_cause_ipi(cpu);
 }
 
+static void pseries_set_crash_nmi_ipi(void)
+{
+	crash_nmi_ipi = 1;
+}
+
 static int pseries_cause_nmi_ipi(int cpu)
 {
 	int hwcpu;
+	int k, curcpu;
 
+	curcpu = smp_processor_id();
 	if (cpu == NMI_IPI_ALL_OTHERS) {
-		hwcpu = H_SIGNAL_SYS_RESET_ALL_OTHERS;
+		if (crash_nmi_ipi) {
+			for_each_present_cpu(k) {
+				if (k != curcpu) {
+					hwcpu = get_hard_smp_processor_id(k);
+
+					/* it is possible that cpu is present,
+					 * but not started yet.
+					 */
+
+					if (paca_ptrs[hwcpu]->cpu_start == 1) {
+						plpar_signal_sys_reset(hwcpu);
+					}
+				}
+			}
+			return 1;
+		} else
+			hwcpu = H_SIGNAL_SYS_RESET_ALL_OTHERS;
 	} else {
 		if (cpu < 0) {
 			WARN_ONCE(true, "incorrect cpu parameter %d", cpu);
@@ -243,6 +269,7 @@ static struct smp_ops_t pseries_smp_ops = {
 	.message_pass	= NULL,	/* Use smp_muxed_ipi_message_pass */
 	.cause_ipi	= NULL,	/* Filled at runtime by pSeries_smp_probe() */
 	.cause_nmi_ipi	= pseries_cause_nmi_ipi,
+	.set_crash_nmi_ipi = pseries_set_crash_nmi_ipi,
 	.probe		= pSeries_smp_probe,
 	.prepare_cpu	= pseries_smp_prepare_cpu,
 	.kick_cpu	= smp_pSeries_kick_cpu,
-- 
2.53.0


