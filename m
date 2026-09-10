Return-Path: <linuxppc-dev+bounces-27011-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F41BC79FB7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 07:36:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgTyS4n8yz2y2S;
	Thu, 10 Sep 2026 17:36:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789025808;
	cv=none; b=LW1WtB1Pv8QYFdMDRM4h0YGIgsUXcyjIfSg6TcUkF/FB+Nkt6WecQadVAZ/YSy5Pc6SJEmMAtAFCeawCjuEACtEdNq1ptDJX0pKx0+o0S2TsQNIhB8OnHQo8rduoYotwZ08g72O5eX5jDuWYz3MQx2XJyv5TwJHggsUIwH8hJ9TJFPjcyNYHUBAhj+QRv2wW6bTkDB5z5CVYXiDwMA4DfXj+9HbDCEj69vJrKcoC+2Ag2rIRW+zilXlSRB0yLAUShkZL2spCv9XUbiZUcyI4r7s3USQ30w1T7CfvhZqd+KUV136kIPwFO33BvSJ/DlzJo6FFS3qoqpmoPXWpcPTadQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789025808; c=relaxed/relaxed;
	bh=N8H5Y7b1qMwZuFef2QciYQi6Mlqrglt14h/cSL2EZ0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OqDaI5viQpVO3uiUCU+tAnjorWAurHX50hfhLnHi3beAFEz2ukOmtB8vOVO848dPh5ogxbk4EZzHKMcqjBtu+C4Xtf9eBZNbCBsYTCiWqQW+Kns5deZjY+F7yRVTqW78XKqQ8Jakiai6vWwGP/rcpMA2SAGhM5hV0pv7CfPTSkzSIMOfae3uu8Tl6CVLtXH6xlUMmS7ekLXmvzdU/NOs1mP44N1yCTvtWtDdnrwH/WKKhkoN9YqvBLuGHzrIVYxwGMm+NX/8A7u+Hqo2a0kYUnBvPN2urjjb2/kydct5XNDhidQDDu4ra2jfZTZfWb1g52KTKBNzB56sLdWhrsynIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8wIqyyn; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8wIqyyn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgTyR3GVkz2xqM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 17:36:47 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 836C3409B2;
	Thu, 10 Sep 2026 07:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8140E1F000FF;
	Thu, 10 Sep 2026 07:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789025804;
	bh=N8H5Y7b1qMwZuFef2QciYQi6Mlqrglt14h/cSL2EZ0s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=i8wIqyynC1WW5Ne7bNtG8OS/iVwy3UVXPoMVLaYWQsUsWKVHdSZDkNTUkeRsW4qJR
	 uOG6DvuvMJKd1zVu3keBfLb7JQpOyHFzzYtI0GNOgERZivQI8Q9QZwEexTnbv3vNTL
	 hoB6paCbWHqvHzl982ak9AfTIsnaIhBf9o1AVB0jklkGUEsVO6moB/Gf6FLSlPi08c
	 l+grrOCEWhXQnJcif0ukTwkjt3LrV0zihGjjpYP6BPznz2Zd0CU07+x89HjHmQaolk
	 QeCWbUcisLxkU99rUawEW8NF+tzxqehUbneK3liIWZDLPuv49MRL+ECOU97ryz2fQV
	 2Tpjpz+GyABQQ==
Message-ID: <0605f2ed-32a1-492d-850e-d1080007b4bc@kernel.org>
Date: Thu, 10 Sep 2026 09:36:34 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] powerpc/bug: Add ARCH_WARN_ASM and refactor
 _EMIT_BUG_ENTRY for Rust support
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com,
 tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev,
 linkmauve@linkmauve.fr, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 rust-for-linux@vger.kernel.org
Cc: FUJITA Tomonori <tomo@flapping.org>
References: <20260910071252.1950488-2-mkchauras@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260910071252.1950488-2-mkchauras@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 10/09/2026 à 09:12, Mukesh Kumar Chaurasiya (IBM) a écrit :
> The Rust kernel infrastructure generates inline asm for WARN() via
> ARCH_WARN_ASM(file, line, flags, size), expanding it through a C
> preprocessor pass (generated_arch_warn_asm.rs.S) to produce an
> arch-specific asm template string for use in Rust's core::arch macros.
> 
> powerpc currently lacks ARCH_WARN_ASM and ARCH_WARN_REACHABLE, causing
> Rust builds to fail on powerpc with
> ```
> error: no rules expected `ARCH_WARN_ASM`
>     --> /home/linkmauve/dev/linux/wii/rust/kernel/generated_arch_warn_asm.rs:1:28
>      |
>    1 | ::kernel::concat_literals!(ARCH_WARN_ASM("{file}", "{line}", "{flags}", "{size}"))
>      |                            ^^^^^^^^^^^^^ no rules expected this token in macro call
>      |
>     ::: ../rust/kernel/lib.rs:279:1
>      |
> 279 | macro_rules! concat_literals {
>      | ---------------------------- when calling this macro
>      |
>      = note: while trying to match sequence start
> 
> error: no rules expected `ARCH_WARN_REACHABLE`
>     --> /home/linkmauve/dev/linux/wii/rust/kernel/generated_arch_reachable_asm.rs:1:28
>      |
>    1 | ::kernel::concat_literals!(ARCH_WARN_REACHABLE)
>      |                            ^^^^^^^^^^^^^^^^^^^ no rules expected this token in macro call
>      |
>     ::: ../rust/kernel/lib.rs:279:1
>      |
> 279 | macro_rules! concat_literals {
>      | ---------------------------- when calling this macro
>      |
>      = note: while trying to match sequence start
> 
> error: aborting due to 2 previous errors
> ```
> 
> Refactor _EMIT_BUG_ENTRY to accept explicit (file, line, flags) string
> arguments rather than relying on positional asm operand references
> (%0, %1, %2, %3). This allows the macro to be composed as a plain
> string concatenation, which is required for ARCH_WARN_ASM where no asm
> operand context exists.

