Return-Path: <michael@ellerman.id.au>
Date: Wed, 13 Mar 2013 16:04:03 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Jia Hongtao <B38951@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: workaround for chips with MSI hardware
 errata
Message-ID: <20130313050403.GB9317@concordia>
References: <1363074482-868-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363074482-868-1-git-send-email-B38951@freescale.com>
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 12, 2013 at 03:48:02PM +0800, Jia Hongtao wrote:
> The MPIC chip with version 2.0 has a MSI errata (errata PIC1 of mpc8544),
> It causes that neither MSI nor MSI-X can work fine. This is a workaround
> to allow MSI-X to function properly.

You say "neither MSI nor MSI-X can work fine", which I take to mean
"both MSI and MSI-X do not work".

But then you say this is a workaround to allow MSI-X to work.

So what I think you mean is, the erratum prevents both MSI and MSI-X
from working. This is a workaround that allows MSI-X to work, and in addition
the patch prevents MSI from being used on chips with the erratum -
because there is no workaround for MSI.

> diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
> index 178c994..0dea680 100644
> --- a/arch/powerpc/sysdev/fsl_msi.c
> +++ b/arch/powerpc/sysdev/fsl_msi.c
> @@ -98,8 +98,20 @@ static int fsl_msi_init_allocator(struct fsl_msi *msi_data)
>  
>  static int fsl_msi_check_device(struct pci_dev *pdev, int nvec, int type)
>  {
> +	struct fsl_msi *msi;
> +
>  	if (type == PCI_CAP_ID_MSIX)
>  		pr_debug("fslmsi: MSI-X untested, trying anyway.\n");

Seeing as this patch is enabling a workaround for MSI-X you've obviously
tested MSI-X, so you should remove the two lines above.

> +	else if (type == PCI_CAP_ID_MSI)
> +		/*
> +		 * MPIC chip with 2.0 version has erratum PIC1. It
> +		 * causes that neither MSI nor MSI-X can work fine.
> +		 * This is a workaround to allow MSI-X to function
> +		 * properly.
> +		 */

This is not a workaround. This is a check to prevent MSI from being used
on buggy chipsets.

> +		list_for_each_entry(msi, &msi_head, list)
> +			if (msi->feature & MSI_HW_ERRATA_ENDIAN)
> +				return -EINVAL;

I take it you're happy preventing MSI for all devices even if only a
single chip in the machine has the erratum? In practice you probably
have all or none with the erratum right?

I would suggest brackets on an if with such a large body, even though it
is OK as it is.

>  
>  	return 0;
>  }
> @@ -142,7 +154,11 @@ static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
>  	msg->address_lo = lower_32_bits(address);
>  	msg->address_hi = upper_32_bits(address);
>  
> -	msg->data = hwirq;
> +	/* See the comment in fsl_msi_check_device() */
> +	if (msi_data->feature & MSI_HW_ERRATA_ENDIAN)
> +		msg->data = __swab32(hwirq);
> +	else
> +		msg->data = hwirq;

This is the workaround. The comment here should say, "this only works
for MSI-X, we prevent MSI in on buggy chips in fsl_msi_check_device()".

>  
>  	pr_debug("%s: allocated srs: %d, ibs: %d\n",
>  		__func__, hwirq / IRQS_PER_MSI_REG, hwirq % IRQS_PER_MSI_REG);
> @@ -361,13 +377,43 @@ static int fsl_msi_setup_hwirq(struct fsl_msi *msi, struct platform_device *dev,
>  	return 0;
>  }
>  
> +/* MPIC chip with 2.0 version has erratum PIC1 */
> +static int mpic_has_errata(struct platform_device *dev)
> +{
> +	struct device_node *mpic_node;
> +
> +	mpic_node = of_irq_find_parent(dev->dev.of_node);
> +	if (mpic_node) {
> +		u32 *reg_base, brr1 = 0;
> +		/* Get the PIC reg base */
> +		reg_base = of_iomap(mpic_node, 0);
> +		of_node_put(mpic_node);
> +		if (!reg_base) {
> +			dev_err(&dev->dev, "ioremap problem failed.\n");
> +			return -EIO;
> +		}
> +
> +		/* Get the mpic chip version from block revision register 1 */
> +		brr1 = in_be32(reg_base + MPIC_FSL_BRR1);
> +		iounmap(reg_base);
> +		if ((brr1 & MPIC_FSL_BRR1_VER) == 0x0200)
> +			return 1;
> +	} else {
> +		dev_err(&dev->dev, "MSI can't find his parent mpic node.\n");
> +		of_node_put(mpic_node);

You don't need the put here, you know it's NULL (you just checked).

> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct of_device_id fsl_of_msi_ids[];
>  static int fsl_of_msi_probe(struct platform_device *dev)
>  {
>  	const struct of_device_id *match;
>  	struct fsl_msi *msi;
>  	struct resource res;
> -	int err, i, j, irq_index, count;
> +	int err, i, j, irq_index, count, errata;
>  	int rc;
>  	const u32 *p;
>  	const struct fsl_msi_feature *features;
> @@ -423,6 +469,16 @@ static int fsl_of_msi_probe(struct platform_device *dev)
>  
>  	msi->feature = features->fsl_pic_ip;
>  
> +	if ((features->fsl_pic_ip & FSL_PIC_IP_MASK) == FSL_PIC_IP_MPIC) {
> +		errata = mpic_has_errata(dev);
> +		if (errata > 0) {
> +			msi->feature |= MSI_HW_ERRATA_ENDIAN;
> +		} else if (errata < 0) {
> +			err = errata;
> +			goto error_out;
> +		}

I don't think you need errata here, "rc" would be fine.

cheers
