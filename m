Date: Wed, 26 Apr 2000 10:42:32 +0200 (CEST)
From: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MultiPPC - was: memory map
In-Reply-To: <3905CC66.D68C30A4@embeddededge.com>
Message-ID: <Pine.BSF.4.10.10004260915061.60450-100000@invalid.ed.ntnu.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 25 Apr 2000, Dan Malek wrote:

> Geir Frode Raanes wrote:
>
> > Hold it! What multiprocessor implementation?
> > Do I need to read up on the datasheet here?
>
> You need a little more than a datasheet......

Well yes. But I have to start somewhere and the datasheet
is as good a starting point as any. First you figure out
if it is altogether possible, then you work out the details.

Motorola documentation on the issue so far studied suggested
it was not possible, which made me stop searching any further.
Which has me believe the multiCPU HW is actually retrofitted
to the 603e kernel at a point later than the documentation.

> > The reason I ask is that I would love to run a 8260 and a 8240
> > in a multiprocessor setup.
>
> Where have you been :-)?

In another department mostly. Started up on PowerPC 4 months
ago. My current task is to replace the MBX board nearing it's
end-of-life. It will be replaced with a modest 855T design.

> Check out Motorola's web site and other
> PowerPC board vendors.  Most use the higher performance 7xx/7xxx
> with the 8260, but you could use the 8240 as well.  There are
> several custom multiprocessor 8260s running for well known data/telecom
> companies.

I was not really thinking of large compactPCI cards and defenitely
not of any design including the dreaded PCI-to-ISA bridge - the root
of all digital evil and so forth. Perhaps one of the PPMC boards
though.

Mostly I was playing with the Linux PDA idea, wich requires a
system-on-a-chip core. A 8260 with PCI (and probabely also CardBus32
PCI extensions or else use a TI bridge) Ethernet, FireWire and USB
implemented in microcode would defenitely do the trick. Add a 1/4
VGA LCD and one set of five keys to each side of the box (making up
a stenography keyboard) and we have a excellent, streamlined PDA.

But even if I had to throw a low power 8240 into the mix it would
be worthwhile if Linux could make use of this second CPU. Possibely
putting it to sleep when not needed. But it is only the MBX
replacement I am actually paid to do... And given the sheer size
of the 8260 I can only say Things Take Time.

> > ... Only in this kind of setup,
> > I would need some way of guaranteeing that the correct CPU
> > issues instructions to onchip peripherials. Guess this ruins it.
>
> Huh?  Talk about giving up before you ever start.....There isn't
> anything that can't be done if you want to do it.

OK, ok! A closer inspection of the datasheet reveals that the 8260
in slave mode will snoop bus transactions. Which means that any
onchip memory mapped peripherial will be available from any CPU.
But browsing the 8240 UM did not reveal any corresponding
functionality. Lots on PCI arbitration but little on local
bus arbitration.

> > BTW, has anyone looked into the possibility of implementing
> > IEEE-1394 FireWire on a FCC of 8260?
>
> Yes.
>
> > ... Motorola microcode perhaps?
>
> Perhaps.

Then perhaps I should wait it out on the nearest fence?
Like the 8260 PCI interface?

> > Probabely a no-go as USB was hardwired on the 823,
>
> You lost me here.........

If 12 MBit/s USB could not be implemented in microcode on
a 20 MBit/s 8xx SCC port, then it is not very likely that
400 MBit/s Firewire can be implemented in microcode on a
700 MBit/s FCC port. But of cause, the 8260 DSP is a lot
faster than the 8xx DSP, so maybe now USB is possible on
a 8260 SCC port. That would be nice.

--
  ******************************************************
  Never ever underestimate the power of human stupidity.
  -Robert Anson Heinlein

		GeirFRS@invalid.and.so.forth
  ******************************************************

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
