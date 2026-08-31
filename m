Return-Path: <linuxppc-dev+bounces-26252-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0818DC61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 08:12:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYMDS2Yjnz2ygK;
	Mon, 31 Aug 2026 18:12:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788163960;
	cv=none; b=gkINHJWTc6EHj10LTdB99jZm4K7ctPgqPv6VzDMWgthOTBjNdaCZN+b1XZsQ8I9RhdxY3RocPslwJdGxe1FUvj8NNl2LYC0pvKnQiztnFCmn6ztxAEpbMKWFjyw0pmy0tTp/9rQxCod9klRfE0YhCR+ikJL4WJNpjCZPW98ZWp+z12iM9AOuiIjWQGHJ36y56OOw1aNtZIc5OnCkCbzk0biA4J3lQ+gocypuw4xuFR/GB5HGsZq/BK8zsAliXVNRnntJ4LTBAd13yF4Rx9wH5UuUSiCCtLcM5KA3Tv6n9pJb9iqZXYC05l6p4eNfJmTS7Yon4T7HXkhefE9poOb3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788163960; c=relaxed/relaxed;
	bh=8YMWtQhoNec0eQMN+uaUDx0asxbEyHNoV6RuG2L3NJc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hTRnU7+YHbAqIlrnA7GKCZxbGFrXMDejksAtHbK1uCEK/4/LrSfVBMHpdrp+lD00l3XM2d4Mo4jz/q7OQLB5rrIeSt2QD0PVc6kn4nsgYbJAETeawNSUySt0qkYSHYsfxp7RlVemTNc5yCki6zYl8xsa6rnxF/NLgaSiB3r8nqGiD2OYlT9XyM+FxvLy1CIi/49//lAgN9+FxC7jubDjwhh67Up80e9rTb8ET6M+9tGmNHcZvbOVzOoF0McnZbx0Sgp/IuxiU0dRbWrqy9cCuTWZE725JJGLca9ou1yRojsENtxopia5cWmQ/J28A0C8kndhCRiucO0QOCPxXqh1jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e3fCH6LZ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e3fCH6LZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYMDR1Nrnz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 18:12:38 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6BE36437A1;
	Mon, 31 Aug 2026 08:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AD81F00A3D;
	Mon, 31 Aug 2026 08:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788163955;
	bh=8YMWtQhoNec0eQMN+uaUDx0asxbEyHNoV6RuG2L3NJc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=e3fCH6LZVXE5Cq9vGwt8R8sacD/D/tPe9blv+x2rbdeMhLwDecp+yoW0W1tRQC1TH
	 /jPtpqBsNZTflkR6dTXU1kmzHw8cjPHrtXxFZHTzQzahQm8FbvyBXvnX/2b6CpH1ST
	 iFP+OfzLZWvlck83pndCtC1eRc0U3Frj4d9J0FWiWOmzjPRgwnFKW7YxHsg8wVfy0v
	 sPsVTrKv7Qg6Ac5w/jO4KaIzzvFemRwf/IDsmC+DAw35BmsEQANazxf+/ipXTbwY6G
	 q18TYKexxlN7rXDHRNb+TDzXv8zQYw6yQcEuA9qeATNsCsmA2ssYUO6wvBpPuP9hyM
	 WyMIlukvVNEaA==
Content-Type: multipart/mixed; boundary="===============0534822206783585426=="
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
Message-Id: <71916017b03ad6e22c093094acae6a356a57f8fd0c3afda3833a20a2db10ec77@mail.kernel.org>
In-Reply-To: <0700c866205c8fa2f861e4b8d64fdf7469cba021.1788154635.git.skb99@linux.ibm.com>
References: <0700c866205c8fa2f861e4b8d64fdf7469cba021.1788154635.git.skb99@linux.ibm.com>
Subject: Re: [PATCH v13 4/8] powerpc/bpf: fix alignment of long branch trampoline address
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,venkat88@linux.ibm.com,yeswanth@linux.ibm.com,skb99@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 08:12:34 +0000 (UTC)

--===============0534822206783585426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 11981d2270a9d..8ca36a933c7ae 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c

[ ... ]

> @@ -49,11 +49,35 @@ asm (
>  "	.popsection				;"
>  );
>
> -void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
> +void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx)
>  {
>  	int ool_stub_idx, long_branch_stub_idx;
> +	int ool_stub_sz;
>
>  	/*
> +	 * Align the mis-aligned dummy_tramp_addr field in the fimage.
> +	 * The alignment NOP must appear before OOL stub, to make
> +	 * ool_stub_idx & long_branch_stub_idx constant from end.
> +	 *
> +	 * The fimage can be non 8-byte aligned, so final alignment depends
> +	 * on start of fimage and the stub's instruction count offset. The
> +	 * OOL stub size is 4 instructions (with CONFIG_PPC_FTRACE_OUT_OF_LINE)
> +	 * or 3 instructions (without) before dummy_tramp_addr.
> +	 *
> +	 * Emit a NOP here if address is not SZL aligned.
> +	 *
> +	 * In pass=0 when image==NULL, conservatively account for space
> +	 * required to accommodate alignment NOP. In case final pass skips
> +	 * emitting alignment NOP, the image buffer have 4 spare bytes and
> +	 * jited_len signifies correct program size.
> +	 */
> +
> +	ool_stub_sz = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 16 : 12;
> +	if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + ool_stub_sz, SZL))
> +		EMIT(PPC_RAW_NOP());

Can the conditional alignment NOP here mask program length convergence?

The preceding commit (5175364d6174 "powerpc/bpf: fix buffer overflow in
JIT for large BPF programs") added a convergence check:

    if (pass >= CODEGEN_MIN_PASSES && proglen == prev_proglen)
        break;

to bpf_int_jit_compile(). But the alignment decision above forces the
stub block to end at a fixed residue mod 8: the field address (fimage +
ctx->idx*4 + ool_stub_sz) is aligned to SZL, and exactly SZL/4 + 7
instructions follow it. So fimage + proglen is congruent to a constant
mod 8 every pass, meaning proglen can only change in multiples of 8.

When the body shrinks by an odd multiple of 4 bytes between passes, the
NOP can absorb it and keep proglen unchanged. The body can shrink when
an exit goes from out-of-range (emitting a full epilogue) to in-range
(emitting a single branch):

arch/powerpc/net/bpf_jit_comp.c:bpf_jit_emit_exit_insn() {
    if (exit_addr && is_offset_in_branch_range(...)) {
        PPC_JMP(exit_addr);                    // 1 instruction
    } else {
        ...
        bpf_jit_build_epilogue(image, fimage, ctx);  // N instructions
    }
}

The shrink is (N-1)*4 bytes. When N-1 is odd, this is 4 mod 8. The NOP
appearance or disappearance compensates, making proglen identical across
passes even though addrs[] shifted.

Because forward branches use addrs[] from the previous pass (addrs[j]
for target j > current i is computed in the prior pass), those branches
would land (N-1)*4 bytes past the intended target.

The comment at arch/powerpc/net/bpf_jit.h:132-138 documents that the
PowerPC JIT avoids pass-to-pass size changes by padding the short branch
case with a NOP, specifically to prevent this scenario. Does reintroducing
an address-dependent, pass-varying size risk incorrect branches?

(Note: commit 0cd8bd7da278 later in this series reworks the stub layout
and is described as a layout improvement rather than a fix for this commit,
which may provide additional context.)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33368376983
--===============0534822206783585426==--

