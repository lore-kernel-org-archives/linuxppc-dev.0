Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615DFC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 06:56:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1BCC218CD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 06:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="GBVBe2IP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1BCC218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448RLD61tszDqJS
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 17:56:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="GBVBe2IP"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448RJT3WNLzDqJR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 17:55:03 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id h11so7492749pgl.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 22:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=ALlyeDQ+17/DtTOUvMgCQbekcr7m6lXtdxY4HBgDEb0=;
 b=GBVBe2IPwZ13QAdllliQtO1WeLVc3hNYqQm/wqGtiu5Ln2pOnlVZnRPcUgGJKpoNqC
 krM6sDT4voeFm/hdmHREFAxs5yHcWKYo7XQ42QMS8Jtbt3+G2ITZCN7cckLi+upGtfH7
 WzSqljsE4k5twyuCsTFdbFhxzxqdfeB4kDWfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=ALlyeDQ+17/DtTOUvMgCQbekcr7m6lXtdxY4HBgDEb0=;
 b=MkkXc+GPhR9gzTUV3oR8NvzCQfva3tbxBmtAOIZpejoOJtLOT3lEOr1p6yCH8IqoNk
 LVJrT2TXieIYB6RXpdD1AMm3X0DANBXouR16pGW67mnRML1hkSu/FVuiL2UJbXoimFRO
 UBfA4apQnmuBI3rYKEBULawFRgUI52FLfg934xLV0fJfXV8m6wk57TxBlEiKlqIIcyw8
 koISZXIuh1Ig9GCrVboRZ6QKECqxx2F40gMLGFIjPgXqUhPXt9WVxLlwEJ/mV/Xwt6p+
 hXD+n7VQ3HmbDN+NK2pyvFamnF8tWqsjDWK2CpzRs9Haeydw1yLKrdboWNr8ttWwBb4q
 bQAA==
X-Gm-Message-State: AHQUAublndebupfNrnr7A8FURVnxGke94JBccZIo7XlZomv8iS/KgCdH
 ut30BVC4en2ua+lC2tYysUaHOw==
X-Google-Smtp-Source: AHgI3IbiPy9uUCRaro/P/CbUrQYgI8Mhn+niPyGv47A0TxjGhYmYl3CA2xNwi9XI9TR1K2ZBBTEE9g==
X-Received: by 2002:a62:20c9:: with SMTP id m70mr167765pfj.118.1551250500118; 
 Tue, 26 Feb 2019 22:55:00 -0800 (PST)
Received: from localhost (203-59-50-226.dyn.iinet.net.au. [203.59.50.226])
 by smtp.gmail.com with ESMTPSA id m13sm24505555pff.175.2019.02.26.22.54.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 26 Feb 2019 22:54:59 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v8 02/11] powerpc: prepare string/mem functions for KASAN
In-Reply-To: <54c5d48a557647be5e0269a22be277891bbdd7f7.1551161392.git.christophe.leroy@c-s.fr>
References: <cover.1551161392.git.christophe.leroy@c-s.fr>
 <54c5d48a557647be5e0269a22be277891bbdd7f7.1551161392.git.christophe.leroy@c-s.fr>
