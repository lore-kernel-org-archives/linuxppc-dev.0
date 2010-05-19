Return-Path: <sonny@us.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6780FB7D2D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 May 2010 04:34:50 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4JIQ3Bj000403
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2010 12:26:03 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4JIYbwr135966
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2010 12:34:38 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o4JIbUwL005852
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2010 12:37:30 -0600
Date: Wed, 19 May 2010 13:34:35 -0500
From: Sonny Rao <sonnyrao@us.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pseries: Add support for IO Event interrupt
	drivers
Message-ID: <20100519183435.GE26215@us.ibm.com>
References: <20100519042744.GA26215@us.ibm.com>
	<1274271058.13433.30.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1274271058.13433.30.camel@concordia>
Cc: markn@au1.ibm.com, linuxppc-dev@lists.ozlabs.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 19, 2010 at 10:10:58PM +1000, Michael Ellerman wrote:
<snip>
> > > The "checks the scope" requires an RTAS call, which takes a global lock
> > > (and you add another) - these aren't going to be used for anything
> > > performance critical I hope?
> > 
> > Nope it shouldn't be performance critical, but it does raise the point
> > that the current RTAS implementation in Linux *always* uses the global
> > lock.  There is a set of calls which are not required to be serialized
> > against each other.  This would be a totally different patchset to fix that
> > problem.  The "check-exception" call is one that doesn't require the global
> > RTAS lock.  I might work on that someday :-)
> 
> Aha, that's kind of what I was wondering. I take it PAPR documents which
> calls need to be serialised and which don't?

Yeah, here's my workin list of what calls can avoid the global lock:

List of "re-entrant to the number of processors in the system" RTAS Calls
--
ibm,get-xive
ibm,set-xive
ibm,int-off
ibm,int-on


OS machine check and soft-reset handlerse must be able to call rtas
(I'm saying these are therefore re-entrant because we could deadlock
if we took a machine check or reset with the global lock held)
--
nvram-fetch
nvram-store
check-exception (includes our io-events)
display-character
system-reboot
set-power-level(0,0)
power-off
ibm,set-eeh-option
ibm,set-slot-reset
ibm,read-slot-reset-state2

additional serialiaztion group by itself
--
stop-self
start-cpu
set-power-level


<snip>
> > Also, if we're going to go ahead and use rtas_call() which locks
> > it's own buffer which meets the requirements, why do we even need
> > a separate buffer?  Really, we should make this call, then copy
> > the content of the buffer before handing it over to the drivers.
> 
> But another CPU could rtas_call() and blow away our buffer after we've
> dropped the RTAS lock but before we've used the content of the buffer.

Yeah, maybe I'm getting ahead of myself here -- to me this just highlights
the whole locking problem with the API as written, since the locking is
all done inside that call. The API needs to be extended such that
we have the option of doing our own locking of RTAS calls.


> > > > +	if (rtas_elog->type != RTAS_TYPE_IO_EVENT) {
> > > > +		pr_warning("IO Events: We got called with an event type of %d"
> > > > +			   " rather than %d!\n", rtas_elog->type,
> > > > +			   RTAS_TYPE_IO_EVENT);
> > > > +		WARN_ON(1);
> > > > +		goto out;
> > > > +	}
> > 
> > Should we try to process this instead of just warning?  
> > The type we get might be one of the the ones we recognize in
> > ras.c; so this is an argument for combining ras.c with this code
> > or at least report this in the same manner we report any other
> > RTAS error log.
> 
> We could, but that would be a massive firmware bug - not that it
> wouldn't happen, but it would be Not Our Problem TM.

Yeah, this is paranoia (*cough* Milton's suggestion)

> > > We /could/ copy the ioei_sec and drop the buf lock, which would allow
> > > another interrupt to come in and start doing the RTAS call (on another
> > > cpu, and iff there are actually multiple interrupts). But we probably
> > > don't care.
> > 
> > I think we *have* to copy it because we don't want our lock held when we
> > call random handlers.
> 
> They're not really random, and as long as they don't call the
> register/unregister routines it should be /OK/. But copying is probably
> good so we don't hold the lock for too long.

Yeah, this is probably ok since it's all happening in interrupt
context anyway the handlers have to be running in an atomic context
anyway.

-- 
Sonny Rao, LTC OzLabs, BML team
