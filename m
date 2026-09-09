Return-Path: <linuxppc-dev+bounces-26984-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3E2C79FB7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 16:35:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg5y809Xlz2yyJ;
	Thu, 10 Sep 2026 02:35:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1134" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788971711;
	cv=pass; b=VRzBSi3EeG58xHoZI1lERoWr5pea1/AoMYIDiLZ7RKsXqB98JaidszsztHPybrt0Q+BojVikpfg69nsxAr+Ug/4+9ONJxti5jjeiI+pOe5QrfnFTfU9Jwd2xPKntG4v2Ye8p3REnuGWRWRMhf1Gvq/BGoj2gZb7qzFoTzLmbcJBeAbnkOzkwShLdBuKaZuCQ3p0kKVs8olIRJAdz6i22jjEKkC9smRN/S7DTFCYLDXoeuqPzdPzOlbGKOr0aLCYiktMXCZWfLWJRSUiDgN6B+DIID0mOVX0mivAw39wfehlTrRsCZ/iBq0fCIL4B9SuyGrb6kAvx9XEX3IJVtRw/ow==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788971711; c=relaxed/relaxed;
	bh=AurL6CS51ZxhuGokqtXHBRLRcchDPoQ4/ZSuDu7JVek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOgd/eHiDmjcC9OyCSFN0cYyD6ft8YJ3f/Nq+A2R+JCDwP90sIhORizXGfxKyDDYYRTcWKcXaBf9DVTlk8TSZyOrEv0AOknedW7zQJEwiOMzoZlceSLV5CT18tsgxAXE5oW762kIlaL9exxWeO/llKp8NqS+RQPAvmtTqvPxbNPywZ+wuAZPeLwP0wRm5Cdm1HPW3w2caOLyIPQVQTn43tDl32JIKLJpwj5Vrhw2QtUqMTbDzYl0ZjdVezlDjoVQqp8Fnhz5OkIOXjRjtJpjKm52TQga+URhyCx65H5Pl5/aX6VjC6fo9AisgVtWW9MWPDrQKx4cvVVT9/MMs5GHVQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h8YOEnc+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com; envelope-from=sidchintamaneni@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h8YOEnc+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com; envelope-from=sidchintamaneni@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg5y60FM0z2yxl
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 02:35:08 +1000 (AEST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-87ffa98d4a9so11308237b3.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 09:35:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788971705; cv=none;
        d=google.com; s=arc-20260327;
        b=DicESbpQguEl2Lu5sl0peOpkhYMnJphkUN7UMmEUCTX119JBsKhPTfqVdtCBbjrCF7
         b65EXQE/npnak959FuHFya8qu1xhliGQ42BbPzvQ5HwhaspXG3kZNz455UpknNgkASVC
         mF2VNw+qSmrPk0ILWYKtuAR+hN0jrQ1+/XybamZDi5DgUh31MQBEVbC3+GrT6Uv6QuUm
         lYNY2QqmN+IlVYf2jBVHpEcY3FKWzE0e7pHof0WBf0GZ7oC4etlE1/e544FjHa81W9yD
         d26CJ9TmPUS3ljPUQq4bBfqyBDEdwsBdRIspuqOPTFfKhiOjR3cuknB3cT3cHa8FCWHZ
         d4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AurL6CS51ZxhuGokqtXHBRLRcchDPoQ4/ZSuDu7JVek=;
        fh=qUWYbrReqKHHOpI6yWmF8CDmwcNvXmWp/68POGlbJTc=;
        b=FVG3+dZ3V0OJxweLfsoWcjSkKRW1fbs1FDQLuJCY0CgpM8ue0fC12mQmpLPUlk861L
         b1NQt2P/OgGUPQyLPfpFd8hKZ5qi/DPvhKfU6LMjxZcuHtbzpNTIWMOub8W/RbMfVPBo
         AnEcCRHQdnGWSpE+jRZytWizVg4jOGGJbQRANgDdhwcAdTZbJt+qKgcddA6IqJyiqWtV
         FqZvDxI01B3ARmlk17Es+WAMYANt6niF+CAiHCiwIKHQFNnZe/n8MSGNSZLVNXvI/Teo
         8TBr1jDviFuWDggNYMWQyoJuxAnEtBdZqSKnobM0tWMjv1Cyy8D4fnqcgL9iheze81yj
         keOw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788971705; x=1789576505; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AurL6CS51ZxhuGokqtXHBRLRcchDPoQ4/ZSuDu7JVek=;
        b=h8YOEnc+EC98B957DTiAL95kju7MuhVp7o3+9+JBzBIqr7UGSzqotB6Nr1/lh9MllW
         DU15HdEX08WHK72+Q8k0u832/ikmdNyukF8g3IwSbCYF+0NYRRBvOvx6cX1u8uwR9VTV
         CC1wam+csEMjre4RXNAh7pSzgLYzNVX2CPIqJ/lSZtlo/Lv2MGlhQmAMJt5ON+QGGeHy
         0khuYRany0NhCV+uvDgcPvzuVeDi7bzQW9S7AquZQ9J8FCKV4gVYXF57Gp4DJB07RQB2
         xFyDFTQHfTM9JMu30rxFojomugd/Huhu5FEJGws2TkQHUmZ37pYKNL7U7+c4r6+B9Mag
         J1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788971705; x=1789576505;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AurL6CS51ZxhuGokqtXHBRLRcchDPoQ4/ZSuDu7JVek=;
        b=LxJ2GO2vsmIOYs8hmYlTipeiVi7RI4tnCLgSF1kjWNE+2Anf1BvvP7wdMdH5G2mpc+
         xYJVK0JxBx305d26gbIknri8f/DIlEBp777fQjRM8PdV1uMS7On05y/05bVG6n5XYZvl
         qxT6IHpFgeZnFoSOC2X7pQqih3xNZXwkT5Dr1eNAl+OAupUcFucGSdLyCEfDGWFPvZEl
         MvP9DzeL4nqtbHUKU6WXsdQOeAgaTXB4/6A4RVgYRzY2iQTNpaSuwLvg4a+3myO+eQ04
         48e6Z7y86jqwMGxYB27D+thhKgX7SaiS3RsCTTYTw7H/FRFGA95xGOWtG0c9R9TtCO4R
         nItA==
X-Forwarded-Encrypted: i=1; AKwUvBx0kNUpfX2PAGehesCBU7gk8O4dSfdWwi9dmYvcit0J8w86zeWzzbchfAvrWiT9MYpZANJTObPHK5Rv94E=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mUWCLUKy8F/wvlK96BNdJvtvZAgmLQM1DDlpm4NBdvIc3/VS8z
	MBhuAmdHATqIEdtYrGqpM/BzKLurL5yLrU3HtJ3n7isXw9nPzGn6IYsDOwVbfBACA0eXwNFopLt
	ztRKwRa0kCtWWP4VNLIbiThUwOu/qFiM=
X-Gm-Gg: AYBFou32cAEk55kTHRiV6yfK4/+NaKQdXOPajIvv06CJF+ohnf4WL4SHhaQcX1OPxzr
	e14sOf0hIVpj5ZUEbT74E5yuGrK8pcokwPtlK/xk7WGQOpdqyf4VZEVUrURPFdlxn1+IsqLq+7o
	uKxk1asygU4i0Vt+EwbPWDZGHda8gN0qor/70OWjmjwkeqc1wYEmSSoPCeFvX7mhlWUtEHuBcBl
	1h/dzE8/stgD68gA1DD46wZd4W3M2aoP0yRck0myuSvnXvtc6+Dv2qILWaTBTKGmmK6h78S822y
	31hkQ6V/QccshBc8H1VnTazPsnbgdPzqNFtgDEaGLEzFnZMXlvG/usV/5DT05mLmcBeZWFUzmos
	8Z1QY+DlaX++HO9tD9/fO2/6oj4jF+pOyvwFWlW+av4vQkcog2B0TPuzOpDx2Wis7eTO+bqhHYH
	c3nEBPU8X6wFn0rnBUBZrbASY=
X-Received: by 2002:a05:690c:c622:b0:86f:6c64:7eb7 with SMTP id
 00721157ae682-87122599769mr119770507b3.1.1788971705167; Wed, 09 Sep 2026
 09:35:05 -0700 (PDT)
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
References: <20260904195132.141068-3-sidchintamaneni@gmail.com> <4866144aa416a8491c9874325394e88f5dc2e66259212baa56032e0428f0772b@mail.kernel.org>
In-Reply-To: <4866144aa416a8491c9874325394e88f5dc2e66259212baa56032e0428f0772b@mail.kernel.org>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Wed, 9 Sep 2026 09:34:53 -0700
X-Gm-Features: AcwNN1WCeNCqyff3VAuQjYBnYtHIwccOam8Qp1LEGjFOZzxZQ1VjRoRu1i5QAcI
Message-ID: <CAE5sdEhdsPvK8UD-SEZ=YNX5_GpHkUV8mivRW1j=6hJ6XkM7Zw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/7] bpf, x86: Use resolved pointer for timed may_goto
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, jeremy.jean@oss.cyber.gouv.fr, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, a.s.protopopov@gmail.com, puranjay@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-riscv@lists.infradead.org, rlmenge@gmail.com, 
	hargar@linux.microsoft.com, apais@microsoft.com, martin.lau@kernel.org, 
	mason@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Sept 2026 at 13:33, <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/arch/x86/net/bpf_timed_may_goto.S b/arch/x86/net/bpf_timed_may_goto.S
