Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fXZb1MyWzF14h
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 07:21:59 +1000 (AEST)
Date: Mon, 30 Jul 2018 16:21:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sam Bobroff <sbobroff@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 mpe@ellerman.id.au, bhelgaas@google.com, bryantly@linux.vnet.ibm.com
Subject: Re: [PATCH v3 1/1] powerpc/pseries: fix EEH recovery of some IOV
 devices
Message-ID: <20180730212155.GB45322@bhelgaas-glaptop.roam.corp.google.com>
References: <e63eb03c87a1a54257aa2bcc384cf07761824a7e.1532915951.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e63eb03c87a1a54257aa2bcc384cf07761824a7e.1532915951.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 30, 2018 at 11:59:14AM +1000, Sam Bobroff wrote:
> EEH recovery currently fails on pSeries for some IOV capable PCI
> devices, if CONFIG_PCI_IOV is on and the hypervisor doesn't provide
> certain device tree properties for the device. (Found on an IOV
> capable device using the ipr driver.)
> 
> Recovery fails in pci_enable_resources() at the check on r->parent,
> because r->flags is set and r->parent is not.  This state is due to
> sriov_init() setting the start, end and flags members of the IOV BARs
> but the parent not being set later in
> pseries_pci_fixup_iov_resources(), because the
> "ibm,open-sriov-vf-bar-info" property is missing.
> 
> Correct this by zeroing the resource flags for IOV BARs when they
> can't be configured (this is the same method used by sriov_init() and
> __pci_read_base()).
> 
> VFs cleared this way can't be enabled later, because that requires
> another device tree property, "ibm,number-of-configurable-vfs" as well
> as support for the RTAS function "ibm_map_pes". These are all part of
> hypervisor support for IOV and it seems unlikely that a hypervisor
> would ever partially, but not fully, support it. (None are currently
> provided by QEMU/KVM.)
> 
> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>

Michael, I assume you'll take this, since it only touches powerpc.
Let me know if you need anything from me.

> ---
> Hi,
> 
> This is a fix to allow EEH recovery to succeed in a specific situation,
> which I've tried to explain in the commit message.
> 
> As with the RFC version, the IOV BARs are disabled by setting the resource
> flags to 0 but the other fields are now left as-is because that is what is done
> elsewhere (see sriov_init() and __pci_read_base()).
> 
> I've also examined the concern raised by Bjorn Helgaas, that VFs could be
> enabled later after the BARs are disabled, and it already seems safe: enabling
> VFs (on pseries) depends on another device tree property,
> "ibm,number-of-configurable-vfs" as well as support for the RTAS function
> "ibm_map_pes". Since these are all part of the hypervisor's support for IOV it
> seems unlikely that we would ever see some of them but not all. (None are
> currently provided by QEMU/KVM.) (Additionally, the ipr driver on which the EEH
> recovery failure was discovered doesn't even seem to have SR-IOV support so it
> certainly can't enable VFs.)
> 
> Cheers,
> Sam.
> 
> Patch set v3:
> Patch 1/1: powerpc/pseries: fix EEH recovery of some IOV devices
> * Moved some useful information from the cover letter to the commit log.
> 
> Patch set v2:
> Patch 1/1: powerpc/pseries: fix EEH recovery of some IOV devices
> * Moved the BAR disabling code to a function.
> * Also check in pseries_pci_fixup_resources().
> 
> Patch set v1:
> Patch 1/1: powerpc/pseries: fix EEH recovery of IOV devices
> 
>  arch/powerpc/platforms/pseries/setup.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index b55ad4286dc7..0a9e4243ae1d 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -645,6 +645,15 @@ void of_pci_parse_iov_addrs(struct pci_dev *dev, const int *indexes)
>  	}
>  }
>  
> +static void pseries_disable_sriov_resources(struct pci_dev *pdev)
> +{
> +	int i;
> +
> +	pci_warn(pdev, "No hypervisor support for SR-IOV on this device, IOV BARs disabled.\n");
> +	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
> +		pdev->resource[i + PCI_IOV_RESOURCES].flags = 0;
> +}
> +
>  static void pseries_pci_fixup_resources(struct pci_dev *pdev)
>  {
>  	const int *indexes;
> @@ -652,10 +661,10 @@ static void pseries_pci_fixup_resources(struct pci_dev *pdev)
>  
>  	/*Firmware must support open sriov otherwise dont configure*/
>  	indexes = of_get_property(dn, "ibm,open-sriov-vf-bar-info", NULL);
> -	if (!indexes)
> -		return;
> -	/* Assign the addresses from device tree*/
> -	of_pci_set_vf_bar_size(pdev, indexes);
> +	if (indexes)
> +		of_pci_set_vf_bar_size(pdev, indexes);
> +	else
> +		pseries_disable_sriov_resources(pdev);
>  }
>  
>  static void pseries_pci_fixup_iov_resources(struct pci_dev *pdev)
> @@ -667,10 +676,10 @@ static void pseries_pci_fixup_iov_resources(struct pci_dev *pdev)
>  		return;
>  	/*Firmware must support open sriov otherwise dont configure*/
>  	indexes = of_get_property(dn, "ibm,open-sriov-vf-bar-info", NULL);
> -	if (!indexes)
> -		return;
> -	/* Assign the addresses from device tree*/
> -	of_pci_parse_iov_addrs(pdev, indexes);
> +	if (indexes)
> +		of_pci_parse_iov_addrs(pdev, indexes);
> +	else
> +		pseries_disable_sriov_resources(pdev);
>  }
>  
>  static resource_size_t pseries_pci_iov_resource_alignment(struct pci_dev *pdev,
> -- 
> 2.16.1.74.g9b0b1f47b
> 
