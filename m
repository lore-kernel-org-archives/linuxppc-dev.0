Date: Wed, 31 May 2000 22:10:56 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Josh Huber <huberj@wpi.edu>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Lite-On ethernet controller
In-Reply-To: <20000531094520.B652@mclinux.com>
Message-ID: <Pine.LNX.4.05.10005312154030.2148-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 31 May 2000, Josh Huber wrote:
> On Wed, May 31, 2000 at 09:32:12AM -0400, Jeff Garzik wrote:
> > I don't understand what you mean here.
> Sorry I wasn't clear.
>
> The Tulip driver in the devel kernels is not working for me. Supposedly,
> this card works with the driver in later 2.2 kernels.  I can't get 2.2.x to
> boot on this machine I have, which is why I'm using 2.4 pre versions.
>
> What I meant by the newer tulip driver was the version available from Don
> Becker's tulip development page.
>
> > > Does anyone know of forward-ported tulip drivers?
> >
> > A tulip driver exists in the 2.4pre kernel.  Are you having problems
> > with that driver?
> Yes.
>
> > > The particular error I'm seeing only happens with moderate load -- pings and
> > > other light traffic work 100%.
> > >
> > > Error information:
> > > NETDEV WATCHDOG: eth1: transmit timed out
> > > Transmit timed out, status e4660000, CSR12 000050ca, resetting...
> > >
> > > Device information:
> > > tulip driver output:
> > > eth1: Lite-On PNIC-II rev 37 at 0x1c00, 00:00:94:C5:EF:FF, IRQ 30.
> >
> > IRQ 30?  Is that ok for PPC?
> Yes, here's the output from /proc/interrupts:
>               CPU0
>      1:       1820   i8259         keyboard
>      2:          0   i8259         82c59 secondary cascade
>      8:          2   i8259         rtc
>     16:          0   OpenPIC       82c59 cascade
>     27:          0   OpenPIC       NMI
>     29:       4872   OpenPIC       eth0
>     30:       4624   OpenPIC       eth1
>     31:       6377   OpenPIC       aic7xxx
>
> eth0 is an actual DEC tulip card, which works great.
>
> > > lspci -vv output attached because it's too wide.
> > No attachment...
>
> Heh, sorry.  I'll attach it this time.

Josh is not the only one having problems...

I have a Digital DC21041 Tulip rev 33 at 0x1080, 21041 mode, 00:80:C8:5A:F8:5B,
IRQ 29. The interrupt number is correct :-) I occasionally got random network
lock ups with the old dex45 driver (tulip didn't work then) that could be
solved by rebooting only (ifconfig down locked up the machine).

Later the card seemed to work fine with the updated tulip driver, as you
probably remember.  However, I just got a problem with the updated driver
(2.3.99-pre3) for the first time:

| NETDEV WATCHDOG: eth0: transmit timed out
| eth0: 21041 transmit timed out, status fc660010, CSR12 000002c8, CSR13 ffffef0d, CSR14 fffff73d, resetting...
| eth0: 21143 100baseTx sensed media.
        ^^^^^
	Huh? I have a real 21041.

So I ran `tulip-diag -fa' and got:

| tulip-diag.c:v1.19 10/2/99 Donald Becker (becker@cesdis.gsfc.nasa.gov)
| Index #1: Found a Digital DC21041 Tulip adapter at 0x1080.
| Digital DC21041 Tulip chip registers at 0x1080:
|   ffe08000 ffffffff ffffffff 07917000 07917200 fc660010 fffe2002 ffffebef
|   fffe0000 ffff4bf8 ffffffff fffe0000 000000c8 ffffef0d fffff73d ffff0006
|  Port selection is half-duplex.
|  Transmit started, Receive started, half-duplex.
|   The Rx process state is 'Waiting for packets'.
|   The Tx process state is 'Idle'.
|   The transmit unit is set to store-and-forward.
|   The NWay status register is 000000c8.
|   Internal autonegotiation state is 'Autonegotiation disabled'.

Fortunately `ifconfig down; ifconfig up' solved the problem and made the
network work again. I reran tulip-diag -fa' and got:

| tulip-diag.c:v1.19 10/2/99 Donald Becker (becker@cesdis.gsfc.nasa.gov)
| Index #1: Found a Digital DC21041 Tulip adapter at 0x1080.
| Digital DC21041 Tulip chip registers at 0x1080:
|   ffe08000 ffffffff ffffffff 07917000 07917200 fc660000 fffe2002 ffffebef
|   fffe0000 ffff4bf8 ffffffff fffe0000 000001c8 ffffef05 ffffff3f ffff0008
|  Port selection is half-duplex.
|  Transmit started, Receive started, half-duplex.
|   The Rx process state is 'Waiting for packets'.
|   The Tx process state is 'Idle'.
|   The transmit unit is set to store-and-forward.
|   The NWay status register is 000001c8.
|   Internal autonegotiation state is 'Autonegotiation disabled'.

I hope this helps. Thanks for your time!

Note that Josh is using a similar box as me, a CHRP LongTrail. In fact all
people with LongTrails seem to have problems with Tulip chips. So it might be a
motherboard problem.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
