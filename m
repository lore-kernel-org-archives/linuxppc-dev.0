Date: Thu, 6 Sep 2001 07:55:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: acmay@acmay.homeip.net
Cc: Dan Malek <dan@mvista.com>, John Tyner <jtyner@cs.ucr.edu>,
	linuxppc-commit@source.mvista.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: patch for mktree.c on cross compiles
Message-ID: <20010906075542.A21172@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010905120613.I14548@ecam.san.rr.com> <3B968E75.A63F26EA@mvista.com> <20010905212050.K18940@cpe-24-221-152-185.az.sprintbbd.net> <20010905223903.D621@sink.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010905223903.D621@sink.san.rr.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Sep 05, 2001 at 10:39:03PM -0700, acmay@acmay.homeip.net wrote:
> On Wed, Sep 05, 2001 at 09:20:50PM -0700, Tom Rini wrote:
> > On Wed, Sep 05, 2001 at 04:43:33PM -0400, Dan Malek wrote:
> > > andrew may wrote:
> > > > I would think everything in arch/ppc/boot/utils should be checked
> > > > for endian problems on cross compiles.
> > >
> > > Are the network-host macros the right things to use?  That's what
> > > always comes to mind for me, but I suspect there is a more standard
> > > set of macros from 'endian.h' or something........If it's OK with
> > > everyone I'll check it in, but it does look kind of weird.
> >
> > Well, after some quick digging, here's what I found.  If we include
> > <asm/byteoder.h>, and deal with some __'s, which are exported outside
>
> One problem with trying this is that <asm/byteoder.h> will only be for
> the target, not the compiling host. I think mktree should stick with
> standard userspace include headers and stay away from kernel headers.

Er.  No, <asm/byteorder.h> _should_ be a userspace header.  At least on
Linux..  For BSD (and Linux with _USE_BSD) we can use sys/types.h and get
back a __BYTE_ORDER, I _think_...

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
