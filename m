Message-ID: <39B7CC9A.4A1A8A35@mvista.com>
Date: Thu, 07 Sep 2000 10:12:59 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: Bob Doyle <doyle@primenet.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: More Sandpoint woes
References: <20000905213639.B22842@hectic.net> <39B5764D.C30702A8@mvista.com> <20000907003235.C5231@hectic.net> <39B71505.12B01DD9@primenet.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alex, Bob,

I expected the eepro100 driver to just work too.  What I found, though, was
that one of the writes to a register was being byte-swapped twice (once
explicitly in the call to outl() and again by outl()).  I changed it to swap
once and things worked much better.

I haven't been following the changes to this driver so I don't know how often
it gets modified.  My assumption at the time was that someone had recently
modified the driver and no one had since tested it on a big-endian machine.
When I get ready to integrate with the latest src base, I'll sort through it
all again.

I think the 8255x enet ctlr is still a good choice.

Bob, I don't know about your AMD card, I haven't tried it.

A note to everyone, for whatever reason(s), the sandpoint has been a difficult
platform to get things to work.  Lots of things that should "just work",
don't.  I've tested with 82559 and 8139 ethernet ctlrs.  They worked for me
with the kernel you now have.  I encountered trouble (timing issues, etc) at
many steps along the way; don't be surprised if you do too.  Sounds like you
guys are taking it beyond where I took it so don't expect an easy ride.  Just
speaking from experience...  :(

Mark
--

Bob Doyle wrote:

> Alex Shnitman wrote:
> >
> > Hi, Mark!
> >
>
> [snip]
>
> > Ooh! I selected the eepro100 because I thought that'd be the most
> > reliable
>
> [snip]
>
> I was about to ask the same question...  I didn't see a list of
> known-to-work
> network cards.  Right now my Sandpoint has a AMD Lance card in it.  Will
> that
> work?
>
> Bob
>

--
Mark A. Greer (mgreer@mvista.com; 480-517-0287)
MontaVista Software, Inc.
2141 E. Broadway Road, Suite 108
Tempe, AZ  85282


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
