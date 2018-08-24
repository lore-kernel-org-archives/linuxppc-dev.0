Return-Path: <roy.pledge@nxp.com>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02on061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe06::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xknR1nqZzDqx0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Aug 2018 00:54:02 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Leo Li
 <leoyang.li@nxp.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] soc: fsl: qbman: qman: avoid allocating from non
 existing gen_pool
Date: Fri, 24 Aug 2018 14:53:56 +0000
Message-ID: <DB6PR0402MB272745FC786675AB113E7C7986360@DB6PR0402MB2727.eurprd04.prod.outlook.com>
References: <20180823213600.23426-1-alexandre.belloni@bootlin.com>
 <20180823213600.23426-2-alexandre.belloni@bootlin.com>
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
> If the qman driver didn't probe, calling qman_alloc_fqid_range,=0A=
> qman_alloc_pool_range or qman_alloc_cgrid_range (as done in dpaa_eth) wil=
l=0A=
> pass a NULL pointer to gen_pool_alloc, leading to a NULL pointer=0A=
> dereference.=0A=
>=0A=
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>=0A=
> ---=0A=
>  drivers/soc/fsl/qbman/qman.c | 3 +++=0A=
>  1 file changed, 3 insertions(+)=0A=
>=0A=
> diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c=
=0A=
> index ecb22749df0b..8cc015183043 100644=0A=
> --- a/drivers/soc/fsl/qbman/qman.c=0A=
> +++ b/drivers/soc/fsl/qbman/qman.c=0A=
> @@ -2729,6 +2729,9 @@ static int qman_alloc_range(struct gen_pool *p, u32=
 *result, u32 cnt)=0A=
>  {=0A=
>  	unsigned long addr;=0A=
>  =0A=
> +	if (!p)=0A=
> +		return -ENODEV;=0A=
> +=0A=
>  	addr =3D gen_pool_alloc(p, cnt);=0A=
>  	if (!addr)=0A=
>  		return -ENOMEM;=0A=
=0A=
Reviewed-by: Roy Pledge <roy.pledge@nxp.com>=0A=
=0A=
