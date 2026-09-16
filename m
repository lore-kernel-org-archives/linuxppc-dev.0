Return-Path: <linuxppc-dev+bounces-27479-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0C9C88E77
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 11:09:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlGPZ2Gw5z2xqp;
	Wed, 16 Sep 2026 21:09:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789556994;
	cv=none; b=P7fnjmv4oXbIeqjtCP5USzUhRFgora5IMGjXOvpSYy+xQes270UgB0qo3haMDe93RPv8aiCOYx3EPvIwSuyGRZHxP8egmOA5HPLZkokUL65rnVrzBw1Q9x2PfG9uPSNbnoBt5vk0K/HOrmr3MPE6csrJ1W42ELwK7FM8JSZcS0d3qKWHrGArmSLzOxx3Uwqfz9ukP0oeBvH8vephT+LkhvxZkK/UGwC1MqHTzkjfud5uFyKy9GeKZ1DLKgkU/BRk23/Whxw7QQ3dFEh977qKmbHOE7sOvvWwAytpE9MJSr7C3ibh/qyzZHtV8+UATgMmy/Wb48IJT9IXI/+s80AmJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789556994; c=relaxed/relaxed;
	bh=2PLyuC7ObcmN5o1FRdyhRGZu33/eQpO13vvhtpaT8pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvuklwToh5VuWtTodfqAvPj1XakfMVf9+PLE7WuI6Ogq2bqqCzlgijz5h12uFLgWRFir3LvuM0e8g3e3/rPz5Td096t0oa4K+eei6u+VMCOXxuFLNmblxyTGa8g7CEw6hy66V2U3mRaUks01H4DLWG2Udb3Z0nuwzZ4fh81V23yopiuH2s56Hdp1ej/+Y9MXV30UL4h2POsCWusfuGGIesRWfsGtpWOzn0y3wjEtOxk5ChVHK2zdD8woLYr64FPreLV2eVmXacd0YUlWj67kOpqzjkuuOZMJJZlk0uc72+L4Ivv+R4jYvkz4CQI5U54t8EdJpNEAaaWFrezztVEgBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZglZRxm; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZglZRxm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlGPX6T08z2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 21:09:52 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BBD9940408;
	Wed, 16 Sep 2026 11:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11D01F000FF;
	Wed, 16 Sep 2026 11:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789556990;
	bh=2PLyuC7ObcmN5o1FRdyhRGZu33/eQpO13vvhtpaT8pY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JZglZRxm033wd4Wy8fNcwq+g6asuPd61w5WLQKJW5cZJfgD5FhbcemAzuX1bxiNZi
	 r9LgxC8c4yxYSfcoeFNHwglfi1/7QLPYsjzZQzhzq58Awh4ZrjZ5v/4Csq9o/JhRrM
	 Bm1Uf9rGN+5mL1bsSrYjZ1/KG66HJ6hjxAq2lNbYgBdmKarmxFZbeJxwJoy3LcOg14
	 cUOjyNlmZ6QwVdaXGoH8VtdQs5vpK8Y5Ux+mQuLkm7n90WcSgsiNsMeigkx6Uhmn2w
	 mLvBdel6Gvodz/Ci5R6aaW443Zi09VB3v5MtJhRXmqMK5RINT5FJNIBtX5R05X8Z/i
	 89Hu4KeGUAsAQ==
Message-ID: <15808e6e-a6c0-49ae-b23e-daa3785a1be0@kernel.org>
Date: Wed, 16 Sep 2026 13:09:41 +0200
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
Subject: Re: [PATCH V3] powerpc/kasan: require memintrinsic prefix support for
 KASAN
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
 dvyukov@google.com, vincenzo.frascino@arm.com, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, kees@kernel.org,
 amachhiw@linux.ibm.com, ritesh.list@gmail.com, nikhilks@linux.ibm.com,
 mahesh@linux.ibm.com, robh@kernel.org, sayalip@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-riscv@lists.infradead.org,
 linux-hardening@vger.kernel.org
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <20260915100938.1337401-1-mkchauras@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260915100938.1337401-1-mkchauras@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 15/09/2026 à 12:09, Mukesh Kumar Chaurasiya (IBM) a écrit :
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
>    __memset as entry points to the same assembly. These aliases were only
>    needed so the C KASAN wrappers in shadow.c could call __memset() to
>    reach raw memory ops; with the compiler prefix approach those wrappers
>    are not used for mem* on powerpc.
> 
> - asm/string.h: remove the separate __memset/__memcpy/__memmove symbol
>    declarations and the memset/memcpy/memmove macro redirections for
>    uninstrumented files that were needed on old toolchains. Simplify the
>    CONFIG_KASAN block to just the three #define aliases (still used by
>    shadow.c as raw backends to bypass KASAN checking).
> 
> - cputable.c, prom_init.c: the memcpy is not required now as the manual
>    instrumentation of memcpy is removed. Hence directly use *dest = *src
>    for this.
> 
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/96dae110-f79b-4e54-8a9b-514369019b5d@linux.ibm.com
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
> Changelog:
> V2 -> V3:
> - *dest = *src used instead of memcpy in cputable.c and prom_init.c

