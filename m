Return-Path: <linuxppc-dev+bounces-26353-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930ABC61DE4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 04:27:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYtBC38QTz2y2h;
	Tue, 01 Sep 2026 14:27:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788236851;
	cv=none; b=MnNhwEb2HxALsb2L7PvsQcbZ5gn5C+l0TLwMcAdcjhC//7VKbr7BOnFvc4BzBKcLC1jEdJ/Ii0s2qWpTtaiptSoXWILweDeND6tHq0sNo+Kzd4mJLAkP07FfdmwO8Y+d2MEZ1iDVhHv7v8NyicRi3FFSlH6iMtknbMl6MjUIYy7BfycThZlmHiB7ewqOutu0B3riH9HTUTq8NuEBcTIZzjmiLsBW9f/h7LgG3VCm7nDpd857L1kNx/lZbVdc/PqR0Fn1qZFgR17czq3KeoENxjbcIR8R6slMljt/Vx6hl9yLjO5fvJfABoLLRsiOfotp9pTojqLB2HYSHeRsC8WXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788236851; c=relaxed/relaxed;
	bh=OZAxivvOuDavpM+pDlUTth0GkE8XofHBHRjwBtbvteg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A95xjM547T9qzJmk4Ul9wcismZdeqNie2DuxtrQqz48tdu8Cggpm5pOQ4DxKpf3LePtZWkA0JOzww3oaeG4cNu02BF2Y51mVsqdiQVvGRxAqC5FEv3lXgTWP8hvOwYFKuHAqUFQ2e3aVbfPd7tDOXVcNwZxVcCDCUzkZX9BtqfRgyOaVrpHXs1UqDwwy21tjcPRzOMvAVbeeShVhdTHxBHJffPLQdM+aAd7vrLLE8CS42YRybsevjYerB0jS8jrNe4OervpnJACQdDdhJEzxKjN4+czluK1RcjyryfRMQVxX/GfGnSsyofsGOPhI5Fn1wRAYM+MHwxWEM7iPmW9jWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oVgXy/Lo; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oVgXy/Lo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYtBB2mG9z2y2c
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 14:27:29 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681123S53825746;
	Tue, 1 Sep 2026 04:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OZAxiv
	vOuDavpM+pDlUTth0GkE8XofHBHRjwBtbvteg=; b=oVgXy/LoNa1StyMRBrn/Cq
	ppxqZfAuQHm8qe63W6lvxgBjr9GVcQRu/0leEcF8S+wgijgCD89rHVEaMIoimXET
	6jqmaCvTeaIRVwc8sKhUHUskmdnnCl1EDBD6DNeLWXaFrluow6OtqDcu46izyPYQ
	95WvA6eOz/vKFXK5h/X7lN9I97TcuDYxiNtNZKwEKyds38IIzadXOtvZUlfUQsgd
	bqKbVAhNkntLQy84MJrvSrqvHfUKXSqXcg5q3AaZP4t3l187AbdB+HGKNCN/eWiZ
	2Jz5HZg3mICpyIjfxQQoRgJ0rBVbb1uFt8c/quiIwY9eQniFQ9d7lDuvRyWnQ3nw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhnpu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 04:27:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6814QPkc022434;
	Tue, 1 Sep 2026 04:27:23 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq9y18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 04:27:23 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6814RMj420841072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 04:27:22 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0406658231;
	Tue,  1 Sep 2026 04:27:22 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD5E358230;
	Tue,  1 Sep 2026 04:27:19 +0000 (GMT)
Received: from [9.123.9.83] (unknown [9.123.9.83])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Sep 2026 04:27:19 +0000 (GMT)
Message-ID: <bc5abcb4-605b-4bee-bc55-04b418d40c4c@linux.ibm.com>
Date: Tue, 1 Sep 2026 09:57:18 +0530
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
Subject: Re: [PATCH] powerpc: Do not restore KUAP in
 arch_exit_to_user_mode_prepare()
Content-Language: en-GB
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
References: <52fee44fd23acf8e1c024ace668728e626a783a8.1788101609.git.ritesh.list@gmail.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <52fee44fd23acf8e1c024ace668728e626a783a8.1788101609.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 5Ifye-rDAjU2ApEMbV6x_P0aFvsFeHOo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDAzMiBTYWx0ZWRfXwZIa+/3OZ/o6
 hfa3tTHB4xtopDketYYmg5Xn9pJ6M8aX7dpTYtqq0uNJ9yTeGYBqXWC8N//hajJZKsBNbX0r8ut
 bdSIaHTGjGSPYZ0/tZ0E0sOYJpxmo1XaysMly7wXRq1+wceij08VsvCgk/ROmSN8aItaSoicrqa
 VssDgdq7YCMLZH5RrID7b9HzKsX26/+fZf+AH9otnhYg8/zd4WDq0i4n3enASMZSrgQtxjMjDse
 0izfSwx+ThH5AHwnTKH/e8v+gSWZCu90Vx3ESVb+rhXwGytd2ai5rb2d72QU5F8hLEDrVzQSVnH
 L+/rNowm/eILfzwSVeMxCjjpW/3364iHiBkOAEqGQY/a3Kkk09876+W6x5V3HUvmAmi8Fep3mv1
 EjPOLltCqx+zWuLnXzKBmhYDfd/xEtgFeY/nWV80lTATolArcxu4TNl31wbZ4/Q25X3IUOtnK5m
 FCCvKfJwRQ4ZvjMHSmw==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a96542c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=rkLeZVjyAmw9mDmvHroA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDAzMiBTYWx0ZWRfXyrDx93W5TWAj
 dEA67/k6SsX/K1KKA9r9o6t4EBHw5dlhFUi1Snt/YVDfwt5s/dtDIV0fv3JdCeBva4qmJZr9cKb
 TWIEqFhRy5ZKMt4ceGVnjVoS8DBW2/g=
