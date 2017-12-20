Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1pKC3QKZzF07m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 19:46:23 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBK8htWP119416
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 03:46:20 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eym62976j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 03:46:20 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Wed, 20 Dec 2017 08:46:19 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: christophe lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
Subject: Re: [PATCH V4] cxl: Add support for ASB_Notify on POWER9
In-Reply-To: <9070c615-209d-d12f-7c40-f4c2a01c50a2@linux.vnet.ibm.com>
References: <1513704438-28958-1-git-send-email-clombard@linux.vnet.ibm.com>
 <871sjpap1e.fsf@vajain21.in.ibm.com>
 <9070c615-209d-d12f-7c40-f4c2a01c50a2@linux.vnet.ibm.com>
Date: Wed, 20 Dec 2017 14:16:14 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <87y3lx9489.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Chritophe,

christophe lombard <clombard@linux.vnet.ibm.com> writes:

> Le 20/12/2017 =C3=A0 07:31, Vaibhav Jain a =C3=A9crit=C2=A0:
>> EINVAL might be a better return value instead of ENODEV in this case.
>
> This return code has been already discussed (with mpe) on the first
> version of the patch. "Either ENODEV or ENXIO would be best that
> can be distinguished and interpreted correctly by userspace"
Agreed. Please ignore the review comment.

>>> +	/* Assign a unique TIDR (thread id) for the current thread */
>>> +	if (work.flags & CXL_START_WORK_TID) {
>>> +		rc =3D cxl_context_thread_tidr(ctx);
>>> +		if (rc)
>>> +			goto out;
>> May need to copy the cxl_ioctl_start_work struct back to userspace with
>> the value of tidr allocated.
>>
>
> In fact, it does not matter. I don't know what the userspace could do
> with this value.
Without libcxl knowing the tidr value, it cannot enforce the condition
that only threads that have called attach can issue 'wait' on the right
context.

Also AFU can selectively ask PSL to issue asb_notify to a specific
thread via the PSL interface. Without userspace knowing the tidr value
it might not be easy for it to give this value to AFU through a Problem
State Area register.

>>> +	}
>>> +
>>>   	trace_cxl_attach(ctx, work.work_element_descriptor,
>>> work.num_interrupts, amr);
>> should update the tracing here to also report the tidr
>>=20
>
> yep. I will provide a new patch to include this update.
Thanks

--=20
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
