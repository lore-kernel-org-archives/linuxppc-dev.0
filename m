Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 368D1DDE02
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 10:48:27 +1100 (EST)
Date: Sat, 24 Nov 2007 02:46:24 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH resend 3/4] powerpc: Add EXPORT_SYMBOL for symbols
	required by fs_enet and cpm_uart
Message-ID: <20071124024624.41ca272a@kernel.crashing.org>
In-Reply-To: <4745B42B.8050201@scram.de>
References: <4745B42B.8050201@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 22 Nov 2007 17:54:03 +0100
Jochen Friedrich wrote:

> fs_enet and cpm_uart need symbols from commproc.c (for CPM1) or
> cpm2_common.c. Add EXPORT_SYMBOL for cpmp, cpm_setbrg and cpm2_immr,
> so the drivers can be compiled as modules.
> 
I think this is not required. We are having very gross setup_immap
function, where just using global area pointer - this should be replaced
with parent node traverse to figure out proper immr reg.

I will likely have a look at this problem. Additionally, I must say what we are having
is unpleasant enough, and EXPORT_...ing global memmapped pointers, we'll open the way to ugly
hacks which nobody want to. Let's cure the disease,   not its effects.

>   Building modules, stage 2.
>   MODPOST 5 modules
> ERROR: "cpm2_immr" [drivers/net/fs_enet/fs_enet.ko] undefined!
> ERROR: "cpmp" [drivers/net/fs_enet/fs_enet.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> 
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> Acked-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/sysdev/commproc.c    |    3 +++
>  arch/powerpc/sysdev/cpm2_common.c |    3 +++
>  2 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/commproc.c
> b/arch/powerpc/sysdev/commproc.c index f6a6378..d5a0dcf 100644
> --- a/arch/powerpc/sysdev/commproc.c
> +++ b/arch/powerpc/sysdev/commproc.c
> @@ -51,6 +51,8 @@ static void m8xx_cpm_dpinit(void);
>  static uint host_buffer; /* One page of host buffer */
>  static uint host_end;    /* end + 1 */
>  cpm8xx_t __iomem *cpmp;  /* Pointer to comm processor space */
> +EXPORT_SYMBOL(cpmp);
> +
>  immap_t __iomem *mpc8xx_immr;
>  static cpic8xx_t __iomem *cpic_reg;
> 
> @@ -302,6 +304,7 @@ cpm_setbrg(uint brg, uint rate)
>  		out_be32(bp, (((BRG_UART_CLK_DIV16 / rate) - 1) <<
> 1) | CPM_BRG_EN | CPM_BRG_DIV16);
>  }
> +EXPORT_SYMBOL(cpm_setbrg);
> 
>  #ifndef CONFIG_PPC_CPM_NEW_BINDING
>  /*
> diff --git a/arch/powerpc/sysdev/cpm2_common.c
> b/arch/powerpc/sysdev/cpm2_common.c index 859362f..4ed5df6 100644
> --- a/arch/powerpc/sysdev/cpm2_common.c
> +++ b/arch/powerpc/sysdev/cpm2_common.c
> @@ -51,11 +51,13 @@ static void cpm2_dpinit(void);
>  #endif
> 
>  cpm_cpm2_t __iomem *cpmp; /* Pointer to comm processor space */
> +EXPORT_SYMBOL(cpmp);
> 
>  /* We allocate this here because it is used almost exclusively for
>   * the communication processor devices.
>   */
>  cpm2_map_t __iomem *cpm2_immr;
> +EXPORT_SYMBOL(cpm2_immr);
> 
>  #define CPM_MAP_SIZE	(0x40000)	/* 256k - the PQ3
> reserve this amount of space for CPM as it is larger
> @@ -117,6 +119,7 @@ cpm_setbrg(uint brg, uint rate)
> 
>  	cpm2_unmap(bp);
>  }
> +EXPORT_SYMBOL(cpm_setbrg);
> 
>  /* This function is used to set high speed synchronous baud rate
>   * clocks.


-- 
Sincerely, Vitaly
