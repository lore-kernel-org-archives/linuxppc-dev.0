Date: Mon, 19 Jul 2004 11:20:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andreas Oberritter <obi@saftware.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] make platform_init() weak for 8xx
Message-ID: <20040719182047.GC6813@smtp.west.cox.net>
References: <1090253615.1415.24.camel@shiva.saftware.de> <20040719163203.GA6813@smtp.west.cox.net> <1090258468.1419.58.camel@shiva.saftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1090258468.1419.58.camel@shiva.saftware.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jul 19, 2004 at 07:34:28PM +0200, Andreas Oberritter wrote:

> On Mon, 2004-07-19 at 18:32, Tom Rini wrote:
> > On Mon, Jul 19, 2004 at 06:13:35PM +0200, Andreas Oberritter wrote:
> > > this patch renames platform_init to m8xx_init in m8xx_setup.c and adds
> > > new weak platform_init, which can be overridden by boards to allow them
> > > to e.g. register platform_devices like redwood5.c does for 40x.
> >
> > First, I don't see the redwood5 example you're talking about.
>
> http://ppc.bkbits.net:8080/linuxppc-2.5/anno/arch/ppc/platforms/4xx/redwood5.c@1.11?nav=index.html

Ah, I follow you now.  This too, seems awkward to me.  I'm making myself
a note to talk with Matt Porter when I see him tomorrow about this.

> > Second, this takes us in the direction of 82xx.  Until the 82xx
> > abstractions get flushed out a bit more, I remain unconvinced that
> > they're really the right way to go (perhaps hooking the other direction
> > would work better, e.g. platform_init() calls board_init(), with a weak
> > version provided, and some functions forced to be provided by board.c,
> > such as m8xx_map_io).
>
> I chose this way because it seemed to be a simple way to port the dbox2
> board to 2.6 using the new device API. Is there another 8xx board which
> uses the device API for its onboard peripherials and can be used as a
> reference? Can I get my devices registered without modifying
> platform_init, or shall I send a patch with the board_init() you
> mentioned? See my board.c attached.

There currently isn't a reference platform for what you speak of.  My
preference would be to see what I described given a shot to see if it
looks better or worse (and it better, or worse, in the flow of things).
But, tomorrow I leave for OLS, so if I don't reply, well, that's my
excuse.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
