Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 9F3D7DDE38
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Oct 2007 00:21:59 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2] drivers/ata: add support to Freescale 3.0Gbps SATA
	Controller
Date: Fri, 12 Oct 2007 16:21:50 +0200
References: <1192196849-24758-1-git-send-email-leoli@freescale.com>
In-Reply-To: <1192196849-24758-1-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710121621.50649.arnd@arndb.de>
Cc: linux-ide@vger.kernel.org, Li Yang <leoli@freescale.com>, jgarzik@pobox.com,
	Ashish Kalra <ashish.kalra@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 12 October 2007, Li Yang wrote:
> This patch adds support for Freescale 3.0Gbps SATA Controller supporting
> Native Command Queueing(NCQ), device hotplug, and ATAPI.  This controller
> can be found on MPC8315 and MPC8378.

Most of the driver looks really good, but here are a few things that
stick out:

> +static int sata_fsl_probe(struct of_device *ofdev,
> +			const struct of_device_id *match)
> +{
> +	int retval = 0;
> +	void __iomem *hcr_base = NULL;
> +	void __iomem *ssr_base = NULL;
> +	void __iomem *csr_base = NULL;
> +	struct sata_fsl_host_priv *host_priv = NULL;
> +	struct resource *r;
> +	int irq;
> +	struct ata_host *host;
> +
> +	struct ata_port_info pi = sata_fsl_port_info[0];
> +	const struct ata_port_info *ppi[] = { &pi, NULL };
> +
> +	dev_printk(KERN_INFO, &ofdev->dev,
> +		   "Sata FSL Platform/CSB Driver init\n");
> +
> +	r = kmalloc(sizeof(struct resource), GFP_KERNEL);
> +	retval = of_address_to_resource(ofdev->node, 0, r);
> +	if (retval)
> +		return -EINVAL;
> +
> +	DPRINTK("start i/o @0x%x\n", r->start);
> +
> +	hcr_base = ioremap(r->start, r->end - r->start + 1);
> +	if (!hcr_base)
> +		goto error_exit_with_cleanup;

Hmm, I think we should redefine of_iomap to do the right thing
for you. currently, it is the combination of of_address_to_resource
and ioremap, which you do as well, so your code can be simplified
to do that. However, ioremap is meant to be used with readl/writel
or in_le32/out_le32 and similar functions, not with ioread32/iowrite32
which you are using.

I had planned to do a patch to get that right for some time so
you can use of_iomap with ioread in all cases, but I guess you
should start using of_iomap even now.

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

Once of_iomap start using devres, we would no longer need to iounmap here.

> +static int sata_fsl_remove(struct of_device *ofdev)
> +{
> +	struct ata_host *host = dev_get_drvdata(&ofdev->dev);
> +	struct sata_fsl_host_priv *host_priv = host->private_data;
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

The header file is entirely pointless, since all definitions in here
are only used in a single file. Please merge the header into the
implementation.

> +static int sata_fsl_probe(struct of_device *ofdev,
> +			const struct of_device_id *match);
> +static int sata_fsl_remove(struct of_device *ofdev);
> +static int sata_fsl_scr_read(struct ata_port *, unsigned int, u32 *);
> +static int sata_fsl_scr_write(struct ata_port *, unsigned int, u32);
> +static unsigned int sata_fsl_qc_issue(struct ata_queued_cmd *);
> +static irqreturn_t sata_fsl_interrupt(int, void *);
> +static void sata_fsl_irq_clear(struct ata_port *);
> +static int sata_fsl_port_start(struct ata_port *);
> +static void sata_fsl_port_stop(struct ata_port *);
> +static void sata_fsl_tf_read(struct ata_port *, struct ata_taskfile *);
> +static void sata_fsl_qc_prep(struct ata_queued_cmd *);
> +static u8 sata_fsl_check_status(struct ata_port *);
> +static void sata_fsl_freeze(struct ata_port *);
> +static void sata_fsl_thaw(struct ata_port *);
> +static void sata_fsl_error_handler(struct ata_port *);
> +static void sata_fsl_post_internal_cmd(struct ata_queued_cmd *);
> +
> +static inline unsigned int sata_fsl_tag(unsigned int, void __iomem *);

In particular, get rid of the forward declarations for static functions.
All functions in a simple driver should be ordered in a way that you
always reference only code that was previously defined. This helps
avoid accidental recursions and makes it easier to review.

	Arnd <><