X-Proofpoint-ORIG-GUID: vsVihpUJozlr9Zej8fKs5SEP2okksaYP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_01,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010032


On 30/08/26 8:24 pm, Ritesh Harjani (IBM) wrote:
> KUAP means kernel cannot touch user memory unless it explicitly is
> enabled. In the kernel it should stay AMR_KUAP_BLOCKED. While returning
> to userspace just before RFI, kernel should restore the user AMR value
> back.
>
> Looks like GENERIC_ENTRY might be treating arch_exit_to_user_mode_prepare()
> as the last architecture step before returning to userspace.
> commit bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> therefore called kuap_user_restore() from that hook. But on PowerPC that
> is too early. After irqentry_exit() / syscall_exit_to_user_mode() we
> still run platform specific exit routines.
>
> e.g. code snippets showing both exception handling and system call
> handling as the callers of function arch_exit_to_user_mode_prepare()
> which does kuap_user_restore(). The below path shows that calling
> kuap_user_restore() is too early when called from
> arch_exit_to_user_mode_prepare().
>
> Exception handling in exceptions-64s.S
> =======================================
>
> bl	CFUNC(do_page_fault)
> 	  ..DEFINE_INTERRUPT_HANDLER_ASYNC(do_page_fault)
> 	      arch_interrupt_async_enter_prepare(regs);
> 	      state = irqentry_enter(regs);
> 	      instrumentation_begin();
> 	      irq_enter_rcu();
> 	      handler(regs);
> 	      nap_adjust_return(regs);
> 	      irq_exit_rcu();
> 	      instrumentation_end();
> 	      arch_interrupt_async_exit_prepare(regs);
> 	      irqentry_exit(regs, state); 		   <<< too early
> 	        irqentry_exit_to_user_mode()
> 		  __exit_to_user_mode_prepare(regs, EXIT_TO_USER_MODE_WORK_IRQ);
> 		    arch_exit_to_user_mode_prepare(regs, ti_work);  <<< too early
> b	interrupt_return_srr
> 		.. bl	CFUNC(interrupt_exit_user_prepare) <<< already calls kuap_user_restore
>
> prep_irq_for_enabled_exit() retry can run kernel code with IRQs on. So
> only when that routine is fully finished is when the user KUAP should be
> fully restored which interrupt_exit_user_prepare() already takes care of
> before returning.
>
> Similarly for system call handling in interrupt_64.S
> ======================================================
>
> 	bl	CFUNC(system_call_exception)
>
> .Lsyscall_exit:
> 	addi	r4,r1,STACK_INT_FRAME_REGS
> 	li	r5,0 /* !scv */
> 	bl	CFUNC(syscall_exit_prepare)
> 		  .. kuap_assert_locked();
> 		     syscall_exit_to_user_mode(regs); <<< too early
> 		       syscall_exit_to_user_mode_prepare(regs);  <<< too early
>   		     kuap_user_restore(regs);         <<< already calls
>
> syscall_exit_prepare(), which can enable IRQs, replay a pending
> interrupt, and only then rfi. Those functions already restore KUAP
> immediately before rfi.
>
> Note that if we restore the user AMR too early like in the current code
> as shown from the code snippets above, then we get the following warning
> when CONFIG_PPC_KUAP_DEBUG is enabled:
>    WARNING: arch/powerpc/include/asm/book3s/64/kup.h:293 at interrupt_exit_user_prepare+0x1a0/0x1c0
>    Hardware name: IBM pSeries (emulated by qemu) POWER10 (architected)
>    TRAP: 0700
>    LR: c00000000000d8d4 CTR: c0000000021fe500
>    MSR: <SF,EE,ME,IR,DR,RI,LE>  CR: 44000804  XER: 20040000
>    interrupt_exit_user_prepare+0x1a0/0x1c0
>    interrupt_return_srr_user+0x8/0x12c
>
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Fixes: 02565a782c1ee ("powerpc: Introduce syscall exit arch functions")
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---

Issue is fixed with this patch.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Before this Patch:


