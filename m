Return-Path: <linuxppc-dev+bounces-21814-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE80CD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2026 13:28:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTZXN4VH2z2yb9;
	Mon, 01 Jun 2026 23:28:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780320484;
	cv=none; b=Mm5bFbDiBEkFn0/l49Ng5uhjE0PZFOvttbm9g5fZrE8A8wYykIUxIivlRiuP2t6+bzpwxW2E0sUR9jjd8FSJ5hGilB8eJnPBgz0uKyuOl0lslxWhYkeeZP86g1b3/sFpQN9SSetcHx/wcRz6OJPXc33dRh+CNA+n3wVv+ZIImMm0UvTT/FLXIwKh4nWC1Chuv/ijVLY6KZXrcQllwKEvjgW0Y5TZPg4yr7G4OigesC9EPxetegwlH+fjUvKQcUcqcpR5b/ysDGgGEn9EaY/WvTW5TpIay09SkMfcKeo4tSntZDGxqJgsilvKbaiHZMvGlXS0U3xRAdwgUa27yUBurg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780320484; c=relaxed/relaxed;
	bh=+896uyyTcL3m0i2ZNTASb52Fj3oZ7ZdTOWijnsDKZao=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=UjXjq2yKTVlPtUDL0X6oHjFfvrjdl2DLcUNRcUwiLILeatBBVokLAvKieVE0dsyKBeteZYk+SgyMYMQlG9mS/CzrwgBOESJcvrOHpr01ZqbKEqgVWFYSZfmUVwlqEb6TReIiSZFK6ZnpDtwSIKbQw12zt1uC9Dq7bNFV9eZOTJU+ZseLDdO+GslAJH0ahJq7AzrMqe0xUJcPTdhzcpcVr+rVOIFbX5FXqDF8XuxbhWWImkkk6+FEzxzOgHBXQOIhUB8ImhQhTceai5pTgKB0YujQqUWvzxi6MAM4LXLPHrkBtqVTn+t5BvXR+U2Ok8JOMDxjFzkRyZlX+H8tqYOZgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DKw4YI7i; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DKw4YI7i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTZXM2yYFz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 23:28:02 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65141ht91959545;
	Mon, 1 Jun 2026 13:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=+896uyyTcL3m0i2ZNTASb52Fj3oZ
	7ZdTOWijnsDKZao=; b=DKw4YI7iNu+qBczP0jU2NKrc+G5SL3UbjWmMkwegGeRr
	PnabLY47UObNysaNhva6pb9v51D1NUWtieeuHd7frrXbsGNm8FRw5Cuox1uUiZk4
	mNgnsb0ojsrO2XXUtV7h8cpjFQmSx6K3qJyAxUG0jW14iQPqzYcRwZheVWKuUxdh
	2ULdyfx8kMM1BJnpHYqY+P7wTgjNMwkvZ8iPHKl7EJmBsczzO3utgXGwGgvE1dhP
	NmlLQoGZXKF7IT74OQprFZGzie8B40zvRChx9b4abt48TX65R7JobkSABIhMgz6q
	idqHNfUNPTsfdharUMYgeko9zYn9Xs2S2xTO5i5fYg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm4rvhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 13:27:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651DQbqb013747;
	Mon, 1 Jun 2026 13:27:53 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwy605s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 13:27:53 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651DRpCd31326766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 13:27:51 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68C495805C;
	Mon,  1 Jun 2026 13:27:51 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54ACD58059;
	Mon,  1 Jun 2026 13:27:48 +0000 (GMT)