> > index 54c690cae190..6e9d9e7c2b1d 100644
> > --- a/arch/x86/net/bpf_timed_may_goto.S
> > +++ b/arch/x86/net/bpf_timed_may_goto.S
> > @@ -11,12 +11,6 @@
> >  SYM_FUNC_START(arch_bpf_timed_may_goto)
> >       ANNOTATE_NOENDBR
> >
> > -     /*
> > -      * r10 passes us stack depth, load the pointer to count and timestamp
> > -      * into r10 by adding it to BPF frame pointer.
> > -      */
> > -     leaq (%rbp, %r10, 1), %r10
> > -
>
> A subsystem pattern flags this as potentially concerning: This commit
> changes the x86 trampoline to the new 'pointer in BPF_REG_AX' ABI, but the
> producer side of that ABI was changed one commit earlier, in d8319a04dafc
> ("bpf: Fix timed may_goto stack pointer for private stacks"), which
> rewrote kernel/bpf/fixups.c to emit:
>
>     insn_buf[4] = BPF_MOV64_REG(BPF_REG_AX, BPF_REG_FP);
>     insn_buf[5] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_AX, stack_off_cnt);
>
> At commit d8319a04dafc (i.e. HEAD~1), does x86 still execute
> 'leaq (%rbp, %r10, 1), %r10' on a register that already holds a resolved
> pointer, producing r10 = rbp + (frame_ptr + stack_off_cnt) -- roughly
> 2*rbp, a non-canonical address?
>
> bpf_check_timed_may_goto() then reads and writes p->timestamp / p->count
> through it (kernel/bpf/core.c:3410). Would any BPF program containing
> may_goto oops on x86_64 at that commit?
>
> The same window exists for arm64, riscv, powerpc64 and s390, whose
> trampolines are only converted in the four later commits d35642770d98,
> 7053db7d3c0d, 6e03227c5677 and 20356163d51e. Is the tree bisectable across
> the series?
>
> The two halves carry different Fixes: tags (this one 2fb761823ead, the
> fixups.c one e723608bf428), which invites a partial stable backport that
> reintroduces exactly this wild-pointer write. Would squashing the fixups.c
> ABI change with the arch trampoline updates, or ordering all arch updates
> before the generic change, address the bisectability concern?
>
> >       /* Setup frame. */
> >       pushq %rbp
> >       movq %rsp, %rbp
>

