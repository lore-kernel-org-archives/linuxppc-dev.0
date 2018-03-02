Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zsrBZ3zkMzF1KZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2018 11:43:18 +1100 (AEDT)
Date: Thu, 1 Mar 2018 18:43:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 mpe@ellerman.id.au, bhelgaas@google.com, bryantly@linux.vnet.ibm.com
Subject: Re: [PATCH RFC 1/1] powerpc/pseries: fix EEH recovery of IOV devices
Message-ID: <20180302004313.GE74737@bhelgaas-glaptop.roam.corp.google.com>
References: <4bd50291799b920b42f8a12f5635c40ccae1302e.1519258921.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4bd50291799b920b42f8a12f5635c40ccae1302e.1519258921.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 22, 2018 at 11:23:35AM +1100, Sam Bobroff wrote:
> Currently EEH recovery will fail on pSeries platforms for
> passed-through physical devices that support IOV, when CONFIG_PCI_IOV
> is set and the hypervisor doesn't provide a device tree node
> "ibm,open-sriov-vf-bar-info" for the device. (Found on an IOV capable
> device using the ipr driver.)
> 
> EEH recovery fails in pci_enable_resources() at the check on
> r->parent, because r->flags is set and r->parent is not.  This state
> is due to sriov_init() setting the start, end and flags members of the
> IOV BARs but the parent not being set later in
> pseries_pci_fixup_iov_resources(), because the
> "ibm,open-sriov-vf-bar-info" property is missing, causing it to bail
> out early.
> 
> Correct this by zeroing the IOV resources in the bailout path, so that
> they are not seen by pci_enable_resources().
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---
> Hi,
> 
> This is a fix to allow EEH recovery to succeed in a specific
> situation, which I've tried to explain in the commit message. But
> while I'm fairly sure of the situation leading up to the problem,
> I'm not sure how it should be fixed, which is why I've posted this
> as an RFC.
> 
> Just zeroing out the flags is sufficient in my tests but it seemed
> cleaner to also clear start and end, but other changes would work as
> well: just clearing the flags, or just removing IORESOURCE_IO and
> IORESOURCE_MEM or even adding some new flag and also adjusting the
> test. Perhaps there's something else.  I'm not sure what
> implications these choices have for the generic PCI code so I would
> appreciate feedback on it.
>
> Note that this problem doesn't seem to have been introduced by
> pseries_pci_fixup_iov_resources() (which was added recently): recovery
> already failed (in this way) before it's introduction.
> 
>  arch/powerpc/platforms/pseries/setup.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index 372d7ada1a0c..019836ffe53d 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -618,13 +618,24 @@ static void pseries_pci_fixup_iov_resources(struct pci_dev *pdev)
>  {
>  	const int *indexes;
>  	struct device_node *dn = pci_device_to_OF_node(pdev);
> +	int i;
> +	struct resource *r;
>  
>  	if (!pdev->is_physfn || pdev->is_added)
>  		return;
>  	/*Firmware must support open sriov otherwise dont configure*/
>  	indexes = of_get_property(dn, "ibm,open-sriov-vf-bar-info", NULL);
> -	if (!indexes)
> +	if (!indexes) {
> +		/* Hide the BARs we can't configure, otherwise other
> +		 * code may see r->flags != 0 and r->parent == 0
> +		 * and raise an error. */
> +		pci_warn(pdev, "No hypervisor support for SRIOV on this device, IOV BARs disabled.\n");
> +		for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> +			r = &pdev->resource[PCI_IOV_RESOURCES + i];
> +			r->start = r->end = r->flags = 0;
> +		}
>  		return;

Just to make sure I'm understanding the situation, "pdev" here is a PF
(not a VF), right?  And if "ibm,open-sriov-vf-bar-info" existed,
of_pci_parse_iov_addrs() would fill in the pdev resources
corresponding to VF BAR0, VF BAR1, etc, in the PF's SR-IOV Capability?

The VF BARs are only used by the VFs, so I guess it should be safe to
enable the PF even if the VF BARs are not assigned, so I think this
patch is OK as far as it goes.

But I think you would also want to do something to prevent the VFs
from being enabled, i.e., we never want to set PCI_SRIOV_CTRL_VFE and
PCI_SRIOV_CTRL_MSE on this PF.  That would cause VFs to decode memory
space that we have not configured and don't know about.  I don't know
off the top of my head what the mechanism for that would be or if we
even have one.

> +	}
>  	/* Assign the addresses from device tree*/
>  	of_pci_parse_iov_addrs(pdev, indexes);
>  }
> -- 
> 2.16.1.74.g9b0b1f47b
> 
