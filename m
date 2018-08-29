Return-Path: <qiang.zhao@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420VbW2B3pzDrM8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 12:54:57 +1000 (AEST)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: David Gounaris <david.gounaris@infinera.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
CC: David Gounaris <david.gounaris@infinera.com>
Subject: RE: [PATCH 4/6] net/wan/fsl_ucc_hdlc: default hmask value
Date: Wed, 29 Aug 2018 02:54:50 +0000
Message-ID: <VI1PR04MB3247E6EBE63C39F5E1C792F191090@VI1PR04MB3247.eurprd04.prod.outlook.com>
References: <20180828110921.2542-1-david.gounaris@infinera.com>
 <20180828110921.2542-5-david.gounaris@infinera.com>
In-Reply-To: <20180828110921.2542-5-david.gounaris@infinera.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: David Gounaris <david.gounaris@infinera.com>
Date: 2018/8/28 19:09
> Subject: [PATCH 4/6] net/wan/fsl_ucc_hdlc: default hmask value
>=20
> Set default HMASK to 0x0000 to use
> promiscuous mode in the hdlc controller.
>=20
> Signed-off-by: David Gounaris <david.gounaris@infinera.com>
> ---
>  drivers/net/wan/fsl_ucc_hdlc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wan/fsl_ucc_hdlc.h b/drivers/net/wan/fsl_ucc_hdl=
c.h
> index c21134c1f180..5bc3d1a6ca6e 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.h
> +++ b/drivers/net/wan/fsl_ucc_hdlc.h
> @@ -134,7 +134,7 @@ struct ucc_hdlc_private {
>=20
>  #define HDLC_HEAD_MASK		0x0000
>  #define DEFAULT_HDLC_HEAD	0xff44
> -#define DEFAULT_ADDR_MASK	0x00ff
> +#define DEFAULT_ADDR_MASK	0x0000
>  #define DEFAULT_HDLC_ADDR	0x00ff
>=20
>  #define BMR_GBL			0x20000000
> --

It is not proper to set default HMASK to 0x0000, how about to add a new pro=
perty standing for hmask into device tree,
If get this property from dtb, then set it with the value from dtb, otherwi=
se, set it with default HMASK ox00ff?

Best Regards
Qiang Zhao
