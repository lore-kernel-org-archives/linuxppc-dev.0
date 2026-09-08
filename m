Return-Path: <linuxppc-dev+bounces-26784-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02F3C79F82
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 09:59:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfKD05cKsz2y2b;
	Tue, 08 Sep 2026 19:59:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788861568;
	cv=none; b=cqMCcw+7NrcAo8smzMRAva/aEN/Je/6ybBdYga2qc7kW5oEWJrkI2fXAhoz1sNIoYUVQwWs5mSPXsq516VifMjrM9fHOH2Qyq8Gn/IOIc8kSqbshxX6538HTQw+vs6tsoCdpiyiazheoPE2RkJKkg0Q81oEHsPObPFh4mQbs2ee9lkp2kjIzYxI0nImv86kAcD/cg6tLgzV6WVlx8PDEWS62tW+hk8YhWySxM6iYONIQPt8lJySTHhG1w/cipqXWKDqXFDx9w//AlabckZ5SCjJMAWTFM681XKuY0Wvm8WzkO+QCYxf7eTQI7zkL4/q8XCqGfVk7be2dUXM9sFrqsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788861568; c=relaxed/relaxed;
	bh=V4ifYhj5ey0g3l1Ok7EVyIw9Ie8yI/Ypk9Qe6O09XRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GnK7HZX/GoVdX+y2k52PN6HzK9eXaihEZdnxUIbc5LWD+T9AJj4HxDcGyCSZJg88iAD2bMtneqCLNIWvK16XsEi0vsTjSWfhgkBf09oXubO36YvobrDrlolonMavb3MtI1d+J59t3N9OTUQNDrrGMgzLyIGcjwiDcu9dOVtrW4kC5REUCbgGGSHZE0P8fFUWMbO6LHMLrM7i0+SmYy9OypOKOvdwFgmv0j2azkyrt7ctReX1d6puHJNuEPBc8keZaSp45i1elV7udZN2RH2yvaVotbWZmdm7bH95nFh2/bXJUCFOrNkVWVD/BYQb1dBJwUCvjwJ6AeOSp8eej+f6GQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=au/t54QD; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=au/t54QD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfKCz40zCz2xlJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 19:59:27 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2481060A97;
	Tue,  8 Sep 2026 09:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3071F00A3D;
	Tue,  8 Sep 2026 09:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788861564;
	bh=V4ifYhj5ey0g3l1Ok7EVyIw9Ie8yI/Ypk9Qe6O09XRc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=au/t54QDRARSRKQ0Kl8AHX/axMhDJt35PmLOGilGTG/d9KVok6qqKoF4zMvyGgvec
	 XhZ5DfZPdMHkazV6Yis2rJEmYZGGq3/euhqROB/+IvumwxQHAOXemH/1TzXb/pNsvy
	 YFdUy3VVPZ0deHWFwWwWXGhtw1rBaBZOIUkvDemGkWqgcOPPyE0gKCJfoy9oHQFp3G
	 +GAt9bUgp8nF30nCFjR1Ryfk3tw/HWcLcFDJi3V2zIQsWbAYGTx2Z9reVCPC+THUnd
	 Vk/f06I/DsRaKRlkescXbzmNj24mOdEJuhJPhG3ynbGMLIuqs0XEFE0NjuWDA+o+0x
	 fbogPtvhioscA==
