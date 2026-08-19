Return-Path: <linuxppc-dev+bounces-25976-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6E0C5DF6D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 10:53:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQ3Ly4BHwz2yRP;
	Wed, 19 Aug 2026 20:52:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787136778;
	cv=none; b=GKeRk5iz7i+ytcQMsbR33lByG0PXflvdkUPuVp1AUeDuOQRs2O1QlYUw7rgbbw3CORB26Hp3EGV6VJ1Bfk/P8O2gEx1s9Do6iCA76kaUlcOXfFQ+Vx4/J9xw7nJyjiX8TvsYZHpS+DLJ+pCMg2EkOAAaUeRjLR9ZTov6MGhDK7EtaBDDuq9B55tfBnja25W7ecRQ8eAWFzLxngM/yV8nn/JuvyyhsY6C/iCwpxf8OG3q9E1KAj0dR9JQ5yvR4dTPbHiOThE70L1l962OxkO+sqNmH6w6uBxhIWBl5snnbOsQDOsprylT/RysEs8uy1HmC1T37BEILSt4WqbkkfCxuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787136778; c=relaxed/relaxed;
	bh=ODqcynh48DF+U6BzDMA9wiegxlct3FULbs4DxYKWWyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGn7WHchHB16InqqkLT62J7+xOZniKhFWcUlcw0S3fOQZ20PYz2S3bZHgWgx8A5quXuBwakl3LTKY1d/8txyatvE76sIupGc6xEF1tgSmoOvtAq8IE1m0vo/WWBtdTuCnf9Jq9w/l1Z13DFb1G9l1LU9zrhgLhRFrrCBTTEA3WrVHI08AWrDRZ2Vp7eWH16OwK8yz3Vf6IKs154Y1kNiYTMp4EK3aDHK5Ob3cD45lomQBHdBbP4W9ePhcVdrOvhbZAuXZkXjdINEkXq4hLmOMu7uyvH4cNqrMn9mAS7oFf0k5dSJX0n60UKffjkjfuC6Kv7OzoBp66r5dtiZ8g2uiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QBnvrHuj; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QBnvrHuj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQ3Lx1hbmz2yFW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2026 20:52:56 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JAVdFb3147987;
	Wed, 19 Aug 2026 10:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ODqcyn
	h48DF+U6BzDMA9wiegxlct3FULbs4DxYKWWyc=; b=QBnvrHujFCMQZxPft7xRNR
	2v9Bs3xzyXXVBDb5zlTs9PUhyPXBTxtmAH7YtnxLw8lpGoU17adyj1dS7DuID5/O
	tJWD8wtfJXy1dCKzLqxpkuJtMBmsYUa3w4yHwLb9coTk4A/tfTtojdVbOrr+mKWR
	wtCg6oxQ0ull20wkhdMPfQ8E2Ud/QtMSQbE8CaR0fiYbi40RHe+mcg5E3FOY01Tc
	BXlJ22dPIR0s1hDPqRj8KtxVpGE6ESBjq/gLh5CHR8g4d+M/P2hkbqGxCEiggpyn
	DmsBjxeGf/nO0U5MjSqI5Q+nnO+8Nd4nFUHyV6PbczuaelOqv/uW+Ku6cF6zCKnw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1b5w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 10:52:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JAfKZ7016921;
	Wed, 19 Aug 2026 10:52:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw8krm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 10:52:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JAqZlF46924116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 10:52:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E93BB2004B;
	Wed, 19 Aug 2026 10:52:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A88D120043;
	Wed, 19 Aug 2026 10:52:32 +0000 (GMT)
