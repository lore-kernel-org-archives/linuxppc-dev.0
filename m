Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D51ED2C00DC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 May 2013 19:45:04 +1000 (EST)
Message-ID: <518B7014.1090508@windriver.com>
Date: Thu, 9 May 2013 17:44:52 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Subject: Re: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interrupts
References: <51885F49.6060605@windriver.com> (from tiejun.chen@windriver.com
 on Mon May 6 20:56:25 2013) <1367892390.3398.12@snotra>
 <300B73AA675FCE4A93EB4FC1D42459FF3F00D0@039-SN2MPN1-013.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0700E64A@039-SN2MPN1-011.039d.mgd.msft.net>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D0700E64A@039-SN2MPN1-011.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Wood Scott-B07421 <B07421@freescale.com>, "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/09/2013 04:23 PM, Bhushan Bharat-R65777 wrote:
>
>
>> -----Original Message-----
>> From: Linuxppc-dev [mailto:linuxppc-dev-
>> bounces+bharat.bhushan=freescale.com@lists.ozlabs.org] On Behalf Of Caraman
>> Mihai Claudiu-B02008
>> Sent: Wednesday, May 08, 2013 6:44 PM
>> To: Wood Scott-B07421; tiejun.chen
>> Cc: linuxppc-dev@lists.ozlabs.org; agraf@suse.de; kvm-ppc@vger.kernel.org;
>> kvm@vger.kernel.org
>> Subject: RE: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interrupts
>>
>>>> This only disable soft interrupt for kvmppc_restart_interrupt() that
>>>> restarts interrupts if they were meant for the host:
>>>>
>>>> a. SOFT_DISABLE_INTS() only for BOOKE_INTERRUPT_EXTERNAL |
>>>> BOOKE_INTERRUPT_DECREMENTER | BOOKE_INTERRUPT_DOORBELL
>>>
>>> Those aren't the only exceptions that can end up going to the host.
>>> We could get a TLB miss that results in a heavyweight MMIO exit, etc.
>>>
>>>> And shouldn't we handle kvmppc_restart_interrupt() like the original
>>>> HOST flow?
>>>>
>>>> #define MASKABLE_EXCEPTION(trapnum, intnum, label, hdlr,
>>>> ack)           \
>>>>
>>>> START_EXCEPTION(label);                                         \
>>>>          NORMAL_EXCEPTION_PROLOG(trapnum, intnum,
>>>> PROLOG_ADDITION_MASKABLE)\
>>>>          EXCEPTION_COMMON(trapnum, PACA_EXGEN,
>>>> *INTS_DISABLE*)             \
>>>> 	...
>>>
>>> Could you elaborate on what you mean?
>>
>> I think Tiejun was saying that host has flags and replays only EE/DEC/DBELL
>> interrupts. There is special macro masked_interrupt_book3e in those exception
>> handlers that sets paca->irq_happened.
>>
>> The list of replied interrupts is limited to asynchronous noncritical interrupts
>> which can be masked by MSR[EE] (therefore no TLB miss). Now on KVM book3e we
>> don't want to put them in the irq_happened lazy state but rather to execute them
>> directly, so there is no reason for exception handling symmetry between host and
>> guest.
>
>
> Another Question:
>
> The case is:
>

Actually in the case GS=1 even if EE=0, EXT/DEC/DBELL still occur as I recall.

> Case 1)
>   -> Local_irq_disable()  will set soft_enabled = 0
>   -> Now Externel interrupt happens, there we set PACA_IRQ_EE in irq_happened, Also clears EE in SRR1 and rfi. So interrupts are hard disabled. No more other interrupt gated by MSR.EE can happen. Looks like the idea here is to not let a device keep on inserting interrupt till the interrupt condition on device is cleared, right?

I don't understand "the interrupt condition on device is cleared" here.

I think regardless if you clear the device interrupt status, the system still 
receive a pending interrupt once EE or GS = 1.

>   -> local_irq_enable() - This checks that irq_happened is set, and replays

ret_from_except also check to replay.

>
> Now the case 2)
> Case 2)
> -> Local_irq_disable()  will set soft_enabled = 0
>   -> Now DEC interrupt happens. We set PACA_IRQ_DEC in irq_happened, But do not clear EE in SRR1 and rfi. So interrupts are not hard disabled.
>   -> Now say EE interrupt happens, there we set PACA_IRQ_EE in irq_happened, Also clears EE in SRR1 and rfi. So interrupts are hard disabled.
>   -> local_irq_enable() - This checks that irq_happened is set.
> IIUC, it replays only one interrupt? is not it?

After anyone is replayed in arch_local_irq_restore(), we will set soft/hard 
interrupt there:

set_soft_enabled(1);
__hard_irq_enable();

Then any pending interrupt can be executed now.

Additionally, ret_from_except probably check to replay all.

Tiejun
