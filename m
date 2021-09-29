Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42064C433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Sep 2021 11:43:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7563761407
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Sep 2021 11:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7563761407
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HKDz96kMrz3bZj
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Sep 2021 21:43:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HKDyh1fK1z2yPK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Sep 2021 21:43:05 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4HKDyW5N65z9sYm;
 Wed, 29 Sep 2021 13:42:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6eT6i8EZsuyZ; Wed, 29 Sep 2021 13:42:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4HKDyW46Zzz9sYh;
 Wed, 29 Sep 2021 13:42:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 71C8F8B770;
 Wed, 29 Sep 2021 13:42:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id X3ysY2qXm5OT; Wed, 29 Sep 2021 13:42:59 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.103])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 40B8C8B763;
 Wed, 29 Sep 2021 13:42:59 +0200 (CEST)
Subject: Re: [PATCH v4 3/8] bpf powerpc: refactor JIT compiler code
To: Hari Bathini <hbathini@linux.ibm.com>, naveen.n.rao@linux.ibm.com,
 mpe@ellerman.id.au, ast@kernel.org, daniel@iogearbox.net
References: <20210929111855.50254-1-hbathini@linux.ibm.com>
 <20210929111855.50254-4-hbathini@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <0a0e6639-748c-5660-25af-98d82fd78c23@csgroup.eu>
Date: Wed, 29 Sep 2021 13:42:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210929111855.50254-4-hbathini@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
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
Cc: songliubraving@fb.com, netdev@vger.kernel.org, john.fastabend@gmail.com,
 andrii@kernel.org, kpsingh@kernel.org, paulus@samba.org, yhs@fb.com,
 bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kafai@fb.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 29/09/2021 à 13:18, Hari Bathini a écrit :
> Refactor powerpc LDX JITing code to simplify adding BPF_PROBE_MEM
> support.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
> 
> Changes in v4:
> * Dropped the default case in the switch statement for bpf size.
> * Dropped explicit fallthrough statement for empty switch cases.
> 
> 
>   arch/powerpc/net/bpf_jit_comp32.c | 33 ++++++++++++++++++-------------
>   arch/powerpc/net/bpf_jit_comp64.c | 31 +++++++++++++++++------------
>   2 files changed, 37 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
> index b60b59426a24..65a4d1ed97bf 100644
> --- a/arch/powerpc/net/bpf_jit_comp32.c
> +++ b/arch/powerpc/net/bpf_jit_comp32.c
> @@ -282,6 +282,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>   		u32 src_reg = bpf_to_ppc(ctx, insn[i].src_reg);
>   		u32 src_reg_h = src_reg - 1;
>   		u32 tmp_reg = bpf_to_ppc(ctx, TMP_REG);
> +		u32 size = BPF_SIZE(code);
>   		s16 off = insn[i].off;
>   		s32 imm = insn[i].imm;
>   		bool func_addr_fixed;
> @@ -810,23 +811,27 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>   		 * BPF_LDX
>   		 */
>   		case BPF_LDX | BPF_MEM | BPF_B: /* dst = *(u8 *)(ul) (src + off) */
> -			EMIT(PPC_RAW_LBZ(dst_reg, src_reg, off));
> -			if (!fp->aux->verifier_zext)
> -				EMIT(PPC_RAW_LI(dst_reg_h, 0));
> -			break;
>   		case BPF_LDX | BPF_MEM | BPF_H: /* dst = *(u16 *)(ul) (src + off) */
> -			EMIT(PPC_RAW_LHZ(dst_reg, src_reg, off));
> -			if (!fp->aux->verifier_zext)
> -				EMIT(PPC_RAW_LI(dst_reg_h, 0));
> -			break;
>   		case BPF_LDX | BPF_MEM | BPF_W: /* dst = *(u32 *)(ul) (src + off) */
> -			EMIT(PPC_RAW_LWZ(dst_reg, src_reg, off));
> -			if (!fp->aux->verifier_zext)
> -				EMIT(PPC_RAW_LI(dst_reg_h, 0));
> -			break;
>   		case BPF_LDX | BPF_MEM | BPF_DW: /* dst = *(u64 *)(ul) (src + off) */
> -			EMIT(PPC_RAW_LWZ(dst_reg_h, src_reg, off));
> -			EMIT(PPC_RAW_LWZ(dst_reg, src_reg, off + 4));
> +			switch (size) {
> +			case BPF_B:
> +				EMIT(PPC_RAW_LBZ(dst_reg, src_reg, off));
> +				break;
> +			case BPF_H:
> +				EMIT(PPC_RAW_LHZ(dst_reg, src_reg, off));
> +				break;
> +			case BPF_W:
> +				EMIT(PPC_RAW_LWZ(dst_reg, src_reg, off));
> +				break;
> +			case BPF_DW:
> +				EMIT(PPC_RAW_LWZ(dst_reg_h, src_reg, off));
> +				EMIT(PPC_RAW_LWZ(dst_reg, src_reg, off + 4));
> +				break;
> +			}
> +
> +			if (size != BPF_DW && !fp->aux->verifier_zext)
> +				EMIT(PPC_RAW_LI(dst_reg_h, 0));
>   			break;
>   
>   		/*
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 2a87da50d9a4..49e6e0b6e4d2 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -285,6 +285,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>   		u32 code = insn[i].code;
>   		u32 dst_reg = b2p[insn[i].dst_reg];
>   		u32 src_reg = b2p[insn[i].src_reg];
> +		u32 size = BPF_SIZE(code);
>   		s16 off = insn[i].off;
>   		s32 imm = insn[i].imm;
>   		bool func_addr_fixed;
> @@ -716,25 +717,29 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>   		 */
>   		/* dst = *(u8 *)(ul) (src + off) */
>   		case BPF_LDX | BPF_MEM | BPF_B:
> -			EMIT(PPC_RAW_LBZ(dst_reg, src_reg, off));
> -			if (insn_is_zext(&insn[i + 1]))
> -				addrs[++i] = ctx->idx * 4;
> -			break;
>   		/* dst = *(u16 *)(ul) (src + off) */
>   		case BPF_LDX | BPF_MEM | BPF_H:
> -			EMIT(PPC_RAW_LHZ(dst_reg, src_reg, off));
> -			if (insn_is_zext(&insn[i + 1]))
> -				addrs[++i] = ctx->idx * 4;
> -			break;
>   		/* dst = *(u32 *)(ul) (src + off) */
>   		case BPF_LDX | BPF_MEM | BPF_W:
> -			EMIT(PPC_RAW_LWZ(dst_reg, src_reg, off));
> -			if (insn_is_zext(&insn[i + 1]))
> -				addrs[++i] = ctx->idx * 4;
> -			break;
>   		/* dst = *(u64 *)(ul) (src + off) */
>   		case BPF_LDX | BPF_MEM | BPF_DW:
> -			PPC_BPF_LL(dst_reg, src_reg, off);
> +			switch (size) {
> +			case BPF_B:
> +				EMIT(PPC_RAW_LBZ(dst_reg, src_reg, off));
> +				break;
> +			case BPF_H:
> +				EMIT(PPC_RAW_LHZ(dst_reg, src_reg, off));
> +				break;
> +			case BPF_W:
> +				EMIT(PPC_RAW_LWZ(dst_reg, src_reg, off));
> +				break;
> +			case BPF_DW:
> +				PPC_BPF_LL(dst_reg, src_reg, off);
> +				break;
> +			}
> +
> +			if (size != BPF_DW && insn_is_zext(&insn[i + 1]))
> +				addrs[++i] = ctx->idx * 4;
>   			break;
>   
>   		/*
> 
