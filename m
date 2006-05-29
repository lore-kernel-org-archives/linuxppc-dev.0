Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 5D39467A5D
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 06:50:59 +1000 (EST)
Date: Mon, 29 May 2006 15:50:03 -0500
To: mostrows@watson.ibm.com
Subject: Re: [PATCH 7/8] Cleaner checks for MPIC on pSeries.
Message-ID: <20060529205003.GA5101@pb15.lixom.net>
References: <1148935262.25048.31.camel@brick>
	<11489353263834-git-send-email-mostrows@watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11489353263834-git-send-email-mostrows@watson.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 29, 2006 at 04:42:06PM -0400, mostrows@watson.ibm.com wrote:
> Instead of checking the pSeries_mpic pointer, use a wrapper
> (pSeries_uses_mpic()) that tells us what we want to know.

You might as well kill the SillyCaps while you're at it.

-Olof


> --
> Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>
> 
> ---
> 
>  arch/powerpc/kernel/rtas_pci.c         |    2 +-
>  arch/powerpc/platforms/pseries/setup.c |    2 +-
>  include/asm-powerpc/mpic.h             |    6 ++++++
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> 082a93566e954ce0cc945b89aced0b28feb7ee60
> diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
> index e1dbd53..2a6b729 100644
> --- a/arch/powerpc/kernel/rtas_pci.c
> +++ b/arch/powerpc/kernel/rtas_pci.c
> @@ -322,7 +322,7 @@ unsigned long __init find_and_init_phbs(
>  		pci_setup_phb_io(phb, index == 0);
>  #ifdef CONFIG_PPC_PSERIES
>  		/* XXX This code need serious fixing ... --BenH */
> -		if (pSeries_mpic) {
> +		if (pSeries_uses_mpic()) {
>  			int addr = root_size_cells * (index + 2) - 1;
>  			mpic_assign_isu(pSeries_mpic, index, opprop[addr]);
>  		}
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index 4ff127b..551da6a 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -536,7 +536,7 @@ static void pseries_kexec_cpu_down(int c
>  		}
>  	}
>  
> -	if (pSeries_mpic)
> +	if (pSeries_uses_mpic())
>  		mpic_teardown_this_cpu(secondary);
>  	else
>  		xics_teardown_cpu(secondary);
> diff --git a/include/asm-powerpc/mpic.h b/include/asm-powerpc/mpic.h
> index 6b9e781..1f1b2eb 100644
> --- a/include/asm-powerpc/mpic.h
> +++ b/include/asm-powerpc/mpic.h
> @@ -287,5 +287,11 @@ extern int mpic_get_irq(struct pt_regs *
>  /* global mpic for pSeries */
>  extern struct mpic *pSeries_mpic;
>  
> +#ifdef CONFIG_MPIC
> +#define pSeries_uses_mpic() (pSeries_mpic != NULL)
> +#else
> +#define pSeries_uses_mpic() 0
> +#endif
> +
>  #endif /* __KERNEL__ */
>  #endif	/* _ASM_POWERPC_MPIC_H */
> -- 
> 1.1.4.g0b63-dirty
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
