Return-Path: <linuxppc-dev+bounces-21474-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C829DCD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 14:08:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPHm50f1mz2xfB;
	Tue, 26 May 2026 00:08:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779718101;
	cv=none; b=gigw5wP17n1Bwg2T2GBxmPM8I/2LpZiF5aNv12WpWI61UcitYvrWWqFOMzRlHf+n2gkfdGP4OG8oQ69tn5MPQf6bzkLR7sI9j01kP/UOlt44MGoaSAGHQlYHQBq3+291jXnjfGMUQ3lYQGWzPXr/VHWmnm+EREbwlIsqJkm7vXbKqyY0cDkm5jdDkbOhviTHGw06dTBy5YTotvb0RfDjGieNm6LNrvXw0ZE8z5yWbD79rpuq5jUW2GQp3WvAieeaGf4d7NG7hdu6Z0gTtnVtNhctPcXbSqCPFLHx/DJPnCdIE+mcfCIbjuND2P3VgQY3KwJTFgSz7rT0T8klI9qt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779718101; c=relaxed/relaxed;
	bh=W9t7WWnx+OXLaSvtSIX2N8dqmiYeyIla9CMW6K79YW0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=V8ARfRPTRSDP6jT46j0MbNjVwsnTbO7mMfcGOX2y0XeHvzhIkQ0VvDqt1yw66ZtEAriweRS/2w9tTLQKJ1T2XkA4tu2dxGG60YwyXfRWS8hiLe1mySP5OO7rYeeOA/aROS2EPMtbPMimqwSFeO9YJ+LX6CrUktWElgbeda+sjlA+8PZ8Be3BLVyio/GaIsM+mDAsctrUOk8z9SCGcbpljtvbJEXk0MtA9WYSYLPfquDTHEpXlV4fbwphaJoGBOzWVHQ7pDHzGEGc14NYzeACO9t4CAXY5kFy2HGFv1fsCGJoIOvvhTzSdUGcHYU/CHq7Y98x6YziHtd+9r2ToGU1Eg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TI58H4mQ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TI58H4mQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPHm307rxz2xbN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 00:08:16 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OK0P3v1444959;
	Mon, 25 May 2026 14:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=W9t7WWnx+OXLaSvtSIX2N8dqmiYe
	yIla9CMW6K79YW0=; b=TI58H4mQa2NW4Z5gfJotMlltXnxnJk+jbQEj+/gdGc3K
	Q2f1LYpGucsz/7kMqWlCw/5K3raG1ixeGcM2ihOYfythkmQItxdB+gTOETMF4Czq
	QcrtzEURVdjh8izAcOSMVkSTas26L7Q7BQRTyjS8aYrOzO8e5pVyLxdNaPvCggwE
	UVB6DFAFlP4jdLrmqstf+rmqdAXA9MP+nVTPV418MRp75nMk4mZmXXnZdmvUe1Wn
	eo9IxR1SfrC6zH2Mhq+7o00+V1kGXHKdzl4Uk9BoFRpfFiOLa5GkROGMqrpEjSN5
	A+bdgLAOvoBuY6PlF7zscW/RaETlb1WDEBvg/mRR/g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4s27ybf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 14:08:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64PDsAio000678;
	Mon, 25 May 2026 14:08:04 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ebs8y5511-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 14:08:04 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64PE83o926804898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 May 2026 14:08:03 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E65458065;
	Mon, 25 May 2026 14:08:03 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD63258052;
	Mon, 25 May 2026 14:07:58 +0000 (GMT)
Received: from [9.61.252.224] (unknown [9.61.252.224])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 May 2026 14:07:58 +0000 (GMT)
Message-ID: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
Date: Mon, 25 May 2026 19:37:57 +0530
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
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [BUG] sched/cache: "Make LLC id continuous" causes NULL cpumask
 dereference in build_sched_domains on POWER9
To: Peter Zijlstra <peterz@infradead.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Chen, Yu C"
 <yu.c.chen@intel.com>, tim.c.chen@linux.intel.com
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-sched@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9h-t76DtWcQtIRsO_-mwI2FGqp_Y60A_
X-Authority-Analysis: v=2.4 cv=Sq2gLvO0 c=1 sm=1 tr=0 ts=6a1457c5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=bC-a23v3AAAA:8 a=QyXUC8HyAAAA:8 a=JfrnYn6hAAAA:8 a=zd2uoN0lAAAA:8
 a=VnNF1IyMAAAA:8 a=v9Z1DADj7bz3Pr0QT2UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE0NSBTYWx0ZWRfX3jLMhVL8cll1
 jf2AagjQY+ILEuzGJJC45IZFP8fM3IEGXay+5npLHXf6pzIyM/Vj5ui5D7/4o5seclbbspGRmr4
 A5QPVxy6gxC71DxZciwrihXNEDs+I/ai8HbR5FU0r+ST6lm7/zB3HJnD5m/9EJ8MbqxPQ/uVgGF
 9HbQerRzcgMtj0XlvcDGMDjAfS5CZ+0WZYP1DjJLbDGyzfalC/AREg+Ew7IHXTeRnhx9AqF+rV9
 dqLg1EpCOzeYwiFZLvjFG5eccG/gctaDRBLZsZ9eUXCCdeP610MVyAFX9XYNVuGd0juRrwXe7q6
 XLayiSLbEwmnxrBCn1UnmdTLcelXdtLIJy5kvGd74X7ed5VZfSJfu8VsaJvCBMZUJ8xnFkmTwnb
 lmlPaT0CjMtNuolmBjmNdl637/FVaYj/Stk2Ef7ybmVKVRjeoZ1uXmIH7DEQPlYvGo4aLInwQGS
 5FeU2zUqVxV/5dfvZkQ==
