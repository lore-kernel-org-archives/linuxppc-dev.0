Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 39F87DDE23
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 08:08:08 +1000 (EST)
Subject: Re: Problem with OF interrupt parsing code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <47016B11.3070609@freescale.com>
References: <20071001210025.314240@gmx.net> <470165F6.7030505@freescale.com>
	<470168B4.7090005@freescale.com> <1191274981.6310.19.camel@pasglop>
	<47016B11.3070609@freescale.com>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 08:07:54 +1000
Message-Id: <1191276474.6310.21.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-10-01 at 16:48 -0500, Scott Wood wrote:
> Benjamin Herrenschmidt wrote:
> > On Mon, 2007-10-01 at 16:37 -0500, Scott Wood wrote:
> >> Scott Wood wrote:
> >> Actually, it doesn't -- it should stop when it sees the 
> >> interrupt-controller property in the i8259 node, at which point it'll be 
> >> trying to use the raw PCI IRQ pin number as an i8259 IRQ.  This is 
> >> Unlikely To Work(tm).
> > 
> > It will work in the specific 8259 case I suppose since it gets the
> > legacy 1:1 mapping... but it sucks :-)
> 
> The mapping between INTA-D and i8259 numbers isn't generally 1:1, and it 
> looked as if it'd try using the former... though the code is 
> sufficiently complicated that I could easily be missing something.

If the whole of_* thing totally fails, pci_read_irq_line should pickup
the value in the config space PCI_INTERRUPT_LINE. That will work on
things like Pegasos and possibly on this AmigaOne but it sucks.

Ben.
