Return-Path: <linuxppc-dev+bounces-26179-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E032DC61DBE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Aug 2026 05:55:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hX4Gq13L0z2xZV;
	Sat, 29 Aug 2026 15:55:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787982915;
	cv=none; b=Aw7Yf8XmEEcjthtJrmXIKZGMcS/MKU4KLPSX26lPCxdPgd9hxQ7FjNqepC38YAyJYSJxsq2gkzYBzoTJNfo9QPaHb172GYCIakVwiOOIiKEWx24yJs0uoKytNjJXF8xycxAsVOLpYZgmG3kINwcxBRhIzjDPTZItii9zwwhtRDthmJqmXPrZZ2P5qmABvvH5FPQvzb9y0rSFHIwbit1JXabYaoGn8ZFTlsCAcYTKumWBC9tg5bFzznSUM1wMxcJYl0uvGms+57i74EMWnIR4f0K+y9CqOxlC7iszvjfpU+g2wjekqQLGZ5pm7mWkYI71R1LMvyOLlCKL6Y8l4ldiyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787982915; c=relaxed/relaxed;
	bh=cEpBCe0kPrK+U8ztNpfo0syWfOkNqISYsryOikfROXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ikMN2sKYOY3jv9AtFV3pecPqMuOjCXdhhj1kUM6W4DXVSvNJ+KVMMAgV2O40bm8ZWLHys+F4wg8xms81c+xR7XrvuPcq2hs10qnhob7vS4CJA7DkG0ZXE0FHqs/XmdGihus6ERVwMMjXQ0KEOzStwuN0gfT/LOPs8oEmSlO/U+0MghJxLqgQNvl4PZQ8DdZZMFnBWHPvlXnrokhrJjrevXDzrhkVxlnytHZx7iifBo3z704wr1AyJwEX734oqfse/26yTb9miRBLJpo8obRcY+4c2LWYnEk+ub2ZLde4IhCymlNVquw9K9iCnxfvw6UUtdDn8SHs2LxpczkOWiwaSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YuunOaQV; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YuunOaQV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hX4Gn5WJJz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Aug 2026 15:55:12 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67T5WQbd2340996;
	Sat, 29 Aug 2026 05:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cEpBCe
	0kPrK+U8ztNpfo0syWfOkNqISYsryOikfROXQ=; b=YuunOaQVnWWWr8zYsi2VSv
	iHsbp82wcYxMHQnser3OV6DfFybKjZIV7ImcqqL7ciaRgQOtdXXn50+J//SzISsZ
	l+AFFO42fRpYEcF2XfaX+BGE9mA1kLexgDWql72HCyBtC7xCL/OPrVMYTXyccsrL
	oriwhNgKrVqLMwgqe+856JZVDbh6dww+bdGeDGXkuVzUrL3hmyQ8UmM3jGUuVYZQ
	tvu7H5S2FpZA8b2SWqkhCQqFJXSnF2cwFvdi/yXvWH2pmweVjnJm9iIP1yfO4YsB
	cxfyXt3JnO+FpoGggk2EgQmTKscgjTbTd7JSnud+/ql79mV+9P7SHsz0UIVZOIzw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3qrdys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Aug 2026 05:55:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67T5fN2M026345;
	Sat, 29 Aug 2026 05:55:04 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3kj54b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Aug 2026 05:55:04 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67T5t38C19661354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Aug 2026 05:55:03 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EB8058060;
	Sat, 29 Aug 2026 05:55:03 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C30B15803F;
	Sat, 29 Aug 2026 05:55:00 +0000 (GMT)
Received: from [9.61.246.88] (unknown [9.61.246.88])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 29 Aug 2026 05:55:00 +0000 (GMT)
Message-ID: <60e06858-43c3-4b92-9f0c-bdb73fe417f8@linux.ibm.com>
Date: Sat, 29 Aug 2026 11:24:59 +0530
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
Subject: Re: [PATCH] powerpc: Don't drop _TIF_RESTOREALL on syscall restart
Content-Language: en-GB
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
References: <10c86c909f870d90b3094f76b692b44ebe9caeac.1787976185.git.ritesh.list@gmail.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <10c86c909f870d90b3094f76b692b44ebe9caeac.1787976185.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a927439 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=k8QQlTQu1wMg4mGaVn4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDA0NSBTYWx0ZWRfX81+8elsxLs/w
 Esale/Fz75je18iwSNace1EihkXPLpUiJ2MogJhS3U62hV9OUji3GFS/Hg1VYdLYk4cTcA64poo
 MdpW9rYLfJMnAt5neEcNOQpBNE2ssr4AdIFDG4wOr1Wm/cajZNif38frAS0yNYx+HqZJjiVa722
 QDTptamehxJ1aCpNc/eUR6EMCIaDw/NEbQckOdyDGzd6euNBqpM7gVSp4lCFazOMjkh1K/zV379
 50jBaGAvLei988K1vHOQ9MZDnjQ19UBXW5yjXNypSGUndAgwbtsqq4GlH5bHYGnIdDH/TmqzVsL
 KqlgSGLSiv8Idvqt7s7WzkSgKVhE5af6c9KQ8WS/SlhYHWKIhIu0KTdD3PlntRm+CIgizCNO0N2
 1KM+xZkncogg8JjS95W/ZpTvTAqBMdkMN9tlU3UaYoqGck0CFux+ada4oIj/4JZKvVZ3WnWjwNS
 s+VQp8IbjWh4U8Mn7cw==
