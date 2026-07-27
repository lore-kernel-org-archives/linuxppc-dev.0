Return-Path: <linuxppc-dev+bounces-24875-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008A3C531D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 10:35:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7w3d3KhFz2ygn;
	Mon, 27 Jul 2026 20:35:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785148541;
	cv=none; b=nMDpLSp9g1lB2h/pOCT10pjeSTZ7dXEtudiJEYU3eh7WLPFpiZ+6HnYEG/tBYL1qbyVDQAw9N01vqjq4OLmQheDOUgYoBy9svkboVw6oR7NzZXMdctJeJxdzgJVgUuXeG8RuZ7YL1kxL+o3m9PazsK4Ld2yV/yIkJfgEWft2jEFv7H9gvj+3RaA97/1JiL6FuGvydBXbILKW0Bq2xXKR+kpjPWMDtbPqYEWlyTbglWQ8KWXf4GLO84VDOty4+NYxAnvziBzrawLnhg2j0HeF9bLaFtPfysvQTz6UFwidtH6ZQ57z35oPDiCa+XJ4L1S06LflIEJMGx+sn1SRNpcmLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785148541; c=relaxed/relaxed;
	bh=Vfkyd5svSEE6CmChey6v07O3MKBhrDGROpKTmo/l1As=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDiYMGgsZLy5ezuWHrO+agR40jvwFAr1QnA4eQ7TETtNHNaod5cRWD1rI/EBfhbdVuJhxoK8mL7bX3pe6seaviLVWH0OjRC48hXBdEtY5IhwCgq7VZD6z7ZxT4UXHf1N+flPMd5+6i+mTAMp/x/L3FNdVDmWKy3Vgjcjyy41642cMOecHHErjxwdSkKhwe67oui3zGDRacK1SE7RgI213kJJkdgeBL2/beNytvxwepuP8i7b7mnjApRcIE5XsKR9LFomS8Sy2z1z5cHUqLCe0aF4PriocY1hN/YEVfHcDjx4TGaIAYVCFUADGB+YjiL9IM4W/6xQtxuoMX7dn1CYjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BM0U/HXy; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BM0U/HXy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7w3b57d4z2xll
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 20:35:39 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0292241FC8;
	Mon, 27 Jul 2026 10:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1173C1F00A3A;
	Mon, 27 Jul 2026 10:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785148535;
	bh=Vfkyd5svSEE6CmChey6v07O3MKBhrDGROpKTmo/l1As=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BM0U/HXyzZp4gn583PT+wHaPVbfs/tswTlEtQ5l/Aol935xSn6Oxz70w6lBL9Ekqq
	 Xsng7tUePdfKa34GLGF+fV9xd23sFVVUK4FPWG21bKtjR2mKnEhBF9Wvu3DmvIsG1v
	 Y3iTOo3dZy8l6xxR8A1xffOo03PcjIAy/yLBB5iRWbzT+HTXkkjBkIAjglCcFWSXCE
	 K0svl0uQboA+tqra4eVqsLNPNJPSET/dZHAl8A2SsqEKjFnYmkvYyrD9kfblDbSqTq
	 yEqALwNT3imhg4sExgZPsBp6eYYfMcO1XeKp0iTAPjc4vFN/TL9XyyxbQgIk7iY+at
	 bUxonllZFv1PA==
Message-ID: <330ca432-ddb6-4eeb-8415-697e16e73c43@kernel.org>
Date: Mon, 27 Jul 2026 12:35:32 +0200
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
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Jirka Hladky <jhladky@redhat.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 npiggin@gmail.com, bigeasy@linutronix.de, will@kernel.org,
 linux-kernel@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>
References: <20250210184334.567383-1-sshegde@linux.ibm.com>
 <20250210184334.567383-2-sshegde@linux.ibm.com>
 <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
 <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com>
 <CAE4VaGB-W9i0nNzH=VN9GJr6Dy9R46NtMC3V3ELUxdDhypj8bw@mail.gmail.com>
 <85cb5e0e-feb5-4a54-b7b6-a5f6a053dcda@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <85cb5e0e-feb5-4a54-b7b6-a5f6a053dcda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Shrikanth,

