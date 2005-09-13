Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <20050913175028.GB14889@dmt.cnet>
References: <20050913175028.GB14889@dmt.cnet>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A6CA30D6-DDC3-4AEF-8CA2-58CFA261F44B@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 13 Sep 2005 14:05:57 -0500
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Cc: linuxppc-dev@ozlabs.org, linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: __switch_to test-and-branch ALTIVEC specific?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This probably has to due with what happens on a G4 system with a  
kernel not build with Altivec.. However, I dont remember exactly what  
behavior is desired.

- kumar

On Sep 13, 2005, at 12:50 PM, Marcelo Tosatti wrote:

> Hi,
>
> This test&branch looks AltiVec specific, any reason for not #ifdef'ing
> it
> out?
>
> --- arch/ppc/kernel/process.c.orig      2005-09-13 14:43:13.000000000
> -0300
> +++ arch/ppc/kernel/process.c   2005-09-13 14:43:51.000000000 -0300
> @@ -287,11 +287,13 @@ struct task_struct *__switch_to(struct t
>  #endif /* CONFIG_SPE */
>  #endif /* CONFIG_SMP */
>
> +#ifdef CONFIG_ALTIVEC
>         /* Avoid the trap.  On smp this this never happens since
>          * we don't set last_task_used_altivec -- Cort
>          */
>         if (new->thread.regs && last_task_used_altivec == new)
>                 new->thread.regs->msr |= MSR_VEC;
> +#endif
>  #ifdef CONFIG_SPE
>         /* Avoid the trap.  On smp this this never happens since
>          * we don't set last_task_used_spe
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
