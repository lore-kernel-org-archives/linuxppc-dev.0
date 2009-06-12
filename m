Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EF1B3B7196
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 22:53:53 +1000 (EST)
Date: Fri, 12 Jun 2009 14:53:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: linux-next: origin tree build failure
Message-ID: <20090612125335.GH31845@elte.hu>
References: <20090612102427.32582baa.sfr@canb.auug.org.au>
	<1244768406.7172.1.camel@pasglop> <20090612092054.GB32052@elte.hu>
	<1244799197.7172.106.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1244799197.7172.106.camel@pasglop>
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

> > Ah - thanks. The bug was caused by me being a bit too optimistic 
> > in applying the shiny-new Power7 support patches on the last 
> > day. (nice CPU btw.)
> 
> In that case paulus tells me it's actually Peter screwing up 
> moving something from the powerpc code to generic :-)

Yes, but i committed it and it's my task to make sure that the thing 
works as a whole so it's my fault still :)

>  .../...
> 
> > Such bugs happen, and they are easy enough to fix. What matters 
> > arent the 1-2 short-lived bugs that do happen when a new 
> > combination of trees is created, but the long-lived combination 
> > bugs and conflicts.
> 
> I'm not saying -next would fix world hunger ... but in this case 
> we have two sets of issues, perfctr and the init ordering change 
> which both got merged totally bypassing -next... We should at 
> least -try- to follow the process we've defined, don't you think ?

You are trying to define a process that does not exist in that form 
and which never existed in that form.

It was never true that new code _MUST_ go via linux-next - and i 
hope it will never be true.

linux-next has integration testing so that interactions between 
maintainer trees are mapped and that architectures that otherwise 
few people use get build-tested too (well beyond their practical 
relevance, i have to add) - but there's little critical review done 
in linux-next. Nor should it be the forum for that, it simply 
contains way too much stuff and has a weird history format with 
daily rebases that makes review hard and expensive in that form.

linux-next should not be second-guessing maintainers and should not 
act as an "approval forum" for controversial features, increasing 
the (already quite substantial) pressure on maintainers to apply 
more crap.

And that is true even if it's a new feature that i happen to support 
- as in this case - it sure would have been handy to have more 
perfcounters test coverage, every little bit of extra testing helps.

If linux-next wants to do that then it should be renamed to 
something else and not called linux-next.

	Ingo