Received: from [9.124.213.40] (unknown [9.124.213.40])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 10:52:32 +0000 (GMT)
Message-ID: <d9c19203-a9d8-4815-9f60-97e7411976e4@linux.ibm.com>
Date: Wed, 19 Aug 2026 16:22:31 +0530
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
Subject: Re: [PATCH] powerpc/entry: Use hard_irq_disable() in
 arch_interrupt_exit_prepare()
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, mchauras@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260812152035.1661781-1-mkchauras@gmail.com>
 <e49d543e-80b2-4c8c-968d-0c8b68717cbb@linux.ibm.com>
 <an6w517sUDWwpVfZ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <an_xbqRgm4RaRw0r@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <999c327b-3ec9-4636-a29e-57795d333912@linux.ibm.com>
 <aoVrvjiSMmEDbwIF@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <aoVrvjiSMmEDbwIF@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a858af8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=nRNRJwip4-sjPr2wZrkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Uf3lwXJO_fhDCHhy4I-GwgMDjl3RoEGW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA4MCBTYWx0ZWRfX9YepzCy1b1Q+
 nvsa0t06NmwYgXoMLfkb7PMg7HUYAqnwfxm7puGF6BBfvHzBBdfu9xRix0ujX/MmnrdDMvm0ULn
 rcLFG3mJal9NPCWGphaf5WBzm0oxIrk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA4MCBTYWx0ZWRfXyQlVL0JDxFat
 EaPRfs2aXPwVPg9P4SKFZW91k8sSONBwxJrBJZOTuawNJzqKLmYN8SQnCyl+0TpzvGAEem2MBy7
 69NR8YHTfmT793463otwEDnbMgLstzqy9r+D7ZsG6HT/2+5rtwjh1mj0Gs3L8CYZsJRhfCIWgng
 esPYudId7ZDTkIOs8CdorXpZrr5rfKtCKxYlArRxYYQufFVSgV2nhuMaDx5dbXB1Z5Co2+vA89/
 lXF1FQfMjjIoru44+P5GWuTR29CaADywgVziB9nVJ+H0XZI5oAX1s48NmvJWcBZU4Yjhc7CQ58k
 ViYWkMFVdPPQyf7wRuoFQFDmyh064iRz2f8dIDbRIzYiGcADuHnOLIgR9zyybAfZW7Tt+Mej4Lu
 YBmJ6zt+bhKEz31T6Oyg3BBZxAMiEoK4x16WjvwHLO2cHlX7oqKcD1P6CJNnia23SNoKDIukGRV
 FCfJlQvlvr3QEl12w9Q==
X-Proofpoint-ORIG-GUID: ae-WBYIFivmS0RhzZlDtV8isTLSVbE2b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190080



