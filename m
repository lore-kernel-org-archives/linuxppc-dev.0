Return-Path: <roy.pledge@nxp.com>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20076.outbound.protection.outlook.com [40.107.2.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xklP36bYzDqj4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Aug 2018 00:52:08 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Leo Li
 <leoyang.li@nxp.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] soc: fsl: qbman: qman_portal: defer probing when qman
 is not available
Date: Fri, 24 Aug 2018 14:52:02 +0000
Message-ID: <DB6PR0402MB27276B417034E7356B0CFA5886360@DB6PR0402MB2727.eurprd04.prod.outlook.com>
References: <20180823213600.23426-1-alexandre.belloni@bootlin.com>
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

On 8/23/2018 5:36 PM, Alexandre Belloni wrote:=0A=
> If the qman driver (qman_ccsr) doesn't probe or fail to probe before=0A=
> qman_portal, qm_ccsr_start will be either NULL or a stale pointer to an=
=0A=
> unmapped page.=0A=
>=0A=
> This leads to a crash when probing  qman_portal as the init_pcfg function=
=0A=
> calls qman_liodn_fixup that tries to read qman registers.=0A=
>=0A=
> Assume that qman didn't probe when the pool mask is 0.=0A=
>=0A=
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>=0A=
> ---=0A=
>  drivers/soc/fsl/qbman/qman_portal.c | 2 ++=0A=
>  1 file changed, 2 insertions(+)=0A=
>=0A=
> diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/=
qman_portal.c=0A=
> index a120002b630e..4fc80d2c8feb 100644=0A=
> --- a/drivers/soc/fsl/qbman/qman_portal.c=0A=
> +++ b/drivers/soc/fsl/qbman/qman_portal.c=0A=
> @@ -277,6 +277,8 @@ static int qman_portal_probe(struct platform_device *=
pdev)=0A=
>  	}=0A=
>  =0A=
>  	pcfg->pools =3D qm_get_pools_sdqcr();=0A=
> +	if (pcfg->pools =3D=3D 0)=0A=
> +		return -EPROBE_DEFER;=0A=
>  =0A=
>  	spin_lock(&qman_lock);=0A=
>  	cpu =3D cpumask_next_zero(-1, &portal_cpus);=0A=
=0A=
Reviewed-by: Roy Pledge <roy.pledge@nxp.com>=0A=
=0A=
=0A=