We could have left the memcpy() there but I'm fine either way. What was 
important was to remove the comment as it was valid only for the 
non-CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX case.

If for some reason you have to send a new version, it would be good to 
mention it is a revert of commit adcf59187e27 ("powerpc: don't use 
direct assignation during early boot.") as it is not necessary anymore 
with CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX

Christophe

> V2: https://lore.kernel.org/all/20260911180536.3234640-2-mkchauras@gmail.com
> 
> V1 -> V2:
> - Comments reworded
> - Commit message reworded
> V1: https://lore.kernel.org/all/20260908064948.999530-1-mkchauras@gmail.com
> 
>   arch/powerpc/Kconfig              | 10 +++++++---
>   arch/powerpc/include/asm/kasan.h  | 11 -----------
>   arch/powerpc/include/asm/string.h | 21 +--------------------
>   arch/powerpc/kernel/cputable.c    | 14 ++------------
>   arch/powerpc/kernel/prom_init.c   | 10 ++--------
>   5 files changed, 12 insertions(+), 54 deletions(-)
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
> index a690e7da53c2..d62756b87ba4 100644
> --- a/arch/powerpc/include/asm/kasan.h
> +++ b/arch/powerpc/include/asm/kasan.h
> @@ -2,20 +2,9 @@
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
>   #define _GLOBAL_KASAN(fn)	_GLOBAL(fn)
>   #define _GLOBAL_TOC_KASAN(fn)	_GLOBAL_TOC(fn)
>   #define EXPORT_SYMBOL_KASAN(fn)
> -#endif /* CONFIG_KASAN && !CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
>   
>   #ifndef __ASSEMBLER__
>   
> diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
> index 1981bd4036b5..72b5c93a2b84 100644
> --- a/arch/powerpc/include/asm/string.h
> +++ b/arch/powerpc/include/asm/string.h
> @@ -29,29 +29,10 @@ extern void * memchr(const void *,int,__kernel_size_t);
>   void memcpy_flushcache(void *dest, const void *src, size_t size);
>   
>   #ifdef CONFIG_KASAN
> -/* __mem variants are used by KASAN to implement instrumented meminstrinsics. */
> -#ifdef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> +/* Used by mm/kasan/shadow.c as raw backends to bypass KASAN checking. */
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
> index 6f6801da9dc1..6356b5c6be7b 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -35,12 +35,7 @@ void __init set_cur_cpu_spec(struct cpu_spec *s)
>   	struct cpu_spec *t = &the_cpu_spec;
>   
>   	t = PTRRELOC(t);
> -	/*
> -	 * use memcpy() instead of *t = *s so that GCC replaces it
> -	 * by __memcpy() when KASAN is active
> -	 */
> -	memcpy(t, s, sizeof(*t));
> -
> +	*t = *s;
>   	*PTRRELOC(&cur_cpu_spec) = &the_cpu_spec;
>   }
>   
> @@ -52,12 +47,7 @@ static struct cpu_spec * __init setup_cpu_spec(unsigned long offset,
>   
>   	t = PTRRELOC(t);
>   	old = *t;
> -
> -	/*
> -	 * Copy everything, then do fixups. Use memcpy() instead of *t = *s
> -	 * so that GCC replaces it by __memcpy() when KASAN is active
> -	 */
> -	memcpy(t, s, sizeof(*t));
> +	*t = *s;
>   
>   	/*
>   	 * If we are overriding a previous value derived from the real
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index eb9f556b0937..e8e071024da5 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -1362,14 +1362,8 @@ static void __init prom_check_platform_support(void)
>   	int prop_len = prom_getproplen(prom.chosen,
>   				       "ibm,arch-vec-5-platform-support");
>   
> -	/*
> -	 * First copy the architecture vec template
> -	 *
> -	 * use memcpy() instead of *vec = *vec_template so that GCC replaces it
> -	 * by __memcpy() when KASAN is active
> -	 */
> -	memcpy(&ibm_architecture_vec, &ibm_architecture_vec_template,
> -	       sizeof(ibm_architecture_vec));
> +	/* First copy the architecture vec template */
> +	ibm_architecture_vec = ibm_architecture_vec_template;
>   
>   	prom_strscpy_pad(ibm_architecture_vec.vec7.os_id, linux_banner, 256);
>   


