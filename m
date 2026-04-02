Return-Path: <linuxppc-dev+bounces-19217-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A931D39421
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 13:16:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmj723PPJz2xTh;
	Fri, 03 Apr 2026 00:16:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775135806;
	cv=none; b=bjjM6vgUGtYqv/dDVE7g3JyUbQaJoJjib+x0PUwMZyLP3DuJepwOp+Q1qRGHF2HIHVlb0oR1gkendg4e5tts3a1llb/oRoo3i0X1M02Hcoc9GWPcW4S3FJhh7qRimIDm0vGfReEdk33LqNWfNstPp7Ye3UPaKXhvPEfXd9+/FIZ9mupxPJyqjXCNYqSoqlA7X2IAA/CM/LYZWDGNBBe9jmSQytnbIW30yi0BmVTugNApwWn0cCLJC21gNXbmdR1M70eHyDi4enN4rwa5bRWQoYIh4S/wQsrib3VbbtJBNjooTnfG9tSpAEqwrji/821ZB54d9C8kz8LJQyydueznvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775135806; c=relaxed/relaxed;
	bh=JgbOLZtZTnGQzeKA0c8+hTYUkEa0VzumKm4KZiICbm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJr2epDQv0pP+MoTV88bg8exWdfjYlzTbimc4JiO4s+dMYVvN5l+5l7HHhFEqXLd6fwvwcUFrHBI9pWOwqTmlJ2WnyH5dSoI4wBXp1r1YCWaRDoCgCl0JLVJN3F2AjZtT+GQcwi4rEHRCex4sB5FcWbYmB4Bd5wBaf1kw6Vnp776ki18gHO/KF47LfqRnQZ/H8Lk5P9PVOwUZ9hCaKzWb1u/qwsBECx7YDCpT6OPImHORctYevF8DeYtJaiLpZfmhefaOpV2Z0joMl3PkBtb8f6fnVNnqu0qjDFkvyr445EM8W+CzYOYTL9lOfWsknlX7OHUKAyHM1tqEvlurcvbkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zfw5Zl8o; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zfw5Zl8o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmj713Cx4z2xS3
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 00:16:44 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6327PhDJ2679500;
	Thu, 2 Apr 2026 13:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JgbOLZ
	tZTnGQzeKA0c8+hTYUkEa0VzumKm4KZiICbm0=; b=Zfw5Zl8oQrDtWsAT9J+Cr/
	XQBADNPZ6wnndoLvRNp+yLGN0IfUjPac4H0kFXpewIjNLe9D3QCTzOnexSOXbIG5
	9sEh7sTi/BcT1sqj4WxeAJAUog2MPgmBFWAwu7g4SzlSiVtWgopLX1zNz1QdjH/E
	rKeeWuCGvKxFGTLWyNmvUu4/v+A90nqQl78f0MIy9lS2syrZmNtXjBhJmzgKVv49
	v7oEZExF0LMkjEc+MdbPY4Ei/HCyF7i/vee+esRMgDwxDLkA9j02Kx0U5/jS/6Gi
	hs6umJ6aYR4OpDsE54c79/YPreSNcBGO2ST1JvcNUfatLU9GEy0Eubwr7+zohaPA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q3cusf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 13:16:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632CIeBv008703;
	Thu, 2 Apr 2026 13:16:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v11swb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 13:16:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632DFwmS54723026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 13:15:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CB2F20073;
	Thu,  2 Apr 2026 13:15:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D5DE2006C;
	Thu,  2 Apr 2026 13:15:54 +0000 (GMT)
Received: from [9.124.211.83] (unknown [9.124.211.83])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 13:15:54 +0000 (GMT)
Message-ID: <d8c9c8dd-a544-4f5d-81c6-6041b5e806b1@linux.ibm.com>
Date: Thu, 2 Apr 2026 18:45:53 +0530
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
Subject: Re: [PATCH] powerpc64/bpf: Add powerpc64 JIT support for timed
 may_goto
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: sachinpb@linux.ibm.com, venkat88@linux.ibm.com, andrii@kernel.org,
        eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, chleroy@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, adubey@linux.ibm.com
