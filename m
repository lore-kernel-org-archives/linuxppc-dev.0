Return-Path: <linuxppc-dev+bounces-22117-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B717CD6E5D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 08:29:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWvk45c5qz2yRM;
	Fri, 05 Jun 2026 18:29:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780648172;
	cv=none; b=IDIVb4AgDvcJjy8vnTIRhFHI864QP6NGK0yPgG2UyAMEotIUVnZmB+91YCDk9/OknaFBGgPRoLi+QfI78WLPcShWcPXh76yvYAgnFlSTQbgXWX6Bk6NnLqpth9pojwCg8xkeivnjEDX+nBECNsIhC66Ljk+I5R4IkNCNYgMqohJufWvJ7qi7XiNM7uFuP4geGPHW13mGg7aF8GOmWH9BSE+ktndi/4dCF7vh7ENGW1G2lLFg5ahpAj/xPXNjGG3oAyE3lSOfwj1gYr+HsNJKlbMuo1itDRnI7j09r1VHiGy1sM36SzdY7fSNHr/A63A7LCvRS/ICrtCinhKl8wJBMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780648172; c=relaxed/relaxed;
	bh=YDeU2k0PY5JnOLo5yk63PWdcLSr0CIJqorhXwq0pqFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SqlQhmd7f0aVs+3evTY/y/dRm0gpN7oN3K4dGo44JooaQhes9GvmjcevBWj30WnaaaYN5GM3qFc/WpdAdn9284pW+V1vTklRJQB4ku8kIvyIQHoQcLjp6Hiq061lDMmkp6I5DFDJi0Jt0k48oq4GLUwN8d1Uffz33MUFkHUXG8LJ8x+nMFapJRF0uQaRodoO4xjKwCR3YuZAns8wXO+BHlTpMTHQSGtz3M8C4sto9GIyXEVSbcbY5PK4V2Q5cpST4PyO7oEg+z3DXYO0c8+7nVDJi+JB1y/smDsIZ89xg1jQVIG2tZh5QpSt3Aqt4Vf+QeqTVFFOvo6MfdyB/yinrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aeWkuBxB; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aeWkuBxB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWvk36Zs9z2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 18:29:31 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654N5Aj12190646;
	Fri, 5 Jun 2026 08:29:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=YDeU2k0PY5JnOLo5yk63PWdcLSr0CIJqorhXwq0pq
	Fk=; b=aeWkuBxBxvN8zhDAzM9Tn4KVA7XMixFiYgjwV3przXp4202FNyEljddIu
	eU52CNh/h3OX6SJj4Oo/3NasdjY1Rrjdpa1pcE1pof7ysyPbcxx5UDRTa4/B6Erw
	WvIgPe7j9TYQjExiqPD7uj1/Ko2jO2FmN9WyQs87hn5aSwiS7DtXc2Lm8LcHTN0p
	gk6VuJgYG9GyIInqHNU7gnyGz1GAJfjRGyYfxWuwPFobHJxWJTGkAksH5ITqRrTe
	M/g8l9wMDVQn3SOYTU4jZP8grVDeUGVMvGMTOQTI23dqBXNN/m/1pzfErQz3Qgd4
	VqXaB6T4nJWsle6Iai3mx6Vx0gaQA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpaejx1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 08:29:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6558O7YM023761;
	Fri, 5 Jun 2026 08:29:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qs132-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 08:29:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6558TLU150266444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 08:29:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DAB220043;
	Fri,  5 Jun 2026 08:29:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7E8E20040;
	Fri,  5 Jun 2026 08:29:18 +0000 (GMT)
Received: from aboo.bl1-in.ibm.com (unknown [9.123.14.187])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jun 2026 08:29:18 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH v3 0/3] powerpc: fix preempt_count imbalances in perf and kexec paths
Date: Fri,  5 Jun 2026 13:59:09 +0530
Message-ID: <20260605082912.305100-1-aboorvad@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a2288e6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=EHRFYB8xNeBlr5IdY6MA:9
X-Proofpoint-GUID: WUrHnIsSVauSbKzqaYQN4KLZg6-SJ3KJ
X-Proofpoint-ORIG-GUID: CO7LofAGwJn7OViUwSMIlvPFupV8ibLs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA3NyBTYWx0ZWRfXzArCpYSzNDLW
 hkzp/56IbMJEWvEOvL/LPrr2p5Qfyry/Q5Flo+bECTC0kq8hhBdElrI/tEUXYXX+jtzKuPHwOmt
 rdhH9L7BM6KLV7OwGonqfTqnTCYk/aFkZeqV89JAhRWFWrHH+8XkbHidClteMoYOXYU2P7aTKKF
 Y3Fb4jYsZlFK9PwWNVSRLEV9xPGZQyY8Ubrg1zst1gEJx98EK+Ph1Z/pwYFxq9aTxzegfrWLGFj
 P4aSqzY6baebLOGrR2YnXMRW3AQjYW3LEw/bM161KWhHxHKgeL3Fkit5D1X94ryImKcS9EuA9K9
 f75qBBlzBmnCwDE+qauzyaQgHFf0INSlpI/90Yc588Eg+5Vrtvm5NOAJG/DxLR/I+12ELks3Wgl
 5u40HZiv+IEmsCLHHDktInOlT/2Dix9EYoSj/uV72nYKlB9/DUucB9uYqAbR0nFRIYI54BPq8sL
 izAOxoPZQpH5965zKaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050077

Hi all,

This patch series fixes some minor preempt_count bookkeeping issues in
arch/powerpc/ found during a preemption leak audit prompted by the
lazy/full preemption model changes. These are get_cpu/put_cpu and
get_cpu_var/put_cpu_var pairing errors that leave preempt_count
incorrectly elevated or underflowed.

v2 -> v3:
 - Patches 2 and 3: use raw_smp_processor_id() instead of
   smp_processor_id(). Both paths run with interrupts
   disabled, so the plain accessor is sufficient.

v2: https://lore.kernel.org/all/20260603062743.1152253-1-aboorvad@linux.ibm.com/

v1: https://lore.kernel.org/all/20260518050855.1147242-1-aboorvad@linux.ibm.com/

Testing:
 - Patches 2 and 3: kexec boot-tested on PowerNV (powernv_defconfig)
   and pseries (pseries_defconfig).
 - Patch 1: compile-tested only (ppc64e_defconfig + CONFIG_FSL_EMB_PERFMON);
   no e500/fsl_emb hardware to runtime-test.

Please let me know your comments.

Thanks,
Aboorva

Aboorva Devarajan (3):
  powerpc/perf: fix preempt count underflow in fsl_emb_pmu_del
  powerpc/powernv: fix preempt count leak in
    pnv_kexec_wait_secondaries_down
  powerpc/kexec: fix double get_cpu() imbalance in kexec_prepare_cpus

 arch/powerpc/kexec/core_64.c           | 4 +---
 arch/powerpc/perf/core-fsl-emb.c       | 3 ++-
 arch/powerpc/platforms/powernv/setup.c | 3 ++-
 3 files changed, 5 insertions(+), 5 deletions(-)


base-commit: 03da3bc22934393e1dcc63ed3c50457b6d7e345e
-- 
2.54.0


