Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B947FC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 12:27:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E870A2084C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 12:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E870A2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438yg26RyTzDqpk
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 23:27:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438yb655CNzDqmX
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 23:24:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 438yb60yPcz9s8J;
 Wed,  5 Dec 2018 23:24:17 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>, firoz.khan@linaro.org
Subject: Re: [PATCH] powerpc: split compat syscall table out from native table
In-Reply-To: <20181204212340.3915309-1-arnd@arndb.de>
References: <CAK8P3a2SP0eX50NoFKaM2N85mgSejToQkD9ZOE_7V_RT__BCvg@mail.gmail.com>
 <20181204212340.3915309-1-arnd@arndb.de>
Date: Wed, 05 Dec 2018 23:24:16 +1100
Message-ID: <87pnugkvpr.fsf@concordia.ellerman.id.au>
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
Cc: linux-arch@vger.kernel.org, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>, deepa.kernel@gmail.com,
 linuxppc-dev@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Arnd Bergmann <arnd@arndb.de> writes:

> PowerPC uses a syscall table with native and compat calls interleaved,
> which is a slightly simpler way to define two matching tables.
>
> As we move to having the tables generated, that advantage is no longer
> important, but the interleaved table gets in the way of using the
> same scripts as on the other architectures.
>
> Split out a new compat_sys_call_table symbol that contains all the
> compat calls, and leave the main table for the native calls, to more
> closely match the method we use everywhere else.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This is completely untested, it's just for illustration and to
> get comments about whether this is a good idea.

Seems like a good idea to me.

The code's not much more complicated, in fact it's probably clearer
except for the extra macros.

It's more cache efficient too, though it probably doesn't really matter.

cheers

