Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cjX11wJFzF0QC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 16:58:09 +1000 (AEST)
Message-ID: <1525417081.2560.10.camel@russell.cc>
Subject: Re: [PATCH 07/13] powerpc/eeh: Clean up pci_ers_result handling
From: Russell Currey <ruscur@russell.cc>
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 04 May 2018 16:58:01 +1000
In-Reply-To: <a4aae83e02d8a5424a92321659a2100a5589d366.1525242772.git.sbobroff@linux.ibm.com>
References: <cover.1525242772.git.sbobroff@linux.ibm.com>
 <a4aae83e02d8a5424a92321659a2100a5589d366.1525242772.git.sbobroff@linux.ibm.com>
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

On Wed, 2018-05-02 at 16:36 +1000, Sam Bobroff wrote:
> As EEH event handling progresses, a cumulative result of type
> pci_ers_result is built up by (some of) the eeh_report_*() functions
> using either:
> 	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
> 	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
> or:
> 	if ((*res == PCI_ERS_RESULT_NONE) ||
> 	    (*res == PCI_ERS_RESULT_RECOVERED)) *res = rc;
> 	if (*res == PCI_ERS_RESULT_DISCONNECT &&
> 	    rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
> (Where *res is the accumulator.)
> 
> However, the intent is not immediately clear and the result in some
> situations is order dependent.
> 
> Address this by assigning a priority to each result value, and always
> merging to the highest priority. This renders the intent clear, and
> provides a stable value for all orderings.
> 
> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> ---
>  arch/powerpc/kernel/eeh_driver.c | 36 ++++++++++++++++++++++++++--
> --------
>  1 file changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/eeh_driver.c
> b/arch/powerpc/kernel/eeh_driver.c
> index 188d15c4fe3a..f33dd68a9ca2 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -39,6 +39,29 @@ struct eeh_rmv_data {
>  	int removed;
>  };
>  
> +static int eeh_result_priority(enum pci_ers_result result)
> +{
> +	switch (result) {
> +	case PCI_ERS_RESULT_NONE: return 0;
> +	case PCI_ERS_RESULT_NO_AER_DRIVER: return 1;
> +	case PCI_ERS_RESULT_RECOVERED: return 2;
> +	case PCI_ERS_RESULT_CAN_RECOVER: return 3;
> +	case PCI_ERS_RESULT_DISCONNECT: return 4;
> +	case PCI_ERS_RESULT_NEED_RESET: return 5;
> +	default:
> +		WARN_ONCE(1, "Unknown pci_ers_result value");

Missing newline and also would be good to print the value was

> +		return 0;
> +	}
> +};
> +
> +static enum pci_ers_result merge_result(enum pci_ers_result old,
> +					enum pci_ers_result new)

merge_result() sounds like something really generic, maybe call it
pci_ers_merge_result() or something?

Note: just learned that it stands for Error Recovery System and that's
a thing (?)

> +{
> +	if (eeh_result_priority(new) > eeh_result_priority(old))
> +		return new;
> +	return old;

MAX would be nicer as per mpe's suggestion

> +}
> +
>  /**
>   * eeh_pcid_get - Get the PCI device driver
>   * @pdev: PCI device
> @@ -206,9 +229,7 @@ static void *eeh_report_error(struct eeh_dev
> *edev, void *userdata)
>  
>  	rc = driver->err_handler->error_detected(dev,
> pci_channel_io_frozen);
>  
> -	/* A driver that needs a reset trumps all others */
> -	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
> -	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
> +	*res = merge_result(*res, rc);
>  
>  	edev->in_error = true;
>  	pci_uevent_ers(dev, PCI_ERS_RESULT_NONE);
> @@ -249,9 +270,7 @@ static void *eeh_report_mmio_enabled(struct
> eeh_dev *edev, void *userdata)
>  
>  	rc = driver->err_handler->mmio_enabled(dev);
>  
> -	/* A driver that needs a reset trumps all others */
> -	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
> -	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
> +	*res = merge_result(*res, rc);
>  
>  out:
>  	eeh_pcid_put(dev);
> @@ -294,10 +313,7 @@ static void *eeh_report_reset(struct eeh_dev
> *edev, void *userdata)
>  		goto out;
>  
>  	rc = driver->err_handler->slot_reset(dev);
> -	if ((*res == PCI_ERS_RESULT_NONE) ||
> -	    (*res == PCI_ERS_RESULT_RECOVERED)) *res = rc;
> -	if (*res == PCI_ERS_RESULT_DISCONNECT &&
> -	     rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
> +	*res = merge_result(*res, rc);
>  
>  out:
>  	eeh_pcid_put(dev);