I tried to follow the same pattern used when the patches were
introduced, but this is a valid concern.
Should I just squash all the patches to one then?

> The x86-only __xlated expectations for the timed may_goto expansion in
> tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c were never
> updated for the new 7-insn -> 8-insn sequence. The test expects:
>
>     __xlated("7: if r12 == 0x0 goto pc+6")
>     __xlated("8: r12 -= 1")
>     __xlated("9: if r12 != 0x0 goto pc+2")
>     __xlated("10: r12 = -24")
>     __xlated("11: call unknown")
>     __xlated("12: *(u64 *)(r10 -24) = r12")
>

I've fixed this in the selftests patch.

> Does this test fail on x86_64 for the whole series? Every line from index
> 7 onward is now wrong: the first branch becomes 'goto pc+7' (insn->off + 6
> instead of insn->off + 5), the second becomes 'goto pc+3' instead of
> 'pc+2', 'r12 = -24' is replaced by the pair 'r12 = r10' / 'r12 += -24',
> and the trailing indices shift by one ('call unknown' at 12, the store at
> 13, then 14 and 15).
>
> git log 28bd77eb835b..8dc5c7d5340d shows the only selftest commit in the
> series is 8dc5c7d5340d ("selftests/bpf: Test timed may_goto with private
> stacks"), which adds new coverage but does not touch
> verifier_bpf_fastcall.c. Note the original x86 JIT enablement commit
> 2fb761823ead -- the commit this patch lists in its Fixes: tag -- adjusted
> this very test for the same reason, so the update belongs with the ABI
> change.
>
> > commit 28bd77eb835bc1a95190315e93afbc6bb186b9ff
> > Author: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> >
> >     bpf, x86: Use resolved pointer for timed may_goto
> >
> >     The timed may_goto fixup now passes the resolved counter pointer through
> >     BPF_REG_AX instead of a stack offset.
> >
> >     Use the pointer directly rather than adding it to RBP. This preserves the
> >     private-stack address selected by the JIT through R9.
> >
> >     Fixes: 2fb761823ead ("bpf, x86: Add x86 JIT support for timed may_goto")
>                  ^^^^^^^^^^^
>
> The existing Fixes: tag points to commit 2fb761823ead, which is not an
> ancestor of this fix and is on a different branch (bpf-next/res_spin_lock).
>

I'll fix this in the next iteration

> The bug was actually introduced by commit 47ab38f3f4d9 in this branch's
> history, which added the incorrect code 'leaq (%rbp, %r10, 1), %r10' that
> overwrites r10 instead of preserving it.
>
> Should this use:
>
>   Fixes: 47ab38f3f4d9 ("adding ci files")
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33914557238

