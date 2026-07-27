Return-Path: <linuxppc-dev+bounces-24874-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2089DC53219
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 10:29:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7vvz2334z2ygn;
	Mon, 27 Jul 2026 20:29:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785148143;
	cv=none; b=P+dwBqKp42Pyg4JEL+kskD8kI6XBaAubgY7PcaQINuQkTJ0SrThbwmltSD3zwsliOMakJ7qm4FmsfUi3yur+As4CTEjk+fkxuIjSVzvOJ+/v10JKC0q9psNgewduwXwvdmj+UCC69/qZ2dO8s1WYHfaDPy5Yj51E4E0eqP3xxIi+XdBM9ixNYN0wvEd7tHmpgamnP1g4WqDUYfnzrAHHcCjBSs3D4gCAGcRxbY6eZGDely0fIlKXbQ/xSat/0S5UK2NJX6zcjKHdG54TKKNZidB7pAMc9NhdRRIon4J+wBAIjHFeXoWpjFoRRhNsm+W2gyQXnDuoE1sHxIOxpnz3Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785148143; c=relaxed/relaxed;
	bh=iywxwTR+a0Ywf96XrMmeuVe88UYGjJVcWt0UoNTfFwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ouNxYAQr80t177PlDqxXrX/t3r2SF/1XrK7nr6NzPcK3byz3gehyv7TJ0ie0CYdytVH1nckUn4BX2jwsEd1e/SJCS76UcpBy7f3b4vLNQUyUOoS348xr6kerlXZ7W6C6PFVPDKSNMIi9hZKQ7OElOE5JjbqVMBsFSg+FH34tWIOzMzRH372gnT1iQdXFPGWPWW64CQJ8AaxPFeLFIcDyKiFm8Dg6OblQ2uBEcREbOs04Vr6y/73PVGXAb55b1jLQXRfUn6S1vh5Y6i6Bo9Mjnny5og8QmhSHMqRDEYKDe9UqYCyC9uFYS/Uuifst1Ml1dfPXuAUd6UKD8bcC22Tr2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ATP5aPhR; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ATP5aPhR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7vvy1KBgz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 20:29:01 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RAIm1F1844840;
	Mon, 27 Jul 2026 10:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iywxwT
	R+a0Ywf96XrMmeuVe88UYGjJVcWt0UoNTfFwg=; b=ATP5aPhRVsIEneHWwIqrr+
	fLvZNLBMiFfHGIDlwuWzsjxvN7eUzBLVKPptUxE7AvmIw66wafGq39ga4ncTEMAy
	xbaiqqwVIPbuJBj3SPTi9EsqYP3k/cfpZsuMbD5PpwuN5jR7kf25iC/yjQBi1h/1
	/iKZTrnhBj3cC43ZZonyKhSbPtvBO1GTCKqfGq69POzQvZIiEKQ10eZTOILF7zsI
	d4WOzOMNee9IHFs7c5HjKgMLysmrbIrEtWbHx++6CZ2xF9ilUrhKWzpeBz4Sgngr
	y5B0vCuDbM7VLw/nlwKJ/j/MQnjrpKzFfjc0fd367S/h3zhPwdNSmmodKifsf5UQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyhy399-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 10:28:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RAQegZ014383;
	Mon, 27 Jul 2026 10:28:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uvw2rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 10:28:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RASfho51970368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 10:28:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33C4E200DB;
	Mon, 27 Jul 2026 10:28:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9593D200DC;
	Mon, 27 Jul 2026 10:28:38 +0000 (GMT)
Received: from [9.39.23.10] (unknown [9.39.23.10])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 10:28:38 +0000 (GMT)
Message-ID: <85cb5e0e-feb5-4a54-b7b6-a5f6a053dcda@linux.ibm.com>
Date: Mon, 27 Jul 2026 15:58:27 +0530
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
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        christophe.leroy@csgroup.eu, mpe@ellerman.id.au, npiggin@gmail.com,
        bigeasy@linutronix.de, will@kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <20250210184334.567383-1-sshegde@linux.ibm.com>
 <20250210184334.567383-2-sshegde@linux.ibm.com>
 <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
 <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com>
 <CAE4VaGB-W9i0nNzH=VN9GJr6Dy9R46NtMC3V3ELUxdDhypj8bw@mail.gmail.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <CAE4VaGB-W9i0nNzH=VN9GJr6Dy9R46NtMC3V3ELUxdDhypj8bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEwMCBTYWx0ZWRfX1t1ICC6BF4Ax
 gbr3cuZgit4h9pASfWSKnXvfVPbRMflXXh+FfimIcTmc1gT11HqlfzYIJ+5xyhTgg+jjHhhuNyH
 oEiz4jEcLetjFvCpSULjfaLWm9F1uhM=
