Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 02B542C0090
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Nov 2013 03:11:42 +1100 (EST)
Date: Fri, 1 Nov 2013 17:11:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: perf events ring buffer memory barrier on powerpc
Message-ID: <20131101161129.GU16117@laptop.programming.kicks-ass.net>
References: <20131025173749.GG19466@laptop.lan>
 <CAFTL4hxn47KFKZPLgKeBxxdaAbA4vg9QVzctuW4ZrSgmfX5bAQ@mail.gmail.com>
 <OFB9096CCA.68AAFFFB-ON42257C12.0044F107-42257C12.00457129@il.ibm.com>
 <20131028132634.GO19466@laptop.lan>
 <20131028163418.GD4126@linux.vnet.ibm.com>
 <20131028201735.GA15629@redhat.com>
 <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131030092725.GL4126@linux.vnet.ibm.com>
 <20131030112526.GI16117@laptop.programming.kicks-ass.net>
 <20131031064015.GV4126@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131031064015.GV4126@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 Oleg Nesterov <oleg@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Victor Kaplansky <VICTORK@il.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 30, 2013 at 11:40:15PM -0700, Paul E. McKenney wrote:
> > void kbuf_write(int sz, void *buf)
> > {
> > 	u64 tail = ACCESS_ONCE(ubuf->tail); /* last location userspace read */
> > 	u64 offset = kbuf->head; /* we already know where we last wrote */
> > 	u64 head = offset + sz;
> > 
> > 	if (!space(tail, offset, head)) {
> > 		/* discard @buf */
> > 		return;
> > 	}
> > 
> > 	/*
> > 	 * Ensure that if we see the userspace tail (ubuf->tail) such
> > 	 * that there is space to write @buf without overwriting data
> > 	 * userspace hasn't seen yet, we won't in fact store data before
> > 	 * that read completes.
> > 	 */
> > 
> > 	smp_mb(); /* A, matches with D */
> > 
> > 	write(kbuf->data + offset, buf, sz);
> > 	kbuf->head = head % kbuf->size;
> > 
> > 	/*
> > 	 * Ensure that we write all the @buf data before we update the
> > 	 * userspace visible ubuf->head pointer.
> > 	 */
> > 	smp_wmb(); /* B, matches with C */
> > 
> > 	ubuf->head = kbuf->head;
> > }

> > Now the whole crux of the question is if we need barrier A at all, since
> > the STORES issued by the @buf writes are dependent on the ubuf->tail
> > read.
> 
> The dependency you are talking about is via the "if" statement?
> Even C/C++11 is not required to respect control dependencies.

But surely we must be able to make it so; otherwise you'd never be able
to write:

void *ptr = obj1;

void foo(void)
{

	/* create obj2, obj3 */

	smp_wmb(); /* ensure the objs are complete */

	/* expose either obj2 or obj3 */
	if (x)
		ptr = obj2;
	else
		ptr = obj3;


	/* free the unused one */
	if (x)
		free(obj3);
	else
		free(obj2);
}

Earlier you said that 'volatile' or '__atomic' avoids speculative
writes; so would:

volatile void *ptr = obj1;

Make the compiler respect control dependencies again? If so, could we
somehow mark that !space() condition volatile?

Currently the above would be considered a valid pattern. But you're
saying its not because the compiler is free to expose both obj2 and obj3
(for however short a time) and thus the free of the 'unused' object is
incorrect and can cause use-after-free.

In fact; how can we be sure that:

void *ptr = NULL;

void bar(void)
{
	void *obj = malloc(...);

	/* fill obj */

	if (!err)
		rcu_assign_pointer(ptr, obj);
	else
		free(obj);
}

Does not get 'optimized' into:

void bar(void)
{
	void *obj = malloc(...);
	void *old_ptr = ptr;

	/* fill obj */

	rcu_assign_pointer(ptr, obj);
	if (err) { /* because runtime profile data says this is unlikely */
		ptr = old_ptr;
		free(obj);
	}
}

We _MUST_ be able to rely on control flow, otherwise me might as well
all go back to writing kernels in asm.
