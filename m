Return-Path: <linuxppc-dev+bounces-25416-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5349CC55822
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 07:25:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFMPV1wC4z2xqM;
	Wed, 05 Aug 2026 17:25:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785914702;
	cv=none; b=bs51yyscxicZYeW3CTMiK//1YbEfUSSKEyPCKpbJ5SWYAzM6PGWdgboZjEd9a07rfWTxKluy/nrhy46TbDQDTZG1pq/8aFqs2F5a7e6FkMRlUGwU0J/P2TKaIgwcUihePkkn/Wp6265sZSQfF8ypm0+pQBYqk5X97zi31a8WOCHnH7Q002o3zcl7bu0nJIiUSL5LUDBvj73VEnEpV01XHSwwcx2L9txoWjf0sRGJQX6BP/3GYOpDQo7/pOyD3QyJduGvzcXZkLEqb+vIMAbW60yoENvY7eN/TEvk+ObKgXoUS+ZRP2GXYYISSC4nOxi6egUP9gxomAR9dMinkoOK9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785914702; c=relaxed/relaxed;
	bh=BW4eguME2maAL3f+ys5mqfFPbLvQZieLacO6hHIVBKw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fRjatTnijCxJ1RLec8oYy2U3t8Y5Sd6TUu1WsB6cj9ZXU8zGgYYkrUDFO5aC27ysswZfWs36rjvC7sl80E/pU1QeDJ8pYPM8Ndgj8mnPniknMxZCg8GN/rGoDhFsR3zA3UFsNS6TPsCbzhhjvT38c+lb3Bg0iheHH68IrGjsSgHyd9W+97s/TLozC3s13xkVTHcBXpt6xaAQpeFzSc/P5MpEkfwW8+E9et030scjZT3DpU01DY9NthLI838skdcm/g2L4WZp7+bMVqjZcU7qHIe88Rqh0AeauLPr3t8MtLN0tfSeDsc6dmyJPqy8C0Nhd7HiOpi5zFEOzZPkp6emoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y7PtBRAf; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y7PtBRAf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFMMR3Fbcz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 17:23:15 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2426442D8C;
	Wed,  5 Aug 2026 07:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FEF1F000E9;
	Wed,  5 Aug 2026 07:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785914560;
	bh=BW4eguME2maAL3f+ys5mqfFPbLvQZieLacO6hHIVBKw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Y7PtBRAfP+RCSGohSHEDO4kWX6oY7YgZu9FeQu70o4dfzc9yax+4qIkTZUWdhN6WK
	 RyHIZnA01AhSTc+bKrGujAkjcT9yLJcefEfWk4uiZxQ+2QGKANb49hmjh3ISGUUEap
	 SQc2/1rCCph3WHcKvZa0Z2RQScQYdFHCBhPKJm/QR0wUUoU5onaQjAjS4cBjieLtK+
	 6FESkaoeDnpbmzO8OniYpRQK42rCqe5hGLNC71bxrvGJUC0h5X3DL8JeHWKcZnZdqu
	 8IIoOkhhN/ska9up08Lik3oy09pzeiORz9sOq1lWmX5eSvXfHMDSxlhDehTCdI+mbm
	 E4DN5J0i9kZMA==
Content-Type: multipart/mixed; boundary="===============7146039074755795200=="
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
Message-Id: <82816128d98deca062a575f024f293e41a8da5f3a41977825b6b9460bb3bd8db@mail.kernel.org>
In-Reply-To: <45cfcf00a9ca1ec0a06c516fabc73e284d529dc1.1785906979.git.skb99@linux.ibm.com>
References: <45cfcf00a9ca1ec0a06c516fabc73e284d529dc1.1785906979.git.skb99@linux.ibm.com>
Subject: Re: [PATCH v10 7/8] powerpc/bpf: fix buffer overflow in JIT for large BPF programs
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,venkat88@linux.ibm.com,yeswanth@linux.ibm.com,skb99@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  5 Aug 2026 07:22:39 +0000 (UTC)

