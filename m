Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 953142C012A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 11:56:38 +1000 (EST)
Message-ID: <51885F49.6060605@windriver.com>
Date: Tue, 7 May 2013 09:56:25 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interrupts
References: <1367884257.3398.9@snotra>
In-Reply-To: <1367884257.3398.9@snotra>
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

On 05/07/2013 07:50 AM, Scott Wood wrote:
> On 05/05/2013 10:13:17 PM, tiejun.chen wrote:
>> On 05/06/2013 11:10 AM, Tiejun Chen wrote:
>>> For the external interrupt, the decrementer exception and the doorbell
>>> excpetion, we also need to soft-disable interrupts while doing as host
>>> interrupt handlers since the DO_KVM hook is always performed to skip
>>> EXCEPTION_COMMON then miss this original chance with the 'ints' (INTS_DISABLE).
>
> http://patchwork.ozlabs.org/patch/241344/
> http://patchwork.ozlabs.org/patch/241412/
>
> :-)

I'm observing the same behaviour as well:

	WARN_ON_ONCE(!irqs_disabled());

>
>>> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
>>> ---
>>>   arch/powerpc/kvm/bookehv_interrupts.S |    9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/arch/powerpc/kvm/bookehv_interrupts.S
>>> b/arch/powerpc/kvm/bookehv_interrupts.S
>>> index e8ed7d6..2fd62bf 100644
>>> --- a/arch/powerpc/kvm/bookehv_interrupts.S
>>> +++ b/arch/powerpc/kvm/bookehv_interrupts.S
>>> @@ -33,6 +33,8 @@
>>>
>>>   #ifdef CONFIG_64BIT
>>>   #include <asm/exception-64e.h>
>>> +#include <asm/hw_irq.h>
>>> +#include <asm/irqflags.h>
>>>   #else
>>>   #include "../kernel/head_booke.h" /* for THREAD_NORMSAVE() */
>>>   #endif
>>> @@ -469,6 +471,13 @@ _GLOBAL(kvmppc_resume_host)
>>>       PPC_LL    r3, HOST_RUN(r1)
>>>       mr    r5, r14 /* intno */
>>>       mr    r14, r4 /* Save vcpu pointer. */
>>> +#ifdef CONFIG_64BIT
>>> +    /* Should we soft-disable interrupts? */
>>> +    andi.    r6, r5, BOOKE_INTERRUPT_EXTERNAL | BOOKE_INTERRUPT_DECREMENTER
>>> | BOOKE_INTERRUPT_DOORBELL
>>> +    beq    skip_soft_dis
>>> +    SOFT_DISABLE_INTS(r7,r8)
>>> +skip_soft_dis:
>>> +#endif
>
> Why wouldn't we always disable them?  kvmppc_handle_exit() will enable
> interrupts when it's ready.

This only disable soft interrupt for kvmppc_restart_interrupt() that restarts 
interrupts if they were meant for the host:

a. SOFT_DISABLE_INTS() only for BOOKE_INTERRUPT_EXTERNAL | 
BOOKE_INTERRUPT_DECREMENTER | BOOKE_INTERRUPT_DOORBELL

b. bl      kvmppc_handle_exit

c. kvmppc_handle_exit()
{
         int r = RESUME_HOST;
         int s;

         /* update before a new last_exit_type is rewritten */
         kvmppc_update_timing_stats(vcpu);

         /* restart interrupts if they were meant for the host */
         kvmppc_restart_interrupt(vcpu, exit_nr);

         local_irq_enable();	==> Enable again.
....

And shouldn't we handle kvmppc_restart_interrupt() like the original HOST flow?

#define MASKABLE_EXCEPTION(trapnum, intnum, label, hdlr, ack)           \
         START_EXCEPTION(label);                                         \
         NORMAL_EXCEPTION_PROLOG(trapnum, intnum, PROLOG_ADDITION_MASKABLE)\
         EXCEPTION_COMMON(trapnum, PACA_EXGEN, *INTS_DISABLE*)             \
	...

So I think this should be reasonable :)

Tiejun
