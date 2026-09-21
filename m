Return-Path: <linuxppc-dev+bounces-27813-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D82C982DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 07:22:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpF6b4VSxz2yPR;
	Mon, 21 Sep 2026 17:22:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789975335;
	cv=none; b=kqiGznk5Q4VQ9rArs0Qs386zWds8vXe/vYGfR2SH95MsKEQlKgDvkVVNOBfMZT0D+4ZyuEqPWLKC8qYV32A4juP5q1EG1YnVgFj3vomNwb0hs2LxRtOUnQ0PM1/n0iTvoQLSEiNM9lUw3C0sebdWPyb0y0Uh7NCn5STXMCZFldEwe6bSoUC7sIBuyu9nLRv+BNp/xPmhvQHNkwFokqjvK723FJaMQBJTnkDF62vLdAcZvcvaF9XjiMe0918VHQvM2hqvHSp+TE2qUEv9NJyHLhz625l/z+YIGd2+fwae8ZGkaXLY4KCmVrciIFJymRhvCDn1v+/SiCn2MQOheWshCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789975335; c=relaxed/relaxed;
	bh=rI68eMAogd7yGrbvuVog6inzAtN+RQWxPU3hSW8KEbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H1pxlF/o6TfG2ICILnUA1p1WJSX8pXB80lXhbfPYTx4NNhmhAv+sE/6uw6knlD60lsgadjh/kJ+Jj2ZWDgW+45a1LVgCdbi3/z8RODfT7aBehkMOgk4ReVJXTuNmgjYEaS+zJ5odEig58ja1Usn8U2Wh/0kDtuNmPADJiJzh31j5w5t5vf3ddcYQGqNwHggMhhAboqXC+SEjYPdEl4Yqr4ROwOKnwZKI2QwWjRlM/OFGVdl0ZTc/yoALUUZgpQTfUbWu81gcrN9zhaNWvextB3vQpaxvp/v4wqlGvHolxbh0iKf4Kmrup0xSCnzyKpTCdTo/3XFloCbwLkHIVS+EbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=X3c0ANGZ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=X3c0ANGZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpF6Z5KStz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 17:22:14 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L3ab7U3307136;
	Mon, 21 Sep 2026 07:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=rI68eMAogd7yGrbvuVog6inzAtN+
	RQWxPU3hSW8KEbQ=; b=X3c0ANGZkNndMmOgfr4p+WkeVFz68bL1PsTNh0v0BofB
	EhziArojEav9WMZWfmhQzSNKdj6lAeQ/+AdGKHb5mHEQ/AtMYvVslE9t80/EFIWU
	iGCeJBbjZZcIWdvyybMvUgdClWez9qkQ4oae4Kf3SUUIJU7gd4JrFSmGj2mZHlVA
	3PhmuDYrpPspuXIjSzkx4emGGT6/nhX8Jlp3ADuYbultmba+ZfIPLnCUqrgixs/v
	WYyiSU6NhuGEYJquWfSz0jXzaQqzT/2TbDtUtIbOIygRFzptO3lDXgezu9Enecsz
	ueSsAKi6Q2D9tGqqSq9BN3U2uuJ/N+GlFU+uiZUFOg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgq72up-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 07:22:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7HslD868114;
	Mon, 21 Sep 2026 07:22:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vcc2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 07:22:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L7LuWp51052860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 07:21:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6402620043;
	Mon, 21 Sep 2026 07:21:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3E1120040;
	Mon, 21 Sep 2026 07:21:53 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.208.199])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 07:21:53 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        msuchanek@suse.de, ritesh.list@gmail.com, hbathini@linux.ibm.com,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: [PATCH v2] powerpc/ftrace: Don't restore r13 during ftrace_regs_caller
Date: Mon, 21 Sep 2026 12:51:50 +0530
Message-ID: <20260921072151.35531-1-sshegde@linux.ibm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab0db19 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=5793ORmOmheN9jAXARAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEwMCBTYWx0ZWRfX22kF53TqveLz
 zwVA3+oC180J18iUKAFD9fM3DI2R1vqhoWP81bRKuHiS8BswX46RLGjej/GJuCzOMaMoeTuEShV
 sZGZ/xHNt9fg6jWX5uzzNmMBsCJzI4IsBhyT+YsFHvWptGMKMxI5zmddOK+AspAaHL8CJCquv10
 iwPxJ69v5JllQVIgaDoKeb6ZMBuNasOy3w6AUb/8nzltku4gQLT6tqOu8uNJ8HycAj9Kt+2HBym
 mRFQQWCbxKyOfXGBaXzsL1f+v19VJq2NjWTb5+GQbv/c5wrS3NYgkak1PHsVIcsy6ECuEftL0eC
 RAVMTf1d25x7gMBris0kqL3+VHRB/5q9cMGVPMrPqh0vGAxKzPZ2ES0IowTxsSCV/5Hbk4kUn0U
 W/nkSmGkSwVp1FG6+8E5tYDHi9vrig45ltM5tat4dK1u9GlrgDT8reiaXtnWIoB/450V5P/XvQo
 0jqO9vLmtXo35BxaoSw==
