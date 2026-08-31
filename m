Return-Path: <linuxppc-dev+bounces-26264-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E72C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 08:25:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYMVl6hwQz2yDD;
	Mon, 31 Aug 2026 18:25:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788164703;
	cv=none; b=ocMYIlTw8BF1o4jeSeEsBxnmTH0671G1sVdsT4L+qkzyiYZavpC2A3ZDuMvAD+QrUfh2OiZ5x5KxXclGtsIxMpLkaLj42QEg1/sEjUN4SUmgHMckGslz4IVryO+tQBjsL/SXK2elkzQ6uX3RjwC7Gp7rgUqGYTvy2KSt2/LP2txyB8vjCi1GhrC8Mp9HX4R3+BYpJoaKhDF1auwVMFk+7mezcWbvwwes7tg7+s1RMT6utjsF9yeO6tbeUw3nOZhlAaZi/GwE9HlLVneq2mEs3nXu3OxOyN84HmoGOoy700VrPNuq7lNG15qkHzjxOZ/plEKyAfNbE/uS8fE4Xnfnaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788164703; c=relaxed/relaxed;
	bh=O9m4b46omMgani/6PKydjvX3UeCse2JOjMD2pfjWU/U=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mC7+gSbopKc30Be6fP0+Na1BWz3vY6ksX1eRzNqIdtP/SyqSpe6knL55ArTy4aG3kA5S1+/OfnV98u3SJ/eM0r2H6OGz9gRYfZLznEzPmqeoGBgAbSda8zHVmgdNPQA/uTM2rKbjDfClY2KFSsfw5yxr5ziUhwB/8NUqqPLlXblxbp83Evmb2BpzwAP5IMeLvyicw3GV2SIqDZmrX/VuhcKGkpQjSzd0rz/+iBGab0jLKL/cItDUwuOioScPneoy7dGMy/DZpTZFhpwl1QzGheRm7E2e8x5Y6jfqBbpGMr/J8x+AYixx9027q9KUXvTxwjQ0LnzKsyQL6avEH7jQ2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0ZZW/NG; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0ZZW/NG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYMVl02w2z2yCt
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 18:25:02 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 019D74093E;
	Mon, 31 Aug 2026 08:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AD11F000E9;
	Mon, 31 Aug 2026 08:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788164700;
	bh=O9m4b46omMgani/6PKydjvX3UeCse2JOjMD2pfjWU/U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=W0ZZW/NGEfCZiYf2OPIpmgAblK5Ugo3IgkljKf8nw/520yhHsc6NqMguOFYKqtTVx
	 Yy4tb5eS91Xpyr1bqigd+aSBQA0P6Zo3TpOKY54LPShOBhjPZjGufMNKxyqAd+MP62
	 ha57cIuMxbxZ2feDsZgeI993ITZfLkwaDzxzWSTLIU4WbCLFC4KfO1KeiErtmcL1Fm
	 azXo8vWJbRiz5cLxQo4EXKXGLIKBQ/QvuQa/A56uBDXtOxWA5WSwzRRlaxg5xYS2fw
	 lw3OqpZPY54/0y4izV73moSBqwoJEUBBoq+L81JBlH6iSwpb131IDAEj5QWFO97fAF
	 XBDu/mFRJhSbA==
Content-Type: multipart/mixed; boundary="===============2430223902918538978=="
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
Message-Id: <f073ec2085f90747a8909276f42726a0a0e12f99f8f81b0297dad05c4eec3667@mail.kernel.org>
In-Reply-To: <e5fc39c4f3340791bec5e7a92e1d146d3ed6296e.1788154635.git.skb99@linux.ibm.com>
References: <e5fc39c4f3340791bec5e7a92e1d146d3ed6296e.1788154635.git.skb99@linux.ibm.com>
Subject: Re: [PATCH v13 3/8] powerpc/bpf: fix buffer overflow in JIT for large BPF programs
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,venkat88@linux.ibm.com,yeswanth@linux.ibm.com,skb99@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 08:24:59 +0000 (UTC)

--===============2430223902918538978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")

Does the Fixes: tag name the correct commit?

With Cc: stable@vger.kernel.org this fix will only reach v6.13+ and will
leave every stable tree from v5.18 to v6.12 carrying the same JIT buffer
overflow.

The faulty logic predates d243b62b7bd3. Looking at the parent of that commit:

git show d243b62b7bd3^:arch/powerpc/net/bpf_jit_comp.c