X-Proofpoint-GUID: qll-_VvUzFnMj2QdvEaBgjcODPQ07Olw
X-Proofpoint-ORIG-GUID: GPo0uZo6NwEBfpD3kb_Aun7USTn2l2Wu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEwMCBTYWx0ZWRfX6sZ0GV1wd4N8
 fdJ67qIQMJRbmkEVCoH9nWR6kDfED8aqltnL09iu0lRb8CId7et/4IUcUWLPvQwFp0BMJNTLnZx
 UHmVjMGtxV10nYLg4hvnBPO5TIJunNS8E5qAlgXlcWuuX7P/cTfzpcshvmwhE2aMXuVXhsKeJjO
 CKmPoFK7Ir5fkLEk0NDflt4dvwtGfxwNQoDbN/rjLLtOH89mbfiDfkcqt/kpJU1ZNmpeZZRFeN0
 MlSUlT/Om+mzdZrnLr/ZMd0OGUS38MbZE/+4ZRHxp6Wfb2ll0yPcOt7eM55w3ruMv/2mdboCrjP
 YmCttkxcqxiKp3B+WpfXv5PITZh7/j9pU+rozvBfF68zj9I2eOY57NRxi956pDSF6fZ3JtFErZ+
 3pNifNVLnLKDysS/WhKI+fED40PK+2nR1Wd5j7gWRbH1A5aGyd1we7BX56Ayzgwmw/tpHxL0MYi
 n4/ibXE2BK2uq2Ob8+A==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6732dc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=KVBXVX55VvJRn9aPeloA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270100

Hi Jirka,
Please avoid top-posting.

On 7/27/26 3:43 PM, Jirka Hladky wrote:
> Hi Shrikanth,
> 
> Thanks for the quick response and for looping in Paul.
> 
>> This is true only if user selected PREEMPT_DYNAMIC option i think.
> 
> Yes, exactly. The issue is that CONFIG_PREEMPT_DYNAMIC=y has been in
> the Fedora/RHEL kernel config since kernel 5.16 (2021). It was
> silently ignored on ppc64le until your 6.16 patch added
> HAVE_PREEMPT_DYNAMIC_KEY, so this is the first time PREEMPT_RCU
> actually takes effect for all Fedora/RHEL ppc64le users.
> 
>> Does your preemption mode remain the same in two cases?
> 
> Verified. On 6.15-rc6 (before PREEMPT_DYNAMIC takes effect):
> 
>    CONFIG_PREEMPT_VOLUNTARY=y
>    (no CONFIG_PREEMPT_DYNAMIC, no /sys/kernel/debug/sched/preempt)
> 
> On both 7.1 and 7.2-rc4 (with PREEMPT_DYNAMIC active):
> 
>    CONFIG_PREEMPT_LAZY=y
>    CONFIG_PREEMPT_DYNAMIC=y
>    CONFIG_PREEMPT_RCU=y
>    cat /sys/kernel/debug/sched/preempt: "full (lazy)"
> 
> So the runtime preemption mode is the same on 7.1 and 7.2. The
> difference between 6.15 and 7.1+ is that the preemption model changed
> from voluntary (static) to full/lazy (dynamic), which is what pulls
> in PREEMPT_RCU.

That means comparison is between preempt=voluntary vs preempt=lazy.

If you make it full preemption in 6.15 you will likely see similar data as 7.1+.
Only on 7.0/7.1 there is force switch to lazy/full. Can you give that a try?

If it shows same data, that implies the regression is mainly due to change
of preemption modes, rather than the static key stuff.

> 
>> Weak memory model would need barriers irrespective of
>> HAVE_PREEMPT_DYNAMIC_CALL or HAVE_PREEMPT_DYNAMIC_KEY.
>> Static key too is expected to minimal cost.
> 
> You're right, I should clarify -- the overhead is not in the static
> key mechanism itself. The cost comes from __rcu_read_lock() and
> __rcu_read_unlock() which are called when CONFIG_PREEMPT_RCU=y.
> These need real memory barriers (lwsync/isync) on ppc64le regardless
> of whether the dynamic mechanism uses keys or calls.
> 
> The real question is: why does enabling PREEMPT_RCU cost ~33% on
> ppc64le but only ~3% on x86_64? The answer is that x86_64's TSO
> memory model makes the barriers in __rcu_read_lock/__rcu_read_unlock
> essentially free, while ppc64le's weak ordering requires explicit
> lwsync/isync instructions, which are expensive when called thousands
> of times per second in the SELinux AVC hot path.

Plus, it may call schedule in lazy/pull preemption.

