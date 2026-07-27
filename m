Return-Path: <linuxppc-dev+bounces-24852-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3E5C531D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 04:19:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7lj80Lnmz2y1F;
	Mon, 27 Jul 2026 14:19:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785125947;
	cv=none; b=XpjGE3WDNHDz/FnrSi1GNQQ+7aAoLy55R3bHYPZQuHdT92+b+s/b4t+2S1+WtlLd+VxU1F7OAHBiCvX6y17sqE3V/P56li/t+jdYxaoN0ZHhg5YstoE42Tc/+gAvL6/lZU6sF5AP0+EiuLD/VMpimBquZ7Fe4Q1VSlVhpPcCdTkZZ+qEezZUJGZTs6XD4i1uHOSWfF4/Jo2+m6ZRaKdLN4A+EbxPpg+xxyFI5DJpZez919R5eDzpz+iXjPuohnRPuRLmmOAgQwUVeBeyD1VXU+FnWvWpzZQVg2ZPx1hgerBjhNQefGCMWNis8RlaJgcXoRSrw+kuHWTxFmCpY5Ns0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785125947; c=relaxed/relaxed;
	bh=s+e7jkFKJSm7jW1mU0dq9zB64RdZT8FHKFStWfM48sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aRze9EYd9mZBKh5ZnOe/OtvFnsGfrx7HnnzSx6BLgvxDn0HXGmRVT52ybd3nMtbsYjIKJt4d8DPxrkjkKi5um7BQf9/npD4tCU506roKdn6xynLIr5649XZtkuEl4t+KX1SQdTop6kWDd3F73Pzrzsb4AUAOGFFJkVlSw8x4GX+XUEnguq1XzMuHxjhC5tet/R+GhOR8zcU63gVo+XqbEo7qpHIJoCIWg9LXT2Ry2bTKR/4tAQVGa9zU/gS6HjX5YmM3CtJ3tudlWdcFbS5RYRTURw86ScsC7KGVW5bWoIAkWLYGzBoG8w0FMLCy2UvN08zXQIUU+ZMPFC7QPfPoUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o4qgM4Mx; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o4qgM4Mx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7lj71Xqxz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 14:19:06 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R1lmfF769497;
	Mon, 27 Jul 2026 04:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=s+e7jk
	FKJSm7jW1mU0dq9zB64RdZT8FHKFStWfM48sw=; b=o4qgM4Mx/VXZYdgKgoqdBA
	6IH3WPb9v09SEvxvQaNzQv9c1CVYoWN3JT0qaxjWbQa5Sxi0LzP79E/s1d33cgSX
	mvI70syOqOzddVxKrW/IqLoTZlWUAsDYir1RKpbREV3gfyWsDWAPtwYlxIetoA0q
	m9NkuCKFCYEVpCpJ5k/qOQfcEJwEKZVnEGqu9exOhksapsz6WCZkEGkzoK4tLZcs
	upHmneBFs/RPvCnMuRLO7/vZatiYd5dCNBYVnfCvHr7Zna8TSKkKWPH4MDL/eaku
	iFZpcvesh8RLefLKDhWMcc5AbTxT0hvke9/fUuhTR2hLfpVo5Et8LMemoHFjgc2g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ndpg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 04:18:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R4BPhT024341;
	Mon, 27 Jul 2026 04:18:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjuu8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 04:18:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R4ITBO12517774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 04:18:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70DED2006E;
	Mon, 27 Jul 2026 04:18:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1B182006C;
	Mon, 27 Jul 2026 04:18:26 +0000 (GMT)
