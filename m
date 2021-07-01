Return-Path: <SRS0=ZiU1=LZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D2FC11F64
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Jul 2021 16:36:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 807426100A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Jul 2021 16:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807426100A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GG3kw4jDyz3bVr
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Jul 2021 02:36:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GG3kV5wbfz308M
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jul 2021 02:36:15 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4GG3kN6JFCzBF3K;
 Thu,  1 Jul 2021 18:36:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HhcqewzrEylk; Thu,  1 Jul 2021 18:36:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4GG3kN5MskzBF2m;
 Thu,  1 Jul 2021 18:36:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id AF3538B97A;
 Thu,  1 Jul 2021 18:36:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Y6AlK0X0b0xD; Thu,  1 Jul 2021 18:36:12 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 30B258B96E;
 Thu,  1 Jul 2021 18:36:12 +0200 (CEST)
Subject: Re: [PATCH 2/2] powerpc/bpf: Reject atomic ops in ppc32 JIT
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <cover.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
 <426699046d89fe50f66ecf74bd31c01eda976ba5.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <f05821f6-816f-c9bf-faa9-015e11f25a46@csgroup.eu>
Date: Thu, 1 Jul 2021 18:36:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <426699046d89fe50f66ecf74bd31c01eda976ba5.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
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
Cc: Brendan Jackman <jackmanb@google.com>, Jiri Olsa <jolsa@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 01/07/2021 à 17:08, Naveen N. Rao a écrit :
> Commit 91c960b0056672 ("bpf: Rename BPF_XADD and prepare to encode other
> atomics in .imm") converted BPF_XADD to BPF_ATOMIC and updated all JIT
> implementations to reject JIT'ing instructions with an immediate value
> different from BPF_ADD. However, ppc32 BPF JIT was implemented around
> the same time and didn't include the same change. Update the ppc32 JIT
> accordingly.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Shouldn't it also include a Fixes tag and stable Cc as PPC32 eBPF was added in 5.13 ?

Fixes: 51c66ad849a7 ("powerpc/bpf: Implement extended BPF on PPC32")
Cc: stable@vger.kernel.org

> ---
>   arch/powerpc/net/bpf_jit_comp32.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
> index cbe5b399ed869d..91c990335a16c9 100644
> --- a/arch/powerpc/net/bpf_jit_comp32.c
> +++ b/arch/powerpc/net/bpf_jit_comp32.c
> @@ -773,9 +773,17 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>   			break;
>   
>   		/*
> -		 * BPF_STX XADD (atomic_add)
> +		 * BPF_STX ATOMIC (atomic ops)
>   		 */
> -		case BPF_STX | BPF_XADD | BPF_W: /* *(u32 *)(dst + off) += src */
> +		case BPF_STX | BPF_ATOMIC | BPF_W:
> +			if (imm != BPF_ADD) {
> +				pr_err_ratelimited(
> +					"eBPF filter atomic op code %02x (@%d) unsupported\n", code, i);
> +				return -ENOTSUPP;
> +			}
> +
> +			/* *(u32 *)(dst + off) += src */
> +
>   			bpf_set_seen_register(ctx, tmp_reg);
>   			/* Get offset into TMP_REG */
>   			EMIT(PPC_RAW_LI(tmp_reg, off));
> @@ -789,7 +797,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>   			PPC_BCC_SHORT(COND_NE, (ctx->idx - 3) * 4);
>   			break;
>   
> -		case BPF_STX | BPF_XADD | BPF_DW: /* *(u64 *)(dst + off) += src */
> +		case BPF_STX | BPF_ATOMIC | BPF_DW: /* *(u64 *)(dst + off) += src */
>   			return -EOPNOTSUPP;
>   
>   		/*
> 
