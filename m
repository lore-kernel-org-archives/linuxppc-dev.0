Return-Path: <listmember@orkun.us>
Message-ID: <42444D00.80401@orkun.us>
Date: Fri, 25 Mar 2005 11:40:16 -0600
From: Tolunay Orkun <listmember@orkun.us>
MIME-Version: 1.0
To: "Caruso, Nick" <ncaruso@irobot.com>
References: <712A2DEC228C7448978CBD7A7AD5B090012EE448@fever.wardrobe.irobot.com>
In-Reply-To: <712A2DEC228C7448978CBD7A7AD5B090012EE448@fever.wardrobe.irobot.com>
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

Dear Nick,

Caruso, Nick wrote:
> Note that "delivery" is in quotes - I don't mean to actually deliver an
> interrupt, but rather to wake the process when the interrupt occurs.
> 
> This is a broad question, but I'm hoping someone out there with real
> experience in this area can comment on a design idea we're kicking
> around.
> If there's a better mailing list for asking this type of question,
> please tell me!
> 
> We are building a device with an MPC5200 processor which needs to detect
> incoming pulses at a 13 mSec rate.  We've got this incoming pulse wired
> to an IRQ on the MPC5200 and we now need a method for detecting these
> interrupts in a user mode process.
> 
> The design we're contemplating is a small character device driver in the
> kernel that will allow a user mode process to perform a blocking read on
> a file descriptor, and return from the read call whenever an interrupt
> occurs.  

I have done a similar char device driver in 2.4 kernel on a PPC405GP 
board. The driver receives the interrupt but does not enable the 
interrupt. However, it releases the user mode application waiting on 
"select" call (could be "poll" as well) from the /dev/device. Once the 
user application processes the interrupt, it performs an ioctl to the 
device driver to re-enable the interrupt.

We do not have hard timing issues like you have. I think 13mSec rate is 
pretty problematic for handling the interrupts consistently from a user 
mode application like I did. But, you can try. It is pretty easy to do.

There is a quirk for PPC405 however: Linux (2.4) calls ack_irq() before 
branching to the IRQ handler. However, if irq is level triggered and 
external interrupt source has not yet deasserted, the interrupt status 
bit in interrupt status register will remain set! To avoid spurious 
interrupt it is necessary to call ack_irq() again before enabling the 
interrupts again. I had discussed this in the old linuxppc-embedded list 
while I was doing this driver.

> We're not concerned (for the moment) with missing interrupts - we think
> we can service them fast enough (we just need to record a
> chronometer-type timestamp for some other incoming (serial) data).
> 
> Does this sound like a workable approach?  Does anyone know of a better
> way?  My implementation plan is to derive something from the 3rd edition
> Linux Device Drivers book "scull-pipe" device driver.
> 
> Any comments or suggestions would be greatly appreciated.
> 
>     thanks and best regards,
>        Nick Caruso
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
