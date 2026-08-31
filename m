Return-Path: <linuxppc-dev+bounces-26253-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CC4C624A5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 08:12:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYMDT1Fq9z2yps;
	Mon, 31 Aug 2026 18:12:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788163961;
	cv=none; b=VdIH2peTmIFWP9y8xb+mLO6DA/O+ijftF4knGoSLZJN55E7QtDtw5aKBrLNiAV29EYnJxrALjO0S/IVF3b0X3J6t7rsH+2ExE2dwPcM9fDt4eZnFvzIx1NG2/IGWIVSMtUEYw+Bx7TtBvKeJJ+q7gcrXISjFidf6SsX46JT1RG9vwQ0t33QyyhTmE/LmOFjBFljHX7wmJPt87vOzHrgd3tn3rcTRhn3Q4BowG+ApEIFCb/Yn98LoYtcy+2uQgBb7Ct4GJpKahTZ7THVG9DPqGxKBLhE+n+J9t3xuvX02WN09tPv8KD1JurOcx+okNP2VvwPOleXTBsE6FOfuMGCtpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788163961; c=relaxed/relaxed;
	bh=mxaD1aN/r9kM1YvzylFDxbR38xtnHNx6b1PVq1CwqVY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Gqbwj0C9Uo4oDbpEehOXSIMqdqle5hTjSrJQXh6qjz4rQjNugzzSFmNu4FbiiXiKQuJh7Ru0JZVnbzIPHTyMjSJaLDIiHT6J6lMDRsBwcPesV2pxKIVGqsszUzq55vTgPvpMY0+vqk9owpnHXbRt1eu85UYEC81oKkeOTH4y7v7WtUf1v93TXITmUbfL/31vmnUavmFB7TMnNMWvfWDaggzKIA4pvApH+cWMEkm072/SwJXf8hD8ev+STKAKPVfjIn2oPQqRb7k1NCM8WM5IX+fTx7ArcHFvndqQGPIOVYtNjfAp7MX53L40FrDkhELJ46FIQLSnrL4WG8KKbpYjOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hXRqMvPf; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hXRqMvPf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYMDS0Y89z2yfH
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 18:12:40 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 02F14601DB;
	Mon, 31 Aug 2026 08:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F811F000E9;
	Mon, 31 Aug 2026 08:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788163957;
	bh=mxaD1aN/r9kM1YvzylFDxbR38xtnHNx6b1PVq1CwqVY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hXRqMvPfKn/5jeO/eRGALKDRNhrU5a0N97hgnfp9JQ5Bpl1OwoVQleV9kss42aTyO
	 wLsPgWVpdfodSM12rsTjWvPmWJIVdu6be0cTregMNbYq7Ds/a6Xo9D67BQr5CabBNY
	 CBCM2k220f6hwM2vL927Cf1SS62bWImRaVJuRi1WisLlcs3elfHQDXupE//ccWRa1W
	 mFLEw3jbWO+wJ+gPlnkMNEDaQrc+0cfv78K06FaX03EMPPgcReIOiXhjDi+t2FLDCi
	 8+XkYSlV0xZAzHHfa6Q1IO3MYirE4CZ3ZV2Oog/5ogodSZlMzu3kNzpySaIVpqM8kv
	 fn7Rv7y5a/udg==
Content-Type: multipart/mixed; boundary="===============5025744068711041007=="
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
Message-Id: <dc68ecf3e7f2f451cedb579967d136e2c8619ad13c3c5d004f931c65ca0610bf@mail.kernel.org>
In-Reply-To: <b11a7ad9ecf1dd7f6524067f061b4f7dabeff1d9.1788154635.git.skb99@linux.ibm.com>
References: <b11a7ad9ecf1dd7f6524067f061b4f7dabeff1d9.1788154635.git.skb99@linux.ibm.com>
Subject: Re: [PATCH v13 8/8] selftests/bpf: Add tailcall verifier selftest for powerpc64
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,venkat88@linux.ibm.com,yeswanth@linux.ibm.com,skb99@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 08:12:36 +0000 (UTC)

--===============5025744068711041007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> index 48fa34d2959f4..9880ce4f1931a 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> @@ -91,6 +91,84 @@ __jited("	popq	%rax")
>  __jited("	jmp	{{.*}}")		/* jump to tail call tgt   */
>  __jited("L0:	leave")
>  __jited("	{{(retq|jmp	0x)}}")		/* return or jump to rethunk */
> +__arch_powerpc64
> +/* program entry for main(), regular function prologue */
> +__jited("	nop")

Will this test work on CONFIG_PPC64_ELF_ABI_V1 builds? On big-endian ppc64
kernels, arch/powerpc/net/bpf_jit_comp.c prepends a 24-byte function
descriptor to the JIT image:

#ifdef CONFIG_PPC64_ELF_ABI_V1
        /* Function descriptor nastiness: Address + TOC */
        ((u64 *)image)[0] = (u64)fcode_base;
        ((u64 *)image)[1] = local_paca->kernel_toc;
#endif
        fp->bpf_func = (void *)fimage;
        fp->jited_len = cgctx.idx * 4 + FUNCTION_DESCR_SIZE;

and bpf_prog_get_info_by_fd() copies jited_len bytes starting at
prog->bpf_func. The disassembler then receives those 24 descriptor bytes as
if they were instructions. The low half of a typical kernel_toc address
such as 0xc000000001b70000 decodes from primary opcode 0, which is illegal,
causing disasm_insn() to call PRINT_FAIL("Can't disasm instruction...") and
fail the test.

