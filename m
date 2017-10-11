Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yC4j50c6ZzDr5x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 07:05:29 +1100 (AEDT)
Date: Wed, 11 Oct 2017 15:05:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, seroyer@linux.vnet.ibm.com,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "Juan J . Alvarez" <jjalvare@us.ibm.com>
Subject: Re: [PATCH v3 2/2] pseries/eeh: Add Pseries pcibios_bus_add_device
Message-ID: <20171011200524.GR25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170922141928.49141-1-bryantly@linux.vnet.ibm.com>
 <20170922141928.49141-3-bryantly@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170922141928.49141-3-bryantly@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 22, 2017 at 09:19:28AM -0500, Bryant G. Ly wrote:
> This patch adds the machine dependent call for
> pcibios_bus_add_device, since the previous patch
> separated the calls out between the PowerNV and PowerVM.
> 
> The difference here is that for the PowerVM environment
> we do not want match_driver set because in this environment
> we do not want the VF device drivers to load immediately, due to
> firmware loading the device node when VF device is assigned to the
> logical partition.
> 
> This patch will depend on the patch linked below, which is under
> review.
> 
> https://patchwork.kernel.org/patch/9882915/
> 
> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Signed-off-by: Juan J. Alvarez <jjalvare@us.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/eeh_pseries.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
> index 6b812ad990e4..45946ee90985 100644
> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
> @@ -64,6 +64,27 @@ static unsigned char slot_errbuf[RTAS_ERROR_LOG_MAX];
>  static DEFINE_SPINLOCK(slot_errbuf_lock);
>  static int eeh_error_buf_size;
>  
> +void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
> +{
> +	struct pci_dn *pdn = pci_get_pdn(pdev);
> +
> +	if (!pdev->is_virtfn)
> +		return;
> +
> +	pdn->device_id  =  pdev->device;
> +	pdn->vendor_id  =  pdev->vendor;
> +	pdn->class_code =  pdev->class;
> +
> +	/*
> +	 * The following operations will fail if VF's sysfs files
> +	 * aren't created or its resources aren't finalized.
> +	 */
> +	eeh_add_device_early(pdn);
> +	eeh_add_device_late(pdev);
> +	eeh_sysfs_add_device(pdev);
> +	pdev->match_driver = -1;

match_driver is a bool, which should be assigned "true" or "false".

> +}
> +
>  /**
>   * pseries_eeh_init - EEH platform dependent initialization
>   *
> @@ -120,6 +141,9 @@ static int pseries_eeh_init(void)
>  	/* Set EEH probe mode */
>  	eeh_add_flag(EEH_PROBE_MODE_DEVTREE | EEH_ENABLE_IO_FOR_LOG);
>  
> +	/* Set EEH machine dependent code */
> +	ppc_md.pcibios_bus_add_device = pseries_pcibios_bus_add_device;
> +
>  	return 0;
>  }
>  
> -- 
> 2.11.0 (Apple Git-81)
> 
