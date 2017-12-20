Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1nt30lzQzF08h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 19:26:18 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBK8OMun118454
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 03:26:16 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eyk10b85c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 03:26:16 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Wed, 20 Dec 2017 08:26:14 -0000
Subject: Re: [PATCH V4] cxl: Add support for ASB_Notify on POWER9
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 fbarrat@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
References: <1513704438-28958-1-git-send-email-clombard@linux.vnet.ibm.com>
 <871sjpap1e.fsf@vajain21.in.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Wed, 20 Dec 2017 09:26:11 +0100
MIME-Version: 1.0
In-Reply-To: <871sjpap1e.fsf@vajain21.in.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <9070c615-209d-d12f-7c40-f4c2a01c50a2@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 20/12/2017 à 07:31, Vaibhav Jain a écrit :
> Hi Christophe,
> 
> Thanks for the changes to the patch. Few minor review comments:
>

Thanks for the review.

> Christophe Lombard <clombard@linux.vnet.ibm.com> writes:
> 
>> @@ -362,3 +363,17 @@ void cxl_context_mm_count_put(struct cxl_context *ctx)
>>   	if (ctx->mm)
>>   		mmdrop(ctx->mm);
>>   }
>> +
>> +int cxl_context_thread_tidr(struct cxl_context *ctx)
>> +{
>> +	int rc = 0;
>> +
>> +	if (!cxl_is_power9())
>> +		return -ENODEV;
> EINVAL might be a better return value instead of ENODEV in this case.

This return code has been already discussed (with mpe) on the first
version of the patch. "Either ENODEV or ENXIO would be best that
can be distinguished and interpreted correctly by userspace"

> 
>> --- a/drivers/misc/cxl/file.c
>> +++ b/drivers/misc/cxl/file.c
>> @@ -248,6 +248,13 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
>>   	 */
>>   	smp_mb();
>>
>> +	/* Assign a unique TIDR (thread id) for the current thread */
>> +	if (work.flags & CXL_START_WORK_TID) {
>> +		rc = cxl_context_thread_tidr(ctx);
>> +		if (rc)
>> +			goto out;
> May need to copy the cxl_ioctl_start_work struct back to userspace with
> the value of tidr allocated.
>

In fact, it does not matter. I don't know what the userspace could do
with this value.

>> +	}
>> +
>>   	trace_cxl_attach(ctx, work.work_element_descriptor,
>> work.num_interrupts, amr);
> should update the tracing here to also report the tidr
> 

yep. I will provide a new patch to include this update.

>> diff --git a/include/uapi/misc/cxl.h b/include/uapi/misc/cxl.h
>> index 49e8fd0..980ee8f 100644
>> --- a/include/uapi/misc/cxl.h
>> +++ b/include/uapi/misc/cxl.h
>> @@ -31,9 +31,11 @@ struct cxl_ioctl_start_work {
> Should reserve a field in the cxl_ioctl_start_work struct to report the
> tidr back to userspace.
> 
> 

We could do that, but as we discussed previously. We want to minimize
the impact on libcxl.
