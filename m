Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zT0hK2ZlpzF0Tc
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jan 2018 13:53:21 +1100 (AEDT)
Date: Sat, 27 Jan 2018 13:34:11 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [RFC PATCH] powerpc/powernv: Provide a way to force a core into
 SMT4 mode
Message-ID: <20180127023411.GA5360@fergus.ozlabs.ibm.com>
References: <20180125050512.GA18744@fergus.ozlabs.ibm.com>
 <20180127010610.GA5428@ram.oc3035372033.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180127010610.GA5428@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 26, 2018 at 05:06:10PM -0800, Ram Pai wrote:
> On Thu, Jan 25, 2018 at 04:05:12PM +1100, Paul Mackerras wrote:
> > POWER9 processors up to and including "Nimbus" v2.2 have hardware
> > bugs relating to transactional memory and thread reconfiguration.
> > One of these bugs has a workaround which is to get the core into
> > SMT4 state temporarily.  This workaround is only needed when
> > running bare-metal.
> 
> ..snip..
> >   */
> >  _GLOBAL(power9_idle_stop)
> >  	std	r3, PACA_REQ_PSSCR(r13)
> 	
> this instruction can go a little later and save a few cycles, in the
> case it need not have to stop ?
> 
> > +	sync
> > +	lwz	r5, PACA_DONT_STOP(r13)
> > +	cmpwi	r5, 0
> > +	bne	1f
> 
> I mean 'std r3, ...' can move here.

That would introduce a race condition, where this thread would miss
seeing the other thread's store to paca->dont_stop, and the other
thread would miss seeing this thread's store to paca->requested_psscr.

> > +	/* order setting dont_stop vs testing requested_psscr */
> > +	mb();
> > +	for (thr = 0; thr < threads_per_core; ++thr) {
> > +		if (!tpaca[thr].requested_psscr)
> > +			++awake_threads;
> > +		else
> > +			poke_threads |= (1 << thr);
> 
> 			ppc_msgsnd(...)  can be called here in the else part?

It could, but I wanted to avoid disturbing the other threads with the
msgsnd if it was not necessary.  Hence the second loop to do the
msgsnds once we have determined that we really need to do them.

> 	
> > +	}
> > +
> > +	/* If at least 3 threads are awake, the core is in SMT4 already */
> 
> small nitpick --  this comment mentions SMT4 and 3 threads. But the code
> is generically applicable to SMTn and (n-1) threads.

Sure - it's easier to understand a concrete example than something
more general, that's why the comment is about the specific use case
not the general capability of the code.

> > +	if (awake_threads < threads_per_core - 1) {
> 
> 
> > +		/* We have to wake some threads; we'll use msgsnd */
> > +		for (thr = 0; thr < threads_per_core; ++thr) {
> > +			if (poke_threads & (1 << thr))
> > +				ppc_msgsnd(PPC_DBELL_MSGTYPE, 0,
> > +					   tpaca[thr].hw_cpu_id);
> > +		}
> 
> and this loop can be deleted, which inturn can leads to further optimizations.

... at the cost of other threads taking doorbell interrupts
unnecessarily.  I thought it better to put more burden on the thread
needing this synchronization and less on the other threads (on
average).

Paul.
