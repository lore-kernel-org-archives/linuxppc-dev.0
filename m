Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 3/5] xhci: Add rmb() between reading event validity
	& event data access.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
In-Reply-To: <201103291156.47822.dmitry.torokhov@gmail.com>
References: <4D8C47CD.3020108@ozlabs.org>
	<61164.94.211.195.167.1301094709.squirrel@gate.crashing.org>
	<4D901429.5010807@ozlabs.org>
	<201103291156.47822.dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 30 Mar 2011 08:23:49 +1100
Message-ID: <1301433829.2402.694.camel@pasglop>
Mime-Version: 1.0
Cc: sarah.a.sharp@linux.intel.com, linuxppc-dev@ozlabs.org,
	linux-usb@vger.kernel.org, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-03-29 at 11:56 -0700, Dmitry Torokhov wrote:
> > +     /*
> > +      * Barrier between reading the TRB_CYCLE (valid) flag above
> and any
> > +      * speculative reads of the event's flags/data below.
> > +      */
> > +     rmb();
> >       /* FIXME: Handle more event types. */
> >       switch ((le32_to_cpu(event->event_cmd.flags) &
> TRB_TYPE_BITMASK)) {
> 
> Isn't it the same memory that is being read the first time around? How
> reordering could happen here? 

We don't try to enforce ordering specifically with the subsequent read
of the flags that is visible in the snipped above (indeed that's the
same address and so hopefully should be in program order), but all
subsequent reads which could have been performed speculatively such as
the rest of the event and including whatever other in memory information
the chip might have updated prior to sending the event.

Cheers,
Ben.
