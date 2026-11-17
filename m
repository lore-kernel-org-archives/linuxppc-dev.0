Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1835C606A33B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=L5GY5CQ6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTXJr5v3Hz2xl0;
	Wed, 18 Nov 2026 04:48:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794937708;
	cv=none; b=JJ6iUlXB1eB6NpqsNyxvJPyQWE3aFpJxpn63tZHIvD9sLbRiAUgBqSLb2TsePB3F6s8yrhFxb6suL0Ek/5+ILp8PoZ8RTgD4pBlPYcH1HU0/NWlbG31yCynBxXRHRW5AK2vDQorGsN3ZcI0IlzSHUKxHcg+adRGppAIoH4urNmh4ko4Qq0yf0a4CHPgMw6aDtZ7J48aRdSqnY0Dq62IkNyuVlO1DbY59paxYTWfIGU6FVg2Le4DRLtaUJV1/xAMLGtXAG+f+5TNf/Tns/CDfysVM755MbuLMIHJ2CMJcgiyISOf5JSvyK4F1gdeKAyZZoAMp2Yh6Vx9Ple5R5w2+Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794937708; c=relaxed/relaxed;
	bh=OB1fMil6gBiBpmy002TLOkou98ErSTEP4nQUldxXLl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqagCS+d1u1Q4BOLoKGc8AHhBP3I+xMCZXQ0ihipz++b+kSvWPR7q7XOfDWUpgl/d7NSO81ziB5bj/N4kP97HpFpt/uc5RXY8UFhlRF1L9jZ38Lg6w4AmB/zKi4QCxz+RikThCmt4ldLyDr+tyQS8QdIs/qzE8xJxPX2nghxwVSAAT1zNzQuC7hqeOTxmqIZ45br1s5jfMfxhzRyA3Ihob2NqV7JnsPidxZ4NO94LoDugYuggq7f2mF1FZRlvnHfy/duNSDsjHgA1eyHFPTn8vLRMP5es48+rYV18J4hj7lWgNd4ZOO1zBmVLXU1AnYonslJkRO1aF6gtP3l8EcgnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=L5GY5CQ6; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=L5GY5CQ6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTXJq2sDHz2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 04:48:27 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFQc622892704;
	Tue, 17 Nov 2026 17:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OB1fMi
	l6gBiBpmy002TLOkou98ErSTEP4nQUldxXLl8=; b=L5GY5CQ6ecnD9qPitN3vyy
	eDlwZ+/QX3qn8PhsV7tOH4QFqux9BeJZAXcXapixaAZ/zqgaWLN5zH/c4f2a7f7D
	TItXyIttBk/3Vfnef1qvzfL2Nuf6ACrU3j6pkMZmqUh8q8PD6NXBdQyaHsXA0Ewa
	F7HOBMwNF/zXoaEJ1sRgynIpWKrkkwErJGFaeul7AtQPlPFGLoGT7Wd2sFfV127M
	OBRB4KHw1lLcbVxuAHoVZWuywBFpSdG5rrm583zeAMWLOt9Yk7/tRXQZnNvMyzgf
	diM7+ZerN8BN5v2hmmmvtyfVNa8q3UCQ63v8q1+DSm+95D65E+dCmxrBO49anqPA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxf56cq8v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 17:48:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFnwWC4159622;
	Tue, 17 Nov 2026 17:48:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hy2bvexnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 17:48:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AHHlwoB39649766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 17:47:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7201720043;
	Tue, 17 Nov 2026 17:47:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7790A20040;
	Tue, 17 Nov 2026 17:47:55 +0000 (GMT)
Received: from [9.124.216.14] (unknown [9.124.216.14])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Nov 2026 17:47:55 +0000 (GMT)
Message-ID: <3e9d9576-0af3-4922-b8bf-37f9127cdb01@linux.ibm.com>
Date: Tue, 17 Nov 2026 23:17:54 +0530
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] powerpc64: Preempt count optimizations
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Samir M <samir@linux.ibm.com>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com,
        peterz@infradead.org, boqun@kernel.org, will@kernel.org,
        jhladky@redhat.com, paulmck@kernel.org, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
References: <20261002164619.1455143-1-sshegde@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20261002164619.1455143-1-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2OSBTYWx0ZWRfX0zQSrt1kEI5W
 6u2nAdWYPHDkF2/oIpFWau/pHSaIU/I72eTFrmXAVrgFJhFj6pXPl6lbpQozxGSK/cjCw2bWpJr
 mYd7ejRoqIEfTUpL9B0n0+G4f+22HRE=
X-Proofpoint-GUID: 946l86BWvzFkGnqTI-pGeeNpF8I2kjWl
X-Authority-Analysis: v=2.4 cv=ROImjIi+ c=1 sm=1 tr=0 ts=6afc9354 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=WsHKUha7AAAA:8 a=pvYHo5gPCXYgU8uDO58A:9 a=QEXdDO2ut3YA:10
 a=H4LAKuo8djmI0KOkngUh:22