References: <20260402054249.28801-1-skb99@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260402054249.28801-1-skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Zm4SQeeocor-YrMLtjR7rk28-DXVJAs8
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69ce6c13 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=sjD7eUQVPW1qbSBmM3gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8JgscKiQBGn9pYynFAGYJa9FQLJ7T3-4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDExNiBTYWx0ZWRfX9Hek6HY48SI5
 05g4BuM1uw0Vf8NcCs8jZpawdT+1K4+CiI38uBsLc8FNUyBbZfwKH26K5X/FDMAjDwDkJcFxlON
 2D86zoZX90MhkAu+QNldZD8nmO9H0uek0U7LPHBe3XZKpzd7Rtf0tw06Ei7KKdgj0Ui9kQI/S0T
 mosXXiuSTczfNQHNupEwMW2zzuj12t9yiCEd9RTKZsJJolEru+mFt7lK44b+QDcEUuENtZfo+gU
 oXSrQEOBTa7MOg6T/mBpkjE3OYegwsbz5jM2HyNgWThvgmPaCv6SrLe89Cz2ciSsS1H6f7VgmpD
 Sb4MT3uDoLZrNzkRFbWNJmb/6aQUEUWqcVWs0/9K8y+Vdxdbe7gmOL3B+Q+R00rb7bVag3tj4rG
 2Ijx8tjpEhRAs3Xjc02N39zkT5v7J6UPKa7C8BoTkYXGYxnd/WfP2rAtCNe2t4O7z9jKq8B3f4x
 YczbcbQ9bD/ZnIFLVAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020116



On 02/04/26 11:12 am, Saket Kumar Bhaskar wrote:
> When verifier sees a timed may_goto instruction, it emits a call to
> arch_bpf_timed_may_goto() with a stack offset in BPF_REG_AX
> (powerpc64 R12) and expects the refreshed count value to be returned
> in the same register. The verifier doesn't save or restore any registers
> before emitting this call.
> 
> arch_bpf_timed_may_goto() should act as a trampoline to call
> bpf_check_timed_may_goto() with powerpc64 ELF ABI calling convention.
> 
> To support this custom calling convention, implement
> arch_bpf_timed_may_goto() in assembly and make sure BPF caller saved
> registers are preserved, then call bpf_check_timed_may_goto with
> the powerpc64 ABI calling convention where first argument and return
> value both are in R3. Finally, move the result back into BPF_REG_AX(R12)
> before returning.
> 
> Also, introduce bpf_jit_emit_func_call() that computes the offset from
> kernel_toc_addr(), validates that the target and emits the ADDIS/ADDI
> sequence to load the function address before performing the indirect
> branch via MTCTR/BCTRL. The existing code in bpf_jit_emit_func_call_rel()
> is refactored to use this function.
> 
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> ---
>   arch/powerpc/net/Makefile             |  2 +-
>   arch/powerpc/net/bpf_jit_comp.c       |  5 +++
>   arch/powerpc/net/bpf_jit_comp64.c     | 59 ++++++++++++++++++++++-----
>   arch/powerpc/net/bpf_timed_may_goto.S | 57 ++++++++++++++++++++++++++
>   4 files changed, 111 insertions(+), 12 deletions(-)
>   create mode 100644 arch/powerpc/net/bpf_timed_may_goto.S
> 
> diff --git a/arch/powerpc/net/Makefile b/arch/powerpc/net/Makefile
> index 8e60af32e51e..204fc57ac56e 100644
> --- a/arch/powerpc/net/Makefile
> +++ b/arch/powerpc/net/Makefile
> @@ -2,4 +2,4 @@
>   #
>   # Arch-specific network modules
>   #
> -obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o bpf_jit_comp$(BITS).o
> +obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o bpf_jit_comp$(BITS).o bpf_timed_may_goto.o

As this is currently only enabled for CONFIG_PPC64, bpf_timed_may_goto.o
should be compiled conditionally for PPC64:

