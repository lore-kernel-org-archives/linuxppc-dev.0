Return-Path: <linuxppc-dev+bounces-25578-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A201C5AC7C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 12:59:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGkkp5NCGz3c4f;
	Fri, 07 Aug 2026 22:59:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786107586;
	cv=none; b=iBiY5XQ6gawqtR1jAzmitS3r8CrnixT/J8fGXtzz0C+ycbzGSR2YvJUzMVPq2WWMx37mEM0EEpzNmswL05bgDnaoDe1FQoeSjI4ld9Lqz0hhbOfgJAz4E674156PAf+n0ZrvdP8xRLepNyVKprnFD5htsEUD2/OkkF8A20lHwcA+bA0Y2pTLI4KD1K2tm727OfHHFFD3IQuaGrWTHXwN+QtWswKuOOUrCIfK0mxb3ZTLAr0f4c2G+AMqc5S5F5ZvMpMHzhnJXZufehy+HSjgvZGvYE8qsW6/i5SU7K880ZZPjOJT3K1wDxjZo7GsmN25S3045vWGDeJF7TgDitT7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786107586; c=relaxed/relaxed;
	bh=WGWe62w4uZOGlTd+Rt6sdGbT/Nouu499hkPKmGKxmLg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YWbgySI2Pw2d8QP/jWjRIp52IyTv70vUY1Xk1pOqOFd99carNGDhoggj9bV6EYqaRO3u4SiYn6bioKtH5lI8/0JP9AQpThe1KBEgIeCF2bfnPY32bzq9Ew4rVNwQB0oS+ThmZsTxZrCiVvDcYh5BPX5XyFGNUgH3Wm1W1Yi6EbqVnLbhgrM7Cv7w+YDkZu1AFmxx6nLVIfmoj4PA+oOrhp2fW2irTuj//mQGpkghJAVKf0SOd9dUhKaEfQepjjl8ZkSIrpq6BZu75IQmOXnT9dik45BxohQYOZ3awDEBmAKTiwYuAvt0ky1NxMHtKl050z0UgZ09tppDSEmPWT1POw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wt/1R8rw; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wt/1R8rw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGkkn5nsZz3c2P
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 22:59:45 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BBC9960A70;
	Fri,  7 Aug 2026 12:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF291F000E9;
	Fri,  7 Aug 2026 12:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786107582;
	bh=WGWe62w4uZOGlTd+Rt6sdGbT/Nouu499hkPKmGKxmLg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Wt/1R8rwmGTx2f8PYIuCEP4H+iJa5y9BsvjmVm2lUyxYIkXsJ2OOrEl5qLluvQ4FO
	 gR8D6wPxIvholh5dqf9AmiEaTihz/DZ7/bp3LNMdFRqmi/poK/JuGskMzKSHvZz+rH
	 wVEKyeNooy4xgO4DalnL9F977Tkbpw3ASKWDczWH9A4b3a4BcVOrxHmugYRcpbuQzL
	 Xd4CGv3HFgkDILwOJfoJUrtiD31AgyG9Av8qqFdmErTziujfC9Rda8lqxV2iYJvKuq
	 oCdL+JelJ10bP+bqSvX5WpnSA9ps34stkgjh3ky3C1ZnFutjcidlObQMoPtYi2Kww8
	 wb4QUz12MUEOA==
Content-Type: multipart/mixed; boundary="===============4091664156689549777=="
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
Message-Id: <20bc24b322d3a8ef52eef9b3cd05eef275efabc0be00be3fd6df5a9765bba321@mail.kernel.org>
In-Reply-To: <e827cffd10c37ae7d0b1fca59523acda38db1704.1786099877.git.skb99@linux.ibm.com>
References: <e827cffd10c37ae7d0b1fca59523acda38db1704.1786099877.git.skb99@linux.ibm.com>
Subject: Re: [PATCH v11 3/8] selftests/bpf: Fixing powerpc JIT disassembly failure
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,venkat88@linux.ibm.com,yeswanth@linux.ibm.com,skb99@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  7 Aug 2026 12:59:41 +0000 (UTC)

--===============4091664156689549777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
> index 3558fe10e28cf..c4aa1d69d3bbf 100644
> --- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
> +++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c

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

This isn't a bug, but are the two new blank lines inside this loop
intentional? Dropping them would keep the diff to just the truncation
logic and match how the loops in disasm_one_func() are laid out.

>  		fprintf(text_out, "func #%d:\n", i);
>  		/*
>  		 * Disabled JIT have zero func_lens, hence underflow
>  		 */
>  		disasm_len = func_lens[i] > trunc_len ?
>  					func_lens[i] - trunc_len : 0;
>  		disasm_one_func(text_out, image + pc, disasm_len);
> +
>  		fprintf(text_out, "\n");
>  		pc += func_lens[i];
>  	}

> selftests/bpf: Fixing powerpc JIT disassembly failure

This isn't a bug, but would the subject read better in the imperative
mood, "selftests/bpf: Fix powerpc JIT disassembly failure", to match
the rest of the series?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31176427801
--===============4091664156689549777==--

