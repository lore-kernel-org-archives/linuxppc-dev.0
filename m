Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0BC0DDDEB9
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 03:38:27 +1100 (EST)
Message-Id: <FE0BA36E-81DE-4E61-8EE4-C6D5BD3AF5D9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20080130103644.bbfe82a5.kim.phillips@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] powerpc: configure USB clock for MPC8315E
Date: Wed, 30 Jan 2008 10:38:14 -0600
References: <20080130103644.bbfe82a5.kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Jerry Huang <Chang-Ming.Huang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 30, 2008, at 10:36 AM, Kim Phillips wrote:

> SCCR USB bits are in a different location on the mpc8315.
>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> arch/powerpc/platforms/83xx/mpc83xx.h |    2 ++
> arch/powerpc/platforms/83xx/usb.c     |   12 ++++++++----
> 2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/ 
> platforms/83xx/mpc83xx.h
> index 88bb748..68065e6 100644
> --- a/arch/powerpc/platforms/83xx/mpc83xx.h
> +++ b/arch/powerpc/platforms/83xx/mpc83xx.h
> @@ -14,6 +14,8 @@
> #define MPC83XX_SCCR_USB_DRCM_11   0x00300000
> #define MPC83XX_SCCR_USB_DRCM_01   0x00100000
> #define MPC83XX_SCCR_USB_DRCM_10   0x00200000
> +#define MPC8315_SCCR_USB_MASK      0x00c00000
> +#define MPC8315_SCCR_USB_DRCM_11   0x00c00000
> #define MPC837X_SCCR_USB_DRCM_11   0x00c00000
>
> /* system i/o configuration register low */
> diff --git a/arch/powerpc/platforms/83xx/usb.c b/arch/powerpc/ 
> platforms/83xx/usb.c
> index 681230a..b3b650e 100644
> --- a/arch/powerpc/platforms/83xx/usb.c
> +++ b/arch/powerpc/platforms/83xx/usb.c
> @@ -124,10 +124,14 @@ int mpc831x_usb_cfg(void)
> 	}
>
> 	/* Configure clock */
> -	temp = in_be32(immap + MPC83XX_SCCR_OFFS);
> -	temp &= ~MPC83XX_SCCR_USB_MASK;
> -	temp |= MPC83XX_SCCR_USB_DRCM_11;  /* 1:3 */
> -	out_be32(immap + MPC83XX_SCCR_OFFS, temp);
> +	if (of_find_compatible_node(NULL, NULL, "fsl,mpc8315erdb"))

Nope.  I don't want a board specific compat check in this code.

>
> +		clrsetbits_be32(immap + MPC83XX_SCCR_OFFS,
> +		                MPC8315_SCCR_USB_MASK,
> +		                MPC8315_SCCR_USB_DRCM_11);
> +	else
> +		clrsetbits_be32(immap + MPC83XX_SCCR_OFFS,
> +		                MPC83XX_SCCR_USB_MASK,
> +		                MPC83XX_SCCR_USB_DRCM_11);
>
> 	/* Configure pin mux for ULPI.  There is no pin mux for UTMI */
> 	if (prop && !strcmp(prop, "ulpi")) {

- k
