Subject: Re: confused about HID1 bits and G5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <409108FE.70500@nortelnetworks.com>
References: <408FEBB6.105@nortelnetworks.com>
	 <1083191370.21436.81.camel@gaston>  <409108FE.70500@nortelnetworks.com>
Content-Type: text/plain
Message-Id: <1083275212.29595.141.camel@gaston>
Mime-Version: 1.0
Date: Fri, 30 Apr 2004 07:46:53 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2004-04-29 at 23:54, Chris Friesen wrote:
> Benjamin Herrenschmidt wrote:
> >>It appears that we're relying on the firmware to set up a lot of the bits in this register--is there
> >>any reason we aren't forcing particular values?
> >
> >
> > Forcing values in HIDs is BAD. The firmware may set/clear bits to work
> > around specific CPU or north bridge bugs for example. That's why I need
> > to change the code that force-clear HID4/5 one of these days too and
> > instead just clear the bits I want to be cleared.
>
> I'm just thinking of stuff that should really be set, like enabling the icache or the branch history
> table.  Do we really want to rely on firmware to do that? [1]

Well, so far, on the HW we had to deal with, the firmware did it
properly, but yes, it may make sense to set them, though not in the
preinit but in the later "setup" code.

> Currently there are a bunch of bits in HID1 that are not specifically set in the linux code.  I
> think they should be set, but I have no way of actually checking the value since I'm running in
> 32-bit mode. [2]
>
> Chris
>
>
>
>
> 1. We've seen at least one firmware that didn't do this for some 74xx hardware.  Drove us nuts
> trying to figure out why performance wasn't meeting projections.
>
> 2. I'm trying to get a 64-bit toolchain built, but the gcc doesn't build when I follow the
> instructions on linuxppc64.org.

I suggest you join #ppc64 on irc.freenode.net. Toolchain build can be
fairly nasty, at least to get the initial one built. Once you get it,
it's easier to rebuild new versions.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
