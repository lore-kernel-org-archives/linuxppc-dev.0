Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z243s2g37zDsSY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 06:05:44 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBKJ54OU185287
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 14:05:41 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2eyvv6thcj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 14:05:41 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 20 Dec 2017 19:05:39 -0000
Subject: Re: [PATCH V5] cxl: Add support for ASB_Notify on POWER9
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, vaibhav@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
References: <1513790844-27779-1-git-send-email-clombard@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 20 Dec 2017 20:05:35 +0100
MIME-Version: 1.0
In-Reply-To: <1513790844-27779-1-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d5a44740-a3d5-def3-8ec0-209d7e47c61e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> --- a/drivers/misc/cxl/file.c
> +++ b/drivers/misc/cxl/file.c
> @@ -173,7 +173,7 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
>   	 * flags are set it's invalid
>   	 */
>   	if (work.reserved1 || work.reserved2 || work.reserved3 ||
> -	    work.reserved4 || work.reserved5 || work.reserved6 ||
> +	    work.reserved4 || work.reserved5 ||
>   	    (work.flags & ~CXL_START_WORK_ALL)) {
>   		rc = -EINVAL;
>   		goto out;
> @@ -248,7 +248,19 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
>   	 */
>   	smp_mb();
> 
> -	trace_cxl_attach(ctx, work.work_element_descriptor, work.num_interrupts, amr);
> +	/* Assign a unique TIDR (thread id) for the current thread */
> +	if (work.flags & CXL_START_WORK_TID) {
> +		rc = cxl_context_thread_tidr(ctx);
> +		if (rc)

We're already pretty deep and have allocated quite a few resources, we 
we'd need to unwind (see error path below when the attach fails).

However, we cannot clear the thread TIDR register, so we need to be 
careful that a user process cannot exhaust our limited pool of TIDs by 
calling the attach ioctl with bogus arguments. Which should be easy to 
do: attach the max number of contexts, and keep calling attach!
So we're going to need to figure out something to prevent that (define a 
max allocation per context? with a value of 1 for now?)


> diff --git a/include/uapi/misc/cxl.h b/include/uapi/misc/cxl.h
> index 49e8fd0..3ea2d4b4 100644
> --- a/include/uapi/misc/cxl.h
> +++ b/include/uapi/misc/cxl.h
> @@ -20,20 +20,22 @@ struct cxl_ioctl_start_work {
>   	__u64 work_element_descriptor;
>   	__u64 amr;
>   	__s16 num_interrupts;
> -	__s16 reserved1;
> -	__s32 reserved2;
> +	__s16 tid;

Should probably be unsigned.

   Fred


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
