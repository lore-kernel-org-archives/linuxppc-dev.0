Message-ID: <20031103141125.10229.qmail@kunk.qbjnet.com>
Subject: Re: IRQS on 6 Slot Macs
In-Reply-To: <1067842481.17970.8.camel@gaston>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 3 Nov 2003 08:11:25 -0600 (CST)
From: Bob Brose <bob@kunk.qbjnet.com>
Cc: Robert E Brose II <bob@kunk.qbjnet.com>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


User Benjamin Herrenschmidt says:
> On Mon, 2003-11-03 at 14:35, Robert E Brose II wrote:
>
> > A couple of things right off, the rage128 appears to be the only thing on
> > irq 23 however 23 doesn't show up in /proc/interrupts meaning, I suppose,
> > that it's not using the interrupt. So why does the drm complain?
> >
> > How come everything from slots 3-6 says it's on the same interrupt (25)?
>
> I don't know what's up with the DRM not liking your interrupt. I can
> answer for the sharing of USB, symbios and firewire interrupts: all 3
> slots share one interrupt because of bad motherboard design :)
> Basicallly, what they did when designing that machine was to use a
> standard powersurge design with 3 slots and replace one of them
> with a PCI<->PCI bridge. Since they didn't "know" how to get more
> interrupt lines out of Grand Central, they just also stuffed all
> interrupt lines together for those 4 slots (I'm pretty sure GC do
> have spare lines they could have used, but that would have meant
> updating Open Firmware to understand the layout, I doubt the people
> who designed that machine wanted to dive into that).
>
> Ben.

I suppose then that I should reorder the cards so that the ones generating
the most interrupts would be in the first 2 slots? It's pretty funny
having the possibility of the use of lots of irqs then ending up with
x86 style sharing. :(

Bob
--
/~\ The ASCII       | Robert E. Brose II    N0QBJ
\ / Ribbon Campaign | http://www.qbjnet.com/
 X  Help cure       | mailto:bob@qbjnet.com
/ \ HTML Email      | public key at http://www.qbjnet.com/key.html

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
