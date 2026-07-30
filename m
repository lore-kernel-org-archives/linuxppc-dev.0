Return-Path: <linuxppc-dev+bounces-25073-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAA2C54FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 06:44:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9fnQ3x26z2xwH;
	Thu, 30 Jul 2026 16:44:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785393866;
	cv=none; b=n+I/SGyYO/ODOwe1zrSBevWMegfnwCI90fIUc7g54KNmoFHbu6ccjWtC5TAiUI+t8e64boLH2Jy9EG92FW2RhVCuo5wxFFfH4Hp2jfjorbDFeKGNJHJsQ0S+7WXZJJeWsOqclunWFSZlqRdhk2fEe07KMELrlXKzgZ2WcKEdTYwRQ8jK6OkqpwPP6/JdlTCnD2UcRkbijrPzpqSJgIxD3ATxI8fYO7T261/NqG+C86w3jcB7d8SjTJlcnMkoP3vdCdmn5MZrZFApuBoJJ/hsfqBwiCgL5Bm7SoY4dQSu7KSoGZaLiJ+gC/p87hdBjr2kQ4UphehtErnfjD3o91mNJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785393866; c=relaxed/relaxed;
	bh=km7lLtTBcVCztfByq61POX8WV/UCDOOkdQKkQtVADgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLVJgcXvUyQxc9c6kLM7lytdfhzwk6Uhn+LyOuA9o2arRst6mgD0ZY6WFCNrMDW91l7k5PRyyjdM4LvWzZGMaRxi/wsqZpWrYWmkcQuvAeuSnjs59Z7jW5c+fRa4s3fIAw3YWSoa6QXFdU0zQp27ZvlS9eSYKOJLMMQ1veT9rqp+dMwPLgdqADWWy4D6ys0glWFvNsi9hrL348jDTwi/itbEEaWE6kMJHg0gQdOzRaTpG8s7dairJP/RIDDp1XrXKMnB5rvhsosLtosOlGZVQWCaW5L0X+ZZCyVLi/PlE4/XlKyFCAbxY1Kf2f1Ib6XjQ6yHDHRr9JvGwcVC91p6gQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hrqUNRKg; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hrqUNRKg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9fnP5wqrz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 16:44:25 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U3leW5037583;
	Thu, 30 Jul 2026 06:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=km7lLt
	TBcVCztfByq61POX8WV/UCDOOkdQKkQtVADgY=; b=hrqUNRKg29i8p7sU5MlIkx
	ML4iEHEmrkoVIGlDJmNQrZBmdTz/ScsM+pI24d7OkTedebAS/5D+nCdywUtCkVmE
	QDHQ6teui1JLJ/8rlZ1v7h8/8bFExb4u0LI9kdhgT6wQ1jA7C2r1S3nnhH4yey74
	nJJOMAWa2sasD3CafKnI7S/avHnEJuCLftqNxMtAem1HgAAQq8idIzZ/BzrDcU+a
	n5FBjtURwMkUe2zVJLzlhGIwq+/5KlhnUZyJjLkXwr/QDDacIshDDz4/0X/J9yxG
	K4/BhJq+dezqaQWtk5U+R6Yl0UELVP/ZKdg6Y+acYnoy6mKltzzyDPVpG4gTEQ4g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycpb6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 06:44:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U6fdK2028237;
	Thu, 30 Jul 2026 06:44:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y9v8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 06:44:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U6i6Vh29425936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 06:44:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1254E2004B;
	Thu, 30 Jul 2026 06:44:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1911B20040;
	Thu, 30 Jul 2026 06:44:03 +0000 (GMT)
Received: from [9.124.209.250] (unknown [9.124.209.250])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 06:44:02 +0000 (GMT)
Message-ID: <29a407ab-268e-4443-96dc-8f5f933cb63c@linux.ibm.com>
Date: Thu, 30 Jul 2026 12:14:01 +0530
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
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
To: Jirka Hladky <jhladky@redhat.com>
Cc: paulmck@kernel.org, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        christophe.leroy@csgroup.eu, mpe@ellerman.id.au, npiggin@gmail.com,
        bigeasy@linutronix.de, will@kernel.org, linux-kernel@vger.kernel.org
