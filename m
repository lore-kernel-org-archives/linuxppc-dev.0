Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svnWt3H13zDsyX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 21:48:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>, Haren Myneni <hbabu@us.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc/fadump: Fix the race in crash_fadump().
In-Reply-To: <8c44acaa-e72a-c66a-4e8e-d3518b8ba571@linux.vnet.ibm.com>
References: <147608098939.18363.6488762843827913560.stgit@jupiter.in.ibm.com>
 <87lgxw5vdx.fsf@concordia.ellerman.id.au>
 <8c44acaa-e72a-c66a-4e8e-d3518b8ba571@linux.vnet.ibm.com>
Date: Thu, 13 Oct 2016 21:48:25 +1100
Message-ID: <87lgxsr0cm.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> writes:

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

mutex_trylock() is probably OK, though with DEBUG options on it might
still run a bunch of code, you don't want it to go and call into lockdep
for example.

Normally the advice is not to write your own locks, but in this case the
safest option might be just to do a cmpxchg() or something similarly
simple.

cheers
