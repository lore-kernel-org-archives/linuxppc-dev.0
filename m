Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 078991007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 08:45:08 +1100 (EST)
In-Reply-To: <4B0D65C5.8090304@yahoo.es>
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
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7556BF73-5D6D-4817-A02F-3DFA05E9AC58@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 11/19] powerpc: gamecube/wii: flipper interrupt
	controller support
Date: Thu, 26 Nov 2009 22:52:04 +0100
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> Maybe using FLIPPER (or GAMECUBE_FLIPPER) instead of GAMECUBE_COMMON
>> is a good name?
>
> I'd prefer to not use a name that implies a specific hardware to  
> describe two (mostly) similar but different hardwares.

Hollywood is 100% compatible to Flipper though.

>>> +/*
>>> + * Each interrupt has a corresponding bit in both
>>> + * the Interrupt Cause (ICR) and Interrupt Mask (IMR) registers.
>>> + *
>>> + * Enabling/disabling an interrupt line involves asserting/clearing
>>> + * the corresponding bit in IMR. ACK'ing a request simply involves
>>> + * asserting the corresponding bit in ICR.
>>> + */

I looked it up in YAGCD; it says that _reading_ the ICR reg already
acks all interrupts (and clears the bits), you never write this reg!

>>> +static void flipper_pic_ack(unsigned int virq)
>>> +{
>>> +    int irq = virq_to_hw(virq);
>>> +    void __iomem *io_base = get_irq_chip_data(virq);
>>> +
>>> +    set_bit(irq, io_base + FLIPPER_ICR);
>>> +}
>>
>> So it should be a simple write instead of an RMW here, right?
>> As it is you are ACKing _all_ IRQs as far as I can see.
>>
>
> No, it acks just a single IRQ.

No it doesn't.  Say IRQs 1 and 3 are asserted, so the reg contains 0x0a.
Now you want to ack IRQ1; set_bit() will write 0x0a | 0x02, not just  
0x02.


Segher
