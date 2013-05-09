Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0A4122C00E2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 May 2013 18:05:01 +1000 (EST)
Message-ID: <518B58A0.1030100@windriver.com>
Date: Thu, 9 May 2013 16:04:48 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Subject: Re: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interrupts
References: <51885F49.6060605@windriver.com> (from tiejun.chen@windriver.com
 on Mon May 6 20:56:25 2013) <1367892390.3398.12@snotra>
 <300B73AA675FCE4A93EB4FC1D42459FF3F00D0@039-SN2MPN1-013.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0700E50E@039-SN2MPN1-011.039d.mgd.msft.net>
 <518B54A6.1070505@windriver.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0700E563@039-SN2MPN1-011.039d.mgd.msft.net>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D0700E563@039-SN2MPN1-011.039d.mgd.msft.net>
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

On 05/09/2013 03:51 PM, Bhushan Bharat-R65777 wrote:
>
>
>> -----Original Message-----
>> From: tiejun.chen [mailto:tiejun.chen@windriver.com]
>> Sent: Thursday, May 09, 2013 1:18 PM
>> To: Bhushan Bharat-R65777
>> Cc: Caraman Mihai Claudiu-B02008; Wood Scott-B07421; linuxppc-
>> dev@lists.ozlabs.org; agraf@suse.de; kvm-ppc@vger.kernel.org;
>> kvm@vger.kernel.org
>> Subject: Re: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interrupts
>>
>> On 05/09/2013 03:33 PM, Bhushan Bharat-R65777 wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Linuxppc-dev [mailto:linuxppc-dev-
>>>> bounces+bharat.bhushan=freescale.com@lists.ozlabs.org] On Behalf Of
>>>> bounces+Caraman
>>>> Mihai Claudiu-B02008
>>>> Sent: Wednesday, May 08, 2013 6:44 PM
>>>> To: Wood Scott-B07421; tiejun.chen
>>>> Cc: linuxppc-dev@lists.ozlabs.org; agraf@suse.de;
>>>> kvm-ppc@vger.kernel.org; kvm@vger.kernel.org
>>>> Subject: RE: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable
>>>> interrupts
>>>>
>>>>>> This only disable soft interrupt for kvmppc_restart_interrupt()
>>>>>> that restarts interrupts if they were meant for the host:
>>>>>>
>>>>>> a. SOFT_DISABLE_INTS() only for BOOKE_INTERRUPT_EXTERNAL |
>>>>>> BOOKE_INTERRUPT_DECREMENTER | BOOKE_INTERRUPT_DOORBELL
>>>>>
>>>>> Those aren't the only exceptions that can end up going to the host.
>>>>> We could get a TLB miss that results in a heavyweight MMIO exit, etc.
>>>>>
>>>>>> And shouldn't we handle kvmppc_restart_interrupt() like the
>>>>>> original HOST flow?
>>>>>>
>>>>>> #define MASKABLE_EXCEPTION(trapnum, intnum, label, hdlr,
>>>>>> ack)           \
>>>>>>
>>>>>> START_EXCEPTION(label);                                         \
>>>>>>           NORMAL_EXCEPTION_PROLOG(trapnum, intnum,
>>>>>> PROLOG_ADDITION_MASKABLE)\
>>>>>>           EXCEPTION_COMMON(trapnum, PACA_EXGEN,
>>>>>> *INTS_DISABLE*)             \
>>>>>> 	...
>>>>>
>>>>> Could you elaborate on what you mean?
>>>>
>>>> I think Tiejun was saying that host has flags and replays only
>>>> EE/DEC/DBELL interrupts. There is special macro
>>>> masked_interrupt_book3e in those exception handlers that sets paca-
>>> irq_happened.
>>>>
>>>> The list of replied interrupts is limited to asynchronous noncritical
>>>> interrupts which can be masked by MSR[EE] (therefore no TLB miss).
>>>
>>> Embedded Perfmon interrupt is also asynchronous, Why that is not in the list
>> of masked interruts.
>>
>> Are you saying perfmon? If so, its also in that list:
>>
>>           START_EXCEPTION(perfmon);
>>           NORMAL_EXCEPTION_PROLOG(0x260, BOOKE_INTERRUPT_PERFORMANCE_MONITOR,
>>                                   PROLOG_ADDITION_NONE)
>>           EXCEPTION_COMMON(0x260, PACA_EXGEN, INTS_DISABLE)
>
> Where it is recorded in paca->irq_happned to be replayed later ?

In stead of PROLOG_ADDITION_MASKABLE, actually we have nothing to do with 
PROLOG_ADDITION_NONE for perfmon, so perfmon can be executed without lazy state.

Tiejun

>
>>
>> Tiejun
>>
>>>
>>> -Bharat
>>>
>>>> Now on KVM book3e we
>>>> don't want to put them in the irq_happened lazy state but rather to
>>>> execute them directly, so there is no reason for exception handling
>>>> symmetry between host and guest.
>>>>
>>>> -Mike
>>
>
