Return-Path: <SRS0=vgOh=RJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA2CC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 21:56:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6F4A20663
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 21:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="XlRyhqkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F4A20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44F6z93HpKzDqCW
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 08:56:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="XlRyhqkq"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44F6x11jSMzDqC5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2019 08:54:27 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44F6wv3g43z9vBwH;
 Wed,  6 Mar 2019 22:54:23 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=XlRyhqkq; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 273gzFdN5yJi; Wed,  6 Mar 2019 22:54:23 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44F6wv2VRgz9vBwC;
 Wed,  6 Mar 2019 22:54:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1551909263; bh=CGxYoqjaGuMadUkLxrfjnlC6FBZGZqJqaeni3+wCIDY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=XlRyhqkqavVwbeiS6mwQnLZHW5+JZTRbTno00ZCyDiny3OCr3/228JQ8cvYFfPm/C
 0Pd5oeXTyMjXXAaeZhXFUPLO/MBwFniFqvcx3x+eFBXmd5WAwAXBTUrYPtVi3u7y2d
 qrIgWdrlH80VeS1bpb9uwXiGYfqCZfasFx5drbQY=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 856C28B8AB;
 Wed,  6 Mar 2019 22:54:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id veWWKZs18AFI; Wed,  6 Mar 2019 22:54:23 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 686DC8B883;
 Wed,  6 Mar 2019 22:54:22 +0100 (CET)
Subject: Re: [PATCH v9 02/11] powerpc: prepare string/mem functions for KASAN
To: Daniel Axtens <dja@axtens.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>
References: <cover.1551443452.git.christophe.leroy@c-s.fr>
 <45fb252fc1b27f2804109fa35ba2882ae29e6035.1551443453.git.christophe.leroy@c-s.fr>
 <87sgw31a85.fsf@dja-thinkpad.axtens.net>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <c69636a6-1f43-78e6-ff88-a3e4f3a35132@c-s.fr>
Date: Wed, 6 Mar 2019 22:54:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <87sgw31a85.fsf@dja-thinkpad.axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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



Le 04/03/2019 à 06:26, Daniel Axtens a écrit :
> Hi Christophe,
>> diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
>> new file mode 100644
>> index 000000000000..c3161b8fc017
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/kasan.h
>> @@ -0,0 +1,15 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __ASM_KASAN_H
>> +#define __ASM_KASAN_H
>> +
>> +#ifdef CONFIG_KASAN
>> +#define _GLOBAL_KASAN(fn)	.weak fn ; _GLOBAL(__##fn) ; _GLOBAL(fn)
>> +#define _GLOBAL_TOC_KASAN(fn)	.weak fn ; _GLOBAL_TOC(__##fn) ; _GLOBAL_TOC(fn)
>> +#define EXPORT_SYMBOL_KASAN(fn)	EXPORT_SYMBOL(__##fn) ; EXPORT_SYMBOL(fn)
> 
> I'm having some trouble with this. I get warnings like this:

I don't have such problem, neither with ppc32 nor with ppc64e_defconfig.

What config are you using ?