> Firoz, can you try to get this working?
> ---
>  arch/powerpc/include/asm/syscall.h |  3 +--
>  arch/powerpc/kernel/entry_64.S     |  7 ++++--
>  arch/powerpc/kernel/systbl.S       | 37 ++++++++++++++++++++++++------
>  arch/powerpc/kernel/vdso.c         |  7 ++++--
>  4 files changed, 41 insertions(+), 13 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> index ab9f3f0a8637..1a0e7a8b1c81 100644
> --- a/arch/powerpc/include/asm/syscall.h
> +++ b/arch/powerpc/include/asm/syscall.h
> @@ -18,9 +18,8 @@
>  #include <linux/thread_info.h>
>  
>  /* ftrace syscalls requires exporting the sys_call_table */
> -#ifdef CONFIG_FTRACE_SYSCALLS
>  extern const unsigned long sys_call_table[];
> -#endif /* CONFIG_FTRACE_SYSCALLS */
> +extern const unsigned long compat_sys_call_table[];
>  
>  static inline int syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
>  {
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 7b1693adff2a..5574d92646f1 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -54,6 +54,9 @@
>  SYS_CALL_TABLE:
>  	.tc sys_call_table[TC],sys_call_table
>  
> +COMPAT_SYS_CALL_TABLE:
> +	.tc compat_sys_call_table[TC],compat_sys_call_table
> +
>  /* This value is used to mark exception frames on the stack. */
>  exception_marker:
>  	.tc	ID_EXC_MARKER[TC],STACK_FRAME_REGS_MARKER
> @@ -173,7 +176,7 @@ system_call:			/* label this so stack traces look sane */
>  	ld	r11,SYS_CALL_TABLE@toc(2)
>  	andis.	r10,r10,_TIF_32BIT@h
>  	beq	15f
> -	addi	r11,r11,8	/* use 32-bit syscall entries */
> +	ld	r11,COMPAT_SYS_CALL_TABLE@toc(2)
>  	clrldi	r3,r3,32
>  	clrldi	r4,r4,32
>  	clrldi	r5,r5,32
> @@ -181,7 +184,7 @@ system_call:			/* label this so stack traces look sane */
>  	clrldi	r7,r7,32
>  	clrldi	r8,r8,32
>  15:
> -	slwi	r0,r0,4
> +	slwi	r0,r0,3
>  
>  	barrier_nospec_asm
>  	/*
> diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
> index 919a32746ede..883b8e36964c 100644
> --- a/arch/powerpc/kernel/systbl.S
> +++ b/arch/powerpc/kernel/systbl.S
> @@ -17,13 +17,13 @@
>  #include <asm/ppc_asm.h>
>  
>  #ifdef CONFIG_PPC64
> -#define SYSCALL(func)		.8byte	DOTSYM(sys_##func),DOTSYM(sys_##func)
> -#define COMPAT_SYS(func)	.8byte	DOTSYM(sys_##func),DOTSYM(compat_sys_##func)
> -#define PPC_SYS(func)		.8byte	DOTSYM(ppc_##func),DOTSYM(ppc_##func)
> -#define OLDSYS(func)		.8byte	DOTSYM(sys_ni_syscall),DOTSYM(sys_ni_syscall)
> -#define SYS32ONLY(func)		.8byte	DOTSYM(sys_ni_syscall),DOTSYM(compat_sys_##func)
> -#define PPC64ONLY(func)		.8byte	DOTSYM(ppc_##func),DOTSYM(sys_ni_syscall)
> -#define SYSX(f, f3264, f32)	.8byte	DOTSYM(f),DOTSYM(f3264)
> +#define SYSCALL(func)		.8byte	DOTSYM(sys_##func)
> +#define COMPAT_SYS(func)	.8byte	DOTSYM(sys_##func)
> +#define PPC_SYS(func)		.8byte	DOTSYM(ppc_##func)
> +#define OLDSYS(func)		.8byte	DOTSYM(sys_ni_syscall)
> +#define SYS32ONLY(func)		.8byte	DOTSYM(sys_ni_syscall)
> +#define PPC64ONLY(func)		.8byte	DOTSYM(ppc_##func)
> +#define SYSX(f, f3264, f32)	.8byte	DOTSYM(f)
>  #else
>  #define SYSCALL(func)		.long	sys_##func
>  #define COMPAT_SYS(func)	.long	sys_##func
> @@ -48,3 +48,26 @@
>  sys_call_table:
>  
>  #include <asm/systbl.h>
> +
> +#undef SYSCALL
> +#undef COMPAT_SYS
> +#undef PPC_SYS
> +#undef OLDSYS
> +#undef SYS32ONLY
> +#undef PPC64ONLY
> +#undef SYSX
> +
> +#ifdef CONFIG_COMPAT
> +#define SYSCALL(func)		.8byte	DOTSYM(sys_##func)
> +#define COMPAT_SYS(func)	.8byte	DOTSYM(compat_sys_##func)
> +#define PPC_SYS(func)		.8byte	DOTSYM(ppc_##func)
> +#define OLDSYS(func)		.8byte	DOTSYM(sys_ni_syscall)
> +#define SYS32ONLY(func)		.8byte	DOTSYM(compat_sys_##func)
> +#define PPC64ONLY(func)		.8byte	DOTSYM(sys_ni_syscall)
> +#define SYSX(f, f3264, f32)	.8byte	DOTSYM(f3264)
> +
> +.globl compat_sys_call_table
> +compat_sys_call_table:
> +
> +#include <asm/systbl.h>
> +#endif
> diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
> index 65b3bdb99f0b..7725a9714736 100644
> --- a/arch/powerpc/kernel/vdso.c
> +++ b/arch/powerpc/kernel/vdso.c
> @@ -671,15 +671,18 @@ static void __init vdso_setup_syscall_map(void)
>  {
>  	unsigned int i;
>  	extern unsigned long *sys_call_table;
> +#ifdef CONFIG_PPC64
> +	extern unsigned long *compat_sys_call_table;
> +#endif
>  	extern unsigned long sys_ni_syscall;
>  
>  
>  	for (i = 0; i < NR_syscalls; i++) {
>  #ifdef CONFIG_PPC64
> -		if (sys_call_table[i*2] != sys_ni_syscall)
> +		if (sys_call_table[i] != sys_ni_syscall)
>  			vdso_data->syscall_map_64[i >> 5] |=
>  				0x80000000UL >> (i & 0x1f);
> -		if (sys_call_table[i*2+1] != sys_ni_syscall)
> +		if (compat_sys_call_table[i] != sys_ni_syscall)
>  			vdso_data->syscall_map_32[i >> 5] |=
>  				0x80000000UL >> (i & 0x1f);
>  #else /* CONFIG_PPC64 */
> -- 
> 2.18.0