[    3.861094] ------------[ cut here ]------------
[    3.861105] WARNING: ./arch/powerpc/include/asm/book3s/64/kup.h:293 
at interrupt_exit_user_prepare+0x240/0x260, CPU#23: modprobe/348
[    3.861124] Modules linked in:
[    3.861133] CPU: 23 UID: 0 PID: 348 Comm: modprobe Not tainted 7.2.0+ 
#14 PREEMPTLAZY
[    3.861145] Hardware name: IBM,8375-42A POWER9 (architected) 0x4e0202 
0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
[    3.861154] NIP:  c00000000003a730 LR: c00000000003a53c CTR: 
000000000049f42c
[    3.861162] REGS: c0000000a7967b70 TRAP: 0700   Not tainted (7.2.0+)
[    3.861170] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE> CR: 
44000008  XER: 20040000
[    3.861197] CFAR: c00000000003a56c IRQMASK: 1
                GPR00: c00000000003a53c c0000000a7967e10 
c000000002b7a400 c0000000a7967fb8
                GPR04: 800000004000d033 0000000000000001 
c0000000000a7460 ffffffffffffffbf
                GPR08: 013ffffe00040038 fcffffffffffffff 
3cffffffffffffff 0000000000000000
                GPR12: c0000000a7967688 c000000017fe3700 
0000000000000000 0000000000000000
                GPR16: 0000000000000000 0000000000000000 
0000000000000000 0000000000000000
                GPR20: 0000000000000000 0000000000000000 
0000000000000000 0000000000000000
                GPR24: 0000000000000000 0000000000000000 
0000000000000000 0000000000000000
                GPR28: 0000000000000000 0000000000000000 
0000000000000000 c0000000a7967e80
[    3.861313] NIP [c00000000003a730] 
interrupt_exit_user_prepare+0x240/0x260
[    3.861325] LR [c00000000003a53c] interrupt_exit_user_prepare+0x4c/0x260
[    3.861336] Call Trace:
[    3.861340] [c0000000a7967e10] [c00000000003a53c] 
interrupt_exit_user_prepare+0x4c/0x260 (unreliable)
[    3.861356] [c0000000a7967e50] [c00000000000d8d4] 
interrupt_return_srr_user+0x8/0x12c
[    3.861370] ---- interrupt: 400 at 0x7fff8cf341c0
[    3.861379] NIP:  00007fff8cf341c0 LR: 0000000000000000 CTR: 
0000000000000000
[    3.861388] REGS: c0000000a7967e80 TRAP: 0400   Not tainted (7.2.0+)
[    3.861395] MSR:  800000004000d033 <SF,EE,PR,ME,IR,DR,RI,LE>  CR: 
00000000  XER: 00000000
[    3.861424] CFAR: c00000000000d7bc IRQMASK: 0
                GPR00: 0000000000000000 00007fffc7b04020 
0000000000000000 0000000000000000
                GPR04: 0000000000000000 0000000000000000 
0000000000000000 0000000000000000
                GPR08: 0000000000000000 0000000000000000 
0000000000000000 0000000000000000
                GPR12: 00007fff8cf341c0 0000000000000000 
0000000000000000 0000000000000000
                GPR16: 0000000000000000 0000000000000000 
0000000000000000 0000000000000000
                GPR20: 0000000000000000 0000000000000000 
0000000000000000 0000000000000000
                GPR24: 0000000000000000 0000000000000000 
0000000000000000 0000000000000000
                GPR28: 0000000000000000 0000000000000000 
0000000000000000 0000000000000000
[    3.861536] NIP [00007fff8cf341c0] 0x7fff8cf341c0
[    3.861543] LR [0000000000000000] 0x0
[    3.861550] ---- interrupt: 400
[    3.861555] Code: 7fbd0aa6 387f0178 488befad 60000000 e93f0178 
7c3d4800 4082febc 73de00ff 4182fef8 3ba00000 4bfffeb4 60000000 
<0fe00000> 4bfffe3c 60000000 60000000

[    3.861599] ---[ end trace 0000000000000000 ]---


Regards,

Venkat.

>   arch/powerpc/include/asm/entry-common.h | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
> index c5adb5006361..94083516df57 100644
> --- a/arch/powerpc/include/asm/entry-common.h
> +++ b/arch/powerpc/include/asm/entry-common.h
> @@ -515,8 +515,14 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>   #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>   	local_paca->tm_scratch = regs->msr;
>   #endif
> -	/* Restore user access locks last */
> -	kuap_user_restore(regs);
> +	/*
> +	 * Do not restore KUAP here. Generic entry might treat this as the last
> +	 * arch step before userspace but PowerPC still has kernel work after
> +	 * irqentry_exit()/syscall_exit_to_user_mode() i.e. in
> +	 * interrupt_exit_user_prepare() / syscall_exit_prepare() may enable
> +	 * IRQs and retry. Those functions restore KUAP immediately before rfi,
> +	 * which is where it should belong.
> +	 */
>   }
>
>   #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
> --
> 2.39.5
>

