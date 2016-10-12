Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svLvJ75Y4zDsxG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 04:48:44 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3svLvJ32kDz9s65
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Oct 2016 04:48:44 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9CHhYvO001444
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Oct 2016 13:48:42 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 261qwsehfu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Oct 2016 13:48:42 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 12 Oct 2016 23:18:38 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 21BE3E005E
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Oct 2016 23:18:16 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9CHmZoV24248394
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Oct 2016 23:18:35 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9CHmXTv031085
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Oct 2016 23:18:34 +0530
Subject: Re: [PATCH] powerpc/fadump: Fix the race in crash_fadump().
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <147608098939.18363.6488762843827913560.stgit@jupiter.in.ibm.com>
 <87lgxw5vdx.fsf@concordia.ellerman.id.au>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Haren Myneni <hbabu@us.ibm.com>, Balbir Singh <bsingharora@gmail.com>,
 Anton Blanchard <anton@samba.org>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 12 Oct 2016 23:18:31 +0530
MIME-Version: 1.0
In-Reply-To: <87lgxw5vdx.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <8c44acaa-e72a-c66a-4e8e-d3518b8ba571@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/10/2016 04:22 PM, Michael Ellerman wrote:
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
> 
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> There are chances that multiple CPUs can call crash_fadump() simultaneously
>> and would start duplicating same info to vmcoreinfo ELF note section. This
>> causes makedumpfile to fail during kdump capture. One example is,
>> triggering dumprestart from HMC which sends system reset to all the CPUs at
>> once.
> ...
>> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
>> index b3a6633..2ed9d1c 100644
>> --- a/arch/powerpc/kernel/fadump.c
>> +++ b/arch/powerpc/kernel/fadump.c
>> @@ -402,8 +402,14 @@ void crash_fadump(struct pt_regs *regs, const char *str)
>>  {
>>  	struct fadump_crash_info_header *fdh = NULL;
>>  
>> -	if (!fw_dump.dump_registered || !fw_dump.fadumphdr_addr)
>> +	mutex_lock(&fadump_mutex);
> 
> What happens when a crashing CPU can't get the mutex and goes to sleep?

Got your point. I think I should use mutex_trylock() here. There is only
two reason crashing CPU can't get mutex, 1) Another CPU also crashing
that got the mutex and on its way to trigger fadump. OR 2) We are in
middle of fadump register/un-register, in which case we can just return
and go to normal panic.

Thanks,
-Mahesh.
