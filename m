Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vyhSc0fgmzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 20:11:11 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v35A916h067485
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Apr 2017 06:11:00 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29mxfugbb8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Apr 2017 06:11:00 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 5 Apr 2017 11:10:57 +0100
Subject: Re: [PATCH v3] cxl: Force context lock during EEH flow
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20170405061237.13601-1-vaibhav@linux.vnet.ibm.com>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>, stable@vger.kernel.org
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 5 Apr 2017 12:10:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170405061237.13601-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <965dc468-48c1-49bd-f5a6-6c528efa1834@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Vaibhav,

I like the simplified version better. However, I think it breaks 
cxlflash's recovery. With this patch, we are also unlocking the adapter 
later. It doesn't matter when the driver initializes the first time, but 
on EEH, we now call the "slot reset" callback of the virtual device 
while locked (we unlock on "resume"). And cxlflash re-attach's on "slot 
reset", see cxlflash_pci_slot_reset()->init_afu()->init_mc().
That was also true on the previous versions of the patch.

   Fred

Le 05/04/2017 à 08:12, Vaibhav Jain a écrit :
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
> To fix this warning, we acquire the adapter context-lock via
> cxl_adapter_context_lock() in the eeh callback
> cxl_pci_error_detected() once all the virtual AFU PHBs are notified
> and their contexts detached. After the EEH flow concludes with
> call to cxl_pci_resume() the context-lock is released with a call to
> cxl_adapter_context_unlock() just before notifying all virtual AFU
> PHBs to resume so that they can re-activate any contexts if needed.
>
> Cc: stable@vger.kernel.org
> Fixes: 70b565bbdb91("cxl: Prevent adapter reset if an active context exists")
> Reported-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
> Change-Log:
>
> v2..v3
> - As discussed with Fred removed function
> cxl_adapter_context_force_lock() which may potentially expose the code
> to deadlock in the future.
> -  Other details of changes in cxl_pci_error_detected() to fix an
> earlier issue of eeh callbacks not being passed on to all slices, is
> being reworked as a separate patch.
>
> v2..v1
> - Moved the call to cxl_adapter_context_force_lock() from
> cxl_pci_error_detected() to cxl_remove. (Fred)
> ---
>  drivers/misc/cxl/pci.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index b27ea98..1e98245 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1496,8 +1496,6 @@ static int cxl_configure_adapter(struct cxl *adapter, struct pci_dev *dev)
>  	if ((rc = cxl_native_register_psl_err_irq(adapter)))
>  		goto err;
>
> -	/* Release the context lock as adapter is configured */
> -	cxl_adapter_context_unlock(adapter);
>  	return 0;
>
>  err:
> @@ -1596,6 +1594,9 @@ static struct cxl *cxl_pci_init_adapter(struct pci_dev *dev)
>  	if ((rc = cxl_sysfs_adapter_add(adapter)))
>  		goto err_put1;
>
> +	/* Release the context lock as adapter is configured */
> +	cxl_adapter_context_unlock(adapter);
> +
>  	return adapter;
>
>  err_put1:
> @@ -1895,6 +1896,13 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>  		cxl_ops->afu_deactivate_mode(afu, afu->current_mode);
>  		pci_deconfigure_afu(afu);
>  	}
> +
> +	/* should take the context lock here */
> +	if (cxl_adapter_context_lock(adapter) != 0)
> +		dev_warn(&adapter->dev,
> +			 "Couldn't take context lock with %d active-contexts\n",
> +			 atomic_read(&adapter->contexts_num));
> +
>  	cxl_deconfigure_adapter(adapter);
>
>  	return result;
> @@ -1977,6 +1985,9 @@ static void cxl_pci_resume(struct pci_dev *pdev)
>  	struct pci_dev *afu_dev;
>  	int i;
>
> +	/* Unlock context activation for the adapter */
> +	cxl_adapter_context_unlock(adapter);
> +
>  	/* Everything is back now. Drivers should restart work now.
>  	 * This is not the place to be checking if everything came back up
>  	 * properly, because there's no return value: do that in slot_reset.
>
