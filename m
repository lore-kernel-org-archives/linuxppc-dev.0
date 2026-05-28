Return-Path: <linuxppc-dev+bounces-21675-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91C1CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 22:40:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRLzS4Yq5z2xMW;
	Fri, 29 May 2026 08:40:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780008020;
	cv=none; b=YIODSiN6/1PAId5pMj89sCiVE/XVM7ZoIQielDeW1D4BmEm+xgCWDmjg2OIPiqgzWkZgqnNnterKrPyuxSfgfYi+huHNPEC1Hv9JhBm7XOQryDEOK9/6+tkSoE2iqtEvnkHtvMdnA2xoGUnSuncoURU03tlsM7OUW2BpR8QCq8gkJEsLNo/vqqFhcVFKcL1zPrI+NFlXFQHTLYO89h+HSsxDmX5rX/YzFtiqM30gtSllsd8I7iFZIS20+9boXGPoii2FdOqfq6F9s9klAmJnh8dhPWxAQBrIbBO/Lj9Ac6J8g4/vKSnii0xJha+rQ2PxcEhSqhH9WHz9GNfw+4ja5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780008020; c=relaxed/relaxed;
	bh=ZYoIC7tgDvTnn72N4qZ6BOaf6goJiUEBgxODpeKiPNc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mXM9ZgS+7PasTgS8zQr7Rk1Qhd6HyjzxRqkz0di/CdmBPAPGdhOJFFstAlSuhtqP/WX7nFKkF/mvJ18BTiohKTJ9vLQuUXYfNmyOAS1/cTddrgUMC4+ueMeiyfLGy6aWSRtUItQMn27bkEqht6mbobmYTUHDCbybEtioixVl83ttRuNP65RgJeKbFPrpRRSUQAKRY9JNVl3vup+Va/On8mhzdsMZQsW3HKSVlmSsI+aq63IoCdl/NlruTGEOxzSgYDg2R1Wm1+i3/Zd7vVl8tmrAfPoBoB58pd3qbSVVlJEvW5WUOCn86BEWVeP7jwpq2OfzhsZkIB/yxCi0isWXTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TomYBcye; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TomYBcye;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRLzR0mFTz2xM7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 08:40:18 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E05A560213;
	Thu, 28 May 2026 22:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573D71F000E9;
	Thu, 28 May 2026 22:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780008015;
	bh=ZYoIC7tgDvTnn72N4qZ6BOaf6goJiUEBgxODpeKiPNc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TomYBcyexq04Y5cnuhvyWbfq++IQqybsVivOkfApAiWeUFFpmNVZGjPoI0C+3zsAe
	 YcC4/BMQQmBVRo6eG065tXr8WhBQs3d0hEa8j4dlMH7MpJ8dvO5a2Zge53EeK+/SHM
	 Sn0gkIAJdWWnRJuLGadnS7wUF3RgE+o6SGr9Qi6A7V5KLGjaamr15XspU0pH9AWcHc
	 Z2wfc62CWBEbD7MNhBtWrQgccFjR/eDwDs5wBol4eoHm2cgrJQO2+00O6pj8HXYA2Z
	 b62Qyt9d4wYYHBchJ8g1kBCbCH/jl2WACvshBHUM0sVprS3gmU3QDI1SLXvJQOSmVP
	 2RZGOCKRIlKFA==
Content-Type: multipart/mixed; boundary="===============2740736122395765729=="
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
Message-Id: <cb81617c5327a5e1373d31f249ed8eeb9d5755e4c81d1e07464d2a0a08288e44@mail.kernel.org>
In-Reply-To: <20260529015855.364704-4-adubey@linux.ibm.com>
References: <20260529015855.364704-4-adubey@linux.ibm.com>
Subject: Re: [PATCH v6 3/6] selftest/bpf: Fixing powerpc JIT disassembly failure
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 28 May 2026 22:40:15 +0000 (UTC)

--===============2740736122395765729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
> index 364c557c5115..21e3e3e68c14 100644
> --- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
> +++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c

[ ... ]

> @@ -216,9 +218,28 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
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
> +		if (strstr(triple, "powerpc")) {
> +			if (IS_ENABLED(CONFIG_PPC64))
> +				trunc_len = 8;
> +			else
> +				trunc_len = 4;
> +		}
> +		LLVMDisposeMessage(triple);
> +	}

Can IS_ENABLED(CONFIG_PPC64) ever be true in this file?

This is a userspace selftest (tools/testing/selftests/bpf/jit_disasm_helpers.c).
IS_ENABLED here resolves to tools/include/linux/kconfig.h:

  #define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))

which ultimately tests __is_defined(CONFIG_PPC64), i.e. whether CONFIG_PPC64
is a defined preprocessor macro.

The kernel proper makes CONFIG_* macros visible by force-including
include/generated/autoconf.h via the build flags. The selftests/bpf build
does not do that: tools/testing/selftests/bpf/Makefile only adds an include
search path and -DHAVE_GENHDR, with no -include autoconf.h, and the include
chain for this file never pulls in generated/autoconf.h.

So CONFIG_PPC64 is undefined and IS_ENABLED(CONFIG_PPC64) is 0 on every
build, including ppc64/ppc64le. trunc_len then always becomes 4.

On 64-bit powerpc the JITed stub appends an 8-byte dummy trampoline address,
but only 4 bytes get truncated. The remaining 4 bytes are still handed to the
disassembler, which can decode them into a seemingly valid instruction, which
is the failure this change is meant to fix. Would a runtime check on the
triple, for example strstr(triple, "powerpc64"), be needed to distinguish
64-bit from 32-bit here, since the 8-vs-4 selection is otherwise compile-time?

> +
>  	for (pc = 0, i = 0; i < jited_funcs; ++i) {
>  		fprintf(text_out, "func #%d:\n", i);
> -		disasm_one_func(text_out, image + pc, func_lens[i]);
> +		/* Disabled JIT have zero func_lens, hence underflow */
> +		__u32 disasm_len = func_lens[i] > trunc_len ?
> +					func_lens[i] - trunc_len : 0;
> +		disasm_one_func(text_out, image + pc, disasm_len);
>  		fprintf(text_out, "\n");
>  		pc += func_lens[i];
>  	}

The commit message describes fixing a powerpc JIT disassembly failure caused
by the dummy trampoline address emitted at the tail of the long_branch stub.
That trailing field was introduced by commit d243b62b7bd3 ("powerpc64/bpf:
Add support for bpf trampolines"). The two sibling commits in this series
both carry that Fixes: tag, but this selftest-side commit does not.

Should this include:

  Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26605473656
--===============2740736122395765729==--