Received: from [9.61.252.116] (unknown [9.61.252.116])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 13:27:48 +0000 (GMT)
Message-ID: <b44aefc5-e066-478b-8d34-50d2d0deab6b@linux.ibm.com>
Date: Mon, 1 Jun 2026 18:57:46 +0530
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
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Peter Zijlstra <peterz@infradead.org>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [next20260529]powerpc/pseries: multiple WARNs: RCU not watching for
 tracepoint and lockdep_hardirq_context() during boot and cpuidle (Power11)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: L1ErtMxIWt3XZBIN6jephwM-jAhaeJLN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEzMSBTYWx0ZWRfXxckBQSLhcYCS
 FXcgCRi8XJLOVmY122bxqfkwiJEf1JgLBvyyIVOko16vwrCt3xdta3wMCIyThcECHAYOK7l55xU
 3mg683WkCeeMyQeDT4kqmLmeF/7X6stJAQDU/bgJQnQLbuaklLZdO+dF/X2R9BHh6n/+bYCzqut
 9vC7hClsyFYP6DPUmO6uG1wK4BLzl9CQpXXGLOdlFqZEnaKEHgX9WXHws0Pep5dep9Ghoi38TPq
 Oe6Y0uDoPBhAQScVlFXKOxEDOWRMiyolttToEzSIwGg9IinA5qcZkBiKjHqHJePrYzzacBBGQ3H
 Mc1jFZWGeSk+Ok5VkyM9RqTDwczJ+AcaJ8tFm5pYyTPVIcl29XcPbFH+9NkLkH0dCl0pVBqdEZ9
 fRgFDmrMyuTkvHyRpK1cdGhrJX8Pz+6Ro1z20qKmybrnhz6hST3ym92uKxTqlAFzUle2VfVWHJc
 deruQUDvptySiekhefQ==
X-Proofpoint-ORIG-GUID: pR1LsMk44R_6oIP7lM9gQmTqV0tmkS12
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a1d88da cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=pC68-rA65GXy0ANEAjIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010131

Greetings!!!


I am observing multiple reproducible WARN_ONs related to RCU and lockdep 
IRQ state tracking on a Power11 pSeries system when running on latest 
linux-next kernel.


Environment:
   Architecture: ppc64le (Power11, pSeries LPAR)
   Kernel: 7.1.0-rc5-next-20260529
   Config: PREEMPT(lazy)
           CONFIG_LOCKDEP=y
           CONFIG_PROVE_LOCKING=y


Warning1:

