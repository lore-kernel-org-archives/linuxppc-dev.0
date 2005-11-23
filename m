Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EC6E9687EF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Nov 2005 18:16:08 +1100 (EST)
In-Reply-To: <4380829E.7040804@compulab.co.il>
References: <4380829E.7040804@compulab.co.il>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F7F76A40-0B04-4884-A7A8-1A8B4F2289CA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 23 Nov 2005 01:16:50 -0600
To: Mike Rapoport <mike@compulab.co.il>
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: smc1_lineif fix for mpc8272
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

It this on some specific board with an MPC8272 on it?

- kumar

On Nov 20, 2005, at 8:05 AM, Mike Rapoport wrote:

> This patch fixes the pin assignment of SMC1 for MPC8272 family
>
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>
>
> --  
> Sincerely yours,
> Mike Rapoport
>
>
> diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/ 
> serial/cpm_uart/cpm_uart_cpm2.c
> --- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> +++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> @@ -89,11 +89,19 @@ void smc1_lineif(struct uart_cpm_port *p
>  {
>  	volatile iop_cpm2_t *io = &cpm2_immr->im_ioport;
>
> +#ifdef CONFIG_8272
> +	/* SMC1 is only on port C on 8272 */
> +	io->iop_pparc |= 0x0c000000;
> +	io->iop_pdirc |= 0x04000000;
> +	io->iop_pdirc &= ~0x08000000;
> +	io->iop_psorc &= ~0x0c000000;
> +#else
>  	/* SMC1 is only on port D */
>  	io->iop_ppard |= 0x00c00000;
>  	io->iop_pdird |= 0x00400000;
>  	io->iop_pdird &= ~0x00800000;
>  	io->iop_psord &= ~0x00c00000;
> +#endif
>
>  	/* Wire BRG1 to SMC1 */
>  	cpm2_immr->im_cpmux.cmx_smr &= 0x0f;
