From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15655.39445.566490.16876@argo.ozlabs.ibm.com>
Date: Sun, 7 Jul 2002 11:32:05 +1000 (EST)
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH/RFC] Change how we pick which _kd_mksound to use.
In-Reply-To: <20020701152727.GC20920@opus.bloom.county>
References: <20020701152727.GC20920@opus.bloom.county>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini writes:

> The following changes how we pick a _kd_mksound.  The problem is that on
> some machines, such as IBM405, the default _kd_mksound breaks horribly
> due to the inb/outb's attempting to fiddle with timers which don't
> exist.  This changes the test which selects either an empty _kd_mksound
> or the one in question from __powerpc__ to CONFIG_PPC64 (since from what I
> understand, __powerpc__ is defined on ppc64) || (CONFIG_PPC32 &&
> CONFIG_6xx).  The CONFIG_6xx test is because these boards are the ones
> which tend to have a SuperIO chip, or something else with the timers at
> 0x61, 0xB6, etc.
>
> The other option would be to define an empty no_kd_mksound or so on
> 4xx/8xx and then conditionally set kd_mksound to that, but I would
> prefer this since we're already doing some preprocessor checks anyhow.

This is one of those "there's got to be a better way" places.  The
CONFIG_PPC32 && CONFIG_6xx test doesn't really capture what we want
much better than the existing __powerpc__ test does.  Testing
CONFIG_PPC32 && CONFIG_ISA might go closer.  I would really rather
that _kd_mksound was provided in the platform-specific files on those
platforms where it applies, though.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
