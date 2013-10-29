Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 552562C0336
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Oct 2013 07:15:20 +1100 (EST)
Date: Tue, 29 Oct 2013 21:15:46 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: perf events ring buffer memory barrier on powerpc
Message-ID: <20131029201546.GA4932@redhat.com>
References: <20131025173749.GG19466@laptop.lan>
 <CAFTL4hxn47KFKZPLgKeBxxdaAbA4vg9QVzctuW4ZrSgmfX5bAQ@mail.gmail.com>
 <OFB9096CCA.68AAFFFB-ON42257C12.0044F107-42257C12.00457129@il.ibm.com>
 <20131028132634.GO19466@laptop.lan>
 <20131028163418.GD4126@linux.vnet.ibm.com>
 <20131028201735.GA15629@redhat.com>
 <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131029102131.GA16117@laptop.programming.kicks-ass.net>
 <20131029103057.GN2490@laptop.programming.kicks-ass.net>
 <20131029103526.GO2490@laptop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131029103526.GO2490@laptop.programming.kicks-ass.net>
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 LKML <linux-kernel@vger.kernel.org>, Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Anton Blanchard <anton@samba.org>, Frederic Weisbecker <fweisbec@gmail.com>,
 Victor Kaplansky <VICTORK@il.ibm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/29, Peter Zijlstra wrote:
>
> On Tue, Oct 29, 2013 at 11:30:57AM +0100, Peter Zijlstra wrote:
> > @@ -154,9 +175,11 @@ int perf_output_begin(struct perf_output
> >  		 * Userspace could choose to issue a mb() before updating the
> >  		 * tail pointer. So that all reads will be completed before the
> >  		 * write is issued.
> > +		 *
> > +		 * See perf_output_put_handle().
> >  		 */
> >  		tail = ACCESS_ONCE(rb->user_page->data_tail);
> > -		smp_rmb();
> > +		smp_mb();
> >  		offset = head = local_read(&rb->head);
> >  		head += size;
> >  		if (unlikely(!perf_output_space(rb, tail, offset, head)))
>
> That said; it would be very nice to be able to remove this barrier. This
> is in every event write path :/

Yes.. And I'm afraid very much that I simply confused you. Perhaps Victor
is right and we do not need this mb(). So I am waiting for the end of
this story too.

And btw I do not understand why we need it (or smp_rmb) right after
ACCESS_ONCE(data_tail).

Oleg.