[    0.008277] ------------[ cut here ]------------
[    0.008285] RCU not watching for tracepoint
[    0.008294] WARNING: ./include/trace/events/preemptirq.h:36 at 
trace_hardirqs_off+0x16c/0x1a0, CPU#1: swapper/1/0
[    0.008306] Modules linked in:
[    0.008316] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 
7.1.0-rc5-next-20260529 #1 PREEMPT(lazy)
[    0.008322] Hardware name: IBM,9080-HEX Power11 (architected) 
0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
[    0.008327] NIP:  c0000000004bb2a8 LR: c0000000004bb2a4 CTR: 
0000000000000000
[    0.008331] REGS: c0000000049cb690 TRAP: 0700   Not tainted 
(7.1.0-rc5-next-20260529)
[    0.008336] MSR:  8000000000021033 <SF,ME,IR,DR,RI,LE> CR: 44000208  
XER: 00000005
[    0.008348] CFAR: c00000000022e9d4 IRQMASK: 3
[    0.008348] GPR00: c0000000004bb2a4 c0000000049cb950 c000000001ccf100 
000000000000001f
[    0.008348] GPR04: 3fffffffffff7fff c0000000049cb740 c0000000049cb738 
0000000000000000
[    0.008348] GPR08: c0000000029d1230 0000000000000001 c0000000049e8000 
0000000000000003
[    0.008348] GPR12: c000000002d514e0 c000000effffeb00 0000000000000000 
0000000000000000
[    0.008348] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[    0.008348] GPR20: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[    0.008348] GPR24: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[    0.008348] GPR28: 0000000000000000 0000000000000001 c000000002414988 
c00000000005be40
[    0.008403] NIP [c0000000004bb2a8] trace_hardirqs_off+0x16c/0x1a0
[    0.008408] LR [c0000000004bb2a4] trace_hardirqs_off+0x168/0x1a0
[    0.008413] Call Trace:
[    0.008416] [c0000000049cb950] [c0000000004bb2a4] 
trace_hardirqs_off+0x168/0x1a0 (unreliable)
[    0.008423] [c0000000049cb9d0] [c00000000005be40] 
arch_interrupt_enter_prepare+0xa0/0x19c
[    0.008430] [c0000000049cba00] [c00000000005bf78] 
doorbell_exception+0x3c/0x4c4
[    0.008436] [c0000000049cbaa0] [c00000000000a2fc] 
doorbell_super_common_virt+0x28c/0x290
[    0.008443] ---- interrupt: a00 at plpar_hcall_norets_notrace+0x18/0x2c
[    0.008449] NIP:  c0000000001b4fc8 LR: c0000000001bcea0 CTR: 
0000000000000000
[    0.008453] REGS: c0000000049cbad0 TRAP: 0a00   Not tainted 
(7.1.0-rc5-next-20260529)
[    0.008457] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
24000008  XER: 00000000
[    0.008469] CFAR: 0000000000000000 IRQMASK: 0
[    0.008469] GPR00: 0000000000000000 c0000000049cbd90 c000000001ccf100 
0000000000000000
[    0.008469] GPR04: 0000000000000000 8004000038407c10 0000000000000000 
0000000000000003
[    0.008469] GPR08: 0000000000000001 0000000000000000 0000000000000090 
0000000000000001
[    0.008469] GPR12: 8004000038407c00 c000000effffeb00 0000000000000000 
000000002ef01820
[    0.008469] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[    0.008469] GPR20: 0000000000000000 0000000000000000 0000000000000000 
0000000000000001
[    0.008469] GPR24: 0000000000000001 000000000000dedc c000000003086150 
0000000000000001
[    0.008469] GPR28: c0000000049e8000 c000000002241548 c000000002241550 
c000000002241548
[    0.008523] NIP [c0000000001b4fc8] plpar_hcall_norets_notrace+0x18/0x2c
[    0.008528] LR [c0000000001bcea0] pseries_lpar_idle.part.0+0x74/0x160
[    0.008533] ---- interrupt: a00
[    0.008536] [c0000000049cbd90] [c0000000049cbe30] 0xc0000000049cbe30 
(unreliable)
[    0.008544] [c0000000049cbe10] [c000000000022c5c] 
arch_cpu_idle+0x4c/0x120
[    0.008551] [c0000000049cbe30] [c0000000015afe70] 
default_idle_call+0x154/0x454
[    0.008558] [c0000000049cbec0] [c0000000002d3dfc] 
cpuidle_idle_call+0x2dc/0x2e0
[    0.008565] [c0000000049cbf10] [c0000000002d3f48] do_idle+0x148/0x1f0
[    0.008571] [c0000000049cbf60] [c0000000002d43c8] 
cpu_startup_entry+0x4c/0x50
[    0.008578] [c0000000049cbf90] [c00000000006371c] 
start_secondary+0x27c/0x28c
[    0.008585] [c0000000049cbfe0] [c00000000000e258] 
start_secondary_prolog+0x10/0x14
[    0.008590] Code: 4bfffcc4 60000000 3d220132 8929db46 2c090000 
4082ff94 3c62ffd6 3d220132 3863d398 9ba9db46 4bd73655 60000000 
<0fe00000> 60000000 4bffff74 60000000
[    0.008611] irq event stamp: 20
[    0.008614] hardirqs last  enabled at (19): [<c0000000002d3dfc>] 
cpuidle_idle_call+0x2dc/0x2e0
[    0.008620] hardirqs last disabled at (20): [<c00000000005be40>] 
arch_interrupt_enter_prepare+0xa0/0x19c
[    0.008625] softirqs last  enabled at (0): [<c00000000022b6ac>] 
copy_process+0xb24/0x1dec
[    0.008632] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    0.008637] ---[ end trace 0000000000000000 ]---


Warning2:

[    0.010098] ------------[ cut here ]------------
[    0.010103] DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
[    0.010107] WARNING: kernel/locking/lockdep.c:4406 at 
lockdep_hardirqs_on_prepare+0x22c/0x2d4, CPU#0: swapper/0/1
[    0.010116] Modules linked in:
[    0.010120] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G     W    
        7.1.0-rc5-next-20260529 #1 PREEMPT(lazy)
[    0.010125] Tainted: [W]=WARN
[    0.010127] Hardware name: IBM,9080-HEX Power11 (architected) 
0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
[    0.010131] NIP:  c00000000031549c LR: c000000000315498 CTR: 
0000000000000000
[    0.010135] REGS: c0000000045bf100 TRAP: 0700   Tainted: G   W        
     (7.1.0-rc5-next-20260529)
