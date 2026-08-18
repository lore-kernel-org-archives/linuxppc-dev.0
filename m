Return-Path: <linuxppc-dev+bounces-25953-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3331EC5DF74
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 05:32:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPJHY3stKz2xxr;
	Tue, 18 Aug 2026 15:32:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787031145;
	cv=none; b=jbZvecVA43Qa+CuCDpuwjOJ1LaSwL0o5fYAPECnP+M55SaXc29nj13/SH9L4oDZK+A+8cB7ju6COscxOGUSREhS43Bml1Qlu2LPVbQQt0L4AD4iN1Ys6PZ8f8yddY5x1FDblyukxpSw8HsEBji3yZo2TgEPFRknFRUUFeORWJbzxH11E5ykqRxo9hpe9Vo1SXbJJxbgdIAHA5jpAcH282qIfbXlo/Tzki9DREBFU1vnjwSWCAJSreasxXu22A1j4mOdW+NBROBkEx4wBltmQzRa2Jw8XgL5mKYpsFFxbyV4ueA3PZRJZ7e3zDCK5WL6EkJwLNEc6zNXbcTc4V7h/DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787031145; c=relaxed/relaxed;
	bh=9FMVXrty6AbTQ8HEy8w73hGEdOppBdD86P9xan4kkSk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lcqpKAC6O5qnSWtztWTaGUxIJ0/XNYWspggPBGmVkI9hn8BPTt7MFPhARROIhQshKYNL5cJSkmVqm8eH+0gR+NLc+ooWtYX8FDRRzgADNY8LGE60+WYLWTYR7WlghUf4UsSYDOdRvgBVEqaOmGK7Wb4RUl24JVVQ7up6yyF6Ah04XXmsAYSyb/gPmo+i54cTOArg/ciuk6ybf3DI2b/ZwSDRiRI73H5pGqEk+ibWF1LRZM277k6NLeLNXowBnt8IHFe+2uOanbb8zqWELyBPb0PQ/JGRtZQQSKa5bJKvLxnkaEK8j20D3H0iHm5azqsp65GarwpjAl1EuHAdKmEzYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m3tQkm2n; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m3tQkm2n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPJHX3HZcz2xrC
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 15:32:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EE60840A37;
	Tue, 18 Aug 2026 05:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019F71F000E9;
	Tue, 18 Aug 2026 05:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787031141;
	bh=9FMVXrty6AbTQ8HEy8w73hGEdOppBdD86P9xan4kkSk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=m3tQkm2nrHHprSxp/ulKVGFZRosqWUvXNoInSMtajkZFEis3LXhD7Tg3Fvpvjutpj
	 jRfGuEEQjcdZfB/HJronIQ6V0Q1mWIWu+w7YnWt8BohCSP4Pm0Sw74OUEi5pQ/Angr
	 QmexXST1bhIoTRdrTAm/DOcVPCshLrneHkO24uI5/j5ShsLZVNkp6jXyGIB0/wOwbL
	 J/oYmn5vznzFQhcrGZPBPtj/NAxaViS4Wv7F0/gFQLyUALvZJ0K+tjdiQ9sa7EyImL
	 h3kny95AXE7Ij2PBLl+ZD9XuH/5KxJX4+NLBV/5V7A7y5+5FvjBqjuycKkbZImb1S/
	 e2SLr2eEDqi1Q==
Content-Type: multipart/mixed; boundary="===============5640435612391008903=="
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
Message-Id: <f6b6fdce69918619ab08600a81a10dc1b651cffd0621beeb0a62d992d01d51b7@mail.kernel.org>
In-Reply-To: <84fad8bf849e48ea156e3e598eed8136e42385ff.1787027080.git.skb99@linux.ibm.com>
References: <84fad8bf849e48ea156e3e598eed8136e42385ff.1787027080.git.skb99@linux.ibm.com>
Subject: Re: [PATCH v12 6/8] selftests/bpf: Fixing powerpc JIT disassembly failure
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,venkat88@linux.ibm.com,yeswanth@linux.ibm.com,skb99@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 18 Aug 2026 05:32:20 +0000 (UTC)

--===============5640435612391008903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Fixing powerpc JIT disassembly failure
>
> Ensure that the trampoline stubs JITed at the tail of the
> epilogue do not expose the dummy trampoline address stored
> in the last 8 bytes(64-bit) and last 4 bytes(32-bit)
> to the disassembly flow. Prevent the disassembler from
> ingesting this memory address, as it may occasionally decode
> into a seemingly valid but incorrect instruction. Fix this
> issue by truncating the last 8/4 bytes from JITed buffers
> before supplying them for disassembly.

This isn't a bug, but could the subject use the imperative ('Fix ...'
instead of 'Fixing ...'), and could the in-code comment and the
changelog agree on why the trailing bytes are dropped - is the hazard
that they cannot be decoded, or that they can be decoded into a
plausible-looking wrong instruction?

> diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
> index 3558fe10e28c..b291d934dd1a 100644
> --- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
> +++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
> @@ -179,9 +179,11 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
>  	struct bpf_prog_info info = {};
>  	__u32 info_len = sizeof(info);
>  	__u32 jited_funcs, len, pc;
> +	__u32 trunc_len = 0, disasm_len;
>  	__u32 *func_lens = NULL;
>  	FILE *text_out = NULL;
>  	uint8_t *image = NULL;
> +	char *triple = NULL;
>  	int i, err = 0;
>
>  	if (!llvm_initialized) {

[ ... ]

> @@ -225,9 +227,30 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
>  	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd #2"))
>  		goto out;
>
> +	/*
> +	 * last 8 bytes contains dummy_trampoline address in JIT
> +	 * output on 64-bit and last 4 bytes on 32-bit powerpc,
> +	 * which can't disassemble to a valid instruction.
> +	 */
> +	triple = LLVMGetDefaultTargetTriple();
> +	if (triple) {
> +		if (strstr(triple, "powerpc64") || strstr(triple, "ppc64"))
> +			trunc_len = 8;
> +		else if (strstr(triple, "powerpc") || strstr(triple, "ppc"))
> +			trunc_len = 4;
> +		LLVMDisposeMessage(triple);
> +	}

This isn't a bug, but would #if defined(__powerpc64__) / #elif
defined(__powerpc__) work here, matching how get_current_arch() in
test_loader.c already detects the arch, and avoiding a second
LLVMGetDefaultTargetTriple()/LLVMDisposeMessage() pair alongside the
one in disasm_one_func()?

> +
>  	for (pc = 0, i = 0; i < jited_funcs; ++i) {
>  		fprintf(text_out, "func #%d:\n", i);
> -		disasm_one_func(text_out, image + pc, func_lens[i]);
> +
> +		/*
> +		 * Disabled JIT have zero func_lens, hence underflow
> +		 */
> +		disasm_len = func_lens[i] > trunc_len ?
> +					func_lens[i] - trunc_len : 0;
> +		disasm_one_func(text_out, image + pc, disasm_len);
> +
>  		fprintf(text_out, "\n");
>  		pc += func_lens[i];
>  	}

This isn't a bug, but since 32-bit powerpc has no __arch_* tag and
get_current_arch() has no case for it yet, would it be clearer to add
the 4-byte arm together with the 32-bit enablement rather than ahead of
it?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32100929603
--===============5640435612391008903==--

