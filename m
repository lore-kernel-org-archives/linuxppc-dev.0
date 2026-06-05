Return-Path: <linuxppc-dev+bounces-22127-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1335ACD6E74
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 12:43:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gX1MR55Chz2yRM;
	Fri, 05 Jun 2026 22:43:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780663427;
	cv=none; b=dG5EEs6u06QtnNtwC08pDBQVF94hSCsDhBVkCDOTwL/xAQa0tuXuioU5lkbEABMqf/zhZINNwUDNONQwkV2DfNNfiOb8KlmGqthUllzx5NDxl5ssdDilUcXv59IYQpbZBSs7KhYUt3GLHnfYeaED/64WIfhmkpNJUDI/8+0kKAhRUGvoAwcmfOGat8gz/lJg93ZPZfWdeLaiFd5wA9WiX47v3/njvw8QZjcbT4koq8OvOsCnnAQa82nVVPvSy5xqLpCJSxxW1+PsG1y84tiPHAzXegf7nyxJKqtSU4KTVT1bUcHQXanLrjDZxXlGU7VUMLpq0s2WlQMiINFYzn0UKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780663427; c=relaxed/relaxed;
	bh=ajll7J+ZKZ6CGCwtgYqZqfHnaiHO6ClV1UvTO0WfydI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EH2fc1SfTloIsNcOowpEvzQ8e5F+cOPdcmG8m31r66KEBUrshlCMv2yQ4uvVZes3FT5pgQnUFgAq+DxNB9kuWTPuj9GCGo5vKpR+9efCegZ6Sm1K3y7EBi/3qBlHbz9m13f7Rn0x+H64Q1TtilCxbPB0M+l10Y61YQNQCCgmiyN6x7C0jTvdTxyCC1e7ZvV6Sr+vhL7RG3NKkDlF7Qwi997xxAZXqwFdPujH4WDHfokLU8V7qs6EJPGH/NbUvAHAztVpAlyLz3sVnaZS8Z9LYreJCcn+da3QbKhVxfRZLNCbfxI9CZFgUNKLaQNALeSY7ef0C9nkTmwTn/njdxu8Lg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VJo7vmt2; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VJo7vmt2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gX1MQ69j5z2yR5
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 22:43:46 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6554II3b3295133;
	Fri, 5 Jun 2026 12:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ajll7J+ZKZ6CGCwtgYqZqfHnaiHO6ClV1UvTO0Wfy
	dI=; b=VJo7vmt2VnNLKc8UpS+UtPYFeFkZ9n4Z3IpRQz/QjBye4kPyqbu2eRVTj
	4me5YDxmFrm3aY/5eRs6wBUzGJNg/SoNakZZ2kZnzT0dY4prdV8v/gKzXrkZIv8e
	tf8dsPdlRcG4rqFMTitpRKjPJclu080jc8yOw5+R8fQbqOq0rk4XfgHXreNGucCT
	UHeuT2RSmwAYsRfsSrsrRMhC1O99ybhAuK1yZZKC8YQSprAD2xzG6VimanpS/on2
	c7NXZLdviGlX04JH7gOes27vJY8VZjfyYFq7EZzWRymPk+qb0DCbD+c3NZD0vsHt
	ErbFmtnFl7PCEEdOsYYcdvNKc5VeQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnaj3y31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 12:43:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 655Cd6VD013828;
	Fri, 5 Jun 2026 12:43:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7khr86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 12:43:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 655ChYJC48038220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 12:43:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCA3720043;
	Fri,  5 Jun 2026 12:43:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84E5220040;
	Fri,  5 Jun 2026 12:43:32 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.210.124])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jun 2026 12:43:32 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        christophe.leroy@csgroup.eu
