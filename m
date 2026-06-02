Return-Path: <linuxppc-dev+bounces-21907-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7C3CD6E60
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 15:25:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVF573Wlyz2xLm;
	Wed, 03 Jun 2026 01:25:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780413915;
	cv=none; b=MmMabir4ryMLReW1/0xlsR1n7n0dromx0Ivxk23TfUZFMQeGQxY0T31p2OWeKMX8rlXABXk6T07mUTwsR6GcFpW4IiDSh9YPfbxlczJcOuvSzGglBcW/uSvr5Hw+YZ7d9OtoZ64kSRjFKK2z5deHaN7vwo+Me7B+HOwH7osnw5Ay8NjDJKns5wiWjgyNIsSIwKSYjoIBgoBqubOyfDIq4LdyqmtA7C6+Oxkt451MSNqpQ3c3mkPRnH3fDCyvXhCA89P+mRdm7t9M329QIH2arBNk6tRAqNHifKMpSR9DJ0hKFSuO4AhCZszLQLIjTRVZTWqeEL83CfNod+bKTPoddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780413915; c=relaxed/relaxed;
	bh=t1nVCptikTR6x52QmYDOPmNtwXdnODnakFb/tZ8Sl/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JNGh8IiTdsHo10CUWVyTL74SuHx4sNU65JziJvZjw3ZQ0o7CakDYK8PIB2QoDA9FdQcprVhT6vOESBQFIerCvvy878HFla0W1pXXyI5oifI2R0rrzhA/cKxlILMcRqsAYjlmmFOGDowIDlFn0U4BxDhKWUvWolLbx/0SSWvXZoxwS+ttilw4KQxyRyNvqtgj40bKFpFKxcXRs5x8hjXyccXsib/4pPw6GvDPFcvADTRJt5LCsV//EKKWaqERzDDpj6JkNv1oP4niCawIlbB6gpUXBxhzYClXwFfUUBRyIgz5bLTciXb0lfm1Wr8KMPr8zPYrRYWd2ksQQYSzPyAqFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ngs2lQFl; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ngs2lQFl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVF561mR0z2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 01:25:13 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65244Ngw1640981;
	Tue, 2 Jun 2026 15:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=t1nVCp
	tikTR6x52QmYDOPmNtwXdnODnakFb/tZ8Sl/A=; b=Ngs2lQFl1Ywqa1uAWq4PAS
	61UiyV/jzlonDk4DQIIoPN92cIK6Z2autQs2Y2Xv4TKJEINEilFcdPlcDS+xosi/
	imU/mLO2/5FO051pTSro6qagHWXHhXLt6OTBYvg33thHgDAOlmMqGrZyl6xHi8vy
	qJhS7r6NgfhBSkCV+Qrx5IwyrUg4S4fVSkY6K72Q7IhLMy+iN1SXzJebtgBOWKDo
	Re5lBBFoNceGG5ZCkyySma88fn2c8IEo61CNy9waeOwpwZv/kVp+byByN0Ix1GBl
	rZ5JPLvqHWMtq+3JAWZZOsh2K7k7wAnb+w1wMzVjyiFaSjW/2WwvJFBBetuSc9jQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahpdcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 15:25:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652FO5Qu008885;
	Tue, 2 Jun 2026 15:25:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k3veq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 15:25:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652FOwuZ51577272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 15:24:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E2342004B;
	Tue,  2 Jun 2026 15:24:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F20F20040;
	Tue,  2 Jun 2026 15:24:55 +0000 (GMT)