References: <20250210184334.567383-1-sshegde@linux.ibm.com>
 <20250210184334.567383-2-sshegde@linux.ibm.com>
 <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
 <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com>
 <500d8e8c-088c-4e6d-ab53-868ade6b0eda@paulmck-laptop>
 <CAE4VaGDGS8wkZj4SF5XVC3-1yDmvJxjUjThTPqVw3kxg56ssQA@mail.gmail.com>
 <e013e88a-6137-4de8-9dfd-925b707f2e01@linux.ibm.com>
 <CAE4VaGAJ9mT8-V=GRPYj8h0RXuNf6S5icrmqeOOFDnkpPMQjaw@mail.gmail.com>
 <a1e04751-eab5-465b-8238-c9f4cd40e472@linux.ibm.com>
 <CAE4VaGCaN6uBBGqbGAsxudSxMC0JdXYn2vpuDJZPFR3xxJgMYA@mail.gmail.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <CAE4VaGCaN6uBBGqbGAsxudSxMC0JdXYn2vpuDJZPFR3xxJgMYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: puI3oPKlPRUS3lh4JHHf0_P-EA_ImwYu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA0MiBTYWx0ZWRfX8FrBHLu2xN8G
 cy7VwmCkEdQSU791yQLgJvhzt/pcb3GTDhi1UX64YY6XiBn0j7cekvs2EPxz8J5etM+CCNNiisS
 +jSY5IIB06Dm2W1KxMwVgaDmfFqKEHtCkAjbe/s28F3ldXsWY8BDT6t4G8wAQ1N+NUGllGLKN9s
 JP/ef0ojbZwMazdUHRW99HcFFNZjWmoeoZY1ZDqf4BRhaBAq8T6NX1mCdoXEhZTLfZulxRZpOXu
 4sXzxnM9+MPKxezEhKIHy7OFQGjdC47NsRlfVBm6fjTkGQT2XQwzX4q26h1iH4HZKUMUuVRrByY
 pOxgBtXhsGRlkQH4mmjlL6EFnk+UIXo24nlvqcsk2Sr/Imp/8PguT7nX9rzvg5ZJhVh0GOjoLr3
 RM5veuM5ms5nrL51TcGCyR15XkvPYJ808SDw+pmaK2a1Y7dEbLs6S/+Cbv5J+TSJvmHCeHYlWVJ
 lzxsKu9omWkfxaMeWoA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA0MiBTYWx0ZWRfX6+vL3xAt6kvz
 cCeO4GTzCTbJ12TyEhSH+FMkE8DJ0BTs188x4vJ1b10dPRfwjf4miTIom1XAE9w0+G/CMYYZmSa
 fSL3edqfwaTzqhVpMRYT/Giua5kyoak=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6af2b9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=7LLowirP21t3R5KMI2QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: IFmSbMArsGp3C2QwiYB8G17eQip9FEvZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_01,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300042

Hi Jirka, Paul,

On 7/28/26 7:49 PM, Jirka Hladky wrote:
> On Tue, Jul 28, 2026 at 7:12 AM Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>> No. It doesn't confirm. I would recommend you do that case to find out
>> the cost of PREEMPT_RCU alone.
>>
>> Config A: CONFIG_PREEMPT_VOLUNTARY=y (CONFIG_PREEMPT_DYNAMIC=n)
>> Config B: CONFIG_PREEMPT_VOLUNTARY=y (CONFIG_PREEMPT_DYNAMIC=y)
> 
> Done. Built two kernels from 6.18 upstream source on the same POWER10
> machine. Both are voluntary preemption, differing only in
> PREEMPT_DYNAMIC (and thus PREEMPT_RCU):
> 
> Config A: PREEMPT_VOLUNTARY=y, PREEMPT_DYNAMIC=n (no PREEMPT_RCU)
> Config B: PREEMPT_VOLUNTARY=y, PREEMPT_DYNAMIC=y (PREEMPT_RCU=y)
> 
> Config B runtime mode confirmed as voluntary:
>    cat /sys/kernel/debug/sched/preempt: "none (voluntary) full lazy"
> 
> Results (stress-ng --kill 1 -t 23, SELinux enforcing, mean of 3 runs):
> 
> Kernel                  PREEMPT_RCU   kill bogo-ops/sec   stddev
> ----------------------  -----------   -----------------   ------
> 6.18.0-vol-nodynamic    no            108,836             19
> 6.18.0-vol-dynamic      yes            68,197             1,146
> Delta                                 -37.3%
> 
> PREEMPT_RCU alone costs 37.3% on ppc64le with zero preemption mode
> change. Both kernels run voluntary preemption.
> 