Cc: sshegde@linux.ibm.com, frederic@kernel.org,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: [PATCH v2] powerpc/vtime: Initialize starttime at boot for native accounting
Date: Fri,  5 Jun 2026 18:13:29 +0530
Message-ID: <20260605124329.377533-1-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDEyMyBTYWx0ZWRfXypDHMuACyzuF
 c9x3GXNOEZhXNkqL98DJFgCXrKpQgPwcZXq0iRXuospw3hA/zazpxawua/7k9AbYv/rVcatxpDZ
 IJVNTeX30jV5bpVT1Ao3dOJc8GUHLjDU44VILLOcY+SWnEIaSMETYgCLLxLPNGl5KWJsZcpUhty
 dBn2ppjjqni/2WVs4PMhB4jD5BVEcuzA4clvJoVgokFZpsWjftlRROP4ZBsMNq+awHfZ3eWloMH
 4UweF921IH6PpsjVDDwgPQzy/WHi/QKJ3NSj6Y4cppPRnXrMV4Wzfhm5YcanYG8CGgOM9BFvCbZ
 nuY4X/TD7Ln2OK/V3rTu1IQdivt3d9LiGWdVfUWp01UD1pOtzxkVrSu2iX6dYfubKRNbGFZO8Ko
 o83vDFIe8mB0ZUtz6JXJIizhHplg5qlI6ZBYGup5IHpX8vwt6g33/49IGimSnxZra1w1W6l+anX
 nGoF8PccBVbka90nGDg==
X-Proofpoint-ORIG-GUID: t3izKxSMt9xabiPXiWCtx7WrgV10Y8JT
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a22c47b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=UNVAPkaQegKVcrs6ZX4A:9
X-Proofpoint-GUID: t3izKxSMt9xabiPXiWCtx7WrgV10Y8JT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050123

It was observed that /proc/stat had very large value for one ore more
CPUs. It was more visible after recent code simplifications around
cpustats. 

System has 240 CPUs.

cat /proc/uptime;
194.18 46500.55
cat /proc/stat
cpu  5966 39 837032887 4650070 164 185 100 0 0 0
cpu0 108 0 837030890 19109 24 4 23 0 0 0

Since uptime is 194s, system time of each CPU can't be more than 19400.
Sum of system time  of all CPUs can't be more than 19400*240 4656000.
In fact huge value is close to mftb(). Note mftb doesn't reset on powerVM
when the LPAR restart. It only resets when whole system resets. The same
issue exists for kexec too.

This happens since starttime is not setup at init time. Once it is set
then subsequent vtime_delta will return the right delta. 

Fix it by initializing the starttime during CPU initialization. This
fixes the large times seen.

cat /proc/uptime; cat /proc/stat
15.78 3694.63
cpu  6035 35 1347 369479 23 144 49 0 0 0
cpu0 19 0 38 1508 0 1 14 0 0 0

Now, system time is reported as expected.

Fixes: cf9efce0ce31 ("powerpc: Account time using timebase rather  than PURR")
Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
Applies on top of tip/timers/nohz
at 6199f9999a9b ("sched/cputime: Handle dyntick-idle steal time correctly")

Discussion thread:
https://lore.kernel.org/all/cd10be19-e0bc-4e0c-8dac-4f1c05d0de8f@kernel.org/

Note: Backporting to earlier tags may need manual addition of
vtime_reset where needed!

v1->v2:
- Addeds tags and Fixes. (Thanks to Christophe Leroy)
v1: https://lore.kernel.org/all/20260604132429.297665-1-sshegde@linux.ibm.com/

 arch/powerpc/kernel/time.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 3460d1a5a97c..11145c40183d 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -377,7 +377,6 @@ void vtime_task_switch(struct task_struct *prev)
 	}
 }
 
-#ifdef CONFIG_NO_HZ_COMMON
 /**
  * vtime_reset - Fast forward vtime entry clocks
  *
@@ -394,6 +393,7 @@ void vtime_reset(void)
 #endif
 }
 
+#ifdef CONFIG_NO_HZ_COMMON
 /**
  * vtime_dyntick_start - Inform vtime about entry to idle-dynticks
  *
@@ -933,6 +933,7 @@ static void __init set_decrementer_max(void)
 static void __init init_decrementer_clockevent(void)
 {
 	register_decrementer_clockevent(smp_processor_id());
+	vtime_reset();
 }
 
 void secondary_cpu_time_init(void)
@@ -948,6 +949,7 @@ void secondary_cpu_time_init(void)
 	/* FIME: Should make unrelated change to move snapshot_timebase
 	 * call here ! */
 	register_decrementer_clockevent(smp_processor_id());
+	vtime_reset();
 }
 
 /*
-- 
2.47.3


