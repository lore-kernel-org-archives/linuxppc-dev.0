Date: Wed, 5 Sep 2001 14:41:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 4xx - a question and a patch
Message-ID: <20010905144125.H6636@zax>
References: <20010830175217.H858@zax> <3B95307D.1BE64A98@mvista.com> <20010905110451.A599@zax> <3B95A796.248A0E99@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B95A796.248A0E99@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Sep 05, 2001 at 12:18:30AM -0400, Dan Malek wrote:
>
> David Gibson wrote:
>
> > The 405gp manual implies that an mtspr to the PIT writes both the
> > decrementing value and the reload register.  Is this a hardware /
> > documentation bug?
>
> Well, the point is that it writes the reload register.  When it
> gets to zero, it reloads with this register, which is wrong.

But when it hits zero we'll also get another timer interrupt and will
shortly be updating it with a corrected value.  Why does it matter
that the value is reloaded?

> > .....  Could the PIT be used this way if auto-reload was
> > disabled?
>
> No, because the PIT doesn't count down past zero.  If they would
> have allowed this, we could have disabled the auto-reload and
> treated it just like the decrementer.

Maybe I'm being dense, but I don't see why that matters.  We're
working out the actual time elapsed between ticks from the time base
not the decrementer (i.e. timer_interrupt() calls set_dec(), but never
get_dec()) so why are values below zero important?

> The best I could come up with is just allow the PIT run with a
> proper and fixed reload value.  It isn't a decrementer and we
> can't treat it like one.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
