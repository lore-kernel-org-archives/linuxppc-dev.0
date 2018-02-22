Return-Path: <srs0=1/yt=fq=kernel.org=helgaas@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znVWX09tmzF0hf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 10:12:56 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3znVWW4XRRz8sk5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 10:12:55 +1100 (AEDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3znVWW0Y63z9sWd
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2018 10:12:55 +1100 (AEDT)
Date: Thu, 22 Feb 2018 17:12:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org,
 torvalds@linux-foundation.org, ruscur@russell.cc,
 bryantly@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com
Subject: Re: [PATCH] PCI/AER: Move pci_uevent_ers() out of pci.h
Message-ID: <20180222231251.GC14632@bhelgaas-glaptop.roam.corp.google.com>
References: <20180208122035.9305-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180208122035.9305-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 08, 2018 at 11:20:35PM +1100, Michael Ellerman wrote:
> There's no reason pci_uevent_ers() needs to be inline in pci.h, so
> move it out to a C file.
> 
> Given it's used by AER the obvious location would be somewhere in
> drivers/pci/pcie/aer, but because it's also used by powerpc EEH code
> unfortunately that doesn't work in the case where EEH is enabled but
> PCIEPORTBUS is not.
> 
> So for now put it in pci-driver.c, next to pci_uevent(), with an
> appropriate #ifdef so it's not built if AER and EEH are both disabled.
> 
> While we're moving it also fix up the kernel doc comment for @pdev to
> be accurate.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to pci/aer for v4.17, thanks!

> ---
>  drivers/pci/pci-driver.c | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h      | 38 +++-----------------------------------
>  2 files changed, 39 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 3bed6beda051..f21e8b1bef80 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1517,6 +1517,42 @@ static int pci_uevent(struct device *dev, struct kobj_uevent_env *env)
>  	return 0;
>  }
>  
> +#if defined(CONFIG_PCIEAER) || defined(CONFIG_EEH)
> +/**
> + * pci_uevent_ers - emit a uevent during recovery path of pci device
> + * @pdev: pci device undergoing error recovery
> + * @err_type: type of error event
> + */
> +void pci_uevent_ers(struct pci_dev *pdev, enum pci_ers_result err_type)
> +{
> +	int idx = 0;
> +	char *envp[3];
> +
> +	switch (err_type) {
> +	case PCI_ERS_RESULT_NONE:
> +	case PCI_ERS_RESULT_CAN_RECOVER:
> +		envp[idx++] = "ERROR_EVENT=BEGIN_RECOVERY";
> +		envp[idx++] = "DEVICE_ONLINE=0";
> +		break;
> +	case PCI_ERS_RESULT_RECOVERED:
> +		envp[idx++] = "ERROR_EVENT=SUCCESSFUL_RECOVERY";
> +		envp[idx++] = "DEVICE_ONLINE=1";
> +		break;
> +	case PCI_ERS_RESULT_DISCONNECT:
> +		envp[idx++] = "ERROR_EVENT=FAILED_RECOVERY";
> +		envp[idx++] = "DEVICE_ONLINE=0";
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (idx > 0) {
> +		envp[idx++] = NULL;
> +		kobject_uevent_env(&pdev->dev.kobj, KOBJ_CHANGE, envp);
> +	}
> +}
> +#endif
> +
>  static int pci_bus_num_vf(struct device *dev)
>  {
>  	return pci_num_vf(to_pci_dev(dev));
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 024a1beda008..19c1dbcff0c6 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2280,41 +2280,9 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
>  	return false;
>  }
>  
> -/**
> - * pci_uevent_ers - emit a uevent during recovery path of pci device
> - * @pdev: pci device to check
> - * @err_type: type of error event
> - *
> - */
> -static inline void pci_uevent_ers(struct pci_dev *pdev,
> -				  enum  pci_ers_result err_type)
> -{
> -	int idx = 0;
> -	char *envp[3];
> -
> -	switch (err_type) {
> -	case PCI_ERS_RESULT_NONE:
> -	case PCI_ERS_RESULT_CAN_RECOVER:
> -		envp[idx++] = "ERROR_EVENT=BEGIN_RECOVERY";
> -		envp[idx++] = "DEVICE_ONLINE=0";
> -		break;
> -	case PCI_ERS_RESULT_RECOVERED:
> -		envp[idx++] = "ERROR_EVENT=SUCCESSFUL_RECOVERY";
> -		envp[idx++] = "DEVICE_ONLINE=1";
> -		break;
> -	case PCI_ERS_RESULT_DISCONNECT:
> -		envp[idx++] = "ERROR_EVENT=FAILED_RECOVERY";
> -		envp[idx++] = "DEVICE_ONLINE=0";
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	if (idx > 0) {
> -		envp[idx++] = NULL;
> -		kobject_uevent_env(&pdev->dev.kobj, KOBJ_CHANGE, envp);
> -	}
> -}
> +#if defined(CONFIG_PCIEAER) || defined(CONFIG_EEH)
> +void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
> +#endif
>  
>  /* Provide the legacy pci_dma_* API */
>  #include <linux/pci-dma-compat.h>
> -- 
> 2.14.1
> 
