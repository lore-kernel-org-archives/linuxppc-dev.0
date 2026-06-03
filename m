Return-Path: <linuxppc-dev+bounces-21952-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28DDCD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 06:28:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVd725wwyz2xc2;
	Wed, 03 Jun 2026 16:28:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780468094;
	cv=none; b=L+bJ/+IhCUZxnUuVNOjeF9y6ax2D8g1YdWtrOajCWI/eo5GXH4zfZ+4B5c1vn8GplkglZhIKpMCgwpzaoMAyrS5tKxkW0ODdp8L+3d9FOgknXwE36ab+x1m3+SyeJk/o3hGo4kt26ZzJhz5EXr+iY9SYvdhyMuHPXBv2i7B3mzvgcERkhNhCMQOEnPbViKm+QjpFsVtSwjRDB2j33mRLTXYNb5HzjqufwGyl/mQpfY1OBg2NiyePkFAOAVjIQF+2WHFYvALGEdFuPSzbyvFFRNEpWNwCj5FcaRD7Kz5EsG1lyfwfWh/TFvY85hXYxY6vRVn23mH0CMJX4urDjvgA2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780468094; c=relaxed/relaxed;
	bh=5RuyxDjFPIpjwknUPXiV6WeC/V+p6pLbpxglLwF1LmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LK9jYbpxi0Gt9mIwhpRy8yobc17+kEBLz8wuPnXAA4AIw0H81yJt/+DTpHqae4SwUN7igHoMISeZFLvoqnxE72AGTgMaWREXNF9Y39wSivYBsJNrNUqlDYGxTEeSDgwCSuRmzc5p64JKrQktnjZZoC/oB8ksbA+Em3V2iwS1PwsFAXOh+7wwg0xWRulOQv2D1iFisb9p/f2oeX7DLmL6ciG5ryLm551kYY9m5EXhK0dlWCb8XuJ4Rlm6f3H2eir1J3TMIAH8HGdFygs9m8jSVx1FVPn3VLCwAGH1ueqmHITheS6uOnWalTrmyMlbnC7NKYBieZtp2WC8GyLiIxozUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FGxCSZuZ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FGxCSZuZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVd713V1Vz2ySl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 16:28:13 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653669BW2897645;
	Wed, 3 Jun 2026 06:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5RuyxDjFPIpjwknUP
	XiV6WeC/V+p6pLbpxglLwF1LmU=; b=FGxCSZuZhEGWpFGdLnc/owU60pU/5LiLL
	LONOZF7LToiDaQsxs7ENuj24iF2GROGc9HWUrq+6eCfiFmXIzKvrZiW1ErGpnUdm
	7nQoXTNrFoGfG98Y+CUDTeUrLp5Z/M/yGsiy6PPR0cEe7qyEEq9wFnSJqfT40fob
	D2t0HxVew2t4PMCy+51Wh685y/EuTNHdpLtXlRPtURyKoB9IjhOl4AtH7cUfeWJe
	1MVzjoDrDMur1H6gBRChUCod3t8+wMSR9uBwIzo5SwP6ZHSOK8LSEBmGWFKvDNZN
	gsyMXyKpfwrDiXFhIa6NNneh6WW1/uT1C4U5Lh15xZX76mJUeBgBg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjq9f9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 06:28:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6536Oadj022721;
	Wed, 3 Jun 2026 06:28:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakvy04k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 06:28:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6536S5gb50987502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 06:28:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 224CB20043;
	Wed,  3 Jun 2026 06:28:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDB3220040;
	Wed,  3 Jun 2026 06:28:01 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.39.24.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 06:28:01 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH 3/3] powerpc/kexec: fix double get_cpu() imbalance in kexec_prepare_cpus
Date: Wed,  3 Jun 2026 11:57:43 +0530
Message-ID: <20260603062743.1152253-4-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603062743.1152253-1-aboorvad@linux.ibm.com>
References: <20260603062743.1152253-1-aboorvad@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: yUIY4cDnkKZJp1H322_jgn677HP3tL2k
X-Proofpoint-GUID: u7iXvpUrp6lWhCOYoS685Vm5LWcDY0du
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a1fc97a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=NZuQ31_9CfGeVvh8xa4A:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA1NiBTYWx0ZWRfXysn2RhiqjE8Y
 TzpEo4UPiNtYXhYBF2pXXLCho1VY2q5T8wKSi+iazq5fq1fQq3rmoPtIMZgiWV9ltGd7UPhe/wi
 YXqxSvk0s41cfCDGTdU3aW8xV38oQ6bGR+GyDPwQ3zvaOOPRF6nxChXH/awc3rlryGu+nKArY0S
 5eqFYaurM/LNmJ24HGrcYS5N3zIaNkSAkS03eHdYDNFA4rocy/LgPwR31gwQwEeYLRISusc157V
 gl2pEg1YvWJfJB8ELREl9uTQYS6VigK0wv3iE9WDj7YTccT9MCkZ/8stybQsAq9Y6klLedzxGfv
 H9w6ZlqCkajilGLFT4yMCYbRuq8ZPV0+vH418p7oSLWMWHwa5jfR+q/Pw8bSJxobJf20urKWTk9
 TiKAqNVGz7g6lQzmDNP5XADIrjj4eDj5LTr8AhOWDuv2puIPZqqkiJDC1ViZ3M7gyAZSzXoQU05
 Jx7zER+aHgwy6s28aBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030056

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

kexec_prepare_cpus() calls local_irq_disable()/hard_irq_disable()
before invoking kexec_prepare_cpus_wait(), so the CPU is already pinned
and the get_cpu()/put_cpu() preempt_disable() bracketing is unnecessary.
Only the current CPU id is needed, so replace get_cpu() with
smp_processor_id() and drop the now-unneeded put_cpu().

Fixes: 1fc711f7ffb0 ("powerpc/kexec: Fix race in kexec shutdown")
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 arch/powerpc/kexec/core_64.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 825ab8a88f18..d7bdc362d497 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -169,7 +169,7 @@ static void kexec_prepare_cpus_wait(int wait_state)
 	int my_cpu, i, notified=-1;
 
 	hw_breakpoint_disable();
-	my_cpu = get_cpu();
+	my_cpu = smp_processor_id();
 	/* Make sure each CPU has at least made it to the state we need.
 	 *
 	 * FIXME: There is a (slim) chance of a problem if not all of the CPUs
@@ -267,8 +267,6 @@ static void kexec_prepare_cpus(void)
 	/* after we tell the others to go down */
 	if (ppc_md.kexec_cpu_down)
 		ppc_md.kexec_cpu_down(0, 0);
-
-	put_cpu();
 }
 
 #else /* ! SMP */
-- 
2.54.0