Received: from [9.124.223.169] (unknown [9.124.223.169])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 15:24:55 +0000 (GMT)
Message-ID: <87715824-b1b8-48ed-a58b-aceefb14aede@linux.ibm.com>
Date: Tue, 2 Jun 2026 20:54:54 +0530
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
Subject: Re: [next20260529]powerpc/pseries: multiple WARNs: RCU not watching
 for tracepoint and lockdep_hardirq_context() during boot and cpuidle
 (Power11)
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>
References: <b44aefc5-e066-478b-8d34-50d2d0deab6b@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <b44aefc5-e066-478b-8d34-50d2d0deab6b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE0NSBTYWx0ZWRfX05bZq+4PhPpy
 rncrim6OvZtHvf+0rNYHW9iM3iJYnLkuTJL7eMfLizryjbjsZiX2nkIDS2Ajbx3maDp2Uhg8YOe
 6+Bi8QjB28nC9kAPxYFSONSzNtwCjAcm/w/8nPRjzzrjh81AmrpC6sJo8rttd5TtGDLRb6A1hLg
 /TyJakX2k45WJ16etQQAeeq48wTKUzjHoWcoEO8yyhcYlMyq4e5HTfB/uFqDdsZaf6NCUCLg8VS
 3eo06aaiREWXRNirR11g8DZVUMFT8t0T4EGYSD8jVbuZ6mu2isDvul8d9jvlm12xh0/ENg+lKQc
 36MzqmZESY3GQeWCd69tqDrZWBlqa9cB79NTxyAQDCfbz3zc4GAmnXLdZJyw40i6wLE3GHZftnx
 Pk4QFGyQO7kT64pioQZczgnUwU6zRlx75nKcmklA9PXOABrkD+r0/y3iOR78WO2mDptIfpMadpe
 dyYJS01188F+lRBYkKQ==
X-Proofpoint-ORIG-GUID: guavw2pbNBO7pCvQ0cz7KtvAagNewpND
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1ef5cf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Ni-Yau-3PeJGwA-dYk4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: t4JteFHSe2Z9TwbYFzNIxy2-r2k_aIF5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020145

Hi Venkat, Thanks for the report.