Le 27/07/2026 à 12:28, Shrikanth Hegde a écrit :
> Hi Jirka,
> Please avoid top-posting.
> 
> On 7/27/26 3:43 PM, Jirka Hladky wrote:
>> Hi Shrikanth,
>>
>> Thanks for the quick response and for looping in Paul.
>>
>>> This is true only if user selected PREEMPT_DYNAMIC option i think.
>>
>> Yes, exactly. The issue is that CONFIG_PREEMPT_DYNAMIC=y has been in
>> the Fedora/RHEL kernel config since kernel 5.16 (2021). It was
>> silently ignored on ppc64le until your 6.16 patch added
>> HAVE_PREEMPT_DYNAMIC_KEY, so this is the first time PREEMPT_RCU
>> actually takes effect for all Fedora/RHEL ppc64le users.
>>
>>> Does your preemption mode remain the same in two cases?
>>
>> Verified. On 6.15-rc6 (before PREEMPT_DYNAMIC takes effect):
>>
>>    CONFIG_PREEMPT_VOLUNTARY=y
>>    (no CONFIG_PREEMPT_DYNAMIC, no /sys/kernel/debug/sched/preempt)
>>
>> On both 7.1 and 7.2-rc4 (with PREEMPT_DYNAMIC active):
>>
>>    CONFIG_PREEMPT_LAZY=y
>>    CONFIG_PREEMPT_DYNAMIC=y
>>    CONFIG_PREEMPT_RCU=y
>>    cat /sys/kernel/debug/sched/preempt: "full (lazy)"
>>
>> So the runtime preemption mode is the same on 7.1 and 7.2. The
>> difference between 6.15 and 7.1+ is that the preemption model changed
>> from voluntary (static) to full/lazy (dynamic), which is what pulls
>> in PREEMPT_RCU.
> 
> That means comparison is between preempt=voluntary vs preempt=lazy.

As far as I can see CONFIG_PREEMPT_LAZY doesn't pull CONFIG_PREEMPT_RCU. 
CONFIG_PREEMPT_DYNAMIC does:

config PREEMPT_RCU
	bool
	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
	select TREE_RCU
	help
	  This option selects the RCU implementation that is
	  designed for very large SMP systems with hundreds or
	  thousands of CPUs, but for which real-time response
	  is also required.  It also scales down nicely to
	  smaller systems.

	  Select this option if you are unsure.


Christophe

