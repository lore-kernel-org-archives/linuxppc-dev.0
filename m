Date: Mon, 1 Feb 1999 19:32:43 -0100
From: Owen Waller <O.Waller@ee.qub.ac.uk>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
Cc: "Petr Vandrovec Ing. VTEI" <VANDROVE@vc.cvut.cz>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: matroxfb, anybody? (More details...)
In-Reply-To: <Pine.LNX.4.03.9902011814220.17350-100000@mercator.cs.kuleuven.ac.be>
Message-Id: <Pine.SGI.4.02A.9902011930570.11398-100000@myst.ee.qub.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 1 Feb 1999, Geert Uytterhoeven wrote:

> On Mon, 1 Feb 1999, Petr Vandrovec Ing. VTEI wrote:
> > On  1 Feb 99 at 15:30, Owen Waller wrote:
> > > o.k. well the x86 board definelty doesn't... So we now have a more general
> > > problem:
> > > If I have two idential video boards in my Mac one "mac" specific which
> > > shows up in the OF tree, and one that is x86 sourced and doesn't show up
> > > under OF how can we initialise both boards correctly.
> > If you have at least one matrox in your OF tree, driver will initialize
> > all matroxes from offb. If you have no matrox in OF tree, driver will
> > initialize them from matrox_init.
> > > im my case matroxfb will become my primary head, but I'd still like access
> > > to the internal (control) video in case soemthing in a new kernel dies
> > > before matroxfb is initialised.
> > Without offb you can set order by
> > video=control: video=matrox:
> > to get control first (or vice versa to get matrox first). With offb I do not
> > know.
> > So, attached patch adds back that matrox_init is called unless you
> > specify `video=matrox:off' on command line. In this case, matrox can
> > be still initialized through offb. If you specify `video=matrox:disabled',
> > driver will be unavailable for offb too.
> Which does not help if you have 2 Matrox boards, due to the single static
> `initialized' variable.

True. In this case is it worth applying your patch Petr?

> > Also, driver still does not use device_node passed to driver by offb
> > because of no-one told me what I can expect in that variable... Driver
> You can find the PCI base addresses in there (look at atyfb_of_init() for an
> example).

if you know the base address in PCI could this be used to move the card
into OF?

-------------------------------------------------------------------------
Owen Waller                     |   "...sometimes I think I'm a little
PhD. Student in Control Eng.    |    more English than I am French..."
Queens University               |              - Alain Prost 
Belfast                         |
Tele: +44 (0)1232 274085        |    Fax: +44 (0)1232 667023


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
