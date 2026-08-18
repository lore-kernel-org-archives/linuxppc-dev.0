Return-Path: <linuxppc-dev+bounces-25955-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F5CC5DF74
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 05:32:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPJHd0Cfdz2xrC;
	Tue, 18 Aug 2026 15:32:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787031148;
	cv=none; b=VM6T9SC4FjdLNXg5ThKCYp7dchsoNTbzuTf1ALP/nqxRuQpaU9/iNo5nA8aSoVLkWLSYxgattFvvwJI4AHDDTirvPF9GWuk3VTrIjh4GdpoLhNG9gpZ9zIp9QUB63c0ixCVGIg807QloVeKDXh5vbFJ8cauc+2GFPheLQS3FECBlE5/kZBDRb1xBerRqY8nNTlbJIfBpL2L9v0Wf7HX0bQJBXIUTBOVLQHIXeP2tptjfEcja2NxrFNps9LmUp84pVIaP89GIOqtKXNvi0ltxfppGF/UjFEV94i4+1Y44mKD7FAYd6PJ8y6zeu4XfT0utdvxoVUAYXQE/3d4QPFci7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787031148; c=relaxed/relaxed;
	bh=T8RxXeGn8bAp2KUhS5P+i/rDx0NmqjAw4E/pv4YyWsE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=b1oo/xTs7tP/qIr2AANC7Ifp5vK0A2U7PDm6D7/IT69H70KFZEGucg4UuH02en42/Z0vUxmyapU3quleNfakz+BCF6xu0jGRHdoSyN8eb/3YUZmWJyhbkpUQKL9UBBsFRbK+Z0ajHu66CaFJlpfMESMediy1p5G0Cm0i8Bk0X9axg0t7QBV4c3zpnPGJZjxz7cwo2phl2PWvyaFWw47uVgevMzJwxcalIv7jCyAeumGW8DuV9rpSNB6WrNBvG9KxVndjAVwxngA2xcDMygEeUxfX4Uswh+n6/DIuIFoeqXnlWU4UBpVLn+RAVdQ9JXGDqkQANUSJxKOGDtdbIKfE7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pr3/w8cc; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pr3/w8cc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPJHc1XJQz2ySm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 15:32:28 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 55F9560204;
	Tue, 18 Aug 2026 05:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345441F000E9;
	Tue, 18 Aug 2026 05:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787031146;
	bh=T8RxXeGn8bAp2KUhS5P+i/rDx0NmqjAw4E/pv4YyWsE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Pr3/w8ccIwKtOepmlA7sJNZw0eL3UbfPy4JWbq0JFPj6ZZiyRA3+IQYGV7ryn5Q4c
	 J3hyiaSOt4MhhoYG3KdIAizb8JW87+bPDwrIfbixF669L0HMTG70TDEPXGqUjYtNq5
	 vMf4jtWGWTPHbT/4nueDV6AikzGkidlBSF+bjbXXEH/qUzlkItyYmLD5abblFC4ZXQ
	 o4SVBlzaDJOA+O+70ESvkMgBX45ICqeeLBFbWzesmvBITf0qwQvm6kKGTWkJV1sALH
	 I9Uly0yIEYCQqmsPo13jDnie+3DDFYVraou/+9Eq39laZ5A9VzKtRgJwZG7JKuAZxE
	 WSYIleUyx4k1w==
Content-Type: multipart/mixed; boundary="===============0559593494344673386=="
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
Message-Id: <4157135143a92751c2292e12dcb1c13e027211442d73796564fa0936646ac138@mail.kernel.org>
In-Reply-To: <0a70cdb21d953c55cd2b39a1754190d7542af165.1787027080.git.skb99@linux.ibm.com>
References: <0a70cdb21d953c55cd2b39a1754190d7542af165.1787027080.git.skb99@linux.ibm.com>
Subject: Re: [PATCH v12 8/8] selftests/bpf: Add tailcall verifier selftest for powerpc64
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,venkat88@linux.ibm.com,yeswanth@linux.ibm.com,skb99@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 18 Aug 2026 05:32:25 +0000 (UTC)

--===============0559593494344673386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> index 48fa34d2959f..880c4636b000 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> @@ -91,6 +91,82 @@ __jited("	popq	%rax")
>  __jited("	jmp	{{.*}}")		/* jump to tail call tgt   */
>  __jited("L0:	leave")
>  __jited("	{{(retq|jmp	0x)}}")		/* return or jump to rethunk */
> +__arch_powerpc64
> +/* program entry for main(), regular function prologue */
> +__jited("	nop")
> +__jited("...")                          /* ld 2, 16(13) absent with CONFIG_PPC_KERNEL_PCREL */
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
> +__jited("	mtctr 12")

Does 'mtctr 12' work on ELF ABIv1 configurations?

Looking at bpf_jit_emit_func_call_rel(), the JIT only loads the target
into r12 on ELFv2; on CONFIG_PPC64_ELF_ABI_V1 it materializes the
function-descriptor address into TMP_REG_2 (r10), then does 'ld 9, 0(10)'
and 'mtctr 9', so the CTR load reads 'mtctr 9' there:

