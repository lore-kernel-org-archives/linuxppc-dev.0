Return-Path: <paubert@iram.es>
Received: from rudy.puc.rediris.es (rudy.puc.rediris.es [130.206.18.140])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFM4B4PLDzDr5X
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 19:58:34 +1000 (AEST)
Date: Thu, 18 Aug 2016 11:58:07 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/8xx: fix single_step debug
Message-ID: <20160818095807.GA14832@visitor2.iram.es>
References: <20160818094420.8E0991A2459@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160818094420.8E0991A2459@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 18, 2016 at 11:44:20AM +0200, Christophe Leroy wrote:
> SPRN_ICR must be read for clearing the internal freeze signal which
> is asserted by the single step exception, otherwise the timebase and
> decrementer remain freezed

Minor nit: s/freezed/frozen/

If the timebase and decrementer are frozen even for a few cycles, this
probably upsets timekeeping. I consider this a completely stupid design
decision, and maybe I'm not alone.

    Gabriel

> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/reg_8xx.h | 1 +
>  arch/powerpc/kernel/traps.c        | 8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/reg_8xx.h b/arch/powerpc/include/asm/reg_8xx.h
> index feaf641..6dae71f 100644
> --- a/arch/powerpc/include/asm/reg_8xx.h
> +++ b/arch/powerpc/include/asm/reg_8xx.h
> @@ -17,6 +17,7 @@
>  #define SPRN_DC_DAT	570	/* Read-only data register */
>  
>  /* Misc Debug */
> +#define SPRN_ICR	148
>  #define SPRN_DPDR	630
>  #define SPRN_MI_CAM	816
>  #define SPRN_MI_RAM0	817
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 2cb5892..0f1f0ce 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -400,8 +400,16 @@ static inline int check_io_access(struct pt_regs *regs)
>  #define REASON_TRAP		0x20000
>  
>  #define single_stepping(regs)	((regs)->msr & MSR_SE)
> +#ifdef CONFIG_PPC_8xx
> +static inline void clear_single_step(struct pt_regs *regs)
> +{
> +	regs->msr &= ~MSR_SE;
> +	mfspr(SPRN_ICR);
> +}
> +#else
>  #define clear_single_step(regs)	((regs)->msr &= ~MSR_SE)
>  #endif
> +#endif
>  
>  #if defined(CONFIG_4xx)
>  int machine_check_4xx(struct pt_regs *regs)
> -- 
> 2.1.0
