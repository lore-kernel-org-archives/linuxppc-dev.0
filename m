Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCTwD4knPzDr4T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 23:01:32 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/3] powerpc/watchdog: Print the NIP in
 soft_nmi_interrupt()
In-Reply-To: <20171012181856.3d88a5d9@roar.ozlabs.ibm.com>
References: <1507783474-28210-1-git-send-email-mpe@ellerman.id.au>
 <1507783474-28210-3-git-send-email-mpe@ellerman.id.au>
 <20171012181856.3d88a5d9@roar.ozlabs.ibm.com>
Date: Thu, 12 Oct 2017 23:01:31 +1100
Message-ID: <87tvz4tw10.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> On Thu, 12 Oct 2017 15:44:34 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> When a CPU detects its locked up via soft_nmi_interrupt() we have
>> pt_regs, so print the regs->nip, which points to where we took the
>> soft-NMI.
>> 
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>  arch/powerpc/kernel/watchdog.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
>> index 2494cbe34132..4594ba0979e4 100644
>> --- a/arch/powerpc/kernel/watchdog.c
>> +++ b/arch/powerpc/kernel/watchdog.c
>> @@ -235,7 +235,7 @@ void soft_nmi_interrupt(struct pt_regs *regs)
>>  		}
>>  		set_cpu_stuck(cpu, tb);
>>  
>> -		pr_emerg("CPU %d self-detected hard LOCKUP\n", cpu);
>> +		pr_emerg("CPU %d self-detected hard LOCKUP @ %pS\n", cpu, (void *)regs->nip);
>>  		print_modules();
>>  		print_irqtrace_events(current);
>>  		show_regs(regs);
>
> These patches all look fine to me, but we should be printing nip
> with show_regs, so why here too?

Because we can? :)

But maybe it's overkill.

We also have issues with loglevels, where sometimes you don't see the
regs, and just the EMERG lines, so it helps then.

But possibly we should fix that by making show_regs() EMERG, though
other arches don't seem to.

cheers
