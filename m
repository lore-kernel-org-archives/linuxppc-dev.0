Return-Path: <linuxppc-dev+bounces-25331-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152F8C55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 06:36:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDkMk4JYzz2yMl;
	Tue, 04 Aug 2026 16:36:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785825378;
	cv=none; b=jr0KNhr+DTNbfisjrKbQDdjFh8sore9Tb/HGn6Z+FRZsoY1uDre1K4qZznAm4QAnJUBoAfimPLPFLAQk7xejtJQvMuznzQf5TnKjS9t38KuRlZsFV6GCFsdJP/PTmXSPQog7Z1im9CfAyGNffeJSoutthc5WNzEtbzEF3aVVb5ewhm1WGjYJTKhK/oLZG0MtcnFJAGz86HM3RNVEZ6qrYeXlxoB+Ulgn6ZKQ77uZwfjzMypvntmZceuWRvydRAx5+DmnZyGE6dCyw4gPwHWp2gfTEBUbNhn/4L0mBRJFx+PkwLspEqykvmPi9DNVL+hgXNW18yYI4faPx1mFKZR6+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785825378; c=relaxed/relaxed;
	bh=m7oz6hMdyn6pjrb5QtuYropL/bnE+tpsmEfe9HYxWR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=En5IxRsPuTtFsGUe6gAD8NSMY86YKzBorl8MfYOZUz5LwooV17cN2dfn1V04lzW/0RArtKTsZKb0vgizxNKoEBoQ6LxSRp5FZuxsPTYY5LhI9CFDHXC8wOen7XFHKI2cy9S2YQmHvSXMXZ2GFl+R+ZzM0ZFq7TA0AoHKXKfEECD1vq93XTJ/dffYJLoOuChEKTp5emUpaStirIbcCVJe/uAOPhVo2qWFRWl4QCYNLfh/0+ZmSkX0A0HLZPlcKfQLOvNN26nOb9G8f8FgvjkHfkD8Mk0Iyv6PDzyj3U/7MyY69q/4nj075n+vd1SbbQavffZSkYfARCKfbT9uJbhKXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dndbhq6w; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dndbhq6w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDkMj31cTz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 16:36:16 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741HgEc1784177;
	Tue, 4 Aug 2026 06:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=m7oz6h
	Mdyn6pjrb5QtuYropL/bnE+tpsmEfe9HYxWR0=; b=dndbhq6w+kUJNPx1IIRLA4
	m3LiqVp7KMhbI6JL9bV2VyGkwGh1G4qHLUA8x6Xq8jEiAUmZm4H0IJFhXG1fruos
	XxcDb5yB8d/p/EJVzY+YylusKSgiFkYANONmhd/Xl4Wff+dAbxS65USA2YMmuzB6
	WSpWPYpbiQ3VFDyvTpwvSMM0T+73NKo0/NvBTgxYcDJWUgcXYTQe2tWAGMH/2NGY
	AeFWgYU6ggbPrmvIyUQG3wAs/h1oSJs695lPI63+qvKdevUH8nfZxE+OQcd9Oy2t
	/4HGf4Zbm9XwDXW72jZvHzm7xQ67foFlKsXbwHAqK+pjHwFIqAHjE10u5NNHv6Ig
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqme7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 06:36:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6746QUgZ016596;
	Tue, 4 Aug 2026 06:36:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh8qcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 06:36:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6746a4bi16056742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 06:36:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBB822004F;
	Tue,  4 Aug 2026 06:36:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1279820040;
	Tue,  4 Aug 2026 06:36:03 +0000 (GMT)
