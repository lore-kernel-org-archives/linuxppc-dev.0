Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7B5DCDDE9D
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 13:07:27 +1000 (EST)
Date: Tue, 21 Aug 2007 21:12:12 -0500
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Fix race in the pasemi timebase calibration
Message-ID: <20070822021212.GA8060@lixom.net>
References: <20070821220631.GA4304@lixom.net>
	<18123.37125.712301.914626@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18123.37125.712301.914626@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 22, 2007 at 11:27:33AM +1000, Paul Mackerras wrote:
> Olof Johansson writes:
> 
> > Make sure the new timebase value is available by the time take_timebase
> > completes. Otherwise take_timebase might race with give_timebase,
> > causing severe badness when the value later is modified (think looong
> > hang trying to catch up with a very large number of lost ticks).
> 
> OK.
> 
> > @@ -61,6 +62,7 @@ static void __devinit pas_give_timebase(
> >  	mtspr(SPRN_TBCTL, TBCTL_UPDATE_LOWER | (tb & 0xffffffff));
> >  	mtspr(SPRN_TBCTL, TBCTL_UPDATE_UPPER | (tb >> 32));
> >  	mtspr(SPRN_TBCTL, TBCTL_RESTART);
> > +	timebase_avail = 1;
> 
> No memory barrier before setting timebase_avail?  Shouldn't there be
> one?

Technically there's no previous memory access to put that barrier up
against since they're all SPR ops, but an isync after the mtspr would
be warranted.

> Actually I don't understand that code at all.  Your give_timebase
> seems to freeze the timebase, read it, set it to the same value and
> restart, all without synchronizing with the other cpu, and your
> take_timebase does nothing except print the timebase.  How does that
> work?

The TBCTL functions control the TBs of all cores. I.e. current
give_timebase will push out the current TB of the booting core to all
others in the system.

And yes, I had misunderstood the timebase calibration back when I
implemented it, not realizing we do a give+take for each cpu coming
up. It should really look more like the pseries implementation, only
using TBCTL to freeze/thaw and do the handover manually. That'll be CPU
hotplug-proof as well.

New patch reworking all of this coming. Thanks for the reality check.

-Olof
