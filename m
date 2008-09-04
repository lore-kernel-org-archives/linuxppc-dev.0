Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id E958FDDF46
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 17:24:37 +1000 (EST)
Date: Thu, 4 Sep 2008 09:22:52 +0200
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 2/2] powerpc - Make the irq reverse mapping radix tree
	lockless
Message-ID: <20080904092252.12b3df4a@bull.net>
In-Reply-To: <1220496739.4879.20.camel@pasglop>
References: <1218029429-21114-1-git-send-email-sebastien.dugue@bull.net>
	<1218029429-21114-3-git-send-email-sebastien.dugue@bull.net>
	<1219209781.21386.25.camel@pasglop>
	<20080903154105.7dff49db@bull.net>
	<1220496739.4879.20.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: dwalker@mvista.com, tinytim@us.ibm.com, linux-rt-users@vger.kernel.org,
	jean-pierre.dion@bull.net, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, michael@ellerman.id.au,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	gilles.carry@ext.bull.net, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 04 Sep 2008 12:52:19 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2008-09-03 at 15:41 +0200, Sebastien Dugue wrote:
> > On Wed, 20 Aug 2008 15:23:01 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > > BTW. It would be good to try to turn the GFP_ATOMIC into GFP_KERNEL,
> > 
> >   That would be nice indeed
> > 
> > > maybe using a semaphore instead of a lock to protect insertion vs.
> > > initialisation.
> > 
> >   a semaphore? are you meaning a mutex? If not, I fail to understand what you're
> > implying.
> 
> Right, a mutex, bad habit calling those semaphores from the old days :-)

  OK, then we're on the same line ;-)

> 
> >   Right, that's the problem with this new scheme and I'm still trying
> > to find a way to handle memory allocation failures be it for GFP_ATOMIC or
> > GFP_KERNEL.
> > 
> >   I could not think of anything simple so far and I'm open for suggestions.
> 
> GFP_KERNEL should not fail, it will just block no ?

  No it won't block and will fail (returns NULL).

> If it fails, it's
> probably catastrophic enough not to care.

  Yep, I'd tend to agree with that.

> You can always fallback to linear lookup.

  I will have to add that back as there is no more fallback.

> I don't know if it's worth trying to fire off a new
> allocation attempt later, probably not.

  I've been pondering with this lately, but I think that adding a linear
lookup fallback should be OK.

  Thanks,

  Sebastien.

> 
> Ben.
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