> 
> I also have new data from SELinux isolation testing that helps
> quantify this. On kernel 7.1 (which already has PREEMPT_RCU=y):
> 
> SELinux mode    kill bogo-ops/sec    vs enforcing
> ------------    -----------------    ------------
> Enforcing       69,107               baseline
> Permissive      70,248               +1.6%
> Disabled        93,566               +35.4%
> 
> Permissive ~ enforcing confirms the overhead is not in SELinux policy
> evaluation. Disabling SELinux removes the rcu_read_lock/unlock call
> sites in the AVC path and recovers most of the performance -- but
> still leaves a ~13% gap vs 6.12 (no PREEMPT_RCU), which is the base
> cost of PREEMPT_RCU in the non-SELinux parts of the kill() path.
> 

This seems strange. How come rcu lock/unlock depends on SELinux policy?
One should call rcu lock/unlock if they are working with rcu updated fields.

Does the policy change itself protected with rcu lock/unlock?
I will check it up.

> So the core issue is: on ppc64le, CONFIG_PREEMPT_RCU makes
> rcu_read_lock/unlock significantly more expensive, and the kill()
> syscall path hits them very heavily through SELinux AVC lookups.
> 
> Thanks,
> Jirka
> 
> On Mon, Jul 27, 2026 at 6:19 AM Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>>
>> +cc paul for any further/RCU insights.
>>
>> On 7/27/26 12:03 AM, Jirka Hladky wrote:
>>>     Hi Shrikanth, Christophe,
>>>
>>
>> Hi Jirka, thanks for the report.
>>
>>>    I'm seeing a significant performance regression on ppc64le after this
>>>    patch landed in 6.16, caused by CONFIG_PREEMPT_RCU becoming active
>>>    once HAVE_PREEMPT_DYNAMIC_KEY is selected.
>>>
>>
>> This is true only if user selected PREEMPT_DYNAMIC option i think.
>>
>> config PREEMPT_RCU
>>           bool
>>           default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
>>           select TREE_RCU
>>
>>
>>>    Benchmark: stress-ng kill stressor (tight kill() syscall loop),
>>>    single thread, POWER10 LPAR (8 vCPUs, 1 core SMT-8).
>>>
>>>    Bisected across Fedora ELN kernel builds on ppc64le:
>>>
>>>      kernel               CONFIG_PREEMPT_RCU   kill bogo-ops/sec
>>>    ---  6.15-rc6 (eln148)    no                   103,207
>>>      6.16     (eln150)          yes                   70,281    (-32%)
>>>      6.18     (eln154)          yes                   72,552    (-30%)
>>>
>>
>> Does your preemption mode remain the same in two cases?
>>
>>>    For comparison, x86_64 (AMD EPYC 9355P) with the same config change
>>>    shows only a 2.8% regression:
>>>
>>>      6.12 x86_64          37,436
>>>      7.2  x86_64           36,392    (-2.8%)
>>>
>>>    perf report shows the overhead comes from rcu_read_lock/unlock in the
>>>    SELinux AVC path (check_kill_permission -> security_task_kill ->
>>>    selinux_task_kill -> avc_has_perm -> avc_lookup):
>>>
>>>      Function               6.15 (no PREEMPT_RCU)   6.16 (PREEMPT_RCU)
>>>    ---  avc_lookup                          15.23%              24.79%
>>>      __rcu_read_lock                      ~0%                 4.52%
>>>      __rcu_read_unlock                    ~0%                 4.17%
>>>      selinux_task_kill                    6.23%               7.35%
>>>      audit_signal_info*                   0.94%               3.59%
>>>
>>>    On x86_64, rcu_read_lock/unlock are cheap thanks to static calls
>>>    (HAVE_PREEMPT_DYNAMIC_CALL). On ppc64le with the KEY-based
>>>    implementation, the weak memory model requires real barriers
>>>    (lwsync/isync) making each RCU read-side critical section
>>>    significantly more expensive.
>>
>> Weak memory model would need barriers irrespective of HAVE_PREEMPT_DYNAMIC_CALL
>> or HAVE_PREEMPT_DYNAMIC_KEY. That's my assumption. I will look
>> more into it. Also i don't know much about PREEMPT_RCU. So might take a while.
>>
>>>
>>>    This aligns with Christophe's earlier review comment that
>>>    HAVE_PREEMPT_DYNAMIC_CALL should be more performant. Would
>>>    implementing static calls for ppc64 be feasible to close this gap?
>>>
>>
>> Static key too is expected to minimal cost. There maybe more into this.
>>
>>>    Test details:
>>>    - Machine: IBM POWER10 (pvr 0080 0200), pHyp virtualization
>>>    - stress-ng 0.21.03, gcc 14.3.1, glibc 2.39
>>>    - Tuned profile: virtual-guest
>>>    - SELinux: enforcing (permissive recovers only ~7%)
>>>
>>>    Happy to run additional tests if needed.
>>>
>>>
>>
> 
> 


