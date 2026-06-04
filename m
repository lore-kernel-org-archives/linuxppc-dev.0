Return-Path: <linuxppc-dev+bounces-22038-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2163CD6E6D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 13:24:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWQKJ1JwWz2yb9;
	Thu, 04 Jun 2026 23:24:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780579492;
	cv=none; b=M5jvR3TMXCd4wSdPKk70D2qLEG+5ueqGCKcwEyU4DeOL0ivoAiTmMHxUo+3iXkRD0PTUDabH4dtz7o70chUfJKofexZs74vijuLKi4b7ELlnk5LwekZHdIs6llhSa3O+4b+LpePkNJgEcE0C5a07YTAfPV+J9UYd4StNdIut3mWT4DEjUaxTawILOkI+JuqRJNefrE9y3ayw5kgHNc/myDAF29Fadz6aOONdBegtZ6GjC92yR1aOW0zC+6hnOzzzE+XX2AvKyVsjEiigqM6hKbpQ1klJkkBK7lVrw9MG1SBrp/k/+MMIEqSQuDS5ikAshfR/iXtj0rgrGRylR08gJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780579492; c=relaxed/relaxed;
	bh=fplJfWBZqK2GmUeYx1VLfwxuedvnEa1a3JPJbcunzaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LI/ZzZDV17E+4XPSw9uvBJQ/89hFCe5ZVdZv/9hQ1IwkG83dHJT62YE3FrulUUepCQOgM0Ngrj4Teip8Tg/3JU9LTsDxV9BmJ+6ZwYu/wpi8crtpTKFf/G7SkyRlteq+o0q3swUbsvzphDiWD0ic3QA49mJiwmidaC3GGbXr/yLbxP0bpc/tUvZ1bXc8NxmK8NVCBFtcHskFIup86iXCRPLlZ0vlz6jlba092F0nwfMkoMindKGN4kj0DNQeESDtG+s1p2KOmb512DXofhLdnkQN+K9xrolvRQVEJHNe5KHwolEEf8CZ1qQ/G9HKYlROuVVYqU5NwbmXACxdD1tTxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NLpBYAgg; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NLpBYAgg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWQKH1vQmz2yRC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 23:24:50 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654AnxPs1360394;
	Thu, 4 Jun 2026 13:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=fplJfWBZqK2GmUeYx1VLfwxuedvnEa1a3JPJbcunz
	aI=; b=NLpBYAggrDXP8skMKMz0B2YswDychhzX62n87j0jf/9HkbG3NjliVcz9f
	MTrPgdPGNfAGxtFCYGKXJ4E92xkGuuTKuyOwghMdWTWR3ZdjrYW/RPmEzUNBFgSc
	nHfUaJp4MVuAMvuqFbKFfd+PRd8zrd2jJO/1Acm5D4mxwt+o8lSwqRmKAabhXT6v
	Yi0LXx1CVmf4++ZvtVcvs47aXcWt0nLVtJBd4Tt2NguqhHUAtURI9qihZO7A2zKG
	GweJSqfhahZMxQSgJFGmE7waiMgFsZVPsTRUgz9cQI2B9jySePKa+ndwe8Pwsq2a
	f3gnqj4KXn2s1NoetOPiAqMXIhGbQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd4g257-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 13:24:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 654DO6cQ013098;
	Thu, 4 Jun 2026 13:24:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7kd7f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 13:24:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 654DOdtP52691294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jun 2026 13:24:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 124432004B;
	Thu,  4 Jun 2026 13:24:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69FEC20043;
	Thu,  4 Jun 2026 13:24:37 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.bl1-in.ibm.com (unknown [9.123.5.233])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jun 2026 13:24:37 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        christophe.leroy@csgroup.eu
Cc: sshegde@linux.ibm.com, frederic@kernel.org,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: [PATCH] powerpc/vtime: Initialize starttime at boot for native accounting
Date: Thu,  4 Jun 2026 18:54:29 +0530
Message-ID: <20260604132429.297665-1-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEyOCBTYWx0ZWRfX3mlc78EvY7eD
 ssYeLFegUfBydnGNQoj93Ys/2PtOvM6yY8iqvL+duwgH7xrfjikkECN4wwj6KOzx4WKhLRHtqBS
 xZfJiaxDWyGiNm7tBr0XDmhzyqapbhGopieIBP4PGhy+ERVQl23JkAoTLQHCP5TFHXtTf9EMXIW
 SbyQpBwfLWZHpO428pols/Rt8cEk9PRUyaSWuOpdkUGnceRmHF6q3irBPrTiaiO0j2bJ9PhZFPT
 oWIVT2XixQjOy7CpC9RiDbYn5gUOrRiut7aeHzOiA0xByRzLWylVSjTQkJdNn3HryCWxpdrMUo+
 VP7hwL5r3P6DIxBBKYTI9OMTk1gBOfte01KIzXqc7KJI0lx+ClZnWNkQAXHtXj2LLTExrIoxZMy
 tI1n6ZV2r6MX53zW1oHfjD/Tb0f/pR0OfgR0u1zPG6MxYdv+iAWnTrhiSXuzleTRQK9PVpSDY+3
 8rWBP1zDeX04NFx1srw==
X-Proofpoint-GUID: 9xvx_qLUm8tlMhuHLMoqpwZVx40Gxkoc
X-Proofpoint-ORIG-GUID: 9xvx_qLUm8tlMhuHLMoqpwZVx40Gxkoc
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a217c9c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=UNVAPkaQegKVcrs6ZX4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040128

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

Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---

Christophe, I have taken the patch as is from the discussion we had.
Let me know if i should send it with your signed-off-by tag. I have just
written the changelog. I sent it like this since tag was not there.

discussion thread:
https://lore.kernel.org/all/cd10be19-e0bc-4e0c-8dac-4f1c05d0de8f@kernel.org/

Also, does this warrant Fixes tag? I found these two likely candidates.
Likely this issues exists since beginning.
c223c90386bc powerpc32: provide VIRT_CPU_ACCOUNTING
b38a181c11d0 powerpc/time: isolate scaled cputime accounting in dedicated functions.

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


