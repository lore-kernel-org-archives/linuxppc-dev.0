Return-Path: <linuxppc-dev+bounces-21565-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92BECD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 11:35:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQSH31slTz2xLs;
	Wed, 27 May 2026 21:35:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779881743;
	cv=none; b=fr7F4TOQxki1umaMBXzqo4DXuOlJBpxPwQiRnLxj0hMwD6Sx+xDujt1RDY/fgaIQofpV3q4w6KaWUSeJA8gbWtW8lIHs1oryLSaNw8GqtSIuu8GFhticyRnqBONyI4EHf8DWDv7jlZllgr2TH63GFFSJNEX5NaTR5YI9djpBlOqS3DA301aNSL7ubdozs261SjbFe6jdUoE6/XcsiwX1dpv1QwMj0aCtLPuYORABIYGTJQfxtvA5PFXVmqVzwEEvbDUCWiMfMzeqcwG/O3esV3H+D6bpfkFDljn/4cSludwl2QIGxTLdKwGhQS15cwFZuFHm2h2d5vem5CgOnOJNcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779881743; c=relaxed/relaxed;
	bh=ljP6BEZRfa2JICSJhYIpT1vvboqfLa/iWqpeXBqZPPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XowHObvMwy4KGO+mVYww5HmHn7YW/kf5ALjGV7GXactqFYiKsUrsKEPwUh9ELr85ceZ+NHRke3Wi6Y+nmClSBhtuIrPOHOVBhUzoUgCeiv2Xj/BANO9GwchCxsA3nLljp2bEXxVnLDeQL/QT4wkJaylGLT2ZZ6cae+T2ryW6OdHtE6Top3gd2kPMLjRPhs/QldmQs7xwehA646NnNjClUiJPKqYGnnqVKsl+uTu7qNg5zKVbAQNC0djQaCsDH/uS3vQsWUnaNVakLEJhGm8J6HW01x7q/A2WoRAZa8kLRMtsmBi8MMjlaktjJSKSaBGpLuv+BcpczsjB5MjitHPs5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EZbvEazB; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EZbvEazB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQSH02Z1gz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 21:35:38 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779881734; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ljP6BEZRfa2JICSJhYIpT1vvboqfLa/iWqpeXBqZPPE=;
	b=EZbvEazBP/BYaFj/4wFpnEIO3E3Ykh6hD+Ib0WrHGs0qCwgrx9rPsg6SzVl6jayG/GVhNyHgIgvci4qslKZUdwxVtBVxYzcrUmjkBxfEyebpXYruMMKX8017HUcKNAg2M6zotn7S6M7dD6EeDkoPE5qbyEgn1rfWP0og1MEMW7g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0X3jdQYC_1779881729;
