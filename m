Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 88F86B7091
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 20:32:15 +1000 (EST)
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by fallback.mail.elte.hu with esmtp (Exim) id 1MF2wh-0006OU-RI
	from <mingo@elte.hu>
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2009 11:21:11 +0200
Date: Fri, 12 Jun 2009 11:20:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: linux-next: origin tree build failure
Message-ID: <20090612092054.GB32052@elte.hu>
References: <20090612102427.32582baa.sfr@canb.auug.org.au>
	<1244768406.7172.1.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1244768406.7172.1.camel@pasglop>
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

> On Fri, 2009-06-12 at 10:24 +1000, Stephen Rothwell wrote:
> 
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Fri, 12 Jun 2009 10:14:22 +1000
> > Subject: [PATCH] perfcounters: remove powerpc definitions of perf_counter_do_pending
> > 
> > Commit 925d519ab82b6dd7aca9420d809ee83819c08db2 ("perf_counter:
> > unify and fix delayed counter wakeup") added global definitions.
> > 
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Ah - thanks. The bug was caused by me being a bit too optimistic in 
applying the shiny-new Power7 support patches on the last day. (nice 
CPU btw.)

> Linus, please apply. BTW, This is _EXACTLY_ why this should have 
> been in -next for a few days before being merged :-(

Not really: for example current upstream is build-broken on x86 due 
to an integration artifact via the kmemleak tree - despite it having 
been in linux-next for months.

Paulus was building and booting powerpc on a daily basis and i ran 
cross-builds as well.

Such bugs happen, and they are easy enough to fix. What matters 
arent the 1-2 short-lived bugs that do happen when a new combination 
of trees is created, but the long-lived combination bugs and 
conflicts.

	Ingo
