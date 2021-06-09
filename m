Return-Path: <SRS0=MsOR=LD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7D0C47095
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 09:43:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83A79613AD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 09:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A79613AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G0Mc54F3Pz3byN
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jun 2021 19:43:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G0Mbh7532z3026
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jun 2021 19:42:53 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4G0MbZ04cdzB11B;
 Wed,  9 Jun 2021 11:42:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZeQI-HI4y8Zp; Wed,  9 Jun 2021 11:42:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4G0MbX2t47zBF5X;
 Wed,  9 Jun 2021 11:42:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 49A308B7D7;
 Wed,  9 Jun 2021 11:42:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 0i0ijwN2cyBI; Wed,  9 Jun 2021 11:42:48 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E65438B7C3;
 Wed,  9 Jun 2021 11:42:47 +0200 (CEST)
Subject: Re: [PATCH] powerpc/bpf: Use bctrl for making function calls
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, bpf@vger.kernel.org
References: <20210609090024.1446800-1-naveen.n.rao@linux.vnet.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <4c371bd1-1fcf-54c1-d0a2-836d40887893@csgroup.eu>
Date: Wed, 9 Jun 2021 11:42:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210609090024.1446800-1-naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 09/06/2021 à 11:00, Naveen N. Rao a écrit :
> blrl corrupts the link stack. Instead use bctrl when making function
> calls from BPF programs.

What's the link stack ? Is it the PPC64 branch predictor stack ?

> 
> Reported-by: Anton Blanchard <anton@ozlabs.org>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/ppc-opcode.h |  1 +
>   arch/powerpc/net/bpf_jit_comp32.c     |  4 ++--
>   arch/powerpc/net/bpf_jit_comp64.c     | 12 ++++++------
>   3 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
> index ac41776661e963..1abacb8417d562 100644
> --- a/arch/powerpc/include/asm/ppc-opcode.h
> +++ b/arch/powerpc/include/asm/ppc-opcode.h
> @@ -451,6 +451,7 @@
>   #define PPC_RAW_MTLR(r)			(0x7c0803a6 | ___PPC_RT(r))
>   #define PPC_RAW_MFLR(t)			(PPC_INST_MFLR | ___PPC_RT(t))
>   #define PPC_RAW_BCTR()			(PPC_INST_BCTR)
> +#define PPC_RAW_BCTRL()			(PPC_INST_BCTRL)

Can you use the numeric value instead of the PPC_INST_BCTRL, to avoid conflict with 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/4ca2bfdca2f47a293d05f61eb3c4e487ee170f1f.1621506159.git.christophe.leroy@csgroup.eu/

>   #define PPC_RAW_MTCTR(r)		(PPC_INST_MTCTR | ___PPC_RT(r))
>   #define PPC_RAW_ADDI(d, a, i)		(PPC_INST_ADDI | ___PPC_RT(d) | ___PPC_RA(a) | IMM_L(i))
>   #define PPC_RAW_LI(r, i)		PPC_RAW_ADDI(r, 0, i)
> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
> index bbb16099e8c7fa..40ab50bea61c02 100644
> --- a/arch/powerpc/net/bpf_jit_comp32.c
> +++ b/arch/powerpc/net/bpf_jit_comp32.c
> @@ -195,8 +195,8 @@ void bpf_jit_emit_func_call_rel(u32 *image, struct codegen_context *ctx, u64 fun
>   		/* Load function address into r0 */
>   		EMIT(PPC_RAW_LIS(__REG_R0, IMM_H(func)));
>   		EMIT(PPC_RAW_ORI(__REG_R0, __REG_R0, IMM_L(func)));
> -		EMIT(PPC_RAW_MTLR(__REG_R0));
> -		EMIT(PPC_RAW_BLRL());
> +		EMIT(PPC_RAW_MTCTR(__REG_R0));
> +		EMIT(PPC_RAW_BCTRL());
>   	}
>   }
>   
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 57a8c1153851a0..ae9a6532be6ad4 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -153,8 +153,8 @@ static void bpf_jit_emit_func_call_hlp(u32 *image, struct codegen_context *ctx,
>   	PPC_LI64(b2p[TMP_REG_2], func);
>   	/* Load actual entry point from function descriptor */
>   	PPC_BPF_LL(b2p[TMP_REG_1], b2p[TMP_REG_2], 0);
> -	/* ... and move it to LR */
> -	EMIT(PPC_RAW_MTLR(b2p[TMP_REG_1]));
> +	/* ... and move it to CTR */
> +	EMIT(PPC_RAW_MTCTR(b2p[TMP_REG_1]));
>   	/*
>   	 * Load TOC from function descriptor at offset 8.
>   	 * We can clobber r2 since we get called through a
> @@ -165,9 +165,9 @@ static void bpf_jit_emit_func_call_hlp(u32 *image, struct codegen_context *ctx,
>   #else
>   	/* We can clobber r12 */
>   	PPC_FUNC_ADDR(12, func);
> -	EMIT(PPC_RAW_MTLR(12));
> +	EMIT(PPC_RAW_MTCTR(12));
>   #endif
> -	EMIT(PPC_RAW_BLRL());
> +	EMIT(PPC_RAW_BCTRL());
>   }
>   
>   void bpf_jit_emit_func_call_rel(u32 *image, struct codegen_context *ctx, u64 func)
> @@ -202,8 +202,8 @@ void bpf_jit_emit_func_call_rel(u32 *image, struct codegen_context *ctx, u64 fun
>   	PPC_BPF_LL(12, 12, 0);
>   #endif
>   
> -	EMIT(PPC_RAW_MTLR(12));
> -	EMIT(PPC_RAW_BLRL());
> +	EMIT(PPC_RAW_MTCTR(12));
> +	EMIT(PPC_RAW_BCTRL());
>   }
>   
>   static void bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 out)
> 
> base-commit: 112f47a1484ddca610b70cbe4a99f0d0f1701daf
> 
