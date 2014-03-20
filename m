Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id ED25C2C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 07:24:13 +1100 (EST)
Message-ID: <1395346982.3460.23.camel@pasglop>
Subject: Re: Tasks stuck in futex code (in 3.14-rc6)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: torvalds@linux-foundation.org
Date: Fri, 21 Mar 2014 07:23:02 +1100
In-Reply-To: <1395333093.14694.3.camel@buesod1.americas.hpqcorp.net>
References: <20140319152619.GB10406@linux.vnet.ibm.com>
 <20140319154705.GB8557@laptop.programming.kicks-ass.net>
 <20140319170829.GD8557@laptop.programming.kicks-ass.net>
 <20140320053350.GB30295@linux.vnet.ibm.com>
 <1395295019.2612.11.camel@buesod1.americas.hpqcorp.net>
 <1395333093.14694.3.camel@buesod1.americas.hpqcorp.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 paulus@samba.org, Davidlohr Bueso <davidlohr@hp.com>, tglx@linutronix.de,
 Paul McKenney <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-03-20 at 09:31 -0700, Davidlohr Bueso wrote:
> hmmm looking at ppc spinlock code, it seems that it doesn't have ticket
> spinlocks -- in fact Torsten Duwe has been trying to get them upstream
> very recently. Since we rely on the counter for detecting waiters, this
> might explain the issue. Could someone confirm this spinlock
> implementation difference? 

Indeed. I haven't merged ticket locks because they break lockref :-(

We have a problem here because we need to store the lock holder so we
can yield to the lock holder partition on contention and we are running
out of space in the spinlock.

The lock holder doesn't have to be atomic, so in theory we could have
the tickets and the lockref in the same 64-bit and the holder separately
but the way the layers are stacked at the moment that's not workable,
at least not without duplicating the whole lockref implementation and
breaking the spinlock in two, a "base" lock without older and the separate
variant with holder field. A mess...

I want to try sorting that out at some stage but haven't had a chance yet.

Cheers,
Ben.
