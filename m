Date: Mon, 24 May 2004 02:42:53 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Fixup for DEC 21154 bridge to allow CardBus support
In-reply-to: <1085376973.14969.47.camel@gaston>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Message-id: <Pine.LNX.4.58.0405240227210.3182@portland.hansa.lan>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
References: <Pine.LNX.4.58.0405231954120.10093@portland.hansa.lan>
 <1085363158.15315.11.camel@gaston>
 <Pine.LNX.4.58.0405240031200.2676@portland.hansa.lan>
 <1085376973.14969.47.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 24 May 2004, Benjamin Herrenschmidt wrote:

[snip]
> > > (hrm... not too sure in fact if the linux common PCI code will properly
> > > fixup the last subordinate bus number, you may also want to only give a
> > > range of 5 or 10 bus numbers in case somebody plugs another PCI card
> > > with a P2P bridge on it, maybe just read the bus number and rewrite it
> > > adding 5 or so...)
> >
> > I assumed that all PCI devices inserted to the slots would be on the bus 1
> > and thus behind the DEC bridge I'm reconfiguring.
>
> They can have P2P bridges too. For example, some adaptecs have a P2P
> bridge and 2 controllers behind it. Some e1000 cards too.

I guess we don't understand each other.  I thought you didn't like that I
the PCI bridge would handle all buses from 1 to 255.  I assumed that you
meant that some of those buses can be used by some other PCI bridges.  I
assumed that if the P2P bridge is behind the main PCI bridge, the buses
handled by the P2P bridge would be a subset of the buses handles by the
the main PCI bridge.

I assure you that every CardBus bridge would only use 4 buses.  It won't
use all 253 buses.

Anyway, you know PowerPC architecture much better.  I might be missing
something obvious.  After all, the upper bus range is just a number.
Adjust it in any direction if you want.

--
Regards,
Pavel Roskin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
