Date: Mon, 8 Jul 2002 09:11:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Armin <akuster@dslextreme.com>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH/RFC] Change how we pick which _kd_mksound to use.
Message-ID: <20020708161157.GF695@opus.bloom.county>
References: <20020701152727.GC20920@opus.bloom.county> <15655.39445.566490.16876@argo.ozlabs.ibm.com> <3D29B8CB.9020204@dslextreme.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D29B8CB.9020204@dslextreme.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jul 08, 2002 at 09:07:39AM -0700, Armin wrote:

> Paul Mockeries wrote:
>
> >Tom Rind writes:
> >
> >>The following changes how we pick a _kd_mksound.  The problem is that on
> >>some machines, such as IBM405, the default _kd_mksound breaks horribly
> >>due to the inb/outb's attempting to fiddle with timers which don't
> >>exist.  This changes the test which selects either an empty _kd_mksound
> >>or the one in question from __powerpc__ to CONFIG_PPC64 (since from what I
> >>understand, __powerpc__ is defined on ppc64) || (CONFIG_PPC32 &&
> >>CONFIG_6xx).  The CONFIG_6xx test is because these boards are the ones
> >>which tend to have a SuperIO chip, or something else with the timers at
> >>0x61, 0xB6, etc.
> >>
> >>The other option would be to define an empty no_kd_mksound or so on
> >>4xx/8xx and then conditionally set kd_mksound to that, but I would
> >>prefer this since we're already doing some preprocessor checks anyhow.
> >>
> It looks to me as if the CONFIG_REDWOOD should be changed to CONFIG_4XX
> to start with and there are no guarantees that the timer will be at the
> same locations plus on a pci base 4xx , in*/out* can't br used on local
> bus i/o access.

Well, CONFIG_REDWOOD should be changed into something that catches all
of the other boards that it won't work on. :)

> >This is one of those "there's got to be a better way" places.  The
> >CONFIG_PPC32 && CONFIG_6xx test doesn't really capture what we want
> >much better than the existing __powerpc__ test does.  Testing
> >CONFIG_PPC32 && CONFIG_ISA might go closer.  I would really rather
> >that _kd_mksound was provided in the platform-specific files on those
> >platforms where it applies, though.
>
> For 4xx it should be defined at the board level in most cases :)

Right, just how pmac case is done.  If we want/can have the beep on a
4xx board :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
