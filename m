Return-Path: <rmk+linuxppc-embedded=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[217.147.92.249])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F1CC467B6C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Nov 2006 00:05:12 +1100 (EST)
Date: Mon, 20 Nov 2006 13:04:56 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: Use real irq on UART0 (IRQ = 0) on PPC4xx systems
Message-ID: <20061120130455.GB22330@flint.arm.linux.org.uk>
References: <200611201200.36780.ml@stefan-roese.de>
	<20061120114248.60bb0869@localhost.localdomain>
	<200611201255.37754.ml@stefan-roese.de>
	<20061120121015.2fb667d0@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061120121015.2fb667d0@localhost.localdomain>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Nov 20, 2006 at 12:10:15PM +0000, Alan wrote:
> On Mon, 20 Nov 2006 12:54:32 +0100 (MET)
> Stefan Roese <ml@stefan-roese.de> wrote:
> > Let's see, if I got this right. You mean that on such a platform, where 0 is a 
> > valid physical IRQ, we should assign another value as virtual IRQ number (not 
> > 0 and not -1 of course). And then the platform "pic" implementation should 
> > take care of the remapping of these virtual IRQ numbers to the physical 
> > numbers.
> > 
> > Correct?
> 
> Absolutely correct in all the detail.

Since IRQ0 is not valid, can we arrange for the generic interrupt
infrastructure to always fail it's allocation, and then remove the
utterly unused bloatful irq_desc[0] ?

Didn't think so since x86 folk would scream.  Wait a moment, x86 can
map IRQ0 to some other number for the timer interrupt, just like
other architectures are being forced to map their UART interrupts.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
