Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3st3SL5GkRzDrbq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 02:09:21 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9AF4JDZ074505
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 11:09:18 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 260cc3ayb8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 11:09:18 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 10 Oct 2016 16:09:16 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4B9C1219005F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 16:08:32 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9AF9Eov17629418
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 15:09:14 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9AF9Daa011215
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 09:09:14 -0600
Subject: Re: [PATCH] cxl: Prevent adapter reset if an active context exists
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1476108550-31686-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Mon, 10 Oct 2016 17:09:07 +0200
MIME-Version: 1.0
In-Reply-To: <1476108550-31686-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <d250fc2f-2c56-1bbd-72fa-fc65ab8754d2@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Vaibhav,


A few comments below...


Le 10/10/2016 à 16:09, Vaibhav Jain a écrit :
> This patch prevents resetting the cxl adapter via sysfs in presence of
> one or more active cxl_context on it. This protects against an
> unrecoverable error caused by PSL owning a dirty cache line even after
> reset and host tries to touch the same cache line. In case a force reset
> of the card is required irrespective of any active contexts, the int
> value -1 can be stored in the 'reset' sysfs attribute of the card.
>
> The patch introduces a new atomic_t member named contexts_num inside
> struct cxl that holds the number of active context attached to the card
> , which is checked against '0' before proceeding with the reset. To
> prevent against a race condition where a context is activated just after
> reset check is performed, the contexts_num is atomically set to '-1'
> after reset-check to indicate that no more contexts can be activated on
> the card anymore.
>
> Before activating a context we atomically test if contexts_num is
> non-negative and if so, increment its value by one. In case the value of
> contexts_num is negative then it indicates that the card is about to be
> reset and context activation is error-ed out at that point.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> ---
>  Documentation/ABI/testing/sysfs-class-cxl |  7 +++++--
>  drivers/misc/cxl/api.c                    |  9 +++++++++
>  drivers/misc/cxl/context.c                |  3 +++
>  drivers/misc/cxl/cxl.h                    | 21 +++++++++++++++++++++
>  drivers/misc/cxl/file.c                   |  9 +++++++++
>  drivers/misc/cxl/main.c                   | 24 +++++++++++++++++++++++-
>  drivers/misc/cxl/sysfs.c                  | 18 ++++++++++++++----
>  7 files changed, 84 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
> index 4ba0a2a..dae2b38 100644
> --- a/Documentation/ABI/testing/sysfs-class-cxl
> +++ b/Documentation/ABI/testing/sysfs-class-cxl
> @@ -220,8 +220,11 @@ What:           /sys/class/cxl/<card>/reset
>  Date:           October 2014
>  Contact:        linuxppc-dev@lists.ozlabs.org
>  Description:    write only
> -                Writing 1 will issue a PERST to card which may cause the card
> -                to reload the FPGA depending on load_image_on_perst.
> +                Writing 1 will issue a PERST to card provided there are no
> +		contexts active on any one of the card AFUs. This may cause
> +		the card to reload the FPGA depending on load_image_on_perst.
> +		Writing -1 will do a force PERST irrespective of any active
> +		contexts on the card AFUs.
>  Users:		https://github.com/ibm-capi/libcxl
>
>  What:		/sys/class/cxl/<card>/perst_reloads_same_image (not in a guest)
> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> index f3d34b9..85bb2d9 100644
> --- a/drivers/misc/cxl/api.c
> +++ b/drivers/misc/cxl/api.c
> @@ -236,10 +236,19 @@ int cxl_start_context(struct cxl_context *ctx, u64 wed,
>  		ctx->real_mode = false;
>  	}
>
> +	/*
> +	 * Increment the mapped context count for adapter. This also checks
> +	 * if adapter_context_lock is taken.
> +	 */
> +	rc = cxl_adapter_context_get(ctx->afu->adapter);
> +	if (rc)
> +		goto out;
> +
>  	cxl_ctx_get();
>
>  	if ((rc = cxl_ops->attach_process(ctx, kernel, wed, 0))) {
>  		put_pid(ctx->pid);
> +		cxl_adapter_context_put(ctx->afu->adapter);
>  		cxl_ctx_put();
>  		goto out;
>  	}
> diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
> index c466ee2..5e506c1 100644
> --- a/drivers/misc/cxl/context.c
> +++ b/drivers/misc/cxl/context.c
> @@ -238,6 +238,9 @@ int __detach_context(struct cxl_context *ctx)
>  	put_pid(ctx->glpid);
>
>  	cxl_ctx_put();
> +
> +	/* Decrease the attached context count on the adapter */
> +	cxl_adapter_context_put(ctx->afu->adapter);
>  	return 0;
>  }
>
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index 01d372a..ed89c57 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -618,6 +618,14 @@ struct cxl {
>  	bool perst_select_user;
>  	bool perst_same_image;
>  	bool psl_timebase_synced;
> +
> +	/*
> +	 * number of contexts mapped on to this card.
> +	 * +ve: Number of contexts mapped and new one can be mapped.
> +	 *  0 : No active contexts and new ones can be mapped.
> +	 * -ve: No contexts mapped and new ones cannot be mapped.


what does "ve" stand for ?
For the last one, shouldn't it be '-1' ?


> +	 */
> +	atomic_t contexts_num;
>  };
>
>  int cxl_pci_alloc_one_irq(struct cxl *adapter);
> @@ -944,4 +952,17 @@ bool cxl_pci_is_vphb_device(struct pci_dev *dev);
>
>  /* decode AFU error bits in the PSL register PSL_SERR_An */
>  void cxl_afu_decode_psl_serr(struct cxl_afu *afu, u64 serr);
> +
> +/*
> + * Increments the number of attached contexts on an adapter.
> + * Incase an adapter_context_lock is taken the return -EBUSY.


typo "In case"


> + */
> +int cxl_adapter_context_get(struct cxl *adapter);
> +
> +/* Decrements the number of attached contexts on an adapter */
> +void cxl_adapter_context_put(struct cxl *adapter);
> +
> +/* If no active contexts then prevents contexts from being attached */
> +int cxl_adapter_context_lock(struct cxl *adapter);
> +
>  #endif
> diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
> index 5fb9894..3b2272a 100644
> --- a/drivers/misc/cxl/file.c
> +++ b/drivers/misc/cxl/file.c
> @@ -205,11 +205,20 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
>  	ctx->pid = get_task_pid(current, PIDTYPE_PID);
>  	ctx->glpid = get_task_pid(current->group_leader, PIDTYPE_PID);
>
> +	/*
> +	 * Increment the mapped context count for adapter. This also checks
> +	 * if adapter_context_lock is taken.
> +	 */
> +	rc = cxl_adapter_context_get(ctx->afu->adapter);
> +	if (rc)
> +		goto out;
> +


