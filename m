Subject: Re: PCI scanning and devices initialization
To: Steve Boorman <steveb@baydel.com>
Cc: "" Stefano Gaiotto " <Stefano.Gaiotto" <Stefano.Gaiotto@marconi.com>,
	"linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <OF0FCDE466.E90AF0B5-ONC1256EF6.0052B974@uk.marconicomms.com>
From: "Stefano Gaiotto" <Stefano.Gaiotto@marconi.com>
Date: Fri, 20 Aug 2004 17:23:53 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve,

thanks for your good advice.


> You need to look up how the configuration mechanism works for your
> processor type.

from "MPC8280 PowerQUICC II" Family Reference Manual" I had confirmation
about association
between field "Device number" (bit 11-15) in CONFIG_ADDR register and PCI
address line.

>From manual: "All 21 IDSEL bits are decoded starting with bit AD[11]" so
AD[12] corrisponds to device number 0b01100.
(special case: AD[31] is selected with 0b010101)

Now I'm sure that connecting IDSEL to AD[12] my device number is 12.



> If you are sure that your CPU will drive AD12 correctly then check
> how the IDSEL line is coupled to the AD line. The usual method is
> simply to connect a resistor from the AD line to the IDSEL line on
> each PCI device (or socket) this reduces the loading on the AD line
> but does restrict the IDSEL timing for fast (66 MHz and beyond) bus
> speeds. This is done like this on our IBM demo board with the PPC440
> and they use 2K2, which will not guarantee correct setup of IDSEL to
> the PCI clock, causing device detection failures.

Connection is done by a 68 ohm resistor, I hope is a good value...


> If you are sure that all the above is correct then modify the pci
> scan code so that it loops indefinately scanning for all 32 possible
> devices. Then get a hardware guy to scope the bus. It is very simple
> to look at the timing of the IDSEL lines by triggering off frameN
> being asserted.

As soon as possible I will do this test, is a foundamental step to know
if the devise is correctly selected.


Best regards,
      Stefano Gaiotto












"Steve Boorman" <steveb@baydel.com> on 20/08/2004 15:55:17

Please respond to Steve Boorman <steveb@baydel.com>

To:    "Stefano Gaiotto" <Stefano.Gaiotto@marconi.com>
cc:    linuxppc-embedded@lists.linuxppc.org

Subject:    Re: PCI scanning and devices initialization


Stefano,

> I examinated board schematics and I found that pin "IDSEL" of the bridge
> PCI/PCMCIA (PCI1410) in wired (at least in the schematics...) to line
AD12
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
