Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 63CB62C0136
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 13:05:05 +1000 (EST)
Date: Mon, 6 May 2013 22:04:52 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interrupts
To: tiejun.chen <tiejun.chen@windriver.com>
In-Reply-To: <51886A59.80807@windriver.com> (from tiejun.chen@windriver.com
 on Mon May  6 21:43:37 2013)
Message-ID: <1367895892.3398.13@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
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

On 05/06/2013 09:43:37 PM, tiejun.chen wrote:
> On 05/07/2013 10:06 AM, Scott Wood wrote:
>> On 05/06/2013 08:56:25 PM, tiejun.chen wrote:
>>> On 05/07/2013 07:50 AM, Scott Wood wrote:
>>>> On 05/05/2013 10:13:17 PM, tiejun.chen wrote:
>>>>> On 05/06/2013 11:10 AM, Tiejun Chen wrote:
>>>>>> For the external interrupt, the decrementer exception and the =20
>>>>>> doorbell
>>>>>> excpetion, we also need to soft-disable interrupts while doing =20
>>>>>> as host
>>>>>> interrupt handlers since the DO_KVM hook is always performed to =20
>>>>>> skip
>>>>>> EXCEPTION_COMMON then miss this original chance with the 'ints'
>>>>>> (INTS_DISABLE).
>>>>=20
>>>> http://patchwork.ozlabs.org/patch/241344/
>>>> http://patchwork.ozlabs.org/patch/241412/
>>>>=20
>>>> :-)
>>>=20
>>> I'm observing the same behaviour as well:
>>>=20
>>>     WARN_ON_ONCE(!irqs_disabled());
>>=20
>> So, could you explain the benefits of your approach over what's =20
>> being discussed
>> in those threads?
>=20
> They're a long thread so I think I need to take time to see :)
>=20
>>=20
>>>> Why wouldn't we always disable them?  kvmppc_handle_exit() will =20
>>>> enable
>>>> interrupts when it's ready.
>>>=20
>>> This only disable soft interrupt for kvmppc_restart_interrupt() =20
>>> that restarts
>>> interrupts if they were meant for the host:
>>>=20
>>> a. SOFT_DISABLE_INTS() only for BOOKE_INTERRUPT_EXTERNAL |
>>> BOOKE_INTERRUPT_DECREMENTER | BOOKE_INTERRUPT_DOORBELL
>>=20
>> Those aren't the only exceptions that can end up going to the host.  =20
>> We could
>> get a TLB miss that results in a heavyweight MMIO exit, etc.
>=20
> This is like host handler, so I'm just disabling soft interrupt =20
> during kvmppc_restart_interrupt() for Doorbell interrupt/Decrementer =20
> Interrupt/External Input Interrupt.
>=20
> I don't see anything should be disabled for any TLB exception in host =20
> handler.

Every exception type needs consistent lazy EE state once we hit the =20
local_irq_enable() (or any other C code that cares).

Plus, if you're going to add code to make something conditional, you =20
should have a good reason for making it conditional.  Being more like =20
the 64-bit host handler for its own sake isn't good enough, especially =20
if you introduce differences between 32 and 64 bit in the process.

>> And I'd rather see any fix for this problem stay out of the asm code.
>=20
> We already have an appropriate SOFT_DISABLE_INTS so I think we can =20
> take this easily :)

An unconditional call to hard_irq_disable() at the beginning of =20
kvmppc_handle_exit() should suffice.  I already have this in the next =20
version of my patch that I'll be posting shortly.

Note that we need this on 32-bit as well, so that trace_hardirqs_off() =20
gets called.

-Scott=
