Return-Path: <linuxppc-dev+bounces-24909-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3756AC531D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 17:10:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h84q94BRwz2yhD;
	Tue, 28 Jul 2026 03:10:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785172229;
	cv=none; b=C1GJuLzTxqF3h2p7yW8CMCnpRX8PZJ0woUeLgAFboK0FS8bPk9MhPOt6SPjtzcgdTwtPlnXVj7LpqhOBkaVFW0SA8Yx1MRZDiCcoM983gPxr3LF8jL1KRFC62LHoD3Yp9sCus4iF06PF5Iizkf/+q7JpgouZPTUz35IlURDkuJ6CV+wXADeQf21MxM/CGcQsaw0U14+cTn4e4LbCjY5jSnNw79rywLIUAV1ZhBYM0HYar/BnsEdP2BISKceguhWsXA0VvZv44Qw4B+xHgXmoLGOaZsnD/0fzOOj2D7VLIJqAw9m6ut4TvxrmN6vbk203O26g0AsrdUUaAMDCBSDlxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785172229; c=relaxed/relaxed;
	bh=jAs7nDPuyc3VTu6qbYt9ObfKpFDm5yR0+kmcenRE8as=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMXMmPNktmNiD4ENr5fXKy6kMwhoSzhfaiqAxy18hjIHXDlg6qs9S8AfdJwTE7ICGszpXICQpK52Zw+kUxIUYoXYnDuikF3Uu11tT6O9Ht14Oi7WAn5XDVVqPoOyf/sBnoaaQcgIKgWX4MycbzPngSlmKNCmTmxV+LuCvDaSC+GYdEZCUIKEisiQK+MvKhhcGUSDS25vefFF/78sihKRyfHRiTrQZpzw3Hr0UOHk7NLVea3QT5UuVU932Ho/dVFGJod1d0dPDAhXVrKZI/rM6xIwvKh5vd0obnVNLxoZZXVnPt4Zh+G7nnFt0kX3+YININgTdLEG4nhMcTKsmybVSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LfJ1+UA+; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LfJ1+UA+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h84q85jQsz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 03:10:28 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDnfIF2412578;
	Mon, 27 Jul 2026 17:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jAs7nD
	Puyc3VTu6qbYt9ObfKpFDm5yR0+kmcenRE8as=; b=LfJ1+UA+Nz5UR6afLvjmvW
	rNFg7co4SE8xwj0H1aU1jMpeyG/FM6O3HTIS5QnVX10Fzs+lpOw87mm7lfkNC1kf
	JGX5WfzcNdxfCH5N7OxMfP9RINJ2rWfr1JJOIU0osZSBLPsT5WtYbv7rDFWLWl/w
	IuyTA/VshXE0FDPkNOP1RHjDfEwbB9DRq/4+XWl24AP7K6549XN3kR5lHwjsWGoV
	Ume/DAK6knbncXwEZy+Bwpd3tx/yicX8wYpKY/sDXpByouEXhP7nwqLgys9w0M3o
	aCglW4+QKs9HdEV7xW6aN7SliKdQWMQ3KoPrYZVwtdb7sfVjLtj7AdgtoZmq5p6A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcrs1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:10:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RGuIAT018045;
	Mon, 27 Jul 2026 17:10:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xx0fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:10:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RHAAWc49676550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 17:10:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF09A20094;
	Mon, 27 Jul 2026 17:10:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F380E20091;
	Mon, 27 Jul 2026 17:10:06 +0000 (GMT)
Received: from [9.39.23.10] (unknown [9.39.23.10])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 17:10:06 +0000 (GMT)
Message-ID: <e013e88a-6137-4de8-9dfd-925b707f2e01@linux.ibm.com>
Date: Mon, 27 Jul 2026 22:40:05 +0530
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
To: Jirka Hladky <jhladky@redhat.com>, paulmck@kernel.org
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        christophe.leroy@csgroup.eu, mpe@ellerman.id.au, npiggin@gmail.com,
        bigeasy@linutronix.de, will@kernel.org, linux-kernel@vger.kernel.org
References: <20250210184334.567383-1-sshegde@linux.ibm.com>
 <20250210184334.567383-2-sshegde@linux.ibm.com>
 <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
 <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com>
 <500d8e8c-088c-4e6d-ab53-868ade6b0eda@paulmck-laptop>
 <CAE4VaGDGS8wkZj4SF5XVC3-1yDmvJxjUjThTPqVw3kxg56ssQA@mail.gmail.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <CAE4VaGDGS8wkZj4SF5XVC3-1yDmvJxjUjThTPqVw3kxg56ssQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: BjCDKRW3lgZLhXRNiacXFSbkzmz2Vmlt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE1NSBTYWx0ZWRfX0HWQMQM7SmDd
 mAgmRT08MWYWVQIIjEqrc1WuffqTMIbTUhftJY68LjpgVFSjcomqdVwWY/eL/38yjAA3MF6g5Zx
 UpVYS08gR2gORhrQPcxlkV6NRsuyUy8=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6790f5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=77gc1ZDODAlib0kZQ5UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE1NSBTYWx0ZWRfX4TG7/Pxazkgn
 YN115iysfNrEgpCDTQ1faskVhcZpW5vwMYbWEtwmdavYGKeuTwqblWfXQIOX29/5LgE8poS26Lg
 aOBIJUCOju9gdiTa7eQtF06QcGM6hMEO7VbQN3ajCtPaL0BfWXMgmTff/jc4l9fMWBQMnkIaMZl
 cjaOSWanhwNZM1hzmQBr4PjsEwTrpMx+koj1xIURg78flsAM2vjtz5A6DF7Nyu2XwlB7cNgeYHl
 HZCFRIkJY7aXV/ARdfzKxE5X9vqC99YsiHf4wnWP34IwzgPKBY71wDJ5q1C8GI8LZY7hjYDHmHB
 3Fr1HH3KivglcLVTzEUFIIdIZorJ1JHZuBv3fa0jC5FsAGr+iGUvyBQ3IJscJLUwytUbZGVc6Tb
 /A0Ieu9gcnEcKPVBMnItFb/eb/nzYgBo+qjeCv2SMS5VqJ+YPXitA/Lnx8Sbq7f30/e+TFYX0Iw
 v1B9pyZpZ5i7cN7AJyg==
