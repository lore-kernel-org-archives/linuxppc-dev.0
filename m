Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9C0606A31E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=q1rPh195
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jb4FG4gJWz2y2h;
	Fri, 27 Nov 2026 05:04:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795716274;
	cv=none; b=jsriv9SnQVyV4HHe7Ivuo2pBcFWF0bRS5FqSZeiA5pQpa2+eDElDHYwGYaeHe4hkkFt/X6tPDpFeFZXSwBB55lJOUeb58SzPrXlQnS6wG2zzDQYDcyU9KR6o7ams6YgBlWQ+MPscAHlKO4Yj4h5SBzP6Y2A3E0xmVfGg+1jj6U4oynZSsdJ+x+xzx1IftHDu3FN18TpBUYjrzKidRq7FBlGkxRd2ywH0IbuJDPMED9uNPnGt/zAG4RU2F+B4EoCpvDoB0eMWDzN5JQrgtXZVOkn6wmT6OdhVl8O1gWG7hCp2snCT3iy+0hoHMRPwKy3lZt409TPdIQGMVwdtPoMXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795716274; c=relaxed/relaxed;
	bh=JlUgpAgqIxfXj8bT0yWcKuAVgkthhwf3lwhEGzyMFjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bYd8WDxNcJ0zzQd+l5UobI+/hUioij2p/wgDEB4jAwErjNMX+6w4zAWSUO/YpzX0r9mcOAiYJEhOzSHACbpmU1YCDM51RhNUEqueQNfmSeP/w9wKnKCuWYSEXrESBLwb+Jej6FIboEofVg+6Fdp73yRrIn9KGLABX96/ScQEl4HFkYTxEUqBFaKI7oHWxOxbOPGNmPCJdD6PjdfWD2Gvye4mO7RMKT1y02lK4/lHmpAWNF+Qp8DenRRzeUEYaVExP67j+ue/uLMZU1xV2Qb6kmvKtaNwuYMWvvTEUDFKHFtJqfw+0tmmyVljd6IB+773SH2GPugmlwgES1g0hZfSgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=q1rPh195; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sridharm@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=q1rPh195;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sridharm@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jb4FF1mqGz2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 05:04:32 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQG53Jw624096;
	Thu, 26 Nov 2026 18:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=JlUgpAgqIxfXj8bT0yWcKuAVgkthhwf3lwhEGzyMF
	jg=; b=q1rPh195sIp0ahFANdYia9BeC/GQP2ms/t3rxyqvCnz5goTGPAyWGmxiX
	ZOfKmh4CUtR6AHDahBZ849x+67DTv0Mzalrzq9YStg6/yNnh9II75isIPG8Vkv+K
	17zcMKfYeoucrlrEU4oMOVkOIopMUA6psjpYMwTaP85kSayEGYdRetQyKOAocm3h
	o079e3wVMygexj4fPxylU+n8aimh2G4btJ8WzDrpIIxHKkGCbaBZrwciG+4XlGpL
	P9qcIz9+TDglqeUb7o3oU+a5PN2D0JxrzaMZ1cyVcteVmqjQJNn4Dt2G3VM0OlzH
	2w2GwWO5XVYo69bgK/TgeGDBcSQkA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g1hwvq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 18:04:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQG4PY81833755;
	Thu, 26 Nov 2026 18:04:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5uxx5ue9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 18:04:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AQI435j26018298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Nov 2026 18:04:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C328B2004D;
	Thu, 26 Nov 2026 18:04:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCC6220043;
	Thu, 26 Nov 2026 18:04:01 +0000 (GMT)
Received: from ltcrain4-lp7.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Nov 2026 18:04:01 +0000 (GMT)
From: Sridhar Markonda <sridharm@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        ravi.bangoria@linux.ibm.com, linux-kernel@vger.kernel.org,
        Sridhar Markonda <sridharm@linux.ibm.com>
Subject: [PATCH] powerpc/hw_breakpoint: Fix NULL pointer dereference in thread_change_pc()
Date: Thu, 26 Nov 2026 18:04:22 -0500
Message-ID: <20261126230422.1533-1-sridharm@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: V8iMch0e3ZIG86DEv_ynqqB0CD2gB2nC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA3MSBTYWx0ZWRfXzSgMBbTkZSpe
 +cAyfIZMNkT1Bfh6KBAT3WFLWpklNXaawbw95ucAAbqAeaCru+j1ZwHVi1dmrcF5Wbgs44zaPsb
 BYk46s6k6rVNFMYLNftqZj32crFG8jg=
