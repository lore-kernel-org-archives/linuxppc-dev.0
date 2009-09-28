Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1912EB7BD9
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Sep 2009 13:21:08 +1000 (EST)
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache
	coherency rewrite
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OFEC38184A.A376E71D-ONC125763E.0048F581-C125763E.00497FD3@transmode.se>
References: <20090924004552.GA11737@compile2.chatsunix.int.mrv.com>
	<1253774659.7103.405.camel@pasglop>
	<20090924233346.GA445@compile2.chatsunix.int.mrv.com>
	<1253836376.7103.469.camel@pasglop>
	<20090925013528.GA2584@compile2.chatsunix.int.mrv.com>
	<1253843480.7103.492.camel@pasglop> <1253847827.7103.504.camel@pasglop>
	<20090925211848.GA3371@compile2.chatsunix.int.mrv.com>
	<OFEC38184A.A376E71D-ONC125763E.0048F581-C125763E.00497FD3@transmode.se>
Content-Type: text/plain
Date: Mon, 28 Sep 2009 13:21:00 +1000
Message-Id: <1254108060.8421.1.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2009-09-27 at 15:22 +0200, Joakim Tjernlund wrote:
> > However, adding tlbil_va() to ptep_set_access_flags() as you suggested
> > makes everything happy. I need to test it some more, but it looks good
> > so far. Below is what I am testing now.
> 
> 8xx, is getting very hacky and I suspect that the only long term fix is
> add code to trap the cache instructions in TLB error/miss and fixup the
> exception in page fault handler. This will also have the added benefit on being able
> to use the cache instructions in both kernel and user space like any other
> ppc arch.

First I'd like to understand exactly what's happening today, since
it makes little sense :-) I suppose I'll have to get myself some
8xx doco and understand how the bloody MMU works.

Then, I saw your old patch and it's -very- invasive. If we can get away
with a one liner just adding tlbil_va in the right place, I think I'm
happy to stick with it until somebody comes up with a real good reason
to do more :-) 8xx is on life support and has been around for long
enough without people feeling the need overall to work around that
problem so I'm tempted to keep the status-quo here.

Cheers,
Ben
