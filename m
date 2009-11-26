Return-Path: <albert_herranz@yahoo.es>
Received: from smtp127.mail.ukl.yahoo.com (smtp127.mail.ukl.yahoo.com
	[77.238.184.58]) by ozlabs.org (Postfix) with SMTP id 561A31007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 09:05:41 +1100 (EST)
Message-ID: <4B0EFBB2.9090206@yahoo.es>
Date: Thu, 26 Nov 2009 23:05:38 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 11/19] powerpc: gamecube/wii: flipper interrupt
	controller support
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<8E6E11A2-25F1-4AB8-B42E-58C269018CD2@kernel.crashing.org>
	<4B0D65C5.8090304@yahoo.es>
	<7556BF73-5D6D-4817-A02F-3DFA05E9AC58@kernel.crashing.org>
In-Reply-To: <7556BF73-5D6D-4817-A02F-3DFA05E9AC58@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>>> Maybe using FLIPPER (or GAMECUBE_FLIPPER) instead of GAMECUBE_COMMON
>>> is a good name?
>>
>> I'd prefer to not use a name that implies a specific hardware to
>> describe two (mostly) similar but different hardwares.
> 
> Hollywood is 100% compatible to Flipper though.
> 

No. There's no ARAM for example :)

>>>> +/*
>>>> + * Each interrupt has a corresponding bit in both
>>>> + * the Interrupt Cause (ICR) and Interrupt Mask (IMR) registers.
>>>> + *
>>>> + * Enabling/disabling an interrupt line involves asserting/clearing
>>>> + * the corresponding bit in IMR. ACK'ing a request simply involves
>>>> + * asserting the corresponding bit in ICR.
>>>> + */
> 
> I looked it up in YAGCD; it says that _reading_ the ICR reg already
> acks all interrupts (and clears the bits), you never write this reg!
> 

YAGCD is not always right. You should not take it as _the truth_.
I'm not telling this is the case. But I don't recall such behavior. It's been a long time since this is done this way.

>>>> +static void flipper_pic_ack(unsigned int virq)
>>>> +{
>>>> +    int irq = virq_to_hw(virq);
>>>> +    void __iomem *io_base = get_irq_chip_data(virq);
>>>> +
>>>> +    set_bit(irq, io_base + FLIPPER_ICR);
>>>> +}
>>>
>>> So it should be a simple write instead of an RMW here, right?
>>> As it is you are ACKing _all_ IRQs as far as I can see.
>>>
>>
>> No, it acks just a single IRQ.
> 
> No it doesn't.  Say IRQs 1 and 3 are asserted, so the reg contains 0x0a.
> Now you want to ack IRQ1; set_bit() will write 0x0a | 0x02, not just 0x02.
> 

Let me rephrase it. No it should just ack a single IRQ :)

So then this is working by accident.
If that's the case, I guess it works because the interrupt is not cleared at the source and the ICR is set again immediately for any pending interrupt?

> 
> Segher
> 
> 

Thanks,
Albert