Received: from [9.39.27.209] (unknown [9.39.27.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 06:36:02 +0000 (GMT)
Message-ID: <e9a6d82c-8ce1-45a5-a5cf-e4476f97cecf@linux.ibm.com>
Date: Tue, 4 Aug 2026 12:06:01 +0530
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
Subject: Re: [BUG] powerpc/pseries: WARN in __replay_soft_interrupts() during
 SMP bringup on Power11 (7.2.0-rc5)
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <6f9bfb0f-b14c-468e-bb9f-c157d120d0dc@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <6f9bfb0f-b14c-468e-bb9f-c157d120d0dc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ieDwXKdORzNRILeB1OelveeOFHd9ZYYK
X-Proofpoint-ORIG-GUID: NBKyUE3_cioRgYZlYUJ2ViujEjJuzGfH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA0OCBTYWx0ZWRfXz5a82doekTZ9
 Y3UQJ2saMLRlbt31fn2MKOfRl/M/lAZt2wSqYOZg31IlvFMSCgeACDA+V+DTr6XVSX3f/GqI2p8
 eHYiN0gr0k9OW2xmzpEX6hXjtItXGrk=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a71885a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=JoO0O_xPh0EsBQ-FPcYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA0OCBTYWx0ZWRfX3yP7mzgBlHQq
 KwKeV+ETQv1MEthqkgLwFP+SSwW1uodlL16ZPteEy7rnhx5VY0QWPleJZvXxwZxXDR+A8qhUP2M
 7mU0e5k4UyN3eztnuELGYWvEHwGp1VOocb3dLLDfFnvyR0kJ7NdFptlfgRXXuf/4X5TtqSP32H7
 nHAsgxOqhN4IdrgUhz/2KCx8B9klvWG90sByKzkf27HaDYeCqrU78W8Cj8IZAxIFeIdsgAw/bF+
 hQHAq+4bab69zj4/ZPlWiGFj9Ty8sSytrG0XCzpOUQUtJ5DAfLCT5MXIeFZ/4bykxyhCkYIrEEf
 urSmwS5yzrEQ+4Bh67LSIp7cX50KlFhyYXGl2C5wb5dO02Aa1p6QR5x2sx8ih4Q3fICgQ/GGFvv
 w3HRYclH/33OtaDlYzDX/rMw9tEZsB/XGCduTH94qxzRMZ2/s/28RoyG/IIyQNTjUsISWgBAOuz
 tnLqEz5OSm1Dp9HjWIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040048

hi venkat,

On 8/4/26 11:39 AM, Venkat Rao Bagalkote wrote:
> Greetings!!
> 
> 
> I'm seeing a reproducible warning during early boot on a Power11 pSeries 
> LPAR with Linux 7.2.0-rc5.
> 
> The kernel starts booting normally and reaches SMP initialization, but 
> then begins emitting continuous warnings from 
> __replay_soft_interrupts().The warnings continue indefinitely and the 
> system never completes boot.
> 

Can you try bisecting it?

> 
> Call Trace:
> 
> 
> [ 2513.069347] WARNING: arch/powerpc/kernel/irq_64.c:75 at 
> __replay_soft_interrupts+0x14c/0x220, CPU#0: swapper/0/0
> [ 2513.069354] Modules linked in: bonding tls nft_fib_inet nft_fib_ipv4 
> nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 
> nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 
> nf_defrag_ipv4 nf_tables rfkill sg pseries_rng vmx_crypto fuse loop 
> vsock_loopback vmw_vsock_virtio_transport_common vsock xfs sd_mod 
> ibmvscsi ibmveth scsi_transport_srp dm_mirror dm_region_hash dm_log dm_mod
> [ 2513.069380] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G     W     
>     7.2.0-rc5 #2 PREEMPTLAZY
> [ 2513.069385] Tainted: [W]=WARN
> [ 2513.069386] Hardware name: IBM,9080-HEX Power11 (architected) 
> 0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
> [ 2513.069390] NIP:  c00000000003b2dc LR: c00000000003b2b8 CTR: 
> c000000000190af0
> [ 2513.069393] REGS: c000000002d074d0 TRAP: 0700   Tainted: G   W     
> (7.2.0-rc5)
> [ 2513.069397] MSR:  8000000000021033 <SF,ME,IR,DR,RI,LE> CR: 84002288 
> XER: 00000001
> [ 2513.069404] CFAR: c0000000000189cc IRQMASK: 1
> [ 2513.069404] GPR00: c00000000003b2b8 c000000002d07790 c000000001938100 
> c000000002d077b8
> [ 2513.069404] GPR04: 0000000000000001 0000000000000001 0000000000000004 
> 0000000ef44c0000
> [ 2513.069404] GPR08: 0000000000000001 0000000000000041 0000000000000001 
> 0000000000002000
> [ 2513.069404] GPR12: c000000000190af0 c000000003030000 0000000000000000 
> 0000000000000000
> [ 2513.069404] GPR16: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [ 2513.069404] GPR20: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [ 2513.069404] GPR24: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [ 2513.069404] GPR28: 0000000000000000 fcffffffffffffff 0000000000000000 
> c000000002d079f0
> [ 2513.069440] NIP [c00000000003b2dc] __replay_soft_interrupts+0x14c/0x220
> [ 2513.069445] LR [c00000000003b2b8] __replay_soft_interrupts+0x128/0x220
> [ 2513.069449] Call Trace:
> [ 2513.069451] [c000000002d07790] [c00000000003b2b8] 
> __replay_soft_interrupts+0x128/0x220 (unreliable)
> [ 2513.069456] [c000000002d07960] [c00000000003b6e4] 
> replay_soft_interrupts+0x24/0x40
> [ 2513.069462] [c000000002d07980] [c0000000000338f0] 
> interrupt_exit_kernel_prepare+0x250/0x280
> [ 2513.069467] [c000000002d079c0] [c00000000000da68] 
> interrupt_return_srr_kernel+0x8/0x18c
> [ 2513.069472] ---- interrupt: 900 at plpar_hcall_norets_notrace+0x18/0x2c
> [ 2513.069477] NIP:  c0000000001bdb68 LR: c000000001318c98 CTR: 
> 0000000000000000
> [ 2513.069480] REGS: c000000002d079f0 TRAP: 0900   Tainted: G   W     
> (7.2.0-rc5)
> [ 2513.069483] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE> 
> CR: 24000282  XER: 00000001
> [ 2513.069492] CFAR: 0000000000000000 IRQMASK: 0
> [ 2513.069492] GPR00: 0000000000000000 c000000002d07cb0 c000000001938100 
> 0000000000000000
> [ 2513.069492] GPR04: 0000000000000000 8004000038667c10 0000000000000000 
> 0000000000000001
> [ 2513.069492] GPR08: 0000000000000000 0000000000000000 0000000000000090 
> 0000000000000001
> [ 2513.069492] GPR12: 8004000038667c00 c000000003030000 0000000000000000 
> 0000000000000000
> [ 2513.069492] GPR16: 0000000000000000 0000000000000000 0000000000000000 
> 0000000000000000
> [ 2513.069492] GPR20: 0000000000c00000 0000000000000008 0000000000000000 
> 0000000000000000
> [ 2513.069492] GPR24: 0000000000000000 0000000000000000 000002491e026596 
> 0000000000000000
> [ 2513.069492] GPR28: 0000000000000000 0000000000000001 c0000000022918e8 
> c0000000022918f0
> [ 2513.069527] NIP [c0000000001bdb68] plpar_hcall_norets_notrace+0x18/0x2c
> [ 2513.069531] LR [c000000001318c98] check_and_cede_processor+0x48/0x60
> [ 2513.069535] ---- interrupt: 900
> [ 2513.069537] [c000000002d07cb0] [c000000002d07d00] 
> init_stack+0x7d00/0x8000 (unreliable)
> [ 2513.069543] [c000000002d07d10] [c000000001319124] 
> dedicated_cede_loop+0x94/0x19c
> [ 2513.069547] [c000000002d07d60] [c000000001318300] 
> cpuidle_enter_state+0x2f0/0x738
> [ 2513.069551] [c000000002d07e00] [c000000000e6eea0] 
> cpuidle_enter+0x50/0x80
> [ 2513.069556] [c000000002d07e40] [c0000000002c1978] call_cpuidle+0x48/0x90
> [ 2513.069560] [c000000002d07e60] [c0000000002ca1b0] 
> cpuidle_idle_call+0x160/0x2e0
> [ 2513.069565] [c000000002d07eb0] [c0000000002ca434] do_idle+0x104/0x200
> [ 2513.069569] [c000000002d07ef0] [c0000000002ca7e8] 
> cpu_startup_entry+0x48/0x50
> [ 2513.069574] [c000000002d07f20] [c000000000011764] rest_init+0x114/0x118
> [ 2513.069578] [c000000002d07f50] [c0000000020052a8] do_initcalls+0x0/0x18c
> [ 2513.069582] [c000000002d07fe0] [c00000000000ea9c] 
> start_here_common+0x1c/0x20
> [ 2513.069585] Code: 992d0933 f9010168 4bfdd665 60000000 892d0933 
> 7d2a48f8 554a07fe 0b0a0000 890d0932 39400001 2c280003 7d40509e 
> <0b0a0000> 712a0002 41820044 552907fa
> [ 2513.069598] ---[ end trace 0000000000000000 ]---
> [ 2513.099343] ------------[ cut here ]------------
> 
> This I am seeing this issue with attached .config.
> 
> 

I don't see GENERIC_ENTRY in your config. So it maybe a older bug
seen with CONFIG_PPC_IRQ_SOFT_MASK_DEBUG.

