Message-ID: <36901B63.5F905878@jlc.net>
Date: Sun, 03 Jan 1999 20:37:39 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Cort Dougan <cort@persephone.cs.nmt.edu>
CC: Paul Mackerras <paulus@cs.anu.edu.au>,
        Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        bh40@calva.net, tmrini@ntplx.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: irq cleanup
References: <Pine.LNX.3.96.981231143743.14310A-100000@persephone.cs.nmt.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Cort Dougan wrote:

> I was adding code for the QSPAN interrupts on the mbx.....

I am a little confused by this.  I am travelling and don't have
my books handy. and I remember the MBX uses the 8259
interrupt controller to manage all PCI/ISA device interrupts.
What I don't remember are the actual connections.  I believe
the PCI interrupts are routed to the 8259, which is then
routed to one of the 8xx external interrupts.

The QSPAN interrupts are for things like PCI parity
errors and the IDMA.  However, the IDMA won't operate
because of a silicon bug that will not allow the QSPAN to
be a master on the 8xx bus.

To support PCI or ISA devices that interrupt on the MBX
you would need to modify irq.c to support a multilevel interrupt
scheme.  The 8259 would interrupt on one of the 8xx interrupt
controller levels, then you would have to process all 8259
interrupts.

> The idea is to have a master controller, and each slave is dealt with as a
> handler so we don't have such an ifdef soup.

That's the right idea.   The master in this case would
be the 8xx interrupt controller, and the slave would be the 8259.
The QSpan isn't part of the picture.


    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
