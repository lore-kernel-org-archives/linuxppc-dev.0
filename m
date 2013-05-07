Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BE5CD2C0117
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 12:43:54 +1000 (EST)
Message-ID: <51886A59.80807@windriver.com>
Date: Tue, 7 May 2013 10:43:37 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interrupts
References: <1367892390.3398.12@snotra>
In-Reply-To: <1367892390.3398.12@snotra>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/07/2013 10:06 AM, Scott Wood wrote:
> On 05/06/2013 08:56:25 PM, tiejun.chen wrote:
>> On 05/07/2013 07:50 AM, Scott Wood wrote:
>>> On 05/05/2013 10:13:17 PM, tiejun.chen wrote:
>>>> On 05/06/2013 11:10 AM, Tiejun Chen wrote:
>>>>> For the external interrupt, the decrementer exception and the doorbell
>>>>> excpetion, we also need to soft-disable interrupts while doing as host
>>>>> interrupt handlers since the DO_KVM hook is always performed to skip
>>>>> EXCEPTION_COMMON then miss this original chance with the 'ints'
>>>>> (INTS_DISABLE).
>>>
>>> http://patchwork.ozlabs.org/patch/241344/
>>> http://patchwork.ozlabs.org/patch/241412/
>>>
>>> :-)
>>
>> I'm observing the same behaviour as well:
>>
>>     WARN_ON_ONCE(!irqs_disabled());
>
> So, could you explain the benefits of your approach over what's being discussed
> in those threads?

They're a long thread so I think I need to take time to see :)

>
>>> Why wouldn't we always disable them?  kvmppc_handle_exit() will enable
>>> interrupts when it's ready.
>>
>> This only disable soft interrupt for kvmppc_restart_interrupt() that restarts
>> interrupts if they were meant for the host:
>>
>> a. SOFT_DISABLE_INTS() only for BOOKE_INTERRUPT_EXTERNAL |
>> BOOKE_INTERRUPT_DECREMENTER | BOOKE_INTERRUPT_DOORBELL
>
> Those aren't the only exceptions that can end up going to the host.  We could
> get a TLB miss that results in a heavyweight MMIO exit, etc.

This is like host handler, so I'm just disabling soft interrupt during 
kvmppc_restart_interrupt() for Doorbell interrupt/Decrementer Interrupt/External 
Input Interrupt.

I don't see anything should be disabled for any TLB exception in host handler.

>
> And I'd rather see any fix for this problem stay out of the asm code.

We already have an appropriate SOFT_DISABLE_INTS so I think we can take this 
easily :)

>
>> b. bl      kvmppc_handle_exit
>>
>> c. kvmppc_handle_exit()
>> {
>>         int r = RESUME_HOST;
>>         int s;
>>
>>         /* update before a new last_exit_type is rewritten */
>>         kvmppc_update_timing_stats(vcpu);
>>
>>         /* restart interrupts if they were meant for the host */
>>         kvmppc_restart_interrupt(vcpu, exit_nr);
>>
>>         local_irq_enable();    ==> Enable again.
>> ....
>>
>> And shouldn't we handle kvmppc_restart_interrupt() like the original HOST flow?
>>
>> #define MASKABLE_EXCEPTION(trapnum, intnum, label, hdlr, ack)           \
>>         START_EXCEPTION(label);                                         \
>>         NORMAL_EXCEPTION_PROLOG(trapnum, intnum, PROLOG_ADDITION_MASKABLE)\
>>         EXCEPTION_COMMON(trapnum, PACA_EXGEN, *INTS_DISABLE*)             \
>>     ...
>
> Could you elaborate on what you mean?

In host handler, we always use MASKABLE_EXCEPTION() to define-to-handle some 
exceptions: Doorbell interrupt/Decrementer Interrupt/External Input Interrupt:

#define MASKABLE_EXCEPTION(trapnum, intnum, label, hdlr, ack)           \
         START_EXCEPTION(label);                                         \
         NORMAL_EXCEPTION_PROLOG(trapnum, intnum, PROLOG_ADDITION_MASKABLE)\
         EXCEPTION_COMMON(trapnum, PACA_EXGEN, *INTS_DISABLE*)             \

This would call INTS_DISABLE, which is equal to SOFT_DISABLE_INTS(), to disable 
soft interrupt before call all associated handlers: 
do_IRQ()/timer_interrupt()/doorbell_exception().

But DO_KVM hook always skips INTS_DISABLE.

So I think we also need to do INTS_DISABLE for kvmppc_restart_interrupt() since 
actually that restarts interrupts for the host with a similar way as they are 
called by host.

Tiejun
