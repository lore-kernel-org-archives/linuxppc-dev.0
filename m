Return-Path: <linuxppc-dev+bounces-26570-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9006C79F82
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 20:33:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hc7Tl5SZsz2y2b;
	Sat, 05 Sep 2026 06:33:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788554027;
	cv=none; b=Sijqtr2EljX/2si3TjvsvD9U+tVW8WqClkScnkVBkb34Ys6f0azzbc8tJ4V6wS65Ixokh6g/Xh01t6/YKTmh+EcwBQk7qFDx+CrNzRRIBiUta/NRulscDZN3bSzIF5zkvnafc4NE39VsvR70H8Ww8iySXUQp3qKWjVA34x8UiqNvJhlEWTEEAqcmUm79wIqRMjMRkrT4BJJ2VqqEykddysKdPy1bsSFxXQduTCvVmtCkqo4SziOZiEFY6URtHXafLp0WLYy7iKlQCoqHUMT67xpakxeNNH0tQRIGvMQ/uAxyfn0/9C2qSxK1bGbwzL4X+87+03UqExPDdx3KYu31ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788554027; c=relaxed/relaxed;
	bh=S1Ltm0JPfJjiwiR8Yz5D6OIK6U9xShhvq6boNu3N5cI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YSgXTNmX06bzk0PBAH3bI6KSAtPlj2Fi7JwZgJlyICOkyfXXyD22xNzd+wIIVWvzHGIlSRF+1SoYKy3C/OHNSc6RZYOKyEmqvBFdlcQ2mJ9iVOUR3X/pNjPxuRkm5Jx2VM/FW+KAiIBHXF4GmLkLM+OAKKIYaKsfIYdaY8/llmjI4JFduD2/UsdL+t+/jkAOIr/AL/MsKNF4JGSfEgAbKe/2ud36u1vC021D6zjtzS8BS0PQX89iONAb3JbVmnXJpkjiUmOi5uz8LlPWN7H0QmWqS3QXD+Qw0GG9wkMvAxlRuTc4hTP/vQLKoFRXiMEm+X4hfkMT2MCFZWZzh/K/HA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gi33ko4A; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gi33ko4A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hc7Tk35Fwz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 06:33:46 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6A60D600C8;
	Fri,  4 Sep 2026 20:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF931F00A3D;
	Fri,  4 Sep 2026 20:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788554023;
	bh=S1Ltm0JPfJjiwiR8Yz5D6OIK6U9xShhvq6boNu3N5cI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Gi33ko4AShQ6SlVBUiya7gtJr/t0DdMgfn3GBt4hcOZ1Juj+7K0TB8/GZ+XmsfFxV
	 7EyR61Z0AGyvUfB0zJXtqpaP7Zg8Jt1ReZQSQmXB5g+JuE4pLt87zV+YT/MdGv6bJ0
	 LJdOCDr2pi7DgNwFKVgTFOY43p8zi/TfxpIjKz3Hgw+nT+kF9VZscD5BAHZoVGA9LP
	 BWcbOTAY7vgEKAMW0qExXqRqrnQK3nlTbXqopzRSOgwr1WCl5KFMkyomfRmA4O1a8Q
	 rOXbyzEsCrRqETaEhgjXFo11E+HeZwoTlkAD3xp9lAtnSYVRecUqD8mZmOfWImXrAA
	 XAGjlNU3JRZ+A==
Content-Type: multipart/mixed; boundary="===============7579324935920484098=="
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
Message-Id: <b67f406ebae81de9368fa6ef0a627548257d5db372ad1dfa2f84092086eaf745@mail.kernel.org>
In-Reply-To: <20260904195132.141068-6-sidchintamaneni@gmail.com>
References: <20260904195132.141068-6-sidchintamaneni@gmail.com>
Subject: Re: [PATCH bpf-next v1 5/7] bpf, riscv: Use resolved pointer for timed may_goto
From: bot+bpf-ci@kernel.org
To: sidchintamaneni@gmail.com,bpf@vger.kernel.org
Cc: sidchintamaneni@gmail.com,jeremy.jean@oss.cyber.gouv.fr,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,a.s.protopopov@gmail.com,puranjay@kernel.org,linuxppc-dev@lists.ozlabs.org,linux-s390@vger.kernel.org,linux-riscv@lists.infradead.org,rlmenge@gmail.com,hargar@linux.microsoft.com,apais@microsoft.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  4 Sep 2026 20:33:41 +0000 (UTC)

