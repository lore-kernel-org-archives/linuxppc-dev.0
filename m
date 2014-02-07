Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 47EB72C0078
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 21:45:39 +1100 (EST)
Date: Fri, 7 Feb 2014 11:45:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH] Convert powerpc simple spinlocks into ticket locks
Message-ID: <20140207104530.GG5126@laptop.programming.kicks-ass.net>
References: <20140206103736.GA18054@lst.de>
 <20140206163837.GT2936@laptop.programming.kicks-ass.net>
 <20140206173727.GA13048@lst.de>
 <1391717992.6733.232.camel@snotra.buserror.net>
 <20140207090248.GB26811@lst.de>
 <20140207103139.GP5002@laptop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140207103139.GP5002@laptop.programming.kicks-ass.net>
Cc: Tom Musta <tommusta@gmail.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Scott Wood <scottwood@freescale.com>,
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

On Fri, Feb 07, 2014 at 11:31:39AM +0100, Peter Zijlstra wrote:
> Anyway, what might work is something like (please forgive my ppc asm, I
> can barely read the thing, I've never before attempted writing it):
> 
> lock:
> 1:	lharx	%0, 0, &head
> 	mov	%1, %0
> 	addic	%0, %0, 1
> 	stwcd   %0, 0, &head
> 	bne-	1b
> 2:	lhax	%0, 0, &tail

That might need to be lhz too, I'm confused on all the load variants.

> 	lwsync
> 	cmp	0, %0, %0

	cmp	0, %0, %1

So we compare the &tail load to the xadd return %1 above.

> 	bne-	2b
> 
> 
> unlock:
> 	lhz	%0, 0, &tail
> 	addic	%0, %0, 1
> 	lwsync
> 	sth	%0, 0, &tail
> 
