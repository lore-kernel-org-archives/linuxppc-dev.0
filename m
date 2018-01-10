Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGqxz401tzF0j7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 00:44:54 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0ADiT3v051556
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 08:44:51 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fdg66u4qv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 08:44:51 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 10 Jan 2018 13:44:49 -0000
Subject: Re: [PATCH V6] cxl: Add support for ASB_Notify on POWER9
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, vaibhav@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
References: <1515513430-23959-1-git-send-email-clombard@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 10 Jan 2018 14:44:45 +0100
MIME-Version: 1.0
In-Reply-To: <1515513430-23959-1-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1db6666e-8469-ba9c-4eca-e589c23a78d3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christophe,


Couple of comments about file.c, the rest of the patch looks ok to me.


> @@ -193,6 +194,7 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
>   		amr = work.amr & mfspr(SPRN_UAMOR);
> 
>   	ctx->mmio_err_ff = !!(work.flags & CXL_START_WORK_ERR_FF);
> +	ctx->wflags = work.flags;


I would prefer to add a	boolean "need to allocate a TID" to the context 
instead of saving the full user land flags, that seems more in-line with 
the existing code.


>   	/*
>   	 * Increment the mapped context count for adapter. This also checks
> @@ -263,6 +265,12 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
>   		goto out;
>   	}
> 
> +	if (work.flags & CXL_START_WORK_TID) {
> +		work.tid = ctx->tidr;
> +		if (copy_to_user(uwork, &work, sizeof(work)))
> +			return -EFAULT;
> +	}
> +

In case of error writing the TID value to user space, we still need to 
release the mutex and mark the context as STARTED.

   Fred


>   	ctx->status = STARTED;
>   	rc = 0;
>   out:
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> index 02b6b45..0cccf27 100644
> --- a/drivers/misc/cxl/native.c
> +++ b/drivers/misc/cxl/native.c
> @@ -16,6 +16,7 @@
>   #include <linux/uaccess.h>
>   #include <linux/delay.h>
>   #include <asm/synch.h>
> +#include <asm/switch_to.h>
>   #include <misc/cxl-base.h>
> 
>   #include "cxl.h"
> @@ -655,6 +656,7 @@ static void update_ivtes_directed(struct cxl_context *ctx)
>   static int process_element_entry_psl9(struct cxl_context *ctx, u64 wed, u64 amr)
>   {
>   	u32 pid;
> +	int rc;
> 
>   	cxl_assign_psn_space(ctx);
> 
> @@ -673,7 +675,16 @@ static int process_element_entry_psl9(struct cxl_context *ctx, u64 wed, u64 amr)
>   		pid = ctx->mm->context.id;
>   	}
> 
> -	ctx->elem->common.tid = 0;
> +	/* Assign a unique TIDR (thread id) for the current thread */
> +	if (!(ctx->tidr) && (ctx->wflags & CXL_START_WORK_TID)) {
> +		rc = set_thread_tidr(current);
> +		if (rc)
> +			return -ENODEV;
> +		ctx->tidr = current->thread.tidr;
> +		pr_devel("%s: current tidr: %d\n", __func__, ctx->tidr);
> +	}
> +
> +	ctx->elem->common.tid = cpu_to_be32(ctx->tidr);
>   	ctx->elem->common.pid = cpu_to_be32(pid);
> 
>   	ctx->elem->sr = cpu_to_be64(calculate_sr(ctx));
> diff --git a/include/uapi/misc/cxl.h b/include/uapi/misc/cxl.h
> index 49e8fd0..56376d3 100644
> --- a/include/uapi/misc/cxl.h
> +++ b/include/uapi/misc/cxl.h
> @@ -20,20 +20,22 @@ struct cxl_ioctl_start_work {
>   	__u64 work_element_descriptor;
>   	__u64 amr;
>   	__s16 num_interrupts;
> -	__s16 reserved1;
> -	__s32 reserved2;
> +	__u16 tid;
> +	__s32 reserved1;
> +	__u64 reserved2;
>   	__u64 reserved3;
>   	__u64 reserved4;
>   	__u64 reserved5;
> -	__u64 reserved6;
>   };
> 
>   #define CXL_START_WORK_AMR		0x0000000000000001ULL
>   #define CXL_START_WORK_NUM_IRQS		0x0000000000000002ULL
>   #define CXL_START_WORK_ERR_FF		0x0000000000000004ULL
> +#define CXL_START_WORK_TID		0x0000000000000008ULL
>   #define CXL_START_WORK_ALL		(CXL_START_WORK_AMR |\
>   					 CXL_START_WORK_NUM_IRQS |\
> -					 CXL_START_WORK_ERR_FF)
> +					 CXL_START_WORK_ERR_FF |\
> +					 CXL_START_WORK_TID)
> 
> 
>   /* Possible modes that an afu can be in */
> 
