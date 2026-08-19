Return-Path: <linuxppc-dev+bounces-25979-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D861C5DF6D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 11:50:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQ4ds3b24z2yRZ;
	Wed, 19 Aug 2026 21:50:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787140257;
	cv=none; b=TuvofAu4n2o1oeJ0sQZxDm0p1J+zfvMZAcMxqUPLC6dSpxfiRrxOkw4SKcF1n3COZ6WZZbiuZaSH6OYTkmicxb52rAyxfMDNj/Ln4colyXArpnolvjfWhpMQRY8orcjrroN6I12xtmTASX+d4hTIFujPLF/hXBHDlwhlcSktRrgfl1YfrwF/51ja6eNUPB+ye9+qgduP2i5cqv9es+rFi64lI7J0dc33Mr4hwPm8YrcZ+B2kia8tWdVZJGQZ8yh1S8GF8CT6ggtkVMxk7gZAk3MrUGNemqxrKcrojtPxPMFfZlB+nfh/h8aBs18AFKWP/w1u7PyIrR/5ugVj3yt0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787140257; c=relaxed/relaxed;
	bh=PzZQi/+zyv5tISCSrhzpaU2w5pSh1zq3AvPapYtU2N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCjeY5cZsTtJlc7wyjUNhAt1Jv/r1bDiVftzlm6DjDe1UK2MWuFaLr1gHNqFOBFYdmIVX4R+Dd9YugXfvW2klF3+mYX1qjBJmZ7VyinC/YXpgTcR1knq2apW3lKHTd1rYfqRsnz2H65/+70Ij+Llb8nfCqQBX+mDThp1dk8Z8URmg1Fte48JGtkglyXY6YgVLFPXQuQSCSH9U+gh1+lRoko48lV9opYpP4V/fJv+ISC4sKNedsZ/E5YC07dXsQ7p2d3TZudbJO7x3bV2qawSXeNEslKCc9Zhp0rpHRon29IbWzaRxIBsKkcdflA1/LszyziIBTrUjnBc/sAWMrN97Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LNVICCgH; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LNVICCgH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQ4dr218Rz2yDr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2026 21:50:56 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A204E60A58;
	Wed, 19 Aug 2026 11:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744891F000E9;
	Wed, 19 Aug 2026 11:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787140252;
	bh=PzZQi/+zyv5tISCSrhzpaU2w5pSh1zq3AvPapYtU2N4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LNVICCgHe+pAUQZvzTWDm972iLfklbfwbVcaoSdCB8MxiUZjCBG/6a4PRM1NczvzE
	 vuq1+vZTyHmI/D/1ZxhbKkj6NYhS0QcLq/rxGhscQpHzRTnmcP8s2fSfZwyZG7rVuN
	 IVuiabGroKi3jjXib5l7Zqej8ydmEfMBPYs69FrJiFNA80q/ia+BsZoCvmTa0vaYyi
	 24fTaD7hPfhY0KohdeIT2kkaYH+wxtWU3q/jn5opEGDVOAn6CpBqaHY19x8r65gFjx
	 Wy9xtLM9ASCA5Y9U9x7dnUng6dWG08KvDHiZwiGTMl22dK720ddr6lSCBPsHyxBig1
	 CeqbwaNmUZxtw==
Message-ID: <4c5b2ab5-83f8-4ee7-bb02-3046ed01fd84@kernel.org>
Date: Wed, 19 Aug 2026 13:50:43 +0200
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
Subject: Re: [PATCH] powerpc/bug: Add ARCH_WARN_ASM and refactor
 _EMIT_BUG_ENTRY for Rust support
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com,
 tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev,
 thuth@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 rust-for-linux@vger.kernel.org
Cc: FUJITA Tomonori <tomo@flapping.org>
References: <20260819084825.969116-1-mkchauras@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260819084825.969116-1-mkchauras@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 19/08/2026 à 10:48, Mukesh Kumar Chaurasiya (IBM) a écrit :
> The Rust kernel infrastructure generates inline asm for WARN() via
> ARCH_WARN_ASM(file, line, flags, size), expanding it through a C
> preprocessor pass (generated_arch_warn_asm.rs.S) to produce an
> arch-specific asm template string for use in Rust's core::arch macros.
> 
> powerpc currently lacks ARCH_WARN_ASM and ARCH_WARN_REACHABLE, causing
> Rust builds to fail on powerpc.
> 
> Refactor _EMIT_BUG_ENTRY to accept explicit (file, line, flags) string
> arguments rather than relying on positional asm operand references
> (%0, %1, %2, %3). This allows the macro to be composed as a plain
> string concatenation, which is required for ARCH_WARN_ASM where no asm
> operand context exists.
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
> Suggested-by: FUJITA Tomonori <tomo@flapping.org>
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
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

Sorry, I still don't understand. The only place the new macro is used is 
a .S file (namely rust/kernel/generated_arch_warn_asm.rs.S), and the 
change this patch implements is inside a #if !__ASSEMBLER__.

What am I missing ?

Christophe


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


