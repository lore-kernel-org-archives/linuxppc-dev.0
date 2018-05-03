Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cGCR6y6YzF2S9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 23:27:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 13/13] powerpc/eeh: Refactor report functions
In-Reply-To: <313ced0e1c4f5140566846bb41f1c42c26c96a0b.1525242772.git.sbobroff@linux.ibm.com>
References: <cover.1525242772.git.sbobroff@linux.ibm.com>
 <313ced0e1c4f5140566846bb41f1c42c26c96a0b.1525242772.git.sbobroff@linux.ibm.com>
Date: Thu, 03 May 2018 23:27:12 +1000
Message-ID: <87efisamz3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sam Bobroff <sbobroff@linux.ibm.com> writes:
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index eb4feee81ff4..1c4336dcf9f5 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -54,6 +54,25 @@ static int eeh_result_priority(enum pci_ers_result result)
>  	}
>  };
>  
> +const char *pci_ers_result_name(enum pci_ers_result r)
> +{
> +	switch (r) {
> +	case PCI_ERS_RESULT_NONE: return "none";
> +	case PCI_ERS_RESULT_CAN_RECOVER: return "can recover";
> +	case PCI_ERS_RESULT_NEED_RESET: return "need reset";
> +	case PCI_ERS_RESULT_DISCONNECT: return "disconnect";
> +	case PCI_ERS_RESULT_RECOVERED: return "recovered";
> +	case PCI_ERS_RESULT_NO_AER_DRIVER: return "no AER driver";
> +	default:
> +		WARN_ONCE(1, "Unknown result type");
> +		return "unknown";
> +	}
> +};
> +
> +#define eeh_infoline(EDEV, FMT, ...) \
> +pr_info("EEH: PE#%x (PCI %s): " pr_fmt(FMT) "\n", EDEV->pe_config_addr, \
> +((EDEV->pdev) ? dev_name(&EDEV->pdev->dev) : "NONE"), ##__VA_ARGS__)

Ooof, I guess.

It would be nicer as a function.

"infoline" annoys me for some reason, "eeh_info" ?

> @@ -223,123 +242,118 @@ static void eeh_set_irq_state(struct eeh_pe *root, bool enable)
>  				}
>  }
>  
> +static void eeh_pe_report(const char *name, struct eeh_pe *root,
> +			  enum pci_ers_result (*fn)(struct eeh_dev *,
> +						    struct pci_driver *),
> +			  enum pci_ers_result *result)
> +{
> +	struct eeh_pe *pe;
> +	struct eeh_dev *edev, *tmp;
> +	enum pci_ers_result new_result;
> +
> +	pr_info("EEH: Beginning: '%s'\n", name);
> +	eeh_for_each_pe(root, pe) {
> +		eeh_pe_for_each_dev(pe, edev, tmp) {

This should be in a separate function.

> +			device_lock(&edev->pdev->dev);
> +			if (eeh_edev_actionable(edev)) {
> +				struct pci_driver *driver;
> +
> +				driver = eeh_pcid_get(edev->pdev);
> +
> +				if (!driver)
> +					eeh_infoline(edev, "no driver");
> +				else if (!driver->err_handler)
> +					eeh_infoline(edev,
> +						     "driver not EEH aware");
> +				else if (edev->mode & EEH_DEV_NO_HANDLER)
> +					eeh_infoline(edev,
> +						     "driver bound too late");
> +				else {
> +					new_result = fn(edev, driver);
> +					eeh_infoline(edev,
> +						"%s driver reports: '%s'",
> +						driver->name,
> +						pci_ers_result_name(new_result));
> +					if (result)
> +						*result = merge_result(*result,
> +								       new_result);
> +				}
> +				if (driver)
> +					eeh_pcid_put(edev->pdev);
> +			} else {
> +				eeh_infoline(edev, "not actionable (%d,%d,%d)",
> +					     !!edev->pdev,
> +					     !eeh_dev_removed(edev),
> +					     !eeh_pe_passed(edev->pe));
> +			}
> +			device_unlock(&edev->pdev->dev);

^^^


cheers
