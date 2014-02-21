Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1B2602C00AA
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Feb 2014 06:56:57 +1100 (EST)
Message-ID: <1393012609.6771.90.camel@pasglop>
Subject: Re: [PATCH 3/5] powerpc/powernv: Cleanup on PNV_EEH_STATE_ENABLED
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Sat, 22 Feb 2014 06:56:49 +1100
In-Reply-To: <1392983613-10090-3-git-send-email-shangw@linux.vnet.ibm.com>
References: <1392983613-10090-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1392983613-10090-3-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-02-21 at 19:53 +0800, Gavin Shan wrote:
> The flag PNV_EEH_STATE_ENABLED is put into pnv_phb::eeh_state, which
> is protected by CONFIG_EEH. We needn't that. Instead, we can have
> pnv_phb::flags and maintain all flags there, which is the purpose
> of the patch.

Can you explain a bit more why we want to create a new flag set
that didn't exist before ? This adds confusion so we need a very
good reason... Do we need to know about the enable state of EEH
even when CNFIG_EEH is not set ?

Cheers,
Ben.

> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/eeh-ioda.c |    2 +-
>  arch/powerpc/platforms/powernv/pci.c      |    8 ++------
>  arch/powerpc/platforms/powernv/pci.h      |    7 +++----
>  3 files changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
> index 0d1d424..04b4710 100644
> --- a/arch/powerpc/platforms/powernv/eeh-ioda.c
> +++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
> @@ -153,7 +153,7 @@ static int ioda_eeh_post_init(struct pci_controller *hose)
>  	}
>  #endif
>  
> -	phb->eeh_state |= PNV_EEH_STATE_ENABLED;
> +	phb->flags |= PNV_PHB_FLAG_EEH;
>  
>  	return 0;
>  }
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index b555ebc..437c37d 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -396,7 +396,7 @@ int pnv_pci_cfg_read(struct device_node *dn,
>  	if (phb_pe && (phb_pe->state & EEH_PE_ISOLATED))
>  		return PCIBIOS_SUCCESSFUL;
>  
> -	if (phb->eeh_state & PNV_EEH_STATE_ENABLED) {
> +	if (phb->flags & PNV_PHB_FLAG_EEH) {
>  		if (*val == EEH_IO_ERROR_VALUE(size) &&
>  		    eeh_dev_check_failure(of_node_to_eeh_dev(dn)))
>  			return PCIBIOS_DEVICE_NOT_FOUND;
> @@ -434,12 +434,8 @@ int pnv_pci_cfg_write(struct device_node *dn,
>  	}
>  
>  	/* Check if the PHB got frozen due to an error (no response) */
> -#ifdef CONFIG_EEH
> -	if (!(phb->eeh_state & PNV_EEH_STATE_ENABLED))
> +	if (!(phb->flags & PNV_PHB_FLAG_EEH))
>  		pnv_pci_config_check_eeh(phb, dn);
> -#else
> -	pnv_pci_config_check_eeh(phb, dn);
> -#endif
>  
>  	return PCIBIOS_SUCCESSFUL;
>  }
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index dbeba3d..adeb3c4 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -79,24 +79,23 @@ struct pnv_eeh_ops {
>  	int (*configure_bridge)(struct eeh_pe *pe);
>  	int (*next_error)(struct eeh_pe **pe);
>  };
> -
> -#define PNV_EEH_STATE_ENABLED	(1 << 0)	/* EEH enabled	*/
> -
>  #endif /* CONFIG_EEH */
>  
> +#define PNV_PHB_FLAG_EEH	(1 << 0)
> +
>  struct pnv_phb {
>  	struct pci_controller	*hose;
>  	enum pnv_phb_type	type;
>  	enum pnv_phb_model	model;
>  	u64			hub_id;
>  	u64			opal_id;
> +	int			flags;
>  	void __iomem		*regs;
>  	int			initialized;
>  	spinlock_t		lock;
>  
>  #ifdef CONFIG_EEH
>  	struct pnv_eeh_ops	*eeh_ops;
> -	int			eeh_state;
>  #endif
>  
>  #ifdef CONFIG_DEBUG_FS
