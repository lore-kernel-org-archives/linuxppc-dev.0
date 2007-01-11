Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26741DDF99
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 08:36:19 +1100 (EST)
Date: Thu, 11 Jan 2007 22:36:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/7] Powerpc MSI implementation
Message-ID: <20070111213603.GB23237@lst.de>
References: <1168514716.63474.857278133999.qpush@cradle>
	<20070111112503.0CC1BDDF13@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070111112503.0CC1BDDF13@ozlabs.org>
Cc: Olof Johannsson <olof@lixom.net>, Greg Kroah-Hartman <greg@kroah.com>,
	linux-pci@atrey.karlin.mff.cuni.cz,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 11, 2007 at 10:25:19PM +1100, Michael Ellerman wrote:
> Powerpc MSI implementation, based on a collection of "ops" callbacks.
> We have to take the ops approach to accomodate RTAS, where firmware
> handles almost all details of MSI setup/teardown. Bare-metal MSI
> can be accomodated also.
> 
> See the comments in include/asm-powerpc/msi.h for more info.

Most of this shouldn't live in arch/powerpc as it's generic code except
for tiny little bits.

> +static struct ppc_msi_ops *get_msi_ops(struct pci_dev *pdev)
> +{
> +	if (ppc_md.get_msi_ops)
> +		return ppc_md.get_msi_ops(pdev);
> +
> +	return NULL;
> +}

struct ppc_msi_ops should become msi_ops, and this function should
be an arch hook in asm/msi.h

> +static struct msi_info *get_msi_info(struct pci_dev *pdev)
> +{
> +	return pdev->msi_info;
> +}

This wrapper looks rather useless :)

> +#if defined(CONFIG_PCI_MSI) && defined(CONFIG_PPC_MERGE)
> +struct msi_info;
> +#endif

Unconditional, please.

>  /*
>   * The pci_dev structure is used to describe PCI devices.
>   */
> @@ -174,6 +178,9 @@ struct pci_dev {
>  	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
>  	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
>  	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
> +#if defined(CONFIG_PCI_MSI) && defined(CONFIG_PPC_MERGE)
> +	struct	msi_info *msi_info;
> +#endif

and only #ifdef CONFIG_PCI_MSI here please.