Received: from [9.39.23.10] (unknown [9.39.23.10])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 04:18:26 +0000 (GMT)
Message-ID: <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com>
Date: Mon, 27 Jul 2026 09:48:25 +0530
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
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDAzOSBTYWx0ZWRfX0dyuVLO7WMA6
 waj8ATPcBTCocJ4/0195AvdHHf/7CGCoBEgsPOhfd2aquSKMpxQQF8Bf0LocLZ5TzPkalAa/mCn
 nuhJiZ9hVCr4TCp0VMdKCUhM1Gh3OlE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDAzOSBTYWx0ZWRfX5Syog1p798Je
 Wj6X8JEm40AahqWASLaPg2OrIxw4OAhi6upIg4Y9siDCKbK3W9Evn9ej+n2yUAbj8kNla6tizpI
 2zXJWcwMRWwKgdZlHxSLsalSzBxE98NSWzEax3znGfjaTAnI6ktMM5HXgQ1dCFd6R9cr9tJ1Ynn
 tYyww+mNMmgYVmBfec2EiAiWMmoTU/phL8GoCXojNyxA9LIuapFjf4wztLvQ6uuMs50ma5rbBVd
 IQApIw/AcK1V2QcNG6WLFr2gu+2xJ6bnrXuCJtu4GqkyLsfquI8xnnXud2sF8p7xKDGfCHn4aAh
 4cEW+ZivGZcNE8ATwxzuIvjsws7hAOc7cCxuFCl0VVyfzrwzl0nG4lggp2TyRc+wnt2QBz3T7qC
 ROT8yLGBSWcxbDztmXyTlAdgDdxXXIHOAWmDt4TvNyqwY4ErLmUbWfDy5gnYjQHWimCuJKKeLAK
 UgzbvQUISBnZFydX+wA==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a66dc18 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=WCvXFVo8NGMObP1iTCQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Y7O2bbFrWB8ZbNPYQkJ4CreFfKHts4oh
X-Proofpoint-ORIG-GUID: V0sD5WmVoqZRmlE5UDM33GA9tPAK-UOA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270039

+cc paul for any further/RCU insights.

On 7/27/26 12:03 AM, Jirka Hladky wrote:
>    Hi Shrikanth, Christophe,
> 

Hi Jirka, thanks for the report.

>   I'm seeing a significant performance regression on ppc64le after this
>   patch landed in 6.16, caused by CONFIG_PREEMPT_RCU becoming active
>   once HAVE_PREEMPT_DYNAMIC_KEY is selected.
> 

This is true only if user selected PREEMPT_DYNAMIC option i think.

config PREEMPT_RCU
         bool
         default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
         select TREE_RCU


>   Benchmark: stress-ng kill stressor (tight kill() syscall loop),
>   single thread, POWER10 LPAR (8 vCPUs, 1 core SMT-8).
> 
>   Bisected across Fedora ELN kernel builds on ppc64le:
> 
>     kernel               CONFIG_PREEMPT_RCU   kill bogo-ops/sec
>   ---  6.15-rc6 (eln148)    no                   103,207
>     6.16     (eln150)          yes                   70,281    (-32%)
>     6.18     (eln154)          yes                   72,552    (-30%)
> 

Does your preemption mode remain the same in two cases?

>   For comparison, x86_64 (AMD EPYC 9355P) with the same config change
>   shows only a 2.8% regression:
> 
>     6.12 x86_64          37,436
>     7.2  x86_64           36,392    (-2.8%)
> 
>   perf report shows the overhead comes from rcu_read_lock/unlock in the
>   SELinux AVC path (check_kill_permission -> security_task_kill ->
>   selinux_task_kill -> avc_has_perm -> avc_lookup):
> 
>     Function               6.15 (no PREEMPT_RCU)   6.16 (PREEMPT_RCU)
>   ---  avc_lookup                          15.23%              24.79%
>     __rcu_read_lock                      ~0%                 4.52%
>     __rcu_read_unlock                    ~0%                 4.17%
>     selinux_task_kill                    6.23%               7.35%
>     audit_signal_info*                   0.94%               3.59%
> 
>   On x86_64, rcu_read_lock/unlock are cheap thanks to static calls
>   (HAVE_PREEMPT_DYNAMIC_CALL). On ppc64le with the KEY-based
>   implementation, the weak memory model requires real barriers
>   (lwsync/isync) making each RCU read-side critical section
>   significantly more expensive.

Weak memory model would need barriers irrespective of HAVE_PREEMPT_DYNAMIC_CALL
or HAVE_PREEMPT_DYNAMIC_KEY. That's my assumption. I will look
more into it. Also i don't know much about PREEMPT_RCU. So might take a while.

> 
>   This aligns with Christophe's earlier review comment that
>   HAVE_PREEMPT_DYNAMIC_CALL should be more performant. Would
>   implementing static calls for ppc64 be feasible to close this gap?
> 

Static key too is expected to minimal cost. There maybe more into this.

>   Test details:
>   - Machine: IBM POWER10 (pvr 0080 0200), pHyp virtualization
>   - stress-ng 0.21.03, gcc 14.3.1, glibc 2.39
>   - Tuned profile: virtual-guest
>   - SELinux: enforcing (permissive recovers only ~7%)
> 
>   Happy to run additional tests if needed.
> 
> 

