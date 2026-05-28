Return-Path: <linuxppc-dev+bounces-21638-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C751CD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 16:06:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRBFT41jvz2yWK;
	Fri, 29 May 2026 02:06:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779984413;
	cv=none; b=RJ3yWGkjHpfvK+A97U4QIfWaJ9LK8h8qi9S69v/YeeEMb/3x8GRPlJ6X6qsWx2CXfuxfsGWtUnNKFPJEk7l2g6Cab9kQFX7WHTRAUDSkpL1mRlozBrf2+xkMQWGptqpwSMpK3gesJAU6g9XHzaGp8ZlcIxp703ZWYsF5Vt/VdvyfU/9rI2QxyQG+XrasQZmn3PwnOaTKzOw/FqfS7XBvj2cWWWCORU2m9TLvtUM5pa0wdo/UffQCa4E4NKrDIAQOWlkeJ9IJ7kBPXeaULeW6PDkPBadvhjTos8V2QKmjBhraISQijeGTEp2KLu9c39p+p19vKEj+jdT4K0IqcSYPUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779984413; c=relaxed/relaxed;
	bh=BGWTpkff2Fbck9rg4DKJR0AUYFoyk5bvoCgjlRW1nP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpHKBulePUGIxpSjXC/TYsftVPNSmu1Q833/wGl7q1xplRHAZDsdun9IpFNMLMQ07y48UeWhIbOACtPWRKYLEPaFrUWtELeixSXPEr2FVsKM7Ysm80GhDfyuaJ0FKiHNXbOqlLcAXqdNR2kUa53ZPktNRneic9kTzjWvVbZFVzz8RdCsz8uUB+UwG/BEy4qDs6+YKt8xWZvU0Koy/8PsQ0v9XYxpQyvENZsaL2Vwz1qFx0JvTsOZ7w6KPIutI4ubq0k+npMvr1LVNh0Tb8E+rtG9VK0lWZLvDV0MrH95NAy1BNe5eNFVGakm54Klo6GWwL5RtMzatHr0El6uBV4lsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pkdEGYU8; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pkdEGYU8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRBFS3Hl6z2xM7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 02:06:51 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SDNLSp3786229;
	Thu, 28 May 2026 16:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=BGWTpkff2Fbck9rg4DKJR0AUYFoyk5bvoCgjlRW1nP4=; b=pkdEGYU8sI9+
	jXyaQfNxhQJPxSPH2jQaP+GgTiZ4qcFmGsZZIB2htGchpdpEVKV8AmBeqfPOq63I
	yZWqNgtJkCzUZbhF5EVusdltF3gFEM4qIP3kjECnWGAprxG5j3f4+VJ2losVzsEh
	abeAGe4iAxfiapEP+wdHXaxQgunQblUPKG5txPttKUNa6ryMgxftiJxoFg5RUN3G
	qPXn658dDHJVwcEX+HaHZy2Qq4PZhMcKHMeHUkHyjvB2y4heGHu6XlmTAmr9eEW2
	s/z5NOJGlfwQyv2kT/JeQ9vE3Y2CMb+skQaxesJo5pHbpIOkZvXyl3el64NX5Kvd
	KQpqEN2blg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee889br8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 16:06:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SFs4au031955;
	Thu, 28 May 2026 16:06:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb8vcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 16:06:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SG6ZU161538714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 16:06:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7239A20043;
	Thu, 28 May 2026 16:06:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02ADD20040;
	Thu, 28 May 2026 16:06:33 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 May 2026 16:06:32 +0000 (GMT)
Date: Thu, 28 May 2026 21:36:32 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Chen, Yu C" <yu.c.chen@intel.com>, tim.c.chen@linux.intel.com,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-sched@vger.kernel.org
Subject: Re: [BUG] sched/cache: "Make LLC id continuous" causes NULL cpumask
 dereference in build_sched_domains on POWER9
Message-ID: <ahhoCMiKZs2Hgj8W@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
 <o6i06n2o.ritesh.list@gmail.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <o6i06n2o.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 5F5gkDbRgvwGpH78-BU-Iok2j7buPhUe
X-Proofpoint-GUID: f31wF4AfIMydrYbqZTCjlIiOdJMLigr5
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a186810 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=iuu2KmbQcLBheBbGiaYA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE2MyBTYWx0ZWRfXwChZDdV2nNUM
 gk5hg0WSOVA+mVE/ZFaHEPWox8F7Hq/NlxsbEdpkZ9+sfzZL7i+qdZ6MCGfAyEhTUk4ec4yRN7J
 kJNzwheW2HaXPFeeqXczQsIPdhx7uwb52/ili/AcfF5lV87RtvFkshOAmkpeaxjN5DOelHiErof
 olsT/dB0dbVpjFcIrM7axNF1BdiT5NNO6TOTO7obIb6yRzzHZHww9hQOpiz28esKRwgSWRw+AsE
 d6mHSDTWMjkd5xdB9XAr3RG5r4lQalxL6MOjeCSaUGgwakgDNTG5D4nMVkcc+qQc5BSLpY/aLVN
 P4eZn95cjsUcLuWnoZC2HaY4mBpuZq9Fb7BfOhXsTckTlseappK1dAe+/Acknr99uT7qJZDduVz
 CBnlO8YuTD9rkkHDPo36vyL38UtmqTVEvvJQ/y9k/CeQ0H23C3ZIWggijc6Uavw1/5f4zTBlQ0r
 2ItVfTI4rtvy44dDcjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280163

