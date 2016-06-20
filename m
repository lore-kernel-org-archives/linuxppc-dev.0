Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rY4M065bwzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 18:50:36 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5K8nS82079276
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 04:50:34 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23n29vrbup-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 04:50:33 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 18:50:31 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7CE3E3578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 18:50:28 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5K8oSXq2031934
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 18:50:28 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5K8oSMW005800
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 18:50:28 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, mrochs@linux.vnet.ibm.com, manoj@linux.vnet.ibm.com,
 imunsie@au1.ibm.com, Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: Re: [v6,
 1/2] cxl: Add mechanism for delivering AFU driver specific events
In-Reply-To: <1466086415-30586-1-git-send-email-felix@linux.vnet.ibm.com>
References: <1466086415-30586-1-git-send-email-felix@linux.vnet.ibm.com>
Date: Mon, 20 Jun 2016 14:20:16 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87k2hkgs6v.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Philippe,

Few points


Philippe Bergheaud <felix@linux.vnet.ibm.com> writes:

> +int cxl_unset_driver_ops(struct cxl_context *ctx)
> +{
> +	if (atomic_read(&ctx->afu_driver_events))
> +		return -EBUSY;
> +
> +	ctx->afu_driver_ops = NULL;
Need a write memory barrier so that afu_driver_ops isnt possibly called
after this store.

>  
> -static inline int ctx_event_pending(struct cxl_context *ctx)
> +static ssize_t afu_driver_event_copy(struct cxl_context *ctx,
> +				     char __user *buf,
> +				     struct cxl_event *event,
> +				     struct cxl_event_afu_driver_reserved *pl)
>  {
> -	return (ctx->pending_irq || ctx->pending_fault ||
> -	    ctx->pending_afu_err || (ctx->status == CLOSED));
> +	/* Check data size */
> +	if (!pl || (pl->data_size > CXL_MAX_EVENT_DATA_SIZE)) {
> +		ctx->afu_driver_ops->event_delivered(ctx, pl, -EINVAL);
> +		return -EFAULT;
> +	}
Should also check against the length of user-buffer (count) provided in the read
call.Ideally this condition check should be moved to the read call where
you have access to the count variable.

Right now libcxl is using a harcoded value of CXL_READ_MIN_SIZE to
issue the read call and in kernel code we have a check to ensure that
read buffer is atleast CXL_READ_MIN_SIZE in size.

But it might be a good idea to decouple driver from
CXL_MAX_EVENT_DATA_SIZE. Ideally the maximum event size that we can
support should be dependent on the amount user buffer we receive in the
read call. That way future libcxl can support larger event_data without
needing a change to the cxl.h


> diff --git a/include/uapi/misc/cxl.h b/include/uapi/misc/cxl.h
> index 8cd334f..4fa36e4 100644
> --- a/include/uapi/misc/cxl.h
> +++ b/include/uapi/misc/cxl.h
> @@ -93,6 +93,7 @@ enum cxl_event_type {
>  	CXL_EVENT_AFU_INTERRUPT = 1,
>  	CXL_EVENT_DATA_STORAGE  = 2,
>  	CXL_EVENT_AFU_ERROR     = 3,
> +	CXL_EVENT_AFU_DRIVER    = 4,
>  };
>  
>  struct cxl_event_header {
> @@ -124,12 +125,32 @@ struct cxl_event_afu_error {
>  	__u64 error;
>  };
>  
> +#define CXL_MAX_EVENT_DATA_SIZE 128
> +

Agree with Matt's earlier comments. 128 is very small and I would prefer
for atleast a page size (4k/64K) limit.

Cheers,
~ Vaibhav