--===============7146039074755795200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index af510da12d8ed..4da8bde92e1ef 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -14,6 +14,13 @@
>  #include <asm/ppc-opcode.h>
>  #include <linux/build_bug.h>
>
> +/*
> + * We need at least 2 passes for proper code generation, and may need
> + * additional passes if code size changes between passes.
> + */
> +#define CODEGEN_MIN_PASSES    2
> +#define CODEGEN_MAX_PASSES    3
> +
>  #ifdef CONFIG_PPC64_ELF_ABI_V1
>  #define FUNCTION_DESCR_SIZE	24
>  #else
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 8be5ded13a4a6..3c20bb13cfd70 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -128,11 +128,10 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
>  int bpf_jit_emit_exit_insn(u32 *image, u32 *fimage, struct codegen_context *ctx,
>  							int tmp_reg, long exit_addr)
>  {
> -	if (!exit_addr || is_offset_in_branch_range(exit_addr - (ctx->idx * 4))) {
> +	if (exit_addr && is_offset_in_branch_range(exit_addr - (long)(ctx->idx * 4))) {
>  		PPC_JMP(exit_addr);
> -	} else if (ctx->alt_exit_addr) {
> -		if (WARN_ON(!is_offset_in_branch_range((long)ctx->alt_exit_addr - (ctx->idx * 4))))
> -			return -1;
> +	} else if (ctx->alt_exit_addr && is_offset_in_branch_range(
> +			(long)(ctx->alt_exit_addr) - (long)(ctx->idx * 4))) {
>  		PPC_JMP(ctx->alt_exit_addr);
>  	} else {
>  		ctx->alt_exit_addr = ctx->idx * 4;
> @@ -303,6 +302,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>  	 */
>  	if (cgctx.seen & SEEN_TAILCALL || !is_offset_in_branch_range((long)cgctx.idx * 4)) {
>  		cgctx.idx = 0;
> +		cgctx.alt_exit_addr = 0;
>  		if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false))
>  			goto out_err;
>  	}
> @@ -335,10 +335,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>  	code_base = (u32 *)(image + FUNCTION_DESCR_SIZE);
>  	fcode_base = (u32 *)(fimage + FUNCTION_DESCR_SIZE);
>
> -	/* Code generation passes 1-2 */
> -	for (pass = 1; pass < 3; pass++) {
> +	/* Code generation passes 1-2+, loop until program size converges. */
> +	for (pass = 1; pass <= CODEGEN_MAX_PASSES; pass++) {
> +		u32 prev_proglen = proglen;
> +
>  		/* Now build the prologue, body code & epilogue for real. */
>  		cgctx.idx = 0;
> +		cgctx.exentry_idx = 0;
>  		cgctx.alt_exit_addr = 0;
>  		bpf_jit_build_prologue(code_base, &cgctx);
>  		if (bpf_jit_build_body(fp, code_base, fcode_base, &cgctx, addrs, pass,
> @@ -347,11 +350,26 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>  			bpf_jit_binary_pack_free(fhdr, hdr);
>  			goto out_err;
>  		}
> +		addrs[fp->len] = cgctx.idx * 4;
>  		bpf_jit_build_epilogue(code_base, fcode_base, &cgctx);
>
> +		proglen = cgctx.idx * 4;
> +
>  		if (bpf_jit_enable > 1)
>  			pr_info("Pass %d: shrink = %d, seen = 0x%x\n", pass,
> -				proglen - (cgctx.idx * 4), cgctx.seen);
> +				prev_proglen - proglen, cgctx.seen);
> +
> +		/* Check if program size has converged, but ensure minimum passes */
> +		if (pass >= CODEGEN_MIN_PASSES && proglen == prev_proglen)
> +			break;
> +
> +		if (pass == CODEGEN_MAX_PASSES && proglen != prev_proglen) {
> +			pr_err("BPF JIT: Program did not converge after %d passes\n",
> +								CODEGEN_MAX_PASSES);
> +			bpf_arch_text_copy(&fhdr->size, &hdr->size, sizeof(hdr->size));
> +			bpf_jit_binary_pack_free(fhdr, hdr);
> +			goto out_err;
> +		}

With CODEGEN_MAX_PASSES set to 3, the convergence loop only allows a
single retry after the mandatory two passes. Is this sufficient margin
for the cascading shrinkage described in the commit message?

The changelog states that when the epilogue offset moves, an exit that
was out of range can fall in range, shrinking the body and potentially
triggering a chain reaction. That pattern can need more than one settling
iteration for a large program. Other architectures allow significantly
more headroom for this exact scenario: riscv and parisc use
NR_JIT_ITERATIONS (default 16), sparc64 uses 40 passes, x86 uses
MAX_PASSES (20), and mips uses JIT_MAX_ITERATIONS (32).

The tight bound has two concrete effects:

1. A program that would eventually converge can now fail the JIT hard.
   The old two-pass code did not check convergence at all, so a program
   that needs four settling iterations to fully cascade would have been
   JITed with pass 2 output. Now it gets -ENOTSUPP. On a
   CONFIG_BPF_JIT_ALWAYS_ON or bpf_jit_enable=2 kernel, that is a
   verifier rejection at load time, not a silent fallback to interpreter.

2. Each pass walks the entire program without preemption. x86 and sparc64
   both call cond_resched() in their codegen loops. A large program will
   burn a full pass with preemption unchanged, and with only three passes
   allowed there is no headroom to add resched points.

For comparison, x86's codegen loop:

  kernel/bpf/core.c:bpf_int_jit_compile() {
      for (pass = 0; pass < MAX_PASSES || image; pass++) {
          ...
          cond_resched();
      }
  }

Would raising CODEGEN_MAX_PASSES to a value with real headroom (perhaps
matching NR_JIT_ITERATIONS at 16, or 20 to match x86) and adding
cond_resched() address these concerns?

>  	}
>
>  	if (bpf_jit_enable > 1)
> @@ -428,7 +446,7 @@ int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass
>  	u32 *fixup;
>
>  	/* Populate extable entries only in the last pass */
> -	if (pass != 2)
> +	if (pass >= CODEGEN_MIN_PASSES)
>  		return 0;

Is this comparison inverted? The old predicate was `if (pass != 2)
return 0;` with the fixed two-pass loop `for (pass = 1; pass < 3;
pass++)`, which populated entries only when pass == 2, the final pass.

The new code is `if (pass >= CODEGEN_MIN_PASSES) return 0;` with
CODEGEN_MIN_PASSES == 2, which returns early for pass 2 and pass 3 and
populates entries only when pass == 1. That is the exact inverse, and
contradicts the retained comment "Populate extable entries only in the
last pass."

The correct predicate for "not the last pass" in the new convergence loop
would be `if (pass < CODEGEN_MIN_PASSES) return 0;`, or a last-pass flag,
not `pass >= CODEGEN_MIN_PASSES`.

Two concrete consequences from populating during pass 1 instead of the
final pass:

1. Stale extable contents. Entries are written during pass 1 using pass-1
   offsets. The whole point of this patch is that the body can shrink
   between passes (an out-of-range exit settling into an in-range jump),
   so pass 2/3 instruction addresses differ from pass 1.

   bpf_add_extable_entry() records deltas derived from absolute addresses:

     kernel/bpf/verifier.c:bpf_add_extable_entry() {
         pc = (unsigned long)&image[insn_idx];
         offset = pc - (long)&ex_entry->insn;
         ex_entry->insn = offset;
         fixup[BPF_FIXUP_LEN - 1] = PPC_RAW_BRANCH(
             (long)(pc + jmp_off) - (long)&fixup[BPF_FIXUP_LEN - 1]);
     }

   Because cgctx.exentry_idx is now reset at the top of every pass
   (CHANGE-3), and pass 2+ returns early, nothing rewrites these entries
   after the layout changes.

   search_bpf_extables() in kernel/bpf/core.c then resolves a faulting
   PROBE_MEM access to the wrong insn address, and the recorded fixup
   branch jumps to a stale offset. For a program whose size changes
   between pass 1 and the final pass, that is a wild branch from the fault
   fixup path in kernel context.

2. Interaction with extra_pass for subprogs. On the skip_init_ctx path,
   the comment at arch/powerpc/net/bpf_jit_comp.c:259 states:

     /* During extra pass, ensure index is reset before repopulating
        extable entries */

   The design intent is that the extra pass repopulates the extable. With
   the new predicate, the extra pass enters the loop at pass == 1 and does
   populate. But any later iteration of the same loop (pass 2, which is
   always executed because CODEGEN_MIN_PASSES == 2 gates the early break)
   will not. That leaves the extable describing whichever pass wrote last
   (pass 1) while the final emitted code is from pass 2. The comment and
   the code now disagree in every configuration.

Would inverting the test to `if (pass < CODEGEN_MIN_PASSES) return 0;`
fix this?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30981212698
--===============7146039074755795200==--