already contains the exact code being fixed:

    if (!exit_addr || is_offset_in_branch_range(exit_addr - (ctx->idx * 4))) {
            PPC_JMP(exit_addr);
    } else if (ctx->alt_exit_addr) {
            if (WARN_ON(!is_offset_in_branch_range((long)ctx->alt_exit_addr - (ctx->idx * 4))))
                    return -1;
            PPC_JMP(ctx->alt_exit_addr);
    } else {
            ctx->alt_exit_addr = ctx->idx * 4;
            bpf_jit_build_epilogue(image, ctx);
    }

The real introducing commit is 0ffdbce6f4a89bb7c0002904d6438ec83cf05ce7
("powerpc/bpf: Handle large branch ranges with BPF_EXIT"), merged in v5.18-rc1
(git describe --contains: v5.18-rc1~124^2~42). It created
bpf_jit_emit_exit_insn() with the '!exit_addr' early-out and replaced the
previous unconditional one-instruction emission:

    -               if (i != flen - 1)
    -                       PPC_JMP(exit_addr);
    +               if (i != flen - 1) {
    +                       ret = bpf_jit_emit_exit_insn(image, ctx, b2p[TMP_REG_1], exit_addr);

Before 0ffdbce6f4a8 a non-final BPF_EXIT always cost exactly one instruction in
every pass, so the sizing pass could not under-count and no overflow was
possible. After it, the sizing pass emits PPC_JMP(0) (1 instruction) while
later passes may emit a full inline epilogue, which is precisely the
under-count described in this commit message.

The commit d243b62b7bd3 only enlarged the epilogue (it added
bpf_jit_build_fentry_stubs()), making an already-existing overflow bigger.

Citing the ppc64-trampoline commit also wrongly implies PPC32 is unaffected.
The commit 0ffdbce6f4a8 made the identical change to
arch/powerpc/net/bpf_jit_comp32.c, so 32-bit powerpc has the same bug over the
same range.

A tag survey confirms the range: 'alt_exit_addr' has 0 occurrences in
arch/powerpc/net/ at v5.16 and v5.17, and 5 occurrences at v5.18, v5.19, v6.0,
v6.1 and v6.6.

Should the tag be:

  Fixes: 0ffdbce6f4a8 ("powerpc/bpf: Handle large branch ranges with BPF_EXIT")

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 8f7501954d9f0..11981d2270a9d 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -99,11 +99,10 @@ void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
>
>  int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr)
>  {
> -	if (!exit_addr || is_offset_in_branch_range(exit_addr - (ctx->idx * 4))) {
> +	if (exit_addr && is_offset_in_branch_range(exit_addr - (long)(ctx->idx * 4))) {
>  		PPC_JMP(exit_addr);
> -	} else if (ctx->alt_exit_addr) {
> -		if (WARN_ON(!is_offset_in_branch_range((long)ctx->alt_exit_addr - (ctx->idx * 4))))
> -			return -1;
> +	} else if (ctx->alt_exit_addr && is_offset_in_branch_range(
> +			(long)(ctx->alt_exit_addr) - (long)(ctx->idx * 4))) {
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  		PPC_JMP(ctx->alt_exit_addr);

With alt_exit_addr defined as unsigned int, does the expression
(long)(ctx->alt_exit_addr) - (long)(ctx->idx * 4) produce a different result
than (long)ctx->alt_exit_addr - (ctx->idx * 4) due to how integer promotion
works?

In v7 review, Hari Bathini pointed out that the cast placement may affect
integer promotion semantics and requested restoring the earlier syntax with the
cast only on alt_exit_addr:

https://lore.kernel.org/bpf/038a115b-e2a5-4ecf-82b1-3689535e986b@linux.ibm.com

While the current code has passed testing, the concern about integer promotion
semantics was never explicitly addressed.

[ ... ]

> @@ -399,7 +417,7 @@ int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass
>  	u32 *fixup;
>
>  	/* Populate extable entries only in the last pass */
> -	if (pass != 2)
> +	if (pass < CODEGEN_MIN_PASSES)
>  		return 0;

Does the comment still match the code?

With the old 'if (pass != 2)' and a fixed two-pass loop, pass 2 was the last
pass, so the comment was accurate. With the new loop and 'pass <
CODEGEN_MIN_PASSES', both pass 2 and pass 3 can write extable entries, so
entries are populated in every pass from 2 onwards, not only in the last one.

Also, CODEGEN_MIN_PASSES is being reused here with a different meaning. In
arch/powerpc/net/bpf_jit.h it documents the minimum number of code-generation
passes, but here it is used as 'the first pass in which extable entries are
valid'. The two are logically independent - bumping CODEGEN_MIN_PASSES to 3 to
force more settling iterations would silently stop extable entries being
written in pass 2.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33368376983
--===============2430223902918538978==--

