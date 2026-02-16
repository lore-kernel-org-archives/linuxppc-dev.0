Return-Path: <linuxppc-dev+bounces-16879-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F7FE7BD83
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Feb 2026 10:50:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fF01L4NKxz2xlq;
	Mon, 16 Feb 2026 21:50:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771239046;
	cv=none; b=bIcdOLogtyEaJflk6RF+qXlmc13glVY7QGXqBJh5cPIVCzK8fBMhzoATV2sq42ldjiuvPQvhjfbhHA/5CpMfcbqnDLZ4Ody3+LTwFa0GiVD2Aad2m7tuBVr/H5Agp8TdOHkc4YhPjKpZqgrWXYqxaTHjZCogil0bLvIM7lysm+Fx/UgrlGwXvLplpCibls0JXUW54acnizDg97mLcCITFUNyH+V3GifQzOr6vZCQDidXDoV8k80BxpXyzZXce/8/HfBJAPpAj+yOKrEI11NjHCjbnRLxthj/9J5IvMWFKqGLvD7zg959LIYoUqRcjMWRAaqMnY0RCLR1f6pqJLhznA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771239046; c=relaxed/relaxed;
	bh=9JKoT9v9/NwXwx27eTaKiz7MurJHQ3YVD1G0KrITcm4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LZxzcZ3If5ORh8jKOdz5muZOM4GF0s4qhCYabVTnVQSz2WMB1ud0X56iReCGXIw1rG/bYHdBeSjGp6ZrIuVpEdoWGTY5oamwR/5e2jlCV225wz6rMseyjHcON/hYXY5F2Yiz4DACerE0sHF0pxmQ++EOIceY+uftQmnPZYlaBk2vonHdbpo7jbMHWx4Io9vclBhrpDNT7/qbEzp9NeggmtJX/Ad64UwUyLQip6knXL7HQsTxiauaYBQEkEuwocFMMjc3S04OfYqXl0J5smmFGasBm+2QuYC+dI7ARhmqaBjNe01Md1wZkEV5b7NO/H2GaTEGGvGZLE8mkFxQvdixEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bBMTW5zK; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bBMTW5zK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fF01K2RxFz2xN4
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2026 21:50:45 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2BC62442E5;
	Mon, 16 Feb 2026 10:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B56C116C6;
	Mon, 16 Feb 2026 10:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771239042;
	bh=SlCa7iijd6YimdLQ8812y/Spgl/WvF8IFqOjV1zktiA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=bBMTW5zK5+cv4R3scVjmm91cPOGj1uakO+y+KT0nLKB+NlBO1KTXMMoCft3+rmV9T
	 Hja1V+HxZs5RYWjJMFyRmat/5TlBgZRgeeFQAjcotLKCdhTvxg4NvlvHnIKJ3AdHRO
	 Ppkr1LIOUi5xWpMCatwwPt2kYUCtpqiQs2BBQ8e3+uXBk3l7A3CChJtuqRDspa4ebV
	 lBYq9nfZe2MsB8jEPqJMNEodyVKmysipBt6iQOIrNPOFsrwwSZJloS+vLVAMt6YMOl
	 mjcXzayNvKN1eQ9N6D6QeNCTI2Rh637ZK1jFXWejWgpCr77uLU7EjyUhRUNUF9LKE+
	 g+zFB/WJnwI+A==
Content-Type: multipart/mixed; boundary="===============3828383631417245113=="
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
Message-Id: <0263fb1687612da60c26fc7ab569190aa94e7d6f9b3ebd23b80b4bbf7751c27e@mail.kernel.org>
In-Reply-To: <20260216152234.36632-1-adubey@linux.ibm.com>
References: <20260216152234.36632-1-adubey@linux.ibm.com>
Subject: Re: [PATCH 1/2] powerpc64/bpf: Implement JIT support for private stack
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev,chleroy@kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 16 Feb 2026 10:50:41 +0000 (UTC)

--===============3828383631417245113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c

[ ... ]

> @@ -140,6 +173,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  	struct codegen_context cgctx;
>  	int pass;
>  	int flen;
> +	int priv_stack_alloc_size;
> +	void __percpu *priv_stack_ptr = NULL;
>  	struct bpf_binary_header *fhdr = NULL;
>  	struct bpf_binary_header *hdr = NULL;
>  	struct bpf_prog *org_fp = fp;

[ ... ]

>  	}
>
> +	if (!priv_stack_ptr && fp->aux->jits_use_priv_stack) {

On extra_pass (when jit_data->addrs is non-NULL), the local
priv_stack_ptr is still NULL because it was initialized to NULL above
and is never loaded from fp->aux->priv_stack_ptr. This means the
allocation will happen again on extra_pass, leaking the per-CPU
memory allocated during the first pass and overwriting
fp->aux->priv_stack_ptr with the new allocation.

Both the x86 and arm64 implementations load the existing pointer
before this check:

arch/x86/net/bpf_jit_comp.c:bpf_int_jit_compile() {
    ...
    priv_stack_ptr = prog->aux->priv_stack_ptr;
    if (!priv_stack_ptr && prog->aux->jits_use_priv_stack) {
    ...
}

arch/arm64/net/bpf_jit_comp.c:bpf_int_jit_compile() {
    ...
    priv_stack_ptr = prog->aux->priv_stack_ptr;
    if (!priv_stack_ptr && prog->aux->jits_use_priv_stack) {
    ...
}

Is this missing a similar assignment before the check?

> +		priv_stack_alloc_size = round_up(fp->aux->stack_depth, 16) +
> +							2 * PRIV_STACK_GUARD_SZ;
> +		priv_stack_ptr = __alloc_percpu_gfp(priv_stack_alloc_size, 16, GFP_KERNEL);
> +		if (!priv_stack_ptr) {
> +			fp = org_fp;
> +			goto out_priv_stack;
> +		}
> +
> +		priv_stack_init_guard(priv_stack_ptr, priv_stack_alloc_size);
> +		fp->aux->priv_stack_ptr = priv_stack_ptr;
> +	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22059200816

AI-authorship-score: low
AI-authorship-explanation: The code shows human copy-and-adapt patterns from existing x86/arm64 implementations, with a characteristic human omission bug and copied pre-existing typo, inconsistent with typical AI code generation.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: Per-CPU memory leak on extra_pass in bpf_int_jit_compile due to missing load of existing priv_stack_ptr from fp->aux before allocation check, affecting programs with subprogs using private stack on powerpc64.

--===============3828383631417245113==--

