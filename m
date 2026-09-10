Return-Path: <linuxppc-dev+bounces-27033-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98A7C79FB9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 15:09:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgh0D6gc0z2xlJ;
	Fri, 11 Sep 2026 01:09:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789052940;
	cv=none; b=KRxI3CVmMpQuNmql5KohmKHFuAbZF8V7hd9K5V9ywcC2gv/f4gFQKuHyc1XXQNN1tcJq1X86nmokGLqtrWstx3cO+wSa2TQ6oajSOeg7lr8B/747EMON2usfkMFjbUFKqfr51MHAQYQ1aZ4ptXpcpPcOjQVFnCR6838iViQ2VFB/BDP+Q5jwPvE+PjrXQOiZQSvWz3qoICvXP/BIdLIljeJTvvSaVVnuwMkghkkTY/TpOrh2hwi67Tcl44UQnes4B9KOSY3geDkQVFXtz/fXp5xHpVkWwm5fbxkkwTqA4K4HrQpDrJjmyWGbq9Wu+H2NHCydY+2NwmV0AJVMUUHthA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789052940; c=relaxed/relaxed;
	bh=mQXXn4qhJ4aChLx2QAED5a/xeQKG/2zmtNcuT7UoMHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZnnL8lnR7L56pqFjXO81MtdqkQNWDvOAsdE9lemweIU0AQ/wVz22f+QTiF+hS92oMx0+nKDfGDUADlKRo+MYHBdDgPibniCS+AFP/BiJ5TmZm+c10CjlmBt5hNOKKzV5N9ArXOdJnVsBABIXuxhkQ/ydmhTD1xYewtmrRGumHbZeIxW4cD7zZgp73dh8AerxpXLm+ISMcLZ0mJCRxvomyeXLNvpjqUsQGiqPfcsXAFR2Q9KH1D89bsKhqHmgpY1tvI9Th49UI+xnDZ1iAF/MO/uDfJv1J6OaatLz0rUlOaGvR98Jo7/6YCsw1EMfvdRcoS+YRlxpSqxmypVNkNFpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fw0TDgul; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fw0TDgul;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgh0C4mfDz2xkr
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 01:08:59 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B917F412C3;
	Thu, 10 Sep 2026 15:08:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A17E1F000FF;
	Thu, 10 Sep 2026 15:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789052936;
	bh=mQXXn4qhJ4aChLx2QAED5a/xeQKG/2zmtNcuT7UoMHE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Fw0TDgulMnT8zjUzucAUywAXhKdwFptF1XubEt8K4TOL0zMtDRw6xCMEnhSlhL6WV
	 dt4zgR+488zDolV+m0gKYVeqJ2WNZ/aTuJvlmQOilF+7/2UffuW4IzPCo2ylc69wb8
	 V2FfTr+KbdcTZMqJi0jxVOVr6OHMFLWpzHRT0x8Pr0s1HE6rH85HvN1GTe9VPUW63k
	 KdYwTdNWsrmT4iidxQk6++iVr+EWhDoi8IhC2kSD3vrN5fXKgS2RlL6AG9Glryw47s
	 H4Eo6Aspwu4IYhQ7hF5gPFM88yD9bEnE3Tvcbg6bb1vKMtVf5B/E84Rkoq+BakHPr8
	 FrozPsKSM4smw==
