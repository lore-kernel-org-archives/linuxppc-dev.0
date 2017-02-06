Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHCMl07H6zDqGL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 03:18:58 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v16GIpXL130216
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Feb 2017 11:18:55 -0500
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28et9sehdq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Feb 2017 11:18:54 -0500
Received: from localhost
 by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 6 Feb 2017 16:18:40 -0000
Subject: Re: [PATCH] cxl: Force context lock during EEH flow
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20170203065739.3052-1-vaibhav@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 frederic.barrat@fr.ibm.com, stable@vger.kernel.org,
 Ian Munsie <ianmunsi@au1.ibm.com>, Andrew Donnellan <andonnel@au1.ibm.com>,
 Gregory Kurz <KURZGREG@fr.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Mon, 6 Feb 2017 17:18:09 +0100
MIME-Version: 1.0
In-Reply-To: <20170203065739.3052-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <d7499436-f25c-fac8-8908-c622a24d85f1@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 03/02/2017 à 07:57, Vaibhav Jain a écrit :
> During an eeh event when the cxl card is fenced and card sysfs attr
> perst_reloads_same_image is set following warning message is seen in the
> kernel logs:
>
>  [   60.622727] Adapter context unlocked with 0 active contexts
>  [   60.622762] ------------[ cut here ]------------
>  [   60.622771] WARNING: CPU: 12 PID: 627 at
>  ../drivers/misc/cxl/main.c:325 cxl_adapter_context_unlock+0x60/0x80 [cxl]
>
> Even though this warning is harmless, it clutters the kernel log
> during an eeh event. This warning is triggered as the EEH callback
> cxl_pci_error_detected doesn't obtain a context-lock before forcibly
> detaching all active context and when context-lock is released during
> call to cxl_configure_adapter from cxl_pci_slot_reset, a warning in
> cxl_adapter_context_unlock is triggered.
>
> To fix this warning and also prevent activation of any context during
> eeh the patch introduces a new function cxl_adapter_context_force_lock
> that would forcefully acquire the context_lock and warn if any active
> contexts exists when this happens. After the EEH flow concludes with
> call to cxl_pci_resume the context-lock is released with a call to
> cxl_adapter_context_unlock.
>
> Cc: stable@vger.kernel.org
> Fixes: 70b565bbdb91("cxl: Prevent adapter reset if an active context exists")
> Reported-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> ---
>  drivers/misc/cxl/cxl.h  |  3 +++
>  drivers/misc/cxl/main.c | 10 ++++++++++
>  drivers/misc/cxl/pci.c  | 18 ++++++++++++++++--
>  3 files changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index b24d767..34d2ca0 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -970,4 +970,7 @@ int cxl_adapter_context_lock(struct cxl *adapter);
>  /* Unlock the contexts-lock if taken. Warn and force unlock otherwise */
>  void cxl_adapter_context_unlock(struct cxl *adapter);
>
> +/* Force contexts-lock to be taken */
> +void cxl_adapter_context_force_lock(struct cxl *adapter);
> +
>  #endif
> diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
> index 62e0dfb..1754a0c 100644
> --- a/drivers/misc/cxl/main.c
> +++ b/drivers/misc/cxl/main.c
> @@ -301,6 +301,16 @@ void cxl_adapter_context_put(struct cxl *adapter)
>  	atomic_dec_if_positive(&adapter->contexts_num);
>  }
>
> +void cxl_adapter_context_force_lock(struct cxl *adapter)
> +{
> +	int count = atomic_read(&adapter->contexts_num);
> +
> +	if (count > 0)
> +		pr_warn("Forcing context lock with %d active contexts\n",
> +			count);
> +	atomic_set(&adapter->contexts_num, -1);
> +}
> +

>  int cxl_adapter_context_lock(struct cxl *adapter)
>  {
>  	int rc;
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 80a87ab..d76fd4d 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1487,8 +1487,6 @@ static int cxl_configure_adapter(struct cxl *adapter, struct pci_dev *dev)
>  	if ((rc = cxl_native_register_psl_err_irq(adapter)))
>  		goto err;
>
> -	/* Release the context lock as adapter is configured */
> -	cxl_adapter_context_unlock(adapter);
>  	return 0;
>
>  err:
> @@ -1587,6 +1585,9 @@ static struct cxl *cxl_pci_init_adapter(struct pci_dev *dev)
>  	if ((rc = cxl_sysfs_adapter_add(adapter)))
>  		goto err_put1;
>
> +	/* Release the context lock as adapter is configured */
> +	cxl_adapter_context_unlock(adapter);
> +
>  	return adapter;
>
>  err_put1:
> @@ -1607,6 +1608,9 @@ static void cxl_pci_remove_adapter(struct cxl *adapter)
>  {
>  	pr_devel("cxl_remove_adapter\n");
>
> +	/* Forcibly take the adapter context lock */
> +	cxl_adapter_context_force_lock(adapter);
> +
>  	cxl_sysfs_adapter_remove(adapter);
>  	cxl_debugfs_adapter_remove(adapter);
>
> @@ -1778,6 +1782,9 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>  	 */
>  	schedule();
>
> +	/* forcibly take the context lock to prevent new context activation */
> +	cxl_adapter_context_force_lock(adapter);
> +

I'm not a fan of the "force lock" call and I'm not convinced it's 
needed. When an EEH is triggered, we'll force-detach all the contexts. 
So that in itself should bring the counter of active contexts to 0. So 
why not just add a cxl_adapter_context_lock() call at the end of 
cxl_pci_error_detected()? The lock would be released in 
cxl_configure_adapter when cxl_pci_slot_reset() is called, as is already 
the case with the current code.
(as a side note, I don't believe the code is racy and that we need to 
add extra protection to avoid context activation while 
cxl_pci_error_detected() is called. We can talk about it if needed)

   Fred



>  	/* If we're permanently dead, give up. */
>  	if (state == pci_channel_io_perm_failure) {
>  		/* Tell the AFU drivers; but we don't care what they
> @@ -1879,11 +1886,15 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>  		/* Only continue if everyone agrees on NEED_RESET */
>  		if (result != PCI_ERS_RESULT_NEED_RESET)
>  			return result;
> +	}
>
> +	for (i = 0; i < adapter->slices; i++) {
> +		afu = adapter->afu[i];
>  		cxl_context_detach_all(afu);
>  		cxl_ops->afu_deactivate_mode(afu, afu->current_mode);
>  		pci_deconfigure_afu(afu);
>  	}
> +
>  	cxl_deconfigure_adapter(adapter);
>
>  	return result;
> @@ -1979,6 +1990,9 @@ static void cxl_pci_resume(struct pci_dev *pdev)
>  				afu_dev->driver->err_handler->resume(afu_dev);
>  		}
>  	}
> +
> +	/* Unlock context activation for the adapter */
> +	cxl_adapter_context_unlock(adapter);
>  }
>
>  static const struct pci_error_handlers cxl_err_handler = {
>
