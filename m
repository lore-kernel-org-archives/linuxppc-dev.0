Return-Path: <ashish.kalra@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 93282DDE9A
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 21:30:14 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l9FBU5Ge001264
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 04:30:06 -0700 (MST)
Received: from zin33exm20.fsl.freescale.net (zin33exm20.ap.freescale.net
	[10.232.192.5])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9FBU4Wo024521
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 06:30:05 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2] drivers/ata: add support to Freescale 3.0Gbps SATA
	Controller
Date: Mon, 15 Oct 2007 17:00:01 +0530
Message-ID: <2A6F278C5B66C4459AF4013E77A40CD3FCBB59@zin33exm20.fsl.freescale.net>
In-Reply-To: <200710121621.50649.arnd@arndb.de>
From: "Kalra Ashish-B00888" <ashish.kalra@freescale.com>
To: "Arnd Bergmann" <arnd@arndb.de>, <linuxppc-dev@ozlabs.org>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com,
	Kalra Ashish-B00888 <ashish.kalra@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Arnd,

Thanks for your comments and feedback.

Actually, for PowerPC platforms iowrite32/ioread32 internally call
writel/readl, which are again mapped to out_le32/in_le32,
therefore we will modify our code to use of_iomap() to combine
functionalities of both of_address_to_resource() & ioremap().

We will also incorporate your other suggestions and then resubmit the
patch.

Ashish

-----Original Message-----
From: Arnd Bergmann [mailto:arnd@arndb.de]=20
Sent: Friday, October 12, 2007 7:52 PM
To: linuxppc-dev@ozlabs.org
Cc: Li Yang-r58472; jgarzik@pobox.com; linux-ide@vger.kernel.org; Kalra
Ashish-B00888
Subject: Re: [PATCH v2] drivers/ata: add support to Freescale 3.0Gbps
SATA Controller

On Friday 12 October 2007, Li Yang wrote:
> This patch adds support for Freescale 3.0Gbps SATA Controller=20
> supporting Native Command Queueing(NCQ), device hotplug, and ATAPI. =20
> This controller can be found on MPC8315 and MPC8378.

Most of the driver looks really good, but here are a few things that
stick out:

> +static int sata_fsl_probe(struct of_device *ofdev,
> +			const struct of_device_id *match)
> +{
> +	int retval =3D 0;
> +	void __iomem *hcr_base =3D NULL;
> +	void __iomem *ssr_base =3D NULL;
> +	void __iomem *csr_base =3D NULL;
> +	struct sata_fsl_host_priv *host_priv =3D NULL;
> +	struct resource *r;
> +	int irq;
> +	struct ata_host *host;
> +
> +	struct ata_port_info pi =3D sata_fsl_port_info[0];
> +	const struct ata_port_info *ppi[] =3D { &pi, NULL };
> +
> +	dev_printk(KERN_INFO, &ofdev->dev,
> +		   "Sata FSL Platform/CSB Driver init\n");
> +
> +	r =3D kmalloc(sizeof(struct resource), GFP_KERNEL);
> +	retval =3D of_address_to_resource(ofdev->node, 0, r);
> +	if (retval)
> +		return -EINVAL;
> +
> +	DPRINTK("start i/o @0x%x\n", r->start);
> +
> +	hcr_base =3D ioremap(r->start, r->end - r->start + 1);
> +	if (!hcr_base)
> +		goto error_exit_with_cleanup;

Hmm, I think we should redefine of_iomap to do the right thing for you.
currently, it is the combination of of_address_to_resource and ioremap,
which you do as well, so your code can be simplified to do that.
However, ioremap is meant to be used with readl/writel or
in_le32/out_le32 and similar functions, not with ioread32/iowrite32
which you are using.

I had planned to do a patch to get that right for some time so you can
use of_iomap with ioread in all cases, but I guess you should start
using of_iomap even now.

> +
> +error_exit_with_cleanup:
> +
> +	if (hcr_base)
> +		iounmap(hcr_base);
> +	if (host_priv)
> +		kfree(host_priv);
> +
> +	return retval;
> +}

Once of_iomap start using devres, we would no longer need to iounmap
here.

> +static int sata_fsl_remove(struct of_device *ofdev) {
> +	struct ata_host *host =3D dev_get_drvdata(&ofdev->dev);
> +	struct sata_fsl_host_priv *host_priv =3D host->private_data;
> +
> +	dev_set_drvdata(&ofdev->dev, NULL);
> +
> +	iounmap(host_priv->hcr_base);
> +	kfree(host_priv);
> +
> +	return 0;
> +}

Should you also free the irq mapping here?

> --- /dev/null
> +++ b/drivers/ata/sata_fsl.h
> @@ -0,0 +1,92 @@
> +/*
> + * drivers/ata/sata_fsl.h
> + *
> + * Freescale 3.0Gbps SATA device driver

The header file is entirely pointless, since all definitions in here are
only used in a single file. Please merge the header into the
implementation.

> +static int sata_fsl_probe(struct of_device *ofdev,
> +			const struct of_device_id *match); static int=20
> +sata_fsl_remove(struct of_device *ofdev); static int=20
> +sata_fsl_scr_read(struct ata_port *, unsigned int, u32 *); static int

> +sata_fsl_scr_write(struct ata_port *, unsigned int, u32); static=20
> +unsigned int sata_fsl_qc_issue(struct ata_queued_cmd *); static=20
> +irqreturn_t sata_fsl_interrupt(int, void *); static void=20
> +sata_fsl_irq_clear(struct ata_port *); static int=20
> +sata_fsl_port_start(struct ata_port *); static void=20
> +sata_fsl_port_stop(struct ata_port *); static void=20
> +sata_fsl_tf_read(struct ata_port *, struct ata_taskfile *); static=20
> +void sata_fsl_qc_prep(struct ata_queued_cmd *); static u8=20
> +sata_fsl_check_status(struct ata_port *); static void=20
> +sata_fsl_freeze(struct ata_port *); static void sata_fsl_thaw(struct=20
> +ata_port *); static void sata_fsl_error_handler(struct ata_port *);=20
> +static void sata_fsl_post_internal_cmd(struct ata_queued_cmd *);
> +
> +static inline unsigned int sata_fsl_tag(unsigned int, void __iomem=20
> +*);

In particular, get rid of the forward declarations for static functions.
All functions in a simple driver should be ordered in a way that you
always reference only code that was previously defined. This helps avoid
accidental recursions and makes it easier to review.

	Arnd <><
