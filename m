Return-Path: <leoyang.li@nxp.com>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0073.outbound.protection.outlook.com [104.47.0.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slLNV1NNwzDskQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 02:57:45 +1000 (AEST)
From: Leo Li <leoyang.li@nxp.com>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, "leoli@freescale.com"
 <leoli@freescale.com>, "vinod.koul@intel.com" <vinod.koul@intel.com>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dma/fsldma : Unmap region obtained by of_iomap
Date: Thu, 29 Sep 2016 16:57:38 +0000
Message-ID: <AM2PR04MB077041DAFE156C77017972E68FCE0@AM2PR04MB0770.eurprd04.prod.outlook.com>
References: <1475059511-10114-1-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1475059511-10114-1-git-send-email-arvind.yadav.cs@gmail.com>
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



> -----Original Message-----
> From: Arvind Yadav [mailto:arvind.yadav.cs@gmail.com]
> Sent: Wednesday, September 28, 2016 5:45 AM
> To: leoli@freescale.com; zw@zh-kernel.org; vinod.koul@intel.com
> Cc: dan.j.williams@intel.com; linuxppc-dev@lists.ozlabs.org;
> dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] dma/fsldma : Unmap region obtained by of_iomap
>=20
> Free memory mapping, if probe is not successful.
>=20
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Acked-by: Li Yang <leoyang.li@nxp.com>

> ---
>  drivers/dma/fsldma.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c index
> 911b717..7ba8944 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1351,7 +1351,7 @@ static int fsldma_of_probe(struct platform_device
> *op)
>  	if (!fdev->regs) {
>  		dev_err(&op->dev, "unable to ioremap registers\n");
>  		err =3D -ENOMEM;
> -		goto out_free_fdev;
> +		goto out_free;
>  	}
>=20
>  	/* map the channel IRQ if it exists, but don't hookup the handler yet *=
/
> @@ -1416,6 +1416,8 @@ static int fsldma_of_probe(struct platform_device
> *op)
>=20
>  out_free_fdev:
>  	irq_dispose_mapping(fdev->irq);
> +	iounmap(fdev->regs);
> +out_free:
>  	kfree(fdev);
>  out_return:
>  	return err;
> --
> 1.7.9.5
