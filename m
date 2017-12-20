Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1vlj2GqyzDsF6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 23:51:12 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBKCnluW076179
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 07:51:09 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eyjpypp2x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 07:51:09 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Wed, 20 Dec 2017 12:51:07 -0000
Subject: Re: [PATCH V4] cxl: Add support for ASB_Notify on POWER9
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 fbarrat@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
References: <1513704438-28958-1-git-send-email-clombard@linux.vnet.ibm.com>
 <871sjpap1e.fsf@vajain21.in.ibm.com>
 <9070c615-209d-d12f-7c40-f4c2a01c50a2@linux.vnet.ibm.com>
 <87y3lx9489.fsf@vajain21.in.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Wed, 20 Dec 2017 13:51:02 +0100
MIME-Version: 1.0
In-Reply-To: <87y3lx9489.fsf@vajain21.in.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <17bdbcb0-d986-be10-a60b-959c105c4374@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 20/12/2017 à 09:46, Vaibhav Jain a écrit :
> Hi Chritophe,
> 
> christophe lombard <clombard@linux.vnet.ibm.com> writes:
> 
>> Le 20/12/2017 à 07:31, Vaibhav Jain a écrit :
>>> EINVAL might be a better return value instead of ENODEV in this case.
>>
>> This return code has been already discussed (with mpe) on the first
>> version of the patch. "Either ENODEV or ENXIO would be best that
>> can be distinguished and interpreted correctly by userspace"
> Agreed. Please ignore the review comment.
> 
>>>> +	/* Assign a unique TIDR (thread id) for the current thread */
>>>> +	if (work.flags & CXL_START_WORK_TID) {
>>>> +		rc = cxl_context_thread_tidr(ctx);
>>>> +		if (rc)
>>>> +			goto out;
>>> May need to copy the cxl_ioctl_start_work struct back to userspace with
>>> the value of tidr allocated.
>>>
>>
>> In fact, it does not matter. I don't know what the userspace could do
>> with this value.
> Without libcxl knowing the tidr value, it cannot enforce the condition
> that only threads that have called attach can issue 'wait' on the right
> context.
> 
> Also AFU can selectively ask PSL to issue asb_notify to a specific
> thread via the PSL interface. Without userspace knowing the tidr value
> it might not be easy for it to give this value to AFU through a Problem
> State Area register.
> 

Don't forget that The ASB_Notify will use LPID:PID:TID tuple found
in the Process Element Entry.
The AFU may optionally provide a TID on AxH_CEA[40:55] (AxH_CEA[39]
must be set to indicate an AFU provided TID)
If AxH_CEA[39] == 1’b0 then Process Element information
(LPID:PID:TID) is used to generate the PCIe address.
If AxH_CEA[39] == 1’b1then the LPID:PID are taken from the PEE
while the TID is taken from AxH_-CEA[40:55]


>>>> +	}
>>>> +
>>>>    	trace_cxl_attach(ctx, work.work_element_descriptor,
>>>> work.num_interrupts, amr);
>>> should update the tracing here to also report the tidr
>>>
>>
>> yep. I will provide a new patch to include this update.
> Thanks
> 
