Subject: Re: [PATCH] Fixup for DEC 21154 bridge to allow CardBus support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Roskin <proski@gnu.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.58.0405240031200.2676@portland.hansa.lan>
References: <Pine.LNX.4.58.0405231954120.10093@portland.hansa.lan>
	 <1085363158.15315.11.camel@gaston>
	 <Pine.LNX.4.58.0405240031200.2676@portland.hansa.lan>
Content-Type: text/plain
Message-Id: <1085376973.14969.47.camel@gaston>
Mime-Version: 1.0
Date: Mon, 24 May 2004 15:36:14 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2004-05-24 at 15:21, Pavel Roskin wrote:
> Hi, Benjamin!
>
> On Mon, 24 May 2004, Benjamin Herrenschmidt wrote:
>
> > > As a side not, the kernel says that the Host bridge (Motorola MPC106
> > > Grackle) is configured to support buses 0 and 1.  Those values come from
> > > the "bus-range" property.  I believe this limitation is not enforced, or
> > > it would also hinder CardBus support.
> >
> > It's a bit nasty right now... You may bump into other problems, the
> > main issue is OF not setting a proper bus range.
>
> I actually tried to replace all references to "bus-range" with "bus-bogus"
> in the kernel.  The kernel would print
>
> Found Grackle (MPC106) PCI host bridge at 0x80000000. Firmware bus number: 0->255
>
> instead of "0->1", but I didn't notice any difference with regards to
> CardBus support.
>
> > Anyway, you should make your patch machine specific to avoid screwing up
> > other possible busses...
>
> I have CONFIG_PPC_PMAC condition already.  This plus the exact vendor and
> device ID should be machine specific.  I can check that the machine is
> "PowerMac1,1" if you want.  I have no idea if G4 models have this problem.
>
> > (hrm... not too sure in fact if the linux common PCI code will properly
> > fixup the last subordinate bus number, you may also want to only give a
> > range of 5 or 10 bus numbers in case somebody plugs another PCI card
> > with a P2P bridge on it, maybe just read the bus number and rewrite it
> > adding 5 or so...)
>
> I assumed that all PCI devices inserted to the slots would be on the bus 1
> and thus behind the DEC bridge I'm reconfiguring.

They can have P2P bridges too. For example, some adaptecs have a P2P
bridge and 2 controllers behind it. Some e1000 cards too.


> Now I see that the video card is on bus 0 somehow.  Maybe that particular
> slot is wired differently.  If you really think that somebody could insert
> a P2P bridge instead of the video card, then maybe I should leave some
> space.  I seem to remember that some multihead cards (Colorgraphic
> Predator LT) have internal bridges.
>
> There are 3 PCI slots other than VGA.  Every card can have 2 CardBus
> slots.  Every CardBus bridge uses 4 buses.  That's 24 buses, from 2 to 25.
>
> The fixed patch is attached.
--
Benjamin Herrenschmidt <benh@kernel.crashing.org>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
