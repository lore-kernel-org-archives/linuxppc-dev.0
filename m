Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406tyv3Kl2zF22c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 17:33:27 +1100 (AEDT)
Message-ID: <1521786791.16434.339.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/eeh: Fix race with driver un/bind
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, ruscur@russell.cc, sam.bobroff@au1.ibm.com
Date: Fri, 23 Mar 2018 17:33:11 +1100
In-Reply-To: <20180323054417.3268-1-mikey@neuling.org>
References: <20180323054417.3268-1-mikey@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-03-23 at 16:44 +1100, Michael Neuling wrote:

 .../...

> This fixes the problem in the same way the generic PCIe AER code (in
> drivers/pci/pcie/aer/aerdrv_core.c) does. It makes the EEH code hold
> the device_lock() before performing the driver EEH callbacks. This
> ensures either the callbacks are no longer register, or if they are
> registered the driver will not be removed from underneath us.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Generally ok, minor nits though and do we want a CC stable ?

> ---
>  arch/powerpc/kernel/eeh_driver.c | 67 ++++++++++++++++++++++++----------------
>  1 file changed, 41 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index 0c0b66fc5b..7cf946ae9a 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -207,18 +207,18 @@ static void *eeh_report_error(void *data, void *userdata)
>  
>  	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
>  		return NULL;
> +
> +	device_lock(&dev->dev);
>  	dev->error_state = pci_channel_io_frozen;
>  
>  	driver = eeh_pcid_get(dev);
> -	if (!driver) return NULL;
> +	if (!driver) goto out2;

I don't like out1/out2, why not call them out_nodev and out_no_handler
? (same comment for the other ones).
>  
>  	eeh_disable_irq(dev);
>  
>  	if (!driver->err_handler ||
> -	    !driver->err_handler->error_detected) {
> -		eeh_pcid_put(dev);
> -		return NULL;
> -	}
> +	    !driver->err_handler->error_detected)
> +		goto out1;
>  
>  	rc = driver->err_handler->error_detected(dev, pci_channel_io_frozen);
>  
> @@ -227,8 +227,11 @@ static void *eeh_report_error(void *data, void *userdata)
>  	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
>  
>  	edev->in_error = true;
> -	eeh_pcid_put(dev);
>  	pci_uevent_ers(dev, PCI_ERS_RESULT_NONE);
> +out1:
> +	eeh_pcid_put(dev);
> +out2:

This also changes doing the uevent while holding a reference and the
the device lock, is that ok ? (I guess a reference is a good thing, the
device lock, not sure... I hope so but you should at least document it
as a chance in the cset comment).

> +	device_unlock(&dev->dev);
>  	return NULL;
>  }
>  
> @@ -251,15 +254,14 @@ static void *eeh_report_mmio_enabled(void *data, void *userdata)
>  	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
>  		return NULL;
>  
> +	device_lock(&dev->dev);
>  	driver = eeh_pcid_get(dev);
> -	if (!driver) return NULL;
> +	if (!driver) goto out2;
>  
>  	if (!driver->err_handler ||
>  	    !driver->err_handler->mmio_enabled ||
> -	    (edev->mode & EEH_DEV_NO_HANDLER)) {
> -		eeh_pcid_put(dev);
> -		return NULL;
> -	}
> +	    (edev->mode & EEH_DEV_NO_HANDLER))
> +		goto out1;
>  
>  	rc = driver->err_handler->mmio_enabled(dev);
>  
> @@ -267,7 +269,10 @@ static void *eeh_report_mmio_enabled(void *data, void *userdata)
>  	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
>  	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
>  
> +out1:
>  	eeh_pcid_put(dev);
> +out2:
> +	device_unlock(&dev->dev);
>  	return NULL;
>  }
>  
> @@ -290,20 +295,20 @@ static void *eeh_report_reset(void *data, void *userdata)
>  
>  	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
>  		return NULL;
> +
> +	device_lock(&dev->dev);
>  	dev->error_state = pci_channel_io_normal;
>  
>  	driver = eeh_pcid_get(dev);
> -	if (!driver) return NULL;
> +	if (!driver) goto out2;
>  
>  	eeh_enable_irq(dev);
>  
>  	if (!driver->err_handler ||
>  	    !driver->err_handler->slot_reset ||
>  	    (edev->mode & EEH_DEV_NO_HANDLER) ||
> -	    (!edev->in_error)) {
> -		eeh_pcid_put(dev);
> -		return NULL;
> -	}
> +	    (!edev->in_error))
> +		goto out1;
>  
>  	rc = driver->err_handler->slot_reset(dev);
>  	if ((*res == PCI_ERS_RESULT_NONE) ||
> @@ -311,7 +316,10 @@ static void *eeh_report_reset(void *data, void *userdata)
>  	if (*res == PCI_ERS_RESULT_DISCONNECT &&
>  	     rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
>  
> +out1:
>  	eeh_pcid_put(dev);
> +out2:
> +	device_unlock(&dev->dev);
>  	return NULL;
>  }
>  
> @@ -362,10 +370,12 @@ static void *eeh_report_resume(void *data, void *userdata)
>  
>  	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
>  		return NULL;
> +
> +	device_lock(&dev->dev);
>  	dev->error_state = pci_channel_io_normal;
>  
>  	driver = eeh_pcid_get(dev);
> -	if (!driver) return NULL;
> +	if (!driver) goto out2;
>  
>  	was_in_error = edev->in_error;
>  	edev->in_error = false;
> @@ -375,18 +385,20 @@ static void *eeh_report_resume(void *data, void *userdata)
>  	    !driver->err_handler->resume ||
>  	    (edev->mode & EEH_DEV_NO_HANDLER) || !was_in_error) {
>  		edev->mode &= ~EEH_DEV_NO_HANDLER;
> -		eeh_pcid_put(dev);
> -		return NULL;
> +		goto out1;
>  	}
>  
>  	driver->err_handler->resume(dev);
>  
> -	eeh_pcid_put(dev);
>  	pci_uevent_ers(dev, PCI_ERS_RESULT_RECOVERED);
> +out1:
> +	eeh_pcid_put(dev);
>  #ifdef CONFIG_PCI_IOV
>  	if (eeh_ops->notify_resume && eeh_dev_to_pdn(edev))
>  		eeh_ops->notify_resume(eeh_dev_to_pdn(edev));
>  #endif
> +out2:
> +	device_unlock(&dev->dev);
>  	return NULL;
>  }
>  
> @@ -406,23 +418,26 @@ static void *eeh_report_failure(void *data, void *userdata)
>  
>  	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
>  		return NULL;
> +
> +	device_lock(&dev->dev);
>  	dev->error_state = pci_channel_io_perm_failure;
>  
>  	driver = eeh_pcid_get(dev);
> -	if (!driver) return NULL;
> +	if (!driver) goto out2;
>  
>  	eeh_disable_irq(dev);
>  
>  	if (!driver->err_handler ||
> -	    !driver->err_handler->error_detected) {
> -		eeh_pcid_put(dev);
> -		return NULL;
> -	}
> +	    !driver->err_handler->error_detected)
> +		goto out1;
>  
>  	driver->err_handler->error_detected(dev, pci_channel_io_perm_failure);
>  
> -	eeh_pcid_put(dev);
>  	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
> +out1:
> +	eeh_pcid_put(dev);
> +out2:
> +	device_unlock(&dev->dev);
>  	return NULL;
>  }
>  
