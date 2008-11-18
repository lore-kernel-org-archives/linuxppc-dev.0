Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A8D16DDDEA
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 03:02:38 +1100 (EST)
Date: Tue, 18 Nov 2008 08:02:10 -0800 (PST)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Large stack usage in fs code (especially for PPC64)
In-Reply-To: <200811182124.33141.nickpiggin@yahoo.com.au>
Message-ID: <alpine.LFD.2.00.0811180800120.18283@nehalem.linux-foundation.org>
References: <alpine.DEB.1.10.0811171508300.8722@gandalf.stny.rr.com>
	<18722.2107.970887.768477@cargo.ozlabs.ibm.com>
	<alpine.LFD.2.00.0811171752450.18283@nehalem.linux-foundation.org>
	<200811182124.33141.nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Tue, 18 Nov 2008, Nick Piggin wrote:
> >
> > The fact is, Intel (and to a lesser degree, AMD) has shown how hardware
> > can do good TLB's with essentially gang lookups, giving almost effective
> > page sizes of 32kB with hardly any of the downsides. Couple that with
> 
> It's much harder to do this with powerpc I think because they would need
> to calculate 8 hashes and touch 8 cachelines to prefill 8 translations,
> wouldn't they?

Oh, absolutely. It's why I despise hashed page tables. It's a broken 
concept.

> The per-page processing costs are interesting too, but IMO there is more
> work that should be done to speed up order-0 pages. The patches I had to
> remove the sync instruction for smp_mb() in unlock_page sped up pagecache
> throughput (populate, write(2), reclaim) on my G5 by something really
> crazy like 50% (most of that's in, but I'm still sitting on that fancy
> unlock_page speedup to remove the final smp_mb).
> 
> I suspect some of the costs are also in powerpc specific code to insert
> linux ptes into their hash table. I think some of the synchronisation for
> those could possibly be shared with generic code so you don't need the
> extra layer of locks there.

Yeah, the hashed page tables get extra costs from the fact that it can't 
share the software page tables with the hardware ones, and the associated 
coherency logic. It's even worse at unmap time, I think.

			Linus
