Return-Path: <qiang.zhao@nxp.com>
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70074.outbound.protection.outlook.com [40.107.7.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4216NZ4DsNzF35w
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 12:47:39 +1000 (AEST)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Leo Li
 <leoyang.li@nxp.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] soc: fsl/qe: Use of_get_child_by_name helper
Date: Thu, 30 Aug 2018 02:47:31 +0000
Message-ID: <VI1PR04MB32475E7E36BA8467FC07B01D91080@VI1PR04MB3247.eurprd04.prod.outlook.com>
References: <20180829200425.16435-1-robh@kernel.org>
In-Reply-To: <20180829200425.16435-1-robh@kernel.org>
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

From: Rob Herring <robh@kernel.org>
date: 2018/8/30 4:04

> To: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: linux-kernel@vger.kernel.org; Leo Li <leoyang.li@nxp.com>;
> linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org
> Subject: [PATCH] soc: fsl/qe: Use of_get_child_by_name helper
>=20
> Use the of_get_child_by_name() helper instead of open coding searching fo=
r the
> 'firmware' child node. This removes directly accessing the name pointer a=
s well.
>=20
> Cc: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: Li Yang <leoyang.li@nxp.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/soc/fsl/qe/qe.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c index
> 2ef6fc6487c1..612d9c551be5 100644
> --- a/drivers/soc/fsl/qe/qe.c
> +++ b/drivers/soc/fsl/qe/qe.c
> @@ -588,11 +588,7 @@ struct qe_firmware_info *qe_get_firmware_info(void)
>  	}
>=20
>  	/* Find the 'firmware' child node */
> -	for_each_child_of_node(qe, fw) {
> -		if (strcmp(fw->name, "firmware") =3D=3D 0)
> -			break;
> -	}
> -
> +	fw =3D of_get_child_by_name(qe, "firmware");
>  	of_node_put(qe);
>=20
>  	/* Did we find the 'firmware' node? */
> --

Acked-by: Qiang Zhao <qiang.zhao@nxp.com>