[    0.010139] MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 
44044228  XER: 00000005
[    0.010147] CFAR: c00000000022e9d4 IRQMASK: 3
[    0.010147] GPR00: c000000000315498 c0000000045bf3c0 c000000001ccf100 
000000000000002e
[    0.010147] GPR04: 3fffffffffff7fff c0000000045bf1b0 c0000000045bf1a8 
0000000000000000
[    0.010147] GPR08: c0000000029d1230 0000000000010002 c0000000048b2b00 
0000000000000003
[    0.010147] GPR12: c000000002d514e0 c000000003ea1000 c000000000011ae4 
0000000000000000
[    0.010147] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[    0.010147] GPR20: 0000000000000000 0000000000000004 c000000000272684 
c0000000029bb0c0
[    0.010147] GPR24: 0000000ebc171000 c000000ebeb63850 c000000003084d00 
c00000000308b2d0
[    0.010147] GPR28: c00000000002a488 0000000000000001 0000000000000000 
c000000002246e08
[    0.010188] NIP [c00000000031549c] 
lockdep_hardirqs_on_prepare+0x22c/0x2d4
[    0.010192] LR [c000000000315498] lockdep_hardirqs_on_prepare+0x228/0x2d4
[    0.010196] Call Trace:
[    0.010198] [c0000000045bf3c0] [c000000000315498] 
lockdep_hardirqs_on_prepare+0x228/0x2d4 (unreliable)
[    0.010204] [c0000000045bf430] [c0000000004bb778] 
trace_hardirqs_on+0xec/0x1b0
[    0.010209] [c0000000045bf4b0] [c0000000015ad574] 
irqentry_exit+0x58c/0xe1c
[    0.010213] [c0000000045bf540] [c00000000002a488] 
timer_interrupt+0x210/0x564
[    0.010219] [c0000000045bf5f0] [c00000000003b960] 
__replay_soft_interrupts+0x14c/0x374
[    0.010224] [c0000000045bf7d0] [c00000000003bd74] 
arch_local_irq_restore.part.0+0x1ec/0x224
[    0.010230] [c0000000045bf810] [c0000000015c17d4] 
_raw_spin_unlock_irqrestore+0x54/0xac
[    0.010235] [c0000000045bf840] [c0000000002cdd54] 
set_user_nice+0x110/0x220
[    0.010240] [c0000000045bf8e0] [c000000000266a94] 
create_worker+0x13c/0x310
[    0.010245] [c0000000045bf9a0] [c0000000002726f4] 
workqueue_prepare_cpu+0x70/0xe4
[    0.010251] [c0000000045bf9e0] [c000000000232604] 
cpuhp_invoke_callback+0x1e8/0x3c0
[    0.010256] [c0000000045bfa50] [c000000000232924] 
__cpuhp_invoke_callback_range+0x148/0x230
[    0.010261] [c0000000045bfaf0] [c000000000234f68] _cpu_up+0x19c/0x3cc
[    0.010265] [c0000000045bfbb0] [c00000000023533c] cpu_up+0x1a4/0x1f4
[    0.010269] [c0000000045bfc40] [c00000000203d1f4] 
bringup_nonboot_cpus+0xbc/0x128
[    0.010275] [c0000000045bfca0] [c00000000204b98c] smp_init+0x44/0xd0
[    0.010279] [c0000000045bfd00] [c000000002006d4c] 
kernel_init_freeable+0x23c/0x3b0
[    0.010284] [c0000000045bfdc0] [c000000000011b0c] kernel_init+0x30/0x274
[    0.010288] [c0000000045bfe30] [c00000000000debc] 
ret_from_kernel_user_thread+0x14/0x1c
[    0.010292] ---- interrupt: 0 at 0x0
[    0.010296] Code: 4182ff74 3d22013c 3929c1d4 81290000 2c090000 
4082ff60 3c82ffda 3c62ffd9 3884f998 38634590 4bf19461 60000000 
<0fe00000> 4bffff40 60000000 60000000
[    0.010310] irq event stamp: 7440
[    0.010312] hardirqs last  enabled at (7439): [<c0000000015c1824>] 
_raw_spin_unlock_irqrestore+0xa4/0xac
[    0.010317] hardirqs last disabled at (7440): [<c00000000003bc30>] 
arch_local_irq_restore.part.0+0xa8/0x224
[    0.010323] softirqs last  enabled at (0): [<c00000000022b6ac>] 
copy_process+0xb24/0x1dec
[    0.010328] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    0.010331] ---[ end trace 0000000000000000 ]---



Warning3:

