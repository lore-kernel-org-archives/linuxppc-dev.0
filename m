Return-Path: <scott.wood@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0049.outbound.protection.outlook.com [104.47.2.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDgrt20zQzDqKX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 02:31:09 +1000 (AEST)
From: Scott Wood <scott.wood@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
CC: "scottwood@freescale.com" <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: Don't report SRAM to L2 cache fallback as
 error
Date: Tue, 24 May 2016 16:31:01 +0000
Message-ID: <DB5PR0401MB192818C12E929B766A82E60B914F0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1464102289-28740-1-git-send-email-claudiu.manoil@nxp.com>
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

On 05/24/2016 10:07 AM, Claudiu Manoil wrote:=0A=
> If the SRAM region parameters are missing the SRAM driver=0A=
> probing exits and the L2 region is configured as L2 cache=0A=
> entirely.  This is the expected default behaviour, so it=0A=
> makes no sense to report it as an error.=0A=
> =0A=
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>=0A=
> ---=0A=
>  arch/powerpc/sysdev/fsl_85xx_l2ctlr.c | 5 ++---=0A=
>  1 file changed, 2 insertions(+), 3 deletions(-)=0A=
> =0A=
> diff --git a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c b/arch/powerpc/sysdev/=
fsl_85xx_l2ctlr.c=0A=
> index 861cebf..15bc867 100644=0A=
> --- a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c=0A=
> +++ b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c=0A=
> @@ -91,9 +91,8 @@ static int mpc85xx_l2ctlr_of_probe(struct platform_devi=
ce *dev)=0A=
>  	l2cache_size =3D *prop;=0A=
>  =0A=
>  	if (get_cache_sram_params(&sram_params)) {=0A=
> -		dev_err(&dev->dev,=0A=
> -			"Entire L2 as cache, provide valid sram offset and size\n");=0A=
> -		return -EINVAL;=0A=
> +		dev_info(&dev->dev, "Configure entire L2 as cache\n");=0A=
> +		return 0;=0A=
>  	}=0A=
=0A=
There's no need to report it at all.  Imagine the mess that the boot log=0A=
would be (even more than it already is) if every driver built into the=0A=
kernel reported "no, didn't find this one".=0A=
=0A=
Plus, the message reads as a command to the user rather than a statement=0A=
of fact.=0A=
=0A=
-Scott=0A=
=0A=
