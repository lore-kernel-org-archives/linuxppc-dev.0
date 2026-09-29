Return-Path: <linuxppc-dev+bounces-28494-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BF8CA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 12:59:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvJCp44y2z30PJ;
	Tue, 29 Sep 2026 22:59:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790686758;
	cv=none; b=Bxquf7MJ5o2g0plBybBPygItIXJuA+Cb6qxjXoI7mykSgFKFQoFqWly9HjNZfaxm/mv4H4KCGnk+x9fWAZVNxrTcnlrbznI39AgqROdQG/pIzquNJbPlbfwl+fC/h2s/MjzOH56SZudc4o8BQV2j+kn6gDSoRHvDrcR/A5RoJ37J2VMdO0FQdi5oGgADO5q/uq3+1TmMTuzpE6nAbLSfTrgXr2UN8YisaA/jcUI7UqQr4s3w7nEBkkc13vNFqehfAt6upCNwLk0gDnekzJSHxFAJWlQd0EZkVSOD1lCj0N3zqzqPi715cWmRz0po6Mu4EqUfGR4PvlwXIIrLUCBX2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790686758; c=relaxed/relaxed;
	bh=woM0FRPu09e91YfETN6qXtfmByrG4dnUmwN1bxa0RV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LF13WOIr75i+h+MSqW0xkHnxXucb6diI8e2HbzsatI9zUXcTP63YHb/g97anc1i2bL+jHbc6Z80t6p3QGkfdDSuTEHx6lCKw352USBR9XA8EjO4UQvc4mXDbfrWw13Y1JpCW7l+nNyerbkDu2B3L8ZbuGWab1tf4aSA07ZJgcetBt3f6fRvjuTkTFLQ+ODQFzeEzkHJ1FUnUmTGS4hkauiRpuu5lk/53WTbj022vHJP145evx03e7NPcGz+jSE44e+jTlLMs9wHtlzI+ktLThe7YaPBQZD+vQEjxaVcl0TnbGCqEJq4gP5ju5FTwGrYccexxWavAgDX/Fb62holrXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KqqBZber; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KqqBZber;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvJCn5HPjz2yvy
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 22:59:17 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T7ZWP53344821;
	Tue, 29 Sep 2026 09:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=woM0FR
	Pu09e91YfETN6qXtfmByrG4dnUmwN1bxa0RV0=; b=KqqBZberyw5BmLSX89xayy
	Qp3x3VGYJL+PVlT1q/yRVKtnMmUFwvefWYJ9Dn6p2R36PTb9RDylbIQUgRs39qAw
	3wU97ZkXyid+WpxTTs9scNno32neL1tKUhgFbC0rxL8HLQLwkZiFQBT2L626uaFk
	OOVsaxdst8O+p/Qv9fHS2WMJvrlBikVOmAEUwuCyMrSeJXwEZkd2WLtDH1HBye9r
	JdzsG/ESlCDdJDahy8f56K0LkQhrfyeWnHYHGisd+gXASEOTBcHgfVL2Y/E2gzMW
	0DKKjsNMEArhyBjQ7kiOKSPAnw2azVpPO41BBNQrUOIiC1V4rb0oPSwd4PjSXWLA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fk5xwb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 09:44:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68T7WSNe1390142;
	Tue, 29 Sep 2026 09:44:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxu2y8wbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 09:44:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68T9iAO449873172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 09:44:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EBCF20043;
	Tue, 29 Sep 2026 09:44:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3623720040;
	Tue, 29 Sep 2026 09:44:07 +0000 (GMT)
