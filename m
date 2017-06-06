Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whmck2HMDzDqLQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 19:30:14 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v569EZkA050799
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Jun 2017 05:30:06 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2awq54y87h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Jun 2017 05:30:05 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 6 Jun 2017 10:30:04 +0100
Subject: Re: [PATCH] cxl: Fix error path on bad ioctl
To: Michael Ellerman <mpe@ellerman.id.au>, andrew.donnellan@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org, vaibhav@linux.vnet.ibm.com,
 clombard@linux.vnet.ibm.com, philippe.bergheaud@fr.ibm.com
References: <20170602161523.14052-1-fbarrat@linux.vnet.ibm.com>
 <878tl5qxpw.fsf@concordia.ellerman.id.au>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Tue, 6 Jun 2017 11:30:00 +0200
MIME-Version: 1.0
In-Reply-To: <878tl5qxpw.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <cd5831d7-9f74-928a-b5c8-a6e5622c8099@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 06/06/2017 à 11:20, Michael Ellerman a écrit :
> Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:
> 
>> Fix error path if we can't copy user structure on
>> CXL_IOCTL_START_WORK ioctl.
> 
> To be clear the error is that returning via the out label will unlock
> cxl->status_mutex, which has not been locked.
> 
> Please spell it out for me :)
> 
> This should be:
> 
>    Fixes: 0712dc7e73e5 ("cxl: Fix issues when unmapping contexts")
> 
> Am I right?


That's correct. I'm about to send a v2 to address Vaibhav's comment and 
I'll fix the above as well.

Thanks,

   Fred



> cheers
> 
>> diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
>> index 17b433f1ce23..caa44adfa60e 100644
>> --- a/drivers/misc/cxl/file.c
>> +++ b/drivers/misc/cxl/file.c
>> @@ -160,10 +160,8 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
>>   	/* Do this outside the status_mutex to avoid a circular dependency with
>>   	 * the locking in cxl_mmap_fault() */
>>   	if (copy_from_user(&work, uwork,
>> -			   sizeof(struct cxl_ioctl_start_work))) {
>> -		rc = -EFAULT;
>> -		goto out;
>> -	}
>> +			   sizeof(struct cxl_ioctl_start_work)))
>> +		return -EFAULT;
>>   
>>   	mutex_lock(&ctx->status_mutex);
>>   	if (ctx->status != OPENED) {
>> -- 
>> 2.11.0
> 
