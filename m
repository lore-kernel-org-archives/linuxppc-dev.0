Date: Wed, 31 Jul 2002 13:38:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC/PATCH] idle loop changes
Message-ID: <20020731203810.GE17472@opus.bloom.county>
References: <20020731193200.GD17472@opus.bloom.county> <3D4847D5.9030404@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D4847D5.9030404@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jul 31, 2002 at 04:25:57PM -0400, Dan Malek wrote:
> Tom Rini wrote:
>
> >I'm not totally sure if it's better to do it this way, or to not provide
> >a default power_save(), so that if we don't set pm_idle to something, we
> >just never call power_save() (as opposed to a call, check for a bit &
> >return).  Comments?
>
> I think whether we force everything to have a power_save() function,
> even if it is empty, or initialize a pointer and have an indirect call
> doesn't make much difference.  What does make a difference, is there could
> be power save functions that are unique to a board.  Some processors have
> power save options that can cause a lower frequency clock to be used which
> will affect external devices.  In such cases, the devices on a board may
> need some adjustment when these power save modes are entered/exited.

Well, this gets us part of the way there.  This allows for the
power_save() functionalility to be totally overridden.  For things such
as modifiying the clock, which may require additional device changes, I
think that falls in as another problem, but this should allow for that
problem to be taken care of.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
