Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjLwF71t5zDrZ7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 01:16:13 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vANEG9jB082258
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 09:16:10 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2edyparsu8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 09:16:10 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Thu, 23 Nov 2017 14:16:08 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
Subject: Re: [PATCH] cxl: Add support for ASB_Notify on POWER9
In-Reply-To: <1511435132-24020-1-git-send-email-clombard@linux.vnet.ibm.com>
References: <1511435132-24020-1-git-send-email-clombard@linux.vnet.ibm.com>
Date: Thu, 23 Nov 2017 19:46:03 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <873755jd24.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christophe,

Few review comments:

Christophe Lombard <clombard@linux.vnet.ibm.com> writes:
> +
> +int cxl_context_thread_tidr(struct cxl_context *ctx, int assign)
> +{
> +	int rc = 0;
> +
> +	/* Clear any TIDR value assigned to the current thread */
> +	if (!assign) {
> +		clear_thread_tidr(current);
> +		ctx->tid = 0;
> +	} else {
> +		/* Assign a unique TIDR (thread id) for the current thread */
> +		rc = set_thread_tidr(current);
> +		if (!rc)
> +			ctx->tid = current->thread.tidr;
set_thread_tidr can also return non-zero error values and will never
return '0'. So this condition should be 'if(rc > 0)' instead of 'if (!rc)'

> +#define CXL_IOCTL_GET_AFU_ID		_IOR(CXL_MAGIC, 0x02, struct cxl_afu_id)
> +#define CXL_IOCTL_THREAD_TIDR		_IOR(CXL_MAGIC, 0x03,
> int)
Instead of adding a new syscall I think assiging a thread-id can be
better done by adding a new flag to the cxl_ioctl_start_work.flag
field and using one of the reserved fields to return the allocated tid
back to the user.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
