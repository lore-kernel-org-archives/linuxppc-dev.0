From: "Steve Boorman" <steveb@baydel.com>
To: "Stefano Gaiotto" <Stefano.Gaiotto@marconi.com>
Date: Fri, 20 Aug 2004 14:55:17 +0100
Subject: Re: PCI scanning and devices initialization
Reply-To: Steve Boorman <steveb@baydel.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <412610D5.24571.6137FAB@localhost>
In-reply-to: <OF379F51C9.E590A00B-ONC1256EF6.003EC05A@uk.marconicomms.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stefano,

> I examinated board schematics and I found that pin "IDSEL" of the bridge
> PCI/PCMCIA (PCI1410) in wired (at least in the schematics...) to line AD12
> of data/address bus. (What's device address? 12? or 2? or 16?)

You need to look up how the configuration mechanism works for your
processor type.

When configuration type 1 cycles are performed, the device is
targeted by a configuration address written to a hardware register
(configuration_address register) in the HOST PCI bridge (contained
within your CPU) then a read or write is performed via the
configuration_data register. The configuration address is defined as
follows:-

bits 31-24 are reserved
bits 23-16 are the bus no
bits 15-11 are the device Number (using a single idsel line)
bits 10-8 are the function (for a multifunction device)
bits 7-2 is addr of the config register to read/write
bits 1 is a zero
bits 0 is a one.

The processor defines how it maps the possible 32 device numbers
(bits 15-11) as AD lines driven during a config cycle. As an example,
I use a PPC440GP and this maps device 0 by driving AD17, device 1 as
AD18 etc. So in your instance if I had connected AD12 up as an IDSEL
line I would not be able to see any devices.

If you are sure that your CPU will drive AD12 correctly then check
how the IDSEL line is coupled to the AD line. The usual method is
simply to connect a resistor from the AD line to the IDSEL line on
each PCI device (or socket) this reduces the loading on the AD line
but does restrict the IDSEL timing for fast (66 MHz and beyond) bus
speeds. This is done like this on our IBM demo board with the PPC440
and they use 2K2, which will not guarantee correct setup of IDSEL to
the PCI clock, causing device detection failures.

>
> With the help of the hardware boys I want now to chek signal
>integrity
>

If you are sure that all the above is correct then modify the pci
scan code so that it loops indefinately scanning for all 32 possible
devices. Then get a hardware guy to scope the bus. It is very simple
to look at the timing of the IDSEL lines by triggering off frameN
being asserted.

Sorry for rambling on as this is not very embedded PPC linux
specific.

Hope this helps

Regards,

Steve Boorman
-------------
steveb@baydel.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
