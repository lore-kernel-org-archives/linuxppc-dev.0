Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 413022C139B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Feb 2014 03:10:14 +1100 (EST)
Date: Fri, 7 Feb 2014 17:10:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Convert powerpc simple spinlocks into ticket locks
Message-ID: <20140207161004.GD9987@twins.programming.kicks-ass.net>
References: <20140206103736.GA18054@lst.de>
 <20140206163837.GT2936@laptop.programming.kicks-ass.net>
 <20140206173727.GA13048@lst.de>
 <1391717992.6733.232.camel@snotra.buserror.net>
 <20140207090248.GB26811@lst.de>
 <87C29DBB-41E7-4B6C-9089-3C7756FBAE07@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <87C29DBB-41E7-4B6C-9089-3C7756FBAE07@kernel.crashing.org>
Cc: Tom Musta <tommusta@gmail.com>, linux-kernel@vger.kernel.org,
 Torsten Duwe <duwe@lst.de>, Anton Blanchard <anton@samba.org>,
 Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 07, 2014 at 09:51:16AM -0600, Kumar Gala wrote:
> 
> On Feb 7, 2014, at 3:02 AM, Torsten Duwe <duwe@lst.de> wrote:
> 
> > On Thu, Feb 06, 2014 at 02:19:52PM -0600, Scott Wood wrote:
> >> On Thu, 2014-02-06 at 18:37 +0100, Torsten Duwe wrote:
> >>> On Thu, Feb 06, 2014 at 05:38:37PM +0100, Peter Zijlstra wrote:
> >> 
> >>>> Can you pair lwarx with sthcx ? I couldn't immediately find the answer
> >>>> in the PowerISA doc. If so I think you can do better by being able to
> >>>> atomically load both tickets but only storing the head without affecting
> >>>> the tail.
> > 
> > Can I simply write the half word, without a reservation, or will the HW caches
> > mess up the other half? Will it ruin the cache coherency on some (sub)architectures?
> 
> The coherency should be fine, I just can’t remember if you’ll lose the reservation by doing this.

It should; I suppose; seeing how you 'destroy' the state it got from the
load.

> >> Plus, sthcx doesn't exist on all PPC chips.
> > 
> > Which ones are lacking it? Do all have at least a simple 16-bit store?
> 
> Everything implements a simple 16-bit store, just not everything implements the store conditional of 16-bit data.

Ok, so then the last version I posted should work on those machines.
