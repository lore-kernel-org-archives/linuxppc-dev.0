Message-ID: <39831621.79C54E27@embeddededge.com>
Date: Sat, 29 Jul 2000 13:36:33 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Dan Malek <dan@netx4.com>, linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_PPC != Mac
References: <39821DD7.ED0DA0A2@embeddededge.com> <20000729093817.C4552@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:

> Well, where are the specific breakages?  (CONFIG_MAC is used for 68k only
> right now, IIRC.)

Sorry, I guess I haven't looked at it in a while.....I just noticed
this with the recent 2.4.0-test5 BitKeeper tree.

All CONFIG_PPC builds include drivers/macintosh, and I guess there are
more changes happening there that require additional configuration
options.  For example, you can't build a PowerPC without Machintosh
and USB (and ADB, and keyboards, and....).  So, when I have a PowerPC
that isn't a Mac, I can't link a kernel unless I have all of these
devices configured.  Then, it likes to probe for this stuff, or look
for OF device trees, or something else I don't have.

However, there is a good side :-).  For the first time I am able to
build a kernel without _any_  Mac drivers, which is really nice.

I modified the Makefiles to remove the line:
	DRIVERS-$(CONFIG_PPC) += drivers/macintosh/macintosh.o

and other places where CONFIG_PPC included the macintosh subdir.


This at least works for my embedded systems.  The interesting part
is that in all of these cases, there is an identical Makefile line
or logic for CONFIG_MAC, so I kind of assumed that if you really want
Mac drivers, you could just configure this.....

I am now about to experiment with building for my iMacs and G4s.
I would like to know what people think CONFIG_MAC or CONFIG_PPC or
some of these others are supposed to mean, or assumptions they make.

Thanks.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
