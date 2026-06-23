Return-Path: <linuxppc-dev+bounces-22945-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B4ACDB470
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 20:07:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glGMM01v7z2yQG;
	Wed, 24 Jun 2026 06:07:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782245262;
	cv=none; b=nQbXtKPm7KA46m8MkoxzTCTxiv8idUasB3WbkvvYfeRbagWSCsMcZoXAE4mzAjxDYYKw09vKTSPkMeX7FMdsMFwoDJ+SW4+oDWFxp2lLLUwUcBD9ja6sgYGzXz/WF8RFt0PmxmTkugxqrXij/7aseE5DJFQoi/kkbXXauats/EbVzoV3+WUNk0Oc/EO8dd+RVa2TPmLAbopCvz5iRHPNkHU9dCIQNcK9uU3jx0UJ+pVr9DB63gpkfja1EbrTSMqyqZwUC7FysGqOp+po8c6tNsJ7pf8ArM0Mu8VYpSwMezjkCDFysJN8vzmDpy31+SjE9S3dk58r55QY3QGD4+oa2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782245262; c=relaxed/relaxed;
	bh=6Kmx0mi/Yz50Wgq4l7LEOUoM/N7dSVgue1OpRg96emw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=k9vC7mnoZNqlPbcUyUBxuqocnbOs9VnCGBtdebRVHnnsVaLN3twUxM1GrfupC9R6aJWbvuXfo/zggCAH7xiaLFoMBfN1XV1ITnjQFjsEb9qRb57/KUZoe1FsEjkUbjzj/jsKwkBrL33tr+mlCyAVeg/Ni/cmiUhbkKtJIUowPoMgV65L4GLXU/IJR8otC4io5eEtGI68zCobuX7YzeQ+Eg7CezPtCLmhVcR+lRFTcL/FW7ICz3v84KLocDcGuthjDPh4+SLY6DF3UgD7BJzMxrzW6gW8xmiDHCum9vqa+Oa51n3PGlmaPRvRlBBrbQZ4E2i6FIrPwlVoeUeeCIvKOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mtgC7vu1; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mtgC7vu1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glGMK5W3jz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 06:07:41 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F06D74079F;
	Tue, 23 Jun 2026 20:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996831F000E9;
	Tue, 23 Jun 2026 20:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782245258;
	bh=6Kmx0mi/Yz50Wgq4l7LEOUoM/N7dSVgue1OpRg96emw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mtgC7vu1b8rxzkq0Xdavu/GlMTv+4n+D8qxXWeiHmpga4P5LNvQ+nuoGfBcpM26H3
	 wO3+BzB8wKxaKvlsUJtBxNgrH2jEstdh/SdmR9z6IrIIsdvCI53xkjq1dCQpwAARVh
	 B8MU+/b9X+U2/x4UGI5LsTpbfWU2x9AwlmvrGQ9n2qUFTdNPjxlLITg2lc6nKgPjqB
	 xt7XlyKXMvc5ZDJDvJlIIRTl5+dIhrLWBmYKLyi/2uxG8t8KcHn9awaeka8cGHVMXI
	 W6nk+bo/vE0TuIxyVYOohVX9QRtMEe/PEc+fM+qrwWsL8UZmGBBCvEtRQ/3crbym7P
	 mdNsp6XLBIZTQ==
Content-Type: multipart/mixed; boundary="===============2442528478780633523=="
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
Message-Id: <979553f5ed74dcb555e9aba6aad660ad2a208c643ab7aeac6d5e74992427f362@mail.kernel.org>
In-Reply-To: <20260623231411.6216-4-adubey@linux.ibm.com>
References: <20260623231411.6216-4-adubey@linux.ibm.com>
Subject: Re: [PATCH bpf v9 3/8] selftest/bpf: Fixing powerpc JIT disassembly failure
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 23 Jun 2026 20:07:38 +0000 (UTC)

--===============2442528478780633523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
> index 3558fe10e28c..11428cad5b2d 100644
> --- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
> +++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
> @@ -178,10 +178,12 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
>  {
>  	struct bpf_prog_info info = {};
>  	__u32 info_len = sizeof(info);
> -	__u32 jited_funcs, len, pc;
> +	__u32 jited_funcs, len, pc, disasm_len;
> +	__u32 trunc_len = 0;
>  	__u32 *func_lens = NULL;
>  	FILE *text_out = NULL;
>  	uint8_t *image = NULL;
> +	char *triple = NULL;

This isn't a bug, but would it be clearer to follow the traditional C
style by grouping related variables together? The disasm_len variable
could be declared closer to where it's used along with trunc_len, and
adding a blank line before the fprintf() statement in the loop might
improve readability.

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
> +
>  	for (pc = 0, i = 0; i < jited_funcs; ++i) {
> +
>  		fprintf(text_out, "func #%d:\n", i);
> -		disasm_one_func(text_out, image + pc, func_lens[i]);
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


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28051760380
--===============2442528478780633523==--

