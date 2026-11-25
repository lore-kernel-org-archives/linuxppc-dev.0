Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC4F606A326
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 12:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Snd4Rqz3
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZKDc449zz2xjN;
	Wed, 25 Nov 2026 23:46:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795610784;
	cv=none; b=jdDnynuZP7v1p0vyOnJN4Rq4s13cHrc57hkUPZNNbL/eOcIRBSxM34Z2lgz3Z0rrT3/KXQWa822YpR4yGazJmg7MaRdcFOTN3llLe92gizXHBnou4TPKwzuq1v3oyD3AaiMXIje0aFZYZE7ev0dyU+66R+ClCKXIwK6mUfSuUsPzDDGNKdQ/yBC5CEcMeuzbDp8f6EFkf14LWMPNlE9ix/IhTEAvwef1whjjkJvoYbRlsVizJ+hwRUGzrvO9UPAxoZqwaz6b/ieVMEmEtw42/Ut2WzGZtnSSvuyfKWAnKEB1v/odtSI4XaEx+yEB+oC8a64My/sjDpT3nqJcW8T0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795610784; c=relaxed/relaxed;
	bh=B+v4apzcNlAQxEg0owaP2Ia+jHgbOJoA6fcAO1puWEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxNNDWZBFdCeGuipVB4P7xkPP64DYlS2EjMUNADb43rhcWfr8PyJ6VeEClQpg8Bz+JBmAbd7JbuW4JkyZ+YmZsWYgY+3KKGdCIA09VnW+pkeTYLiFtsvN2NrqcPmb1NQQq/YhTVRXVPLMfhWvNkbdhRDkS/Rkok5KQZy4LhszqkRvCRVkIbzRrS+mpZIhKYw2U/cOpmuGFCVgMuqIi/b1FBbJJBWeidBdIRgvwdZtLPKXIq46qC5C8AeOXSiBkcjwwMJhwVmtSwSzWXFwrcdVwB0bgjagEapJUqd6gIKfZugI51tAsAz8bHzo/WlYD5eyvwXbwunKWr0SV5MUvDMQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Snd4Rqz3; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Snd4Rqz3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZKDb1zWMz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 23:46:22 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APA4aEf973327;
	Wed, 25 Nov 2026 12:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=B+v4ap
	zcNlAQxEg0owaP2Ia+jHgbOJoA6fcAO1puWEU=; b=Snd4Rqz3o97jCpC3pUU8rF
	oDufqRiO/il+rxBOvh+q6rj6/1xxcAWj2ZBcwzdwTihpxxxatEHhreziChtO4PL+
	K6Zey5WpBL0v4L6AYga3O51R4oxYL9BAgmA8xwtvIqAJFZzUEuM1YaUb14iOIzGp
	lUK6n5ys6RkGrOJixmSGDJqvQhugAEKzHFcbW5vaM2WILJVPtzfK9ieJ0aCXxBYz
	tiBbLH0CWt1l3c3/ZeJsWfa4TwyXMdphBMQf6duh43FnmH0yt9yUIxK7OG0+cjKe
	dKom6jOZYoYz95yENo/IfRog/FUCwn77lhPHvjMyUQ1v2llIR3kFpAAp0MXVDniA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gvc22s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 12:45:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9ns0B630576;
	Wed, 25 Nov 2026 12:45:43 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5dcuucya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 12:45:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6APCjgpq26280454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 12:45:42 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48DA25806B;
	Wed, 25 Nov 2026 12:45:42 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E61D58055;
	Wed, 25 Nov 2026 12:45:38 +0000 (GMT)
