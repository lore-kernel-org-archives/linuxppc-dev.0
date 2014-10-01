Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AFAAD1A03B4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 13:43:43 +1000 (EST)
In-Reply-To: <1412044750-24460-2-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [02/21] powerpc/eeh: Add eeh_pe_state sysfs entry
Message-Id: <20141001034343.9626514012C@ozlabs.org>
Date: Wed,  1 Oct 2014 13:43:43 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-30-09 at 02:38:51 UTC, Gavin Shan wrote:
> diff --git a/arch/powerpc/kernel/eeh_sysfs.c b/arch/powerpc/kernel/eeh_sysfs.c
> index e2595ba..eb15be4 100644
> --- a/arch/powerpc/kernel/eeh_sysfs.c
> +++ b/arch/powerpc/kernel/eeh_sysfs.c
> @@ -54,6 +54,62 @@ EEH_SHOW_ATTR(eeh_mode,            mode,            "0x%x");
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
> +		return -ENODEV;
> +
> +	state = eeh_ops->get_state(edev->pe, NULL);
> +	return sprintf(buf, "%08x %08x\n",
> +		       state, edev->pe->state);

Looking at all the other eeh sysfs files, they all use 0x%x. Which makes it
much clearer when you're looking at the file in userspace that the content is
hex.

Please send an incremental patch to change the format to 0x%08x, unless there's
a good reason not to.

cheers
