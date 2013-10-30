Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B2C6A2C0393
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 02:39:52 +1100 (EST)
Date: Wed, 30 Oct 2013 16:39:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Victor Kaplansky <VICTORK@il.ibm.com>
Subject: Re: perf events ring buffer memory barrier on powerpc
Message-ID: <20131030153931.GM16117@laptop.programming.kicks-ass.net>
References: <20131025173749.GG19466@laptop.lan>
 <CAFTL4hxn47KFKZPLgKeBxxdaAbA4vg9QVzctuW4ZrSgmfX5bAQ@mail.gmail.com>
 <OFB9096CCA.68AAFFFB-ON42257C12.0044F107-42257C12.00457129@il.ibm.com>
 <20131028132634.GO19466@laptop.lan>
 <20131028163418.GD4126@linux.vnet.ibm.com>
 <20131028201735.GA15629@redhat.com>
 <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131030092725.GL4126@linux.vnet.ibm.com>
 <20131030112526.GI16117@laptop.programming.kicks-ass.net>
 <OFF6C78E48.E477DB1E-ON42257C14.0050F9B3-42257C14.0051AC6D@il.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFF6C78E48.E477DB1E-ON42257C14.0050F9B3-42257C14.0051AC6D@il.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 LKML <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 30, 2013 at 04:52:05PM +0200, Victor Kaplansky wrote:
> Peter Zijlstra <peterz@infradead.org> wrote on 10/30/2013 01:25:26 PM:
> 
> > Also, I'm not entirely sure on C, that too seems like a dependency, we
> > simply cannot read the buffer @tail before we've read the tail itself,
> > now can we? Similarly we cannot compare tail to head without having the
> > head read completed.
> 
> No, this one we cannot omit, because our problem on consumer side is not
> with @tail, which is written exclusively by consumer, but with @head.

Ah indeed, my argument was flawed in that @head is the important part.
But we still do a comparison of @tail against @head before we do further
reads.

Although I suppose speculative reads are allowed -- they don't have the
destructive behaviour speculative writes have -- and thus we could in
fact get reorder issues.

But since it is still a dependent load in that we do that @tail vs @head
comparison before doing other loads, wouldn't a read_barrier_depends()
be sufficient? Or do we still need a complete rmb?

> BTW, it is why you also don't need ACCESS_ONCE() around @tail, but only
> around
> @head read.

Agreed, the ACCESS_ONCE() around tail is superfluous since we're the one
updating tail, so there's no problem with the value changing
unexpectedly.
