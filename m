Return-Path: <michael@ellerman.id.au>
Date: Tue, 26 Mar 2013 15:14:26 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Jia Hongtao <hongtao.jia@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/MPIC: Add get_version API both for internal
 and external use
Message-ID: <20130326041426.GC22382@concordia>
References: <1364268527-32068-1-git-send-email-hongtao.jia@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364268527-32068-1-git-send-email-hongtao.jia@freescale.com>
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 26, 2013 at 11:28:46AM +0800, Jia Hongtao wrote:
> MPIC version is useful information for both mpic_alloc() and mpic_init().
> The patch provide an API to get MPIC version for reusing the code.
> Also, some other IP block may need MPIC version for their own use.
> The API for external use is also provided.
> 
> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  arch/powerpc/include/asm/mpic.h |  3 +++
>  arch/powerpc/sysdev/mpic.c      | 30 +++++++++++++++++++++++-------
>  2 files changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
> index c0f9ef9..95053d6 100644
> --- a/arch/powerpc/include/asm/mpic.h
> +++ b/arch/powerpc/include/asm/mpic.h
> @@ -393,6 +393,9 @@ struct mpic
>  #define	MPIC_REGSET_STANDARD		MPIC_REGSET(0)	/* Original MPIC */
>  #define	MPIC_REGSET_TSI108		MPIC_REGSET(1)	/* Tsi108/109 PIC */
>  
> +/* Get the mpic version */
> +extern u32 mpic_primary_get_version(void);
> +
>  /* Allocate the controller structure and setup the linux irq descs
>   * for the range if interrupts passed in. No HW initialization is
>   * actually performed.
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index d30e6a6..d6b6fb6 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1165,10 +1165,31 @@ static struct irq_domain_ops mpic_host_ops = {
>  	.xlate = mpic_host_xlate,
>  };
>  
> +static u32 mpic_get_version(struct mpic *mpic)
> +{
> +	u32 brr1;
> +
> +	brr1 = _mpic_read(mpic->reg_type, &mpic->thiscpuregs,
> +			MPIC_FSL_BRR1);
> +
> +	return brr1 & MPIC_FSL_BRR1_VER;
> +}
> +
>  /*
>   * Exported functions
>   */
>  
> +u32 mpic_primary_get_version(void)
> +{
> +	u32 brr1;
> +	struct mpic *mpic = mpic_primary;
> +
> +	brr1 = _mpic_read(mpic->reg_type, &mpic->thiscpuregs,
> +			MPIC_FSL_BRR1);
> +
> +	return brr1 & MPIC_FSL_BRR1_VER;
> +}

Why doesn't mpic_primary_get_version() call mpic_get_version() ?

cheers