On 6/1/26 6:57 PM, Venkat Rao Bagalkote wrote:
> Greetings!!!
> 
> 
> I am observing multiple reproducible WARN_ONs related to RCU and lockdep 
> IRQ state tracking on a Power11 pSeries system when running on latest 
> linux-next kernel.
> 
> 
> Environment:
>    Architecture: ppc64le (Power11, pSeries LPAR)
>    Kernel: 7.1.0-rc5-next-20260529
>    Config: PREEMPT(lazy)
>            CONFIG_LOCKDEP=y
>            CONFIG_PROVE_LOCKING=y
> 
> 
> Warning1:
> 
> [    0.008277] ------------[ cut here ]------------
> [    0.008285] RCU not watching for tracepoint
> [    0.008294] WARNING: ./include/trace/events/preemptirq.h:36 at 
> trace_hardirqs_off+0x16c/0x1a0, CPU#1: swapper/1/0
> [    0.008306] Modules linked in:
> [    0.008316] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 7.1.0- 
> rc5-next-20260529 #1 PREEMPT(lazy)
> [    0.008322] Hardware name: IBM,9080-HEX Power11 (architected) 
> 0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
> [    0.008327] NIP:  c0000000004bb2a8 LR: c0000000004bb2a4 CTR: 
> 0000000000000000
> [    0.008331] REGS: c0000000049cb690 TRAP: 0700   Not tainted (7.1.0- 
> rc5-next-20260529)
> [    0.008336] MSR:  8000000000021033 <SF,ME,IR,DR,RI,LE> CR: 44000208 
> XER: 00000005
> [    0.008348] CFAR: c00000000022e9d4 IRQMASK: 3
> [    0.008348] GPR00: c0000000004bb2a4 c0000000049cb950 c000000001ccf100 
> 000000000000001f
> [    0.008348] GPR04: 3fffffffffff7fff c0000000049cb740 c0000000049cb738 
> 0000000000000000
> [    0.008348] GPR08: c0000000029d1230 0000000000000001 c0000000049e8000 
> 0000000000000003
> [    0.008348] GPR12: c000000002d514e0 c000000effffeb00 0000000000000000 
> 0000000000000000
> [    0.008348] GPR16: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [    0.008348] GPR20: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [    0.008348] GPR24: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [    0.008348] GPR28: 0000000000000000 0000000000000001 c000000002414988 
> c00000000005be40
> [    0.008403] NIP [c0000000004bb2a8] trace_hardirqs_off+0x16c/0x1a0
> [    0.008408] LR [c0000000004bb2a4] trace_hardirqs_off+0x168/0x1a0
> [    0.008413] Call Trace:
> [    0.008416] [c0000000049cb950] [c0000000004bb2a4] 
> trace_hardirqs_off+0x168/0x1a0 (unreliable)
> [    0.008423] [c0000000049cb9d0] [c00000000005be40] 
> arch_interrupt_enter_prepare+0xa0/0x19c
> [    0.008430] [c0000000049cba00] [c00000000005bf78] 
> doorbell_exception+0x3c/0x4c4
> [    0.008436] [c0000000049cbaa0] [c00000000000a2fc] 
> doorbell_super_common_virt+0x28c/0x290
> [    0.008443] ---- interrupt: a00 at plpar_hcall_norets_notrace+0x18/0x2c
> [    0.008449] NIP:  c0000000001b4fc8 LR: c0000000001bcea0 CTR: 
> 0000000000000000
> [    0.008453] REGS: c0000000049cbad0 TRAP: 0a00   Not tainted (7.1.0- 
> rc5-next-20260529)
> [    0.008457] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
> 24000008  XER: 00000000
> [    0.008469] CFAR: 0000000000000000 IRQMASK: 0
> [    0.008469] GPR00: 0000000000000000 c0000000049cbd90 c000000001ccf100 
> 0000000000000000
> [    0.008469] GPR04: 0000000000000000 8004000038407c10 0000000000000000 
> 0000000000000003
> [    0.008469] GPR08: 0000000000000001 0000000000000000 0000000000000090 
> 0000000000000001
> [    0.008469] GPR12: 8004000038407c00 c000000effffeb00 0000000000000000 
> 000000002ef01820
> [    0.008469] GPR16: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [    0.008469] GPR20: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000001
> [    0.008469] GPR24: 0000000000000001 000000000000dedc c000000003086150 
> 0000000000000001
> [    0.008469] GPR28: c0000000049e8000 c000000002241548 c000000002241550 
> c000000002241548
> [    0.008523] NIP [c0000000001b4fc8] plpar_hcall_norets_notrace+0x18/0x2c
> [    0.008528] LR [c0000000001bcea0] pseries_lpar_idle.part.0+0x74/0x160
> [    0.008533] ---- interrupt: a00
> [    0.008536] [c0000000049cbd90] [c0000000049cbe30] 0xc0000000049cbe30 
> (unreliable)
> [    0.008544] [c0000000049cbe10] [c000000000022c5c] 
> arch_cpu_idle+0x4c/0x120
> [    0.008551] [c0000000049cbe30] [c0000000015afe70] 
> default_idle_call+0x154/0x454
> [    0.008558] [c0000000049cbec0] [c0000000002d3dfc] 
> cpuidle_idle_call+0x2dc/0x2e0
> [    0.008565] [c0000000049cbf10] [c0000000002d3f48] do_idle+0x148/0x1f0
> [    0.008571] [c0000000049cbf60] [c0000000002d43c8] 
> cpu_startup_entry+0x4c/0x50
> [    0.008578] [c0000000049cbf90] [c00000000006371c] 
> start_secondary+0x27c/0x28c
> [    0.008585] [c0000000049cbfe0] [c00000000000e258] 
> start_secondary_prolog+0x10/0x14
> [    0.008590] Code: 4bfffcc4 60000000 3d220132 8929db46 2c090000 
> 4082ff94 3c62ffd6 3d220132 3863d398 9ba9db46 4bd73655 60000000 
> <0fe00000> 60000000 4bffff74 60000000
> [    0.008611] irq event stamp: 20
> [    0.008614] hardirqs last  enabled at (19): [<c0000000002d3dfc>] 
> cpuidle_idle_call+0x2dc/0x2e0
> [    0.008620] hardirqs last disabled at (20): [<c00000000005be40>] 
> arch_interrupt_enter_prepare+0xa0/0x19c
> [    0.008625] softirqs last  enabled at (0): [<c00000000022b6ac>] 
> copy_process+0xb24/0x1dec
> [    0.008632] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    0.008637] ---[ end trace 0000000000000000 ]---
> 

Equivalent to trace_hardirqs_off is done by irqentry_enter.
So it is not essential in arch_interrupt_enter_prepare.

irqentry_enter
	lockdep_hardirqs_off(CALLER_ADDR0);
	trace_hardirqs_off_finish();


For reference:
void trace_hardirqs_off(void)
{
         lockdep_hardirqs_off(CALLER_ADDR0);

         if (!this_cpu_read(tracing_irq_cpu)) {
                 this_cpu_write(tracing_irq_cpu, 1);
                 tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
                 trace(irq_disable, TP_ARGS(CALLER_ADDR0, CALLER_ADDR1));
         }
}

