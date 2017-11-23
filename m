Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjPYh5PNxzDrZ7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 03:15:20 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vANGErKQ145355
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 11:15:17 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2edx7p170k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 11:15:16 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Thu, 23 Nov 2017 16:15:15 -0000
Subject: Re: [PATCH] cxl: Add support for ASB_Notify on POWER9
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 fbarrat@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
References: <1511435132-24020-1-git-send-email-clombard@linux.vnet.ibm.com>
 <873755jd24.fsf@vajain21.in.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Thu, 23 Nov 2017 17:15:12 +0100
MIME-Version: 1.0
In-Reply-To: <873755jd24.fsf@vajain21.in.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <04843932-0f56-6a4e-29c7-e614b6a8370c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 23/11/2017 à 15:16, Vaibhav Jain a écrit :
> Hi Christophe,
> 
> Few review comments:
> 
> Christophe Lombard <clombard@linux.vnet.ibm.com> writes:
>> +
>> +int cxl_context_thread_tidr(struct cxl_context *ctx, int assign)
>> +{
>> +	int rc = 0;
>> +
>> +	/* Clear any TIDR value assigned to the current thread */
>> +	if (!assign) {
>> +		clear_thread_tidr(current);
>> +		ctx->tid = 0;
>> +	} else {
>> +		/* Assign a unique TIDR (thread id) for the current thread */
>> +		rc = set_thread_tidr(current);
>> +		if (!rc)
>> +			ctx->tid = current->thread.tidr;
> set_thread_tidr can also return non-zero error values and will never
> return '0'. So this condition should be 'if(rc > 0)' instead of 'if (!rc)'

good point. Thanks for this.

> 
>> +#define CXL_IOCTL_GET_AFU_ID		_IOR(CXL_MAGIC, 0x02, struct cxl_afu_id)
>> +#define CXL_IOCTL_THREAD_TIDR		_IOR(CXL_MAGIC, 0x03,
>> int)
> Instead of adding a new syscall I think assiging a thread-id can be
> better done by adding a new flag to the cxl_ioctl_start_work.flag
> field and using one of the reserved fields to return the allocated tid
> back to the user.
> 

We have worked previously on this solution but this solution is too 
restrictive for now - we offer the possibility to configure and to clear
the tidr from user land - and for the future implementation.
