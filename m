Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 772AFDDE03
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 01:00:28 +1100 (EST)
Date: Thu, 24 Jan 2008 17:00:12 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: mpc8568e-mds: pci-e is broken
Message-ID: <20080124140012.GA19781@localhost.localdomain>
References: <20080123193712.GA12037@localhost.localdomain>
	<6785FDE5-FEBA-4FE2-A94C-85FCE299D1CC@kernel.crashing.org>
	<20080123195022.GA21157@localhost.localdomain>
	<B4582CB3-2065-40D5-9C16-B0EE1943D83A@kernel.crashing.org>
	<Pine.LNX.4.64.0801231701110.1762@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <Pine.LNX.4.64.0801231701110.1762@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 23, 2008 at 05:02:10PM -0600, Kumar Gala wrote:
> Anton,
> 
> Can you try this patch and see if it resolves the issue for you.. (You'll
> still get the Apple FW messages)

Yup, that patch fixes it.

Thanks,

> - k
> 
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index 4005739..bf13c21 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -133,22 +133,23 @@ void fsl_pcibios_fixup_bus(struct pci_bus *bus)
>  	struct pci_controller *hose = (struct pci_controller *) bus->sysdata;
>  	int i;
> 
> -	/* deal with bogus pci_bus when we don't have anything connected on PCIe */
> -	if (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK) {
> -		if (bus->parent) {
> -			for (i = 0; i < 4; ++i)
> -				bus->resource[i] = bus->parent->resource[i];
> -		}
> -	}
> -
> -	if (fsl_pcie_bus_fixup &&
> -	    (bus->parent == hose->bus) &&
> -	     early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
> +	if ((bus->parent == hose->bus) &&
> +	    ((fsl_pcie_bus_fixup &&
> +	      early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) ||
> +	     (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK)))
> +	{
>  		for (i = 0; i < 4; ++i) {
> -			if (bus->resource[i] && bus->parent->resource[i]) {
> -				bus->resource[i]->start = bus->parent->resource[i]->start;
> -				bus->resource[i]->end = bus->parent->resource[i]->end;
> -				bus->resource[i]->flags = bus->parent->resource[i]->flags;
> +			struct resource *res = bus->resource[i];
> +			struct resource *par = bus->parent->resource[i];
> +			if (res) {
> +				res->start = 0;
> +				res->end   = 0;
> +				res->flags = 0;
> +			}
> +			if (res && par) {
> +				res->start = par->start;
> +				res->end   = par->end;
> +				res->flags = par->flags;
>  			}
>  		}
>  	}
> 

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