X-Proofpoint-ORIG-GUID: 9h-t76DtWcQtIRsO_-mwI2FGqp_Y60A_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250145

Greetings!!!

I am seeing an early boot kernel panic due to NULL pointer dereference 
on a POWER9 (pSeries) system when testing linux-next (next-20260522).


Traces:

[    0.038567] Big cores detected but using small core scheduling
[    0.038796] BUG: Kernel NULL pointer dereference at 0x00000000
[    0.038804] Faulting instruction address: 0xc000000000e58504
[    0.038812] Oops: Kernel access of bad area, sig: 11 [#1]
[    0.038819] LE PAGE_SIZE=64K MMU=Hash  SMP NR_CPUS=8192 NUMA pSeries
[    0.038830] Modules linked in:
[    0.038840] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 
7.0.0-rc6+ #14 PREEMPTLAZY
[    0.038851] Hardware name: IBM,8375-42A POWER9 (architected) 0x4e0202 
0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
[    0.038860] NIP:  c000000000e58504 LR: c000000000e58500 CTR: 
0000000000000000
[    0.038869] REGS: c0000000090e78e0 TRAP: 0380   Not tainted (7.0.0-rc6+)
[    0.038878] MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 
44002242  XER: 20040003
[    0.038907] CFAR: c00000000093f3f0 IRQMASK: 0
[    0.038907] GPR00: c00000000038b3b8 c0000000090e7b80 c00000000259a800 
0000000000000000
[    0.038907] GPR04: 0000000000000038 0000000000000038 c00000000c6e2560 
0000000000000000
[    0.038907] GPR08: 0000000000000000 0000000000000037 0000ffffffffffff 
0000000000000000
[    0.038907] GPR12: c000000000072730 c0000000051b0000 c00000000c6ee560 
00000000ffffffff
[    0.038907] GPR16: 0000000000000000 0000000000000038 c0000000032c6b08 
fffffffffffffff6
[    0.038907] GPR20: 0000000000000000 c000000004d1a6e0 0000000000000000 
0000000000000000
[    0.038907] GPR24: 0000000000000000 0000000000000000 00000000ffffffff 
c00000000a3bf940
[    0.038907] GPR28: 0000000000000038 0000000000000000 0000000000000000 
0000000000000000
[    0.039029] NIP [c000000000e58504] _find_first_bit+0x44/0x130
[    0.039043] LR [c000000000e58500] _find_first_bit+0x40/0x130
[    0.039054] Call Trace:
[    0.039060] [c0000000090e7b80] [c00000000416af20] 
schedutil_gov+0x0/0xa0 (unreliable)
[    0.039076] [c0000000090e7bc0] [c00000000038b3b8] 
build_sched_domains+0xad8/0xe50
[    0.039089] [c0000000090e7ce0] [c000000003045d78] 
sched_init_smp+0xa8/0x164
[    0.039102] [c0000000090e7d30] [c00000000300f374] 
kernel_init_freeable+0x250/0x370
[    0.039117] [c0000000090e7de0] [c000000000011f90] kernel_init+0x34/0x1e4
[    0.039129] [c0000000090e7e50] [c00000000000debc] 
ret_from_kernel_user_thread+0x14/0x1c
[    0.039142] ---- interrupt: 0 at 0x0
[    0.039150] Code: 41820090 7c0802a6 393cffff fbe10038 7c7f1b78 
fba10028 fbc10030 3bc00000 793dd7e2 f8010050 4bae6e9d 60000000 
<e93f0000> 2c290000 408200bc 283c0040
[    0.039196] ---[ end trace 0000000000000000 ]---


Git bisect is pointing to b5ea300a17e3 sched/cache: Make LLC id 
continuous as first bad commit.


Git Bisect Logs:


# git bisect log
git bisect start
# status: waiting for both good and bad commits
# bad: [c1ecb239fa3456529a32255359fc78b69eb9d847] Add linux-next 
specific files for 20260522
git bisect bad c1ecb239fa3456529a32255359fc78b69eb9d847
# status: waiting for good commit(s), bad commit known
# good: [5200f5f493f79f14bbdc349e402a40dfb32f23c8] Linux 7.1-rc4
git bisect good 5200f5f493f79f14bbdc349e402a40dfb32f23c8
# good: [7cd27a0d57b8539366c98bb04fe48d1aff779ea9] Merge branch 'main' 
of https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect good 7cd27a0d57b8539366c98bb04fe48d1aff779ea9
# good: [efb3dd6031ec9858c7285fd673970320c86c01f3] Merge branch 'next' 
of https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
git bisect good efb3dd6031ec9858c7285fd673970320c86c01f3
# bad: [1a6066d1c1243fdc5ed464032bbdf12e6710c027] Merge branch 
'driver-core-next' of 
https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git
git bisect bad 1a6066d1c1243fdc5ed464032bbdf12e6710c027
# good: [409a99cbc316d912c999fd75b9df042b25900e50] Merge branch 
'for-next' of 
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
git bisect good 409a99cbc316d912c999fd75b9df042b25900e50
# bad: [af73f6b022c8c09a3234176892a18216be4cd984] Merge branch 'next' of 
git://git.kernel.org/pub/scm/virt/kvm/kvm.git
git bisect bad af73f6b022c8c09a3234176892a18216be4cd984
# bad: [6a459eb254e4bff61546587eccd3091955123d24] Merge branch into 
tip/master: 'sched/core'
git bisect bad 6a459eb254e4bff61546587eccd3091955123d24
# good: [71ba4bb66c3a9287245d0f5fcfb27d4b951ba402] Merge branch into 
tip/master: 'locking/core'
git bisect good 71ba4bb66c3a9287245d0f5fcfb27d4b951ba402
# good: [f3b45696a160a2230d846de8f706e835984ae65b] Merge branch into 
tip/master: 'objtool/core'
git bisect good f3b45696a160a2230d846de8f706e835984ae65b
# bad: [c99b8593b060931c5a0a4b701689f8d6a2c00dbf] sched/cache: Fix stale 
preferred_llc for a new task
git bisect bad c99b8593b060931c5a0a4b701689f8d6a2c00dbf
# bad: [5b1d5e6db20a6c64ffb95d04578db8c4b0228eea] sched/cache: Respect 
LLC preference in task migration and detach
git bisect bad 5b1d5e6db20a6c64ffb95d04578db8c4b0228eea
# bad: [46afe3af7ead57190b6d362e214814ec804e3b7b] sched/cache: Track 
LLC-preferred tasks per runqueue
git bisect bad 46afe3af7ead57190b6d362e214814ec804e3b7b
# good: [f025ef275388742643a2c33f00a0d9c0af3112ee] sched/cache: Record 
per LLC utilization to guide cache aware scheduling decisions
git bisect good f025ef275388742643a2c33f00a0d9c0af3112ee
# bad: [b5ea300a17e37eada7a98561fbd34a3054578713] sched/cache: Make LLC 
id continuous
git bisect bad b5ea300a17e37eada7a98561fbd34a3054578713
# good: [23b2b5ccc45ce2a38b9336a916088fffdc4cdfb1] sched/cache: 
Introduce helper functions to enforce LLC migration policy
git bisect good 23b2b5ccc45ce2a38b9336a916088fffdc4cdfb1
# first bad commit: [b5ea300a17e37eada7a98561fbd34a3054578713] 
sched/cache: Make LLC id continuous


b5ea300a17e37eada7a98561fbd34a3054578713 is the first bad commit
commit b5ea300a17e37eada7a98561fbd34a3054578713
Author: Tim Chen <tim.c.chen@linux.intel.com>
Date:   Wed Apr 1 14:52:17 2026 -0700

     sched/cache: Make LLC id continuous

     Introduce an index mapping between CPUs and their LLCs. This provides
     a roughly continuous per LLC index needed for cache-aware load 
balancing in
     later patches.

     The existing per_cpu llc_id usually points to the first CPU of the
     LLC domain, which is sparse and unsuitable as an array index. Using
     llc_id directly would waste memory.

     With the new mapping, CPUs in the same LLC share an approximate
     continuous id:

       per_cpu(llc_id, CPU=0...15)  = 0
       per_cpu(llc_id, CPU=16...31) = 1
       per_cpu(llc_id, CPU=32...47) = 2
       ...

     Note that the LLC IDs are allocated via bitmask, so the IDs may be
     reused during CPU offline->online transitions.

     Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
     Originally-by: K Prateek Nayak <kprateek.nayak@amd.com>
     Co-developed-by: Chen Yu <yu.c.chen@intel.com>
     Signed-off-by: Chen Yu <yu.c.chen@intel.com>
     Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
     Link: 
https://patch.msgid.link/047ef46339e4db497b54a89940a7ebedf27fcf28.1775065312.git.tim.c.chen@linux.intel.com

  kernel/sched/core.c     |  2 ++
  kernel/sched/sched.h    |  3 ++
  kernel/sched/topology.c | 90 
+++++++++++++++++++++++++++++++++++++++++++++++--
  3 files changed, 93 insertions(+), 2 deletions(-)


If you happen to fix this, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.



