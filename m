Return-Path: <michael.neuling@au1.ibm.com>
From: Michael Neuling <michael.neuling@au1.ibm.com>
To: Haren Myneni <haren@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/6] powerpc: Define ppr in thread_struct
In-reply-to: <1351666515.32304.17.camel@hbabu-laptop>
References: <1351666515.32304.17.camel@hbabu-laptop>
Date: Fri, 23 Nov 2012 14:21:55 +1100
Message-ID: <26608.1353640915@neuling.org>
Cc: anton@au1.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Haren Myneni <haren@linux.vnet.ibm.com> wrote:

> [PATCH 4/6] powerpc: Define ppr in thread_struct
> 
> ppr in thread_struct is used to save PPR and restore it before process exits
> from kernel.
> 
> This patch sets the default priority to 3 when tasks are created such
> that users can use 4 for higher priority tasks.
> 
> Signed-off-by: Haren Myneni <haren@us.ibm.com>
> ---
>  arch/powerpc/include/asm/processor.h |    6 ++++++
>  arch/powerpc/kernel/asm-offsets.c    |    1 +
>  arch/powerpc/kernel/process.c        |    2 ++
>  3 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> index 8750204..7db5df4 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -245,6 +245,7 @@ struct thread_struct {
>  #ifdef CONFIG_PPC64
>  	unsigned long	dscr;
>  	int		dscr_inherit;
> +	unsigned long	ppr;
>  #endif
>  };
>  
> @@ -270,6 +271,10 @@ struct thread_struct {
>  	SPEFSCR_INIT \
>  }
>  #else
> +/* Default SMT priority is 3. Use 11- 13bits to save priority. */
> +/* .ppr is used to save/restore only on P7 or later processors */
> +#define INIT_PPR (3ull << 50)

Can you split this into two macros so that we can use the '3' elsewhere.

Like in patch 5, you do this:

+	lis	ra,0xc;		/* default ppr=3 */			\

where you could reuse the '3' so that we don't have to change it in two
places later.

Mikey

> +
>  #define INIT_THREAD  { \
>  	.ksp = INIT_SP, \
>  	.ksp_limit = INIT_SP_LIMIT, \
> @@ -278,6 +283,7 @@ struct thread_struct {
>  	.fpr = {{0}}, \
>  	.fpscr = { .val = 0, }, \
>  	.fpexc_mode = 0, \
> +	.ppr = INIT_PPR, \
>  }
>  #endif
>  
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index 7523539..41f65ec 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -77,6 +77,7 @@ int main(void)
>  	DEFINE(NMI_MASK, NMI_MASK);
>  	DEFINE(THREAD_DSCR, offsetof(struct thread_struct, dscr));
>  	DEFINE(THREAD_DSCR_INHERIT, offsetof(struct thread_struct, dscr_inherit));
> +	DEFINE(TASKTHREADPPR, offsetof(struct task_struct, thread.ppr));
>  #else
>  	DEFINE(THREAD_INFO, offsetof(struct task_struct, stack));
>  #endif /* CONFIG_PPC64 */
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index ba48233..2563acc 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -814,6 +814,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
>  		p->thread.dscr_inherit = current->thread.dscr_inherit;
>  		p->thread.dscr = current->thread.dscr;
>  	}
> +	if (cpu_has_feature(CPU_FTR_HAS_PPR))
> +		p->thread.ppr = INIT_PPR;
>  #endif
>  	/*
>  	 * The PPC64 ABI makes use of a TOC to contain function 
> -- 
> 1.7.1
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