For a cleaner _EMIT_BUG_ENTRY() macro, shouldn't it also pass the label 
where the trap sits as a macro argument instead of blindly relying on it 
being 1: ?

Christophe

> 
> Move the .org and .previous directives out of _EMIT_BUG_ENTRY and into
> the BUG_ENTRY() call site to preserve existing behaviour while enabling
> ARCH_WARN_ASM to supply its own size operand independently.
> 
> Add ARCH_WARN_REACHABLE as an empty define, matching the arm64
> convention, indicating that no additional reachability annotation is
> needed after a WARN on powerpc.
> 
> This brings powerpc into line with x86, arm64, s390, and riscv, all of
> which already define ARCH_WARN_ASM and ARCH_WARN_REACHABLE.
> 
> Reported-by: FUJITA Tomonori <tomo@flapping.org>
> Closes: https://lore.kernel.org/all/anG67Q6Y59kDqh-c@desktop
> Fixes: 73b741adb264 ("rust: Add PowerPC support")
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
> Changelog:
> V1 -> V2:
> - commit message now has error, fixes tag and closes tag
> 
>   arch/powerpc/include/asm/bug.h | 28 ++++++++++++++++------------
>   1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
> index 0db48977c70c..8aba39e0cf26 100644
> --- a/arch/powerpc/include/asm/bug.h
> +++ b/arch/powerpc/include/asm/bug.h
> @@ -32,34 +32,38 @@
>   #endif /* verbose */
>   
>   #else /* !__ASSEMBLER__ */
> -/* _EMIT_BUG_ENTRY expects args %0,%1,%2,%3 to be FILE, LINE, flags and
> -   sizeof(struct bug_entry), respectively */
>   #ifdef CONFIG_DEBUG_BUGVERBOSE
> -#define _EMIT_BUG_ENTRY				\
> +#define _EMIT_BUG_ENTRY(file, line, flags)	\
>   	".section __bug_table,\"aw\"\n"		\
>   	"2:	.4byte 1b - .\n"		\
> -	"	.4byte %0 - .\n"		\
> -	"	.short %1, %2\n"		\
> -	".org 2b+%3\n"				\
> -	".previous\n"
> +	"	.4byte " file " - .\n"		\
> +	"	.short " line ", " flags "\n"
>   #else
> -#define _EMIT_BUG_ENTRY				\
> +#define _EMIT_BUG_ENTRY(file, line, flags)	\
>   	".section __bug_table,\"aw\"\n"		\
>   	"2:	.4byte 1b - .\n"		\
> -	"	.short %2\n"			\
> -	".org 2b+%3\n"				\
> -	".previous\n"
> +	"	.short " flags "\n"
>   #endif
>   
>   #define BUG_ENTRY(cond_str, insn, flags, ...)		\
>   	__asm__ __volatile__(				\
>   		"1:	" insn "\n"			\
> -		_EMIT_BUG_ENTRY				\
> +		_EMIT_BUG_ENTRY("%0", "%1", "%2")	\
> +		".org 2b+%3\n"				\
> +		".previous\n"				\
>   		: : "i" (WARN_CONDITION_STR(cond_str) __FILE__), "i" (__LINE__),	\
>   		  "i" (flags),				\
>   		  "i" (sizeof(struct bug_entry)),	\
>   		  ##__VA_ARGS__)
>   
> +#define ARCH_WARN_ASM(file, line, flags, size)		\
> +		"1:	twi 31, 0, 0\n"			\
> +		_EMIT_BUG_ENTRY(file, line, flags)	\
> +		".org 2b+" size "\n"			\
> +		".previous\n"
> +
> +#define ARCH_WARN_REACHABLE
> +
>   /*
>    * BUG_ON() and WARN_ON() do their best to cooperate with compile-time
>    * optimisations. However depending on the complexity of the condition


