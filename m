Return-Path: <sam.bobroff@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhJRH02SdzDqR9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 16:20:42 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7T6JQnT069995
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 02:20:40 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cmvjf6kbg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 02:20:40 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Tue, 29 Aug 2017 16:20:37 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7T6KYgU39321722
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 16:20:34 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7T6KY79010944
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 16:20:34 +1000
Date: Tue, 29 Aug 2017 16:20:31 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 "Bryant G. Ly" <bgly@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 martin.petersen@oracle.com
Subject: Re: [PATCH] powerpc/kernel: Change retrieval of pci_dn
References: <1503936303-18274-1-git-send-email-bryantly@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503936303-18274-1-git-send-email-bryantly@linux.vnet.ibm.com>
Message-Id: <20170829062031.hb3pwrnt5pohpr7l@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 28, 2017 at 11:05:03AM -0500, Bryant G. Ly wrote:
> For a PCI device it's pci_dn can be retrieved from
> pdev->dev.archdata.firmware_data, PCI_DN(devnode), or parent's list.
> Thus, we should just use the generic function pci_get_pdn_by_devfn
> to get the pci_dn.
> 
> Signed-off-by: Bryant G. Ly <bgly@us.ibm.com>
Reviewed-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

I don't know this area but I tested it using a patched kernel with the
old and new code together. My test kernel booted fine (in QEMU+KVM) and
I saw 26 reads and 4 writes, all of which got the same value with either
code block.

I also checked that the error result in the "not found" case is the same
as well, which it is, because rtas_{read,write}_config() will return
PCIBIOS_DEVICE_NOT_FOUND if given a NULL pdn.

So, looks good to me.

Cheers,
Sam.

> ---
>  arch/powerpc/kernel/rtas_pci.c | 30 ++----------------------------
>  1 file changed, 2 insertions(+), 28 deletions(-)
> 
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
>  
>  	ret = rtas_read_config(pdn, where, size, val);
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
