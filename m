Return-Path: <linuxppc@lizardlogic.co.uk>
Received: from murano.lizardlogic.co.uk (unknown [195.10.246.108])
	by ozlabs.org (Postfix) with ESMTP id B92EF67B32
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Aug 2006 05:07:15 +1000 (EST)
In-Reply-To: <821B2170E9E7F04FA38DF7EC21DE487105E01B5B@VCAEXCH01.hq.corp.viasat.com>
References: <821B2170E9E7F04FA38DF7EC21DE487105E01B5B@VCAEXCH01.hq.corp.viasat.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9e35071a8a49e32925c3fdd623ef5206@lizardlogic.co.uk>
From: Stig Telfer <linuxppc@lizardlogic.co.uk>
Subject: Re: Xilinx PIC and kernel interrupt handler 
Date: Mon, 31 Jul 2006 20:07:13 +0100
To: "Martin, Tim" <tim.martin@viasat.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Tim -

You are right, there are many references in the INTC doc to w meaning 
the data bus width.  I think I have mis-read the IVR section.

However, the patch was based on real-world observations.  Under high 
system activity I occasionally see IVR reads returning 0x7F, and our 
system has 7 interrupts connected to that PIC.  That's where my 
hypothesis about the bit-extension came from.

As an aside, an immediate second read of the IVR returns a valid vector 
number to service.  Curious on a uniprocessor system...

Regards,
Stig


On 31 Jul 2006, at 19:06, Martin, Tim wrote:

> Regarding the IVR patch:  Have you seen this bug in practice, or just
> from examining the code?
>
> The reason I ask is I've recently looked at this myself, and was under
> the impression that "w" is the width of the data bus (DB) (per page 9 
> of
> dcr_intc.pdf).  So regardless of how many interrupt sources are
> connected, assuming the data bus width is 32 bits, w=32.
>
> I've specifically confirmed this is true if you have less than 32
> interrupt sources connected, the one named INT0 shows up in bit 
> position
> 31 (w-1 for w=32 is 31) of the ISR and IPR.  Bit position 31 in PPC
> notation is the LSB.
>
> Tim
>
>> -----Original Message-----
>> From: linuxppc-embedded-bounces+tmartin=viasat.com@ozlabs.org
>> [mailto:linuxppc-embedded-bounces+tmartin=viasat.com@ozlabs.or
>> g] On Behalf Of Stig Telfer
>> Sent: Monday, July 31, 2006 6:51 AM
>> To: linuxppc-embedded@ozlabs.org
>> Subject: Xilinx PIC and kernel interrupt handler
>>
>> Hi -
>>
>> There appears to be a kernel bug in the 2.4 and 2.6.17.7
>> kernel trees relating to reading the interrupt vector from
>> the Xilinx PIC
>> (xilinx_pic_get_irq() in xilinx_pic.c).  As I see it, here's the
>> problem: If no interrupt is pending, the register should read
>> all ones.
>>   However, the IVR is only as wide as the number of interrupt
>> sources.
>> The routine mistakenly assumes sign extension and checks for
>> a 32-bit read of -1 instead of a read of w bits where w is
>> the number of connected interrupt sources.
>>
>> The 2.6 version also has a search-and-replace glitch relating
>> to removal of the reversal of bit numbering.  I have attached
>> a two line patch (for 2.6.17.7) that makes the IVR comparison
>> against the right bit pattern and removes the remnants of the
>> former bit-reversal code.
>>
>> Share and enjoy,
>> Stig Telfer
>>
>>
