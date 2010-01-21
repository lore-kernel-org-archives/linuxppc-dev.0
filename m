Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f204.google.com (mail-iw0-f204.google.com
	[209.85.223.204]) by ozlabs.org (Postfix) with ESMTP id E5950B7CEA
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2010 04:22:48 +1100 (EST)
Received: by iwn42 with SMTP id 42so187890iwn.9
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jan 2010 09:22:47 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1263932653-3634-8-git-send-email-agust@denx.de>
References: <1263932653-3634-1-git-send-email-agust@denx.de>
	<1263932653-3634-8-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 21 Jan 2010 10:22:27 -0700
Message-ID: <fa686aa41001210922h280be005pda88e5859b2769f1@mail.gmail.com>
Subject: Re: [PATCH 07/11] dma: Add MPC512x DMA driver
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: wd@denx.de, dzu@denx.de, linuxppc-dev@ozlabs.org,
	Dan Williams <dan.j.williams@intel.com>, Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 19, 2010 at 1:24 PM, Anatolij Gustschin <agust@denx.de> wrote:
> From: Piotr Ziecik <kosmo@semihalf.com>
>
> Adds initial version of MPC512x DMA driver.
> Only memory to memory transfers are currenly supported.

Comments below on brief review.  I've not looked at the code in-depth.

> Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: John Rigby <jcrigby@gmail.com>
> ---
> =A0drivers/dma/Kconfig =A0 =A0 =A0 | =A0 =A07 +
> =A0drivers/dma/Makefile =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/dma/mpc512x_dma.c | =A0636 +++++++++++++++++++++++++++++++++++=
++++++++++
> =A0drivers/dma/mpc512x_dma.h | =A0192 ++++++++++++++

Unless the stuff in the .h file is used by other .c files, it really
belongs in mpc512x_dma.c

> +static int __init mpc_dma_probe(struct of_device *op,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 const struct of_device_id *match)

__devinit

> +static void __exit mpc_dma_remove(struct of_device *op)

__devexit

> +{
> + =A0 =A0 =A0 struct device *dev =3D &op->dev;
> + =A0 =A0 =A0 struct mpc_dma *mdma =3D dev_get_drvdata(dev);
> +
> + =A0 =A0 =A0 devm_free_irq(dev, mdma->irq, mdma);
> +}

No unregistration of the dma device?  No unmapping?  No kfree()?

> +
> +static struct of_device_id mpc_dma_match[] =3D {
> + =A0 =A0 =A0 { .compatible =3D "fsl,mpc5121-dma", },
> + =A0 =A0 =A0 {},
> +};
> +
> +static struct of_platform_driver mpc_dma_driver =3D {
> + =A0 =A0 =A0 .match_table =A0 =A0=3D mpc_dma_match,
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D mpc_dma_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __exit_p(mpc_dma_remove),

__devexit_p()

> + =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D DRV_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 },
> +};
> +
> +static int __init mpc_dma_init(void)
> +{
> + =A0 =A0 =A0 return of_register_platform_driver(&mpc_dma_driver);
> +}
> +module_init(mpc_dma_init);
> +
> +static void __exit mpc_dma_exit(void)
> +{
> + =A0 =A0 =A0 of_unregister_platform_driver(&mpc_dma_driver);
> +}
> +module_exit(mpc_dma_exit);
> +
> +/* MODULE API */

Meaningless comment.

> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Piotr Ziecik <kosmo@semihalf.com>");

Thanks,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
