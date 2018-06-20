Return-Path: <alastair@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419SDq2jLTzF0kx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 11:39:36 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5K1dMnt132058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 21:39:33 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jq71h5fjd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 21:39:33 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Wed, 20 Jun 2018 02:39:32 +0100
Subject: Re: [PATCH] ocxl: Fix page fault handler in case of fault on dying
 process
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>, andrew.donnellan@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Cc: clombard@linux.ibm.com, vaibhav@linux.ibm.com
Date: Wed, 20 Jun 2018 11:39:24 +1000
In-Reply-To: <20180618121436.20479-1-fbarrat@linux.ibm.com>
References: <20180618121436.20479-1-fbarrat@linux.ibm.com>
Mime-Version: 1.0
Message-Id: <2590ccd230153b95aabb8e9e6a2335915448780a.camel@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-06-18 at 14:14 +0200, Frederic Barrat wrote:
> If a process exits without doing proper cleanup, there's a window
> where an opencapi device can try to access the memory of the dying
> process and may trigger a page fault. That's an expected scenario and
> the ocxl driver holds a reference on the mm_struct of the process
> until the opencapi device is notified of the process exiting.
> However, if mm_users is already at 0, i.e. the address space of the
> process has already been destroyed, the driver shouldn't try
> resolving
> the page fault, as it will fail, but it can also try accessing
> already
> freed data.
> 
> It is fixed by only calling the bottom half of the page fault handler
> if mm_users is greater than 0 and get a reference on mm_users instead
> of mm_count. Otherwise, we can safely return a translation fault to
> the device, as its associated memory context is being removed. The
> opencapi device will be properly cleaned up shortly after when
> closing
> the file descriptors.
> 
> Fixes: 5ef3166e8a32 ("ocxl: Driver code for 'generic' opencapi
> devices")
> Cc: stable@vger.kernel.org # v4.16+
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> ---
>  drivers/misc/ocxl/link.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
> index f30790582dc0..2aeaf34e7eda 100644
> --- a/drivers/misc/ocxl/link.c
> +++ b/drivers/misc/ocxl/link.c
> @@ -136,7 +136,7 @@ static void xsl_fault_handler_bh(struct
> work_struct *fault_work)
>  	int rc;
>  
>  	/*
> -	 * We need to release a reference on the mm whenever exiting
> this
> +	 * We must release a reference on mm_users whenever exiting
> this
>  	 * function (taken in the memory fault interrupt handler)
>  	 */
>  	rc = copro_handle_mm_fault(fault->pe_data.mm, fault->dar,
> fault->dsisr,
> @@ -172,7 +172,7 @@ static void xsl_fault_handler_bh(struct
> work_struct *fault_work)
>  	}
>  	r = RESTART;
>  ack:
> -	mmdrop(fault->pe_data.mm);
> +	mmput(fault->pe_data.mm);
>  	ack_irq(spa, r);
>  }
>  
> @@ -184,6 +184,7 @@ static irqreturn_t xsl_fault_handler(int irq,
> void *data)
>  	struct pe_data *pe_data;
>  	struct ocxl_process_element *pe;
>  	int lpid, pid, tid;
> +	bool schedule = false;
>  
>  	read_irq(spa, &dsisr, &dar, &pe_handle);
>  	trace_ocxl_fault(spa->spa_mem, pe_handle, dsisr, dar, -1);
> @@ -226,14 +227,19 @@ static irqreturn_t xsl_fault_handler(int irq,
> void *data)
>  	}
>  	WARN_ON(pe_data->mm->context.id != pid);
>  
> -	spa->xsl_fault.pe = pe_handle;
> -	spa->xsl_fault.dar = dar;
> -	spa->xsl_fault.dsisr = dsisr;
> -	spa->xsl_fault.pe_data = *pe_data;
> -	mmgrab(pe_data->mm); /* mm count is released by bottom half
> */
> -
> +	if (mmget_not_zero(pe_data->mm)) {
> +			spa->xsl_fault.pe = pe_handle;
> +			spa->xsl_fault.dar = dar;
> +			spa->xsl_fault.dsisr = dsisr;
> +			spa->xsl_fault.pe_data = *pe_data;
> +			schedule = true;
> +			/* mm_users count released by bottom half */
> +	}
>  	rcu_read_unlock();
> -	schedule_work(&spa->xsl_fault.fault_work);
> +	if (schedule)
> +		schedule_work(&spa->xsl_fault.fault_work);
> +	else
> +		ack_irq(spa, ADDRESS_ERROR);
>  	return IRQ_HANDLED;
>  }
>  

Reviewed-By: Alastair D'Silva <alastair@d-silva.org>

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
