Mime-Version: 1.0
Message-Id: <a04310100bbce04de57b9@[199.170.89.118]>
In-Reply-To: <Pine.GSO.4.21.0311042328150.3207-100000@waterleaf.sonytel.be>
References: <Pine.GSO.4.21.0311042328150.3207-100000@waterleaf.sonytel.be>
Date: Tue, 4 Nov 2003 19:48:44 -0600
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
From: Jeff Walther <trag@io.com>
Subject: Re: IRQS on 6 Slot Macs
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 23:30 +0100 11/04/2003, Geert Uytterhoeven wrote:

>On Tue, 4 Nov 2003, Jeff Walther wrote:
>>  At 20:14 +1100 11/04/2003, Benjamin Herrenschmidt wrote:
>>  >>  After all, one can, in theory, add 1024 PCI slots to a machine using
>>  >>  PPBs.   There aren't going to be 1024 interrupts available.
>>  >
>>  >Why ? Some iSeries have up to 2048 irq lines afaik ;)
>>
>>  By iSeries, do you mean iBook and iMac?   Or is that something else?
>
>iSeries are the big IBM boxes formerly known as AS/400.

How do they provide that many IRQ lines?  I'm assuming that there
can't be one wire/pin per IRQ because of the routing/packaging
problems for the traces and chips.   Do they do something like an
address bus for IRQs?
>
>>  I think I can find GC's connection to MESH as well, but I'm
>>  uncertain.   I believe that MESH is just a licensed NEC (now LSI
>                                                       ^^^
>>  Logic) 53CF96 and I have the pinout for the 53CF96 so tracing
>
>NCR, I assume?

Derrrrrrr.  Yes.   Must.  Find.  New.  Brain.

NCR spun off their semiconductor business as SYMBIOS which was later
acquired by LSI Logic.

>>  I haven't dug into that, but I'd like to know how they made that
>>  work.  Does an Enet card require an interrupt?  Does it ever master
>>  the PCI bus?
>
>Ethernet prefers to have an interrupt, else it becomes quite slow :-)
>Most modern Ethernet interfaces do bus mastering. Old NE2000 clones don't.

Thank you.  Then one would expect to find an interrupt and PCI bus
arbitration lines in the extender on PCI slot 1 of the S900.   The
PCI bus arbitration lines are simple.  The arbiter that Apple used
has something like six GNT and REQ lines available, so there are
spares of those, but I wonder where Umax got the interrupt, unless
it's sharing one with the UW SCSI portion of the card and the drivers
take that into account.

Jeff Walther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