On 8/19/26 2:16 PM, Mukesh Kumar Chaurasiya wrote:
> On Wed, Aug 19, 2026 at 11:24:40AM +0530, Venkat Rao Bagalkote wrote:
>>
> [...]
>>> Hey Venkat,
>>>
>>> Can you try this diff,
>>>
>>> diff --git a/arch/powerpc/kernel/irq_64.c b/arch/powerpc/kernel/irq_64.c
>>> index d5c48d1b0a31..2fbfebef74fe 100644
>>> --- a/arch/powerpc/kernel/irq_64.c
>>> +++ b/arch/powerpc/kernel/irq_64.c
>>> @@ -117,7 +117,7 @@ static __no_kcsan void __replay_soft_interrupts(void)
>>>    	local_paca->irq_happened |= PACA_IRQ_REPLAYING;
>>>    	ppc_save_regs(&regs);
>>> -	regs.softe = IRQS_ENABLED;
>>> +	regs.softe = IRQS_DISABLED;
>>>    	regs.msr |= MSR_EE;
>>>    	/*
>>>
>> Hello Mukesh,
>>
>> With the proposed change, I still the issue.
>>
>> [    0.742633] ------------[ cut here ]------------
>> [    0.742633] WARNING: arch/powerpc/kernel/irq_64.c:75 at
>> __replay_soft_interrupts+0x104/0x220, CPU#6: swapper/0/1
>> [    0.742637] Modules linked in:
>> [    0.742638] CPU: 6 UID: 0 PID: 1 Comm: swapper/0 Tainted: G   W
>>   7.2.0-rc7-dirty #25 PREEMPT
>> [    0.742639] Tainted: [W]=WARN
>> [    0.742640] Hardware name: IBM,9080-HEX Power11 (architected) 0x820200
>> 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
>> [    0.742641] NIP:  c00000000003a384 LR: c00000000003a360 CTR:
>> c000000000029f00
>> [    0.742642] REGS: c000000009757410 TRAP: 0700   Tainted: G W
>> (7.2.0-rc7-dirty)
>> [    0.742643] MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE> CR: 88024824
>> XER: 00000003
>> [    0.742646] CFAR: c00000000002a708 IRQMASK: 1
>> [    0.742646] GPR00: c00000000003a360 c0000000097576b0 c000000001b28100
>> c0000000097576d8
>> [    0.742646] GPR04: 0000000000000000 0000000000000001 c00000000968d200
>> c0000000096eb200
>> [    0.742646] GPR08: 0000000000000001 0000000000000041 0000000000000001
>> 000000002c1b8100
>> [    0.742646] GPR12: c000000000029f00 c0000005ffff8f00 0000000000000000
>> c00000000968d200
>> [    0.742646] GPR16: c000000002f3aaf8 0000000000000000 c00000000284e138
>> 0000000000000000
>> [    0.742646] GPR20: c00000000303aaf8 c00000000303ade8 0000000000000001
>> 0000000000000000
>> [    0.742646] GPR24: c00000000303ae08 0000000000000000 0000000000000000
>> 0000000000000002
>> [    0.742646] GPR28: 0000000000000003 fcffffffffffffff fcffffffffffffff
>> c00000000968d200
>> [    0.742662] NIP [c00000000003a384] __replay_soft_interrupts+0x104/0x220
>> [    0.742665] LR [c00000000003a360] __replay_soft_interrupts+0xe0/0x220
>> [    0.742668] Call Trace:
>> [    0.742668] [c0000000097576b0] [c00000000003a360]
>> __replay_soft_interrupts+0xe0/0x220 (unreliable)
>> [    0.742672] [c000000009757860] [c00000000003a694]
>> arch_local_irq_restore+0x1f4/0x2d8
>> [    0.742675] [c0000000097578b0] [c0000000002face0]
>> console_flush_all+0x3ec/0x558
>> [    0.742676] [c000000009757a00] [c0000000002faee4]
>> console_unlock+0x98/0x1d8
>> [    0.742678] [c000000009757a80] [c0000000002fc698]
>> vprintk_emit+0x2c0/0x3f4
>> [    0.742680] [c000000009757af0] [c0000000002fdc70] vprintk+0x30/0x7c
>> [    0.742682] [c000000009757b10] [c0000000002f6c78] _printk+0x3c/0x50
>> [    0.742683] [c000000009757b30] [c00000000205d814]
>> load_system_certificate_list+0x24/0x5c
>> [    0.742685] [c000000009757b90] [c00000000001111c]
>> do_one_initcall+0x5c/0x3f0
>> [    0.742687] [c000000009757c70] [c00000000200684c]
>> do_initcalls+0x11c/0x270
>> [    0.742689] [c000000009757d30] [c000000002006c78]
>> kernel_init_freeable+0x228/0x3c0
>> [    0.742690] [c000000009757de0] [c000000000011600] kernel_init+0x30/0x260
>>
>> [    0.742692] [c000000009757e50] [c00000000000df7c]
>> ret_from_kernel_user_thread+0x14/0x1c
>>
>>
>> Regards,
>>
>> Venkat.
>>
> 
> Hey Venkat,
> Thanks for verifying.
> 
> The regs.softe = IRQS_DISABLED change only prevents
> irqentry_exit_cond_resched() preemption path from running — it does nothing
> about PACA_IRQ_HARD_DIS being cleared by the handler and not restored.
> hard_irq_disable() fixes both: it atomically sets PACA_IRQ_HARD_DIS, sets
> irq_soft_mask = IRQS_ALL_DISABLED, and clears MSR[EE], leaving a fully
> consistent disabled state that next_interrupt() expects, regardless of
> which entry path (idle wakeup or irqrestore) triggered the replay.
> 
> To answer's shrikanth question
> it worked before because there was literally no interrupt-disabling code
> on the handler exit path during replay. The new GENERIC_ENTRY
> infrastructure brought a real exit sequence with it, and that sequence
> needs hard_irq_disable() — not local_irq_disable() — to keep PPC64's
> two-level interrupt state (irq_soft_mask + PACA_IRQ_HARD_DIS) consistent.
> 
> Hey Madhavan,
> I think we are ok with this patch if there are no more objections from
> anyone.
> 

Venkat,

Can you collect vmcore with panic on warning enabled?

It maybe nested replay of soft interrupts which maybe causing problems 
here. We should see the regs state.

> Regards,
> Mukesh


