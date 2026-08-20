Return-Path: <linuxppc-dev+bounces-26020-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190F5C5DF85
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Aug 2026 14:48:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQmX14RLBz2xT6;
	Fri, 21 Aug 2026 00:48:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787237297;
	cv=none; b=DkJxbSDbzb7CbICYOHwTX5sYbKTC5RfWytXimeLYOqx9akoRWqiak9YkOOL4qmvuQm+qfIzOAWcAvVe7th1uGsYcBWDSMfW+Gkp9qzKUzGRrI/JK2ZEM+8IwLNoNgGMJZ+/ObeX/WqBvKHBTghSDXQ3PkFf9FDR66GQFDJzZsu4XC3h9LngRobxvLra6tLb6pERKTB4mWGmpmEGeaw/I72XyLxCQDZiUAmDHXgqKbnYaG1nZZBWV8XhT8bzifNC9wETFj2zJfaNI7g4FQOvtv6f9cADyvFY0OjvRYGtCgRdVWRRXjrL4aUrgzw1WN8a9s3QHJ5Rom1l7CWYF+dxDZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787237297; c=relaxed/relaxed;
	bh=Hvnhnz4f2PuLYr8Mdq0XSUeDEm2X+60ZcQaCe3DX3pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVUb7BMdVdD1vUapd4/t+5wtw8R5BdxQIASo9yQNkDfUPqMnAm3ahVUCKcqDrYHEfXU9+7bmB2pMAed+YstffzhSpEDwBnEOBxS9k6eSYEueL+cDizkd2qYuqpA83cS687DTmhHiRGaR83dhP3eY6jjrj0v96e9iZTxpsQZDx5KpBwEkvvKQPrjabJE0A7uBt5k4du64iChLT0dt3C7YNSBmq6pqyA0B7R505KP1grzm1QHwtvVsC1akDL2AnMf63KKjMdY3nJBVcehPcRpndP+xIWKB3DP1GV8Tz55jrTaYlp65tKkDiBvd6+sewLOsSEGsrqGAPTOJyuqrDfPqiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sxm78njo; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sxm78njo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQmX00sc6z2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2026 00:48:15 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KEW2lj2771727;
	Thu, 20 Aug 2026 14:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Hvnhnz
	4f2PuLYr8Mdq0XSUeDEm2X+60ZcQaCe3DX3pQ=; b=sxm78njoowIJWk3yMfA7Bg
	/W4ShF6E4/IMQPvl+XTBurZEZwzGY/pjlcGD1xxwrLV2LQaznGQZPEi9ue5aPG0R
	XU0JgDrpsDZjkLGsLL4hJW8qN6AExUpGIVGKj2LtBrbh//lNCIJj7Gm1BVbqF/am
	fv3UwrpJvW2w1GqithrvNSO7MUPbTPnI5zqKQcQrT8CYLT3cK6YBJDqk1pb4LgvK
	hshROWydHmGxuXQ/yE5gUVOpZxiikPmFeRg8BipKGRcQ/9hxF2Dq6KCw7lW60Dfg
	IacTTrD/S9xEiOXZ/JDBe4zY6U3rH8/MsfZU4aktMgWw5YJvScERBk4liHnSEKHw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4aucm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 14:48:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KEfI9H020123;
	Thu, 20 Aug 2026 14:48:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekf4dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 14:48:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KElwRJ39911888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 14:47:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6A6620043;
	Thu, 20 Aug 2026 14:47:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 485FB20040;
	Thu, 20 Aug 2026 14:47:56 +0000 (GMT)
Received: from [9.124.211.198] (unknown [9.124.211.198])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 14:47:56 +0000 (GMT)
Message-ID: <2e16b624-be55-4127-8ec8-db9479957f96@linux.ibm.com>
Date: Thu, 20 Aug 2026 20:17:55 +0530
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
Subject: Re: [PATCH V2] powerpc/entry: Fix irq_soft_mask corruption on
 replayed interrupt exit
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        mchauras@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20260820134718.2176411-1-mkchauras@gmail.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260820134718.2176411-1-mkchauras@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a8713a4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=EF15BPeV1vtgjPpHrm0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: zBcC0yL-Jw3oirLsSa2NFJa-9rJ-pP95
X-Proofpoint-GUID: HUkEiR7KcZau7RJEXTP2WQucqc7rk5Pr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwOSBTYWx0ZWRfXx9MX6ouHHvyv
 BHXnFNUxOuPgmNKR9/SA89Cjy4+O8f7F3agoHy/GMcsDlmB/aJD/BXEXvDTNOSCaEROtBwRQ0rm
 MxoO0r//Uajqj5UJpcp+EVmdMozIT1M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwOSBTYWx0ZWRfX+dTLzNyocqGR
 31InRShjt7eK8Ct2v6XPpw8+nh5gng3HNZFKhe75U81Uu1fCUnrU4pa0yE1Y4UgvZFRZhOru7Ch
 MOQP0LWSDbHruhRiLMRTnkMfjW4tYWZbzgzuhiV1Pcg5TLLWVYAOrlz3aHe+SpvSYQGMzHczidd
 iJBKqba6ti8l829dEJOFokvN5MMKCP77rAU4QOUNnM/TuCvDIQWF+LKt/iMdb4fq0ypLcfUVvB9
 jjyORQmfmt5imjVTYFdP1RHtKu0YyPDUsMOuNofqk+WYNyoRJ1lxcFpWGhMzkvISVY0a/aRu6Vv
 8s9evny/dsrs9Ps3+5Zj4/jPQVsIrpJNh0/Agne95EcazGKuFSnjL/2MLZgjPnHI2lHH0ZXP2hX
 Ph0zUtgt9uipISnDGD0EDGzl+zA9bVTu45WE4VwwAyVkw9SLLzdyySvBLji+Q5F8plBrCKExAd0
 PMusEy44/Pzf2027FNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200109



