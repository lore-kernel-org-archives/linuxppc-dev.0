Return-Path: <linuxppc-dev+bounces-27919-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F492C982FA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 15:13:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hq3XC6DRtz2ygK;
	Wed, 23 Sep 2026 01:13:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790090027;
	cv=none; b=LtKwuYEoAxbGts3V82r83VVk1bf7ytud7cfLrIfaxAZ/AhaAsrFbnqOpCu2p+h/N8EHK0fp8ugGX0LRlZvbfJe2V9CeD252sq1qkbJ04/gVypEHkFCJmC9vxLEFkCrst117x75yqHrBMTvP8aBSgeaCC/tOxXWEhtUOj1MowgePjgbmyu+yVIHnp0RBhnWKenk0wylUgABLiN24EOaF+rp68Igo87jFqCkNJCekGz2tbD0PpMPmgTuJJGTiaY35cVESsAVlVvVUqSVWX51dOYf10uFZ9hImnHgFunOFfD0h/Lidddxdsh0tv0ur/LD5XZynqQGSJ2n28ex+GNaSaRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790090027; c=relaxed/relaxed;
	bh=lzZ7qLwrQMpSPZbhbQDdZ+F/CJAgHkdbwOO4EHN9WsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wk5cfE/m3vLc7w3BCEpeFuIUGlibOPfmJCSWIB/xQ3qD/PJJw1bAlAAnHCplsTUKyFmXJ5p1qvJoiftEJwjbt/+pI07YobjeKMsufXn8EqkVTP++456U40pEmJwlxJCxXOz+TiI/Btf+4Ii0xNWKOMtU02FsrTUnzSxMCDBVFbPkFjqx8LT9iw7DTm6Pcw3KCITSRR7u2wn65vGEaZ6yxBLt2/+0qBnbmvPcxZdfOdYepmziE8FmqaXmszlEEYJIcUTBWSGCoxG2OrLs53vEMaoVuD/BUnglRNmyNXmOVnpMOTQFzdrUhsw/mGa+aVVhmmZYdI2qaNingfYGa6Qgyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RNTQqDDk; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RNTQqDDk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hq3XC0vZNz2yQJ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 01:13:46 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MF5Swv752500;
	Tue, 22 Sep 2026 15:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lzZ7qL
	wrQMpSPZbhbQDdZ+F/CJAgHkdbwOO4EHN9WsM=; b=RNTQqDDkaMnutjXcRVFTQ/
	WvpU8EypWs0BdJ57B8OGHA89iICNI7jG4QivrXiNgE0lfa5EmZrI+4TzVo9Sf+dA
	KsZ8OF2b0TqT/Q1UnKf4oAO11kxnKHlfa5pxpB6QpuKvuHs/l0jsGy24e7agCEDW
	5QGR8973BI1seMg/eXSK8P+ug3QAIgHYOAuKITWSjQkLm+dUwNk7v+9TaDJ7p53d
	8N2jHft/T2c29azdVNDQxmu8vfk25uJJFcF9w2uKden4vAydVuO7HHl5SwkCiGtF
	2d1CU5ryIAQjXjfkP0ASfH3W/cXsSgrD7eFEIHcrFMuvxq+2VJ8aaFhN8ZrrUkLg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgs6gbk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 15:13:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68MElYOn3046803;
	Tue, 22 Sep 2026 15:13:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qqaf4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 15:13:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68MFDH9052101456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 15:13:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AFEB2004B;
	Tue, 22 Sep 2026 15:13:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31B5920040;
	Tue, 22 Sep 2026 15:13:15 +0000 (GMT)
Received: from [9.39.20.195] (unknown [9.39.20.195])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 15:13:14 +0000 (GMT)
Message-ID: <d8d9ee29-e871-4657-9951-36a3b2b2ea56@linux.ibm.com>
Date: Tue, 22 Sep 2026 20:43:14 +0530
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
Subject: Re: 7.3.0-rc4: DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org,
        Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani
 <ritesh.list@gmail.com>,
        "Mukesh Kumar Chaurasiya (IBM)"
 <mkchauras@gmail.com>
References: <20260922150619.lwWqj1AO@linutronix.de>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260922150619.lwWqj1AO@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab29b12 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=heuPLrr5t0BLJfQVZ9kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jtkIc7Fv08WLk519RqRkkhObL5SmfjEu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDIyMCBTYWx0ZWRfX+s1tiOt/5s60
 bpTap8OGyWDxCx0YhFnZ1BJP3Fvbd/x8WxcVySbmz06OI6N3glI6XZEpSh4mrSgUq7fZAh0oMPa
 9aymctFwRuhApJS3Cd/rDahDfZbA4JXFGO4iGRVL4ZS/Cq6xd5CJq1mC0YtLGOYf1XMuyb7GBWj
 r9EqQQQXIpsPXdonf0jCUhmaomvn6DGzD4NqrQrKOC72kuwHXl8DtdoG8DfgY4KiQUva8pKBYUU
 ilHdPlyOM5+odnXQDyCZThaSAzMPUQ2Ru8wXTVcLjRx8WOLCzNNKlUgV/CiJvyiXURpfUAbaLw+
 BgJjS19V4zxzAVVI2qU31nUGrLaLGMWkO6vd7DmXAPVTBqEtxk/Iwn2RErRZiragmoBELyyHjJa
 u//OQFbWHNBSyW/PglmO9EIoICZhkVSqzTWlX9Al1dE1B5r5iEEYDboyCT3eEPgiA+sB3sUqZFO
 ORGblLHcIG+PiFHv9tg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDIyMCBTYWx0ZWRfX75T5QVuEFGXR
 JtlnpqtYY2wIi3uW3yu+YbyolgxsJcIl2Rxt8irSaeob3DOBjLYq4K1txzzRZalplCqqrmMMTDs
 CZCXP4SQRHwun4ZqnPP+41RxWgwxZKg=