X-Proofpoint-GUID: Ozbyi1j6YqbmP2YLodxWzAAU2fVZ7Gm8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270155

Hi Jirka.

On 7/27/26 10:20 PM, Jirka Hladky wrote:
> On Mon, Jul 27, 2026 at 6:16 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>> Yes, non-preemptible RCU's __rcu_read_{,un}lock() are (almost) no-ops,
>> but preemptible RCU must actually execute real code.  But I would not
>> expect *this* much overhead.
> 

Thanks for doing these experiment.

> I've now isolated the PREEMPT_RCU cost with a controlled experiment.
> Built two kernels from the same 6.15-rc6 upstream source on the same
> POWER10 machine, no CONFIG_PREEMPT_DYNAMIC in either case:
> 
> Config A: CONFIG_PREEMPT_VOLUNTARY=y (no PREEMPT_RCU)
> Config B: CONFIG_PREEMPT=y           (PREEMPT_RCU=y)  

That's full preemption mode.

> 
> Results (stress-ng --kill 1 -t 23, SELinux enforcing):
> 
> Kernel                       PREEMPT_RCU   kill bogo-ops/sec
> ---------------------------  -----------   -----------------
> 6.15-rc6-voluntary-test      no            105,014
> 6.15-rc6-preempt-test        yes            73,317
> Delta                                      -30.2%
> 

That is voluntary -> full preemption change.

When preemption mode changes preempt_enable/disable which were just a
barrier earlier now become real preemption points. If the code path
repeatedly does the exact same thing, it might pop up.
But, can we say is that number expected? it is difficult to put a number to it.

What I was asking is below. (You can do this only with below 7.0)

Config A: CONFIG_PREEMPT_VOLUNTARY=y (CONFIG_PREEMPT_DYNAMIC=n i.e no PREEMPT_RCU)
Config B: CONFIG_PREEMPT_VOLUNTARY=y (CONFIG_PREEMPT_DYNAMIC=y i.e PREEMPT_RCU)

That should keep in voluntary preemption.
You can confirm with dynamic preemption using /sys/kerenl/debug/sched/preempt.

In Config B, though there is rcu_read_lock/unlock it should be just a barrier.


> PREEMPT_RCU alone accounts for ~30% on this workload. The kill()
> path hits rcu_read_lock/unlock very heavily through the SELinux AVC
> (avc_has_perm -> avc_lookup wraps every hash table lookup in an RCU
> read-side critical section).
> 
> This also answers Shrikanth's question about whether the regression
> is from the preemption mode change (voluntary -> lazy) or from
> PREEMPT_RCU. Since no PREEMPT_DYNAMIC is involved in either build,
> the preemption mode is not a factor. Additionally, switching between
> full and lazy at runtime on 7.1 showed only ~1% difference (57,476
> vs 56,892), further confirming the mode doesn't matter.

Lazy/full switch is same. There will not be any additional overhead.
The real concern is none/voluntary vs lazy/full.

> 
>> OK, if you are executing an isync or an lwsync instruction in each call
>> to __rcu_read_{,un}lock(), that would explain the overhead.
> 
> Yes, that's what perf shows. __rcu_read_lock and __rcu_read_unlock
> together consume ~9% of total cycles on ppc64le with PREEMPT_RCU,
> vs essentially 0% without.
> 
>> CONFIG_PREEMPT_DYNAMIC=n for the win?
> 
> That's the simplest distro workaround for ppc64le. But since commit
> 7dadeaa6e851 ("sched: Further restrict the preemption modes")
> removed PREEMPT_VOLUNTARY as an option for architectures with
> ARCH_HAS_PREEMPT_LAZY (which includes powerpc), distros that want
> voluntary preemption on ppc64le would need to disable PREEMPT_DYNAMIC
> anyway.
> 
> Is there any path to reducing the barrier cost in
> __rcu_read_lock/__rcu_read_unlock on weakly-ordered architectures?
> Or is the current implementation fundamentally constrained by the
> memory model?
> 

Are you saying you see regression with voluntary with CONFIG_PREEMPT_DYNAMIC=y?

> Jirka
> 