* Ritesh Harjani <ritesh.list@gmail.com> [2026-05-28 12:24:39]:

> Venkat Rao Bagalkote <venkat88@linux.ibm.com> writes:
> 
> > Greetings!!!
> >
> > I am seeing an early boot kernel panic due to NULL pointer dereference 
> > on a POWER9 (pSeries) system when testing linux-next (next-20260522).
> >
> >
> > [    0.039029] NIP [c000000000e58504] _find_first_bit+0x44/0x130
> > [    0.039043] LR [c000000000e58500] _find_first_bit+0x40/0x130
> > [    0.039054] Call Trace:
> > [    0.039060] [c0000000090e7b80] [c00000000416af20] 
> > schedutil_gov+0x0/0xa0 (unreliable)
> > [    0.039076] [c0000000090e7bc0] [c00000000038b3b8] 
> > build_sched_domains+0xad8/0xe50
> > [    0.039089] [c0000000090e7ce0] [c000000003045d78] 
> > sched_init_smp+0xa8/0x164
> > [    0.039102] [c0000000090e7d30] [c00000000300f374] 
> > kernel_init_freeable+0x250/0x370
> > [    0.039117] [c0000000090e7de0] [c000000000011f90] kernel_init+0x34/0x1e4
> > [    0.039129] [c0000000090e7e50] [c00000000000debc] 
> > ret_from_kernel_user_thread+0x14/0x1c
> > [    0.039142] ---- interrupt: 0 at 0x0
> > [    0.039150] Code: 41820090 7c0802a6 393cffff fbe10038 7c7f1b78 
> > fba10028 fbc10030 3bc00000 793dd7e2 f8010050 4bae6e9d 60000000 
> > <e93f0000> 2c290000 408200bc 283c0040
> > [    0.039196] ---[ end trace 0000000000000000 ]---
> >
> >
> 
> Well, I am hitting this on 7.1.0-rc5-next-20260526-00010-gbfac43765a97
> with Qemu Pseries TCG power10/11.
> 

Qemu Pseries guest would be a shared lpar. So thats expected to be similar
to P9. We would not have a coregroup_map allocated.

> [    0.342868][    T1] smp: Bringing up secondary CPUs ...
> [    0.342868][    T1] smp: Bringing up secondary CPUs ...
> [    0.525419][    T1] smp: Brought up 1 node, 4 CPUs
> [    0.525419][    T1] smp: Brought up 1 node, 4 CPUs
> [    0.527992][    T1] numa: Node 0 CPUs: 0-3
> [    0.527992][    T1] numa: Node 0 CPUs: 0-3
> [    0.552787][    T1] BUG: Kernel NULL pointer dereference on read at 0x00000000
> [    0.552787][    T1] BUG: Kernel NULL pointer dereference on read at 0x00000000
> [    0.557446][    T1] Faulting instruction address: 0xc000000000fe3f1c
> [    0.557446][    T1] Faulting instruction address: 0xc000000000fe3f1c
> cpu 0x0: Vector: 300 (Data Access) at [c000000006607800]
>     pc: c000000000fe3f1c: _find_first_bit+0xc/0xc0
>     lr: c00000000027b7d8: build_sched_domains+0xbb4/0x1938
>     sp: c000000006607ac0
>    msr: 8000000002009033
>    dar: 0
>  dsisr: 80000
>   current = 0xc000000006f9fb00
>   paca    = 0xc000000005670000   irqmask: 0x03   irq_happened: 0x09
>     pid   = 1, comm = swapper/0
> Linux version 7.1.0-rc5-next-20260526-00010-gbfac43765a97-dirty (powerpc64le-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #19 SMP PREEMPT Thu May 28 12:29:51 IST 2026
> enter ? for help
> [link register   ] c00000000027b7d8 build_sched_domains+0xbb4/0x1938
> [c000000006607ac0] c00000000027b0a8 build_sched_domains+0x484/0x1938 (unreliable)
> [c000000006607c20] c000000004053180 sched_init_domains+0x114/0x1cc
> [c000000006607c70] c0000000040515e0 sched_init_smp+0x5c/0x17c
> [c000000006607cc0] c000000004012888 kernel_init_freeable+0x258/0x790
> [c000000006607dc0] c000000000011f3c kernel_init+0x34/0x268
> [c000000006607e30] c00000000000debc ret_from_kernel_user_thread+0x14/0x1c
> ---- Exception: 0  at 0000000000000000
> 
> 
> 
> -ritesh

-- 
Thanks and Regards
Srikar Dronamraju