Another (unrelated) question I have:
On the initial arm64 implementation (39d114ddc682 arm64: add KASAN 
support) they made KASAN implementation depend on SPARSEMEM_VMEMMAP 
(allthough they later removed that dependency with commit e17d8025f07e 
arm64/mm/kasan: don't use vmemmap_populate() to initialize shadow)

So I'm wondering why on your side, KASAN depends on !SPARSEMEM_VMEMMAP

Thanks
Christophe

> 
> WARNING: EXPORT symbol "__memcpy" [vmlinux] version generation failed, symbol will not be versioned.
> 
> It seems to be related to the export line, as if I swap the exports to
> do fn before __##fn I get:
> 
> WARNING: EXPORT symbol "memset" [vmlinux] version generation failed, symbol will not be versioned.
> 
> I have narrowed this down to combining 2 EXPORT_SYMBOL()s on one line.
> This works - no warning:
> 
> EXPORT_SYMBOL(memset)
> EXPORT_SYMBOL(__memset)
> 
> This throws a warning:
> 
> EXPORT_SYMBOL(memset) ; EXPORT_SYMBOL(__memset)
> 
> I notice in looking at the diff of preprocessed source we end up
> invoking an asm macro that doesn't seem to have a full final argument, I
> wonder if that's relevant...
> 
> -___EXPORT_SYMBOL __memset, __memset, ; ___EXPORT_SYMBOL memset, memset,
> +___EXPORT_SYMBOL __memset, __memset,
> +___EXPORT_SYMBOL memset, memset,
> 
> I also notice that nowhere else in the source do people have multiple
> EXPORT_SYMBOLs on the same line, and other arches seem to just
> unconditionally export both symbols on multiple lines.
> 
> I have no idea how this works for you - maybe it's affected by something 32bit.
> 
> How would you feel about this approach instead? I'm not tied to any of
> the names or anything.
> 
> diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
> index e0637730a8e7..7b6a91b448dd 100644
> --- a/arch/powerpc/include/asm/ppc_asm.h
> +++ b/arch/powerpc/include/asm/ppc_asm.h
> @@ -214,6 +214,9 @@ name: \
>   
>   #define DOTSYM(a)      a
>   
> +#define PROVIDE_WEAK_ALIAS(strongname, weakname) \
> +       .weak weakname ; .set weakname, strongname ;
> +
>   #else
>   
>   #define XGLUE(a,b) a##b
> @@ -236,6 +239,10 @@ GLUE(.,name):
>   
>   #define DOTSYM(a)      GLUE(.,a)
>   
> +#define PROVIDE_WEAK_ALIAS(strongname, weakname) \
> +       .weak weakname ; .set weakname, strongname ; \
> +       .weak DOTSYM(weakname) ; .set DOTSYM(weakname), DOTSYM(strongname) ;
> +
>   #endif
>   
>   #else /* 32-bit */
> @@ -251,6 +258,9 @@ GLUE(.,name):
>   
>   #define _GLOBAL_TOC(name) _GLOBAL(name)
>   
> +#define PROVIDE_WEAK_ALIAS(strongname, weakname) \
> +       .weak weakname ; .set weakname, strongname ;
> +
>   #endif
>   
>   /*
> --- a/arch/powerpc/lib/mem_64.S
> +++ b/arch/powerpc/lib/mem_64.S
> @@ -33,7 +33,8 @@ EXPORT_SYMBOL(__memset32)
>   EXPORT_SYMBOL(__memset64)
>   #endif
>   
> -_GLOBAL_KASAN(memset)
> +PROVIDE_WEAK_ALIAS(__memset,memset)
> +_GLOBAL(__memset)
>          neg     r0,r3
>          rlwimi  r4,r4,8,16,23
>          andi.   r0,r0,7                 /* # bytes to be 8-byte aligned */
> @@ -98,9 +99,11 @@ _GLOBAL_KASAN(memset)
>   10:    bflr    31
>          stb     r4,0(r6)
>          blr
> -EXPORT_SYMBOL_KASAN(memset)
> +EXPORT_SYMBOL(memset)
> +EXPORT_SYMBOL(__memset)
>   
> -_GLOBAL_TOC_KASAN(memmove)
> +PROVIDE_WEAK_ALIAS(__memmove,memove)
> +_GLOBAL_TOC(__memmove)
>          cmplw   0,r3,r4
>          bgt     backwards_memcpy
>          b       memcpy
> @@ -141,4 +144,5 @@ _GLOBAL(backwards_memcpy)
>          beq     2b
>          mtctr   r7
>          b       1b
> -EXPORT_SYMBOL_KASAN(memmove)
> +EXPORT_SYMBOL(memmove)
> +EXPORT_SYMBOL(__memmove)
> diff --git a/arch/powerpc/lib/memcpy_64.S b/arch/powerpc/lib/memcpy_64.S
> index 862b515b8868..7c1b09556cad 100644
> --- a/arch/powerpc/lib/memcpy_64.S
> +++ b/arch/powerpc/lib/memcpy_64.S
> @@ -19,7 +19,8 @@
>   #endif
>   
>          .align  7
> -_GLOBAL_TOC_KASAN(memcpy)
> +PROVIDE_WEAK_ALIAS(__memcpy,memcpy)
> +_GLOBAL_TOC(__memcpy)
>   BEGIN_FTR_SECTION
>   #ifdef __LITTLE_ENDIAN__
>          cmpdi   cr7,r5,0
> @@ -230,4 +231,5 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
>   4:     ld      r3,-STACKFRAMESIZE+STK_REG(R31)(r1)     /* return dest pointer */
>          blr
>   #endif
> -EXPORT_SYMBOL_KASAN(memcpy)
> +EXPORT_SYMBOL(__memcpy)
> +EXPORT_SYMBOL(memcpy)
> 
> 
> Regards,
> Daniel
> 
> 
>> +#else
>> +#define _GLOBAL_KASAN(fn)	_GLOBAL(fn)
>> +#define _GLOBAL_TOC_KASAN(fn)	_GLOBAL_TOC(fn)
>> +#define EXPORT_SYMBOL_KASAN(fn)	EXPORT_SYMBOL(fn)
>> +#endif
>> +
>> +#endif
>> diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
>> index 1647de15a31e..9bf6dffb4090 100644
>> --- a/arch/powerpc/include/asm/string.h
>> +++ b/arch/powerpc/include/asm/string.h
>> @@ -4,14 +4,17 @@
>>   
>>   #ifdef __KERNEL__
>>   
>> +#ifndef CONFIG_KASAN
>>   #define __HAVE_ARCH_STRNCPY
>>   #define __HAVE_ARCH_STRNCMP
>> +#define __HAVE_ARCH_MEMCHR
>> +#define __HAVE_ARCH_MEMCMP
>> +#define __HAVE_ARCH_MEMSET16
>> +#endif
>> +
>>   #define __HAVE_ARCH_MEMSET
>>   #define __HAVE_ARCH_MEMCPY
>>   #define __HAVE_ARCH_MEMMOVE
>> -#define __HAVE_ARCH_MEMCMP
>> -#define __HAVE_ARCH_MEMCHR
>> -#define __HAVE_ARCH_MEMSET16
>>   #define __HAVE_ARCH_MEMCPY_FLUSHCACHE
>>   
>>   extern char * strcpy(char *,const char *);
>> @@ -27,7 +30,27 @@ extern int memcmp(const void *,const void *,__kernel_size_t);
>>   extern void * memchr(const void *,int,__kernel_size_t);
>>   extern void * memcpy_flushcache(void *,const void *,__kernel_size_t);
>>   
>> +void *__memset(void *s, int c, __kernel_size_t count);
>> +void *__memcpy(void *to, const void *from, __kernel_size_t n);
>> +void *__memmove(void *to, const void *from, __kernel_size_t n);
>> +
>> +#if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
>> +/*
>> + * For files that are not instrumented (e.g. mm/slub.c) we
>> + * should use not instrumented version of mem* functions.
>> + */
>> +#define memcpy(dst, src, len) __memcpy(dst, src, len)
>> +#define memmove(dst, src, len) __memmove(dst, src, len)
>> +#define memset(s, c, n) __memset(s, c, n)
>> +
>> +#ifndef __NO_FORTIFY
>> +#define __NO_FORTIFY /* FORTIFY_SOURCE uses __builtin_memcpy, etc. */
>> +#endif
>> +
>> +#endif
>> +
>>   #ifdef CONFIG_PPC64
>> +#ifndef CONFIG_KASAN
>>   #define __HAVE_ARCH_MEMSET32
>>   #define __HAVE_ARCH_MEMSET64
>>   
>> @@ -49,8 +72,11 @@ static inline void *memset64(uint64_t *p, uint64_t v, __kernel_size_t n)
>>   {
>>   	return __memset64(p, v, n * 8);
>>   }
>> +#endif
>>   #else
>> +#ifndef CONFIG_KASAN
>>   #define __HAVE_ARCH_STRLEN
>> +#endif
>>   
>>   extern void *memset16(uint16_t *, uint16_t, __kernel_size_t);
>>   #endif
>> diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
>> index 667df97d2595..181fd10008ef 100644
>> --- a/arch/powerpc/kernel/prom_init_check.sh
>> +++ b/arch/powerpc/kernel/prom_init_check.sh
>> @@ -16,8 +16,16 @@
>>   # If you really need to reference something from prom_init.o add
>>   # it to the list below:
>>   
>> +grep "^CONFIG_KASAN=y$" .config >/dev/null
>> +if [ $? -eq 0 ]
>> +then
>> +	MEM_FUNCS="__memcpy __memset"
>> +else
>> +	MEM_FUNCS="memcpy memset"
>> +fi
>> +
>>   WHITELIST="add_reloc_offset __bss_start __bss_stop copy_and_flush
>> -_end enter_prom memcpy memset reloc_offset __secondary_hold
>> +_end enter_prom $MEM_FUNCS reloc_offset __secondary_hold
>>   __secondary_hold_acknowledge __secondary_hold_spinloop __start
>>   strcmp strcpy strlcpy strlen strncmp strstr kstrtobool logo_linux_clut224
>>   reloc_got2 kernstart_addr memstart_addr linux_banner _stext
>> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
>> index 79396e184bca..47a4de434c22 100644
>> --- a/arch/powerpc/lib/Makefile
>> +++ b/arch/powerpc/lib/Makefile
>> @@ -8,9 +8,14 @@ ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
>>   CFLAGS_REMOVE_code-patching.o = $(CC_FLAGS_FTRACE)
>>   CFLAGS_REMOVE_feature-fixups.o = $(CC_FLAGS_FTRACE)
>>   
>> -obj-y += string.o alloc.o code-patching.o feature-fixups.o
>> +obj-y += alloc.o code-patching.o feature-fixups.o
>>   
>> -obj-$(CONFIG_PPC32)	+= div64.o copy_32.o crtsavres.o strlen_32.o
>> +ifndef CONFIG_KASAN
>> +obj-y	+=	string.o memcmp_$(BITS).o
>> +obj-$(CONFIG_PPC32)	+= strlen_32.o
>> +endif
>> +
>> +obj-$(CONFIG_PPC32)	+= div64.o copy_32.o crtsavres.o
>>   
>>   obj-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
>>   
>> @@ -34,7 +39,7 @@ obj64-$(CONFIG_KPROBES_SANITY_TEST)	+= test_emulate_step.o \
>>   					   test_emulate_step_exec_instr.o
>>   
>>   obj-y			+= checksum_$(BITS).o checksum_wrappers.o \
>> -			   string_$(BITS).o memcmp_$(BITS).o
>> +			   string_$(BITS).o
>>   
>>   obj-y			+= sstep.o ldstfp.o quad.o
>>   obj64-y			+= quad.o
>> diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
>> index ba66846fe973..fc4fa7246200 100644
>> --- a/arch/powerpc/lib/copy_32.S
>> +++ b/arch/powerpc/lib/copy_32.S
>> @@ -14,6 +14,7 @@
>>   #include <asm/ppc_asm.h>
>>   #include <asm/export.h>
>>   #include <asm/code-patching-asm.h>
>> +#include <asm/kasan.h>
>>   
>>   #define COPY_16_BYTES		\
>>   	lwz	r7,4(r4);	\
>> @@ -68,6 +69,7 @@ CACHELINE_BYTES = L1_CACHE_BYTES
>>   LG_CACHELINE_BYTES = L1_CACHE_SHIFT
>>   CACHELINE_MASK = (L1_CACHE_BYTES-1)
>>   
>> +#ifndef CONFIG_KASAN
>>   _GLOBAL(memset16)
>>   	rlwinm.	r0 ,r5, 31, 1, 31
>>   	addi	r6, r3, -4
>> @@ -81,6 +83,7 @@ _GLOBAL(memset16)
>>   	sth	r4, 4(r6)
>>   	blr
>>   EXPORT_SYMBOL(memset16)
>> +#endif
>>   
>>   /*
>>    * Use dcbz on the complete cache lines in the destination
>> @@ -91,7 +94,7 @@ EXPORT_SYMBOL(memset16)
>>    * We therefore skip the optimised bloc that uses dcbz. This jump is
>>    * replaced by a nop once cache is active. This is done in machine_init()
>>    */
>> -_GLOBAL(memset)
>> +_GLOBAL_KASAN(memset)
>>   	cmplwi	0,r5,4
>>   	blt	7f
>>   
>> @@ -150,7 +153,7 @@ _GLOBAL(memset)
>>   9:	stbu	r4,1(r6)
>>   	bdnz	9b
>>   	blr
>> -EXPORT_SYMBOL(memset)
>> +EXPORT_SYMBOL_KASAN(memset)
>>   
>>   /*
>>    * This version uses dcbz on the complete cache lines in the
>> @@ -163,12 +166,12 @@ EXPORT_SYMBOL(memset)
>>    * We therefore jump to generic_memcpy which doesn't use dcbz. This jump is
>>    * replaced by a nop once cache is active. This is done in machine_init()
>>    */
>> -_GLOBAL(memmove)
>> +_GLOBAL_KASAN(memmove)
>>   	cmplw	0,r3,r4
>>   	bgt	backwards_memcpy
>>   	/* fall through */
>>   
>> -_GLOBAL(memcpy)
>> +_GLOBAL_KASAN(memcpy)
>>   1:	b	generic_memcpy
>>   	patch_site	1b, patch__memcpy_nocache
>>   
>> @@ -242,8 +245,8 @@ _GLOBAL(memcpy)
>>   	stbu	r0,1(r6)
>>   	bdnz	40b
>>   65:	blr
>> -EXPORT_SYMBOL(memcpy)
>> -EXPORT_SYMBOL(memmove)
>> +EXPORT_SYMBOL_KASAN(memcpy)
>> +EXPORT_SYMBOL_KASAN(memmove)
>>   
>>   generic_memcpy:
>>   	srwi.	r7,r5,3
>> diff --git a/arch/powerpc/lib/mem_64.S b/arch/powerpc/lib/mem_64.S
>> index 3c3be02f33b7..7cd6cf6822a2 100644
>> --- a/arch/powerpc/lib/mem_64.S
>> +++ b/arch/powerpc/lib/mem_64.S
>> @@ -12,7 +12,9 @@
>>   #include <asm/errno.h>
>>   #include <asm/ppc_asm.h>
>>   #include <asm/export.h>
>> +#include <asm/kasan.h>
>>   
>> +#ifndef CONFIG_KASAN
>>   _GLOBAL(__memset16)
>>   	rlwimi	r4,r4,16,0,15
>>   	/* fall through */
>> @@ -29,8 +31,9 @@ _GLOBAL(__memset64)
>>   EXPORT_SYMBOL(__memset16)
>>   EXPORT_SYMBOL(__memset32)
>>   EXPORT_SYMBOL(__memset64)
>> +#endif
>>   
>> -_GLOBAL(memset)
>> +_GLOBAL_KASAN(memset)
>>   	neg	r0,r3
>>   	rlwimi	r4,r4,8,16,23
>>   	andi.	r0,r0,7			/* # bytes to be 8-byte aligned */
>> @@ -95,9 +98,9 @@ _GLOBAL(memset)
>>   10:	bflr	31
>>   	stb	r4,0(r6)
>>   	blr
>> -EXPORT_SYMBOL(memset)
>> +EXPORT_SYMBOL_KASAN(memset)
>>   
>> -_GLOBAL_TOC(memmove)
>> +_GLOBAL_TOC_KASAN(memmove)
>>   	cmplw	0,r3,r4
>>   	bgt	backwards_memcpy
>>   	b	memcpy
>> @@ -138,4 +141,4 @@ _GLOBAL(backwards_memcpy)
>>   	beq	2b
>>   	mtctr	r7
>>   	b	1b
>> -EXPORT_SYMBOL(memmove)
>> +EXPORT_SYMBOL_KASAN(memmove)
>> diff --git a/arch/powerpc/lib/memcpy_64.S b/arch/powerpc/lib/memcpy_64.S
>> index 273ea67e60a1..862b515b8868 100644
>> --- a/arch/powerpc/lib/memcpy_64.S
>> +++ b/arch/powerpc/lib/memcpy_64.S
>> @@ -11,6 +11,7 @@
>>   #include <asm/export.h>
>>   #include <asm/asm-compat.h>
>>   #include <asm/feature-fixups.h>
>> +#include <asm/kasan.h>
>>   
>>   #ifndef SELFTEST_CASE
>>   /* For big-endian, 0 == most CPUs, 1 == POWER6, 2 == Cell */
>> @@ -18,7 +19,7 @@
>>   #endif
>>   
>>   	.align	7
>> -_GLOBAL_TOC(memcpy)
>> +_GLOBAL_TOC_KASAN(memcpy)
>>   BEGIN_FTR_SECTION
>>   #ifdef __LITTLE_ENDIAN__
>>   	cmpdi	cr7,r5,0
>> @@ -229,4 +230,4 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
>>   4:	ld	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)	/* return dest pointer */
>>   	blr
>>   #endif
>> -EXPORT_SYMBOL(memcpy)
>> +EXPORT_SYMBOL_KASAN(memcpy)
>> -- 
>> 2.13.3