We are missing a call to afu_release_irqs() in case of error here.


>  	trace_cxl_attach(ctx, work.work_element_descriptor, work.num_interrupts, amr);
>
>  	if ((rc = cxl_ops->attach_process(ctx, false, work.work_element_descriptor,
>  							amr))) {
>  		afu_release_irqs(ctx, ctx);
> +		cxl_adapter_context_put(ctx->afu->adapter);
>  		goto out;
>  	}
>
> diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
> index d9be23b2..5c3c02a 100644
> --- a/drivers/misc/cxl/main.c
> +++ b/drivers/misc/cxl/main.c
> @@ -243,8 +243,9 @@ struct cxl *cxl_alloc_adapter(void)
>  	if (dev_set_name(&adapter->dev, "card%i", adapter->adapter_num))
>  		goto err2;
>
> -	return adapter;
> +	atomic_set(&adapter->contexts_num, 0);


I think the initialization of the counter should be done in 
cxl_configure_adapter() instead of cxl_alloc_adapter(). I would expect 
most reset scenarios to end up unloading/reloading the driver, but if 
you look at cxl_pci_error_detected(), it should be possible to tweak 
some settings to just deconfigure/reconfigure the adapter. So it seems 
safer to reset the counter to 0 in cxl_configure_adapter().

Also wouldn't it make sense to add a WARN if the counter is not NULL 
when unconfiguring the adapter? It seems that it would be a bug.


> +	return adapter;
>  err2:
>  	cxl_remove_adapter_nr(adapter);
>  err1:
> @@ -286,6 +287,27 @@ int cxl_afu_select_best_mode(struct cxl_afu *afu)
>  	return 0;
>  }
>
> +int cxl_adapter_context_get(struct cxl *adapter)
> +{
> +	int rc;
> +
> +	rc = atomic_inc_unless_negative(&adapter->contexts_num);
> +	return rc >= 0 ? 0 : -EBUSY;
> +}
> +
> +void cxl_adapter_context_put(struct cxl *adapter)
> +{
> +	atomic_dec_if_positive(&adapter->contexts_num);
> +}
> +
> +int cxl_adapter_context_lock(struct cxl *adapter)
> +{
> +	int rc;
> +	/* no active contexts -> contexts_num == 0 */
> +	rc = atomic_cmpxchg(&adapter->contexts_num, 0, -1);
> +	return rc ? -EBUSY : 0;
> +}
> +
>  static int __init init_cxl(void)
>  {
>  	int rc = 0;
> diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
> index b043c20..592dbf2 100644
> --- a/drivers/misc/cxl/sysfs.c
> +++ b/drivers/misc/cxl/sysfs.c
> @@ -75,12 +75,22 @@ static ssize_t reset_adapter_store(struct device *device,
>  	int val;
>
>  	rc = sscanf(buf, "%i", &val);
> -	if ((rc != 1) || (val != 1))
> +	if ((rc != 1) || (val != 1 && val != -1))
>  		return -EINVAL;
>
> -	if ((rc = cxl_ops->adapter_reset(adapter)))
> -		return rc;
> -	return count;
> +	/*
> +	 * See if we can lock the context mapping that's only allowed
> +	 * when there are no contexts attached to the adapter. Once
> +	 * taken this will also prevent any context being attached.
> +	 */
> +	if (val == 1)
> +		rc = cxl_adapter_context_lock(adapter);
> +
> +	/* Perform a forced adapter reset */
> +	if (rc >= 0)
> +		rc = cxl_ops->adapter_reset(adapter);


Readability could be improved, rc meaning seems overloaded.
Also, if the adapter_reset callback fails, we need to reset the count.


   Fred


> +
> +	return rc ? rc : count;
>  }
>
>  static ssize_t load_image_on_perst_show(struct device *device,
>
