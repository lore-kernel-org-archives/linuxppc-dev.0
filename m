Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhJhC1nt2zDqkh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 16:31:55 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: martin.petersen@oracle.com, linuxppc-dev@lists.ozlabs.org,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, "Bryant G. Ly" <bgly@us.ibm.com>
Subject: Re: [PATCH] powerpc/kernel: Change retrieval of pci_dn
In-Reply-To: <1503936303-18274-1-git-send-email-bryantly@linux.vnet.ibm.com>
References: <1503936303-18274-1-git-send-email-bryantly@linux.vnet.ibm.com>
Date: Tue, 29 Aug 2017 16:31:52 +1000
Message-ID: <87wp5m28br.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Bryant,

Thanks for the patch, a few comments/questions.

How have you tested this?

"Bryant G. Ly" <bryantly@linux.vnet.ibm.com> writes:
> For a PCI device it's pci_dn can be retrieved from
> pdev->dev.archdata.firmware_data, PCI_DN(devnode), or parent's list.
> Thus, we should just use the generic function pci_get_pdn_by_devfn
> to get the pci_dn.

"generic" means shared between architectures, which is not true for
pci_get_pdn_by_devfn(). "existing" would be more appropriate.

> diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
> index 73f1934..c21e6c5 100644
> --- a/arch/powerpc/kernel/rtas_pci.c
> +++ b/arch/powerpc/kernel/rtas_pci.c
> @@ -91,25 +91,13 @@ static int rtas_pci_read_config(struct pci_bus *bus,
>  				unsigned int devfn,
>  				int where, int size, u32 *val)
>  {
> -	struct device_node *busdn, *dn;
>  	struct pci_dn *pdn;
> -	bool found = false;
>  	int ret;
>  
>  	/* Search only direct children of the bus */

You kept the comment, but is it still true, and what does it apply to
now?

Also you removed the comment below in write, I'd expect it to either
stay in both or be removed in both?

>  	*val = 0xFFFFFFFF;
> -	busdn = pci_bus_to_OF_node(bus);
> -	for (dn = busdn->child; dn; dn = dn->sibling) {
> -		pdn = PCI_DN(dn);
> -		if (pdn && pdn->devfn == devfn
> -		    && of_device_is_available(dn)) {
> -			found = true;
> -			break;
> -		}
> -	}
>  
> -	if (!found)
> -		return PCIBIOS_DEVICE_NOT_FOUND;
> +	pdn = pci_get_pdn_by_devfn(bus, devfn);

This appears to not handle the pdn == NULL case.

>  	ret = rtas_read_config(pdn, where, size, val);

But actually is handled in there ^
That would have been worth mentioning in the change log.

cheers

>  	if (*val == EEH_IO_ERROR_VALUE(size) &&
> @@ -153,23 +141,9 @@ static int rtas_pci_write_config(struct pci_bus *bus,
>  				 unsigned int devfn,
>  				 int where, int size, u32 val)
>  {
> -	struct device_node *busdn, *dn;
>  	struct pci_dn *pdn;
> -	bool found = false;
> -
> -	/* Search only direct children of the bus */
> -	busdn = pci_bus_to_OF_node(bus);
> -	for (dn = busdn->child; dn; dn = dn->sibling) {
> -		pdn = PCI_DN(dn);
> -		if (pdn && pdn->devfn == devfn
> -		    && of_device_is_available(dn)) {
> -			found = true;
> -			break;
> -		}
> -	}
>  
> -	if (!found)
> -		return PCIBIOS_DEVICE_NOT_FOUND;
> +	pdn = pci_get_pdn_by_devfn(bus, devfn);
>  
>  	return rtas_write_config(pdn, where, size, val);
>  }
> -- 
> 2.5.4 (Apple Git-61)