Received: from 30.246.179.14(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X3jdQYC_1779881729 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 May 2026 19:35:30 +0800
Message-ID: <056610fa-0dcc-46e9-a0b4-7c72067437ae@linux.alibaba.com>
Date: Wed, 27 May 2026 19:35:23 +0800
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
Subject: Re: [PATCH v14 3/8] arm64: add support for ARCH_HAS_COPY_MC
To: Ruidong Tian <tianruidong@linux.alibaba.com>, catalin.marinas@arm.com,
 will@kernel.org, rafael@kernel.org, tony.luck@intel.com,
 guohanjun@huawei.com, mchehab@kernel.org, tongtiangen@huawei.com,
 james.morse@arm.com, robin.murphy@arm.com, andreyknvl@gmail.com,
 dvyukov@google.com, vincenzo.frascino@arm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, ryabinin.a.a@gmail.com, glider@google.com,
 christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
 naveen.n.rao@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com
References: <20260518084956.2538442-1-tianruidong@linux.alibaba.com>
 <20260518084956.2538442-4-tianruidong@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260518084956.2538442-4-tianruidong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/18/26 4:49 PM, Ruidong Tian wrote:
> From: Tong Tiangen <tongtiangen@huawei.com>
> 
> For the arm64 kernel, when it processes hardware memory errors for
> synchronize notifications(do_sea()), if the errors is consumed within the
> kernel, the current processing is panic. However, it is not optimal.
> 
> Take copy_from/to_user for example, If ld* triggers a memory error, even in
> kernel mode, only the associated process is affected. Killing the user
> process and isolating the corrupt page is a better choice.
> 
> Add new fixup type EX_TYPE_KACCESS_ERR_ZERO_MEM_ERR to identify insn
> that can recover from memory errors triggered by access to kernel memory,
> and this fixup type is used in __arch_copy_to_user(), This make the regular
> copy_to_user() will handle kernel memory errors.
> 
> [Ruidong: handle EX_TYPE_UACCESS_CPY in fixup_exception_me()]
> 
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
> ---
>   arch/arm64/Kconfig                   |  1 +
>   arch/arm64/include/asm/asm-extable.h | 22 +++++++++++++++++++-
>   arch/arm64/include/asm/asm-uaccess.h |  4 ++++
>   arch/arm64/include/asm/extable.h     |  1 +
>   arch/arm64/lib/copy_to_user.S        | 10 +++++-----
>   arch/arm64/mm/extable.c              | 21 +++++++++++++++++++
>   arch/arm64/mm/fault.c                | 30 ++++++++++++++++++++--------
>   7 files changed, 75 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fe60738e5943..831b20d45893 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -21,6 +21,7 @@ config ARM64
>   	select ARCH_HAS_CACHE_LINE_SIZE
>   	select ARCH_HAS_CC_PLATFORM
>   	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
> +	select ARCH_HAS_COPY_MC if ACPI_APEI_GHES


At this commit:

   - arch/arm64/lib/memcpy_mc.S does not exist (patch 7)
   - arch/arm64/lib/copy_mc_page.S does not exist (patch 5)
   - arm64 has no copy_mc_to_kernel() override
   - __HAVE_ARCH_COPY_MC_USER_HIGHPAGE is not defined

Build does not break because the generic fallback in
include/linux/uaccess.h and include/linux/highmem.h covers it, but
ARCH_HAS_COPY_MC=y silently means "plain memcpy() with no MC
handling at all" between this commit and patch 7. Anyone bisecting
an MC regression in this window will be very confused.

Please move this select to the last arm64 implementation patch in
the series.


>   	select ARCH_HAS_CURRENT_STACK_POINTER
>   	select ARCH_HAS_DEBUG_VIRTUAL
>   	select ARCH_HAS_DEBUG_VM_PGTABLE
> diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/asm/asm-extable.h
> index d67e2fdd1aee..4980023f2fbd 100644
> --- a/arch/arm64/include/asm/asm-extable.h
> +++ b/arch/arm64/include/asm/asm-extable.h
> @@ -11,6 +11,8 @@
>   #define EX_TYPE_KACCESS_ERR_ZERO	3
>   #define EX_TYPE_UACCESS_CPY		4
>   #define EX_TYPE_LOAD_UNALIGNED_ZEROPAD	5
> +/* kernel access memory error safe */
> +#define EX_TYPE_KACCESS_ERR_ZERO_MEM_ERR	6

KACCESS_ERR_ZERO is already "encode err reg + zero reg". Tacking
_MEM_ERR on the end reads like "+ another mem-err reg". Please
rename to e.g. EX_TYPE_KACCESS_ERR_ZERO_MC, which directly tells
the reader "MC-safe variant of KACCESS_ERR_ZERO".

>   
>   /* Data fields for EX_TYPE_UACCESS_ERR_ZERO */
>   #define EX_DATA_REG_ERR_SHIFT	0
> @@ -42,7 +44,7 @@
>   	(.L__gpr_num_##gpr << EX_DATA_REG_##reg##_SHIFT)
>   
>   #define _ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, err, zero)		\
> -	__ASM_EXTABLE_RAW(insn, fixup, 					\
> +	__ASM_EXTABLE_RAW(insn, fixup,					\
>   			  EX_TYPE_UACCESS_ERR_ZERO,			\
>   			  (						\
>   			    EX_DATA_REG(ERR, err) |			\
> @@ -55,6 +57,17 @@
>   #define _ASM_EXTABLE_UACCESS(insn, fixup)				\
>   	_ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, wzr, wzr)
>   
> +#define _ASM_EXTABLE_KACCESS_ERR_ZERO_MEM_ERR(insn, fixup, err, zero)	\
> +	__ASM_EXTABLE_RAW(insn, fixup,					\
> +			  EX_TYPE_KACCESS_ERR_ZERO_MEM_ERR,		\
> +			  (						\
> +			    EX_DATA_REG(ERR, err) |			\
> +			    EX_DATA_REG(ZERO, zero)			\
> +			  ))
> +
> +#define _ASM_EXTABLE_KACCESS_MEM_ERR(insn, fixup)			\
> +	_ASM_EXTABLE_KACCESS_ERR_ZERO_MEM_ERR(insn, fixup, wzr, wzr)
> +
>   /*
>    * Create an exception table entry for uaccess `insn`, which will branch to `fixup`
>    * when an unhandled fault is taken.
> @@ -76,6 +89,13 @@
>   	.macro		_asm_extable_uaccess_cpy, insn, fixup, uaccess_is_write
>   	__ASM_EXTABLE_RAW(\insn, \fixup, EX_TYPE_UACCESS_CPY, \uaccess_is_write)
>   	.endm
> +/*
> + * Create an exception table entry for kaccess `insn`, which will branch to
> + * `fixup` when an unhandled fault is taken.
> + */
> +	.macro          _asm_extable_kaccess_mem_err, insn, fixup
> +	_ASM_EXTABLE_KACCESS_MEM_ERR(\insn, \fixup)
> +	.endm
>   
>   #else /* __ASSEMBLER__ */
>   
> diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
> index 12aa6a283249..c8f0af5fde63 100644
> --- a/arch/arm64/include/asm/asm-uaccess.h
> +++ b/arch/arm64/include/asm/asm-uaccess.h
> @@ -57,6 +57,10 @@ alternative_else_nop_endif
>   	.endm
>   #endif
>   
> +#define KERNEL_MEM_ERR(l, x...)			\
> +9999:	x;					\
> +	_asm_extable_kaccess_mem_err	9999b, l
> +
>   #define USER(l, x...)				\
>   9999:	x;					\
>   	_asm_extable_uaccess	9999b, l
> diff --git a/arch/arm64/include/asm/extable.h b/arch/arm64/include/asm/extable.h
> index 9dc39612bdf5..47c851d7df4f 100644
> --- a/arch/arm64/include/asm/extable.h
> +++ b/arch/arm64/include/asm/extable.h
> @@ -48,4 +48,5 @@ bool ex_handler_bpf(const struct exception_table_entry *ex,
>   #endif /* !CONFIG_BPF_JIT */
>   
>   bool fixup_exception(struct pt_regs *regs, unsigned long esr);
> +bool fixup_exception_me(struct pt_regs *regs);
>   #endif
> diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
> index 819f2e3fc7a9..991d94ecc1a8 100644
> --- a/arch/arm64/lib/copy_to_user.S
> +++ b/arch/arm64/lib/copy_to_user.S
> @@ -20,7 +20,7 @@
>    *	x0 - bytes not copied
>    */
>   	.macro ldrb1 reg, ptr, val
> -	ldrb  \reg, [\ptr], \val
> +	KERNEL_MEM_ERR(9998f, ldrb  \reg, [\ptr], \val)
>   	.endm
>   
>   	.macro strb1 reg, ptr, val
> @@ -28,7 +28,7 @@
>   	.endm
>   
>   	.macro ldrh1 reg, ptr, val
> -	ldrh  \reg, [\ptr], \val
> +	KERNEL_MEM_ERR(9998f, ldrh  \reg, [\ptr], \val)
>   	.endm
>   
>   	.macro strh1 reg, ptr, val
> @@ -36,7 +36,7 @@
>   	.endm
>   
>   	.macro ldr1 reg, ptr, val
> -	ldr \reg, [\ptr], \val
> +	KERNEL_MEM_ERR(9998f, ldr \reg, [\ptr], \val)
>   	.endm
>   
>   	.macro str1 reg, ptr, val
> @@ -44,7 +44,7 @@
>   	.endm
>   
>   	.macro ldp1 reg1, reg2, ptr, val
> -	ldp \reg1, \reg2, [\ptr], \val
> +	KERNEL_MEM_ERR(9998f, ldp \reg1, \reg2, [\ptr], \val)
>   	.endm
>   
>   	.macro stp1 reg1, reg2, ptr, val
> @@ -74,7 +74,7 @@ SYM_FUNC_START(__arch_copy_to_user)
>   9997:	cmp	dst, dstin
>   	b.ne	9998f
>   	// Before being absolutely sure we couldn't copy anything, try harder
> -	ldrb	tmp1w, [srcin]
> +KERNEL_MEM_ERR(9998f, ldrb	tmp1w, [srcin])
>   USER(9998f, sttrb tmp1w, [dst])
>   	add	dst, dst, #1
>   9998:	sub	x0, end, dst			// bytes not copied
> diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
> index 6e0528831cd3..f78ac7e92845 100644
> --- a/arch/arm64/mm/extable.c
> +++ b/arch/arm64/mm/extable.c
> @@ -110,7 +110,28 @@ bool fixup_exception(struct pt_regs *regs, unsigned long esr)
>   		return ex_handler_uaccess_cpy(ex, regs, esr);
>   	case EX_TYPE_LOAD_UNALIGNED_ZEROPAD:
>   		return ex_handler_load_unaligned_zeropad(ex, regs);
> +	case EX_TYPE_KACCESS_ERR_ZERO_MEM_ERR:
> +		return false;
>   	}
>   
>   	BUG();
>   }
> +
> +bool fixup_exception_me(struct pt_regs *regs)
> +{
> +	const struct exception_table_entry *ex;
> +
> +	ex = search_exception_tables(instruction_pointer(regs));
> +	if (!ex)
> +		return false;
> +
> +	switch (ex->type) {
> +	case EX_TYPE_UACCESS_CPY:
> +		return ex_handler_uaccess_cpy(ex, regs, 0);

Pointed by sashiko:

    copy_to_user.S annotates its MOPS prologue/main/epilogue with
    USER_CPY(..., 1, cpyf{p,m,e}wt ...), so uaccess_is_write=1 for the
    whole MOPS sequence. With esr=0 hard-coded here:

        cpy_faulted_on_uaccess(): uaccess_is_write=1, fault_on_write=0
                                  -> returns false
        ex_handler_uaccess_cpy()                       -> returns false
        fixup_exception_me()                           -> returns false
        do_apei_claim_sea()                            -> returns -ENOENT
        do_sea()                                       -> panic

    So any MC SEA taken inside a MOPS copy_to_user() panics the kernel,
    exactly defeating the recovery this patch claims to provide.


> +	case EX_TYPE_UACCESS_ERR_ZERO:
> +	case EX_TYPE_KACCESS_ERR_ZERO_MEM_ERR:
> +		return ex_handler_uaccess_err_zero(ex, regs);
> +	}
> +
> +	return false;
> +}
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 0f3c5c7ca054..efbda54770be 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -858,21 +858,35 @@ static int do_bad(unsigned long far, unsigned long esr, struct pt_regs *regs)
>   	return 1; /* "fault" */
>   }
>   
> +/*
> + * APEI claimed this as a firmware-first notification.
> + * Some processing deferred to task_work before ret_to_user().
> + */
> +static int do_apei_claim_sea(struct pt_regs *regs)
> +{
> +	int ret;
> +
> +	ret = apei_claim_sea(regs);
> +	if (ret)
> +		return ret;
> +
> +	if (!user_mode(regs) && IS_ENABLED(CONFIG_ARCH_HAS_COPY_MC)) {

The IS_ENABLED(CONFIG_ARCH_HAS_COPY_MC) test is also dead on arm64:
ARCH_HAS_COPY_MC is selected iff ACPI_APEI_GHES, and without
ACPI_APEI_GHES apei_claim_sea() returns -ENOENT and we never reach
this branch. Please drop it.


Thanks.
Shuai