arch/powerpc/net/bpf_jit_comp64.c:bpf_jit_emit_func_call_rel() {
    if (PPC_ELF_ABI_V1) {
        ...
        EMIT(PPC_RAW_LD(_R9, TMP_REG_2, 0));  /* ld 9, 0(10) */
        EMIT(PPC_RAW_MTCTR(_R9));             /* mtctr 9 */
    } else {
        ...
        EMIT(PPC_RAW_MTCTR(_R12));            /* mtctr 12 */
    }
}

test_loader.c:get_current_arch() returns ARCH_POWERPC64 for any
__powerpc64__ build regardless of ABI, so a big-endian ABIv1 kernel would
run this block and see a mismatch.

If ABIv1 builds are out of scope for this test, would wildcarding the CTR
register make the line ABI-agnostic?

> +__jited("	bctrl")
> +__jited("	mr	8, 3")
> +__jited("	li 8, 0")
> +__jited("	addi 1, 1, {{.*}}")

[ ... ]

> +/* subprogram entry for sub() */
> +__jited("	nop")
> +__jited("...")                          /* ld 2, 16(13) absent with CONFIG_PPC_KERNEL_PCREL */
> +/* tail call prologue for subprogram */
> +__jited("	ld 10, 0(1)")
> +__jited("	ld 9, -8(10)")
> +__jited("	cmpldi	9, 33")
> +__jited("	bt	{{.*}}, {{.*}}")
> +__jited("	addi 9, 10, -8")
> +__jited("	std 9, -8(1)")

Should the '/* tail call prologue for subprogram */' comment end here?

The comment heading covers the next 15 lines, but only the first 6 lines
(ld 10,0(1) through std 9,-8(1)) come from the is_subprog branch of
bpf_jit_build_prologue(). The lines that follow are:

- Lines 136-140 (lis / sldi / oris / ori / li) are ordinary body
  instructions for 'r2 = jmp_table ll' and 'r3 = 0'

- Lines 141-144 (lwz / slwi / cmplw / bf 0) are already the first block of
  bpf_jit_emit_tail_call() - the 'index >= array->map.max_entries' check -
  which sits above the '/* bpf_tail_call implementation */' heading

A reader using the comment to map expectations onto JIT functions would be
misdirected for 9 of the 15 lines.

> +__jited("	lis {{.*}}, {{.*}}")
> +__jited("	sldi {{.*}}, {{.*}}, 32")
> +__jited("	oris {{.*}}, {{.*}}, {{.*}}")
> +__jited("	ori {{.*}}, {{.*}}, {{.*}}")

Does this fixed four-instruction sequence match what PPC_LI64 actually
emits?

These lines hardcode a fixed expansion (lis / sldi / oris / ori) for the
'r2 = jmp_table ll' map-pointer materialization in sub(), but the ppc64
JIT emits PPC_LI64() there, whose length and shape depend on the runtime
value of the pointer:

arch/powerpc/net/bpf_jit.h:PPC_LI64(d, i) {
    if (!((uintptr_t)(i) & 0xffff800000000000ULL))
        EMIT(PPC_RAW_LI(d, ((uintptr_t)(i) >> 32) & 0xffff));
    else {
        EMIT(PPC_RAW_LIS(d, ((uintptr_t)(i) >> 48)));
        if ((uintptr_t)(i) & 0x0000ffff00000000ULL)
            EMIT(PPC_RAW_ORI(d, d, ((uintptr_t)(i) >> 32) & 0xffff));
    }
    EMIT(PPC_RAW_SLDI(d, d, 32));
    if ((uintptr_t)(i) & 0x00000000ffff0000ULL)
        EMIT(PPC_RAW_ORIS(d, d, ((uintptr_t)(i) >> 16) & 0xffff));
    if ((uintptr_t)(i) & 0x000000000000ffffULL)
        EMIT(PPC_RAW_ORI(d, d, (uintptr_t)(i) & 0xffff));
}

The immediate here is the struct bpf_map * returned by
__bpf_map_area_alloc() (kernel/bpf/syscall.c:372), which for a small map
takes the kmalloc_node() path and therefore lives in the linear map at
0xc000000000000000 | pa.

Bits 47:32 of that address are pa[47:32]. On any ppc64 machine where the
allocation lands at a physical address >= 4 GiB - routine on a box with
more than 4 GiB of RAM - PPC_LI64 emits an extra 'ori d, d, <pa[47:32]>'
between the lis and the sldi.

Because consecutive non-"..." __jited() patterns are pushed with
on_next_line = true (test_loader.c:push_disasm_msg), validate_msgs()
enforces prev_match->line + 1 == match->line and the test fails with
'expected next match: "\tsldi ..." ... WRONG LINE'. Conversely, an
allocation that happens to be 64 KiB aligned drops the trailing 'ori' and
the line-139 pattern fails to match at all.

Would the address-dependent part of this sequence need the same '...'
treatment already used for the call-target materialization in main(), for
example keeping 'lis' and the terminal 'li {{.*}}, 0' as anchors and
wildcarding what is between them?

> +__jited("	li {{.*}}, 0")
> +__jited("	lwz 9, {{.*}}({{.*}})")
> +__jited("	slwi {{.*}}, {{.*}}, 0")
> +__jited("	cmplw	{{.*}}, 9")
> +__jited("	bf	0, {{.*}}")
> +/* bpf_tail_call implementation */
> +__jited("	ld 9, -8(1)")

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32100929603
--===============0559593494344673386==--