ifdef CONFIG_PPC64
obj-$(CONFIG_BPF_JIT) += bpf_timed_may_goto.o
endif

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 50103b3794fb..9b2b456b0765 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -537,6 +537,11 @@ bool bpf_jit_supports_subprog_tailcalls(void)
>   	return IS_ENABLED(CONFIG_PPC64);
>   }
>   
> +bool bpf_jit_supports_timed_may_goto(void)
> +{
> +	return IS_ENABLED(CONFIG_PPC64);
> +}
> +
>   bool bpf_jit_supports_kfunc_call(void)
>   {
>   	return IS_ENABLED(CONFIG_PPC64);
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index db364d9083e7..d39241444cd9 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -451,10 +451,28 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *, u64, u64, u64), void *cookie
>   	}
>   }
>   
> +static int bpf_jit_emit_func_call(u32 *image, struct codegen_context *ctx, u64 func_addr, int reg)
> +{

> +	long reladdr;
> +
> +	reladdr = func_addr - kernel_toc_addr();

long reladdr = func_addr - kernel_toc_addr();

> +	if (reladdr > 0x7FFFFFFF || reladdr < -(0x80000000L)) {
> +		pr_err("eBPF: address of %ps out of range of kernel_toc.\n", (void *)func_addr);
> +		return -ERANGE;
> +	}
> +
> +	EMIT(PPC_RAW_ADDIS(reg, _R2, PPC_HA(reladdr)));
> +	EMIT(PPC_RAW_ADDI(reg, reg, PPC_LO(reladdr)));
> +	EMIT(PPC_RAW_MTCTR(reg));
> +	EMIT(PPC_RAW_BCTRL());
> +
> +	return 0;
> +}
> +
>   int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
>   {
>   	unsigned long func_addr = func ? ppc_function_entry((void *)func) : 0;
> -	long reladdr;
> +	int ret;
>   
>   	/* bpf to bpf call, func is not known in the initial pass. Emit 5 nops as a placeholder */
>   	if (!func) {
> @@ -469,6 +487,7 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
>   	}
>   
>   #ifdef CONFIG_PPC_KERNEL_PCREL

> +	long reladdr;

While this works with modern C standard, I would be conservative and let
this be at the start of the function itself..

>   	reladdr = func_addr - local_paca->kernelbase;
>   
>   	/*
> @@ -507,16 +526,9 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
>   	EMIT(PPC_RAW_BCTRL());
>   #else
>   	if (core_kernel_text(func_addr)) {
> -		reladdr = func_addr - kernel_toc_addr();
> -		if (reladdr > 0x7FFFFFFF || reladdr < -(0x80000000L)) {
> -			pr_err("eBPF: address of %ps out of range of kernel_toc.\n", (void *)func);
> -			return -ERANGE;
> -		}
> -
> -		EMIT(PPC_RAW_ADDIS(_R12, _R2, PPC_HA(reladdr)));
> -		EMIT(PPC_RAW_ADDI(_R12, _R12, PPC_LO(reladdr)));
> -		EMIT(PPC_RAW_MTCTR(_R12));
> -		EMIT(PPC_RAW_BCTRL());
> +		ret = bpf_jit_emit_func_call(image, ctx, func_addr, _R12);
> +		if (ret)
> +			return ret;
>   	} else {
>   		if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V1)) {
>   			/* func points to the function descriptor */
> @@ -1755,6 +1767,31 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>   			if (ret < 0)
>   				return ret;
>   
> +			/*
> +			 * Call to arch_bpf_timed_may_goto() is emitted by the
> +			 * verifier and called with custom calling convention with
> +			 * first argument and return value in BPF_REG_AX (_R12).
> +			 *
> +			 * The generic helper or bpf function call emission path
> +			 * may use the same scratch register as BPF_REG_AX to
> +			 * materialize the target address. This would clobber AX
> +			 * and break timed may_goto semantics.
> +			 *
> +			 * Emit a minimal indirect call sequence here using a temp
> +			 * register and skip the normal post-call return-value move.
> +			 */
> +
> +			if (func_addr == (u64)arch_bpf_timed_may_goto) {

> +#ifdef CONFIG_PPC_KERNEL_PCREL
> +				PPC_LI_ADDR(tmp1_reg, func_addr);
> +				EMIT(PPC_RAW_MTCTR(tmp1_reg));
> +				EMIT(PPC_RAW_BCTRL());
> +#else
> +				bpf_jit_emit_func_call(image, ctx, func_addr, tmp1_reg);

The error check is missing for the above function..
Actually, how about:

	ret = 0;
	if (!IS_ENABLED(CONFIG_PPC_KERNEL_PCREL))
		ret = bpf_jit_emit_func_call(image, ctx, func_addr, tmp1_reg);

	if (ret || IS_ENABLED(CONFIG_PPC_KERNEL_PCREL)) {
		PPC_LI_ADDR(tmp1_reg, func_addr);
		EMIT(PPC_RAW_MTCTR(tmp1_reg));
		EMIT(PPC_RAW_BCTRL());
	}

> +#endif
> +				break;
> +			}
> +
>   			/* Take care of powerpc ABI requirements before kfunc call */
>   			if (insn[i].src_reg == BPF_PSEUDO_KFUNC_CALL) {
>   				if (prepare_for_kfunc_call(fp, image, ctx, &insn[i]))
> diff --git a/arch/powerpc/net/bpf_timed_may_goto.S b/arch/powerpc/net/bpf_timed_may_goto.S
> new file mode 100644
> index 000000000000..0b9afe3cfa1f
> --- /dev/null
> +++ b/arch/powerpc/net/bpf_timed_may_goto.S
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2025 IBM Corporation, Saket Kumar Bhaskar <skb99@linux.ibm.com> */
> +
> +#include <linux/linkage.h>
> +#include <asm/ppc_asm.h>
> +
> +/*
> + * arch_bpf_timed_may_goto() trampoline for powerpc64
> + *
> + * Custom BPF convention (verifier/JIT):
> + *	- input:  stack offset in BPF_REG_AX (r12)
> + *	- output: updated count in BPF_REG_AX (r12)
> + *
> + * Call bpf_check_timed_may_goto(ptr) with normal powerpc64 ABI:
> + * 	- r3 = ptr, return in r3
> + *
> + * Preserve BPF regs R0-R5 (mapping: r8, r3-r7).
> + */
> +
> +SYM_FUNC_START(arch_bpf_timed_may_goto)
> +	/* Prologue: save LR, allocate frame */
> +	mflr    r0
> +	std     r0, 16(r1)
> +	stdu    r1, -112(r1)
> +
> +	/* Save BPF registers R0 - R5 (r8, r3-r7) */

> +	std     r3, 24(r1)

May not matter much for this handwritten function but can we use
32 and on instead, as 32 is the MIN_FRAME_SIZE on ABIv2?

> +	std     r4, 32(r1)
> +	std     r5, 40(r1)
> +	std     r6, 48(r1)
> +	std     r7, 56(r1)
> +	std     r8, 64(r1)
> +
> +	/*
> +	 * r3 = BPF_REG_FP + BPF_REG_AX
> +	 * BPF_REG_FP is r31; BPF_REG_AX is r12 (stack offset in bytes).
> +	 */
> +	add     r3, r31, r12
> +	bl      bpf_check_timed_may_goto
> +
> +	/* Put return value back into AX */
> +	mr      r12, r3
> +
> +	/* Restore BPF registers R0 - R5 (r8, r3-r7) */
> +	ld      r3, 24(r1)
> +	ld      r4, 32(r1)
> +	ld      r5, 40(r1)
> +	ld      r6, 48(r1)
> +	ld      r7, 56(r1)
> +	ld      r8, 64(r1)
> +
> +	/* Epilogue: pop frame, restore LR, return */
> +	addi    r1, r1, 112
> +	ld      r0, 16(r1)
> +	mtlr    r0
> +	blr
> +SYM_FUNC_END(arch_bpf_timed_may_goto)

- Hari

