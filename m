Date: Mon, 8 Jul 2002 07:46:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH/RFC] Change how we pick which _kd_mksound to use.
Message-ID: <20020708144648.GA695@opus.bloom.county>
References: <20020701152727.GC20920@opus.bloom.county> <15655.39445.566490.16876@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15655.39445.566490.16876@argo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jul 07, 2002 at 11:32:05AM +1000, Paul Mackerras wrote:
> Tom Rini writes:
>
> > The following changes how we pick a _kd_mksound.  The problem is that on
> > some machines, such as IBM405, the default _kd_mksound breaks horribly
> > due to the inb/outb's attempting to fiddle with timers which don't
> > exist.  This changes the test which selects either an empty _kd_mksound
> > or the one in question from __powerpc__ to CONFIG_PPC64 (since from what I
> > understand, __powerpc__ is defined on ppc64) || (CONFIG_PPC32 &&
> > CONFIG_6xx).  The CONFIG_6xx test is because these boards are the ones
> > which tend to have a SuperIO chip, or something else with the timers at
> > 0x61, 0xB6, etc.
> >
> > The other option would be to define an empty no_kd_mksound or so on
> > 4xx/8xx and then conditionally set kd_mksound to that, but I would
> > prefer this since we're already doing some preprocessor checks anyhow.
>
> This is one of those "there's got to be a better way" places.

heh..

> The
> CONFIG_PPC32 && CONFIG_6xx test doesn't really capture what we want
> much better than the existing __powerpc__ test does.  Testing
> CONFIG_PPC32 && CONFIG_ISA might go closer.

Well, lets think about what we want here.  We want to know if we have a
PC-style SuperIO (or similar) on board.  This is true of every board
under CONFIG_6xx, except for pmac, and possibly the 8260 boards.

Perhaps in 2.5, if this is still an issue after the input bits are all
sorted out, and Ben gets his version of MS' CONFIG_GENERIC_PPC32
working, we can get CONFIG_PPC_SUPERIO or so added for all of the boards
which have one (which would catch any of the odd-ball, not existant but
no technically impossible 4xx boards with a SuperIO or something).

And is is popping up on the input layer discussion, what does CONFIG_ISA
actually mean?  In a lot of places (most even?) it means the existance
of ISA slots.

> I would really rather
> that _kd_mksound was provided in the platform-specific files on those
> platforms where it applies, though.

Er, I don't know if I follow you here.  Are you suggesting we take the
__powerpc__ test out of drivers/char/vt.c (or change it to CONFIG_PPC64)
and then make every board with a SuperIO have a copy of the 'proper'
_kd_mksound ? (The Makefile mojo would look like this tho :) :
ifeq ($(CONFIG_6xx)$(CONFIG_8260),yn) # It's a feature damnit...
obj-$(CONFIG_VT) += pc_mksound.o
endif
)

Or did you mean to make this a per-architecture problem?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
