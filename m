Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6172E1A0606
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 22:46:39 +1100 (AEDT)
In-Reply-To: <1446939035-2617-10-git-send-email-weiyang@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 bhelgaas@google.com, aik@ozlabs.ru
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [V13,9/9] powerpc/eeh: Support error recovery for VF PE
Message-Id: <20151119114639.40721141498@ozlabs.org>
Date: Thu, 19 Nov 2015 22:46:39 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-07-11 at 23:30:35 UTC, Wei Yang wrote:
> PFs are enumerated on PCI bus, while VFs are created by PF's driver.
> 
> In EEH recovery, it has two cases:
> 1. Device and driver is EEH aware, error handlers are called.
> 2. Device and driver is not EEH aware, un-plug the device and plug it again
> by enumerating it.
> 
> The special thing happens on the second case. For a PF, we could use the
> original pci core to enumerate the bus, while for VF we need to record the
> VFs which aer un-plugged then plug it again.
> 
> Also The patch caches the VF index in pci_dn, which can be used to
> calculate VF's bus, device and function number. Those information helps to
> locate the VF's PCI device instance when doing hotplug during EEH recovery
> if necessary.

> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index 9b365d6..533e6e9 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -211,6 +211,7 @@ struct pci_dn {
>  #define IODA_INVALID_PE		(-1)
>  #ifdef CONFIG_PPC_POWERNV
>  	int	pe_number;
> +	int     vf_index;		/* VF index in the PF */


> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index 89eb4bc..f25428a 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -386,12 +396,39 @@ static void *eeh_report_failure(void *data, void *userdata)
>  	return NULL;
>  }
>  
> +static void *eeh_add_virt_device(void *data, void *userdata)
> +{
> +	struct pci_driver *driver;
> +	struct eeh_dev *edev = (struct eeh_dev *)data;
> +	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
> +	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
> +
> +	if (!(edev->physfn)) {
> +		pr_warn("%s: EEH dev %04x:%02x:%02x.%01x not for VF\n",
> +			__func__, edev->phb->global_number, pdn->busno,
> +			PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
> +		return NULL;
> +	}
> +
> +	driver = eeh_pcid_get(dev);
> +	if (driver) {
> +		eeh_pcid_put(dev);
> +		if (driver->err_handler)
> +			return NULL;
> +	}
> +
> +	pci_iov_virtfn_add(edev->physfn, pdn->vf_index, 0);
                                              ^

This is giving me:

  arch/powerpc/kernel/eeh_driver.c:420:38: error: 'struct pci_dn' has no member named 'vf_index'

And similarly:

  arch/powerpc/kernel/eeh_driver.c:472:42: error: 'struct pci_dn' has no member named 'vf_index'
  arch/powerpc/kernel/eeh_driver.c:479:6: error: 'struct pci_dn' has no member named 'pe_number'


For pseries_defconfig with POWERNV=n.

The reason is that those fields are #ifdef POWERNV, but eeh_driver.c is still
built for PSERIES.

More here:

  http://kisskb.ellerman.id.au/kisskb/buildresult/12550871/


cheers
