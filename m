Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXwjF6VKVzDqJp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 11:06:41 +1100 (AEDT)
Message-ID: <1488326797.15238.6.camel@russell.cc>
Subject: Re: [RFC 3/3] cxl: Reset freeze counters before adapter PERST for
 flashing new image
From: Russell Currey <ruscur@russell.cc>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,  frederic.barrat@fr.ibm.com
Cc: Andrew Donnellan <andonnel@au1.ibm.com>, Ian Munsie
 <ianmunsi@au1.ibm.com>,  Christophe Lombard
 <christophe_lombard@fr.ibm.com>, Philippe Bergheaud
 <philippe.bergheaud@fr.ibm.com>, Gregory Kurz <KURZGREG@fr.ibm.com>, Gavin
 Shan <gwshan@linux.vnet.ibm.com>
Date: Wed, 01 Mar 2017 11:06:37 +1100
In-Reply-To: <20170228072219.24868-1-vaibhav@linux.vnet.ibm.com>
References: <20170228070222.21126-1-vaibhav@linux.vnet.ibm.com>
 <20170228072219.24868-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[resending this since it didn't get delivered to the list]

On Tue, 2017-02-28 at 12:52 +0530, Vaibhav Jain wrote:
> The patch resets the freeze counter on eeh_pe struct for PHB
> associated with the cxl pci adapter. This would enable re-flashing of
> the cxl-adapter beyond the default limit of 5.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
>  drivers/misc/cxl/pci.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 679afc9..3b14688 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -22,6 +22,7 @@
>  #include <asm/pnv-pci.h>
>  #include <asm/io.h>
>  #include <asm/reg.h>
> +#include <asm/eeh.h>
>  
>  #include "cxl.h"
>  #include <misc/cxl.h>
> @@ -1229,6 +1230,8 @@ static void cxl_pci_remove_afu(struct cxl_afu *afu)
>  int cxl_pci_reset(struct cxl *adapter)
>  {
>  	struct pci_dev *dev = to_pci_dev(adapter->dev.parent);
> +	struct eeh_dev *eehdev = pci_dev_to_eeh_dev(dev);
> +	struct eeh_pe *devpe = eeh_dev_to_pe(eehdev);

EEH code typically uses "edev" and "pe" for these variable names

>  	int rc;
>  
>  	if (adapter->perst_same_image) {
> @@ -1242,6 +1245,18 @@ int cxl_pci_reset(struct cxl *adapter)
>  	/* the adapter is about to be reset, so ignore errors */
>  	cxl_data_cache_flush(adapter);
>  
> +	/* If loading a new image, reset freeze counters for the PHB
> +	 * associated with the adapter.
> +	 */
> +	if (devpe && adapter->perst_loads_image) {
> +		/* Find the pe associated with the device PHB */
> +		while (devpe->parent != NULL && (devpe->type & EEH_PE_PHB) ==
> 0)
> +			devpe = devpe->parent;
> +
> +		dev_info(&dev->dev, "Resetting freeze counters for the
> PHB\n");

Would be good to mention "EEH" here to help with grepping, alternatively a
similar message could be printed in eeh_pe_reset_freeze_counter() displaying the
PHB information.

> +		eeh_pe_reset_freeze_counter(devpe);
> +	}
> +
>  	/* pcie_warm_reset requests a fundamental pci reset which includes a
>  	 * PERST assert/deassert.  PERST triggers a loading of the image
>  	 * if "user" or "factory" is selected in sysfs */
