From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Mon, 16 Feb 2004 18:08:02 -0700
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on MPC5200 - LITE5200EVAL
Message-ID: <20040217010802.GA9519@zenos.farnsworth.org>
References: <402E0D8C.4080801@246tNt.com> <20040214145308.9E915C108D@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040214145308.9E915C108D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Feb 14, 2004 at 02:53:03PM +0000, Wolfgang Denk wrote:
>
> In message <402E0D8C.4080801@246tNt.com> you wrote:
> >
> > The weird problem with u-boot ( not booting If I set bootargs manually )
> > and the kernel crash are both solved. It was a compiler issue. I used a
> > toolchain I used to build binaries for a "normal" mac based on gcc 3.4 (
> > cvs ) and it was a really bad idea.
>
> I see.
>
> >  - The PCI slot is 3.3 v and apparently I don't have a single PCI card
> > that seems to work on it ... When I plug one ( that I thought was 3.3v
> > ), nothing boot, sometimes even the led don't power on ...
>
> Be careful to put it correctly. The slot bracket has  to  be  on  the
> side where the UART / USB / CAN connctors are. Do not insert the card
> with the slot bracket pointing to the IDE connector.
>
> Also be VERY carefully  which  card  you  insert.  make  sure  it  is
> _really_ a 3.3V compatible card. [I fried a board by trying a Digitus
> "DC  SER2 Rev. 2.0 Serial PCI I/O Card" - this card has the key slots
> for a 3.3/5V combi card, but the V_I/O pins are connected to  the  5V
> rail. The RAM chips didn't like to see 5V ...]
>
> >  - When I change options in the kernel to support new stuff I need, like
> > activating USB host & IDE controller, the kernel don't boot at all ( or
> > at least, I don't see on the serial console it does ). It's the same
> > problem with activating drivers for the PCI bus ... What is weird is
> > that it's not an error on boot, it's just that after u-boot messages,
> > there is nothing at all.
>
> Can you attach a debugger? Or even try  a  post-mortem  dump  of  the
> logbif area? Both PCI and USB are working fine for me.
>
> > I'm not sure my hardware is fully OK, but I did mtest on u-boot  for
> > about 10 hours and it didn't complained. It's a fresh new board from
> > motorola...
>
> Maybe you can ask for a replacement. Your problems don't look  normal
> to me.

I've seen the same symptoms Sylvain described on the five Lite5200
boards that I have tried.  Eepro100 network cards work fine, but the 3
brands of IDE cards I tried are not even visible in PCI config space.
U-boot doesn't see them and Linux doesn't see them, booted either from
dBUG or U-boot.

Actually, one Lite5200/IDE combo comes close.  Parts of the IDE cards
PCI config info do read correctly sometimes.  Different parts each time.
I think this is likely a hardware issue with Lite5200 boards.

-Dale Farnsworth

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