Message-ID: <ffd8e0c3-0d78-46ee-9ab1-59dbfe0b6d27@kernel.org>
Date: Thu, 10 Sep 2026 17:08:48 +0200
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
Subject: Re: [PATCH V3] powerpc/bug: Add ARCH_WARN_ASM and refactor
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
References: <20260910100801.2159785-2-mkchauras@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260910100801.2159785-2-mkchauras@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 10/09/2026 à 12:08, Mukesh Kumar Chaurasiya (IBM) a écrit :
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
> To add ARCH_WARN_ASM, _EMIT_BUG_ENTRY first needs to be refactored.
> The old definition was a bare macro with no parameters, relying on
> positional asm operand references (%0-%3), hardcoding the backward
> reference to local label 1b, and including .org/.previous directives
> inline. That made it impossible to compose as a plain string outside of
> an asm operand context, and left an invisible contract that callers must
> always emit their trap at label 1:.
> 
> Refactor _EMIT_BUG_ENTRY to take explicit (label, file, line, flags)
> string arguments via string concatenation. This removes the dependency
> on asm operand numbering and makes the trap label an explicit argument,
> so the caller's intent is visible at the call site and a future caller
> using a different label cannot silently produce a wrong bug table entry.
> 
> Move the .org and .previous directives out of _EMIT_BUG_ENTRY and into
> each call site, so BUG_ENTRY() can still pass sizeof(struct bug_entry)
> as an asm operand while ARCH_WARN_ASM can supply its own size string
> independently.
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
> V2 -> V3:
>   - Add label argument in _EMIT_BUG_ENTRY
> V2: https://lore.kernel.org/all/20260910071252.1950488-2-mkchauras@gmail.com
> 
> V1 -> V2:
> - commit message now has error, fixes tag and closes tag
> V1: https://lore.kernel.org/all/20260819084825.969116-1-mkchauras@gmail.com
> 
>   arch/powerpc/include/asm/bug.h | 36 +++++++++++++++++++---------------
>   1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
> index 0db48977c70c..df2183c35945 100644
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
> -	".section __bug_table,\"aw\"\n"		\
> -	"2:	.4byte 1b - .\n"		\
> -	"	.4byte %0 - .\n"		\
> -	"	.short %1, %2\n"		\
> -	".org 2b+%3\n"				\
> -	".previous\n"
> +#define _EMIT_BUG_ENTRY(label, file, line, flags)	\
> +	".section __bug_table,\"aw\"\n"			\
> +	"2:	.4byte " label "b - .\n"		\

Ah, you left the b here. The label is 1b which mean "the first 1: you 
find going backward". Could as well be "1f" instead meaning "the first 
1: you find going forward".

So I think you should use 1b or 1f as the label, not just 1.

I would also try to use #label to stringigy the label in order to avoid 
having to put the arguments into quotes (untested), same for other ones.

Cdlt
Christophe

> +	"	.4byte " file " - .\n"			\
> +	"	.short " line ", " flags "\n"
>   #else
> -#define _EMIT_BUG_ENTRY				\
> -	".section __bug_table,\"aw\"\n"		\
> -	"2:	.4byte 1b - .\n"		\
> -	"	.short %2\n"			\
> -	".org 2b+%3\n"				\
> -	".previous\n"
> +#define _EMIT_BUG_ENTRY(label, file, line, flags)	\
> +	".section __bug_table,\"aw\"\n"			\
> +	"2:	.4byte " label "b - .\n"		\
> +	"	.short " flags "\n"
>   #endif
>   
>   #define BUG_ENTRY(cond_str, insn, flags, ...)		\
>   	__asm__ __volatile__(				\
>   		"1:	" insn "\n"			\
> -		_EMIT_BUG_ENTRY				\
> +		_EMIT_BUG_ENTRY("1", "%0", "%1", "%2")	\
> +		".org 2b+%3\n"				\
> +		".previous\n"				\
>   		: : "i" (WARN_CONDITION_STR(cond_str) __FILE__), "i" (__LINE__),	\
>   		  "i" (flags),				\
>   		  "i" (sizeof(struct bug_entry)),	\
>   		  ##__VA_ARGS__)
>   
> +#define ARCH_WARN_ASM(file, line, flags, size)		\
> +		"1:	twi 31, 0, 0\n"			\
> +		_EMIT_BUG_ENTRY("1", file, line, flags)	\
> +		".org 2b+" size "\n"			\
> +		".previous\n"
> +
> +#define ARCH_WARN_REACHABLE
> +
>   /*
>    * BUG_ON() and WARN_ON() do their best to cooperate with compile-time
>    * optimisations. However depending on the complexity of the condition


