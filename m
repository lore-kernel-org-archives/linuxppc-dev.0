Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sw82g6nKxzDt5k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 11:42:51 +1100 (AEDT)
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sw82g324Cz9sCZ
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Oct 2016 11:42:51 +1100 (AEDT)
Received: by mail-pa0-x242.google.com with SMTP id hh10so5392862pac.0
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Oct 2016 17:42:51 -0700 (PDT)
Subject: Re: [PATCH] powerpc/fadump: Fix the race in crash_fadump().
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <147608098939.18363.6488762843827913560.stgit@jupiter.in.ibm.com>
 <87lgxw5vdx.fsf@concordia.ellerman.id.au>
 <8c44acaa-e72a-c66a-4e8e-d3518b8ba571@linux.vnet.ibm.com>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Haren Myneni <hbabu@us.ibm.com>, Anton Blanchard <anton@samba.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <62282745-bf75-24df-d686-464bf58e05e8@gmail.com>
Date: Fri, 14 Oct 2016 11:42:45 +1100
MIME-Version: 1.0
In-Reply-To: <8c44acaa-e72a-c66a-4e8e-d3518b8ba571@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 13/10/16 04:48, Mahesh Jagannath Salgaonkar wrote:
> On 10/10/2016 04:22 PM, Michael Ellerman wrote:
>> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
>>
>>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>>
>>> There are chances that multiple CPUs can call crash_fadump() simultaneously
>>> and would start duplicating same info to vmcoreinfo ELF note section. This
>>> causes makedumpfile to fail during kdump capture. One example is,
>>> triggering dumprestart from HMC which sends system reset to all the CPUs at
>>> once.
>> ...
>>> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
>>> index b3a6633..2ed9d1c 100644
>>> --- a/arch/powerpc/kernel/fadump.c
>>> +++ b/arch/powerpc/kernel/fadump.c
>>> @@ -402,8 +402,14 @@ void crash_fadump(struct pt_regs *regs, const char *str)
>>>  {
>>>  	struct fadump_crash_info_header *fdh = NULL;
>>>  
>>> -	if (!fw_dump.dump_registered || !fw_dump.fadumphdr_addr)
>>> +	mutex_lock(&fadump_mutex);
>>
>> What happens when a crashing CPU can't get the mutex and goes to sleep?
> 
> Got your point. I think I should use mutex_trylock() here. There is only
> two reason crashing CPU can't get mutex, 1) Another CPU also crashing
> that got the mutex and on its way to trigger fadump. OR 2) We are in
> middle of fadump register/un-register, in which case we can just return
> and go to normal panic.

I think trylock is a good idea, but having said that not getting the lock
and having the CPU active will still lead to the same issue. 
I don't quite know the source of failure in makedumpfile but
should we fix makedumpfile to deal better with these issues?

Another option is to check to see if anyone started writing at the ELF
note section and have others bail out if they get there after the try
lock

Balbir Singh.
