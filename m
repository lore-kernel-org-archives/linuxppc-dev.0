Return-Path: <Jason.Jin@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DA2D1DDF33
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 20:48:47 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m6HAmedJ000075
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 03:48:40 -0700 (MST)
Received: from zch01exm27.fsl.freescale.net (zch01exm27.ap.freescale.net
	[10.192.129.223])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m6HAmcPE028005
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 05:48:39 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/4] powerpc: fsl_msi doesn't need it's own of_node
Date: Thu, 17 Jul 2008 18:48:59 +0800
Message-ID: <CC27DED0F8F39E48A7E75FD768688B7AAC731A@zch01exm27.fsl.freescale.net>
In-Reply-To: <378edcf6ad114d35166364c5df03a8c422f757a1.1216133084.git.michael@ellerman.id.au>
References: <378edcf6ad114d35166364c5df03a8c422f757a1.1216133084.git.michael@ellerman.id.au>
From: "Jin Zhengxiong" <Jason.Jin@freescale.com>
To: "Michael Ellerman" <michael@ellerman.id.au>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: Olof Johannsson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Gala Kumar <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ack, Tested the patch set on Freescale board and working good.
Thanks

Jason Jin=20

> -----Original Message-----
> From: Michael Ellerman [mailto:michael@ellerman.id.au]=20
> Sent: Tuesday, July 15, 2008 10:46 PM
> To: Benjamin Herrenschmidt
> Cc: linuxppc-dev@ozlabs.org; Olof Johannsson; Gala Kumar; Jin=20
> Zhengxiong
> Subject: [PATCH 1/4] powerpc: fsl_msi doesn't need it's own of_node
>=20
> The FSL MSI code keeps a pointer to the of_node from the=20
> device it represents. However it also has an irq_host, which=20
> contains a pointer to the of_node, so use that one instead.
>=20
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  arch/powerpc/sysdev/fsl_msi.c |   12 +++++-------
>  arch/powerpc/sysdev/fsl_msi.h |    3 ---
>  2 files changed, 5 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/fsl_msi.c=20
> b/arch/powerpc/sysdev/fsl_msi.c index 2c5187c..d49fa99 100644
> --- a/arch/powerpc/sysdev/fsl_msi.c
> +++ b/arch/powerpc/sysdev/fsl_msi.c
> @@ -108,7 +108,8 @@ static int fsl_msi_free_dt_hwirqs(struct=20
> fsl_msi *msi)
>  	bitmap_allocate_region(msi->fsl_msi_bitmap, 0,
>  		       get_count_order(NR_MSI_IRQS));
> =20
> -	p =3D of_get_property(msi->of_node, "msi-available-ranges", &len);
> +	p =3D of_get_property(msi->irqhost->of_node,=20
> "msi-available-ranges",
> +			    &len);
> =20
>  	if (!p) {
>  		/* No msi-available-ranges property,
> @@ -120,7 +121,7 @@ static int fsl_msi_free_dt_hwirqs(struct=20
> fsl_msi *msi)
> =20
>  	if ((len % (2 * sizeof(u32))) !=3D 0) {
>  		printk(KERN_WARNING "fsl_msi: Malformed=20
> msi-available-ranges "
> -		       "property on %s\n", msi->of_node->full_name);
> +		       "property on %s\n",=20
> msi->irqhost->of_node->full_name);
>  		return -EINVAL;
>  	}
> =20
> @@ -317,14 +318,11 @@ static int __devinit=20
> fsl_of_msi_probe(struct of_device *dev,
>  		goto error_out;
>  	}
> =20
> -	msi->of_node =3D of_node_get(dev->node);
> +	msi->irqhost =3D irq_alloc_host(dev->node, IRQ_HOST_MAP_LINEAR,
> +				      NR_MSI_IRQS,=20
> &fsl_msi_host_ops, 0);
> =20
> -	msi->irqhost =3D irq_alloc_host(of_node_get(dev->node),
> -				IRQ_HOST_MAP_LINEAR,
> -				NR_MSI_IRQS, &fsl_msi_host_ops, 0);
>  	if (msi->irqhost =3D=3D NULL) {
>  		dev_err(&dev->dev, "No memory for MSI irqhost\n");
> -		of_node_put(dev->node);
>  		err =3D -ENOMEM;
>  		goto error_out;
>  	}
> diff --git a/arch/powerpc/sysdev/fsl_msi.h=20
> b/arch/powerpc/sysdev/fsl_msi.h index a653468..6574550 100644
> --- a/arch/powerpc/sysdev/fsl_msi.h
> +++ b/arch/powerpc/sysdev/fsl_msi.h
> @@ -22,9 +22,6 @@
>  #define FSL_PIC_IP_IPIC	0x00000002
> =20
>  struct fsl_msi {
> -	/* Device node of the MSI interrupt*/
> -	struct device_node *of_node;
> -
>  	struct irq_host *irqhost;
> =20
>  	unsigned long cascade_irq;
> --
> 1.5.5
>=20
>=20
