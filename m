Date: Wed, 31 Jul 2002 17:09:12 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Matt Porter <porter@cox.net>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC/PATCH] idle loop changes
Message-ID: <20020801000912.GG17472@opus.bloom.county>
References: <20020731193200.GD17472@opus.bloom.county> <20020731142401.B5793@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020731142401.B5793@home.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jul 31, 2002 at 02:24:01PM -0700, Matt Porter wrote:
> On Wed, Jul 31, 2002 at 12:32:00PM -0700, Tom Rini wrote:
> >
> > The following is based on the final patch that Armin posted a short
> > while back.  What this does is allow for the power_save() function to be
> > overridden, but still provide a 'sane' default.  This moves the existing
> > power_save() function into ppc6xx_idle.c, as after talking with Hollis,
> > the function won't work as-is on Power3/iSeries (bits have moved or are
> > non-existant).
> >
> > I'm not totally sure if it's better to do it this way, or to not provide
> > a default power_save(), so that if we don't set pm_idle to something, we
> > just never call power_save() (as opposed to a call, check for a bit &
> > return).  Comments?
>
> To build it on non-6xx you need to move the powersave_nap declaration
> back to idle.c and extern it in ppc6xx_idle.c.  It's required by
> sysctl.  Other than that, this will work.

Bleah.  I'm not sure if the sysctl is wrong or not right now.  IIRC,
powersave_nap is only actually made use of on pmac, and from what I
remember of talking to Ben, it's only really an option on 6xx anyhow.
But good spotting none the less. :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