I tried to repro using "taskset -c 0-7 stress-ng --kill 1 -t 23 --metrics"
since system had more than 1 core.
I did observe close to 25% regression with Config B

Config A: PREEMPT_VOLUNTARY=y, PREEMPT_DYNAMIC=n
Config B: PREEMPT_VOLUNTARY=y, PREEMPT_DYNAMIC=y

I spent some more time debugging it as it was bugging me for few reasons.

1. There is barrier even when CONFIG_PREEMPTION=n.
See include/linux/preempt.h.
#define preempt_disable()                       barrier()
#define preempt_enable()                        barrier()
    So i was doubting all the cost is due to that.

2. Seeing the stress-ng --kill 1 -t 23, it spawns 3 threads IIUC.
    two will be long running. Given there are 8 CPUs in the test,
    preemption should be minimal. (This is only a guess)

3. Though rcu_lock/unlock shows up only in one case, it could be just
    that they are inline in PREEMPT_DYNAMIC=n. They still do barriers.

A did below hacks to see where the cost is coming from.

===================================
First thing i did was to remove PREEMPT_RCU for PREEMPT_DYNAMIC=y.

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 4d9b21f69eaa..1d67060b2261 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -18,7 +18,7 @@ config TREE_RCU
  
  config PREEMPT_RCU
         bool
-       default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
+       default y if (PREEMPT || PREEMPT_RT)
         select TREE_RCU
         help
           This option selects the RCU implementation that is

This improves it by 5%. But doesn't cover the whole regression.
============================================================================

So PREEMPT_RCU is not the main reason. Now what else PREEMPT_DYNAMIC
adds,
  
1. PREEMPT_DYNAMIC select CONFIG_PREEMPTION and that selects PREEMPT_COUNT.
    That turns every preempt_enable/disable to dec/inc the preempt count.
    Even though it isn't finally used for voluntary preemption.
    This can have overhead on any RISC architecture if all the workload does is
    hitting that path, without doing any meaningful work.

2. Static key overheads.

++++++++++++++++++++++++++++++++++++++
For 1, first thought came to my mind was is it due to preempt_count
being part of thread_info. Tried to move it PACA as it is more efficient(atleast
for 64 bit). Even with that numbers didn;t improve much. Then i thought,
is it purely due to preempt count itself. So did below,

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index da326800c1c9..d00c600dc071 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -117,11 +117,11 @@ config PREEMPT_RT_NEEDS_BH_LOCK
           the old synchronized behaviour.
  
  config PREEMPTION
-       bool
-       select PREEMPT_COUNT
+       bool
+       select PREEMPT_COUNT if !PREEMPT_VOLUNTARY
  
That is able to recover all the regression. You can give it a try if you want.
But that's not a solution as dynamic preemption just won't work.

++++++++++++++++++++++++
For 2, Sadly, i lost the system to try any hacks for static key overheads.
But given above, i don't expect it to be a major one.

==============================================================================

 From the above, it is quite evident that main cost is cost of preempt_disable/preempt_enable
due to inc/dec of preempt count itself. This is due to nature of this workload which
probably hits just lock/unlock likely, and no other work outside of it.

The cost of preempt_count is likely un-avoidable with DYNAMIC_PREEMPTION for
all RISC architecture. I think CISC cost is minimal since it can update memory and
folding of need_resched bit into the preempt count. Both are not doable in RISC.

Also given that after 7.0, all major archs including powerpc, can have only full/lazy
preemption. None/voluntary are no longer possible. So making any sort of optimization for
preempt count is not useful since it has to be there for full/lazy.

Also, evaluate it with any real life workloads, IIRC i have run hackbench, schbench,
daytrader(db2 workload) this cost wasn't visible.

>> That's true for all archs. Please check your preemption mode in your
>> x86 experiment.
> 
> Checked. On x86_64 (AMD EPYC 7313):
> 
> Kernel               PREEMPT_RCU   Runtime mode        kill bogo-ops/sec
> -------------------  -----------   ------------------  -----------------
> 6.12.0-211 (el10)    yes           none (voluntary)    37,436
> 7.2.0-rc4 (eln158)   yes           full (lazy)         36,392 (-2.8%)
> 
> Both x86 kernels already had PREEMPT_RCU=y, so the x86 comparison
> only shows the voluntary->lazy mode change cost (~3%), not the
> PREEMPT_RCU enablement cost.
> 

