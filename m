Return-Path: <fweisbec@gmail.com>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225]) by ozlabs.org (Postfix) with ESMTP id 9236CB7C8E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Apr 2010 03:15:58 +1000 (EST)
Received: by bwz25 with SMTP id 25so1669503bwz.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Apr 2010 10:15:55 -0700 (PDT)
Date: Thu, 15 Apr 2010 19:15:55 +0200
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: linux-next: PowerPC WARN_ON_ONCE() after merge of the final
	tree (tip related)
Message-ID: <20100415171551.GA5069@nowhere>
References: <20100415161214.04637496.sfr@canb.auug.org.au>
	<20100415064940.GA9240@elte.hu> <20100415130032.GA6789@nowhere>
	<20100415140358.GA19981@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100415140358.GA19981@elte.hu>
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

On Thu, Apr 15, 2010 at 04:03:58PM +0200, Ingo Molnar wrote:
> > In this case, I guess the following fix should be sufficient?
> > I'm going to test it and provide a sane changelog.
> > 
> > 
> > diff --git a/kernel/lockdep.c b/kernel/lockdep.c
> > index 78325f8..65d4336 100644
> > --- a/kernel/lockdep.c
> > +++ b/kernel/lockdep.c
> > @@ -2298,7 +2298,11 @@ void trace_hardirqs_on_caller(unsigned long ip)
> >  		return;
> >  
> >  	if (unlikely(curr->hardirqs_enabled)) {
> > +		unsigned long flags;
> > +
> > +		raw_local_irq_save(flags);
> >  		debug_atomic_inc(redundant_hardirqs_on);
> > +		raw_local_irq_restore(flags);
> >  		return;
> >  	}
> >  	/* we'll do an OFF -> ON transition: */
> 
> that looks rather ugly. Why not do a raw:
> 
> 	this_cpu_inc(lockdep_stats.redundant_hardirqs_on);
> 
> which basically open-codes debug_atomic_inc(), but without the warning?


Because that would open a race against interrupts that might
touch lockdep_stats.redundant_hardirqs_on too.

If you think it's not very important (this race must be pretty rare I guess),
I can use your solution.



> 
> Btw., using the this_cpu() methods might result in faster code for all the 
> debug_atomic_inc() macros as well?


Indeed, will change that too.

Thanks.
