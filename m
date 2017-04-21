Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8Mf833pbzDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 14:08:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH v2] powerpc/book3s: mce: Move add_taint() later in virtual
 mode.
In-Reply-To: <874lxjbak1.fsf@possimpible.ozlabs.ibm.com>
References: <149253349689.12722.1516352063236500616.stgit@jupiter.in.ibm.com>
 <874lxjbak1.fsf@possimpible.ozlabs.ibm.com>
Date: Fri, 21 Apr 2017 14:07:57 +1000
Message-ID: <87r30mtnc2.fsf@concordia.ellerman.id.au>
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

Daniel Axtens <dja@axtens.net> writes:
>> diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
>> index a1475e6..b23b323 100644
>> --- a/arch/powerpc/kernel/mce.c
>> +++ b/arch/powerpc/kernel/mce.c
>> @@ -221,6 +221,8 @@ static void machine_check_process_queued_event(struct irq_work *work)
>>  {
>>  	int index;
>>  
>> +	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
>> +
> This bit makes sense...
>
>> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
>> index ff365f9..af97e81 100644
>> --- a/arch/powerpc/kernel/traps.c
>> +++ b/arch/powerpc/kernel/traps.c
>> @@ -741,6 +739,8 @@ void machine_check_exception(struct pt_regs *regs)
>>  
>>  	__this_cpu_inc(irq_stat.mce_exceptions);
>>  
>> +	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
>> +
>
> But this bit I'm not sure about.
>
> Isn't machine_check_exception called from asm in
> kernel/exceptions-64s.S? As in, it's called really early/in real mode?

It is called from there, in asm, but not from real mode AFAICS.

There's a call from machine_check_common(), we're already in virtual
mode there.

The other call is from unrecover_mce(), and both places that call that
do so via rfid, using PACAKMSR, which should turn on virtual mode.


But none of that really matters. The fundamental issue here is we can't
recursively call OPAL, that's what matters.

So if we were in OPAL and take an MCE, then we must not call OPAL again
from the MCE handler.

This fixes one case where we know that can happen, but AFAICS we are not
protected in general from it.

For example if we take an MCE in OPAL, decide it's not recoverable and
go to unrecover_mce(), that will call machine_check_exception() which
can then call OPAL via printk.

Or maybe there's a check in there somewhere that makes it OK, but it's
not clear to me.

cheers
