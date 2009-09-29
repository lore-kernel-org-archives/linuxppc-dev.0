Return-Path: <RFeany@mrv.com>
Received: from bos-spam.mrv.com (mx5.mrv.com [140.179.254.12])
	by ozlabs.org (Postfix) with ESMTP id F06E5B7C0E
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2009 07:09:20 +1000 (EST)
Date: Tue, 29 Sep 2009 14:09:17 -0700
From: Rex Feany <RFeany@mrv.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache
	coherency rewrite
Message-ID: <20090929210917.GB25779@laura.chatsunix.int.mrv.com>
References: <20090924004552.GA11737@compile2.chatsunix.int.mrv.com>
	<1253774659.7103.405.camel@pasglop>
	<20090924233346.GA445@compile2.chatsunix.int.mrv.com>
	<1253836376.7103.469.camel@pasglop>
	<20090925013528.GA2584@compile2.chatsunix.int.mrv.com>
	<1253843480.7103.492.camel@pasglop>
	<20090929012106.GA22798@compile2.chatsunix.int.mrv.com>
	<1254208031.5771.6.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1254208031.5771.6.camel@pasglop>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thus spake Benjamin Herrenschmidt (benh@kernel.crashing.org):

> On Mon, 2009-09-28 at 18:21 -0700, Rex Feany wrote:
> > > It's going to be hard for me to get that "right" since I don't really
> > > know what's going on with the core here, but I suppose if we get it
> > > moving along with extra tlb invalidations, that should be "good enough"
> > > until somebody who really knows what's going on comes up with possibly
> > > a better fix.
> > 
> > I've tried sticking tlbil_va() in those places, nothing seems to help.
> > In some cases userspace is slow, in other cases userspace is faster and
> > unstable: sometimes commands hang, sometimes I am able to ctrl-c and
> > and kill it, sometimes I get other strange crashes or falures (so far no
> > kernel oopses though).
> 
> And you are positive that with 2.6.31 and your other patch, it works
> both fast and stable ? This is strange... the code should be mostly
> identical. I'll have a second look and see if I can get you a patch that
> reproduce -exactly- the behaviour of 2.6.31 plus your patch.

The difference is night and day - with 2.6.31 I can boot into single
user mode, I can run our custom software (I left it running over night
with very simple test script - no crashes).

With the top of the tree I can sometimes boot into a shell, and if it
isn't crashing or hanging on boot it runs very slow (10+ seconds to do
anything, if I am lucky).

thanks!
/rex
