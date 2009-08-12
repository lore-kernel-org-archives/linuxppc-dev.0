Return-Path: <leonardo.lists@gmail.com>
Received: from mail-ew0-f217.google.com (mail-ew0-f217.google.com
	[209.85.219.217])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 50CC0B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 05:40:05 +1000 (EST)
Received: by ewy17 with SMTP id 17so284308ewy.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 12:40:02 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 12 Aug 2009 16:40:02 -0300
Message-ID: <c2d0b6ec0908121240v60446ebdjc9dc35fe1b5b544e@mail.gmail.com>
Subject: The infamous ppc_spurious_interrupt
From: Leonardo Chiquitto <leonardo.lists@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I'm trying to understand the rationale behind "ppc_spurious_interrupts" without
luck so far. I'm seeing the BAD interrupt counter incrementing with kernels of
different ages (2.6.5, 2.6.16, 2.6.27) and on different hardware (IBM P5 and P6
64 bit, Apple PPC 32 bit). Here is the code snip that performs the increment:

void do_IRQ(struct pt_regs *regs)
{
(...)
        irq = ppc_md.get_irq();

        if (irq != NO_IRQ && irq != NO_IRQ_IGNORE)
                handle_one_irq(irq);
        else if (irq != NO_IRQ_IGNORE)
                /* That's not SMP safe ... but who cares ? */
                ppc_spurious_interrupts++;
(...)
}

I see that the counter is incremented only when ppc_md.get_irq() returns NO_IRQ.
This seems to happen with some frequency here (32 million "bad" interrupts in
~16 days of uptime, or ~23 int/sec).

I did some research in the archives and found some references, like this comment
from Rob Baxter (http://marc.info/?l=linuxppc-dev&m=119579052741562&w=2):

> A good example is an interrupt request from a PCI bus device.  Many device
> driver interrupt handlers will clear the source of the interrupt by either
> reading or writing some register within the device, perform some necessary
> actions, and return from the handler.  The PCI device is slow to negate its
> interrupt request and the interrupt controller sees the interrupt request
> from the device again.  With the platforms that I'm associated with I've
> seen this happen more frequently (i.e., BAD interrupts) as processor
> internal core frequencies increase, especially with the 7457.

Is this correct? Why we see this behavior only on PPC and not on all
architectures
that support the PCI bus?

If the "bad interrupts" are harmless (I suppose they are), why are we counting
them and displaying the counter as BAD in /proc/interrupts?

Best regards,
Leonardo