[    1.718239] ------------[ cut here ]------------
[    1.718247] RCU not watching for tracepoint
[    1.718255] WARNING: ./include/trace/events/preemptirq.h:40 at 
trace_hardirqs_on+0x180/0x1b0, CPU#19: swapper/19/0
[    1.718266] Modules linked in: ibmvscsi ibmveth scsi_transport_srp 
pseries_wdt
[    1.718275] CPU: 19 UID: 0 PID: 0 Comm: swapper/19 Tainted: G       
W           7.1.0-rc5-next-20260529 #1 PREEMPT(lazy)
[    1.718280] Tainted: [W]=WARN
[    1.718283] Hardware name: IBM,9080-HEX Power11 (architected) 
0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
[    1.718287] NIP:  c0000000004bb80c LR: c0000000004bb808 CTR: 
0000000000000000
[    1.718290] REGS: c000000004a4b9e0 TRAP: 0700   Tainted: G   W        
     (7.1.0-rc5-next-20260529)
[    1.718294] MSR:  8000000002823033 <SF,VEC,VSX,FP,ME,IR,DR,RI,LE>  
CR: 44000208  XER: 00000005
[    1.718305] CFAR: c00000000022e9d4 IRQMASK: 3
[    1.718305] GPR00: c0000000004bb808 c000000004a4bca0 c000000001ccf100 
000000000000001f
[    1.718305] GPR04: 3fffffffffff7fff c000000004a4ba90 c000000004a4ba88 
0000000ebe5e2000
[    1.718305] GPR08: 0000000000000027 0000000000000002 c000000004a62b00 
0000000000000003
[    1.718305] GPR12: c000000002d514e0 c000000effff1300 0000000000000000 
000000002ef01a60
[    1.718305] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[    1.718305] GPR20: 0000000000000000 0000000000000000 0000000000000000 
00000000666a3c88
[    1.718305] GPR24: c00000000105088c 000000000000dedc c000000003084d00 
0000000000000000
[    1.718305] GPR28: c000000ec09fe440 0000000000000001 c000000002414988 
c00000000003bca8
[    1.718347] NIP [c0000000004bb80c] trace_hardirqs_on+0x180/0x1b0
[    1.718351] LR [c0000000004bb808] trace_hardirqs_on+0x17c/0x1b0
[    1.718355] Call Trace:
[    1.718357] [c000000004a4bca0] [c0000000004bb808] 
trace_hardirqs_on+0x17c/0x1b0 (unreliable)
[    1.718362] [c000000004a4bd20] [c00000000003bca8] 
arch_local_irq_restore.part.0+0x120/0x224
[    1.718369] [c000000004a4bd60] [c0000000015b065c] snooze_loop+0xa0/0x270
[    1.718374] [c000000004a4bda0] [c0000000015af06c] 
cpuidle_enter_state+0x110/0x8fc
[    1.718379] [c000000004a4be60] [c00000000105088c] cpuidle_enter+0x50/0x74
[    1.718384] [c000000004a4bea0] [c0000000002ca85c] call_cpuidle+0x48/0xa0
[    1.718389] [c000000004a4bec0] [c0000000002d3c80] 
cpuidle_idle_call+0x160/0x2e0
[    1.718395] [c000000004a4bf10] [c0000000002d3f48] do_idle+0x148/0x1f0
[    1.718400] [c000000004a4bf60] [c0000000002d43c8] 
cpu_startup_entry+0x4c/0x50
[    1.718405] [c000000004a4bf90] [c00000000006371c] 
start_secondary+0x27c/0x28c
[    1.718411] [c000000004a4bfe0] [c00000000000e258] 
start_secondary_prolog+0x10/0x14
[    1.718415] Code: 60000000 3d220132 8929db48 2c090000 4082ff64 
3c62ffd6 39200001 3d420132 3863d398 992adb48 4bd730f1 60000000 
<0fe00000> 60000000 4bffff40 60000000
[    1.718430] irq event stamp: 0
[    1.718432] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[    1.718436] hardirqs last disabled at (0): [<c00000000022b6ac>] 
copy_process+0xb24/0x1dec
[    1.718442] softirqs last  enabled at (0): [<c00000000022b6ac>] 
copy_process+0xb24/0x1dec
[    1.718447] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    1.718450] ---[ end trace 0000000000000000 ]---



I am reporting all three warnings in one report, as its flagging 
inconsistencies around IRQ enable/disable transitions.


If you happen to fix this, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>



Regards,

Venkat.



