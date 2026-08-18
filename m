Return-Path: <linuxppc-dev+bounces-25956-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F332DC5DF67
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 05:45:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPJZh0w4Lz2xxr;
	Tue, 18 Aug 2026 15:45:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787031932;
	cv=none; b=SO4W/+zYCQiEE/8Zg+42FlNMWJq2pG9B+xahAzQ8iV+cDxiWVZY+fnMl7kDzwDLw3bcIPygQFxU/Lm2OeaBoiCHcNMmvw42EIPOvhJ1tvnCQOwD9nX8yxnQDlrA82GOzG/W46jILU1x822aFX2zskq8wgJGXjFYHJtRMkaNwJnyC1c4fyAI8cTtXVWfcI1sszhYJ7Sw3jkHv0K2FUBSsVuzv6uLzxEZPShn65cZtLezvc97PMU3jmn9G6xGZGKBnD3DWFtzJtB6tN10G1qkUBNovrQPrFx7vgRGn1aZswVfvLVSNKSISwodY9maFo7jsLUCTlzTvHUP2J/wVIUs2uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787031932; c=relaxed/relaxed;
	bh=mtHYt05/dWW0H2RHmI5a47PvI9BCSxbqC/IwNWkMqMo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cKCeyVBvc99Pw48ZunQm0SGHy0LyVlE2RzplVYF2LHgr2k0MJ+ZJIHi/B8ppVK9WhnQzhYa+TcoE19x178+UYWyynWg0t/jhr8CmDAHtXYWIBr33EME6qgIt8eaiBJJ2Hd4cRd/w9y1jo4K8K3Fi0c7UQW4ixoKr7VPbdy+R6nawZxNk7ZVGF4M4w5llvLioSjBFHoMWSNxYnrXZNwYclHK8AYPTNmNw35XohoQiRPbTtNQb5/jtAO2BoaCVnJ1lOJu0+ApT4fkt0X9lkNPJ7kTNuCXfS0+MvZwH6jqsYMy/rrih6BHTKFLVOZdYSo7qeOwXYH7AcS0pbSXoZaOkmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kEwsWg+0; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kEwsWg+0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPJZf5LSDz2xrC
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 15:45:30 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6ABEC43983;
	Tue, 18 Aug 2026 05:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732D51F000E9;
	Tue, 18 Aug 2026 05:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787031927;
	bh=mtHYt05/dWW0H2RHmI5a47PvI9BCSxbqC/IwNWkMqMo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kEwsWg+0myLL36TRgxdYcE8cJLjJugBbc6Sizdaw0Gmf48yUb936HGSjg4OkAQqoV
	 m0XRh4W6Nu1B1NGeK9hqvoJ8JCd9yxG3TNoXMoNDW5IcuSdiEx9d7XiDK7ro2rfd5k
	 rU1pH36/4FImW24D/DMuchsHu8xkvT5rSGfn50T2G1pO3ejydSptN5NMRUJ4hEn+A/
	 +noNJ0IiCnVpq3iAFAjWBuypwa8nEgew5vozbzQl2Zdqc+n7PQLddq+nwM/vnrky/U
	 HyJXa+HfZ4vY2VuqLP3M2LGKkl5AJMRfv59/ZhM9tQNMNwytbJiB0pMyQkLd46+V20
	 IVAX1csSurL1g==
Content-Type: multipart/mixed; boundary="===============8162154980185016120=="
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
Message-Id: <1654cd0b38eec2c92914cda4356c25434187c9a5de5e8fdae901556f0479129b@mail.kernel.org>
In-Reply-To: <ccf3ae66535ea8a7fd3442b7183c87c61f67b24c.1787027080.git.skb99@linux.ibm.com>
References: <ccf3ae66535ea8a7fd3442b7183c87c61f67b24c.1787027080.git.skb99@linux.ibm.com>
Subject: Re: [PATCH v12 2/8] powerpc/bpf: fix alignment of long branch trampoline address
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,venkat88@linux.ibm.com,yeswanth@linux.ibm.com,skb99@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 18 Aug 2026 05:45:26 +0000 (UTC)

--===============8162154980185016120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Ensure the dummy trampoline address field present between the OOL stub
> and the long branch stub is 8-byte aligned, for memory compatibility
> when content loaded to a register.

This isn't a bug, but could the changelog name the concrete failure mode?
The actual mechanism is that bpf_arch_text_poke() patches this field via
patch_ulong() which returns -EINVAL unless IS_ALIGNED(addr,
sizeof(unsigned long)), so attaching a bpf trampoline whose target is out
of branch range fails when the field lands at a 4-mod-8 address.

The phrase "for memory compatibility when content loaded to a register" is
vague - powerpc 'ld' does not require 8-byte alignment; the alignment
requirement comes from patch_ulong().

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 8bee2674d4a9..caea53cde063 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c

[ ... ]

> @@ -49,11 +49,39 @@ asm (
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
> +	 * In the final pass, align the mis-aligned dummy_tramp_addr field
> +	 * in the fimage. The alignment NOP must appear before OOL stub,
> +	 * to make ool_stub_idx & long_branch_stub_idx constant from end.
> +	 *
> +	 * dummy_tramp_addr must be 8-byte aligned for load-register
> +	 * compatibility. The fimage can be non 8-byte aligned, so final
> +	 * alignment depends on start of fimage and the stub's instruction
> +	 * count offset. The OOL stub size is 4 instructions (with
> +	 * CONFIG_PPC_FTRACE_OUT_OF_LINE) or 3 instructions (without)
> +	 * before dummy_tramp_addr.
> +	 *
> +	 * Emit a NOP here if (ctx->idx + ool_stub_sz) is odd, so that
> +	 * dummy_tramp_addr lands at an even instruction offset (== 8-byte
> +	 * aligned from an 8-byte aligned base).
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

Does the new comment block accurately describe the code? Looking at the
comment and the implementation:

(1) Unit mismatch: The comment says "Emit a NOP here if (ctx->idx +
ool_stub_sz) is odd" but ctx->idx is an instruction index while ool_stub_sz
is a byte count (16 or 12). The code actually tests:

    IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + ool_stub_sz, SZL)

which properly multiplies ctx->idx by 4 to convert to bytes. The comment's
stated parity expression doesn't match what the code performs.

(2) Alignment assumption contradiction: The comment states dummy_tramp_addr
"lands at an even instruction offset (== 8-byte aligned from an 8-byte
aligned base)", but the preceding sentence explicitly says "The fimage can
be non 8-byte aligned". In fact, bpf_jit_binary_pack_alloc() is called
with alignment 4 in bpf_int_jit_compile(), and the code correctly folds the
real fimage address into the IS_ALIGNED() check rather than assuming an
aligned base.

(3) "In the final pass" is inaccurate: the alignment decision is taken in
every codegen pass where image != NULL. Looking at the loop in
bpf_jit_comp.c starting around bpf_jit_build_prologue(), 2-3 such passes
run, not just the final one.

Also, "the image buffer have 4 spare bytes" is ungrammatical and
understates the case: a fentry-stub block is also emitted mid-body by
bpf_jit_emit_exit_insn()'s fallback path, so a program can contain several
stub sites and therefore several spare NOP slots.

Note: the immediate follow-up commit 1525fbfebfe9 ("powerpc/bpf: Move out
dummy_tramp_addr after Long branch stub") deletes exactly this wording and
replaces the 16:12 constant with 44:40, which suggests the description was
known to be confusing.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32100929603
--===============8162154980185016120==--

