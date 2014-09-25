Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 61A081A06F9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 14:09:58 +1000 (EST)
In-Reply-To: <1408244549-10221-3-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [2/5] powerpc/eeh: Add eeh_pe_state sysfs entry
Message-Id: <20140925040958.4D2C414016A@ozlabs.org>
Date: Thu, 25 Sep 2014 14:09:58 +1000 (EST)
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2014-17-08 at 03:02:26 UTC, Gavin Shan wrote:
> The patch adds sysfs entry "eeh_pe_state". Reading on it returns
> the PE's state while writing to it clears the frozen state. It's
> used to check or clear the PE frozen state from userland for
> debugging purpose.
> 
> diff --git a/arch/powerpc/kernel/eeh_sysfs.c b/arch/powerpc/kernel/eeh_sysfs.c
> index e2595ba..e69bcbb 100644
> --- a/arch/powerpc/kernel/eeh_sysfs.c
> +++ b/arch/powerpc/kernel/eeh_sysfs.c
> @@ -54,6 +54,63 @@ EEH_SHOW_ATTR(eeh_mode,            mode,            "0x%x");
>  EEH_SHOW_ATTR(eeh_config_addr,     config_addr,     "0x%x");
>  EEH_SHOW_ATTR(eeh_pe_config_addr,  pe_config_addr,  "0x%x");
>  
> +static ssize_t eeh_pe_state_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
> +	int state;
> +
> +	if (!edev || !edev->pe)
> +		return 0;
> +
> +	state = eeh_ops->get_state(edev->pe, NULL);
> +	return sprintf(buf, "PHB#%d-PE#%d: 0x%08x 0x%08x\n",
> +		       edev->pe->phb->global_number,
> +		       edev->pe->addr, state, edev->pe->state);

Shouldn't this only display the state, ie not the number and addr etc.

And why are there two states, state and edev->pe->state ?

> +static ssize_t eeh_pe_state_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
> +	int ret;
> +
> +	if (!edev || !edev->pe)
> +		return 0;

Shouldn't that be an error?

> +	/* Nothing to do if it's not frozen */
> +	if (!(edev->pe->state & EEH_PE_ISOLATED))
> +		return 0;
> +
> +	/* Enable MMIO */
> +	ret = eeh_pci_enable(edev->pe, EEH_OPT_THAW_MMIO);
> +	if (ret) {
> +		pr_warn("%s: Failure %d enabling MMIO for PHB#%d-PE#%d\n",
> +			__func__, ret, edev->pe->phb->global_number,
> +			edev->pe->addr);
> +		return 0;

Error ?

> +	}
> +
> +	/* Enable DMA */
> +	ret = eeh_pci_enable(edev->pe, EEH_OPT_THAW_DMA);
> +	if (ret) {
> +		pr_warn("%s: Failure %d enabling DMA for PHB#%d-PE#%d\n",
> +			__func__, ret, edev->pe->phb->global_number,
> +			edev->pe->addr);
> +		return 0;

Error?

And should it roll back, ie. unthaw MMIO?


cheers