X-Proofpoint-ORIG-GUID: VtpRg4VG1JcMOZjVyR1ForUUaYgkUi7f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2OSBTYWx0ZWRfX369mSZrsuey3
 OnAwyoo/flqmgVYmZ8jJWYlNvX7a0n/bxgPtgRb2G64QIeM8YzJ8viIS/s6rcNi8a5c9uuGROE0
 Rommz1N+Ak8UnPZq3mwIv9yIh+nVo063qLQPDEEnz/85+fe4MUcF1rZTs1HcsigsH1L7BpY26VP
 FDl9N0YSJYPuS0XL+riuOmZyWe5klyafexV4X1AYPYh+rOlhNSnXTsU+DKEiR6dBOj7DT8JpUg7
 5f1JUzIZsLGUxCmumaiYJ/Z3tA9SZqk8rKdxmYVL2fkl/LpW6Cqs0AZMRtreCn/JvjwXGJp1DoH
 SYYzAea3Ut19NqZs5IkA5x5Pjt0qV8YStq4jyhr/P6ZB4k4lpL8UXTpn+Lx9qYQrEatH7zsTfMA
 NCqHGJTauHGzUbVa/ktSjVJMeZh2iLj5bNv1Zmf5DpZOQ9SAO+zlt2tiSKD4GZZP1bkGyXRhCr/
 ATaq95xNX6yjV2kCW7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170069
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

venkat, Samir,

Could you run CI suite, or LTP test suite and your standard set of tests
to see if it holding good functionally?

On 10/2/26 10:16 PM, Shrikanth Hegde wrote:
> This is an RFC and initial implementation of the idea which was discussed
> in few threads. [1][2][3]
> 
> It is lightly tested, but given changes are involving the core api,
> it definitely needs more testing. Also I need to investigate the
> patches in more detail and likely changelogs needs update too.
> 
> Please go ahead and try to see if works/breaks for you.
> 
> Ideas in brief:
> 
> 1. Move preempt count to PACA.
>     preempt count in PACA is better as it make it direct access from r13 instead of
>     obtaining from thread info.
> 
> 2. Fold need_resched into preempt count.
>     Also it was noted that adopting similar style of folding need_resched
>     into preempt count as ARM64 is better as it helps load-store archs and
>     helps to avoid accessing thread info in fast paths.
> 
> 3. Enable HAS_SEPARATE_PREEMPT_RESCHED_BITS.
>     While there enable the HAS_SEPARATE_PREEMPT_RESCHED_BITS which is a
>     recent trick to fold the NMI bits into preempt count(29-32bits)
>     instead of using separate per_cpu count.
> 
> [1] https://lore.kernel.org/all/e8efdade-161e-4efe-8bd3-abb12ad45dee@linux.ibm.com/
> [2] https://lore.kernel.org/all/1eab63fc-b70d-41ef-b720-8ae77d8e56d8@linux.ibm.com/#t
> [3] https://lore.kernel.org/all/20260805094219.GM687043@noisy.programming.kicks-ass.net/
> 
> Below are hackbench results.
> 
> Test                       	  Baseline    Patched   Gain
> =============================================================
> Hackbench process 10 groups         1.000x    0.991x   +0.88%
> Hackbench process 20 groups         1.000x    0.972x   +2.81%
> Hackbench process 30 groups         1.000x    0.976x   +2.37%
> Hackbench process 40 groups         1.000x    0.979x   +2.11%
> Hackbench process 50 groups         1.000x    0.980x   +2.05%
> Hackbench process 60 groups         1.000x    0.982x   +1.79%
> Hackbench thread 10  groups         1.000x    0.978x   +2.23%
> Hackbench thread 20  groups         1.000x    0.971x   +2.93%
> Hackbench process pipe 10 groups    1.000x    0.957x   +4.35%
> Hackbench process pipe 20 groups    1.000x    0.977x   +2.32%
> Hackbench process pipe 30 groups    1.000x    0.981x   +1.95%
> Hackbench process pipe 40 groups    1.000x    0.981x   +1.93%
> Hackbench process pipe 50 groups    1.000x    0.975x   +2.54%
> Hackbench process pipe 60 groups    1.000x    1.024x   -2.37%
> Hackbench thread pipe 10 groups     1.000x    0.970x   +3.04%
> Hackbench thread pipe 20 groups     1.000x    0.981x   +1.89%
> 
> Things tested(no warnings/crash):
> - Build and boot.
> - hackbench run.
> - daytrader run.
> - kexec.
> 
> Shrikanth Hegde (3):
>    powerpc64: move preempt count to paca
>    powerpc64/preempt: Add need_resched bit inside preempt_count
>    powerpc64/Kconfig: Enable HAS_SEPARATE_PREEMPT_RESCHED_BITS
> 
>   arch/powerpc/Kconfig                   |   1 +
>   arch/powerpc/include/asm/paca.h        |  12 +++
>   arch/powerpc/include/asm/preempt.h     | 113 +++++++++++++++++++++++++
>   arch/powerpc/include/asm/thread_info.h |  14 ++-
>   arch/powerpc/kernel/paca.c             |   1 +
>   arch/powerpc/kexec/core_64.c           |   2 +-
>   6 files changed, 139 insertions(+), 4 deletions(-)
>   create mode 100644 arch/powerpc/include/asm/preempt.h
> 



