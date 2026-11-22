Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AA2606A32C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 20:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEp5dSxQ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXgKZ5PZxz2xsW;
	Mon, 23 Nov 2026 07:14:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795378498;
	cv=none; b=SIktxVZD+vGJL7OZsfkXAMnFqd0fcZarGwj2tHeJ5kUT4IK1ZE5MiTAnyVf0KiQQZBcZKmUvswmiC1VhVfHJRdhlIBDpVgDb+i9WQDa/m3fU3lBEMzftEBCxZkyv2zFJr5dYLSv/6lp8Pr3mHBd7srZKnq2C4IrMccwPs/I3oewG6I2qj3bxVYnhD94ZxafHajmjx+5ilIgu+sSriXw46Sm/zNryftM/ZV5nVJJ86Z00suI8cIi4RHubtXJQARbYfDxjZShItfH3kFBw+QVlFKCtpkWi+CVtXKmGcKRsqiYfTOtUeGd2283nVX3umxVHSj4tVTz4vXShLrdDdPGS5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795378498; c=relaxed/relaxed;
	bh=76ljkf7BVH2cqSoMcyXFT4dj4x0j5CN/M31i9Hxmuyo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ALIE3JCVl31PsM4zef+DUCQ6iJTs7cOoNn+aW7RWlx8ySCWej1U8370BMrhZ0AQ/I8uh/Ey6uvCCPPj9I+OlSG/t8UzYqaYiVaWLFoLZ338Ekl53Nw1ASsQNjwyJGngNJjYMRmzp9rzZbVpX8iZynNccIg1WLBwY6PGxkd3uk9niWx7TTn7eJ2P3j+X4D5kodKRaKNXl2GQAv4UFkz3z1of8E40C6THPpvtwAosk5r2x2antoH26tlnyuzhIcKFiOle+rByOcy0Is7uEcv2RePE1/TBzQpk96WFnEXJiXXwHRfZe1W4SU9YQnx+j2KNm4ST7rHFMw+n7FWgJs9oR9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEp5dSxQ; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEp5dSxQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXgKY6K9qz2xLh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 07:14:57 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 82A5E6146D;
	Sun, 22 Nov 2026 20:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8437C1F0093C;
	Sun, 22 Nov 2026 20:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795378494;
	bh=76ljkf7BVH2cqSoMcyXFT4dj4x0j5CN/M31i9Hxmuyo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XEp5dSxQdSjLItyX3RLGq4xfSl9ePCsNlz2hTOOhoNIJ0/oBCKKimAw5Xs3ZmDJOK
	 yx6iFXL9PkbDl6QCNTg3ULMZ8MMuals2Hac6r+0N5eC2bPkm/bjNQNq4ii7JXjtppz
	 WY/0VALCnsheEPyI3Nx5vHwFuoPwqStThnPSGMGGvnXXQDIDMv7k8K9PfHMNdKZKdb
	 E/40AOhfVGeyyICIx6ktUVxK3/is9qlQbajTP3HYjMKHJBrni4wnPkikiBWBEAPmrY
	 sQ59efk70IfuR5SJLqlI7i38gRcOemXX4DJk/LqQCWsEp/tphAyPKVsddh2Saag8iw
	 Is3bsdGC2y1jg==
Content-Type: multipart/mixed; boundary="===============7795125532508836721=="
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <53e178df1c64a4c8ae71a4d44647398d0a60cec6803d8922dd78217d2c900c34@mail.kernel.org>
In-Reply-To: <20261122194205.218543-5-lukas@lukasstockner.de>
References: <20261122194205.218543-5-lukas@lukasstockner.de>
Subject: Re: [PATCH 4/4] powerpc32/bpf: don't fold MOV into instructions that use dst_reg
From: bot+bpf-ci@kernel.org
To: lukas@lukasstockner.de,hbathini@linux.ibm.com,chleroy@kernel.org,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org
Cc: naveen@kernel.org,maddy@linux.ibm.com,mpe@ellerman.id.au,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,lukas@lukasstockner.de,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 22 Nov 2026 20:14:52 +0000 (UTC)
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7795125532508836721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> powerpc32/bpf: don't fold MOV into instructions that use dst_reg

TL;DR:
- PPC32 JIT MOV-fold fix is incomplete: several ALU handlers still read stale
  dst, giving wrong results
- Pre-existing: fold ignores sign-extending MOV and jump targets, also
  computing wrong values

> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
> --- a/arch/powerpc/net/bpf_jit_comp32.c
> +++ b/arch/powerpc/net/bpf_jit_comp32.c

[ ... ]

