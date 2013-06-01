Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9A7DD2C02AB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jun 2013 14:24:37 +1000 (EST)
Message-ID: <1370060670.3766.8.camel@pasglop>
Subject: Re: [PATCH 16/23] powerpc/eeh: I/O chip PE reset
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Sat, 01 Jun 2013 14:24:30 +1000
In-Reply-To: <1369902245-5886-17-git-send-email-shangw@linux.vnet.ibm.com>
References: <1369902245-5886-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1369902245-5886-17-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-05-30 at 16:23 +0800, Gavin Shan wrote:
> The patch adds the I/O chip backend to do PE reset. For now, we
> focus on PCI bus dependent PE. If PHB PE has been put into error
> state, the PHB will take complete reset. Besides, the root bridge
> will take fundamental or hot reset accordingly if the indicated
> PE locates at the toppest of PCI hierarchy tree. Otherwise, the
> upstream p2p bridge will take hot reset.
> 
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>

 .../...

> +static s64 ioda_eeh_phb_poll(struct pnv_phb *phb)
> +{
> +	s64 rc = OPAL_HARDWARE;
> +
> +	while (1) {
> +		rc = opal_pci_poll(phb->opal_id);
> +		if (rc <= 0)
> +			break;
> +	}
> +
> +	return rc;
> +}

This is rude. It should at the very least cond_resched, but better,
isn't the firmware supposed to return a positive value to indicate
how long to wait for before calling again ? In that case it should
msleep() ...

> +static int ioda_eeh_phb_reset(struct pci_controller *hose, int option)
> +{
> +	struct pnv_phb *phb = hose->private_data;
> +	s64 rc = OPAL_HARDWARE;
> +
> +	pr_debug("%s: Reset PHB#%x, option=%d\n",
> +		__func__, hose->global_number, option);
> +
> +	/* Issue PHB complete reset request */
> +	if (option == EEH_RESET_FUNDAMENTAL ||
> +	    option == EEH_RESET_HOT)
> +		rc = opal_pci_reset(phb->opal_id,
> +				OPAL_PHB_COMPLETE,
> +				OPAL_ASSERT_RESET);
> +	else if (option == EEH_RESET_DEACTIVATE)
> +		rc = opal_pci_reset(phb->opal_id,
> +				OPAL_PHB_COMPLETE,
> +				OPAL_DEASSERT_RESET);
> +	if (rc < 0)
> +		goto out;
> +
> +	/*
> +	 * Poll state of the PHB until the request is done
> +	 * successfully.
> +	 */
> +	rc = ioda_eeh_phb_poll(phb);
> +out:
> +	if (rc != OPAL_SUCCESS)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int ioda_eeh_root_reset(struct pci_controller *hose, int option)
> +{
> +	struct pnv_phb *phb = hose->private_data;
> +	s64 rc = OPAL_SUCCESS;
> +
> +	pr_debug("%s: Reset PHB#%x, option=%d\n",
> +		__func__, hose->global_number, option);
> +
> +	/*
> +	 * During the reset deassert time, we needn't care
> +	 * the reset scope because the firmware does nothing
> +	 * for fundamental or hot reset during deassert phase.
> +	 */
> +	if (option == EEH_RESET_FUNDAMENTAL)
> +		rc = opal_pci_reset(phb->opal_id,
> +				OPAL_PCI_FUNDAMENTAL_RESET,
> +				OPAL_ASSERT_RESET);
> +	else if (option == EEH_RESET_HOT)
> +		rc = opal_pci_reset(phb->opal_id,
> +				OPAL_PCI_HOT_RESET,
> +				OPAL_ASSERT_RESET);
> +	else if (option == EEH_RESET_DEACTIVATE)
> +		rc = opal_pci_reset(phb->opal_id,
> +				OPAL_PCI_HOT_RESET,
> +				OPAL_DEASSERT_RESET);
> +	if (rc < 0)
> +		goto out;
> +
> +	/* Poll state of the PHB until the request is done */
> +	rc = ioda_eeh_phb_poll(phb);
> +out:
> +	if (rc != OPAL_SUCCESS)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int ioda_eeh_bridge_reset(struct pci_controller *hose,
> +		struct pci_dev *dev, int option)
> +{
> +	u16 ctrl;
> +
> +	pr_debug("%s: Reset device %04x:%02x:%02x.%01x with option %d\n",
> +		__func__, hose->global_number, dev->bus->number,
> +		PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn), option);
> +
> +	switch (option) {
> +	case EEH_RESET_FUNDAMENTAL:
> +	case EEH_RESET_HOT:
> +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &ctrl);
> +		ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
> +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
> +		break;
> +	case EEH_RESET_DEACTIVATE:
> +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &ctrl);
> +		ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
> +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
> +		break;
> +	}
> +
> +	return 0;
> +}

