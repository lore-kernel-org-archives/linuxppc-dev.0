Return-Path: <linuxppc-dev+bounces-22493-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C622CD98CC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 12:18:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbhWZ5DlJz3br5;
	Thu, 11 Jun 2026 22:18:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781180314;
	cv=none; b=OoG4VfKDmIbHNsgAs8oHdyEg0UiyHPEQeHFV3hR4qaOpw23aDPLyDhPl7LufRJc7JMC1sAdMjx2wbx96LpGWOVRVmZHxmSJZj9wNhWaakIfhpgfkf4Zqp/gGp6tmV2lhJVG2bgMW9zq0wW1zsILZFk6MUXsZTqAeHAhlQ2+etD/6Jp2bbwLcMEQ4YQe7zyh9qqS1+64bEyVAu8p2lbZuSBwgPl/Eroyc7rrq16pAsLxlQ2DUwSZthPwVTFSbWp92jdTOMG7mJ90E7/rgLC3WSCjAE5iAGxXgd9vZkYm4jXq8Xi6bOBY4hdhkoBF9hvic08csFWdDLf8gXiHR0L6t1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781180314; c=relaxed/relaxed;
	bh=141gI6qHfCWItY/nQuT4+axMxf2+yNx7YkH48PkWfHI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PAktD4EYIRycwHvInYi4P4b0+T/mH1ZBByG+6R8m6Ut6oqbhsxBa77CfxS9j+ONCVPkJoya8H1aCUTH54bLAAfespToNalFMOb/0hhGNDsrF56668EmA5PFA/TcDvOIxVESq07cU2gFYP5jU/QVRa5Kb3C2TXq7LnzQgtGpnu6CIOy6MHF/EFrHIliFwkODpQwEhtVMyAxDR2UHR6tAb9rZrzcdQaSEgRYXqA8ZmXRVBMxaTyobI00qvzpT6t55/1MwxMR6lcKSV5nozqHGLiu1nAvabFUp52pDbV/yHgDSuHdJek78JbyvsTvgxZn0sQLu5PnlodAPOBA61rvFeYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gh1HRszp; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gh1HRszp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbhWY3s5Nz3bpP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 22:18:33 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EDF394378A;
	Thu, 11 Jun 2026 12:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589251F00893;
	Thu, 11 Jun 2026 12:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781180310;
	bh=141gI6qHfCWItY/nQuT4+axMxf2+yNx7YkH48PkWfHI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Gh1HRszpNwjIkArB4/fvKDY80JjRE/yZmV8Zw9IsvjQtEfpK6XpxVa+BcSmPFU41y
	 D3YSpNYau8JPs/tKG3wmntbGokNlIhdV7eSXBGyDNgh6Rt3lZT2bgujywhHXM0E3Tc
	 iNjH3IKGjlD4s17PV41igtl02nqUWGkvgEVW8GKNwcIsu/bQ3l4WoAoS5lasEK6ICW
	 8BERJaO1tlfbPRSfRftEMfWIK1ft4FZKu2fex4WtertIEF76dvwKAgEC6K26poXLrV
	 s6L/vUHVutMLnniK8VdVEU6+KcYfEkccJbld8V0wiKRq4hj+TOCqEP1sO9cSgT4naU
	 Qnk7TEz2cGTwg==
Content-Type: multipart/mixed; boundary="===============2293734144057904883=="
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
Message-Id: <b3a9887383e78d4ab37879573df3b240c880d206529a6d23e3299e7f56a9df74@mail.kernel.org>
In-Reply-To: <20260611153826.31187-3-adubey@linux.ibm.com>
References: <20260611153826.31187-3-adubey@linux.ibm.com>
Subject: Re: [PATCH v7 2/7] powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 11 Jun 2026 12:18:30 +0000 (UTC)

--===============2293734144057904883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -217,7 +217,8 @@ static inline void bpf_clear_seen_register(struct codegen_context *ctx, int i)
>  void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_context *ctx);
>  void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx);
>  void bpf_jit_realloc_regs(struct codegen_context *ctx);
> -int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr);
> +int bpf_jit_emit_exit_insn(u32 *image, u32 *fimage, struct codegen_context *ctx, int tmp_reg,
> +										long exit_addr);
                                                        ^^^^

Does this prototype change break the build for 32-bit configurations?

The function definition in bpf_jit_comp.c and the caller in
bpf_jit_comp64.c were both updated to the new 5-argument signature, but
the caller in arch/powerpc/net/bpf_jit_comp32.c was not updated:

arch/powerpc/net/bpf_jit_comp32.c:bpf_jit_build_body() {
    ...
    case BPF_JMP | BPF_EXIT:
        if (i != flen - 1) {
            ret = bpf_jit_emit_exit_insn(image, ctx, _R0, exit_addr);
            if (ret)
                return ret;
    ...
}

This still passes only 4 arguments to a function now requiring 5, which
will result in a compilation failure with 'too few arguments to function'
when CONFIG_PPC32 is enabled.

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c

[ ... ]

> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -1726,7 +1726,8 @@
>  			 * we'll just fall through to the epilogue.
>  			 */
>  			if (i != flen - 1) {
> -				ret = bpf_jit_emit_exit_insn(image, ctx, tmp1_reg, exit_addr);
> +				ret = bpf_jit_emit_exit_insn(image, fimage, ctx,
> +								tmp1_reg, exit_addr);
>  				if (ret)
>  					return ret;
>  			}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27344891421
--===============2293734144057904883==--