X-Proofpoint-GUID: y77l1Ua8lb9QaVLdUOI0Kmr7wj2fgo0Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220220

Hi Sebastian.

Thanks for the report.

+cc mukesh

On 9/22/26 8:36 PM, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> I've seen similar reports such as
> 	https://lore.kernel.org/all/b44aefc5-e066-478b-8d34-50d2d0deab6b@linux.ibm.com/
> 

Yes, we had taken a look at them. There is work being done, but patches
haven't been posted since we were burning cycles to fix the functional issues
even without lockdep on generic entry.

> but nothing on recent one. I am not sure if this is the same issue or

What do you mean nothing on recent one? You don't see the lockdep warning?

> something different. This happens during boot:
> 
> | ------------[ cut here ]------------
> | DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
> | WARNING: kernel/locking/lockdep.c:4448 at lockdep_hardirqs_on_prepare+0x22c/0x2e0, CPU#0: swapper/0/0
> | Modules linked in:
> | CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.3.0-rc4 #6 PREEMPT(lazy)
> | Hardware name: IBM pSeries (emulated by qemu) Power11 (architected) 0x821200 0xf000007 of:SLOF,HEAD pSeries
> | NIP:  c0000000001ec72c LR: c0000000001ec728 CTR: c000000000e1ab70
> | REGS: c0000000017531e0 TRAP: 0700   Not tainted  (7.3.0-rc4)
> | MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 48028228  XER: 00000000
> | CFAR: c00000000011ee84 IRQMASK: 3
> | GPR00: c0000000001ec728 c000000001753480 c000000001248000 000000000000002e
> | GPR04: c0000000015ee8d8 c0000000015ee9c8 0000000000000001 0000000000000080
> | GPR08: c0000000015ee7b8 0000000001000003 c000000001581400 0000000048028228
> | GPR12: c000000001788228 c000000002340000 c0000000005bbd50 c000000000ea30f0
> | GPR16: c0000000016cec98 c0000000011a1518 c000000003327658 0000000000000001
> | GPR20: c0000000016c9620 c0000000015e3c80 c0000000016c9670 0000000000000000
> | GPR24: 0000000000000000 0000000000000001 0000000000000000 c000000001788228
> | GPR28: c000000001380580 c000000000027644 0000000000000000 c000000001387160
> | NIP [c0000000001ec72c] lockdep_hardirqs_on_prepare+0x22c/0x2e0
> | LR [c0000000001ec728] lockdep_hardirqs_on_prepare+0x228/0x2e0
> | Call Trace:
> | [c000000001753480] [c0000000001ec728] lockdep_hardirqs_on_prepare+0x228/0x2e0 (unreliable)
> | [c000000001753500] [c000000000331c90] trace_hardirqs_on+0x90/0x130
> | [c000000001753540] [c000000000e257f4] irqentry_exit+0x554/0x10b0
> | [c000000001753600] [c000000000027644] timer_interrupt+0x254/0x5c0
> | [c0000000017536c0] [c00000000003a2c0] __replay_soft_interrupts+0x140/0x390
> | [c000000001753880] [c00000000003a614] arch_local_irq_restore+0x104/0x1f0
> | [c0000000017538b0] [c0000000001eed9c] lock_acquire+0x19c/0x440
> | [c0000000017539b0] [c000000000541024] __kmalloc_cache_noprof+0x114/0x630
> | [c000000001753a90] [c0000000004970c8] shrinker_alloc+0x38/0xe0
> | [c000000001753ac0] [c0000000005bf374] sget_fc+0x364/0x940
> | [c000000001753c00] [c0000000005bfd78] get_tree_nodev+0x38/0xf0
> | [c000000001753c40] [c000000000649060] nullfs_fs_get_tree+0x20/0x40
> | [c000000001753c60] [c0000000005ba01c] vfs_get_tree+0x3c/0x110
> | [c000000001753ce0] [c0000000006043a0] fc_mount+0x20/0xc0
> | [c000000001753d20] [c000000000604544] vfs_kern_mount.part.0+0x104/0x120
> | [c000000001753d80] [c0000000006045bc] kern_mount+0x2c/0x60
> | [c000000001753da0] [c000000001296f20] mnt_init+0x3c8/0x50c
> | [c000000001753e80] [c000000001296610] vfs_caches_init+0x100/0x144
> | [c000000001753f30] [c00000000125442c] start_kernel+0xa4c/0xabc
> | [c000000001753fe0] [c00000000000d688] start_here_common+0x1c/0x20
> | Code: 4182ff80 3d220054 3929106c 81290000 2c090000 4082ff6c 3c82ffe7 3c62ffe7 38846858 3863dfd8 4bf32645 60000000 <0fe00000> 4bffff4c 60000000 60000000
> | irq event stamp: 472
> | hardirqs last  enabled at (471): [<c000000000e39034>] _raw_spin_unlock_irqrestore+0xa4/0xb0
> | hardirqs last disabled at (472): [<c00000000003a5b8>] arch_local_irq_restore+0xa8/0x1f0
> | softirqs last  enabled at (10): [<c00000000012db60>] handle_softirqs+0x670/0x6d0
> | softirqs last disabled at (3): [<c000000000016f88>] do_softirq_own_stack+0x38/0x50
> | ---[ end trace 0000000000000000 ]---
> 
> Sebastian

IIRC, it is tricky to fix since softreplay is a unique thing on its own
and tracking right context gets tricky.

Mukesh had spent some time on it. Lets wait to hear from him.

Plus we had some more lockdep warnings too. There is effort ongoing to fix
them. Hopefully soon.

