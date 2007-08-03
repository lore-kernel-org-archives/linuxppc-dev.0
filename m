Return-Path: <benh@kernel.crashing.org>
Subject: Re: [ PATCH ] PowerPC cascade UIC IRQ handler fix.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070802034848.GA837@localhost.localdomain>
References: <20070730163517.GA10087@ru.mvista.com>
	<20070802034848.GA837@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 03 Aug 2007 11:18:09 +1000
Message-Id: <1186103889.5495.650.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-08-02 at 13:48 +1000, David Gibson wrote:
> On Mon, Jul 30, 2007 at 08:35:17PM +0400, Valentine Barshak wrote:
> > PPC44x cascade UIC irq handler fix.
> > 
> > According to PPC44x UM, if an interrupt is configured as level-sensitive,
> > and a clear is attempted on the UIC_SR, the UIC_SR field is not
> > cleared if the incoming interrupt signal is at the asserted polarity.
> > This causes us to enter a cascade handler twice, since we first ack
> > parent UIC interrupt and ack child UIC one after that.
> > The patch checks child UIC msr value and returns IRQ_HANDLED
> > if there're no pending interrupts. Otherwise we get a kernel panic
> > with a "Fatal exception in interrupt" (illegal vector).
> > The patch also fixes status flags.
> > 
> > Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> 
> Hrm... This doesn't seem like the right fix to me.  Instead, I think
> the cascaded IRQ handler should ack the interrupt on the child first.
> I'm a little surprised it doesn't at the moment.

Well, we certainly do also need to make the code more solid vs.
spurrious interrupts.

The main thing is, if the cascade is a level interrupt, it should
probably use a smarter cascade handler that masks it, handle the child
interrupts, then unmasks it.

Ben.
