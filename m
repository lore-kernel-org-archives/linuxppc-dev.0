Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjQ1B43y2zDqLf
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 20:35:10 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v57AYL2l138105
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Jun 2017 06:35:08 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2axf12j6ga-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Jun 2017 06:35:07 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Wed, 7 Jun 2017 04:35:06 -0600
Subject: Re: [PATCH v9 07/10] powerpc/perf: PMU functions for Core IMC and
 hotplugging
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, ego@linux.vnet.ibm.com,
 bsingharora@gmail.com, anton@samba.org, sukadev@linux.vnet.ibm.com,
 mikey@neuling.org, stewart@linux.vnet.ibm.com, dja@axtens.net,
 eranian@google.com, hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com
References: <1496665922-702-1-git-send-email-anju@linux.vnet.ibm.com>
 <1496665922-702-2-git-send-email-anju@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1706061135490.1885@nanos>
 <692e037d-5367-208f-ac6f-8fd43e1643ba@linux.vnet.ibm.com>
Date: Wed, 7 Jun 2017 16:04:57 +0530
MIME-Version: 1.0
In-Reply-To: <692e037d-5367-208f-ac6f-8fd43e1643ba@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <81a85e3c-2c29-a0d5-3ae6-3e72e1090447@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 07 June 2017 11:14 AM, Anju T Sudhakar wrote:
> Hi Thomas,
>
> On Tuesday 06 June 2017 03:39 PM, Thomas Gleixner wrote:
>> On Mon, 5 Jun 2017, Anju T Sudhakar wrote:
>>> +static void cleanup_all_core_imc_memory(struct imc_pmu *pmu_ptr)
>>> +{
>>> +    struct imc_mem_info *ptr = pmu_ptr->mem_info;
>>> +
>>> +    if (!ptr)
>>> +        return;
>> That's pointless.
>
> No, it is not.  We may end up here from imc_mem_init() when the memory 
> allocation for
> pmu_ptr->mem_info fails. So in that case we can just return from here, 
> and kfree wont be
> called with a NULL pointer.
>
>>> +    for (; ptr; ptr++) {
>>        for (ptr = pmu_ptr->mem_info; ptr; ptr++) {
>>
>> will do the right thing.

Sorry, replied too soon on this. You are right, with this we can remove 
the if (!ptr) check.
thanks.
>>
>>> +        if (ptr->vbase[0] != 0)
>>> +            free_pages(ptr->vbase[0], 0);
>>> +    }
>> and kfree can be called with a NULL pointer.
>>

Yes right.

Regards,
Anju
