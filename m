Date: Mon, 25 Feb 2002 13:18:00 +0100 (CET)
From: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>
To: Jerry Van Baren <vanbaren_gerald@si.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: custom mpc8240 student project (long)
In-Reply-To: <5.1.0.14.2.20020222070057.01f28df8@falcon.si.com>
Message-ID: <20020225115719.P58832-100000@invalid.ed.ntnu.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 22 Feb 2002, Jerry Van Baren wrote:

>
> [snip]
>
> >What I would like to know is wether this BSDL file can be used
> >to reversengineer the functionality of the internal TRAP logic.
>
> What you are asking for is the information covering the separate ring that
> goes through the innards (registers) of the CPU.

I did take a quick look at the BSDL file and the enclosed JTAG
documentation in the 8260 user manual. But at first glimse,
there was nothing to hint at internal debug registers the
like of BDM. Unfortunately. But there is plenty codespace
left in the 4 bit command register to implement debugging
and an alternate scan line.

> >This is all about control - the manufactures should not be allowed
> >to place a NDA on this information. Redirecting customers to 3'd

> I suspect that it's about sanity preservation, not control.  Releasing this
> extremely complex information (which can vary from chip rev to chip rev) to
> John Q Public is going to generate a LOT of technical support calls that
> they are currently avoiding by carefully selecting who they release the
> information to.

The actual motive/reason of Motorola for placing this under NDA is
not really our concern. What is our concern is that Motorola like
all other manufacturers of JTAG enabled controllers _has_ put an
NDA on this information. That hurts us, or at least a large number
of us even if you do not count yourself in. This is the situation
the OS market was in that lead to Linux in it's time. And GCC.

Hence it is an situation we have to remedy. Cracking or stealing
information is not the style of the Open Source community. Neither
is giving in. Reverse engineering might so the trick, since I refute
the assertion that the JTAG debug logic is 'extremely complex.'
I'm almost willing to bet that it is close to or identical to
the tried and tested BDM implementation embedded within JTAG.
But I do not dispose neither an BDI200 nor an 82xx to do logic
analysing and logging with. But even if I did I would not have
a goog enough understanding of how GDB works to break down the
problem into manageable pieces.

But revers engineering will by its very nature be a continuing
struggle to overcome increasingly strong encryption put in place
by the manufacturers.

Hence we develop our own solutions or - in this case - workarounds.
I do not see why you oppose my suggested alternative so much. EPROM
emulators har been around since the beginning of digital logic and
does indeed work. You are quite correct in that EPROM emulators are
both more complex and more costly than a JTAG dongle. But as long
as we are cut off from the information required to utilize an JTAG
dongle (which I also suggested how to build) we are forced to find
alternatives and workarounds, wouldn't you agree?

> By the way, the 3rd party tool costs are NOT astronomical.  Entry level is
> $50 for a BDM4GDB, $150 for a Macraiger Wiggler.  That is roughly the same

I have built BDM4GDB adapters for less than $5. Guss the wiggler
is much the same. It is not the HW that is the culprit. SW is.

> as the cost of the CPU you are trying to debug.  That's pretty reasonable
> in my book.  With the BDI-2000 or Corolis accel card you are paying a LOT
> more for the HARDWARE ACCELERATION.

I can build my suggested accelerated JTAG dongle for less than $20.
An even faster solution would be to use a PowerQUICC SCC port in
transparent mode for the JTAG shift register requirement. This, of
cause, requires the presence of an existing PowerQICC system.
Just a suggestion.

> The software, which is the part covered by the NDA, you can download
> from Macraigor for _FREE_ so quicherbitchin:

The first shot is, as we know, always free.

> Source project doing this, you can start TODAY.  Hey, you could become as
> rich and famous as Wolfgang :-).

I do not even come close to the SW knowledge of Wolfgang or Malek, so
I am more likely to enter a joint venture. It is the SW that is stopping
me, not the HW. And yes, it is quite possible to do Open Source HW
in the BSD license style. The GNU style is harder to apply since
HW is all about recycling old ideas (prior art) and implementations
in new permutations.

> spend the money to build a SRAM dongle, you will find a Macraiger Wiggler
> costs about the same with no assembly required, so where's the beef?

The assurance is about control. To know that I'm not at the whims
of Macraigor, that the dongle implmentation is here to stay. Etc.


> Couple of reality checks:
>                  JTAG            SRAM
>                  ----            ----
> Pins            5               32 (possible 32x4)

There are more pins on the HC244 buffers within the JTAG dongle.
But that is not the point. The point is that the EPROM emulator
we can use, the JTAG we can not due to NDA.

> Size            10 pin header   32 pin DIP, no wait TSOP,
>                                    no wait BGA, no wait...
>                                    (DIP footprint by 1++ inches long)

Five more pins already on the JTAG header. But no, it will not
come close to an EPROM emulator (200++ pins) The SRAM packeage
does not apply, since it will not sit in the actual system but
typically on an expansion board with access to the local bus an
of cause the boot chip select line /CS0. But for those systems
that can spare the area the DIP socets occupy the dongle can
interface directly into these. Do not worry to much about the
physical layout of the EPROM emulator. It can be done.

> Speed           don't care      full bus speed (66MHz)

No EPROM can do full bus speed. SRAM can, but that is beside the
point. We will rely on the System Interface Unit to do its job.

> Support logic   1 logic buffer  CPLD and buffers

Nix, No, Njet. I can do this dongle in only discreets.
An AVR would be helpful, but is not really required.

> Future          works           Obsolescence is a continual problem

The other way around. Todays EPROM/Flash will look the same in
10 years from now. All embedded CPUs on the marked today can
make use of 20 year old chips, so I do not worry. The consept
can be modernized too. The JTAG dongle will also look mostly the
same in 10 years. It is the SW that is the question for both cases.
But less so for the EPROM emulator. The JTAG implementation can as
you yourself claim, change from one core revision to the next.

> Cost            $15 in parts    $$$

Let me guess at $30-50 for the 8 bit wide  EPROM emulator.

> Software        roughly the same both ways

Not by a far shot. JTAG means commersial software given
current state of affairs. The EPROM emulator means GDB.

> Do it, be rich and famous, but my professional opinion is that using JTAG
> to program flash is going to be a much easier path to the same end goal.

I do not disagree. It is just that I am cut of from JTAG.
Which means I've got to stay at 8xx series with BDM. This pisses me off.

But of cause, if noone wants such an EPROM emulator then there
is no point in me designing and testing one, is there?

--

  ******************************************************
  Never ever underestimate the power of human stupidity.
  -Robert Anson Heinlein

		GeirFRS@invalid.ed.ntnu.no
  ******************************************************

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
