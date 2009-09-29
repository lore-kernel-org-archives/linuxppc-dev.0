Return-Path: <RFeany@mrv.com>
Received: from bos-spam.mrv.com (mx5.mrv.com [140.179.254.12])
	by ozlabs.org (Postfix) with ESMTP id 901C7B7BBD
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Sep 2009 11:21:11 +1000 (EST)
Date: Mon, 28 Sep 2009 18:21:06 -0700
From: Rex Feany <RFeany@mrv.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache
	coherency rewrite
Message-ID: <20090929012106.GA22798@compile2.chatsunix.int.mrv.com>
References: <20090924004552.GA11737@compile2.chatsunix.int.mrv.com>
	<1253774659.7103.405.camel@pasglop>
	<20090924233346.GA445@compile2.chatsunix.int.mrv.com>
	<1253836376.7103.469.camel@pasglop>
	<20090925013528.GA2584@compile2.chatsunix.int.mrv.com>
	<1253843480.7103.492.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1253843480.7103.492.camel@pasglop>
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

> On Thu, 2009-09-24 at 18:35 -0700, Rex Feany wrote:
> > 
> > Then I can boot and get to a shell, but userspace is slow. 8 seconds
> > to mount
> > /proc (vs. less then a second using my old kernel)! Maybe this is an
> > unrelated issue?  I'm pretty clueless about the details, I'm sorry.
> > PG_arch_1 is used to prevent a cache flush unless it is actually
> > needed?
> > Then why would changing the location of the tlbil_va() make a
> > difference?
> 
> I think there's more finishyness to 8xx than we thought. IE. That
> tlbil_va might have more reasons to be there than what the comment
> seems to advertize. Can you try to move it even higher up ? IE.
> Unconditionally at the beginning of set_pte_filter ?
> 
> Also, if that doesn't help, can you try putting one in
> set_access_flags_filter() just below ?
> 
> (Beware that there's two different versions of both functions, only the
> first one is compiled/used on 8xx).
> 
> It's going to be hard for me to get that "right" since I don't really
> know what's going on with the core here, but I suppose if we get it
> moving along with extra tlb invalidations, that should be "good enough"
> until somebody who really knows what's going on comes up with possibly
> a better fix.

I've tried sticking tlbil_va() in those places, nothing seems to help.
In some cases userspace is slow, in other cases userspace is faster and
unstable: sometimes commands hang, sometimes I am able to ctrl-c and
and kill it, sometimes I get other strange crashes or falures (so far no
kernel oopses though).

take care!
/rex.