X-Proofpoint-ORIG-GUID: cDym8uBQ-pY4gP309kVjxl-uzfNx6P6z
X-Proofpoint-GUID: rnBTgEvrACJgNb84zebxHt4GfWrmf1Az
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEwMCBTYWx0ZWRfX8iIzUuG4yjh+
 VCpOChh12Xq1r13OB4MfN9zrgbisNp6d/X7axNExXeQcRmozV7OcsiH2IXsLtpJLB2yro8G8Z6k
 RIJ0pgyS94U5Tm5JJJaAuGAdsj/mxuU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210100

Michal reported a stack-protector failure and subsequent panic when
running kernel builds. This was observed with full/lazy preemption.
Initially it was suspected as KVM, but later turned out to be due
to a bcc tool running in parallel.

Issue was recreated using a bcc tool. 
For example, running below in parallel leads to crash.
./funccount sched* -d 100 and make -j 64

The same crash was observed when running kprobe for schedule() function,
while simpler function tracer for schedule() didn't cause the crash.
This helped to narrow it down to ftrace backed kprobes area.

The crash occurs as follows:

ftrace_regs_caller entry on CPU A
    |
    +-> save r13 = CPU A PACA into pt_regs
    |
    +-> call kprobe_ftrace_handler()
            |
            +-> ftrace_test_recursion_unlock()
                    |
                    +-> preempt_enable
                    +-> task can schedule and migrate to CPU B
                    +-> task resumes with live r13 = CPU B PACA
    |
    +-> REST_GPRS(2, 31)
            |
            +-> restore saved r13 = CPU A PACA
    |
    |-> The task then continues running on CPU B with r13 pointing
    |   to CPU A's PACA.

The stack-protector canary is accessed through the PACA. After the task
migrates, CPU A may run a different task and update its PACA with that
task's canary. Restoring the saved r13 then causes the migrated task's
saved stack canary to be compared against the canary in CPU A's PACA,
resulting in a stack-protector failure.

Similarly, current is resolved through the PACA. With a stale r13,
preempt_count() can access the state of the task referenced by CPU A's
PACA instead of the task running on CPU B. This results in corrupted
preempt-count warnings and scheduling-while-atomic failures.

This path for example is called when using kprobes and parallel kernel
builds can cause preemptions during ftrace_test_recursion_unlock.

Do not restore r13 from the saved register frame. If the task did not
migrate, the live r13 already has the saved value. If it migrated, the
live r13 contains the correct PACA pointer for the CPU on which the task
resumed.

On PPC32, r13 is regular register. So do this fix only for PPC64

Fixes: 153086644fd1 ("powerpc/ftrace: Add support for -mprofile-kernel ftrace ABI") 
Reported-by: Michal Suchánek <msuchanek@suse.de>
Closes: https://lore.kernel.org/all/aqKfsVArHHaIK6M9@kunlun.suse.cz/
Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
v1->v2: 
- On PPC32 r13 is regular register. So continue to restore it.
- Picked up the tags.
v1: https://lore.kernel.org/all/20260918150811.1743769-1-sshegde@linux.ibm.com/

 arch/powerpc/kernel/trace/ftrace_entry.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S b/arch/powerpc/kernel/trace/ftrace_entry.S
index 6599fe3c6234..5eb8eee32549 100644
--- a/arch/powerpc/kernel/trace/ftrace_entry.S
+++ b/arch/powerpc/kernel/trace/ftrace_entry.S
@@ -220,7 +220,13 @@
 
 	/* Restore gprs */
 	.if \allregs == 1
+#ifdef CONFIG_PPC64
+	REST_GPRS(2, 12, r1)
+	/* Do not restore a stale PACA pointer if the task migrated */
+	REST_GPRS(14, 31, r1)
+#else
 	REST_GPRS(2, 31, r1)
+#endif
 	.else
 	REST_GPRS(3, 10, r1)
 #if defined(CONFIG_LIVEPATCH_64) || defined(CONFIG_PPC_FTRACE_OUT_OF_LINE)
-- 
2.52.0


