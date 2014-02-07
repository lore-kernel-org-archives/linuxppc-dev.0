Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 447B02C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 19:24:43 +1100 (EST)
Date: Fri, 7 Feb 2014 09:24:37 +0100
From: Torsten Duwe <duwe@lst.de>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Convert powerpc simple spinlocks into ticket locks
Message-ID: <20140207082437.GA26811@lst.de>
References: <20140206103736.GA18054@lst.de>
 <20140206163837.GT2936@laptop.programming.kicks-ass.net>
 <20140206173727.GA13048@lst.de>
 <20140206180826.GI5002@laptop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140206180826.GI5002@laptop.programming.kicks-ass.net>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
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

On Thu, Feb 06, 2014 at 07:08:26PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 06, 2014 at 06:37:27PM +0100, Torsten Duwe wrote:
> > I must admit that I haven't tested the patch on non-pseries ppc64 nor on
> > ppc32. Only ppc64 has the ldarx and I tried to atomically replace the 
> > holder along with the locks. That might prove unneccessary.
> 
> But what is the holder for? Can't we do away with that field?

Scott, Peter: good questions.
The conditional is wrong because I confused pSeries with ppc64 CPUs with
64-bit kernels. I got deluded by the LOCK_TOKEN definition above. Is that
correctly ifdef'd, with PPC64? The holder field should be ifdef'd
CONFIG_PPC_SPLPAR, independent of ppc64.

It is an advisory performance hint, and doesn't need to be updated atomically
with the lock; this and the above are 2 reasons to drop the asm string
operand size voodoo as well.

Thanks,
	Torsten