void trace_hardirqs_off_finish(void)
{
         if (!this_cpu_read(tracing_irq_cpu)) {
                 this_cpu_write(tracing_irq_cpu, 1);
                 tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
                 trace(irq_disable, TP_ARGS(CALLER_ADDR0, CALLER_ADDR1));
         }

}

> 
> Warning2:
> 
> [    0.010098] ------------[ cut here ]------------
> [    0.010103] DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
> [    0.010107] WARNING: kernel/locking/lockdep.c:4406 at 
> lockdep_hardirqs_on_prepare+0x22c/0x2d4, CPU#0: swapper/0/1
> [    0.010116] Modules linked in:
> [    0.010120] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G     W     
>     7.1.0-rc5-next-20260529 #1 PREEMPT(lazy)
> [    0.010125] Tainted: [W]=WARN
> [    0.010127] Hardware name: IBM,9080-HEX Power11 (architected) 
> 0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
> [    0.010131] NIP:  c00000000031549c LR: c000000000315498 CTR: 
> 0000000000000000
> [    0.010135] REGS: c0000000045bf100 TRAP: 0700   Tainted: G   W     
> (7.1.0-rc5-next-20260529)
> [    0.010139] MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 
> 44044228  XER: 00000005
> [    0.010147] CFAR: c00000000022e9d4 IRQMASK: 3
> [    0.010147] GPR00: c000000000315498 c0000000045bf3c0 c000000001ccf100 
> 000000000000002e
> [    0.010147] GPR04: 3fffffffffff7fff c0000000045bf1b0 c0000000045bf1a8 
> 0000000000000000
> [    0.010147] GPR08: c0000000029d1230 0000000000010002 c0000000048b2b00 
> 0000000000000003
> [    0.010147] GPR12: c000000002d514e0 c000000003ea1000 c000000000011ae4 
> 0000000000000000
> [    0.010147] GPR16: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [    0.010147] GPR20: 0000000000000000 0000000000000004 c000000000272684 
> c0000000029bb0c0
> [    0.010147] GPR24: 0000000ebc171000 c000000ebeb63850 c000000003084d00 
> c00000000308b2d0
> [    0.010147] GPR28: c00000000002a488 0000000000000001 0000000000000000 
> c000000002246e08
> [    0.010188] NIP [c00000000031549c] 
> lockdep_hardirqs_on_prepare+0x22c/0x2d4
> [    0.010192] LR [c000000000315498] 
> lockdep_hardirqs_on_prepare+0x228/0x2d4
> [    0.010196] Call Trace:
> [    0.010198] [c0000000045bf3c0] [c000000000315498] 
> lockdep_hardirqs_on_prepare+0x228/0x2d4 (unreliable)
> [    0.010204] [c0000000045bf430] [c0000000004bb778] 
> trace_hardirqs_on+0xec/0x1b0
> [    0.010209] [c0000000045bf4b0] [c0000000015ad574] 
> irqentry_exit+0x58c/0xe1c
> [    0.010213] [c0000000045bf540] [c00000000002a488] 
> timer_interrupt+0x210/0x564
> [    0.010219] [c0000000045bf5f0] [c00000000003b960] 
> __replay_soft_interrupts+0x14c/0x374
> [    0.010224] [c0000000045bf7d0] [c00000000003bd74] 
> arch_local_irq_restore.part.0+0x1ec/0x224
> [    0.010230] [c0000000045bf810] [c0000000015c17d4] 
> _raw_spin_unlock_irqrestore+0x54/0xac
> [    0.010235] [c0000000045bf840] [c0000000002cdd54] 
> set_user_nice+0x110/0x220
> [    0.010240] [c0000000045bf8e0] [c000000000266a94] 
> create_worker+0x13c/0x310
> [    0.010245] [c0000000045bf9a0] [c0000000002726f4] 
> workqueue_prepare_cpu+0x70/0xe4
> [    0.010251] [c0000000045bf9e0] [c000000000232604] 
> cpuhp_invoke_callback+0x1e8/0x3c0
> [    0.010256] [c0000000045bfa50] [c000000000232924] 
> __cpuhp_invoke_callback_range+0x148/0x230
> [    0.010261] [c0000000045bfaf0] [c000000000234f68] _cpu_up+0x19c/0x3cc
> [    0.010265] [c0000000045bfbb0] [c00000000023533c] cpu_up+0x1a4/0x1f4
> [    0.010269] [c0000000045bfc40] [c00000000203d1f4] 
> bringup_nonboot_cpus+0xbc/0x128
> [    0.010275] [c0000000045bfca0] [c00000000204b98c] smp_init+0x44/0xd0
> [    0.010279] [c0000000045bfd00] [c000000002006d4c] 
> kernel_init_freeable+0x23c/0x3b0
> [    0.010284] [c0000000045bfdc0] [c000000000011b0c] kernel_init+0x30/0x274
> [    0.010288] [c0000000045bfe30] [c00000000000debc] 
> ret_from_kernel_user_thread+0x14/0x1c
> [    0.010292] ---- interrupt: 0 at 0x0
> [    0.010296] Code: 4182ff74 3d22013c 3929c1d4 81290000 2c090000 
> 4082ff60 3c82ffda 3c62ffd9 3884f998 38634590 4bf19461 60000000 
> <0fe00000> 4bffff40 60000000 60000000
> [    0.010310] irq event stamp: 7440
> [    0.010312] hardirqs last  enabled at (7439): [<c0000000015c1824>] 
> _raw_spin_unlock_irqrestore+0xa4/0xac
> [    0.010317] hardirqs last disabled at (7440): [<c00000000003bc30>] 
> arch_local_irq_restore.part.0+0xa8/0x224
> [    0.010323] softirqs last  enabled at (0): [<c00000000022b6ac>] 
> copy_process+0xb24/0x1dec
> [    0.010328] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    0.010331] ---[ end trace 0000000000000000 ]---
> 
> 

