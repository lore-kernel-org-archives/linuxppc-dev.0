Return-Path: <mukesh02@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMG3W1bMYzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 17:33:58 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1D6SbFc144053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 01:33:56 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28hxta2wgp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 01:33:56 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mukesh02@linux.vnet.ibm.com>;
 Mon, 13 Feb 2017 16:33:54 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E93002CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 17:33:51 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1D6XhDN26804256
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 17:33:51 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1D6XJgm031664
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 17:33:19 +1100
Subject: Re: [PATCH 1/2] powerpc/powernv/opal-dump : Handles opal_dump_info
 properly
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
References: <1480583289-6380-1-git-send-email-mukesh02@linux.vnet.ibm.com>
 <9be9fb54-9143-dfa0-5e8a-fdccde251627@linux.vnet.ibm.com>
From: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>
Date: Mon, 13 Feb 2017 12:02:54 +0530
MIME-Version: 1.0
In-Reply-To: <9be9fb54-9143-dfa0-5e8a-fdccde251627@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <c1c55d19-eaa2-bef6-552d-acdb955e9f2e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Micheal,

Can you please look at this patchset?

-Mukesh


On Tuesday 06 December 2016 12:07 PM, Mukesh Ojha wrote:
> Hi Michael,
>
> Can you please have a look at this patchset as there is no
>
> functional changes involve with this?
>
> Thanks,
> Mukesh
>
>
>
>
> On Thursday 01 December 2016 02:38 PM, Mukesh Ojha wrote:
>> Moves the return value check of 'opal_dump_info' to a proper place which
>> was previously unnecessarily filling all the dump info even on failure.
>>
>> Signed-off-by: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/platforms/powernv/opal-dump.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/opal-dump.c 
>> b/arch/powerpc/platforms/powernv/opal-dump.c
>> index 4c82782..ae32212 100644
>> --- a/arch/powerpc/platforms/powernv/opal-dump.c
>> +++ b/arch/powerpc/platforms/powernv/opal-dump.c
>> @@ -225,13 +225,16 @@ static int64_t dump_read_info(uint32_t 
>> *dump_id, uint32_t *dump_size, uint32_t *
>>       if (rc == OPAL_PARAMETER)
>>           rc = opal_dump_info(&id, &size);
>>
>> +    if (rc) {
>> +        pr_warn("%s: Failed to get dump info (%d)\n",
>> +            __func__, rc);
>> +        return rc;
>> +    }
>> +
>>       *dump_id = be32_to_cpu(id);
>>       *dump_size = be32_to_cpu(size);
>>       *dump_type = be32_to_cpu(type);
>>
>> -    if (rc)
>> -        pr_warn("%s: Failed to get dump info (%d)\n",
>> -            __func__, rc);
>>       return rc;
>>   }
>>
>
