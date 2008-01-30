Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7057FDDEF0
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 04:27:51 +1100 (EST)
Date: Wed, 30 Jan 2008 11:27:57 -0600
From: Olof Johansson <olof@lixom.net>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH v2] powerpc: configure USB clock for MPC8315E
Message-ID: <20080130172757.GA18385@lixom.net>
References: <20080130110857.c66f98fb.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080130110857.c66f98fb.kim.phillips@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Jerry Huang <Chang-Ming.Huang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Wed, Jan 30, 2008 at 11:08:57AM -0600, Kim Phillips wrote:
> diff --git a/arch/powerpc/platforms/83xx/usb.c b/arch/powerpc/platforms/83xx/usb.c
> index 681230a..14c83f1 100644
> --- a/arch/powerpc/platforms/83xx/usb.c
> +++ b/arch/powerpc/platforms/83xx/usb.c
> @@ -124,10 +124,14 @@ int mpc831x_usb_cfg(void)
>  	}
>  
>  	/* Configure clock */
> -	temp = in_be32(immap + MPC83XX_SCCR_OFFS);
> -	temp &= ~MPC83XX_SCCR_USB_MASK;
> -	temp |= MPC83XX_SCCR_USB_DRCM_11;  /* 1:3 */
> -	out_be32(immap + MPC83XX_SCCR_OFFS, temp);
> +	if (of_find_compatible_node(NULL, NULL, "fsl,mpc8315-usb2-dr"))
> +		clrsetbits_be32(immap + MPC83XX_SCCR_OFFS,
> +		                MPC8315_SCCR_USB_MASK,
> +		                MPC8315_SCCR_USB_DRCM_11);

You need an of_node_put here.

Also, it's weird to check for the global presence of a compatible
device. You already have the device node pointer in the function, why
don't you just check to see if that device is compatible instead?


-Olof
