Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E55A1A0281
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Nov 2014 15:26:48 +1100 (AEDT)
Message-ID: <1415939194.666.30.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/powernv: Support OPAL requested heartbeat
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alistair Popple <alistair@popple.id.au>
Date: Fri, 14 Nov 2014 15:26:34 +1100
In-Reply-To: <40458133.nYBXtuXJmS@mexican>
References: <1415772194.5124.37.camel@kernel.crashing.org>
 <40458133.nYBXtuXJmS@mexican>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 Jeremy Kerr <jeremy.kerr@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-11-14 at 14:01 +1100, Alistair Popple wrote:
> Hi Ben,
> 
> On Wed, 12 Nov 2014 17:03:14 Benjamin Herrenschmidt wrote:
> 
> <snip>
> 
> > +
> > +static int kopald(void *unused)
> > +{
> > +	set_freezable();
> > +	do {
> > +		try_to_freeze();
> > +		opal_poll_events(NULL);
> 
> Do we need to check for outstanding events (and call opal_do_notifier)? The 
> Linux OPAL-IPMI interface signals an event which the interrupt handler 
> (opal_interrupt) checks for, but if interrupts aren't functional no event will 
> be signalled and hence the Linux IPMI layer won't get a response.
> 
> It's probably only an issue for lab bring up though as I would expect 
> interrupts to generally be working...

Well, it would somewhat double up with the OCC interrupt ... OPAL will
sent a local OCC interrupt if we change the event mask as a result of a
call that isn't opal_handle_interrupts() ... but yes, I suppose if that
doesn't work either... though this is not known to be problematic unless
the external one.

> > +		msleep_interruptible(opal_heartbeat);
> > +	} while (!kthread_should_stop());
> > +
> > +	return 0;
> > +}
> > +
> 
> Regards,
> 
> Alistair
