Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5D92B2C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 20:02:54 +1100 (EST)
Date: Fri, 7 Feb 2014 10:02:48 +0100
From: Torsten Duwe <duwe@lst.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Convert powerpc simple spinlocks into ticket locks
Message-ID: <20140207090248.GB26811@lst.de>
References: <20140206103736.GA18054@lst.de>
 <20140206163837.GT2936@laptop.programming.kicks-ass.net>
 <20140206173727.GA13048@lst.de>
 <1391717992.6733.232.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391717992.6733.232.camel@snotra.buserror.net>
Cc: Tom Musta <tommusta@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>,
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

On Thu, Feb 06, 2014 at 02:19:52PM -0600, Scott Wood wrote:
> On Thu, 2014-02-06 at 18:37 +0100, Torsten Duwe wrote:
> > On Thu, Feb 06, 2014 at 05:38:37PM +0100, Peter Zijlstra wrote:
> 
> > > Can you pair lwarx with sthcx ? I couldn't immediately find the answer
> > > in the PowerISA doc. If so I think you can do better by being able to
> > > atomically load both tickets but only storing the head without affecting
> > > the tail.

Can I simply write the half word, without a reservation, or will the HW caches
mess up the other half? Will it ruin the cache coherency on some (sub)architectures?

> Plus, sthcx doesn't exist on all PPC chips.

Which ones are lacking it? Do all have at least a simple 16-bit store?

	Torsten