The companion commit 9e3a62e5e00a6 truncates the trailing 8 bytes for this
reason, but nothing strips the leading descriptor. Should the test be
restricted to ELFv2, or should jit_disasm_helpers.c skip
FUNCTION_DESCR_SIZE at the head of each function on ppc64 ELFv1?

> +__jited("...")                          /* ld 2, 16(13) absent with CONFIG_PPC_KERNEL_PCREL */

Is this comment accurate? The TOC load is guarded by both conditions:

#ifndef CONFIG_PPC_KERNEL_PCREL
        if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2))
                EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)));
#endif

so it is also absent on CONFIG_PPC64_ELF_ABI_V1 builds.

Also, is the displacement always 16? The offsetof(struct paca_struct,
kernel_toc) is 16 only when CONFIG_PPC_PSERIES=y, because the leading
'struct lppaca *lppaca_ptr' member is inside '#ifdef CONFIG_PPC_PSERIES'.
Without PSERIES the offset is 8, giving 'ld 2, 8(13)'.

> +__jited("	li 9, 0")
> +__jited("	std 9, -8(1)")
> +__jited("	mflr 0")
> +__jited("	std 0, 16(1)")
> +__jited("	stdu 1, {{.*}}(1)")
> +/*
> + * load address and call sub() via count register
> + *
> + * Address materialization differs between PCREL and non-PCREL kernels.
> + * Skip the address generation sequence and verify only that the call
> + * target is loaded into CTR before branching.
> + */
> +__jited("...")
> +__jited("...")
> +__jited("...")
> +__jited("...")
> +__jited("...")
> +__jited("...")

Does the framework need six consecutive '...' entries? In
tools/testing/selftests/bpf/test_loader.c, the push_disasm_msg()
function handles '...' by setting on_next_line = false and returning
immediately without pushing a pattern:

if (strcmp(regex_str, "...") == 0) {
        *on_next_line = false;
        return 0;
}

So '...' pushes no pattern at all; it only clears the on_next_line flag
for the following real pattern, which then matches anywhere later in the
log. Consecutive '...' entries are idempotent. These six lines behave
identically to a single '...', and five of them are dead. The comment
describes skipping 6 instructions, but the framework doesn't implement
per-line skips this way.

> +__jited("	mtctr {{.*}}")

[ ... ]

> +__jited("...")
> +__jited("func #1")
> +/* subprogram entry for sub() */
> +__jited("	nop")
> +__jited("...")                          /* ld 2, 16(13) absent with CONFIG_PPC_KERNEL_PCREL */

This comment is repeated verbatim from the main() prologue and has the same
issues: the TOC load is also absent on ELFv1, and the displacement varies
with CONFIG_PPC_PSERIES.

> +/* tail call prologue for subprogram */
> +__jited("	ld 10, 0(1)")
> +__jited("	ld 9, -8(10)")
> +__jited("	cmpldi	9, 33")
> +__jited("	bt	{{.*}}, {{.*}}")
> +__jited("	addi 9, 10, -8")
> +__jited("	std 9, -8(1)")
> +__jited("	lis {{.*}}, {{.*}}")
> +__jited("	sldi {{.*}}, {{.*}}, 32")
> +__jited("	oris {{.*}}, {{.*}}, {{.*}}")
> +__jited("	ori {{.*}}, {{.*}}, {{.*}}")

Will this lis/sldi/oris/ori sequence always appear in exactly this form?
PPC_LI64() in arch/powerpc/net/bpf_jit.h emits between 2 and 5
instructions, conditionally, based on the runtime value:

EMIT(PPC_RAW_LIS(d, (uintptr_t)(i) >> 48));
if ((uintptr_t)(i) & 0x0000ffff00000000ULL)
        EMIT(PPC_RAW_ORI(d, d, ((uintptr_t)(i) >> 32) & 0xffff));
EMIT(PPC_RAW_SLDI(d, d, 32));
if ((uintptr_t)(i) & 0x00000000ffff0000ULL)
        EMIT(PPC_RAW_ORIS(d, d, ((uintptr_t)(i) >> 16) & 0xffff));
if ((uintptr_t)(i) & 0x000000000000ffffULL)
        EMIT(PPC_RAW_ORI(d, d, (uintptr_t)(i) & 0xffff));

Each of these four patterns follows a non-'...' pattern, so test_loader.c
sets on_next_line=true and requires strict line adjacency. The verifier
rewrites BPF_LD_IMM64 to the kernel address of the kvzalloc()'d 'struct
bpf_array', which is a linear-map address 0xc000000000000000 + physaddr.
When that object lands above the 4 GiB boundary (routine with >4 GiB RAM),
PPC_LI64() emits an extra 'ori' between 'lis' and 'sldi', and the 'sldi'
pattern then matches one line late, causing validate_msgs() to report
WRONG LINE.

Symmetrically, a 64 KiB-aligned map address drops the trailing 'ori', and a
map whose bits 16..31 are zero drops the 'oris', both producing
EXPECTED/no-match failures. The test already recognizes this problem for
the call-target address (the comment about PCREL vs non-PCREL address
materialization plus '...' wildcards). Should the map-address
materialization use a single '__jited("...")' instead?

> +__jited("	li {{.*}}, 0")
> +__jited("	lwz 9, {{.*}}({{.*}})")

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33368376983
--===============5025744068711041007==--