Received: from [9.61.253.214] (unknown [9.61.253.214])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Nov 2026 12:45:37 +0000 (GMT)
Message-ID: <1b75e490-78c7-48a2-b59d-9eec953a0335@linux.ibm.com>
Date: Wed, 25 Nov 2026 18:15:36 +0530
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
Subject: Re: [PATCHv4 1/4] powerpc/64: Leave lockdep hardirq context around
 replayed interrupts
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, linux-kernel@vger.kernel.org,
        chleroy@kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Shrikanth Hegde
 <sshegde@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <cover.1795603946.git.ritesh.list@gmail.com>
 <6a02babe73f316616cf829af3ddbbfc61fb4066a.1795603946.git.ritesh.list@gmail.com>
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <6a02babe73f316616cf829af3ddbbfc61fb4066a.1795603946.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b06d878 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=CaKusWZ8ccimFSZQ_D8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1MCBTYWx0ZWRfX/f5/ULfexoyL
 W1feTj6VVnXTt287GZ6DxZ8k6YwxtIE+mT7xa+c7NTVmnIqMiiL0Wh3+qrXq+uCsB5F4uvSXEgU
 65QBnf8BRDm6c6yvRRu9rrazpgoUwNA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1MCBTYWx0ZWRfX83aQY6DVfMwH
 1TgdmzOePx+N3YMjs9I3dObVK0co0X/P/lipoadH6BsYVf4au2F1dRSU9zEOId8hj24z+vgybbR
 Z9Sqic/U7+/SV6gXpPzpngfLVneeQTi4zGnNzzWliVhQ5zJsdQIxEixWSDmgIY2vIFNhwVWhWXe
 vKS+SaNWFj+44ZUqWFfmfBkPgxuF64f28NkFzlBBttltABqAzGtFOZnWJLR6VSR6xd83nkFQyfd
 guTeEXF98ZL78Kyrk6GjVE8CDx1mP9q/t4hLr2Zwq+kzDortK6VBQmPha0Qn41OjBnMKgFnYytL
 36Q2Y7LNuD+W4cK9pr3WOcWMbhuBFN8SRa9V6tz/KpRJCFXfBFBbOjryx48zab6tbiL4oXapy4f
 9NZt1bmHH/9wZK4k42/m7Bka8ZWEEDgDCVGFbhnzmXzyboUnbMp31bqvAKImKgdDt2CKYSxlNTn
 l77UXsaxnkvK2XxJsqw==
X-Proofpoint-ORIG-GUID: GY1ii9oVf1qj9I8c9iSR6Kl2XwwNRlZv
X-Proofpoint-GUID: D8Q4JohSEuhGF02ODzWmQaB76gD32D_C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250050
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 25/11/26 4:56 pm, Ritesh Harjani (IBM) wrote:
> With PROVE_LOCKING, boot warns once and lockdep turns itself off:
>    DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
>    WARNING: kernel/locking/lockdep.c:4448 at lockdep_hardirqs_on_prepare+0x22c/0x2d4, CPU#0: swapper/0/0
>    CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.4.0-rc2-00027-g074831f06e18-dirty #123 PREEMPT
>    NIP:  c0000000002b2f2c LR: c0000000002b2f28 CTR: c000000002426f90
>    REGS: c000000004f075c0 TRAP: 0700   Not tainted  (7.4.0-rc2-00027-g074831f06e18-dirty)
>    MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 48022221  XER: 20040000
>    NIP [c0000000002b2f2c] lockdep_hardirqs_on_prepare+0x22c/0x2d4
>    LR [c0000000002b2f28] lockdep_hardirqs_on_prepare+0x228/0x2d4
>    Call Trace:
>      lockdep_hardirqs_on_prepare+0x228/0x2d4 (unreliable)
>      trace_hardirqs_on+0x98/0x11c
>      irqentry_exit+0x64c/0x1064
>      timer_interrupt+0x274/0x6bc
>      __replay_soft_interrupts+0x158/0x380
>      arch_local_irq_restore+0x1cc/0x244
>      console_flush_one_record+0x438/0x654
>      console_unlock+0xb8/0x1e0
>      vprintk_emit+0x300/0x56c
>      vprintk+0x20/0x34
>      _printk+0x40/0x54
>      lockdep_init+0xdc/0x104
>
> The warning is triggered because trace_hardirqs_on() gets called while
> lockdep's hardirq_context still says we are handling an interrupt. To
> fix that, we need to ensure lockdep's hardirq_context and
> hardirqs_enabled state stays consistent with powerpc's soft-masked
> interrupt replay code and the generic entry/exit code.
>
> With the current change, this is how the new state machine looks like:
>                                         hardirq_context  hardirqs_enabled
>    arch_local_irq_restore()
>      trace_hardirqs_off()                     0             1 -> 0
>      irq_enter()                           0 -> 1           0          (softirqs held off)
>      __replay_soft_interrupts()
>        lockdep_hardirq_exit()              1 -> 0           0          patch: the loop is not a handler
>        timer_interrupt(&regs)
>          irq_enter_rcu()                   0 -> 1           0          handler starts
>          irq_exit_rcu()                    1 -> 0           0          handler done
>          irqentry_exit()
>            trace_hardirqs_on()                0             0 -> 1     legal: context is 0
>        next_interrupt()
>          trace_hardirqs_off()                 0             1 -> 0     still replaying: back to off
>        ...                                 same for each pending interrupt
>        lockdep_hardirq_enter()             0 -> 1           0          patch: restore for the caller
>      irq_exit()                            1 -> 0           0          softirqs may run now
>      trace_hardirqs_on()                      0             0 -> 1     IRQs really enabled
>
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Cc: stable@vger.kernel.org
> Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Closes: https://lore.kernel.org/linuxppc-dev/b44aefc5-e066-478b-8d34-50d2d0deab6b@linux.ibm.com/
> Closes: https://lore.kernel.org/linuxppc-dev/20260922150619.lwWqj1AO@linutronix.de/
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---


