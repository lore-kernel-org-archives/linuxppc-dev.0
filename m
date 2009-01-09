Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C49DC47506
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jan 2009 13:35:09 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n092Z5nl025606
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jan 2009 19:35:05 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n092Z3rI023801
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jan 2009 20:35:04 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/2] powerpc/e500mc: Doorbells need to be taken
	w/exceptionsdisabled
Date: Fri, 9 Jan 2009 10:34:59 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB12089056DBD@zch01exm21.fsl.freescale.net>
In-Reply-To: <1231460116-26383-2-git-send-email-galak@kernel.crashing.org>
References: <1231460116-26383-1-git-send-email-galak@kernel.crashing.org>
	<1231460116-26383-2-git-send-email-galak@kernel.crashing.org>
From: "Liu Dave" <DaveLiu@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Acked-by: Dave Liu <daveliu@freescale.com>

> -----Original Message-----
> From: linuxppc-dev-bounces+daveliu=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+daveliu=3Dfreescale.com@ozlabs.org]
>  On Behalf Of Kumar Gala
> Sent: 2009?1?9? 8:15 AM
> To: linuxppc-dev@ozlabs.org
> Subject: [PATCH 2/2] powerpc/e500mc: Doorbells need to be=20
> taken w/exceptionsdisabled
>=20
> We use Doorbell interrupts for IPIs and thus we need to make=20
> sure we aren't
> interrupted in the process of processing the IPI.
>=20
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/head_fsl_booke.S |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/head_fsl_booke.S=20
> b/arch/powerpc/kernel/head_fsl_booke.S
> index 6062669..475c937 100644
> --- a/arch/powerpc/kernel/head_fsl_booke.S
> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> @@ -698,7 +698,7 @@ interrupt_base:
>  	/* Performance Monitor */
>  	EXCEPTION(0x2060, PerformanceMonitor,=20
> performance_monitor_exception, EXC_XFER_STD)
>  =09
> -	EXCEPTION(0x2070, Doorbell, unknown_exception, EXC_XFER_EE)
> +	EXCEPTION(0x2070, Doorbell, unknown_exception, EXC_XFER_STD)
> =20
>  	/* Debug Interrupt */
>  	DEBUG_DEBUG_EXCEPTION
> --=20
> 1.5.6.5
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