This should be fixed by the diff where interrupts are disabled
when going to irqentry_exit.

> 
> Warning3:
> 
> [    1.718239] ------------[ cut here ]------------
> [    1.718247] RCU not watching for tracepoint
> [    1.718255] WARNING: ./include/trace/events/preemptirq.h:40 at 
> trace_hardirqs_on+0x180/0x1b0, CPU#19: swapper/19/0
> [    1.718266] Modules linked in: ibmvscsi ibmveth scsi_transport_srp 
> pseries_wdt
> [    1.718275] CPU: 19 UID: 0 PID: 0 Comm: swapper/19 Tainted: G W      
>       7.1.0-rc5-next-20260529 #1 PREEMPT(lazy)
> [    1.718280] Tainted: [W]=WARN
> [    1.718283] Hardware name: IBM,9080-HEX Power11 (architected) 
> 0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
> [    1.718287] NIP:  c0000000004bb80c LR: c0000000004bb808 CTR: 
> 0000000000000000
> [    1.718290] REGS: c000000004a4b9e0 TRAP: 0700   Tainted: G   W     
> (7.1.0-rc5-next-20260529)
> [    1.718294] MSR:  8000000002823033 <SF,VEC,VSX,FP,ME,IR,DR,RI,LE> CR: 
> 44000208  XER: 00000005
> [    1.718305] CFAR: c00000000022e9d4 IRQMASK: 3
> [    1.718305] GPR00: c0000000004bb808 c000000004a4bca0 c000000001ccf100 
> 000000000000001f
> [    1.718305] GPR04: 3fffffffffff7fff c000000004a4ba90 c000000004a4ba88 
> 0000000ebe5e2000
> [    1.718305] GPR08: 0000000000000027 0000000000000002 c000000004a62b00 
> 0000000000000003
> [    1.718305] GPR12: c000000002d514e0 c000000effff1300 0000000000000000 
> 000000002ef01a60
> [    1.718305] GPR16: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [    1.718305] GPR20: 0000000000000000 0000000000000000 0000000000000000 
> 00000000666a3c88
> [    1.718305] GPR24: c00000000105088c 000000000000dedc c000000003084d00 
> 0000000000000000
> [    1.718305] GPR28: c000000ec09fe440 0000000000000001 c000000002414988 
> c00000000003bca8
> [    1.718347] NIP [c0000000004bb80c] trace_hardirqs_on+0x180/0x1b0
> [    1.718351] LR [c0000000004bb808] trace_hardirqs_on+0x17c/0x1b0
> [    1.718355] Call Trace:
> [    1.718357] [c000000004a4bca0] [c0000000004bb808] 
> trace_hardirqs_on+0x17c/0x1b0 (unreliable)
> [    1.718362] [c000000004a4bd20] [c00000000003bca8] 
> arch_local_irq_restore.part.0+0x120/0x224
> [    1.718369] [c000000004a4bd60] [c0000000015b065c] snooze_loop+0xa0/0x270
> [    1.718374] [c000000004a4bda0] [c0000000015af06c] 
> cpuidle_enter_state+0x110/0x8fc
> [    1.718379] [c000000004a4be60] [c00000000105088c] 
> cpuidle_enter+0x50/0x74
> [    1.718384] [c000000004a4bea0] [c0000000002ca85c] call_cpuidle+0x48/0xa0
> [    1.718389] [c000000004a4bec0] [c0000000002d3c80] 
> cpuidle_idle_call+0x160/0x2e0
> [    1.718395] [c000000004a4bf10] [c0000000002d3f48] do_idle+0x148/0x1f0
> [    1.718400] [c000000004a4bf60] [c0000000002d43c8] 
> cpu_startup_entry+0x4c/0x50
> [    1.718405] [c000000004a4bf90] [c00000000006371c] 
> start_secondary+0x27c/0x28c
> [    1.718411] [c000000004a4bfe0] [c00000000000e258] 
> start_secondary_prolog+0x10/0x14
> [    1.718415] Code: 60000000 3d220132 8929db48 2c090000 4082ff64 
> 3c62ffd6 39200001 3d420132 3863d398 992adb48 4bd730f1 60000000 
> <0fe00000> 60000000 4bffff40 60000000
> [    1.718430] irq event stamp: 0
> [    1.718432] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [    1.718436] hardirqs last disabled at (0): [<c00000000022b6ac>] 
> copy_process+0xb24/0x1dec
> [    1.718442] softirqs last  enabled at (0): [<c00000000022b6ac>] 
> copy_process+0xb24/0x1dec
> [    1.718447] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    1.718450] ---[ end trace 0000000000000000 ]---
> 
> 

