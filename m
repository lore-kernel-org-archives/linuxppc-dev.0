Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0EE00B7BCE
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Sep 2009 20:06:48 +1000 (EST)
In-Reply-To: <OF0EEAC985.DECE2C31-ONC125763F.002527BE-C125763F.002882FD@transmode.se>
References: <20090924004552.GA11737@compile2.chatsunix.int.mrv.com>		<1253774659.7103.405.camel@pasglop>
	<20090924233346.GA445@compile2.chatsunix.int.mrv.com>		<1253836376.7103.469.camel@pasglop>
	<20090925013528.GA2584@compile2.chatsunix.int.mrv.com>		<1253843480.7103.492.camel@pasglop>
	<1253847827.7103.504.camel@pasglop>	<20090925211848.GA3371@compile2.chatsunix.int.mrv.com>
	<OFEC38184A.A376E71D-ONC125763E.0048F581-C125763E.00497FD3@transmode.se>
	<1254108060.8421.1.camel@pasglop>
	<OF0EEAC985.DECE2C31-ONC125763F.002527BE-C125763F.002882FD@transmode.se>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache coherency
	rewrite
Message-ID: <OFFB884A25.4C93A282-ONC125763F.0036DE93-C125763F.0037243B@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 28 Sep 2009 12:02:17 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Rex Feany <RFeany@mrv.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 28/09/2009 05:21:00:
> >
> > On Sun, 2009-09-27 at 15:22 +0200, Joakim Tjernlund wrote:
> > > > However, adding tlbil_va() to ptep_set_access_flags() as you suggested
> > > > makes everything happy. I need to test it some more, but it looks good
> > > > so far. Below is what I am testing now.
> > >
> > > 8xx, is getting very hacky and I suspect that the only long term fix is
> > > add code to trap the cache instructions in TLB error/miss and fixup the
> > > exception in page fault handler. This will also have the added benefit on being able
> > > to use the cache instructions in both kernel and user space like any other
> > > ppc arch.
> >
> > First I'd like to understand exactly what's happening today, since
> > it makes little sense :-) I suppose I'll have to get myself some
> > 8xx doco and understand how the bloody MMU works.
>
> hmm, I recall that the reason for the currect "force a TLB error"
> procedure was to fix a problem Montavista had, possibly Tom Rini.
> He fixed the problem differently at first but later it
> was changed to what is in use today.
>
> If you have access to the old linuxppc-embedded you will find a lot
> of info in a thread with subject "[PATCH 2.6.14] mm: 8xx MM fix for"
> Also I made a ref that I cannot access anymore:
> http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/016382.html

Found a link to the original problem
 http://www.mail-archive.com/linuxppc-embedded@ozlabs.org/msg03376.html
seems like I had something to do with the solution that is haunting
8xx now :(
Basically 8xx should revert back to the fix suggested in the above link.
