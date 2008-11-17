Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 962FADDE1B
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 10:13:46 +1100 (EST)
Subject: Re: Large stack usage in fs code (especially for PPC64)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0811171300410.18283@nehalem.linux-foundation.org>
References: <alpine.DEB.1.10.0811171508300.8722@gandalf.stny.rr.com>
	<alpine.LFD.2.00.0811171300410.18283@nehalem.linux-foundation.org>
Content-Type: text/plain
Date: Tue, 18 Nov 2008 10:13:16 +1100
Message-Id: <1226963596.7178.254.camel@pasglop>
Mime-Version: 1.0
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


> Well, it's not unacceptable on good CPU's with 4kB blocks (just an 8-entry 
> array), but as you say:
> 
> > On PPC64 I'm told that the page size is 64K, which makes the above equal 
> > to: 64K / 512 = 128  multiply that by 8 byte words, we have 1024 bytes.
> 
> Yeah. Not good. I think 64kB pages are insane. In fact, I think 32kB 
> pages are insane, and 16kB pages are borderline. I've told people so.
> 
> The ppc people run databases, and they don't care about sane people 
> telling them the big pages suck.

Hehe :-)

Guess who is pushing for larger page sizes nowadays ? Embedded
people :-) In fact, we have patches submited on the list to offer the
option for ... 256K pages on some 44x embedded CPUs :-)

It makes some sort of sense I suppose on very static embedded workloads
with no swap nor demand paging.

> It's made worse by the fact that they 
> also have horribly bad TLB fills on their broken CPU's, and years and 
> years of telling people that the MMU on ppc's are sh*t has only been 
> reacted to with "talk to the hand, we know better".

Who are you talking about here precisely ? I don't think either Paul or
I every said something nearly around those lines ... Oh well.

But yeah, our existing server CPUs have pretty poor TLB refills and yes,
64K pages help. And yes, we would like things to be different, but they
aren't.

But there is also pressure to get larger page sizes from small embedded
field, where CPUs have even poorer TLB refill (software loaded
basically) :-)

> Quite frankly, 64kB pages are INSANE. But yes, in this case they actually 
> cause bugs. With a sane page-size, that *arr[MAX_BUF_PER_PAGE] thing uses 
> 64 bytes, not 1kB.

Come on, the code is crap to allocate that on the stack anyway :-)

> Of course, that would likely mean that FAT etc wouldn't work on ppc64, so 
> I don't think that's a valid model either. But if the 64kB page size is 
> just a "database server crazy-people config option", then maybe it's 
> acceptable.

Well, as I said, embedded folks are wanting that too ...

Cheers,
Ben.
