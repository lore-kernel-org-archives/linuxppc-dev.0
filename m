Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjBHw67D8zDwVl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 06:46:36 +1100 (AEDT)
Message-ID: <1482176783.32531.28.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: madalin.bucur@nxp.com, netdev@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net
Date: Mon, 19 Dec 2016 13:46:23 -0600
In-Reply-To: <1482164013-6111-3-git-send-email-madalin.bucur@nxp.com>
References: <1482164013-6111-1-git-send-email-madalin.bucur@nxp.com>
 <1482164013-6111-3-git-send-email-madalin.bucur@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [upstream-release] [PATCH net v3 2/4] powerpc: fsl/fman: remove
 fsl, fman from of_device_ids[]
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-12-19 at 18:13 +0200, Madalin Bucur wrote:
> The fsl/fman drivers will use of_platform_populate() on all
> supported platforms. Call of_platform_populate() to probe the
> FMan sub-nodes.
> 
> Signed-off-by: Igal Liberman <igal.liberman@freescale.com>
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> ---
>  arch/powerpc/platforms/85xx/corenet_generic.c | 3 ---
>  drivers/net/ethernet/freescale/fman/fman.c    | 8 ++++++++
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c
> b/arch/powerpc/platforms/85xx/corenet_generic.c
> index 1179115..824b7f1 100644
> --- a/arch/powerpc/platforms/85xx/corenet_generic.c
> +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
> @@ -117,9 +117,6 @@ static const struct of_device_id of_device_ids[] = {
>  	{
>  		.compatible	= "fsl,qe",
>  	},
> -	{
> -		.compatible    = "fsl,fman",
> -	},
>  	/* The following two are for the Freescale hypervisor */
>  	{
>  		.name		= "hypervisor",

For this part:

Acked-by: Scott Wood <oss@buserror.net>

> diff --git a/drivers/net/ethernet/freescale/fman/fman.c
> b/drivers/net/ethernet/freescale/fman/fman.c
> index dafd9e1..0b7f711 100644
> --- a/drivers/net/ethernet/freescale/fman/fman.c
> +++ b/drivers/net/ethernet/freescale/fman/fman.c
> @@ -2868,6 +2868,14 @@ static struct fman *read_dts_node(struct
> platform_device *of_dev)
>  
>  	fman->dev = &of_dev->dev;
>  
> +	/* call of_platform_populate in order to probe sub-nodes on arm64
> */
> +	err = of_platform_populate(fm_node, NULL, NULL, &of_dev->dev);
> +	if (err) {
> +		dev_err(&of_dev->dev, "%s: of_platform_populate()
> failed\n",
> +			__func__);
> +		goto fman_free;
> +	}

The "on arm64" comment is no longer accurate (and the rest of the comment
seems unnecessary).

-Scott
