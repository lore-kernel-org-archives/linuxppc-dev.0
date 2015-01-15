Return-Path: <Yuantian.Tang@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0129.outbound.protection.outlook.com [65.55.169.129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4590F1A0E33
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 14:24:02 +1100 (AEDT)
From: Yuantian Tang <Yuantian.Tang@freescale.com>
To: Mike Turquette <mturquette@linaro.org>
Subject: RE: [PATCH v3 1/3] Revert "clk: ppc-corenet: Fix Section mismatch
 warning"
Date: Thu, 15 Jan 2015 02:50:33 +0000
Message-ID: <DM2PR03MB574CB90ADC584A950A493DAFA4E0@DM2PR03MB574.namprd03.prod.outlook.com>
References: <1417596833-31456-1-git-send-email-haokexin@gmail.com>
 <1417596833-31456-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1417596833-31456-2-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Kevin Hao <haokexin@gmail.com>, Gerhard Sittig <gsi@denx.de>,
 Jingchang Lu <jingchang.lu@freescale.com>,
 Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PING!

Thanks,
Yuantian

> -----Original Message-----
> From: Kevin Hao [mailto:haokexin@gmail.com]
> Sent: Wednesday, December 03, 2014 4:54 PM
> To: linuxppc-dev@lists.ozlabs.org
> Cc: Benjamin Herrenschmidt; Wood Scott-B07421; Mike Turquette; Lu
> Jingchang-B35083; Gerhard Sittig; Tang Yuantian-B29983
> Subject: [PATCH v3 1/3] Revert "clk: ppc-corenet: Fix Section mismatch wa=
rning"
>=20
> This reverts commit da788acb28386aa896224e784954bb73c99ff26c.
>=20
> That commit tried to fix the section mismatch warning by moving the
> ppc_corenet_clk_driver struct to init section. This is definitely wrong b=
ecause the
> kernel would free the memories occupied by this struct after boot while t=
his
> driver is still registered in the driver core.
> The kernel would panic when accessing this driver struct.
>=20
> Cc: stable@vger.kernel.org # 3.17
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> Acked-by: Scott Wood <scottwood@freescale.com>
> Acked-by: Michael Turquette <mturquette@linaro.org>
> ---
> v3: Cc stable and add ack.
>=20
> v2: A new patch in v2.
>=20
>  drivers/clk/clk-ppc-corenet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corenet.=
c index
> b6e6c85507a5..0a47d6f49cd6 100644
> --- a/drivers/clk/clk-ppc-corenet.c
> +++ b/drivers/clk/clk-ppc-corenet.c
> @@ -291,7 +291,7 @@ static const struct of_device_id ppc_clk_ids[] __init=
const
> =3D {
>  	{}
>  };
>=20
> -static struct platform_driver ppc_corenet_clk_driver __initdata =3D {
> +static struct platform_driver ppc_corenet_clk_driver =3D {
>  	.driver =3D {
>  		.name =3D "ppc_corenet_clock",
>  		.of_match_table =3D ppc_clk_ids,
> --
> 1.9.3