X-Proofpoint-GUID: EfWa7S74vMo5frl5kQ6QAjUIycC0zdTk
X-Proofpoint-ORIG-GUID: U_o01UN6E4MXvcsyz31OzxQRGaxD2-h6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDA0NSBTYWx0ZWRfX6j4DosSSZwik
 SjpC055UmzKcVeOY49uVLfxozHsaeFLs2MiQf2Ij70lHMJraPJ03FsqbEghStJgJrpTQfCevL3S
 BDhy0x/nEGQlNtXrJ7iVJbl2aDS6rj8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608290045


On 29/08/26 9:49 am, Ritesh Harjani (IBM) wrote:
> So the syscall return sequence is as follows:
> A syscall return to userspace is prepared and then a short asm sequence
> that actually does the RFI. Note that this asm range is restartable i.e.
> EE is still on, so an interrupt (e.g. decrementer or external interrupt)
> can hit while SRR/GPRs are being loaded. This is defined via:
>
> RESTART_TABLE(.Lsyscall_rst_start, .Lsyscall_rst_end, syscall_restart)
>
> This restart table then sends us to syscall_restart rather than resuming
> in the middle of the RFI. The same stub is also used if irq_happened
> already has a pending bit (soft-masked irq that has not been replayed
> yet (PowerPC special case of local_irq_disable())).
>
> Here is a bit of a flow of sequence of code to visualize:
>    syscall_exit_prepare
>        decide full-GPR restore (_TIF_RESTOREALL) for signal,
>        rt_sigreturn or syscall trace
>        save that in regs->exit_result and return it in r3
>             |
>             v
>    .Lsyscall_rst_start .. _end     EE still on
>        irq_happened set or interrupt in this range?
>             | no                         | yes
>             v                            v
>        cmpdi r3,0                  syscall_exit_restart
>        restore all / zero            replay irq, try exit again
>        volatiles; RFI                must return flags in r3
>                                      again for the same cmpdi
>
> Now r3 after prepare is the flags word, not the actual syscall return. A nested
> interrupt clobbers it, so the restart stub reloads RESULT into r3 and the
> C handler (syscall_exit_restart()) should put the flags back (because later asm
> checks whether r3 returned from C has _TIF_RESTOREALL set or not):
> 	cmpdi r3, 0
> 	bne	.Lsyscall_restore_regs
>
> Note that syscall_exit_restart() already ORs any new _TIF_RESTOREALL into
> exit_result, but then it only returns the new sample and not the full
> regs->exit_result.
>
> That sample could be often 0 even when restore-all is still required:
>
>    - rt_sigreturn / syscall trace set the bit in prepare's local
>      ret and in exit_result. They never set exit_flags, which is
>      what restart samples.
>
>    - a signal does set exit_flags but restart clears it. A
>      second pass through the stub then returns 0 while
>      exit_result still has the bit.
>
> The asm as mentioned earlier then treats r3==0 as the fast path and
> zeros r0/r4-r12. That means the userspace that needed the full register
> set could SIGSEGVs, (which could happen often in ld64.so.2 like while
> doing a parallel kernel build as reported by Venkat).
>
> So we should instead return the accumulated exit_result, like how we do
> in interrupt_exit_user_restart(). Note that prior to this commit
> 263e5159e00a ("powerpc: Fix exit_flags field placement in pt_regs for ptrace")
> we were returning regs->exit_result from syscall_exit_restart(), but
> this commit changed that behaviour.
>
> Fixes: 263e5159e00a ("powerpc: Fix exit_flags field placement in pt_regs for ptrace")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/75419f88-eab9-444b-bf97-28a9765819ad@linux.ibm.com/
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
This patch fixes reported issue.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.

> Sorry about the long commit msg. It took sometime for me to fully understand
> that complex path, so I thought I may as well document that properly.
>
>   arch/powerpc/kernel/interrupt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index 5b88bf72786c..55f9c0c9922a 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -175,7 +175,7 @@ notrace unsigned long syscall_exit_restart(unsigned long r3, struct pt_regs *reg
>   	current_thread_info()->exit_flags &= ~_TIF_RESTOREALL;
>   	regs->exit_result |= ret;
>
> -	return ret;
> +	return regs->exit_result;
>   }
>   #endif
>
> --
> 2.39.5
>
>

