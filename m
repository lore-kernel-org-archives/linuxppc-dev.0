Return-Path: <linuxppc-dev+bounces-21432-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0722CD5BAC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 May 2026 17:41:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gN8ZH6R5Wz3bpL;
	Sun, 24 May 2026 03:40:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779558055;
	cv=none; b=I6oSNVB/i/sE9dkIenAfxNMV5DYn3SrzfSDacHwiepyU6ABSmGugXflG7PY/nT1MuBEoBhScgZyja1bFtq4Da2biZyJq14bkFZJqiFGkPa9HFSCH3VRSYAIzckzVY+RVYG+y3vodsafB1bnp5qETzdc4XpduDiOGBvkv6msei1V06PIObAv/M3iehHGoU4+6pAge/4Tm9tUJd49NjKxcdJlnbZCY7Fliea5R2uFP+HsnAWVESos3qZ7aLFcWkO3EYKLeQAKRMrnjUwpSi8SDS6wIPGZI+QeL8c0/yljnOtfuuslk8GYH9DxwYyd07W6fc7CjMaBsiuMQFnGDsrRkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779558055; c=relaxed/relaxed;
	bh=RBf1wDYRE1VUg8Y3ZKjyTOkiPBSk1KFebh05TMM4Irc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XTntaSpP1tYwIqwh24IbqB/XkwQ0CwY4HBnLkgsNVAXytyeQ6unREnlhw+phDkoLewqXFW2UF5FIQgg60ly8ZJWEikYAkbdB9LwFw71YJX2LnRloUfIEdQHGrkE+blhEg2mHi2ueqcWi1vQ4dWfTUO3o8aasudG+kcvjmiVgF8pFLMn0XXVnEoPVi0Eai5P56q1GimBZOKWiIYbjcBsgpRZutJPvEWhpWDe2uEIdj0MChfecVWSY1bODIRdOTg39voJbPIs+/ijJsOgkox5rR3ynno9xf3/0Iw2EVqRnwGULm0kiXEwd3/2cI4pzPal71eNGGktLlTV42HA/iojt0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Xzf+D772; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Xzf+D772;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gN8ZG5TKrz2xfR
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 May 2026 03:40:54 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64N7pnem1374859;
	Sat, 23 May 2026 17:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=RBf1wDYRE1VUg8Y3ZKjyTOkiPBSk1KFebh05TMM4I
	rc=; b=Xzf+D772EKdqd5gckPZ5j3NllJ9/nq6jls/InBtFHx37veFN+aiLb+Hc0
	m8XNAkOVaNzSPLD7kQX4jKm3xyKaDM0bNG755LnjTo/yDYtjVAn6/0NnDLVdvfXp
	HWam6o2xehp+PvKZbuvn4MTXisft//8yEJgYartEGNah2kMG+JviefF9E/heOwZQ
	wnrBy53UTm6TZTi/EEsKxItsoZDlAzd6in57fuL4LBTN8oAfqCirKLD0EEO3yUhj
	BYTp7XbWq5V9/siSxo5M3ASnQjKa45Cs6+SBRPNqDxprFn8JuuEt9oRIRktsg45R
	ghzQ7g8Way3X4ByI02frMGdOKOivw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4s21png-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 May 2026 17:40:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64NHd7Cb032429;
	Sat, 23 May 2026 17:40:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eb480hxuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 May 2026 17:40:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64NHebBS43843872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 17:40:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46C7920043;
	Sat, 23 May 2026 17:40:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8882C20040;
	Sat, 23 May 2026 17:40:35 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.18.40])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 23 May 2026 17:40:35 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, tglx@kernel.org
Cc: sshegde@linux.ibm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] powerpc/irq: Use optimizations for /proc/interrupts
Date: Sat, 23 May 2026 23:10:13 +0530
Message-ID: <20260523174016.999456-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
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
X-Proofpoint-GUID: sOCiUXPmCzneE4ju14DS_UnoRXVZesfL
X-Authority-Analysis: v=2.4 cv=Sq2gLvO0 c=1 sm=1 tr=0 ts=6a11e69a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=ZHew1V-Ef7zmNSL-XegA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDE4MCBTYWx0ZWRfX/tKj4mYNrfx+
 usC4IIBoLvRf4fpFn1mjxytOpY7be5zr8kUcVkYRmKCOtuEZX6ANB1HtfvMVR7cTcSGFsOTS9rf
 9GmqEpR0arcXot/6vv5GEAZWHqxjgMqUHoksMw8YEaNdtUilCfnoRp2KItX4nnTPOZgP1BrhjTm
 eMyiJ3biks5ayO/Qjf4OabvU1dLDSqF0X8Krea7jHYfuYsyh7piwI4wwOaDeywa6n6ZOUj8MItj
 ghzwd0SOpLbAnE2IMLcj3REGQ7dt9V6m0tV6I2wNjD3M21t389ey8es6CSHVk4qQH+Ova97dPvr
 OWZ+Dy5cfKXJ5q2xs77CUzg5pCwQqBLpsjWDkqJFyLFKUtomhTROslwMfb5F29Cge9dJ1N6BsGM
 Yg/+dml9gaV/JV1FjpHdE+an8lk1u+GQFfrr/znI9+1YDynxRupGkQWYCu0N0kCEPBdexr0k9SG
 qsCaILVwJGEPdKGIq5Q==
X-Proofpoint-ORIG-GUID: sOCiUXPmCzneE4ju14DS_UnoRXVZesfL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605230180

This series is based on work by Thomas Gleixner[1]. 

There are several optimization which helps to bring the time taken to
read /proc/interrupts. Though it is not in fastpaths, still many tools
read it often and this reduction in time will save meaningful amount of
cycle over the long duration.

[1]: https://lore.kernel.org/all/20260517194421.705253664@kernel.org/

Bulk of the design/code is copied from Thomas's work on x86. powerpc had
exact pattern which made it quite easy to port.

Using micro-loops[2] of reading /proc/interrupts shows real benefit of
the series. Bulk of the gain is already achieved using Thomas's
series[1]. This series on top provide some more benefits. As the system
size goes up, benefits could be more.

[2]: https://lore.kernel.org/all/87jysxw65f.ffs@tglx/

======== Performance Data ==================
Time taken to read /proc/interrupts 1000 times[2]
Base		:  103us 
v6		:   63us
v6+patch 1+2	:   57us
v6+patch 1+2+3	:   54us

Base: tip/master at c991e3897ead ("Merge branch into tip/master: 'x86/tdx'")
Depends on v6[1] to be applied first.

Shrikanth Hegde (3):
  powerpc/irq: Move __softirq_pending out of irq_stat
  powerpc/irq: Make irqstats array based
  powerpc/irq: Suppress unlikely interrupt stats by default

 arch/powerpc/include/asm/hardirq.h |  31 ++++---
 arch/powerpc/kernel/dbell.c        |   2 +-
 arch/powerpc/kernel/irq.c          | 131 +++++++++++++++--------------
 arch/powerpc/kernel/time.c         |   6 +-
 arch/powerpc/kernel/traps.c        |  11 +--
 arch/powerpc/kernel/watchdog.c     |   2 +-
 6 files changed, 95 insertions(+), 88 deletions(-)

-- 
2.47.3