Message-ID: <b3b1fa5a-c836-447f-a658-ad66183c23c5@kernel.org>
Date: Tue, 8 Sep 2026 11:59:14 +0200
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
Subject: Re: [PATCH] powerpc/kasan: require memintrinsic prefix support for
 KASAN
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
 dvyukov@google.com, vincenzo.frascino@arm.com, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, kees@kernel.org,
 amachhiw@linux.ibm.com, ritesh.list@gmail.com, robh@kernel.org,
 sayalip@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 linux-riscv@lists.infradead.org, linux-hardening@vger.kernel.org
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <20260908064948.999530-1-mkchauras@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260908064948.999530-1-mkchauras@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/09/2026 à 08:49, Mukesh Kumar Chaurasiya (IBM) a écrit :
> powerpc unconditionally selects GENERIC_ENTRY. The GENERIC_ENTRY
> infrastructure relies on the compiler emitting __asan_mem*() calls at
> instrumented mem*() sites rather than plain memset/memcpy/memmove, so
> that entry/exit paths calling those functions are not instrumented.
> 
> This assumption is encoded in two places:
> 
>    mm/kasan/shadow.c:
>      #if !defined(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX) &&
>          !defined(CONFIG_GENERIC_ENTRY)
> 
>    include/linux/fortify-string.h:
>      #if !defined(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX) &&
>          !defined(CONFIG_GENERIC_ENTRY)
> 
> When GENERIC_ENTRY is set, both guards suppress the C wrappers for
> memset/memcpy/memmove and the __underlying_mem*() redirections. This
> is only safe when the compiler supports the prefixed __asan_mem*()
> intrinsics. On older toolchains (e.g. GCC 9) that lack this support,
> plain mem*() calls from instrumented code fall through to the raw
> assembly implementations in mem_64.S / copy_32.S, completely bypassing
> the KASAN shadow check.
> 
> Other arches with GENERIC_ENTRY (x86, s390, loongarch, riscv) do not
> hit this because their CI toolchains are always new enough to support
> the prefix flag.
> 
> Background: the !GENERIC_ENTRY guard was introduced by commit 69d4c0d32186
> ("entry, kasan, x86: Disallow overriding mem*() functions", Peter Zijlstra,
> Jan 2023). The root problem is that the KASAN C wrappers override the
> linker symbol memset/memcpy/memmove globally, so any call from noinstr or
> __no_sanitize_address code (e.g. irqentry_enter/irqentry_exit) would still
> reach the KASAN shadow-check wrapper -- at a point where KASAN invariants
> may not hold. The compiler prefix approach (Marco Elver, Feb 2023,
> commit 51287dcb00cc) solves this by having the compiler emit __asan_memset
> at instrumented call sites and bare memset inside __no_sanitize_address
> functions, splitting the decision at code-generation time rather than at
> link time.
> 
> A manual C-level override cannot replicate this split: a single linker
> symbol cannot be made to resolve differently depending on the caller.
> 
> x86 also placed its raw memset/memcpy/memmove implementations in
> .noinstr.text (same commit, 69d4c0d32186), which is the other half of
> the fix: noinstr callers hit the raw assembly directly, safely bypassing
> KASAN. PowerPC has not done this. Placing mem_64.S / memcpy_64.S /
> copy_32.S implementations in .noinstr.text would be the complementary
> long-term fix that could re-enable KASAN on older toolchains, but it
> requires care around linker stub overflow on large PPC64 kernels (the
> same reason powerpc uses NOKPROBE_SYMBOL rather than noinstr for its
> interrupt handlers -- see the comment in asm/interrupt.h). That work
> is left as a follow-up.
> 
> For now, introduce PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX, an arch-local
> compiler probe that mirrors the same check as CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> in lib/Kconfig.kasan but lives outside the 'if KASAN' block to avoid a
> recursive dependency (CC_HAS_KASAN_MEMINTRINSIC_PREFIX depends on KASAN
> which depends on HAVE_ARCH_KASAN). Gate the three HAVE_ARCH_KASAN selects
> on this new symbol so that KASAN is not offered as a config option on
> toolchains that cannot support it correctly with GENERIC_ENTRY.
> 
> Since KASAN on powerpc now unconditionally implies
> CC_HAS_KASAN_MEMINTRINSIC_PREFIX, the old !CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> code paths in asm/kasan.h and asm/string.h are dead. Clean them up:
> 
> - asm/kasan.h: remove the dual-entry-point variant of _GLOBAL_KASAN /
>    _GLOBAL_TOC_KASAN / EXPORT_SYMBOL_KASAN that emitted both memset and
>    __memset as entry points to the same assembly.  These aliases were only
>    needed so the C KASAN wrappers in shadow.c could call __memset() to
>    reach raw memory ops; with the compiler prefix approach the wrappers are
>    not used at all for mem* on powerpc.
> 
> - asm/string.h: remove the separate __memset/__memcpy/__memmove symbol
>    declarations and the memset/memcpy/memmove macro redirections for
>    uninstrumented files that were needed on old toolchains.  Simplify the
>    CONFIG_KASAN block to just the three #define aliases (which are still
>    used by shadow.c as raw backends).
> 
> - cputable.c, prom_init.c: update stale comments that said GCC replaces
>    memcpy() with __memcpy() under KASAN; with the prefix flag it emits
>    __asan_memcpy() instead.
> 
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/96dae110-f79b-4e54-8a9b-514369019b5d@linux.ibm.com
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
>   arch/powerpc/Kconfig              | 10 +++++++---
>   arch/powerpc/include/asm/kasan.h  | 19 ++++++++-----------
>   arch/powerpc/include/asm/string.h | 25 +++++--------------------
>   arch/powerpc/kernel/cputable.c    |  6 +++---
>   arch/powerpc/kernel/prom_init.c   |  4 ++--
>   5 files changed, 25 insertions(+), 39 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2580e27e4328..b27ed9739eea 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -7,6 +7,10 @@ config CC_HAS_ELFV2
>   config CC_HAS_PREFIXED
>   	def_bool PPC64 && $(cc-option, -mcpu=power10 -mprefixed)
>   
> +config PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> +	def_bool (CC_IS_CLANG && $(cc-option,-fsanitize=kernel-address -mllvm -asan-kernel-mem-intrinsic-prefix=1)) || \
> +		 (CC_IS_GCC && $(cc-option,-fsanitize=kernel-address --param asan-kernel-mem-intrinsic-prefix=1))
> +
>   config CC_HAS_PCREL
>   	# Clang has a bug (https://github.com/llvm/llvm-project/issues/62372)
>   	# where pcrel code is not generated if -msoft-float, -mno-altivec, or
> @@ -220,9 +224,9 @@ config PPC
>   	select HAVE_ARCH_HUGE_VMAP		if PPC_RADIX_MMU || PPC_8xx
>   	select HAVE_ARCH_JUMP_LABEL
>   	select HAVE_ARCH_JUMP_LABEL_RELATIVE
> -	select HAVE_ARCH_KASAN			if PPC32 && PAGE_SHIFT <= 14
> -	select HAVE_ARCH_KASAN			if PPC_RADIX_MMU
> -	select HAVE_ARCH_KASAN			if PPC_BOOK3E_64
> +	select HAVE_ARCH_KASAN			if PPC32 && PAGE_SHIFT <= 14 && PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> +	select HAVE_ARCH_KASAN			if PPC_RADIX_MMU && PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> +	select HAVE_ARCH_KASAN			if PPC_BOOK3E_64 && PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
>   	select HAVE_ARCH_KASAN_VMALLOC		if HAVE_ARCH_KASAN
>   	select HAVE_ARCH_KCSAN
>   	select HAVE_ARCH_KFENCE			if ARCH_SUPPORTS_DEBUG_PAGEALLOC
> diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
> index a690e7da53c2..ffada5f51b2b 100644
> --- a/arch/powerpc/include/asm/kasan.h
> +++ b/arch/powerpc/include/asm/kasan.h
> @@ -2,20 +2,17 @@
>   #ifndef __ASM_KASAN_H
>   #define __ASM_KASAN_H
>   
> -#if defined(CONFIG_KASAN) && !defined(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX)
> -#define _GLOBAL_KASAN(fn)			\
> -	_GLOBAL(fn);				\
> -	_GLOBAL(__##fn)
> -#define _GLOBAL_TOC_KASAN(fn)			\
> -	_GLOBAL_TOC(fn);			\
> -	_GLOBAL_TOC(__##fn)
> -#define EXPORT_SYMBOL_KASAN(fn)			\
> -	EXPORT_SYMBOL(__##fn)
> -#else /* CONFIG_KASAN && !CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
> +/*
> + * powerpc requires CC_HAS_KASAN_MEMINTRINSIC_PREFIX whenever KASAN is
> + * enabled (see PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX in arch/powerpc/Kconfig),
> + * so the compiler always emits __asan_mem*() at instrumented call sites and
> + * bare mem*() inside __no_sanitize_address / noinstr code.  The old dual
> + * entry-point trick (_GLOBAL_KASAN emitting both memset and __memset) is
> + * therefore never needed.
> + */

This explanation belongs to the commit message not to the source code.

>   #define _GLOBAL_KASAN(fn)	_GLOBAL(fn)
>   #define _GLOBAL_TOC_KASAN(fn)	_GLOBAL_TOC(fn)
>   #define EXPORT_SYMBOL_KASAN(fn)
> -#endif /* CONFIG_KASAN && !CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
>   
>   #ifndef __ASSEMBLER__
>   
> diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
> index 1981bd4036b5..743126e3dcc1 100644
> --- a/arch/powerpc/include/asm/string.h
> +++ b/arch/powerpc/include/asm/string.h
> @@ -29,29 +29,14 @@ extern void * memchr(const void *,int,__kernel_size_t);
>   void memcpy_flushcache(void *dest, const void *src, size_t size);
>   
>   #ifdef CONFIG_KASAN
> -/* __mem variants are used by KASAN to implement instrumented meminstrinsics. */
> -#ifdef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> +/*
> + * powerpc requires CC_HAS_KASAN_MEMINTRINSIC_PREFIX whenever KASAN is
> + * enabled, so the compiler emits __asan_mem*() at instrumented sites.
> + * The raw mem* symbols are always safe to call directly.
> + */

This explanation belongs to the commit message not to the source code.

>   #define __memset memset
>   #define __memcpy memcpy
>   #define __memmove memmove
> -#else /* CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
> -void *__memset(void *s, int c, __kernel_size_t count);
> -void *__memcpy(void *to, const void *from, __kernel_size_t n);
> -void *__memmove(void *to, const void *from, __kernel_size_t n);
> -#ifndef __SANITIZE_ADDRESS__
> -/*
> - * For files that are not instrumented (e.g. mm/slub.c) we
> - * should use not instrumented version of mem* functions.
> - */
> -#define memcpy(dst, src, len) __memcpy(dst, src, len)
> -#define memmove(dst, src, len) __memmove(dst, src, len)
> -#define memset(s, c, n) __memset(s, c, n)
> -
> -#ifndef __NO_FORTIFY
> -#define __NO_FORTIFY /* FORTIFY_SOURCE uses __builtin_memcpy, etc. */
> -#endif
> -#endif /* !__SANITIZE_ADDRESS__ */
> -#endif /* CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
>   #endif /* CONFIG_KASAN */
>   
>   #ifdef CONFIG_PPC64
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index 6f6801da9dc1..44115f904c2c 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -36,8 +36,8 @@ void __init set_cur_cpu_spec(struct cpu_spec *s)
>   
>   	t = PTRRELOC(t);
>   	/*
> -	 * use memcpy() instead of *t = *s so that GCC replaces it
> -	 * by __memcpy() when KASAN is active
> +	 * use memcpy() instead of *t = *s so that the compiler replaces it
> +	 * by __asan_memcpy() when KASAN is active
>   	 */

Does the initial problem still exist with the new __asan_memcpy() 
approach ? If not the comment should be removed.


>   	memcpy(t, s, sizeof(*t));
>   
> @@ -55,7 +55,7 @@ static struct cpu_spec * __init setup_cpu_spec(unsigned long offset,
>   
>   	/*
>   	 * Copy everything, then do fixups. Use memcpy() instead of *t = *s
> -	 * so that GCC replaces it by __memcpy() when KASAN is active
> +	 * so that the compiler replaces it by __asan_memcpy() when KASAN is active

Does the initial problem still exist with the new __asan_memcpy() 
approach ? If not the comment should be removed.

>   	 */
>   	memcpy(t, s, sizeof(*t));
>   
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index eb9f556b0937..b763720c68b6 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -1365,8 +1365,8 @@ static void __init prom_check_platform_support(void)
>   	/*
>   	 * First copy the architecture vec template
>   	 *
> -	 * use memcpy() instead of *vec = *vec_template so that GCC replaces it
> -	 * by __memcpy() when KASAN is active
> +	 * use memcpy() instead of *vec = *vec_template so that the compiler
> +	 * replaces it by __asan_memcpy() when KASAN is active

Does the initial problem still exist with the new __asan_memcpy() 
approach ? If not the comment should be removed.

>   	 */
>   	memcpy(&ibm_architecture_vec, &ibm_architecture_vec_template,
>   	       sizeof(ibm_architecture_vec));