Applied this patch on top of latest mainline, and issue is fixed. Please 
add below tag.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Regards,

Venkat.

>   arch/powerpc/kernel/irq_64.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/kernel/irq_64.c b/arch/powerpc/kernel/irq_64.c
> index d5c48d1b0a31..e2f1e5b7a3a7 100644
> --- a/arch/powerpc/kernel/irq_64.c
> +++ b/arch/powerpc/kernel/irq_64.c
> @@ -76,13 +76,11 @@ static inline void next_interrupt(struct pt_regs *regs)
>   	}
>
>   	/*
> -	 * We are responding to the next interrupt, so interrupt-off
> -	 * latencies should be reset here.
> +	 * We are responding to the next interrupt. The irqentry_exit() of the
> +	 * replayed handler has traced hardirqs on, which also reset the
> +	 * interrupt-off latencies. Trace them off again.
>   	 */
> -	lockdep_hardirq_exit();
> -	trace_hardirqs_on();
>   	trace_hardirqs_off();
> -	lockdep_hardirq_enter();
>   }
>
>   static inline bool irq_happened_test_and_clear(u8 irq)
> @@ -116,6 +114,15 @@ static __no_kcsan void __replay_soft_interrupts(void)
>   	 */
>   	local_paca->irq_happened |= PACA_IRQ_REPLAYING;
>
> +	/*
> +	 * The irq_enter() of our callers is there to hold off softirqs. Each
> +	 * replayed handler enters and leaves the hardirq context itself and
> +	 * returns through irqentry_exit(), which again traces hardirqs on.
> +	 * Since lockdep only allows that outside of hardirq context, so leave
> +	 * it for the duration of the replay.
> +	 */
> +	lockdep_hardirq_exit();
> +
>   	ppc_save_regs(&regs);
>   	regs.softe = IRQS_ENABLED;
>   	regs.msr |= MSR_EE;
> @@ -168,6 +175,8 @@ static __no_kcsan void __replay_soft_interrupts(void)
>   		next_interrupt(&regs);
>   	}
>
> +	lockdep_hardirq_enter();
> +
>   	local_paca->irq_happened &= ~PACA_IRQ_REPLAYING;
>   }
>
> --
> 2.39.5
>
>

