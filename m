Return-Path: <linuxppc-dev+bounces-28766-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7894CCA5FE2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 16:47:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxF7D6dSgz30TY;
	Sat, 03 Oct 2026 02:47:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790959624;
	cv=none; b=AVAlxEINOENAyO3+nifdzrlFtqL5rUsjR+bHHrBP9gUuBBg5/TsVLuN+TlcjmLlFwyECAf33y4gAK5BYSN/AHQPBsHVP5y0HCxX2vZyB7PrHqPaEmh+eF7uPBZM30/dkL3XethH5u8excN8PJyp4glehyd381l9ichXo/DpFLfCO1l/nBImmq00JrUnfx/ucYdxT2gwb+VPwsxvZSWzFUkKPbT15OeOZxNJguePh94aeMDYdXLXWGcp6eR/O2pATjPsuoxzLMAADMFLzQ53u9GEzO8fYe1ASx+9Poh6LL1W2B84tHITDbXBn0tQhtyCe0YAPeA1605OIPsaXtu4NGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790959624; c=relaxed/relaxed;
	bh=g8tIMJsUPly3IN9IGeQEJnwD/GkVkR1RaqITdDvMYXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C+ews0as/JLWcv7xPOFPY5Ln1b2c0yosCRB4pYo2BjZMNakVEBIKUJEZo0OV/rRJdabtHicyl8oxDlXXmNJTCh0jU3wF59wVs3qcWHnLycs9743M4nY3oPNBwvBURvdlerOu7YmV3Y9KqGiQIHcjjfX7ByJudkeBukoymaFvXXt8tnVkb89BXftmsQRAGw1SyC0tlFBKmsT77KxDyxsBK/VBYPdHPPNJQ6RM7VGcVdY+ESV+egoMvR1uxJD/xTkCtJ+soRJWwx+Qz77eYXTQL+Wzjhfnh6LHtxx6zzyXAfwSwCPd5dNOpC2TMORW0OI0/Ttx85K6jxLXi9jXFEQECQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PCOzkX3A; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PCOzkX3A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxF7C36rNz30Pp
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 02:47:03 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692FZaQX881183;
	Fri, 2 Oct 2026 16:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=g8tIMJsUPly3IN9IGeQEJnwD/GkVkR1RaqITdDvMY
	Xk=; b=PCOzkX3AS36gGnBa9UorpyN6tteW9DvWgzVQRJX+FVm9nLpjMhNRR4k2B
	bpEiIHcR1RWS6cFSEsNThv1H1uL3Tgd2T4jJ/W6nsJLF8D44Cg0x5HcRCrp3GzEm
	3R7jQxcPyFAa+/UwjMdVBukxpAzg39GbpR8o6kejlEUKIiKpo4UJVkVHM34b841a
	gjXZfJ1EnRBj0SaEd+vFQwIXYPsW7g2JA1UmOWIIhX8B+zR+PBcURpyOF1kP/fuX
	/J4vExnPo4S0oi+f8oBlnE/Yu9B8w4jiELb8StB/TDY4FfxdNa0aOSOtXmPTxD6h
	UTayNqOxi3Mde6wNpZX9B4DxUO80w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5ptrvpx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 16:46:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 692FHW0W2708141;
	Fri, 2 Oct 2026 16:46:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h21nu2wc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 16:46:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 692GkX9J36438454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Oct 2026 16:46:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 024B02004B;
	Fri,  2 Oct 2026 16:46:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 964D120040;
	Fri,  2 Oct 2026 16:46:28 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.216.180])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Oct 2026 16:46:28 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        ritesh.list@gmail.com, peterz@infradead.org, boqun@kernel.org,
        will@kernel.org, jhladky@redhat.com, paulmck@kernel.org
