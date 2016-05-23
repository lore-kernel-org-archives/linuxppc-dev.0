Return-Path: <paubert@iram.es>
Received: from rudy.puc.rediris.es (rudy.puc.rediris.es [130.206.18.132])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDQqs1LllzDqD3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 16:44:24 +1000 (AEST)
Date: Mon, 23 May 2016 19:17:38 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: inline current_stack_pointer()
Message-ID: <20160523171738.GA15830@visitor2.iram.es>
References: <20160523084602.53F771A239A@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160523084602.53F771A239A@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 23, 2016 at 10:46:02AM +0200, Christophe Leroy wrote:
> current_stack_pointeur() is a single instruction function. it
> It is not worth breaking the execution flow with a bl/blr for a
> single instruction

Are you sure that the result is always the same? 

Calling an external function prevents the compiler from considering the
caller of of current_stack_pointer a leaf function, which certainly 
does not help the compiler, but in a leaf function the compiler is free 
not to establish a new frame.

If the compiler decides to establishes a new frame (typically with 
"stwu r1,-frame_size(r1)"), *r1 is the previous stack pointer, or
the caller's stack pointer, or the current function frame pointer if
I remember correctly the ABI definitions. 

However, if the compiler decides that it can get away without a frame
for the function, *r1 is the stack pointer of the caller's caller.

Depending on the application, this may or may not be important.

By the way, isn't there a GCC builtin which can perform this task,
for example builtin_frame_address()?

    Gabriel
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/reg.h  | 7 ++++++-
>  arch/powerpc/kernel/misc.S      | 4 ----
>  arch/powerpc/kernel/ppc_ksyms.c | 2 --
>  3 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index c1e82e9..7ce6777 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -1301,7 +1301,12 @@ static inline unsigned long mfvtb (void)
>  
>  #define proc_trap()	asm volatile("trap")
>  
> -extern unsigned long current_stack_pointer(void);
> +static inline unsigned long current_stack_pointer(void)
> +{
> +	register unsigned long *ptr asm("r1");
> +
> +	return *ptr;
> +}
>  
>  extern unsigned long scom970_read(unsigned int address);
>  extern void scom970_write(unsigned int address, unsigned long value);
> diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
> index 0d43219..7ce26d4 100644
> --- a/arch/powerpc/kernel/misc.S
> +++ b/arch/powerpc/kernel/misc.S
> @@ -114,7 +114,3 @@ _GLOBAL(longjmp)
>  	mtlr	r0
>  	mr	r3,r4
>  	blr
> -
> -_GLOBAL(current_stack_pointer)
> -	PPC_LL	r3,0(r1)
> -	blr
> diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
> index 9f01e28..eb5c5dc 100644
> --- a/arch/powerpc/kernel/ppc_ksyms.c
> +++ b/arch/powerpc/kernel/ppc_ksyms.c
> @@ -33,5 +33,3 @@ EXPORT_SYMBOL(store_vr_state);
>  #ifdef CONFIG_EPAPR_PARAVIRT
>  EXPORT_SYMBOL(epapr_hypercall_start);
>  #endif
> -
> -EXPORT_SYMBOL(current_stack_pointer);
> -- 
> 2.1.0
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
