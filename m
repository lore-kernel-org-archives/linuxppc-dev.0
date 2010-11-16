Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D92BDB7109
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Nov 2010 01:01:22 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 4/4][v2] rapidio,
	powerpc/85xx: Error interrupt handler for sRIO.
Date: Tue, 16 Nov 2010 06:00:42 -0800
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552015397DD@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <1288777048-25105-1-git-send-email-b21989@freescale.com>
References: <1288777048-25105-1-git-send-email-b21989@freescale.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Shaohui Xie" <b21989@freescale.com>, <akpm@linux-foundation.org>
Cc: Kumar Gala <kumar.gala@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> From: Shaohui Xie [mailto:b21989@freescale.com]
>=20
> The sRIO controller reports errors to the core with one signal, it
uses
> register EPWISR to provides the core quick access to where the error
occurred.
> The EPWISR indicates that there are 4 interrupts sources, port1,
port2, message
> unit and port write receive, but the sRIO driver does not support
port2
> for now, still the handler takes care of port2.
> Currently the handler only clear error status without any recovery.
>

Do these dual-RIO controllers have only one port-write interrupt?
(sorry, user manuals are not available for download from FSL).  =20
=20
> @@ -1082,14 +1142,24 @@ fsl_rio_port_write_handler(int irq, void
*dev_instance)
>  	ipwsr =3D in_be32(&priv->msg_regs->pwsr);
>=20
>  	epwisr =3D in_be32(priv->regs_win + RIO_EPWISR);
> -	if (epwisr & 0x80000000) {
> +	if (epwisr & EPWISR_ERR_PINT1) {
>  		tmp =3D in_be32(priv->regs_win + RIO_LTLEDCSR);
>  		pr_info("RIO_LTLEDCSR =3D 0x%x\n", tmp);
> -		out_be32(priv->regs_win + RIO_LTLEDCSR, 0);
> +		port_error_handler(port, 0);
> +	}
> +
> +	if (epwisr & EPWISR_ERR_PINT2) {
> +		pr_info("RIO: port2 error\n");
> +		port_error_handler(port, 1);
> +	}
> +
> +	if (epwisr & EPWISR_ERR_MU) {
> +		pr_info("RIO: message unit error\n");
> +		msg_unit_error_handler(port);
>  	}
>=20
> -	if (!(epwisr & 0x00000001))
> -		return IRQ_HANDLED;
> +	if (!(epwisr & EPWISR_ERR_PW))
> +		return IRQ_NONE;
>=20
>  #ifdef DEBUG_PW
>  	pr_debug("PW Int->IPWMR: 0x%08x IPWSR: 0x%08x (", ipwmr, ipwsr);

This part is out of sync with mainline code tree (37-rc1). Probably it
should be updated to make it easier to apply your patch. Besides that,
works as expected on my RIO setup.

Regards,

Alex.