Is there any minimum delay by spec here ? And is there a delay to
respect after the rest or is that handled at the upper level ?

Also, it looks like nothing here checks if the link is coming back
up below the bridge, at what speed etc... this might be something
to add in the future.

> +/**
> + * ioda_eeh_reset - Reset the indicated PE
> + * @pe: EEH PE
> + * @option: reset option
> + *
> + * Do reset on the indicated PE. For PCI bus sensitive PE,
> + * we need to reset the parent p2p bridge. The PHB has to
> + * be reinitialized if the p2p bridge is root bridge. For
> + * PCI device sensitive PE, we will try to reset the device
> + * through FLR. For now, we don't have OPAL APIs to do HARD
> + * reset yet, so all reset would be SOFT (HOT) reset.
> + */
> +static int ioda_eeh_reset(struct eeh_pe *pe, int option)
> +{
> +	struct pci_controller *hose = pe->phb;
> +	struct eeh_dev *edev;
> +	struct pci_dev *dev;
> +	int ret;
> +
> +	/*
> +	 * Anyway, we have to clear the problematic state for the
> +	 * corresponding PE. However, we needn't do it if the PE
> +	 * is PHB associated. That means the PHB is having fatal
> +	 * errors and it needs reset. Further more, the AIB interface
> +	 * isn't reliable any more.
> +	 */
> +	if (!(pe->type & EEH_PE_PHB) &&
> +	    (option == EEH_RESET_HOT ||
> +	    option == EEH_RESET_FUNDAMENTAL)) {
> +		ret = ioda_eeh_pe_clear(pe);
> +		if (ret)
> +			return -EIO;
> +	}
> +
> +	/*
> +	 * The rules applied to reset, either fundamental or hot reset:
> +	 *
> +	 * We always reset the direct upstream bridge of the PE. If the
> +	 * direct upstream bridge isn't root bridge, we always take hot
> +	 * reset no matter what option (fundamental or hot) is. Otherwise,
> +	 * we should do the reset according to the required option.
> +	 */
> +	if (pe->type & EEH_PE_PHB) {
> +		ret = ioda_eeh_phb_reset(hose, option);
> +	} else {
> +		if (pe->type & EEH_PE_DEVICE) {
> +			/*
> +			 * If it's device PE, we didn't refer to the parent
> +			 * PCI bus yet. So we have to figure it out indirectly.
> +			 */
> +			edev = list_first_entry(&pe->edevs,
> +					struct eeh_dev, list);
> +			dev = eeh_dev_to_pci_dev(edev);
> +			dev = dev->bus->self;
> +		} else {
> +			/*
> +			 * If it's bus PE, the parent PCI bus is already there
> +			 * and just pick it up.
> +			 */
> +			dev = pe->bus->self;
> +		}
> +
> +		/*
> +		 * Do reset based on the fact that the direct upstream bridge
> +		 * is root bridge (port) or not.
> +		 */
> +		if (dev->bus->number == 0)
> +			ret = ioda_eeh_root_reset(hose, option);
> +		else
> +			ret = ioda_eeh_bridge_reset(hose, dev, option);
> +	}
> +
> +	return ret;
> +}
> +
>  struct pnv_eeh_ops ioda_eeh_ops = {
>  	.post_init		= ioda_eeh_post_init,
>  	.set_option		= ioda_eeh_set_option,
>  	.get_state		= ioda_eeh_get_state,
> -	.reset			= NULL,
> +	.reset			= ioda_eeh_reset,
>  	.get_log		= NULL,
>  	.configure_bridge	= NULL
>  };

Cheers,
Ben.
