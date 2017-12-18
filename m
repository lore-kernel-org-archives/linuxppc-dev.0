Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0SqW1rgSzDrW0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 15:34:31 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id u19so9195926pfa.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Dec 2017 20:34:31 -0800 (PST)
Subject: Re: [PATCH v1 3/7] platforms/pseries: Set eeh_pe of EEH_PE_VF type
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, helgaas@kernel.org, ruscur@russell.cc,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bodong@mellanox.com, eli@mellanox.com, saeedm@mellanox.com
References: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
 <20171213153242.98015-4-bryantly@linux.vnet.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5a9a3c99-ae38-ac52-415c-fe3c2042acb2@ozlabs.ru>
Date: Mon, 18 Dec 2017 15:34:21 +1100
MIME-Version: 1.0
In-Reply-To: <20171213153242.98015-4-bryantly@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14/12/17 02:32, Bryant G. Ly wrote:
> To correctly use EEH code one has to make
> sure that the EEH_PE_VF is set for dynamic created
> VFs. Therefore this patch allocates an eeh_pe of
> eeh type EEH_PE_VF and associates PE with parent.
> 
> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/pci-bridge.h        | 5 ++++-
>  arch/powerpc/platforms/pseries/eeh_pseries.c | 9 ++++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index 9f66ddebb799..c30c7cba4c30 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -211,7 +211,10 @@ struct pci_dn {
>  	unsigned int *pe_num_map;	/* PE# for the first VF PE or array */
>  	bool    m64_single_mode;	/* Use M64 BAR in Single Mode */
>  #define IODA_INVALID_M64        (-1)
> -	int     (*m64_map)[PCI_SRIOV_NUM_BARS];
> +	union {
> +		int     (*m64_map)[PCI_SRIOV_NUM_BARS];
> +		int     last_allow_rc;

I'd suggest defining it where is used, easier to follow what this actually
does.


> +	};
>  #endif /* CONFIG_PCI_IOV */
>  	int	mps;			/* Maximum Payload Size */
>  	struct list_head child_list;
> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
> index 1a9a6fa91151..5bdd1678a9ff 100644
> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
> @@ -58,6 +58,8 @@ static int ibm_configure_pe;
>  void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
>  {
>  	struct pci_dn *pdn = pci_get_pdn(pdev);
> +	struct pci_dn *physfn_pdn;
> +	struct eeh_dev *edev;
>  
>  	if (!pdev->is_virtfn)
>  		return;
> @@ -65,6 +67,10 @@ void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
>  	pdn->device_id  =  pdev->device;
>  	pdn->vendor_id  =  pdev->vendor;
>  	pdn->class_code =  pdev->class;
> +	pdn->last_allow_rc =  0;
> +	physfn_pdn      =  pci_get_pdn(pdev->physfn);
> +	pdn->pe_number  =  physfn_pdn->pe_num_map[pdn->vf_index];
> +	edev = pdn_to_eeh_dev(pdn);
>  
>  	/*
>  	 * The following operations will fail if VF's sysfs files
> @@ -72,8 +78,9 @@ void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
>  	 */
>  	eeh_add_device_early(pdn);
>  	eeh_add_device_late(pdev);
> +	edev->pe_config_addr =  (pdn->busno << 16) | (pdn->devfn << 8);
> +	eeh_add_to_parent_pe(edev);


powernv does this from eeh_ops::probe, and so does pseries_eeh_probe(), do
you still need this here?

>  	eeh_sysfs_add_device(pdev);
> -

Unnecessary change.

>  }
>  
>  /*
> 


-- 
Alexey
