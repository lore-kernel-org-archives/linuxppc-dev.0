MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Anyone got eepro100 working on Walnut?
Date: Wed, 17 Apr 2002 15:22:54 -0400
Message-ID: <FF6CF34C346E724596A2FB5CAAB2C497884506@voyager.ops.infiniswitch.com>
From: "Wright, David" <dwright@infiniswitch.com>
To: "Matt Porter" <mporter@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings, all,

As it turned out, the age of my kernel (2.4.14-pre3) was the
source of the problem; I had the older pci allocation functions
that don't allocate non-cacheable memory.  When I updated the
kernel to use a more recent pci-dma.c, the eepro100.c driver
I'd been using worked fine.  (It's not identical to the one in
the latest distribution, but it's not far off.)

Thanks,

  -- David Wright, InfiniSwitch Corp.


> -----Original Message-----
> On Tue, Apr 16, 2002 at 09:08:41PM -0400, Wright, David wrote:
> >
> > I've been trying to get an Intel eepro100 card working on a
> > Walnut board.  I've tried both the 1.09 and 1.19 versions of
> > the driver (eepro100.c).  Initially, both failed the self-
> > test step.  I was able to get past that one by invalidating
> > the dcache after issuing the self-test directive.  However,
> > I now find that the card is neither transmitting nor receiving
> > reliably.  I get messages like:
> >
> >    eth1: Unknown receiver error, status=0x5048.  [lots of these]
> >
> > and
> >
> > eth1: Transmit timed out: status 0050  0000 at 2/8 commands
> 00a00300 00a003000.
> > eth1: Restarting the chip...
> > eth1: Command unit failed to mark command 00030000 as complete at 6.
> >
> >
> > Any suggestions (other than junking this card, which is not
> > an option for me) most welcome.
>
> Sounds like you have a buggy kernel since it looks like cache
> coherency problems.  By the revision of the eepro100 driver you
> are using, it sounds ancient too.
>
> Try running the 2_4_devel kernel.  The current eepro100 driver
> works fine for me on a 440 so you shouldn't have a problem
> assuming that the walnut port is working.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
