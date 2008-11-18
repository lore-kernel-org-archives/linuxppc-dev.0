Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp103.mail.mud.yahoo.com (smtp103.mail.mud.yahoo.com
	[209.191.85.213]) by ozlabs.org (Postfix) with SMTP id 1322DDDE19
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 21:31:28 +1100 (EST)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Large stack usage in fs code (especially for PPC64)
Date: Tue, 18 Nov 2008 21:24:32 +1100
References: <alpine.DEB.1.10.0811171508300.8722@gandalf.stny.rr.com>
	<18722.2107.970887.768477@cargo.ozlabs.ibm.com>
	<alpine.LFD.2.00.0811171752450.18283@nehalem.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0811171752450.18283@nehalem.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200811182124.33141.nickpiggin@yahoo.com.au>
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

On Tuesday 18 November 2008 13:08, Linus Torvalds wrote:
> On Tue, 18 Nov 2008, Paul Mackerras wrote:
> > Also, you didn't respond to my comments about the purely software
> > benefits of a larger page size.
>
> I realize that there are benefits. It's just that the downsides tend to
> swamp the upsides.
>
> The fact is, Intel (and to a lesser degree, AMD) has shown how hardware
> can do good TLB's with essentially gang lookups, giving almost effective
> page sizes of 32kB with hardly any of the downsides. Couple that with

It's much harder to do this with powerpc I think because they would need
to calculate 8 hashes and touch 8 cachelines to prefill 8 translations,
wouldn't they?


> low-latency fault handling (for not when you miss in the TLB, but when
> something really isn't in the page tables), and it seems to be seldom the
> biggest issue.
>
> (Don't get me wrong - TLB's are not unimportant on x86 either. But on x86,
> things are generally much better).

The per-page processing costs are interesting too, but IMO there is more
work that should be done to speed up order-0 pages. The patches I had to
remove the sync instruction for smp_mb() in unlock_page sped up pagecache
throughput (populate, write(2), reclaim) on my G5 by something really
crazy like 50% (most of that's in, but I'm still sitting on that fancy
unlock_page speedup to remove the final smp_mb).

I suspect some of the costs are also in powerpc specific code to insert
linux ptes into their hash table. I think some of the synchronisation for
those could possibly be shared with generic code so you don't need the
extra layer of locks there.
