From: okorpil@fh-landshut.de
Date: Wed, 14 Apr 2004 14:52:02 +0200 (CEST)
Reply-To: okorpil@fh-landshut.de
To: linuxppc-embedded@lists.linuxppc.org
Subject: MVME2100 patch cleanup / EPIC setup
Message-ID: <Pine.LNX.4.58.0404141436040.12711@ppcproject1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

A tested and updated version of the MVME2100 patch is up, mainly
consisting of the following changes:

Only CONFIG_GEN_RTC is enabled, but not CONFIG_RTC (both were before).
Thanks, Andrew Cox!

8259 stuff has been taken out as far as possible.

As far as I can see, the EPIC in the MVME2100 uses 12 of its 16 possible
external interrupt sources in serial mode (initsenses and OpenPIC sources
have been adjusted accordingly). There's no cascaded 8259 as an
external interrupt source, so I removed that.

Now I have a problem when cleaning up the patch - if I initialize the EPIC
like this -

openpic_init(0);

- the first interrupt (the DEC ethernet) would be mapped to 0. I have a
PCI IRQ table in the mvme2100_map_irq function, and it doesn't seem to
work that way, because it would have the same entries as an unused entry
in the PCI IRQ table with { 0, 0, 0, 0}.

Anyway, I tried it - and left the 8259 stuff completely out (including the
i8259.o object file in the corresponding Makefile), and it will stop
booting/showing serial messages after "Now booting Linux".

If I stick with the offset of 16 (NUM_8259_INTERRUPTS) in openpic_init,
anything will work just fine (and keep the 8259 object in). I tried both
with an adjusted serial UART irq for serial setup purposes, but only the
approach with openpic_init(NUM_8259_INTERRUPTS); does work.

Is this maybe an EPIC related problem?

Some platforms set up the openpic_init(0); but those don't have the EPIC
in serial mode. Those featuring the EPIC in serial mode have a cascaded
other PIC as well, so my "special case" seems to be limited to me: an EPIC
in serial mode with no cascaded other PIC. Not all platforms have a PCI
IRQ mapping table, but only the initsenses. Most platforms have an IRQ
setup without unused IRQs when initializing the OpenPIC (as I do: IRQ0,
IRQ6, IRQ11 and IRQ12 on the EPIC have no external sources connected).

Any ideas, anyone?

Look for the patches at -

http://www.fh-landshut.de/~okorpil/mvme2100-linux-2.4.25.patch.gz
http://www.fh-landshut.de/~okorpil/mvme2100-linux-2.4.25.patch.bz2

Hope anyone had great holidays!

Thanks in advance,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