Received: from [9.124.214.246] (unknown [9.124.214.246])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 09:44:06 +0000 (GMT)
Message-ID: <9a2c2187-f0ea-42e1-a9da-81088f5065ac@linux.ibm.com>
Date: Tue, 29 Sep 2026 15:14:06 +0530
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
Subject: Re: [PATCH] powerpc: fix NMI exit ordering: restore soft masks after
 irqentry_nmi_exit()
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        ritesh.list@gmail.com, mkchauras@linux.ibm.com, ruanjinjie@huawei.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <20260929071600.2963954-1-mkchauras@gmail.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260929071600.2963954-1-mkchauras@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 7Yebalj0KqJfyT3vJGuVxLJfpTpJzC8E
X-Proofpoint-GUID: hZzWI2TLVRV4zpaKhJNj3ptCksDBq62w
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzOCBTYWx0ZWRfX3Kwr5B1mK/MV
 MC0dtcf+2YVtOe52m9OzvDooZBaXuJ1NiQ8y0eFEkx2kfPLLyYgIIogIWYIdMNQ/sHA2JjIkh+5
 IcDvCeyjyvuRYKcoJSWwi9zlgyO67Ow=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abb886e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=IGkpBAwnVNaApzdPf5QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzOCBTYWx0ZWRfXzK9rNSlDZj9e
 I9VoCRiCOw5huMvXriCErMFHjUdd2NHlZevgaQhun+UTQSsSarda3I+CQpv3RhY4nwiivGs7WDd
 8aRYIDfIguY4cKjNuJ1A2G+58Z6jrAEtTOuBa7PTikZIMQ2W7XE1C9JteXb5L03bFxvz7Z/vgGv
 fQ+ukBiBgu+AJaLQ+70thcavgI8TDDKCT8YLi5QoShM7o579bDg99onRq5zS9GNPIW7B4TCBH0S
 f/2zTjIQg8G3A+72FfeO6xRvNkwDKABVY5LfWEbAV7ICNYzwkIWkNxXjyKnSPVDIjEyUSSoaHpd
 wad/cVjlmc+ElRN0vDnyHKmBO+mUJPYxlWOyMWqJt/w6O068KmQQmqEj2H/oMjnWc9SCz47IYlF
 TxJ8tRVS2wo69vVSh9RNQ5ATh9C4JvnsdbVosTOrAYKOfDYWgeYGr6U7q1aTwLHGWp10vA4Ik5g
 dESBdylyG+aLm1njtzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290038

Hi Mukesh.

