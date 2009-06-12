Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BFE9FB71D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 23:44:46 +1000 (EST)
Date: Fri, 12 Jun 2009 15:44:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: linux-next: origin tree build failure
Message-ID: <20090612134428.GC32105@elte.hu>
References: <20090612102427.32582baa.sfr@canb.auug.org.au>
	<1244768406.7172.1.camel@pasglop> <20090612092054.GB32052@elte.hu>
	<1244799197.7172.106.camel@pasglop>
	<20090612125335.GH31845@elte.hu>
	<1244812224.7172.146.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1244812224.7172.146.camel@pasglop>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	paulus@samba.org, Linus <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> > linux-next should not be second-guessing maintainers and should 
> > not act as an "approval forum" for controversial features, 
> > increasing the (already quite substantial) pressure on 
> > maintainers to apply more crap.
> 
> I agree here. That's not the point. The idea is that for things 
> that -are- approved by their respective maintainers, to get some 
> integration testing and ironing of those mechanical bugs so that 
> by the time they hit mainstream, they don't break bisection among 
> others.

This is certainly doable for agreeable features - which is the bulk 
- and it is being done.

But this is a catch-22 for _controversial_ new features - which 
perfcounters clearly was, in case you turned off your lkml 
subscription ;-)

And if you hit that build breakage during bisection you can do:

   git cherry-pick e14112d

Also, you seem to brush off the notion that far more bugs slip 
through linux-next than get caught by it.

So if you think linux-next matters in terms of _regression_ testing, 
the numbers dont seem to support that notion. This particular 
incident does support that notion though, granted - but it's taken 
out of context IMHO:

In terms of test coverage, at least for our trees, less than 1% of 
the bugs we handle get reported in a linux-next context - and most 
of the bugs that get reported (against say the scheduler tree) are 
related to rare architectures.

In fact, i checked, there were _zero_ x86 bugs reported against 
linux-next and solved against it between v2.6.30-rc1 and v2.6.30:

   git log --grep=next -i v2.6.30-rc1..v2.6.30 arch/x86/

Doing it over the full cycle shows one commit altogether - a Xen 
build failure. In fact, i just checked the whole stabilization cycle 
for the whole kernel (v2.6.30-rc1..v2.6.30-final), and there were 
only 5 linux-next originated patches, most of them build failures.

I did this by looking at all occurances of 'next', in all commit 
logs:

   git log --grep=next -i v2.6.30-rc1..v2.6.30

and then manually checking the context of all 'next' matches and 
counting the linux-next related commits.

So lets be generous and say that because some people dont put the 
bug report originator into the changelog it was four times as many, 
20 - but that's still dwarved by the sheer amount of post-rc1 
changes: thousands of changes and hundreds of regressions.

linux-next is mostly useful (to me at least) not for the 
cross-builds it does, but in terms of mapping out upcoming conflicts 
- which also drives early detection of problematic patches and 
problematic conflicts.

	Ingo
