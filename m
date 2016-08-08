Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s79Gn1FHKzDqS5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 18:16:17 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s79Gm3wwPz9sDf
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Aug 2016 18:16:16 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u788Eu9K017245
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Aug 2016 04:16:14 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24n8txef9p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 08 Aug 2016 04:16:13 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Mon, 8 Aug 2016 13:46:10 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7E4B4E0061
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Aug 2016 13:50:26 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u788G1eJ36307044
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Aug 2016 13:46:01 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u788Fvbx003871
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Aug 2016 13:46:00 +0530
Subject: Re: [RESEND][PATCH v2 2/2] powerpc/fadump: parse fadump reserve
 memory size based on memory range
To: Michael Ellerman <mpe@ellerman.id.au>, rusty@rustcorp.com.au,
 ebiederm@xmission.com, vgoyal@redhat.com,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <147025270324.29229.8322429758761407397.stgit@hbathini.in.ibm.com>
 <147025281599.29229.9962999599360876220.stgit@hbathini.in.ibm.com>
 <87h9b0g953.fsf@concordia.ellerman.id.au>
 <ef95923f-56b6-b4f1-94a2-555f7df32629@linux.vnet.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec@lists.infradead.org,
 lkml <linux-kernel@vger.kernel.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Mon, 8 Aug 2016 13:45:50 +0530
MIME-Version: 1.0
In-Reply-To: <ef95923f-56b6-b4f1-94a2-555f7df32629@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <be3ba9ef-278e-63cd-8569-2d8228f83aac@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 05 August 2016 12:23 AM, Hari Bathini wrote:
>
> On Thursday 04 August 2016 03:15 PM, Michael Ellerman wrote:
>> Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
>> ...
>>>   /**
>>>    * fadump_calculate_reserve_size(): reserve variable boot area 5% 
>>> of System RAM
>>>    *
>>> @@ -212,12 +262,17 @@ static inline unsigned long 
>>> fadump_calculate_reserve_size(void)
>>>   {
>>>       unsigned long size;
>>>   +    /* sets fw_dump.reserve_bootvar */
>>> +    parse_fadump_reserve_mem();
>>> +
>>>       /*
>>>        * Check if the size is specified through fadump_reserve_mem= 
>>> cmdline
>>>        * option. If yes, then use that.
>>>        */
>>>       if (fw_dump.reserve_bootvar)
>>>           return fw_dump.reserve_bootvar;
>>> +    else
>>> +        printk(KERN_INFO "fadump: calculating default boot size\n");
>>>         /* divide by 20 to get 5% of value */
>>>       size = memblock_end_of_DRAM() / 20;
>> The code already knows how to reserve 5% based on the size of the 
>> machine's
>> memory, as long as no commandline parameter is passed. So why can't we
>> just use that logic?
>
> Hi Michael,
>
> That is the default value reserved but not a good enough value for
> every case. It is a bit difficult to come up with a robust formula
> that works for every case as new kernel changes could make the
> values obsolete. But it won't be all that difficult to find values that
> work for different memory ranges for a given kernel version.
> Passing that as range based input with "fadump_reserve_mem"
> parameter would work for every memory configuration on a
> given system, which is what this patch is trying to provide..
>

Hi Michael,

You want me to add this to the changelog on respin?

Thanks
Hari

> Thanks
> Hari
>
>
>> cheers
>>
>
