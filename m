Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTLlC46fwzDr38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 20:26:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, bauerman@linux.vnet.ibm.com,
 mhocko@kernel.org
Subject: Re: [RFC v7 24/25] powerpc: Deliver SEGV signal on pkey violation
In-Reply-To: <87378zkuil.fsf@linux.vnet.ibm.com>
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
 <1501459946-11619-25-git-send-email-linuxram@us.ibm.com>
 <87378zkuil.fsf@linux.vnet.ibm.com>
Date: Fri, 11 Aug 2017 20:26:30 +1000
Message-ID: <87a836csdl.fsf@concordia.ellerman.id.au>
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

Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> Ram Pai <linuxram@us.ibm.com> writes:
>
>> The value of the AMR register at the time of exception
>> is made available in gp_regs[PT_AMR] of the siginfo.
>>
>> The value of the pkey, whose protection got violated,
>> is made available in si_pkey field of the siginfo structure.
>
> Should the IAMR also be made available?
>
> Also, should the AMR and IAMR be accesible to userspace (e.g., to GDB)
> via ptrace and the core file?

Yes if they're part of the thread's context they should be accessible
via ptrace and in core files.

>> --- a/arch/powerpc/kernel/signal_32.c
>> +++ b/arch/powerpc/kernel/signal_32.c
>> @@ -500,6 +500,11 @@ static int save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
>>  				   (unsigned long) &frame->tramp[2]);
>>  	}
>>
>> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
>> +	if (__put_user(get_paca()->paca_amr, &frame->mc_gregs[PT_AMR]))
>> +		return 1;
>> +#endif /*  CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
>> +
>>  	return 0;
>>  }
>
> frame->mc_gregs[PT_AMR] has 32 bits, but paca_amr has 64 bits. Does this
> work as intended?

I don't understand why we are putting it in there at all?

Is there some special handling of the actual register on signals? I
haven't seen it. In which case the process can get the value of AMR by
reading the register. ??

cheers
