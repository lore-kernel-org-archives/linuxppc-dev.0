Date: Wed, 29 May 2002 13:43:50 -0700
From: Matt Porter <porter@cox.net>
To: Tom Rini <trini@kernel.crashing.org>
Cc: "Cameron, Steve" <Steve.Cameron@hp.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Unrecognized opcode: `mtdcr'
Message-ID: <20020529134350.A3960@home.com>
References: <45B36A38D959B44CB032DA427A6E10640167CFD8@cceexc18.americas.cpqcorp.net> <20020529195429.GP5997@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020529195429.GP5997@opus.bloom.county>; from trini@kernel.crashing.org on Wed, May 29, 2002 at 12:54:29PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 29, 2002 at 12:54:29PM -0700, Tom Rini wrote:
>
> On Wed, May 29, 2002 at 02:30:16PM -0500, Cameron, Steve wrote:
> > [..snip...]
> > >
> > > I think we need to change arch/ppc/Makefile from:
> > > ifdef CONFIG_40x
> > > CFLAGS := $(CFLAGS) -Wa,-m405
> > > endif
> > >
> > > To:
> > > ifdef CONFIG_4xx
> > > CFLAGS := $(CFLAGS) -Wa,-m405
> > > endif
> >
> > Ok, this worked for me.  Thanks!  (I guess I wasn't so
> > far off track after all.)

Pushed this.

> > > For the moment.  Until there's some 440-specific opcodes we use (are
> > > there any?) which means we'll need to do -Wa,-m440.
> >
> > When I had tried "-Wa,-m440" before, it wasn't recognized as an option.
> > (but perhaps by "do -Wa,-m440", you mean enhance the C compiler and/or
> > assembler.)
>
> Well, iff there's 440-specific opcodes, at somepoint gas will know about
> them, and we can use -Wa,-m440, or so.  But for now -Wa,-m405 seems
> correct for 4xx.

There is _a_ 440-specific opcode, dlbmnz.  It's not yet supported by
gas (and ideally glibc).  For now, a 405 enabled toolchain is
sufficient.

When I push some CONFIG_BOOKE cleanup we'll have an option to enable
-mbooke with as well.  That's where most of the new instructions
come from, but they aren't 440 specific (they'll be on the e500
Book E core as well).  Right now, the important booke opcodes
are picked up by the PPC403 conf in gas so there's not a huge
hurry.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