Idle loop is expected to use the variant without the traces.
raw_* is being used in the diff.

> 
> I am reporting all three warnings in one report, as its flagging 
> inconsistencies around IRQ enable/disable transitions.
> 
> 
> If you happen to fix this, please add below tag.
> 
> 
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> 
> 
> 
> Regards,
> 
> Venkat.
> 
> 


Can you try the below diff and check if all three gets solved?


diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
index de5601282755..a7f30875d14a 100644
--- a/arch/powerpc/include/asm/entry-common.h
+++ b/arch/powerpc/include/asm/entry-common.h
@@ -210,9 +210,6 @@ static inline void arch_interrupt_enter_prepare(struct pt_regs *regs)
         /* Enable MSR[RI] early, to support kernel SLB and hash faults */
  #endif
  
-       if (!regs_irqs_disabled(regs))
-               trace_hardirqs_off();
-
         if (user_mode(regs)) {
                 kuap_lock();
                 account_cpu_user_entry();
@@ -253,16 +250,17 @@ static inline void arch_interrupt_enter_prepare(struct pt_regs *regs)
  static inline void arch_interrupt_exit_prepare(struct pt_regs *regs)
  {
         if (user_mode(regs)) {
-               BUG_ON(regs_is_unrecoverable(regs));
-               BUG_ON(regs_irqs_disabled(regs));
+               WARN_ON(regs_is_unrecoverable(regs));
+               WARN_ON(regs_irqs_disabled(regs));
                 /*
                  * We don't need to restore AMR on the way back to userspace for KUAP.
                  * AMR can only have been unlocked if we interrupted the kernel.
                  */
                 kuap_assert_locked();
-
-               local_irq_disable();
         }
+
+       /* irqentry_exit expects to be called with interrupts disabled */
+       local_irq_disable();
  }
  
  static inline void arch_interrupt_async_enter_prepare(struct pt_regs *regs)
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index b89e7111e7b8..a0d18deb7119 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -73,7 +73,7 @@ static int snooze_loop(struct cpuidle_device *dev,
  
         set_thread_flag(TIF_POLLING_NRFLAG);
  
-       local_irq_enable();
+       raw_local_irq_enable();
  
         snooze_exit_time = get_tb() + get_snooze_timeout(dev, drv, index);
         dev->poll_time_limit = false;
@@ -100,7 +100,7 @@ static int snooze_loop(struct cpuidle_device *dev,
         if (!dev->poll_time_limit)
                 clear_thread_flag(TIF_POLLING_NRFLAG);
  
-       local_irq_disable();
+       raw_local_irq_disable();
  
         return index;
  }



