Return-Path: <linuxppc-dev+bounces-21015-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B94CCD4F4B
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 May 2026 18:18:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJTht66r5z2xfB;
	Mon, 18 May 2026 04:18:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779041934;
	cv=none; b=b9/FQm/j5BMIm81v2n+NlcjCbtddmxlmD2m6I0+ooDj5pBSHBOd6SHqelXkqZIVaCRHMhnQQE5Srqr1HdxDmyOCVX4lTF12xysnZz2MEuXHpqjhgvaIFNfY2JfEQOlsrDPxtGyQLZarvG7ZMthaweyt8MmIklOG7CpJv+pXLuDJhXsi4w+lyHBxgZoKaIUKTvZW16xwNKBbNM1G3Jc3Z6j+alUSeAf8L+RceMe/29xmvJSBWesMxdvB41d/RRlbf0RA1Mie5PG39gNYLAcDOI5++vShj4H1WeBTzcAOeVzGkw5td1nPk/YZpOZsA+C0+y/tiLU6lqcY5kHndZDuEuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779041934; c=relaxed/relaxed;
	bh=+WuKDRodrSZ435yDBhO6Q1AWfTkbrj6SrtymL5lRwj0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VppN/olszqRINbuVFvEmEjpEHxAggOoTV4wQm8uxnfOtomWiREFg9390gkNlCzn7aqk1jE3VPxY+PQGgKVgkvuclEiLsj5ieFNCbRV5t+5kcTl7GBME9tfg/1QzbeN+7a2U3gfo7k131LlyQwpyXl3pRb3lXHchnlys70JnDt/WEFOPCO1Dn0N8ZVteVWK6m5WCW6n27Nn4NM7iBeAwGJRmJ1chN068trf3JPx8UmBdM2TzSiM0rn0wG92cwH76BizO9E8yunlqPz2R6ke1gctvkLPGmLv4iKC/Q4aBwGzctMDA+GewFtoaKjhO3tywIKktDhxjqCp7xg8/xNgPwaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R/Xcgn3E; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R/Xcgn3E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJThr55yRz2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 04:18:52 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3B80543CF6;
	Sun, 17 May 2026 18:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C784AC2BCC6;
	Sun, 17 May 2026 18:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779041929;
	bh=FdTz52kBiuxxnKRGyJY8LYIp811khf+rWDjvDMYs5Rc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=R/Xcgn3EfpQZ7yJolrPGRQ5v3X7TKIyJpoV3r3zTXJyr7pVl517l7MMEMWPhbaMTj
	 fPtBG8CMOv1r19o6WVKylBp8Vo/jYSyozFZssnmAh196WxWScJjMvsdwGUeBc67ARs
	 PEXRSkOe6f0RHXxkaxuGLfbNBvkyQ7MUf6kOdX/RXjUEfYYWpuCFilY2EMbg9qAUby
	 +PomWpXt7M16B7riEtp3ndNl1Tr5mjKNj0IymsVlMQnTqM4a157isY1mVBPwJLdbyK
	 CAC2PrHn3LwL3nIknQS/9oTceAg1JIN6uQJ7KlFSXYIm0YkiSpnAcvuMyvD5FzipCV
	 eYcYIannNMcrA==
Content-Type: multipart/mixed; boundary="===============1283525173956514337=="
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
Message-Id: <afd81a2105bb0deae207a35569bde1f3e1cf07d4a119a6fa745a3a15acd8be91@mail.kernel.org>
In-Reply-To: <20260517214043.12975-4-adubey@linux.ibm.com>
References: <20260517214043.12975-4-adubey@linux.ibm.com>
Subject: Re: [PATCH v4 3/5] selftest/bpf: Fixing powerpc JIT disassembly failure
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 17 May 2026 18:18:48 +0000 (UTC)

--===============1283525173956514337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
> index 364c557c5115..4c6bcbe08491 100644
> --- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
> +++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
> @@ -170,9 +170,11 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
>  	struct bpf_prog_info info = {};
>  	__u32 info_len = sizeof(info);
>  	__u32 jited_funcs, len, pc;
> +	__u32 trunc_len = 0;
>  	__u32 *func_lens = NULL;
>  	FILE *text_out = NULL;
>  	uint8_t *image = NULL;
> +	char *triple = NULL;
>  	int i, err = 0;
>
>  	if (!llvm_initialized) {

[ ... ]

> @@ -216,9 +218,18 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
>  	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd #2"))
>  		goto out;
>
> +	/*
> +	 * last 8 bytes contains dummy_trampoline address in JIT
> +	 * output for 64-bit and 32-bit powerpc, which can't
> +	 * disassemble a to valid instruction.
> +	 */
> +	triple = LLVMGetDefaultTargetTriple();
> +	if (strstr(triple, "powerpc"))
> +		trunc_len = 8;
> +

Does this code leak the triple string? Looking at the LLVM C API,
LLVMGetDefaultTargetTriple() returns a string that must be freed with
LLVMDisposeMessage(). The sibling function disasm_one_func() in this
same file shows the correct pattern:

    if (triple)
        LLVMDisposeMessage(triple);

The cleanup section at the 'out:' label properly frees text_out, image,
and func_lens, but triple isn't included. While this is test code and
the leak is small, it violates the established cleanup pattern in the
file and can accumulate across test runs.

>  	for (pc = 0, i = 0; i < jited_funcs; ++i) {
>  		fprintf(text_out, "func #%d:\n", i);
> -		disasm_one_func(text_out, image + pc, func_lens[i]);
> +		disasm_one_func(text_out, image + pc, func_lens[i] - trunc_len);
>  		fprintf(text_out, "\n");
>  		pc += func_lens[i];
>  	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25998434343
--===============1283525173956514337==--

