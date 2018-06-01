Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y7pG0PT9zDrph
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 01:40:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 07/13] powerpc/eeh: Clean up pci_ers_result handling
In-Reply-To: <e638159f9e6dfc4931f5164220741dd99bb4c0c7.1527217866.git.sbobroff@linux.ibm.com>
References: <cover.1527217866.git.sbobroff@linux.ibm.com>
 <e638159f9e6dfc4931f5164220741dd99bb4c0c7.1527217866.git.sbobroff@linux.ibm.com>
Date: Sat, 02 Jun 2018 01:40:46 +1000
Message-ID: <87muwe3475.fsf@concordia.ellerman.id.au>
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
> ====== v1 -> v2: ======
>
> * Added the value, and missing newline, to some WARN()s.
> * Improved name of merge_result() to pci_ers_merge_result().
> * Adjusted the result priorities so that unknown doesn't overlap with _NONE.

These === markers seem to have confused patchwork, they ended up in the
patch, and then git put them in the changelog.

http://patchwork.ozlabs.org/patch/920194/

The usual format is just something like:

v2 - Added the value, and missing newline, to some WARN()s.
   - Improved name of merge_result() to pci_ers_merge_result().
   - Adjusted the result priorities so that unknown doesn't overlap with _NONE.

cheers

>  arch/powerpc/kernel/eeh_driver.c | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index 188d15c4fe3a..2d3cac584899 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -39,6 +39,29 @@ struct eeh_rmv_data {
>  	int removed;
>  };
>  
> +static int eeh_result_priority(enum pci_ers_result result)
> +{
> +	switch (result) {
> +	case PCI_ERS_RESULT_NONE: return 1;
> +	case PCI_ERS_RESULT_NO_AER_DRIVER: return 2;
> +	case PCI_ERS_RESULT_RECOVERED: return 3;
> +	case PCI_ERS_RESULT_CAN_RECOVER: return 4;
> +	case PCI_ERS_RESULT_DISCONNECT: return 5;
> +	case PCI_ERS_RESULT_NEED_RESET: return 6;
> +	default:
> +		WARN_ONCE(1, "Unknown pci_ers_result value: %d\n", (int)result);
> +		return 0;
> +	}
> +};
> +
> +static enum pci_ers_result pci_ers_merge_result(enum pci_ers_result old,
> +						enum pci_ers_result new)
> +{
> +	if (eeh_result_priority(new) > eeh_result_priority(old))
> +		return new;
> +	return old;
> +}
> +
>  /**
>   * eeh_pcid_get - Get the PCI device driver
>   * @pdev: PCI device
> @@ -206,9 +229,7 @@ static void *eeh_report_error(struct eeh_dev *edev, void *userdata)
>  
>  	rc = driver->err_handler->error_detected(dev, pci_channel_io_frozen);
>  
> -	/* A driver that needs a reset trumps all others */
> -	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
> -	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
> +	*res = pci_ers_merge_result(*res, rc);
>  
>  	edev->in_error = true;
>  	pci_uevent_ers(dev, PCI_ERS_RESULT_NONE);
> @@ -249,9 +270,7 @@ static void *eeh_report_mmio_enabled(struct eeh_dev *edev, void *userdata)
>  
>  	rc = driver->err_handler->mmio_enabled(dev);
>  
> -	/* A driver that needs a reset trumps all others */
> -	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
> -	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
> +	*res = pci_ers_merge_result(*res, rc);
>  
>  out:
>  	eeh_pcid_put(dev);
> @@ -294,10 +313,7 @@ static void *eeh_report_reset(struct eeh_dev *edev, void *userdata)
>  		goto out;
>  
>  	rc = driver->err_handler->slot_reset(dev);
> -	if ((*res == PCI_ERS_RESULT_NONE) ||
> -	    (*res == PCI_ERS_RESULT_RECOVERED)) *res = rc;
> -	if (*res == PCI_ERS_RESULT_DISCONNECT &&
> -	     rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
> +	*res = pci_ers_merge_result(*res, rc);
>  
>  out:
>  	eeh_pcid_put(dev);
> -- 
> 2.16.1.74.g9b0b1f47b
