Date: Mon, 1 Feb 1999 18:15:45 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: "Petr Vandrovec Ing. VTEI" <VANDROVE@vc.cvut.cz>
cc: Owen Waller <O.Waller@ee.qub.ac.uk>, linuxppc-dev@lists.linuxppc.org
Subject: Re: matroxfb, anybody? (More details...)
In-Reply-To: <1F2ACA229B9@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.03.9902011814220.17350-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 1 Feb 1999, Petr Vandrovec Ing. VTEI wrote:
> On  1 Feb 99 at 15:30, Owen Waller wrote:
> > o.k. well the x86 board definelty doesn't... So we now have a more general
> > problem:
> > If I have two idential video boards in my Mac one "mac" specific which
> > shows up in the OF tree, and one that is x86 sourced and doesn't show up
> > under OF how can we initialise both boards correctly.
> If you have at least one matrox in your OF tree, driver will initialize
> all matroxes from offb. If you have no matrox in OF tree, driver will
> initialize them from matrox_init.
> > im my case matroxfb will become my primary head, but I'd still like access
> > to the internal (control) video in case soemthing in a new kernel dies
> > before matroxfb is initialised.
> Without offb you can set order by
> video=control: video=matrox:
> to get control first (or vice versa to get matrox first). With offb I do not
> know.
> 
> So, attached patch adds back that matrox_init is called unless you
> specify `video=matrox:off' on command line. In this case, matrox can
> be still initialized through offb. If you specify `video=matrox:disabled',
> driver will be unavailable for offb too.

Which does not help if you have 2 Matrox boards, due to the single static
`initialized' variable.

> Also, driver still does not use device_node passed to driver by offb
> because of no-one told me what I can expect in that variable... Driver

You can find the PCI base addresses in there (look at atyfb_of_init() for an
example).

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
