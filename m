Return-Path: <listmember@orkun.us>
Message-ID: <42446F00.90000@orkun.us>
Date: Fri, 25 Mar 2005 14:05:20 -0600
From: Tolunay Orkun <listmember@orkun.us>
MIME-Version: 1.0
References: <712A2DEC228C7448978CBD7A7AD5B090012EE448@fever.wardrobe.irobot.com>
	<42444D00.80401@orkun.us> <20050325183126.GA2539@gate.ebshome.net>
	<424469C2.2070906@orkun.us>
In-Reply-To: <424469C2.2070906@orkun.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.com
Subject: Re: Question regarding Interrupt "delivery" to user mode process
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Eugene,

>> There is a quirk for PPC405 however: Linux (2.4) calls ack_irq() 
>> before branching to the IRQ handler. However, if irq is level 
>> triggered and external interrupt source has not yet deasserted, the 
>> interrupt status bit in interrupt status register will remain set! To 
>> avoid spurious interrupt it is necessary to call ack_irq() again 
>> before enabling the interrupts again. I had discussed this in the old 
>> linuxppc-embedded list while I was doing this driver.
>>   
>
>
> This isn't 405 specific. This problem will exist on any system with 
> level-sensitive IRQ source which wasn't ACK'ed. ACK'ed here means 
> acknowledgment in device itself, not in PIC.

This would not be a problem for level triggered interrupts if 
enable_irq() cleared the pending IRQ bit before re-enabling the 
interrupt system if that particular interrupt was level triggered.

If there is a valid request still pending (i.e. external IRQ line is 
still asserted at the appropriate level) this would not cause loss of 
interrupt but in case there is no requester (i.e. all interrupts are 
properly acknowledged), the spurious interrupt due to delayed processing 
would be avoided.

Tolunay
