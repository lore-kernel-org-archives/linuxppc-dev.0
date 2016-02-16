Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 120EC1A0202
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 08:21:16 +1100 (AEDT)
Message-ID: <1455657664.2463.68.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 16 Feb 2016 15:21:04 -0600
In-Reply-To: <20160211161650.1F12C1A2400@localhost.localdomain>
References: <20160211161650.1F12C1A2400@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v5] powerpc32: provide VIRT_CPU_ACCOUNTING
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-02-11 at 17:16 +0100, Christophe Leroy wrote:
> This patch provides VIRT_CPU_ACCOUTING to PPC32 architecture.
> PPC32 doesn't have the PACA structure, so we use the task_info
> structure to store the accounting data.
> 
> In order to reuse on PPC32 the PPC64 functions, all u64 data has
> been replaced by 'unsigned long' so that it is u32 on PPC32 and
> u64 on PPC64
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> Changes in v3: unlike previous version of the patch that was inspired
> from IA64 architecture, this new version tries to reuse as much as
> possible the PPC64 implementation.
> 
> PPC32 doesn't have PACA and past discusion on v2 version has shown
> that it is not worth implementing a PACA in PPC32 architecture
> (see below benh opinion)
> 
> benh: PACA is actually a data structure and you really really don't want it
> on ppc32 :-) Having a register point to current works, having a register
> point to per-cpu data instead works too (ie, change what we do today),
> but don't introduce a PACA *please* :-)

And Ben never replied to my reply at the time:

"What is special about 64-bit that warrants doing things differently from 32
-bit?  What is the difference between PACA and "per-cpu data", other than the
obscure name?"

I can understand wanting to avoid churn, but other than that, doing things 
differently on 64-bit versus 32-bit sucks.

> b/arch/powerpc/include/asm/cputime.h
> index e245255..c4c33be 100644
> --- a/arch/powerpc/include/asm/cputime.h
> +++ b/arch/powerpc/include/asm/cputime.h
> @@ -230,7 +230,11 @@ static inline cputime_t clock_t_to_cputime(const
> unsigned long clk)
>  
>  #define cputime64_to_clock_t(ct)	cputime_to_clock_t((cputime_t)(ct))
>  
> +#ifdef CONFIG_PPC64
>  static inline void arch_vtime_task_switch(struct task_struct *tsk) { }
> +#else
> +void arch_vtime_task_switch(struct task_struct *tsk);
> +#endif

Add a comment explaining why this is empty on 64-bit but non-empty on 32-bit.

> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm
> -offsets.c
> index 07cebc3..b04b957 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -256,6 +256,13 @@ int main(void)
>  	DEFINE(PACA_TRAP_SAVE, offsetof(struct paca_struct, trap_save));
>  	DEFINE(PACA_NAPSTATELOST, offsetof(struct paca_struct,
> nap_state_lost));
>  	DEFINE(PACA_SPRG_VDSO, offsetof(struct paca_struct, sprg_vdso));
> +#else /* CONFIG_PPC64 */
> +#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
> +	DEFINE(PACA_STARTTIME, offsetof(struct thread_info, starttime));
> +	DEFINE(PACA_STARTTIME_USER, offsetof(struct thread_info,
> starttime_user));
> +	DEFINE(PACA_USER_TIME, offsetof(struct thread_info, user_time));
> +	DEFINE(PACA_SYSTEM_TIME, offsetof(struct thread_info,
> system_time));
> +#endif
>  #endif /* CONFIG_PPC64 */

Can you change the name if it's not always going to be relative to a PACA?

> +#ifdef CONFIG_PPC32
> +#define get_paca()	task_thread_info(tsk)
> +#endif

Likewise, this is just going to cause confusion.

Can you bundle up the time accounting fields into a struct, that you share
between the paca and the 32-bit thread_info, and then have a macro to grab a
pointer to that?

-Scott
