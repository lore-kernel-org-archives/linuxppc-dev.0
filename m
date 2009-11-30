Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B2546B6F19
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 Nov 2009 16:50:13 +1100 (EST)
Subject: Re: [PATCH] powerpc: Restore dma ops for powermac cardbus drivers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: roger blofeld <blofeldus@yahoo.com>
In-Reply-To: <187031.59622.qm@web53502.mail.re2.yahoo.com>
References: <187031.59622.qm@web53502.mail.re2.yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 30 Nov 2009 16:49:27 +1100
Message-ID: <1259560167.2076.58.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2009-11-29 at 20:23 -0800, roger blofeld wrote:
> Commit 4ae0ff606e848fa4957ebf8f97e5db5fdeec27be broke dma setup for cardbus
> devices such as sata_sil, rt2500 and ath5k. This patch restores the default
> dma ops for cardbus devices. Tested with sata_sil on a powerbook G4.
> 
> bz#537176
> 
> Signed-off-by: Roger Blofeld <blofeldus@yahoo.com>

Hi !

That's an interesting way to do it :-)

However, I suppose a better approach would be to fix cardbus to call the
proper fixup code in the arch, ie, dma isn't the only thing that's going
to be broken without that (at least maybe on pmac that is, but machines
with an iommu will suffer etc...)

I will try to have a look as soon as I'm done with porting the pmac IDE
driver to libata.

Cheers,
Ben.

> ---
> The inline patch is whitespace damaged by this mailer. The attachment should be ok,
> and passes checkpatch.pl
> 
> 
> diff -up linux-2.6.30.ppc/arch/powerpc/platforms/powermac/setup.c.orig linux-2.6.30.ppc/arch/powerpc/platforms/powermac/setup.c
> --- linux-2.6.30.ppc/arch/powerpc/platforms/powermac/setup.c.orig    2009-06-09 22:05:27.000000000 -0500
> +++ linux-2.6.30.ppc/arch/powerpc/platforms/powermac/setup.c    2009-11-29 21:47:15.000000000 -0600
> @@ -514,6 +514,44 @@ static void __init pmac_init_early(void)
>  #endif
>  }
>  
> +#ifdef CONFIG_CARDBUS
> +static int pmac_cardbus_notify(struct notifier_block *nb, unsigned long action,
> +             void *data)
> +{
> +    struct device *dev = data;
> +    struct device *parent;
> +    struct pci_dev *pdev = to_pci_dev(dev);
> +
> +    /* We are only interested in device addition */
> +    if (action != BUS_NOTIFY_ADD_DEVICE)
> +        return 0;
> +
> +    parent = pdev->dev.parent;
> +
> +    if (!parent->archdata.of_node)
> +        return 0;
> +
> +    if (!of_device_is_compatible(parent->archdata.of_node,
> +            "cardbus-bridge"))
> +        return 0;
> +
> +    /* We use the direct ops for cardbus */
> +    dev->archdata.dma_ops = &dma_direct_ops;
> +
> +    return 0;
> +}
> +
> +static struct notifier_block cardbus_notifier = {
> +    .notifier_call = pmac_cardbus_notify,
> +};
> +
> +static int __init pmac_cardbus_init(void)
> +{
> +    return bus_register_notifier(&pci_bus_type, &cardbus_notifier);
> +}
> +machine_device_initcall(powermac, pmac_cardbus_init);
> +#endif
> +
>  static int __init pmac_declare_of_platform_devices(void)
>  {
>      struct device_node *np;
> 
> 
>       