Subject: [RFC 0/3] powerpc64: Preempt count optimizations
Date: Fri,  2 Oct 2026 22:16:16 +0530
Message-ID: <20261002164619.1455143-1-sshegde@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 0gXPqQsEwNqL_CsDnEdAh2_MjpIN3o65
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2NiBTYWx0ZWRfX4ZHUakqbA9lr
 Oe23KByCaYmcq7hbvhVmHrJOIGPL1uvqDp/fYHPjCAUJ635Gs60abH93oFwfUHTcR8n0KEmb6Cp
 A8rNg0OnWxvaQjvgUnZCqLHrDW3VhUKy1ZKD8dlNydR2uK41DYZVX1kSmYeHljL06AVJ7LmmV1z
 WJ+f9A3qyadXfqp5naZ2sw5vnm/HRANI39zrIv8sua8AeJmocq221pCWV0ywr40PhuMGlcBCSfu
 ushH27pW4M3u59WkzZy57sKlsTJi/McLgfuywONAeXjkq5NE7b6Pcr+gk7HWd7YkAknY57YazgB
 rLfJ08YpUw2w4yxmZIb58MIbSwqXfNTuakPIoisp4hYbdw/t7dVC4dAtghSU05V97qluCMHq556
 gTEFYnZyYIFRnHuIU/wcPUKmbHaOW5YeAljGxpJXqiff12VKtWSyT85vZk2W+uCHf/D5YJdLwqS
 KzNR17CMM7WchM/xUlw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2NiBTYWx0ZWRfX+sxWZimG7XDq
 E3eSIf38wbE2JKRo5G3H90Jz4shQzMYfFFqBtsJGeji3h40/LRif9mtlm3liZwxneO49LoSIyi3
 we0h8XVRBRE3U7xZHKZHvqc5bPlWGOw=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abfdfed cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=WsHKUha7AAAA:8
 a=cGEWBFB16DZnsGJdHYsA:9 a=H4LAKuo8djmI0KOkngUh:22
X-Proofpoint-GUID: u5HUZapJlMR1GanJnICopMFuU6RLXpEQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020066

This is an RFC and initial implementation of the idea which was discussed
in few threads. [1][2][3]

It is lightly tested, but given changes are involving the core api,
it definitely needs more testing. Also I need to investigate the
patches in more detail and likely changelogs needs update too.

Please go ahead and try to see if works/breaks for you.

Ideas in brief:

1. Move preempt count to PACA.
   preempt count in PACA is better as it make it direct access from r13 instead of
   obtaining from thread info. 

2. Fold need_resched into preempt count.
   Also it was noted that adopting similar style of folding need_resched
   into preempt count as ARM64 is better as it helps load-store archs and
   helps to avoid accessing thread info in fast paths.

3. Enable HAS_SEPARATE_PREEMPT_RESCHED_BITS.
   While there enable the HAS_SEPARATE_PREEMPT_RESCHED_BITS which is a
   recent trick to fold the NMI bits into preempt count(29-32bits)
   instead of using separate per_cpu count.

[1] https://lore.kernel.org/all/e8efdade-161e-4efe-8bd3-abb12ad45dee@linux.ibm.com/
[2] https://lore.kernel.org/all/1eab63fc-b70d-41ef-b720-8ae77d8e56d8@linux.ibm.com/#t
[3] https://lore.kernel.org/all/20260805094219.GM687043@noisy.programming.kicks-ass.net/

Below are hackbench results.

Test                       	  Baseline    Patched   Gain
=============================================================
Hackbench process 10 groups         1.000x    0.991x   +0.88%
Hackbench process 20 groups         1.000x    0.972x   +2.81%
Hackbench process 30 groups         1.000x    0.976x   +2.37%
Hackbench process 40 groups         1.000x    0.979x   +2.11%
Hackbench process 50 groups         1.000x    0.980x   +2.05%
Hackbench process 60 groups         1.000x    0.982x   +1.79%
Hackbench thread 10  groups         1.000x    0.978x   +2.23%
Hackbench thread 20  groups         1.000x    0.971x   +2.93%
Hackbench process pipe 10 groups    1.000x    0.957x   +4.35%
Hackbench process pipe 20 groups    1.000x    0.977x   +2.32%
Hackbench process pipe 30 groups    1.000x    0.981x   +1.95%
Hackbench process pipe 40 groups    1.000x    0.981x   +1.93%
Hackbench process pipe 50 groups    1.000x    0.975x   +2.54%
Hackbench process pipe 60 groups    1.000x    1.024x   -2.37%
Hackbench thread pipe 10 groups     1.000x    0.970x   +3.04%
Hackbench thread pipe 20 groups     1.000x    0.981x   +1.89%

Things tested(no warnings/crash):
- Build and boot.
- hackbench run.
- daytrader run.
- kexec.

Shrikanth Hegde (3):
  powerpc64: move preempt count to paca
  powerpc64/preempt: Add need_resched bit inside preempt_count
  powerpc64/Kconfig: Enable HAS_SEPARATE_PREEMPT_RESCHED_BITS

 arch/powerpc/Kconfig                   |   1 +
 arch/powerpc/include/asm/paca.h        |  12 +++
 arch/powerpc/include/asm/preempt.h     | 113 +++++++++++++++++++++++++
 arch/powerpc/include/asm/thread_info.h |  14 ++-
 arch/powerpc/kernel/paca.c             |   1 +
 arch/powerpc/kexec/core_64.c           |   2 +-
 6 files changed, 139 insertions(+), 4 deletions(-)
 create mode 100644 arch/powerpc/include/asm/preempt.h

-- 
2.52.0


