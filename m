Return-Path: <ebs@ebshome.net>
Date: Fri, 25 Mar 2005 10:31:26 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Tolunay Orkun <listmember@orkun.us>
Message-ID: <20050325183126.GA2539@gate.ebshome.net>
References: <712A2DEC228C7448978CBD7A7AD5B090012EE448@fever.wardrobe.irobot.com>
	<42444D00.80401@orkun.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42444D00.80401@orkun.us>
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

On Fri, Mar 25, 2005 at 11:40:16AM -0600, Tolunay Orkun wrote:

[snip]

> There is a quirk for PPC405 however: Linux (2.4) calls ack_irq() before 
> branching to the IRQ handler. However, if irq is level triggered and 
> external interrupt source has not yet deasserted, the interrupt status 
> bit in interrupt status register will remain set! To avoid spurious 
> interrupt it is necessary to call ack_irq() again before enabling the 
> interrupts again. I had discussed this in the old linuxppc-embedded list 
> while I was doing this driver.

This isn't 405 specific. This problem will exist on any system with 
level-sensitive IRQ source which wasn't ACK'ed. ACK'ed here means 
acknowledgment in device itself, not in PIC.

This is why this user-space IRQ handling is a bad idea, IMHO. You have 
to ACK IRQ (in device itself) in kernel-IRQ handler.

--
Eugene
