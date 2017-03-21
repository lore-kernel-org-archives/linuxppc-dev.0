Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnHDd3fRjzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 13:43:12 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2L2dGpP073283
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 22:43:04 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29ajfefseb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 22:43:04 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 21 Mar 2017 12:43:01 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2L2goRm15597610
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 13:42:58 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2L2gPit019143
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 13:42:26 +1100
Subject: Re: [PATCH v2] cxl: Force context lock during EEH flow
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
References: <20170320095525.8582-1-vaibhav@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>, stable@vger.kernel.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 21 Mar 2017 13:42:01 +1100
MIME-Version: 1.0
In-Reply-To: <20170320095525.8582-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <83375caf-9b1a-dc15-98cb-8c65077dc5e8@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 20/03/17 20:55, Vaibhav Jain wrote:
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
> This patch also introduces function cxl_adapter_context_force_lock()
> that forcefully acquires the context_lock and warns if any active
> contexts exists when this happens. This is needed for case where the
> cxl module is forcibly unbound from an adapter with active
> contexts. In such cases we need cxl_remove() calls this function to
> ensure that no new contexts can be activated while the cleanup for the
> adapter is in progress.
>
> Cc: stable@vger.kernel.org
> Fixes: 70b565bbdb91("cxl: Prevent adapter reset if an active context exists")
> Reported-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
> Change-Log:
>
> v2..v1
> - Moved the call to cxl_adapter_context_force_lock() from
> cxl_pci_error_detected() to cxl_remove. (Fred)
> ---
>  drivers/misc/cxl/cxl.h  |  3 +++
>  drivers/misc/cxl/main.c | 10 ++++++++++
>  drivers/misc/cxl/pci.c  | 33 +++++++++++++++++++++++++--------
>  3 files changed, 38 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index 79e60ec..4ae44a0 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -1024,4 +1024,7 @@ int cxl_adapter_context_lock(struct cxl *adapter);
>  /* Unlock the contexts-lock if taken. Warn and force unlock otherwise */
>  void cxl_adapter_context_unlock(struct cxl *adapter);
>
> +/* Force contexts-lock to be taken */
> +void cxl_adapter_context_force_lock(struct cxl *adapter);
> +
>  #endif
> diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
> index b0b6ed3..76d8d85 100644
> --- a/drivers/misc/cxl/main.c
> +++ b/drivers/misc/cxl/main.c
> @@ -303,6 +303,16 @@ void cxl_adapter_context_put(struct cxl *adapter)
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
> index 91f6459..116be05 100644
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
> @@ -1736,6 +1737,9 @@ static void cxl_remove(struct pci_dev *dev)
>  	struct cxl_afu *afu;
>  	int i;
>
> +	/* Forcibly take the adapter context lock */
> +	cxl_adapter_context_force_lock(adapter);
> +
>  	/*
>  	 * Lock to prevent someone grabbing a ref through the adapter list as
>  	 * we are removing it
> @@ -1781,7 +1785,7 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>  {
>  	struct cxl *adapter = pci_get_drvdata(pdev);
>  	struct cxl_afu *afu;
> -	pci_ers_result_t result = PCI_ERS_RESULT_NEED_RESET;
> +	pci_ers_result_t result = PCI_ERS_RESULT_NEED_RESET, afu_result;
>  	int i;
>
>  	/* At this point, we could still have an interrupt pending.
> @@ -1886,16 +1890,26 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>  	for (i = 0; i < adapter->slices; i++) {
>  		afu = adapter->afu[i];
>
> -		result = cxl_vphb_error_detected(afu, state);
> -
> -		/* Only continue if everyone agrees on NEED_RESET */
> -		if (result != PCI_ERS_RESULT_NEED_RESET)
> -			return result;
> +		afu_result = cxl_vphb_error_detected(afu, state);
>
>  		cxl_context_detach_all(afu);
>  		cxl_ops->afu_deactivate_mode(afu, afu->current_mode);
>  		pci_deconfigure_afu(afu);
> +
> +		/* Disconnect trumps all, NONE trumps NEED_RESET */
> +		if (afu_result == PCI_ERS_RESULT_DISCONNECT)
> +			result = PCI_ERS_RESULT_DISCONNECT;
> +		else if ((afu_result == PCI_ERS_RESULT_NONE) &&
> +			 (result == PCI_ERS_RESULT_NEED_RESET))
> +			result = PCI_ERS_RESULT_NONE;
>  	}

This change looks alright to me, it's a fix really, but I think might 
need a quick mention in the changelog? AFAICT it'll change the return 
value in cases where, for whatever reason, an earlier slice returns 
PCI_ERS_RESULT_NONE and a later slice would return 
PCI_ERS_RESULT_DISCONNECT, from what I can see.

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
> @@ -1978,6 +1992,9 @@ static void cxl_pci_resume(struct pci_dev *pdev)
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

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
