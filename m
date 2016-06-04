Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rMHMd3krvzDq8G
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Jun 2016 20:32:13 +1000 (AEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rMHMc6pnYz9t89
 for <linuxppc-dev@ozlabs.org>; Sat,  4 Jun 2016 20:32:12 +1000 (AEST)
Received: from pps.filterd (m0075420.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u54ASa2B031400
 for <linuxppc-dev@ozlabs.org>; Sat, 4 Jun 2016 06:32:09 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23bsgapk6b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sat, 04 Jun 2016 06:32:08 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Sat, 4 Jun 2016 20:32:05 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D184C3578052
 for <linuxppc-dev@ozlabs.org>; Sat,  4 Jun 2016 20:32:02 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u54AW2sk9961824
 for <linuxppc-dev@ozlabs.org>; Sat, 4 Jun 2016 20:32:02 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u54AW2xO013193
 for <linuxppc-dev@ozlabs.org>; Sat, 4 Jun 2016 20:32:02 +1000
Date: Sat, 4 Jun 2016 16:01:14 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: Define and use PPC_ELF_ABI_v2
References: <1461836327-15417-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461836327-15417-1-git-send-email-mpe@ellerman.id.au>
Message-Id: <20160604103113.GM18654@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/04/28 07:38PM, Michael Ellerman wrote:
> We're approaching 20 locations where we need to check for ELF ABI v2.
> That's fine, except the logic is a bit awkward, because we have to check
> that _CALL_ELF is defined and then what its value is.
> 
> So check it once in asm/types.h and define PPC_ELF_ABI_v2 when ELF ABI
> v2 is detected.
> 
> We don't add explicit includes of asm/types.h because it's included
> basically everywhere via compiler.h.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/code-patching.h | 6 +++---
>  arch/powerpc/include/asm/ftrace.h        | 2 +-
>  arch/powerpc/include/asm/kprobes.h       | 4 ++--
>  arch/powerpc/include/asm/linkage.h       | 2 +-
>  arch/powerpc/include/asm/ppc_asm.h       | 4 ++--
>  arch/powerpc/include/asm/ptrace.h        | 2 +-
>  arch/powerpc/include/asm/sections.h      | 2 +-
>  arch/powerpc/include/asm/types.h         | 4 ++++
>  arch/powerpc/kernel/entry_64.S           | 2 +-
>  arch/powerpc/kernel/head_64.S            | 2 +-
>  arch/powerpc/kernel/kprobes.c            | 2 +-
>  arch/powerpc/kernel/misc_64.S            | 2 +-
>  arch/powerpc/kernel/module_64.c          | 4 ++--
>  arch/powerpc/kvm/book3s_interrupts.S     | 2 +-
>  arch/powerpc/kvm/book3s_rmhandlers.S     | 2 +-
>  15 files changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
> index 994c60a857ce..d325b35315d3 100644
> --- a/arch/powerpc/include/asm/code-patching.h
> +++ b/arch/powerpc/include/asm/code-patching.h
> @@ -50,7 +50,7 @@ void __patch_exception(int exc, unsigned long addr);
>  static inline unsigned long ppc_function_entry(void *func)
>  {
>  #if defined(CONFIG_PPC64)
> -#if defined(_CALL_ELF) && _CALL_ELF == 2
> +#ifdef PPC_ELF_ABI_v2
>  	u32 *insn = func;
>  
>  	/*
> @@ -90,7 +90,7 @@ static inline unsigned long ppc_function_entry(void *func)
>  
>  static inline unsigned long ppc_global_function_entry(void *func)
>  {
> -#if defined(CONFIG_PPC64) && defined(_CALL_ELF) && _CALL_ELF == 2
> +#if defined(CONFIG_PPC64) && defined(PPC_ELF_ABI_v2)
>  	/* PPC64 ABIv2 the global entry point is at the address */
>  	return (unsigned long)func;
>  #else
> @@ -106,7 +106,7 @@ static inline unsigned long ppc_global_function_entry(void *func)
>   */
>  
>  /* This must match the definition of STK_GOT in <asm/ppc_asm.h> */
> -#if defined(_CALL_ELF) && _CALL_ELF == 2
> +#ifdef PPC_ELF_ABI_v2
>  #define R2_STACK_OFFSET         24
>  #else
>  #define R2_STACK_OFFSET         40
> diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
> index 50ca7585abe2..0b0bfcaa587a 100644
> --- a/arch/powerpc/include/asm/ftrace.h
> +++ b/arch/powerpc/include/asm/ftrace.h
> @@ -66,7 +66,7 @@ struct dyn_arch_ftrace {
>  #endif
>  
>  #if defined(CONFIG_FTRACE_SYSCALLS) && defined(CONFIG_PPC64) && !defined(__ASSEMBLY__)
> -#if !defined(_CALL_ELF) || _CALL_ELF != 2
> +#ifdef PPC_ELF_ABI_v2

That should be #ifndef.


- Naveen
