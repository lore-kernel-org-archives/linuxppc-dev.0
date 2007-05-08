Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id F32D3DDE2B
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 02:45:19 +1000 (EST)
Date: Tue, 8 May 2007 11:45:13 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 4/7] Add support for 750CL Holly board
Message-ID: <20070508164513.GD19780@localdomain>
References: <1178572962.2990.197.camel@zod.rchland.ibm.com>
	<1178573318.2990.206.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1178573318.2990.206.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Josh-

I see this has been picked up by Paul already, but there are a couple
minor things I noticed as I was reading the patch.


> +int holly_exclude_device(u_char bus, u_char devfn)
> +{
> +	if (bus == 0 && PCI_SLOT(devfn) == 0)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	else
> +		return PCIBIOS_SUCCESSFUL;
> +}

This function could be static, I think?  Looks like it's assigned to
ppc_md.pci_exclude_device and called through that.


> +static void __init holly_init_IRQ(void)
> +{
> +	struct mpic *mpic;
> +	phys_addr_t mpic_paddr = 0;
> +	struct device_node *tsi_pic;
> +#ifdef CONFIG_PCI
> +	unsigned int cascade_pci_irq;
> +	struct device_node *tsi_pci;
> +	struct device_node *cascade_node = NULL;
> +#endif
> +
> +	tsi_pic = of_find_node_by_type(NULL, "open-pic");
> +	if (tsi_pic) {
> +		unsigned int size;
> +		const void *prop = of_get_property(tsi_pic, "reg", &size);
> +		mpic_paddr = of_translate_address(tsi_pic, prop);
> +	}

You don't actually need 'size' there; it's legal to pass NULL to
of_get_property.
