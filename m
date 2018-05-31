Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xFFC2xyRzDrph
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 14:42:39 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4V4eS6Q005134
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 00:42:37 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ja5gg903f-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 00:42:36 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 31 May 2018 05:42:34 +0100
Subject: Re: [PATCH v5 5/7] ocxl: Expose the thread_id needed for wait on
 POWER9
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
 vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
 sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
 gregkh@linuxfoundation.org, arnd@arndb.de, fbarrat@linux.vnet.ibm.com,
 corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180511061303.10728-1-alastair@au1.ibm.com>
 <20180511061303.10728-6-alastair@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 31 May 2018 14:42:28 +1000
MIME-Version: 1.0
In-Reply-To: <20180511061303.10728-6-alastair@au1.ibm.com>
Message-Id: <fc2184c1-eb0f-0116-8565-b2eac4354379@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/05/18 16:13, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> In order to successfully issue as_notify, an AFU needs to know the TID
> to notify, which in turn means that this information should be
> available in userspace so it can be communicated to the AFU.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Comments below.

> +#ifdef CONFIG_PPC64
> +static long afu_ioctl_enable_p9_wait(struct ocxl_context *ctx,
> +		struct ocxl_ioctl_p9_wait __user *uarg)
> +{
> +	struct ocxl_ioctl_p9_wait arg;
> +
> +	memset(&arg, 0, sizeof(arg));
> +
> +	if (cpu_has_feature(CPU_FTR_P9_TIDR)) {
> +		enum ocxl_context_status status;
> +
> +		// Locks both status & tidr
> +		mutex_lock(&ctx->status_mutex);
> +		if (!ctx->tidr) {
> +			if (set_thread_tidr(current))
> +				return -ENOENT;
> +
> +			ctx->tidr = current->thread.tidr;
> +		}
> +
> +		status = ctx->status;
> +		mutex_unlock(&ctx->status_mutex);
> +
> +		if (status == ATTACHED) {
> +			int rc;
> +			struct link *link = ctx->afu->fn->link;
> +
> +			rc = ocxl_link_update_pe(link, ctx->pasid, ctx->tidr);
> +			if (rc)
> +				return rc;
> +		}
> +
> +		arg.thread_id = ctx->tidr;
> +	} else
> +		return -ENOENT;

I didn't pick this up before - please please please use braces on both 
sides of the if here.

> +
> +	if (copy_to_user(uarg, &arg, sizeof(arg)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +#endif

> diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
> index 51ccf76db293..9ff6ddc28e22 100644
> --- a/include/misc/ocxl.h
> +++ b/include/misc/ocxl.h
> @@ -188,6 +188,15 @@ extern int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
>   		void (*xsl_err_cb)(void *data, u64 addr, u64 dsisr),
>   		void *xsl_err_data);
>   
> +/**
> + * Update values within a Process Element
> + *
> + * link_handle: the link handle associated with the process element
> + * pasid: the PASID for the AFU context
> + * tid: the new thread id for the process element
> + */
> +extern int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid);

My earlier comment about __u16 vs u16 applies for this declaration (and 
the body declaration) as well

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
