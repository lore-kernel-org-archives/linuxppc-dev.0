Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 02ED3B7D0F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Apr 2010 03:40:13 +1000 (EST)
Date: Thu, 15 Apr 2010 19:39:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: linux-next: PowerPC WARN_ON_ONCE() after merge of the final tree
	(tip related)
Message-ID: <20100415173955.GA10881@elte.hu>
References: <20100415161214.04637496.sfr@canb.auug.org.au>
	<20100415064940.GA9240@elte.hu> <20100415130032.GA6789@nowhere>
	<20100415140358.GA19981@elte.hu> <20100415172421.GB5069@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100415172421.GB5069@nowhere>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Frederic Weisbecker <fweisbec@gmail.com> wrote:

> On Thu, Apr 15, 2010 at 04:03:58PM +0200, Ingo Molnar wrote:
> > > 
> > > 
> > > diff --git a/kernel/lockdep.c b/kernel/lockdep.c
> > > index 78325f8..65d4336 100644
> > > --- a/kernel/lockdep.c
> > > +++ b/kernel/lockdep.c
> > > @@ -2298,7 +2298,11 @@ void trace_hardirqs_on_caller(unsigned long ip)
> > >  		return;
> > >  
> > >  	if (unlikely(curr->hardirqs_enabled)) {
> > > +		unsigned long flags;
> > > +
> > > +		raw_local_irq_save(flags);
> > >  		debug_atomic_inc(redundant_hardirqs_on);
> > > +		raw_local_irq_restore(flags);
> > >  		return;
> > >  	}
> > >  	/* we'll do an OFF -> ON transition: */
> > 
> > that looks rather ugly. Why not do a raw:
> > 
> > 	this_cpu_inc(lockdep_stats.redundant_hardirqs_on);
> > 
> > which basically open-codes debug_atomic_inc(), but without the warning?
> 
> 
> There is also no guarantee we are in a non-preemptable section. We can then
> also race against another cpu.
> 
> I'm not sure what to do.

it's a statistics counter so worst-case we lose a count. It's not a real issue 
- but might be worth adding a comment.

	Ingo