X-Proofpoint-GUID: Sp-ARMORu9xoaBxIGw-GLjv4WY8whTvu
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b08749a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=kNhjnwM3jKZadXBbU-4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA3MSBTYWx0ZWRfX7p6UM1+WRARz
 mhI7wDDVYlCuvyPkQEPJTBD+aYIQOnGo8KZJ3SnK0Ifu4KPH+imqO7XvYWPFCyM04DjbXePgqQS
 id6Vti0AergxbJAaRk7w4atj9Gmv6GjXc7TX59Xx8wXIp2mpI1OZ9Lgv2dPSQGAJaY/+2UXw6dh
 QFl+gnzxNKiNRSO0cE9HT416wkB/lQoxtcrylBd00Ti/bvAO2wCADQq1suayXmHyT6pDjiKrp2G
 /TBt6U5GK8RHHHk+mLa+6rfXH5/SAFWy0p8prI4WJ+XMlaiUdKn2TKLlUStIzDMBK+LLbr8+oif
 GFa9niMOgwIRyUDtmeaE8hAoxyZNHcrdTmIfyYdsXm1myroHbwoE6R1sEXf/kUN72PXaUPwooaz
 H3mxJyKZUni7DVJi0qnujqZ4OiAW00h6B2TfNRZLin6gMUl98EjYj49zIONcObDctLrODTg5s9s
 tL8yDOozRgpfyAv1pYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260071
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_03_06,DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Syzkaller reported a NULL pointer dereference on ppc64le:

  BUG: KASAN: null-ptr-deref in __set_breakpoint()
  Read of size 16 at addr 0000000000000190

  Call Trace:
  __set_breakpoint+0x6c/0xa0 arch/powerpc/kernel/process.c:880
  thread_change_pc+0x1c4/0x2f0 arch/powerpc/kernel/hw_breakpoint.c:247
  do_signal arch/powerpc/kernel/signal.c:279 [inline]
  arch_do_signal_or_restart+0x2dc/0x7c0 arch/powerpc/kernel/signal.c:360
  __exit_to_user_mode_loop kernel/entry/common.c:66 [inline]
  exit_to_user_mode_loop+0xa0/0x8d0 kernel/entry/common.c:101
  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
  syscall_exit_to_user_mode include/linux/entry-common.h:343 [inline]
  syscall_exit_prepare+0x494/0xc10 arch/powerpc/kernel/interrupt.c:124
  system_call_vectored_common+0x168/0x2ec

thread_change_pc() handles the case where a task changes its program
counter while a watchpoint is in perf_single_step state. The reset path
walks all watchpoint slots and restores watchpoints that were temporarily
disabled for single-stepping.

However, the number of installed watchpoints may be smaller than the
number of available hardware watchpoint slots, leaving unused bp_per_reg[]
entries NULL.

When the reset path encounters an unused slot, counter_arch_bp() operates
on a NULL perf_event pointer and produces an invalid arch_hw_breakpoint
pointer. This pointer is subsequently passed to __set_breakpoint(),
resulting in the reported NULL pointer dereference.

Fix this by skipping empty bp_per_reg[] slots and restore only watchpoints
that are currently in perf_single_step state.

Fixes: deb2bd9bcc84 ("powerpc/watchpoint: Return available watchpoints dynamically")

Signed-off-by: Sridhar Markonda <sridharm@linux.ibm.com>
---
 arch/powerpc/kernel/hw_breakpoint.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index a1318ce18d0e..4a5f0e27499a 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -228,12 +228,13 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs)
 {
 	struct arch_hw_breakpoint *info;
+	struct perf_event *bp;
 	int i;
 
 	preempt_disable();
 
 	for (i = 0; i < nr_wp_slots(); i++) {
-		struct perf_event *bp = __this_cpu_read(bp_per_reg[i]);
+		bp = __this_cpu_read(bp_per_reg[i]);
 
 		if (unlikely(bp && counter_arch_bp(bp)->perf_single_step))
 			goto reset;
@@ -243,9 +244,16 @@ void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs)
 reset:
 	regs_set_return_msr(regs, regs->msr & ~MSR_SE);
 	for (i = 0; i < nr_wp_slots(); i++) {
-		info = counter_arch_bp(__this_cpu_read(bp_per_reg[i]));
-		__set_breakpoint(i, info);
-		info->perf_single_step = false;
+		bp = __this_cpu_read(bp_per_reg[i]);
+
+		if (!bp)
+			continue;
+
+		info = counter_arch_bp(bp);
+		if (info->perf_single_step) {
+			__set_breakpoint(i, info);
+			info->perf_single_step = false;
+		}
 	}
 
 out:
-- 
2.47.3