> 
> If you make it full preemption in 6.15 you will likely see similar data 
> as 7.1+.
> Only on 7.0/7.1 there is force switch to lazy/full. Can you give that a 
> try?
> 
> If it shows same data, that implies the regression is mainly due to change
> of preemption modes, rather than the static key stuff.
> 
>>
>>> Weak memory model would need barriers irrespective of
>>> HAVE_PREEMPT_DYNAMIC_CALL or HAVE_PREEMPT_DYNAMIC_KEY.
>>> Static key too is expected to minimal cost.
>>
>> You're right, I should clarify -- the overhead is not in the static
>> key mechanism itself. The cost comes from __rcu_read_lock() and
>> __rcu_read_unlock() which are called when CONFIG_PREEMPT_RCU=y.
>> These need real memory barriers (lwsync/isync) on ppc64le regardless
>> of whether the dynamic mechanism uses keys or calls.
>>
>> The real question is: why does enabling PREEMPT_RCU cost ~33% on
>> ppc64le but only ~3% on x86_64? The answer is that x86_64's TSO
>> memory model makes the barriers in __rcu_read_lock/__rcu_read_unlock
>> essentially free, while ppc64le's weak ordering requires explicit
>> lwsync/isync instructions, which are expensive when called thousands
>> of times per second in the SELinux AVC hot path.
> 
> Plus, it may call schedule in lazy/pull preemption.
> 
>>
>> I also have new data from SELinux isolation testing that helps
>> quantify this. On kernel 7.1 (which already has PREEMPT_RCU=y):
>>
>> SELinux mode    kill bogo-ops/sec    vs enforcing
>> ------------    -----------------    ------------
>> Enforcing       69,107               baseline
>> Permissive      70,248               +1.6%
>> Disabled        93,566               +35.4%
>>
>> Permissive ~ enforcing confirms the overhead is not in SELinux policy
>> evaluation. Disabling SELinux removes the rcu_read_lock/unlock call
>> sites in the AVC path and recovers most of the performance -- but
>> still leaves a ~13% gap vs 6.12 (no PREEMPT_RCU), which is the base
>> cost of PREEMPT_RCU in the non-SELinux parts of the kill() path.
>>
> 
> This seems strange. How come rcu lock/unlock depends on SELinux policy?
> One should call rcu lock/unlock if they are working with rcu updated 
> fields.
> 
> Does the policy change itself protected with rcu lock/unlock?
> I will check it up.
> 
>> So the core issue is: on ppc64le, CONFIG_PREEMPT_RCU makes
>> rcu_read_lock/unlock significantly more expensive, and the kill()
>> syscall path hits them very heavily through SELinux AVC lookups.
>>
>> Thanks,
>> Jirka
>>
>> On Mon, Jul 27, 2026 at 6:19 AM Shrikanth Hegde 
>> <sshegde@linux.ibm.com> wrote:
>>>
>>> +cc paul for any further/RCU insights.
>>>
>>> On 7/27/26 12:03 AM, Jirka Hladky wrote:
>>>>     Hi Shrikanth, Christophe,
>>>>
>>>
>>> Hi Jirka, thanks for the report.
>>>
>>>>    I'm seeing a significant performance regression on ppc64le after 
>>>> this
>>>>    patch landed in 6.16, caused by CONFIG_PREEMPT_RCU becoming active
>>>>    once HAVE_PREEMPT_DYNAMIC_KEY is selected.
>>>>
>>>
>>> This is true only if user selected PREEMPT_DYNAMIC option i think.
>>>
>>> config PREEMPT_RCU
>>>           bool
>>>           default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
>>>           select TREE_RCU
>>>
>>>
>>>>    Benchmark: stress-ng kill stressor (tight kill() syscall loop),
>>>>    single thread, POWER10 LPAR (8 vCPUs, 1 core SMT-8).
>>>>
>>>>    Bisected across Fedora ELN kernel builds on ppc64le:
>>>>
>>>>      kernel               CONFIG_PREEMPT_RCU   kill bogo-ops/sec
>>>>    ---  6.15-rc6 (eln148)    no                   103,207
>>>>      6.16     (eln150)          yes                   70,281    (-32%)
>>>>      6.18     (eln154)          yes                   72,552    (-30%)
>>>>
>>>
>>> Does your preemption mode remain the same in two cases?
>>>
>>>>    For comparison, x86_64 (AMD EPYC 9355P) with the same config change
>>>>    shows only a 2.8% regression:
>>>>
>>>>      6.12 x86_64          37,436
>>>>      7.2  x86_64           36,392    (-2.8%)
>>>>
>>>>    perf report shows the overhead comes from rcu_read_lock/unlock in 
>>>> the
>>>>    SELinux AVC path (check_kill_permission -> security_task_kill ->
>>>>    selinux_task_kill -> avc_has_perm -> avc_lookup):
>>>>
>>>>      Function               6.15 (no PREEMPT_RCU)   6.16 (PREEMPT_RCU)
>>>>    ---  avc_lookup                          15.23%              24.79%
>>>>      __rcu_read_lock                      ~0%                 4.52%
>>>>      __rcu_read_unlock                    ~0%                 4.17%
>>>>      selinux_task_kill                    6.23%               7.35%
>>>>      audit_signal_info*                   0.94%               3.59%
>>>>
>>>>    On x86_64, rcu_read_lock/unlock are cheap thanks to static calls
>>>>    (HAVE_PREEMPT_DYNAMIC_CALL). On ppc64le with the KEY-based
>>>>    implementation, the weak memory model requires real barriers
>>>>    (lwsync/isync) making each RCU read-side critical section
>>>>    significantly more expensive.
>>>
>>> Weak memory model would need barriers irrespective of 
>>> HAVE_PREEMPT_DYNAMIC_CALL
>>> or HAVE_PREEMPT_DYNAMIC_KEY. That's my assumption. I will look
>>> more into it. Also i don't know much about PREEMPT_RCU. So might take 
>>> a while.
>>>
>>>>
>>>>    This aligns with Christophe's earlier review comment that
>>>>    HAVE_PREEMPT_DYNAMIC_CALL should be more performant. Would
>>>>    implementing static calls for ppc64 be feasible to close this gap?
>>>>
>>>
>>> Static key too is expected to minimal cost. There maybe more into this.
>>>
>>>>    Test details:
>>>>    - Machine: IBM POWER10 (pvr 0080 0200), pHyp virtualization
>>>>    - stress-ng 0.21.03, gcc 14.3.1, glibc 2.39
>>>>    - Tuned profile: virtual-guest
>>>>    - SELinux: enforcing (permissive recovers only ~7%)
>>>>
>>>>    Happy to run additional tests if needed.
>>>>
>>>>
>>>
>>
>>
> 


