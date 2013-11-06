Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DEBA52C0094
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Nov 2013 06:43:12 +1100 (EST)
Date: Wed, 6 Nov 2013 20:42:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC] arch: Introduce new TSO memory barrier smp_tmb()
Message-ID: <20131106194244.GL16117@laptop.programming.kicks-ass.net>
References: <CA+55aFyD_kCkAHQwHCUBrumO-pH6LaZikTNvyWDW_tWsHdqk6Q@mail.gmail.com>
 <20131104105059.GL3947@linux.vnet.ibm.com>
 <20131104112254.GK28601@twins.programming.kicks-ass.net>
 <20131104162732.GN3947@linux.vnet.ibm.com>
 <20131104191127.GW16117@laptop.programming.kicks-ass.net>
 <20131104205344.GW3947@linux.vnet.ibm.com>
 <20131106123946.GJ10651@twins.programming.kicks-ass.net>
 <CAMuHMdXZjQJvT7R4ODbDNBgAVwPUBPjB6UoR66_sNuFx7opUDw@mail.gmail.com>
 <20131106135736.GK10651@twins.programming.kicks-ass.net>
 <20131106184848.GM18245@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131106184848.GM18245@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, Tony Luck <tony.luck@intel.com>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Oleg Nesterov <oleg@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Anton Blanchard <anton@samba.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Victor Kaplansky <VICTORK@il.ibm.com>, Russell King <linux@arm.linux.org.uk>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 06, 2013 at 10:48:48AM -0800, Paul E. McKenney wrote:
> A few nits on Documentation/memory-barriers.txt and some pointless
> comments elsewhere.  With the suggested Documentation/memory-barriers.txt
> fixes:
> 
> Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

Thanks, I think I'll cut the thing into a number of smaller patches with
identical end result. Will (hopefully) post a full new series tomorrow
somewhere.

I was thinking like:
 1 - aggressively employ asm-generic/barrier.h
 2 - Reformulate _The_ document to ACQUIRE/RELEASE
 3 - add the new store/load thingies

That should hopefully be slightly easier to look at.
