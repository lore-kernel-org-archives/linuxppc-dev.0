Message-ID: <38EA7BD9.C24774EB@embeddededge.com>
Date: Tue, 04 Apr 2000 19:33:45 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
CC: Ruedi Hofer <ruedi.hofer@ascom.ch>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA support for 860
References: <38E9BA8F.913681C7@ascom.ch> <kfyhfdiw06w.fsf@kieraypc01.p.y.ki.era.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marcus Sundberg wrote:
>
> Ruedi Hofer <ruedi.hofer@ascom.ch> writes:

> > Does someone have a clue on that? Is request_irq and request_8xxirq related??

Sort of.  The MPC8xx has an internal interrupt controller.  The
Linux community seems to think the world is 8259s and PCI/ISA bus.
Mapping request_irq into the 8xx interrupt controller was attempted,
but didn't provide the proper results.  The request_8xxirq function
is used by all integrated device drivers (serial, Ethernet, TDM/audio,
USB, SPI, I2C, PCMCIA, general purpose I/O pins, etc.), as they know
they are using the internal interrupt controller.

In the case of boards with PCI/ISA bridges, the request_irq is also
enabled because there is a downstream 8259 controller.  Not defining
this when there is no 8259 causes drivers that would attempt to use
this to fail.  It is nice to know this at build time, rather than
wondering why things are crashing or not working once the system is
booted.

This also presents a challenge for PCMCIA devices.  All of these drivers
(or supporting functions) want to install interrupt handlers using
request_irq, which doesn't make sense on the 8xx.  I have the ATA/IDE
patch to install the interrupt handler, but other devices may also need
interrupt handler patches.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
