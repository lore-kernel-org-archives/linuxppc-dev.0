Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5C01D2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jun 2013 18:37:20 +1000 (EST)
Message-ID: <1371371826.21896.140.camel@pasglop>
Subject: Re: [PATCH 21/27] powerpc/eeh: Process interrupts caused by EEH
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Sun, 16 Jun 2013 18:37:06 +1000
In-Reply-To: <20130616072744.GA3845@shangw.(null)>
References: <1371286998-2842-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1371286998-2842-22-git-send-email-shangw@linux.vnet.ibm.com>
 <1371359531.21896.128.camel@pasglop> <20130616072744.GA3845@shangw.(null)>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-06-16 at 15:27 +0800, Gavin Shan wrote:

> Thanks for the review, Ben.
> 
> >Getting better.... but:
> >
> > - I still don't like having a kthread for that. Why not use schedule_work() ?
> >
> 
> Ok. Will update it with schedule_work() in next revision :-)
> 
> > - We already have an EEH thread, why not just use it ? IE send it a special
> >type of message that makes it query the backend for error info instead ?
> >
> 
> Ok. I'll try to do as you suggested in next revision. Something like:
> 
> 	- Interrupt comes in
> 	- OPAL notifier callback
> 	- Mark all PHB and its subordinate PEs "isolated" since we don't know
> 	  which PHB/PE has problems (Note: we still need eeh_serialize_lock())

No, don't mark anything. It wouldn't be good to start marking "isolated"
things that aren't. It doesn't matter if we don't "know" they are
isolated just yet. Just "poke" the EEH thread with a different type of
message from the current one.

> 	- Create an EEH event without binding PE to EEH core.
> 	- EEH core starts new kthread and calls to next_error() backend
> 	  and handle the EEH errors accordingly.

No need for a new kthread, EEH core already runs in one, doesn't it ? or
am I missing something here ? And yes, if EEH core doesn't get a PE in
the message, then it can call a backend function along the lines of
"next_error()" which ... returns a PE, and does whatever additional
processing we want to do for PHBs.

That can also return "nothing to do" (INF).
	  
> 	  * Informational errors: clear PHB "isolated" state and output diag-data
> 	    in backend (in eeh-ioda.c as you suggested).

Don't mark isolated in the first place.

> 	  * Fenced PHB: PHB complete reset by EEH core and "isolated" state will
> 	    be cleared during the reset automatically.
> 	  * Dead PHB: Remove the PHB and its subordinate PCI buses/devices from
> 		      the system.
> 	  * Dead IOC: Remove PCI domain from the system.

Might want to have return codes from next_error for doing that from the
core, up to you, not a big deal.

> The problem with the scheme is that the PHB's state can't reflect the real state
> any more. For example, PHB#0 has been fenced, but PHB#1 is normal state. We have
> to mark all PHBs as "isolated" (fenced) since we don't know which PHB is encountering
> problems in the OPAL notifier callback.

No, we don't have to mark anything. The interrupt is an asynchronous
thing anyway, so the effect in practice is that we'll react to it a
little bit later, but it's already coming an undefined amount of time
after the error anyway so we may as well deal with it, and that helps
with the synchronization between detection via the interrupt vs.
detection (of the same error) via the MMIO reads.

> I think it would work well. Let me have a try to change the code and make it
> workable. The side-effect would be introducing more logic to EEH core and it's
> shared by multiple platforms (powernv, pseries, powerkvm guest in future). So
> my initial though is making opal_pci_next_error() invisible from EEH core and
> make the EEH core totally event-driven :-)
> 
> > - I'm not fan of exposing that EEH private lock. I don't entirely understand
> >why you need to do that either.
> >
> 
> It's used to get consistent PE isolated state, which is protected by the lock.
> Without it, we would have following case. Since we're going to change the
> PE's state in platform code (pci-err.c), we need the lock to protect the PE's
> state.

I'd rather you expose get/set_state functions and keep the lock local if
that makes sense but first look at what I've proposed above. It might be
that you are right and the lock must be exposed.

> 	
> 		    CPU#0				CPU#1
> 	PCI-CFG read returns 0xFF's		PCI-CFG read returns 0xFF's
> 	PE not fenced				PE not fenced
> 	PE marked as fenced			PE marked as fenced
> 	EEH event to EEH core			EEH event to EEH core
> 
> >Generally speaking, I'm thinking this file should contain less stuff, most of
> >it should move into the ioda backend, the interrupt just turning into some
> >request down to the existing EEH thread.
> >
> 
> Yeah, I'll move most of the stuff into eeh-ioda.c with above scheme applied :-)

Cheers,
Ben.