Date: Wed, 27 Feb 2019 17:54:54 +1100
Message-ID: <877edl3em9.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> CONFIG_KASAN implements wrappers for memcpy() memmove() and memset()
> Those wrappers are doing the verification then call respectively
> __memcpy() __memmove() and __memset(). The arches are therefore
> expected to rename their optimised functions that way.
>
> For files on which KASAN is inhibited, #defines are used to allow
> them to directly call optimised versions of the functions without
> going through the KASAN wrappers.
>
> See commit 393f203f5fd5 ("x86_64: kasan: add interceptors for
> memset/memmove/memcpy functions") for details.
>
> Other string / mem functions do not (yet) have kasan wrappers,
> we therefore have to fallback to the generic versions when
> KASAN is active, otherwise KASAN checks will be skipped.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/kasan.h       | 15 +++++++++++++++
>  arch/powerpc/include/asm/string.h      | 32 +++++++++++++++++++++++++++++---
>  arch/powerpc/kernel/prom_init_check.sh | 10 +++++++++-
>  arch/powerpc/lib/Makefile              | 11 ++++++++---
>  arch/powerpc/lib/copy_32.S             | 15 +++++++++------
>  arch/powerpc/lib/mem_64.S              | 11 +++++++----
>  arch/powerpc/lib/memcpy_64.S           |  5 +++--
>  7 files changed, 80 insertions(+), 19 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/kasan.h
>
> diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
> new file mode 100644
> index 000000000000..c3161b8fc017
> --- /dev/null
> +++ b/arch/powerpc/include/asm/kasan.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_KASAN_H
> +#define __ASM_KASAN_H
> +
> +#ifdef CONFIG_KASAN
> +#define _GLOBAL_KASAN(fn)	.weak fn ; _GLOBAL(__##fn) ; _GLOBAL(fn)
> +#define _GLOBAL_TOC_KASAN(fn)	.weak fn ; _GLOBAL_TOC(__##fn) ; _GLOBAL_TOC(fn)
> +#define EXPORT_SYMBOL_KASAN(fn)	EXPORT_SYMBOL(__##fn) ; EXPORT_SYMBOL(fn)

[FWIW, and this shouldn't block your patch:] This doesn't seem to work
with the 64bit elf abi v1, as we have symbols and dot symbols - our
_GLOBAL* doesn't just create a symtab entry. I don't fully understand
the inner workings just yet, but Aneesh and Balbir have solutions that
use .set instead of creating two entries.

What I am also struggling with is why we export the __symbol
version. I know the x86 version does this, but I can't figure that out
either - why would a module need an uninstrumented copy?

Anyway, I am getting some issues such as:

WARNING: EXPORT symbol "__memcpy" [vmlinux] version generation failed, symbol will not be versioned.
WARNING: EXPORT symbol "__memset" [vmlinux] version generation failed, symbol will not be versioned.
WARNING: EXPORT symbol "__memmove" [vmlinux] version generation failed, symbol will not be versioned.

I think Balbir and Aneesh avoided this by just not ever exporting the
__symbol versions, but perhaps that won't fly for the final version. It
looks like we can also avoid this by jumping through some extra hoops
and creating new weak symbols - I'll keep working on it and let you know
how I go.

As I said, I don't think this should necessarily block your patches -
it's just notes on ppc64 progress.

Regards,
Daniel

> +#else
> +#define _GLOBAL_KASAN(fn)	_GLOBAL(fn)
> +#define _GLOBAL_TOC_KASAN(fn)	_GLOBAL_TOC(fn)
> +#define EXPORT_SYMBOL_KASAN(fn)	EXPORT_SYMBOL(fn)
> +#endif
> +
> +#endif
> diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
> index 1647de15a31e..9bf6dffb4090 100644
> --- a/arch/powerpc/include/asm/string.h
> +++ b/arch/powerpc/include/asm/string.h
> @@ -4,14 +4,17 @@
>  
>  #ifdef __KERNEL__
>  
> +#ifndef CONFIG_KASAN
>  #define __HAVE_ARCH_STRNCPY
>  #define __HAVE_ARCH_STRNCMP
> +#define __HAVE_ARCH_MEMCHR
> +#define __HAVE_ARCH_MEMCMP
> +#define __HAVE_ARCH_MEMSET16
> +#endif
> +
>  #define __HAVE_ARCH_MEMSET
>  #define __HAVE_ARCH_MEMCPY
>  #define __HAVE_ARCH_MEMMOVE
> -#define __HAVE_ARCH_MEMCMP
> -#define __HAVE_ARCH_MEMCHR
> -#define __HAVE_ARCH_MEMSET16
>  #define __HAVE_ARCH_MEMCPY_FLUSHCACHE
>  
>  extern char * strcpy(char *,const char *);
> @@ -27,7 +30,27 @@ extern int memcmp(const void *,const void *,__kernel_size_t);
>  extern void * memchr(const void *,int,__kernel_size_t);
>  extern void * memcpy_flushcache(void *,const void *,__kernel_size_t);
>  
> +void *__memset(void *s, int c, __kernel_size_t count);
> +void *__memcpy(void *to, const void *from, __kernel_size_t n);
> +void *__memmove(void *to, const void *from, __kernel_size_t n);
> +
> +#if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
> +/*
> + * For files that are not instrumented (e.g. mm/slub.c) we
> + * should use not instrumented version of mem* functions.
> + */
> +#define memcpy(dst, src, len) __memcpy(dst, src, len)
> +#define memmove(dst, src, len) __memmove(dst, src, len)
> +#define memset(s, c, n) __memset(s, c, n)
> +
> +#ifndef __NO_FORTIFY
> +#define __NO_FORTIFY /* FORTIFY_SOURCE uses __builtin_memcpy, etc. */
> +#endif
> +
> +#endif
> +
>  #ifdef CONFIG_PPC64
> +#ifndef CONFIG_KASAN
>  #define __HAVE_ARCH_MEMSET32
>  #define __HAVE_ARCH_MEMSET64
>  
> @@ -49,8 +72,11 @@ static inline void *memset64(uint64_t *p, uint64_t v, __kernel_size_t n)
>  {
>  	return __memset64(p, v, n * 8);
>  }
> +#endif
>  #else
> +#ifndef CONFIG_KASAN
>  #define __HAVE_ARCH_STRLEN
> +#endif
>  
>  extern void *memset16(uint16_t *, uint16_t, __kernel_size_t);
>  #endif
> diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
> index 667df97d2595..181fd10008ef 100644
> --- a/arch/powerpc/kernel/prom_init_check.sh
> +++ b/arch/powerpc/kernel/prom_init_check.sh
> @@ -16,8 +16,16 @@
>  # If you really need to reference something from prom_init.o add
>  # it to the list below:
>  
> +grep "^CONFIG_KASAN=y$" .config >/dev/null
> +if [ $? -eq 0 ]
> +then
> +	MEM_FUNCS="__memcpy __memset"
> +else
> +	MEM_FUNCS="memcpy memset"
> +fi
> +
>  WHITELIST="add_reloc_offset __bss_start __bss_stop copy_and_flush
> -_end enter_prom memcpy memset reloc_offset __secondary_hold
> +_end enter_prom $MEM_FUNCS reloc_offset __secondary_hold
>  __secondary_hold_acknowledge __secondary_hold_spinloop __start
>  strcmp strcpy strlcpy strlen strncmp strstr kstrtobool logo_linux_clut224
>  reloc_got2 kernstart_addr memstart_addr linux_banner _stext
> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> index 79396e184bca..47a4de434c22 100644
> --- a/arch/powerpc/lib/Makefile
> +++ b/arch/powerpc/lib/Makefile
> @@ -8,9 +8,14 @@ ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
>  CFLAGS_REMOVE_code-patching.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_feature-fixups.o = $(CC_FLAGS_FTRACE)
>  
> -obj-y += string.o alloc.o code-patching.o feature-fixups.o
> +obj-y += alloc.o code-patching.o feature-fixups.o
>  
> -obj-$(CONFIG_PPC32)	+= div64.o copy_32.o crtsavres.o strlen_32.o
> +ifndef CONFIG_KASAN
> +obj-y	+=	string.o memcmp_$(BITS).o
> +obj-$(CONFIG_PPC32)	+= strlen_32.o
> +endif
> +
> +obj-$(CONFIG_PPC32)	+= div64.o copy_32.o crtsavres.o
>  
>  obj-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
>  
> @@ -34,7 +39,7 @@ obj64-$(CONFIG_KPROBES_SANITY_TEST)	+= test_emulate_step.o \
>  					   test_emulate_step_exec_instr.o
>  
>  obj-y			+= checksum_$(BITS).o checksum_wrappers.o \
> -			   string_$(BITS).o memcmp_$(BITS).o
> +			   string_$(BITS).o
>  
>  obj-y			+= sstep.o ldstfp.o quad.o
>  obj64-y			+= quad.o
> diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
> index ba66846fe973..fc4fa7246200 100644
> --- a/arch/powerpc/lib/copy_32.S
> +++ b/arch/powerpc/lib/copy_32.S
> @@ -14,6 +14,7 @@
>  #include <asm/ppc_asm.h>
>  #include <asm/export.h>
>  #include <asm/code-patching-asm.h>
> +#include <asm/kasan.h>
>  
>  #define COPY_16_BYTES		\
>  	lwz	r7,4(r4);	\
> @@ -68,6 +69,7 @@ CACHELINE_BYTES = L1_CACHE_BYTES
>  LG_CACHELINE_BYTES = L1_CACHE_SHIFT
>  CACHELINE_MASK = (L1_CACHE_BYTES-1)
>  
> +#ifndef CONFIG_KASAN
>  _GLOBAL(memset16)
>  	rlwinm.	r0 ,r5, 31, 1, 31
>  	addi	r6, r3, -4
> @@ -81,6 +83,7 @@ _GLOBAL(memset16)
>  	sth	r4, 4(r6)
>  	blr
>  EXPORT_SYMBOL(memset16)
> +#endif
>  
>  /*
>   * Use dcbz on the complete cache lines in the destination
> @@ -91,7 +94,7 @@ EXPORT_SYMBOL(memset16)
>   * We therefore skip the optimised bloc that uses dcbz. This jump is
>   * replaced by a nop once cache is active. This is done in machine_init()
>   */
> -_GLOBAL(memset)
> +_GLOBAL_KASAN(memset)
>  	cmplwi	0,r5,4
>  	blt	7f
>  
> @@ -150,7 +153,7 @@ _GLOBAL(memset)
>  9:	stbu	r4,1(r6)
>  	bdnz	9b
>  	blr
> -EXPORT_SYMBOL(memset)
> +EXPORT_SYMBOL_KASAN(memset)
>  
>  /*
>   * This version uses dcbz on the complete cache lines in the
> @@ -163,12 +166,12 @@ EXPORT_SYMBOL(memset)
>   * We therefore jump to generic_memcpy which doesn't use dcbz. This jump is
>   * replaced by a nop once cache is active. This is done in machine_init()
>   */
> -_GLOBAL(memmove)
> +_GLOBAL_KASAN(memmove)
>  	cmplw	0,r3,r4
>  	bgt	backwards_memcpy
>  	/* fall through */
>  
> -_GLOBAL(memcpy)
> +_GLOBAL_KASAN(memcpy)
>  1:	b	generic_memcpy
>  	patch_site	1b, patch__memcpy_nocache
>  
> @@ -242,8 +245,8 @@ _GLOBAL(memcpy)
>  	stbu	r0,1(r6)
>  	bdnz	40b
>  65:	blr
> -EXPORT_SYMBOL(memcpy)
> -EXPORT_SYMBOL(memmove)
> +EXPORT_SYMBOL_KASAN(memcpy)
> +EXPORT_SYMBOL_KASAN(memmove)
>  
>  generic_memcpy:
>  	srwi.	r7,r5,3
> diff --git a/arch/powerpc/lib/mem_64.S b/arch/powerpc/lib/mem_64.S
> index 3c3be02f33b7..7cd6cf6822a2 100644
> --- a/arch/powerpc/lib/mem_64.S
> +++ b/arch/powerpc/lib/mem_64.S
> @@ -12,7 +12,9 @@
>  #include <asm/errno.h>
>  #include <asm/ppc_asm.h>
>  #include <asm/export.h>
> +#include <asm/kasan.h>
>  
> +#ifndef CONFIG_KASAN
>  _GLOBAL(__memset16)
>  	rlwimi	r4,r4,16,0,15
>  	/* fall through */
> @@ -29,8 +31,9 @@ _GLOBAL(__memset64)
>  EXPORT_SYMBOL(__memset16)
>  EXPORT_SYMBOL(__memset32)
>  EXPORT_SYMBOL(__memset64)
> +#endif
>  
> -_GLOBAL(memset)
> +_GLOBAL_KASAN(memset)
>  	neg	r0,r3
>  	rlwimi	r4,r4,8,16,23
>  	andi.	r0,r0,7			/* # bytes to be 8-byte aligned */
> @@ -95,9 +98,9 @@ _GLOBAL(memset)
>  10:	bflr	31
>  	stb	r4,0(r6)
>  	blr
> -EXPORT_SYMBOL(memset)
> +EXPORT_SYMBOL_KASAN(memset)
>  
> -_GLOBAL_TOC(memmove)
> +_GLOBAL_TOC_KASAN(memmove)
>  	cmplw	0,r3,r4
>  	bgt	backwards_memcpy
>  	b	memcpy
> @@ -138,4 +141,4 @@ _GLOBAL(backwards_memcpy)
>  	beq	2b
>  	mtctr	r7
>  	b	1b
> -EXPORT_SYMBOL(memmove)
> +EXPORT_SYMBOL_KASAN(memmove)
> diff --git a/arch/powerpc/lib/memcpy_64.S b/arch/powerpc/lib/memcpy_64.S
> index 273ea67e60a1..862b515b8868 100644
> --- a/arch/powerpc/lib/memcpy_64.S
> +++ b/arch/powerpc/lib/memcpy_64.S
> @@ -11,6 +11,7 @@
>  #include <asm/export.h>
>  #include <asm/asm-compat.h>
>  #include <asm/feature-fixups.h>
> +#include <asm/kasan.h>
>  
>  #ifndef SELFTEST_CASE
>  /* For big-endian, 0 == most CPUs, 1 == POWER6, 2 == Cell */
> @@ -18,7 +19,7 @@
>  #endif
>  
>  	.align	7
> -_GLOBAL_TOC(memcpy)
> +_GLOBAL_TOC_KASAN(memcpy)
>  BEGIN_FTR_SECTION
>  #ifdef __LITTLE_ENDIAN__
>  	cmpdi	cr7,r5,0
> @@ -229,4 +230,4 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
>  4:	ld	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)	/* return dest pointer */
>  	blr
>  #endif
> -EXPORT_SYMBOL(memcpy)
> +EXPORT_SYMBOL_KASAN(memcpy)
> -- 
> 2.13.3