On 8/20/26 7:17 PM, Mukesh Kumar Chaurasiya (IBM) wrote:
> When __replay_soft_interrupts() replays a pending interrupt (e.g.
> PACA_IRQ_DEC → timer_interrupt), it calls the handler directly with a
> synthetic pt_regs. The DEFINE_INTERRUPT_HANDLER_ASYNC wrapper around
> each handler calls arch_interrupt_async_exit_prepare() on the way out,
> which calls arch_interrupt_exit_prepare() → local_irq_disable() →
> arch_local_irq_disable(), which does:
> 
>      irq_soft_mask_set(IRQS_DISABLED)   /* 0x1 */
> 
> This unconditionally overwrites irq_soft_mask with IRQS_DISABLED (0x1),
> stripping the IRQS_PMI_DISABLED (0x2) bit. The result is that
> irq_soft_mask is 0x1 instead of IRQS_ALL_DISABLED (0x3) when the
> handler returns to __replay_soft_interrupts().
> 
> For a normally-taken interrupt this is harmless: the next interrupt
> always enters through arch_interrupt_enter_prepare() which
> unconditionally sets irq_soft_mask to IRQS_ALL_DISABLED.
> But during replay, next_interrupt() is called
> directly between replayed handlers without going back through
> arch_interrupt_enter_prepare(), so the stripped bit is never restored.
> next_interrupt() then fires a WARNING:
> 
>      WARNING: arch/powerpc/kernel/irq_64.c:75
>      WARN_ON(irq_soft_mask_return() != IRQS_ALL_DISABLED)
> 
> This was introduced by commit bee25f97ad24 ("powerpc: Enable
> GENERIC_ENTRY feature"). Before that commit, the old
> interrupt_async_exit_prepare() called irq_exit() followed by an empty
> interrupt_exit_prepare() stub and never touched irq_soft_mask at all,
> so the soft mask was left at IRQS_ALL_DISABLED throughout replay.
> 
> The root cause: arch_interrupt_exit_prepare() uses local_irq_disable()
> whose only job is to set the IRQS_DISABLED bit; it has no knowledge of
> IRQS_PMI_DISABLED. It is there to satisfy irqentry_exit()'s
> requirement that interrupts be disabled, but using the plain
> irq_soft_mask_set(IRQS_ALL_DISABLED) is the right primitive:
> 
>    - irq_soft_mask_set(IRQS_ALL_DISABLED): sets soft mask to 0x3
>      (both IRQS_DISABLED and IRQS_PMI_DISABLED). Touches only the soft
>      mask. MSR[EE] and PACA_IRQ_HARD_DIS are already correct because
>      hard interrupts were never re-enabled during replay
>      (PACA_IRQ_REPLAYING is in PACA_IRQ_MUST_HARD_MASK, which blocks
>      should_hard_irq_enable()).
> 
>    - local_irq_disable() / arch_local_irq_disable(): sets soft mask to
>      IRQS_DISABLED (0x1) only, silently dropping IRQS_PMI_DISABLED.
> 
>    - hard_irq_disable(): also issues __mtmsrd to clear MSR[EE] in
>      hardware and sets PACA_IRQ_HARD_DIS — redundant and wrong here
>      since both are already set.
> 
> Fix by replacing local_irq_disable() with irq_soft_mask_set(IRQS_ALL_DISABLED)
> in arch_interrupt_exit_prepare(), making the exit symmetric with the
> entry path in arch_interrupt_enter_prepare() which always sets
> IRQS_ALL_DISABLED.
> 
> The warning was observed early in boot on a POWER10 pseries guest
> during kmem_cache_init_late(), where a spinlock release triggers
> interrupt replay that processes a pending timer interrupt.
> 
> Debugger state confirming the bug:
>    Before timer_interrupt(&regs):
>      irq_soft_mask = 0x3 (IRQS_ALL_DISABLED)   correct
>      irq_happened  = 0x41 (HARD_DIS|REPLAYING)  correct
>    After timer_interrupt(&regs) returns:
>      irq_soft_mask = 0x1 (IRQS_DISABLED)        WRONG — PMI bit stripped
>      irq_happened  = 0x41                        unchanged
> 

Indeed. Thanks for the fix and good explanation.

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

> Fixes: 334f3f6d7a16 ("powerpc/entry: Disable interrupts before irqentry_exit")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/6f9bfb0f-b14c-468e-bb9f-c157d120d0dc@linux.ibm.com/
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
> Change log:
> V1 -> V2:
> 	- Instead of using hard_irq_disable use irq_soft_mask_set
> V1: https://lore.kernel.org/all/20260812152035.1661781-1-mkchauras@gmail.com
> 
>   arch/powerpc/include/asm/entry-common.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
> index c5adb5006361..2a153dca962c 100644
> --- a/arch/powerpc/include/asm/entry-common.h
> +++ b/arch/powerpc/include/asm/entry-common.h
> @@ -270,7 +270,7 @@ static inline void arch_interrupt_exit_prepare(struct pt_regs *regs)
>   	}
>   
>   	/* irqentry_exit expects to be called with interrupts disabled */
> -	local_irq_disable();
> +	irq_soft_mask_set(IRQS_ALL_DISABLED);
>   }
>   
>   static inline void arch_interrupt_async_enter_prepare(struct pt_regs *regs)


