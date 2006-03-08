Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 930D1679E2
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Mar 2006 05:32:56 +1100 (EST)
In-Reply-To: <18AEF66AFDF06F4CAAA1D419D000FD332ECDA6@az33exm24.fsl.freescale.net>
References: <18AEF66AFDF06F4CAAA1D419D000FD332ECDA6@az33exm24.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <460DF565-EE39-4D93-8766-AF8ACBF2975D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Fix MPC8548CDS rebooting procedure
Date: Wed, 8 Mar 2006 12:33:09 -0600
To: Haruki Dai-r35557 <Dai.Haruki@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 8, 2006, at 11:22 AM, Haruki Dai-r35557 wrote:

> This patch fixes the MPC8548 CDS rebooting procedure.
> Without this patche, issuing reboot from shell doesn't reboot the
> machine.
>
> Signed-off-by: Dai Haruki <dai.haruki@freescale.com>

Dai, I'm avoid taking patches for 85xx that effect new  
functionality.  If you want change this to work with arch/powerpc and  
make it a run time check for 8548.

- kumar

> ---
>
>  arch/ppc/syslib/ppc85xx_setup.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> 8f095006923385c3546165b0e10d73d3e057c120
> diff --git a/arch/ppc/syslib/ppc85xx_setup.c
> b/arch/ppc/syslib/ppc85xx_setup.c
> index e4dda43..45b1b2b 100644
> --- a/arch/ppc/syslib/ppc85xx_setup.c
> +++ b/arch/ppc/syslib/ppc85xx_setup.c
> @@ -115,6 +115,11 @@ mpc85xx_early_serial_map(void)
>  void
>  mpc85xx_restart(char *cmd)
>  {
> +#ifdef CONFIG_MPC8548
> +	volatile unsigned int *rstcr;
> +	u32 *pMem = (u32*) ioremap((BOARD_CCSRBAR + 0xe00b0),0x100);
> +	*pMem = 0x2; /* Set HRESET_REQ flag */
> +#endif
>  	local_irq_disable();
>  	abort();
>  }
> -- 
> 1.2.4
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