On 9/29/26 12:46 PM, Mukesh Kumar Chaurasiya (IBM) wrote:
> When running with CONFIG_PPC_IRQ_SOFT_MASK_DEBUG=y and LOCKDEP=y, an
> Oops is triggered during NMI exit:
> 
>    [  202.258332] Oops: Exception in kernel mode, sig: 4 [#1]
>    NIP [000000000003e178] 0x3e178
>    LR  [c00000000003e174] arch_local_irq_restore+0x2a4/0x328
>    TRAP: 0700  MSR: 0000000000081000 <ME>
> 
> The faulting instruction at NIP is a 'trap' (0fe00000) inside the
> rfi_flush_fallback trampoline at a userspace-looking low address, reached
> after a bad rfid caused by an incorrect SRR0 value.
> 
> Root cause
> ----------
> DEFINE_INTERRUPT_HANDLER_NMI used to call arch_interrupt_nmi_exit_prepare()
> *before* irqentry_nmi_exit(), giving this sequence:
> 
>    arch_interrupt_nmi_enter_prepare()   // saves irq_soft_mask, irq_happened
>    irqentry_nmi_enter()                 // __nmi_enter() -> nmi_count++, in_nmi()=true
>    ____func(regs)                       // NMI handler body
>    arch_interrupt_nmi_exit_prepare()    // RESTORES irq_soft_mask=0 (IRQS_ENABLED)
>                                         // RESTORES irq_happened with pending bits
>    irqentry_nmi_exit()                  // instrumentation block runs here...
>      trace_hardirqs_on_prepare()        //   ...with in_nmi()==true still
>      lockdep_hardirqs_on_prepare()      //   ...and irq_soft_mask already restored to 0
>        -> arch_local_irq_restore(0)     // mask=0 -> enable path entered
>             WARN_ON_ONCE(in_nmi())      // FIRES: __nmi_exit() hasn't run yet
>      __nmi_exit()                       // nmi_count-- (too late)
> 
> arch_interrupt_nmi_exit_prepare() restores irq_soft_mask to whatever
> the interrupted thread had (IRQS_ENABLED / 0) and restores irq_happened
> with any pending deferred-interrupt bits that were present when the NMI
> fired.  This is correct and necessary before rfid back to the interrupted
> context, but it must not happen until irqentry_nmi_exit() has fully
> completed.
> 
> With irq_soft_mask=0 and pending bits in irq_happened, the
> trace_hardirqs_on_prepare() call inside irqentry_nmi_exit()'s
> instrumentation block reaches lockdep_hardirqs_on_prepare() which
> calls __trace_hardirqs_on_caller(), which eventually calls
> arch_local_irq_restore(0) (the IRQS_ENABLED / enable path).
> 
> arch_local_irq_restore() with mask=0 hits the CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
> guards at irq_64.c:217:
> 
>    WARN_ON_ONCE(in_nmi());   // TRUE: __nmi_exit() not yet called
> 
> The WARN_ON_ONCE fires a 'trap' instruction (tw 31,0,0 / 0fe00000) in
> kernel mode with MSR_PR=0, MSR_IR=0 (real-mode).  The program check
> handler (TRAP 0700) takes the sig:4 (SIGILL) path via do_program_check()
> and calls die(), producing the Oops.
> 
> The RESTART_TABLE mechanism in arch_local_irq_restore then causes the
> bad rfid that lands at the userspace-looking address visible in the NIP.
> 
> The bug is invisible with LOCKDEP=n because trace_hardirqs_on_prepare()
> is a no-op when CONFIG_TRACE_IRQFLAGS is not set (TRACE_IRQFLAGS is
> selected by PROVE_LOCKING which selects LOCKDEP).
> 
> Fix
> ---
> Move arch_interrupt_nmi_exit_prepare() to after the irqentry_nmi_exit()
> block, so that:
> 
>    irqentry_nmi_exit()                 // __nmi_exit() -> nmi_count--, in_nmi()=false
>    arch_interrupt_nmi_exit_prepare()   // now safe to restore soft mask state
> 
> The instrumentation inside irqentry_nmi_exit() now executes while
> in_nmi() is still true (nmi_count not yet decremented), but
> irq_soft_mask is still IRQS_ALL_DISABLED (NMI-entry value), so
> arch_local_irq_restore() is never called with mask=0 from that path.
> After __nmi_exit() returns, arch_interrupt_nmi_exit_prepare() restores
> the pre-NMI soft mask and irq_happened, which is the correct state for
> the rfid back to the interrupted context.
> 
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/d4cccba9-ce5c-424b-864c-2248fb0d99e6@linux.ibm.com/
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
>   arch/powerpc/include/asm/interrupt.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
> index 1b45a49e9bed..56f855c6f07e 100644
> --- a/arch/powerpc/include/asm/interrupt.h
> +++ b/arch/powerpc/include/asm/interrupt.h
> @@ -301,7 +301,6 @@ interrupt_handler long func(struct pt_regs *regs)			\
>   		state = irqentry_nmi_enter(regs);			\
>   	}								\
>   	ret = ____##func (regs);					\
> -	arch_interrupt_nmi_exit_prepare(regs, &nmi_state);		\
>   	if (mfmsr() & MSR_DR) {						\
>   		/* nmi_exit if relocations are on */			\
>   		irqentry_nmi_exit(regs, state);				\
> @@ -317,6 +316,7 @@ interrupt_handler long func(struct pt_regs *regs)			\
>   	} else {							\
>   		irqentry_nmi_exit(regs, state);				\
>   	}								\
> +	arch_interrupt_nmi_exit_prepare(regs, &nmi_state);		\
>   									\
>   	return ret;							\
>   }									\

Thanks for the fix.

Ordering also seems right now visually and it reflects similar to code previous
to generic entry.

arch_interrupt_nmi_enter_prepare
irqentry_nmi_enter
irqentry_nmi_exit
arch_interrupt_nmi_exit_prepare

So,
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

