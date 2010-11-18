Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8FA31B71A4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Nov 2010 14:56:10 +1100 (EST)
Subject: Re: linux-next: build warning in Linus' tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20101025170322.851780f3.sfr@canb.auug.org.au>
References: <20101025135237.337b8321.sfr@canb.auug.org.au>
	<1287978429-18542-1-git-send-email-lacombar@gmail.com>
	<20101025170322.851780f3.sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 18 Nov 2010 14:55:44 +1100
Message-ID: <1290052544.32570.1.camel@pasglop>
Mime-Version: 1.0
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "H.
	Peter Anvin" <hpa@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	Jan Beulich <JBeulich@novell.com>, Arnaud Lacombe <lacombar@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-10-25 at 17:03 +1100, Stephen Rothwell wrote:
> Hi Arnaud,
> 
> On Sun, 24 Oct 2010 23:47:09 -0400 Arnaud Lacombe <lacombar@gmail.com> wrote:
> >
> > The following patch should fix this warning.
> 
> I think the following is preferable.  Not tested yet, I will test
> tomorrow and submit properly then.

I agree. Tho I don't understand the original problem. Both definitions
have no parenthesis for me and I don't see warnings, or am I missing
some changes still in -next that cause this ?

Cheers,
Ben.


> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 25 Oct 2010 16:57:47 +1100
> Subject: [PATCH] powerpc: remove second definition of STACK_FRAME_OVERHEAD
> 
> Since STACK_FRAME_OVERHEAD is defined in asm/ptrace.h and that
> is ASSEMBER safe, we can just include that instead of going via
> asm-offsets.h.
> 
> Eliminated build warnings about a duplicate definition now that
> the asm-offsets.h version has parentheses around the values.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/kernel/asm-offsets.c       |    1 -
>  arch/powerpc/kernel/entry_32.S          |    1 +
>  arch/powerpc/kernel/exceptions-64s.S    |    1 +
>  arch/powerpc/kernel/fpu.S               |    1 +
>  arch/powerpc/kernel/head_40x.S          |    1 +
>  arch/powerpc/kernel/head_44x.S          |    1 +
>  arch/powerpc/kernel/head_64.S           |    1 +
>  arch/powerpc/kernel/head_8xx.S          |    1 +
>  arch/powerpc/kernel/head_fsl_booke.S    |    1 +
>  arch/powerpc/kernel/misc_32.S           |    1 +
>  arch/powerpc/kernel/misc_64.S           |    1 +
>  arch/powerpc/kernel/ppc_save_regs.S     |    1 +
>  arch/powerpc/kernel/vector.S            |    1 +
>  arch/powerpc/platforms/pseries/hvCall.S |    1 +
>  14 files changed, 13 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index bd0df2e..23e6a93 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -209,7 +209,6 @@ int main(void)
>  	DEFINE(RTASENTRY, offsetof(struct rtas_t, entry));
>  
>  	/* Interrupt register frame */
> -	DEFINE(STACK_FRAME_OVERHEAD, STACK_FRAME_OVERHEAD);
>  	DEFINE(INT_FRAME_SIZE, STACK_INT_FRAME_SIZE);
>  	DEFINE(SWITCH_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs));
>  #ifdef CONFIG_PPC64
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index ed4aeb9..c22dc1e 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -31,6 +31,7 @@
>  #include <asm/asm-offsets.h>
>  #include <asm/unistd.h>
>  #include <asm/ftrace.h>
> +#include <asm/ptrace.h>
>  
>  #undef SHOW_SYSCALLS
>  #undef SHOW_SYSCALLS_TASK
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 9f8b01d..8a81799 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -13,6 +13,7 @@
>   */
>  
>  #include <asm/exception-64s.h>
> +#include <asm/ptrace.h>
>  
>  /*
>   * We layout physical memory as follows:
> diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
> index e86c040..de36955 100644
> --- a/arch/powerpc/kernel/fpu.S
> +++ b/arch/powerpc/kernel/fpu.S
> @@ -23,6 +23,7 @@
>  #include <asm/thread_info.h>
>  #include <asm/ppc_asm.h>
>  #include <asm/asm-offsets.h>
> +#include <asm/ptrace.h>
>  
>  #ifdef CONFIG_VSX
>  #define REST_32FPVSRS(n,c,base)						\
> diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
> index 8278e8b..9dd21a8 100644
> --- a/arch/powerpc/kernel/head_40x.S
> +++ b/arch/powerpc/kernel/head_40x.S
> @@ -40,6 +40,7 @@
>  #include <asm/thread_info.h>
>  #include <asm/ppc_asm.h>
>  #include <asm/asm-offsets.h>
> +#include <asm/ptrace.h>
>  
>  /* As with the other PowerPC ports, it is expected that when code
>   * execution begins here, the following registers contain valid, yet
> diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
> index 562305b..cbb3436 100644
> --- a/arch/powerpc/kernel/head_44x.S
> +++ b/arch/powerpc/kernel/head_44x.S
> @@ -37,6 +37,7 @@
>  #include <asm/thread_info.h>
>  #include <asm/ppc_asm.h>
>  #include <asm/asm-offsets.h>
> +#include <asm/ptrace.h>
>  #include <asm/synch.h>
>  #include "head_booke.h"
>  
> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index f0dd577..ce41b97 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -38,6 +38,7 @@
>  #include <asm/page_64.h>
>  #include <asm/irqflags.h>
>  #include <asm/kvm_book3s_asm.h>
> +#include <asm/ptrace.h>
>  
>  /* The physical memory is layed out such that the secondary processor
>   * spin code sits at 0x0000...0x00ff. On server, the vectors follow
> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
> index 1f1a04b..1cbf64e 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -29,6 +29,7 @@
>  #include <asm/thread_info.h>
>  #include <asm/ppc_asm.h>
>  #include <asm/asm-offsets.h>
> +#include <asm/ptrace.h>
>  
>  /* Macro to make the code more readable. */
>  #ifdef CONFIG_8xx_CPU6
> diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
> index 529b817..3e02710 100644
> --- a/arch/powerpc/kernel/head_fsl_booke.S
> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> @@ -41,6 +41,7 @@
>  #include <asm/ppc_asm.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/cache.h>
> +#include <asm/ptrace.h>
>  #include "head_booke.h"
>  
>  /* As with the other PowerPC ports, it is expected that when code
> diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
> index a7a570d..094bd98 100644
> --- a/arch/powerpc/kernel/misc_32.S
> +++ b/arch/powerpc/kernel/misc_32.S
> @@ -30,6 +30,7 @@
>  #include <asm/processor.h>
>  #include <asm/kexec.h>
>  #include <asm/bug.h>
> +#include <asm/ptrace.h>
>  
>  	.text
>  
> diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
> index e514490..206a321 100644
> --- a/arch/powerpc/kernel/misc_64.S
> +++ b/arch/powerpc/kernel/misc_64.S
> @@ -25,6 +25,7 @@
>  #include <asm/cputable.h>
>  #include <asm/thread_info.h>
>  #include <asm/kexec.h>
> +#include <asm/ptrace.h>
>  
>  	.text
>  
> diff --git a/arch/powerpc/kernel/ppc_save_regs.S b/arch/powerpc/kernel/ppc_save_regs.S
> index 5113bd2..e83ba3f 100644
> --- a/arch/powerpc/kernel/ppc_save_regs.S
> +++ b/arch/powerpc/kernel/ppc_save_regs.S
> @@ -11,6 +11,7 @@
>  #include <asm/processor.h>
>  #include <asm/ppc_asm.h>
>  #include <asm/asm-offsets.h>
> +#include <asm/ptrace.h>
>  
>  /*
>   * Grab the register values as they are now.
> diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
> index fe46048..9de6f39 100644
> --- a/arch/powerpc/kernel/vector.S
> +++ b/arch/powerpc/kernel/vector.S
> @@ -5,6 +5,7 @@
>  #include <asm/cputable.h>
>  #include <asm/thread_info.h>
>  #include <asm/page.h>
> +#include <asm/ptrace.h>
>  
>  /*
>   * load_up_altivec(unused, unused, tsk)
> diff --git a/arch/powerpc/platforms/pseries/hvCall.S b/arch/powerpc/platforms/pseries/hvCall.S
> index 48d2057..fd05fde 100644
> --- a/arch/powerpc/platforms/pseries/hvCall.S
> +++ b/arch/powerpc/platforms/pseries/hvCall.S
> @@ -11,6 +11,7 @@
>  #include <asm/processor.h>
>  #include <asm/ppc_asm.h>
>  #include <asm/asm-offsets.h>
> +#include <asm/ptrace.h>
>  	
>  #define STK_PARM(i)     (48 + ((i)-3)*8)
>  