--===============7579324935920484098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, riscv: Use resolved pointer for timed may_goto
>
> The timed may_goto fixup now passes the resolved counter pointer through
> BPF_REG_AX instead of a stack offset.
>
> Copy the pointer directly into the first argument register rather than
> adding it to the BPF frame pointer again.
>
> Fixes: 6ef8ff20c30b ("bpf, riscv: Add support for timed may_goto")

Should the Fixes: tag point to d8319a04dafc ("bpf: Fix timed may_goto
stack pointer for private stacks") instead? That commit changed the
calling convention from passing a stack offset to passing a resolved
pointer through BPF_REG_AX, which is what broke the riscv trampoline.

The original riscv implementation (6ef8ff20c30b) worked correctly with
the original calling convention. riscv64 cannot hit the private-stack bug
that d8319a04dafc targeted: it does not implement
bpf_jit_supports_private_stack(), so the __weak default in
kernel/bpf/core.c returns false, and private stacks are gated on it in
kernel/bpf/verifier.c. On riscv, regmap[BPF_REG_FP] = RV_REG_S5 is the
one and only BPF frame pointer, and the pre-patch 'add a0, t0, s5'
computed exactly the right address.

What this patch actually does on riscv is adapt to the new BPF_REG_AX
calling convention introduced by d8319a04dafc, which is patch 1 of the
same series. If stable/AUTOSEL tooling picks this commit up on the
strength of its Fixes: tag without also taking d8319a04dafc, BPF_REG_AX
still holds the raw immediate from the old fixup (BPF_MOV64_IMM(BPF_REG_AX,
stack_off_cnt), i.e. -stack_depth-16, up to -528):

    mv a0, t0       /* a0 = -528, not a pointer */
    call bpf_check_timed_may_goto

bpf_check_timed_may_goto() then dereferences p->timestamp
(kernel/bpf/core.c) at 0xfffffffffffffdf0, oopsing on every timed
may_goto loop.

Should the changelog also declare that d8319a04dafc is a prerequisite
for this patch?

Because d8319a04dafc lands first and each architecture is converted in a
later commit, riscv64 (and arm64, powerpc64, s390) BPF timed may_goto is
broken at every intermediate commit of the series. Does the series need to
be structured differently to remain bisectable for those architectures?

> diff --git a/arch/riscv/net/bpf_timed_may_goto.S b/arch/riscv/net/bpf_timed_may_goto.S
> index 02c637d87420..8c03e272e0bf 100644
> --- a/arch/riscv/net/bpf_timed_may_goto.S
> +++ b/arch/riscv/net/bpf_timed_may_goto.S
> @@ -6,12 +6,11 @@
>
>  /*
>   * Trampoline for the BPF timed may_goto loop bound. Custom calling convention:
> - *	- input:  stack offset in BPF_REG_AX (t0)
> + *	- input:  count and timestamp pointer in BPF_REG_AX (t0)
>   *	- output: updated count in BPF_REG_AX (t0)
>   *
> - * Calls bpf_check_timed_may_goto(ptr) with the standard RISC-V ABI, where
> - * ptr = BPF_REG_FP (s5) + BPF_REG_AX (t0). BPF R0-R5 (a5, a0-a4) are saved
> - * across the call; BPF_REG_FP (s5) is callee-saved and needs no saving.
> + * Calls bpf_check_timed_may_goto(ptr) with the standard RISC-V ABI.
> + * BPF R0-R5 (a5, a0-a4) are saved across the call.
>   */
>
>  SYM_FUNC_START(arch_bpf_timed_may_goto)
> @@ -28,7 +27,11 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
>  	REG_S	a3, 1*SZREG(sp)
>  	REG_S	a4, 0*SZREG(sp)
>
> -	add	a0, t0, s5
> +	/*
> +	 * BPF_REG_AX (t0) contains the count and timestamp pointer; pass it as
> +	 * the first argument in a0.
> +	 */
> +	mv	a0, t0
>  	call	bpf_check_timed_may_goto
>  	mv	t0, a0
>

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33914557238
--===============7579324935920484098==--