> @@ -367,7 +367,8 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>  		if (i && (BPF_CLASS(code) == BPF_ALU64 || BPF_CLASS(code) == BPF_ALU) &&
>  		    (BPF_CLASS(prevcode) == BPF_ALU64 || BPF_CLASS(prevcode) == BPF_ALU) &&
>  		    BPF_OP(prevcode) == BPF_MOV && BPF_SRC(prevcode) == BPF_X &&
> -		    insn[i - 1].dst_reg == insn[i].dst_reg && insn[i - 1].imm != 1) {
> +		    insn[i - 1].dst_reg == insn[i].dst_reg && insn[i - 1].imm != 1 &&
> +		    !(BPF_SRC(code) == BPF_X && insn[i].src_reg == insn[i].dst_reg)) {
>  			src2_reg = bpf_to_ppc(insn[i - 1].src_reg);
>  			src2_reg_h = src2_reg - 1;
>  			ctx->idx = addrs[i - 1] / 4;

The subject says the JIT should no longer fold a MOV into an instruction
that uses dst_reg, but this check only covers the case where the explicit
BPF_X source operand equals dst.  Several handlers in the same switch still
read dst_reg/dst_reg_h directly, or never write dst_reg_h (or anything at
all), instead of using src2_reg/src2_reg_h.  Folding still drops the MOV for
these, so they compute from the stale destination register:

- BPF_ALU64 | BPF_RSH | BPF_X emits
  EMIT(PPC_RAW_SRW(tmp_reg, dst_reg_h, tmp_reg)), which reads dst_reg_h,
  while ARSH_X uses src2_reg_h in the same position.  For "r2 = r1;
  r2 >>= r3" with r3 >= 32, the low word comes from the old high word of
  r2, not r1.

- BPF_ALU64 | BPF_MUL | BPF_K with a power-of-2 imm emits
  EMIT(PPC_RAW_RLWIMI(dst_reg_h, dst_reg, imm, 32 - imm, 31)), which reads
  the old low word of dst.  LSH_K uses src2_reg at the same spot.

- BPF_END | BPF_FROM_LE with imm 16 emits
  EMIT(PPC_RAW_RLWIMI(dst_reg, src2_reg, 16, 0, 15)), which keeps bits
  16-31 of the old dst, so "r2 = r1; r2 = le16 r2" returns
  (b0 << 8 | stale byte) instead of (b0 << 8 | b1).

- BPF_ALU | BPF_END | BPF_FROM_BE with imm 32/64 emits nothing (/* nop */),
  so after the rewind (ctx->idx = addrs[i - 1] / 4) the MOV disappears
  completely and "r2 = r1; r2 = be64 r2" leaves r2 unchanged.  BPF_TO_BE
  is 0x08 == BPF_X but src_reg is required to be 0, so the new check only
  blocks this for dst r0.

- BPF_ALU64 | BPF_OR | BPF_K and BPF_XOR | BPF_K with imm >= 0, and
  BPF_AND | BPF_K with imm < 0, never write dst_reg_h.  After the fold it
  should hold src2_reg_h, but it keeps the old high word: "r2 = r1;
  r2 |= 4" gives hi(r2) = old hi(r2).  With imm == 0, OR_K and XOR_K emit
  nothing for the low word either.

- BPF_ALU64 | BPF_LSH | BPF_K with imm == 0 only runs
  EMIT(PPC_RAW_MR(dst_reg, src2_reg)), so the high word is not copied.
  RSH_K and ARSH_K emit both MRs.

The verifier accepts all of these sequences, and "copy then op on the copy"
is a common shape in compiler output.  c88da29b4d2c converted the other
operands of the RSH_X sequence and missed this one.

Should the fold be restricted to an allow-list of handlers known to read
only src2_reg/src2_reg_h and write all of dst, or should these handlers be
converted to src2_reg* as part of this fix?

This next part isn't introduced by this patch, but it is in the condition
being edited.  Two more preconditions seem to be missing, and both let the
fold drop work that the MOV must still do.

First, insn[i - 1].off is not checked.  Since 8ecf3c1dab1c, ALU and ALU64
MOV X with off 8/16/32 is a sign-extending move (EXTSB/EXTSH/SRAWI in the
BPF_MOV handler).  The fold replaces it with a plain register reference, so
"r2 = (s8)r1; r2 += r3" becomes:

  addc r2,r1,r3
  adde r2h,r1h,r3h

and the sign extension is lost.  The same happens for "w2 = (s16)w1;
w2 += w3".

Second, the fold does not check whether insn i is a jump target.  When it
folds, addrs[i] == addrs[i - 1], and jumps branch to addrs[i + 1 + off], so
a jump that skips the MOV lands on the folded instruction, which reads the
MOV's source:

    0: r2 = r5
    1: if r3 == 0 goto 3
    2: r2 = r1
    3: r2 += r4

When r3 == 0, the folded insn 3 computes r1 + r4 instead of r5 + r4.

Both cases make the JIT compute a value other than the one the verifier
tracked.  Since this patch is already tightening the condition, should it
also require insn[i - 1].off == 0 and skip the fold when insn i is a jump
target?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45063388022
--===============7795125532508836721==--

