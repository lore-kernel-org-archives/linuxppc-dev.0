Return-Path: <linuxppc-dev+bounces-21016-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597CACD4F47
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 May 2026 18:19:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJThw6XwLz2xdh;
	Mon, 18 May 2026 04:18:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779041936;
	cv=none; b=FfdvW/5YjuO2RbWnrt0EOD1Gg3L5JeyiTbN24xyTAIEb40cN611t5Aohd7d7YfszlFDX8V+EoNk5x74/RRRx20ILx8SPbyXl+y8BJRvam3GSc6qBMrAqBY4AT7CAd7RJvpAsUs1WeuStdMNXWiyZ0x+KzG3f11ku2Jlc8UI8CO4C1UdjV9ur7oRA1OofNdvMcndAF/rdhFQh25FBpVvJ7az0oTdNM1S2+UYy0aFHTnR95M/6dY64CG6qF7w6YtSHKRCl55sZBYn4BoDOkAKCJJ4xU8C0u0I9fHfIhYMxJSLGOltuZNYQ+gKW8R18TU5GIZeGGDGOo/lZlOTgysVkmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779041936; c=relaxed/relaxed;
	bh=XQ0zRcFuuw6easltRFcuNFft1q/fJzpPP5OTM4sYmO0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aVcIhIX5/EKDg7xspVIG7M02iVrYbBKTpMRNhYOago7J1ZQemUXzfwqAfelHcF2SkzYqniOq9YVefpl2xBqBVmlT3PFdrZjj44Teikf0ylsaTLSoHzXimaGvaVJYCluNOua0MU3C6UQ2KYEKfyrTAn0aGvMLyY2/3nzDapTgx4FM8/eaP9Jog6u9WXtuUfXLf8qVRVqYSCJAj96LkZaJw1mrH0ulAzGUxWubjsuohORx2xEspZUo1F53MhX9XgL/lz5hvqNKdaiyJAimEcwMGVhFPbokn2m9+4vLMDa1iBnL1/s+nyckTCqvB58UR7wqFffgoQupz6jD9QmpIB4sEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=l2k0q89B; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=l2k0q89B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJThv6B4Jz2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 04:18:55 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C8AAC40B41;
	Sun, 17 May 2026 18:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B173C2BCB0;
	Sun, 17 May 2026 18:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779041927;
	bh=3HniV/owbPuyiFifJf0oVNfnNRlBq/8riIc6nhW1yCY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=l2k0q89B9VKOKo9+4tHkay3xCumeTJcaZ858CHG/+LijIOrmKsmVXEW+66yMNO3uw
	 3QiYU4dde86xgR+dmqbrUFofQoPqzKVbr0ONpqbhP7GW8H2pS2cqx9Gn5yjd78SUsO
	 hrDe5LAwKIWOZoqPtW/gT6Il4xacb/Kvis6L0CBG3ADT6beON/nQSGJl0wPT7e3C2b
	 HLl62VLwZZzjyzrdvXksQLJO+EL2UStObbfLEZNKx+P3KAQ+/dQYxaEXjvRWkKS2YR
	 rAXQBEkhSgy0gG4wk8PuUCcYLQp6On2H+pP2n795dtuWZFJeQUDxQ/HHqvUudaAfAj
	 6rj65ryJmxE5Q==
Content-Type: multipart/mixed; boundary="===============4766251417798908984=="
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
Message-Id: <f86a6d40190b7f1334240e90e1bc07f4cf7a04afb945c0e8b9dd19c05fc87364@mail.kernel.org>
In-Reply-To: <20260517214043.12975-5-adubey@linux.ibm.com>
References: <20260517214043.12975-5-adubey@linux.ibm.com>
Subject: Re: [PATCH v4 4/5] selftest/bpf: Enable verifier selftest for powerpc64
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 17 May 2026 18:18:47 +0000 (UTC)

--===============4766251417798908984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
> index 9eeb5b0b63d6..cdc2a3de3054 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -158,6 +158,7 @@
>  #define __arch_arm64		__arch("ARM64")
>  #define __arch_riscv64		__arch("RISCV64")
>  #define __arch_s390x		__arch("s390x")
> +#define __arch_powerpc64	__arch("POWERPC64")
>  #define __caps_unpriv(caps)	__test_tag("test_caps_unpriv=" EXPAND_QUOTE(caps))
>  #define __load_if_JITed()	__test_tag("load_mode=jited")
>  #define __load_if_no_JITed()	__test_tag("load_mode=no_jited")
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index abdb9e6e3713..d5589355ed9e 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -377,6 +377,7 @@ enum arch {
>  	ARCH_ARM64	= 0x4,
>  	ARCH_RISCV64	= 0x8,
>  	ARCH_S390X	= 0x10,
> +	ARCH_POWERPC64	= 0x20,
>  };
>
>  static int get_current_arch(void)
> @@ -389,6 +390,8 @@ static int get_current_arch(void)
>  	return ARCH_RISCV64;
>  #elif defined(__s390x__)
>  	return ARCH_S390X;
> +#elif defined(__powerpc64__)
> +	return ARCH_POWERPC64;
>  #endif
>  	return ARCH_UNKNOWN;
>  }
> @@ -580,6 +583,8 @@ static int parse_test_spec(struct test_loader *tester,
>  				arch = ARCH_RISCV64;
>  			} else if (strcmp(val, "s390x") == 0) {
>  				arch = ARCH_S390X;
> +			} else if (strcmp(val, "POWERPC64") == 0) {
> +				arch = ARCH_POWERPC64;
>  			} else {
>  				PRINT_FAIL("bad arch spec: '%s'\n", val);
>  				err = -EINVAL;

This patch looks clean. However, unaddressed review comments from earlier
versions of related patches in the series were identified:

https://lore.kernel.org/bpf/20260517180201.87B8AC2BCB0@smtp.kernel.org

Three issues were raised by sashiko-bot@kernel.org on Sun, 17 May 2026 about
alignment logic in arch/powerpc/net/bpf_jit_comp.c (from a related commit in
this series):

Issue 1: In bpf_jit_build_fentry_stubs(), the alignment NOP is only emitted
when (fimage && image) is true. During pass 0 sizing, both are NULL, so the
NOP is skipped and proglen is calculated without it.

During final passes 1 and 2, if the NOP is emitted, could this increase the
instruction count beyond proglen and overflow into the exception table or
fixups?

Issue 2: In the same function, the alignment calculation appears flawed:

    unsigned long pc = (unsigned long)fimage + CTX_NIA(ctx);
    pc += IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 11 : 10;

The comment says "11/10 instructions" but pc is a byte address. Adding 11 or
10 adds bytes instead of the intended 44 or 40 bytes (since PowerPC
instructions are 4 bytes).

Adding 4 bytes to an 8-byte aligned address makes it unaligned. Does this
force the code to emit a NOP when the target address is already aligned?

Issue 3: In bpf_jit_emit_exit_insn(), the code passes NULL for fimage:

    } else {
        ctx->alt_exit_addr = ctx->idx * 4;
        bpf_jit_build_epilogue(image, NULL, ctx);

Because fimage is strictly passed as NULL, the (fimage && image) check will
always evaluate to false. Will this cause the alignment NOP to be
unconditionally skipped for all inline epilogues, leaving their
dummy_tramp_addr fields unaligned?

These comments should be addressed in the related commits of this series.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25998434343
--===============4766251417798908984==--

