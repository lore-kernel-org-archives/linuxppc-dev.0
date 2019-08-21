Return-Path: <SRS0=9oUV=WR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1FDC3A59E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Aug 2019 10:28:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD46022DD3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Aug 2019 10:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD46022DD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46D3mD0QCxzDqv3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Aug 2019 20:28:44 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46D3hf1GT5zDr5k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2019 20:25:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46D3hP6b02z9sN4;
 Wed, 21 Aug 2019 20:25:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Jiong Wang <jiong.wang@netronome.com>
Subject: Regression fix for bpf in v5.3 (was Re: [RFC PATCH] bpf: handle
 32-bit zext during constant blinding)
In-Reply-To: <20190813171018.28221-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20190813171018.28221-1-naveen.n.rao@linux.vnet.ibm.com>
Date: Wed, 21 Aug 2019 20:25:17 +1000
Message-ID: <87d0gy6cj6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> Since BPF constant blinding is performed after the verifier pass, there
> are certain ALU32 instructions inserted which don't have a corresponding
> zext instruction inserted after. This is causing a kernel oops on
> powerpc and can be reproduced by running 'test_cgroup_storage' with
> bpf_jit_harden=2.
>
> Fix this by emitting BPF_ZEXT during constant blinding if
> prog->aux->verifier_zext is set.
>
> Fixes: a4b1d3c1ddf6cb ("bpf: verifier: insert zero extension according to analysis result")
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> This approach (the location where zext is being introduced below, in 
> particular) works for powerpc, but I am not entirely sure if this is 
> sufficient for other architectures as well. This is broken on v5.3-rc4.

Any comment on this?

This is a regression in v5.3, which results in a kernel crash, it would
be nice to get it fixed before the release please?

cheers

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 8191a7db2777..d84146e6fd9e 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -890,7 +890,8 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
>  
>  static int bpf_jit_blind_insn(const struct bpf_insn *from,
>  			      const struct bpf_insn *aux,
> -			      struct bpf_insn *to_buff)
> +			      struct bpf_insn *to_buff,
> +			      bool emit_zext)
>  {
>  	struct bpf_insn *to = to_buff;
>  	u32 imm_rnd = get_random_int();
> @@ -939,6 +940,8 @@ static int bpf_jit_blind_insn(const struct bpf_insn *from,
>  		*to++ = BPF_ALU32_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ from->imm);
>  		*to++ = BPF_ALU32_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
>  		*to++ = BPF_ALU32_REG(from->code, from->dst_reg, BPF_REG_AX);
> +		if (emit_zext)
> +			*to++ = BPF_ZEXT_REG(from->dst_reg);
>  		break;
>  
>  	case BPF_ALU64 | BPF_ADD | BPF_K:
> @@ -992,6 +995,10 @@ static int bpf_jit_blind_insn(const struct bpf_insn *from,
>  			off -= 2;
>  		*to++ = BPF_ALU32_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ from->imm);
>  		*to++ = BPF_ALU32_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
> +		if (emit_zext) {
> +			*to++ = BPF_ZEXT_REG(BPF_REG_AX);
> +			off--;
> +		}
>  		*to++ = BPF_JMP32_REG(from->code, from->dst_reg, BPF_REG_AX,
>  				      off);
>  		break;
> @@ -1005,6 +1012,8 @@ static int bpf_jit_blind_insn(const struct bpf_insn *from,
>  	case 0: /* Part 2 of BPF_LD | BPF_IMM | BPF_DW. */
>  		*to++ = BPF_ALU32_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ aux[0].imm);
>  		*to++ = BPF_ALU32_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
> +		if (emit_zext)
> +			*to++ = BPF_ZEXT_REG(BPF_REG_AX);
>  		*to++ = BPF_ALU64_REG(BPF_OR,  aux[0].dst_reg, BPF_REG_AX);
>  		break;
>  
> @@ -1088,7 +1097,8 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
>  		    insn[1].code == 0)
>  			memcpy(aux, insn, sizeof(aux));
>  
> -		rewritten = bpf_jit_blind_insn(insn, aux, insn_buff);
> +		rewritten = bpf_jit_blind_insn(insn, aux, insn_buff,
> +						clone->aux->verifier_zext);
>  		if (!rewritten)
>  			continue;
>  
> -- 
> 2.22.0
