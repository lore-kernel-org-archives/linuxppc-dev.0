Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 87EC4B7B8A
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 11:51:29 +1000 (EST)
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache
	coherency rewrite
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rex Feany <RFeany@mrv.com>
In-Reply-To: <20090925013528.GA2584@compile2.chatsunix.int.mrv.com>
References: <20090924004552.GA11737@compile2.chatsunix.int.mrv.com>
	<1253774659.7103.405.camel@pasglop>
	<20090924233346.GA445@compile2.chatsunix.int.mrv.com>
	<1253836376.7103.469.camel@pasglop>
	<20090925013528.GA2584@compile2.chatsunix.int.mrv.com>
Content-Type: text/plain
Date: Fri, 25 Sep 2009 11:51:20 +1000
Message-Id: <1253843480.7103.492.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-09-24 at 18:35 -0700, Rex Feany wrote:
> 
> Then I can boot and get to a shell, but userspace is slow. 8 seconds
> to mount
> /proc (vs. less then a second using my old kernel)! Maybe this is an
> unrelated issue?  I'm pretty clueless about the details, I'm sorry.
> PG_arch_1 is used to prevent a cache flush unless it is actually
> needed?
> Then why would changing the location of the tlbil_va() make a
> difference?

I think there's more finishyness to 8xx than we thought. IE. That
tlbil_va might have more reasons to be there than what the comment
seems to advertize. Can you try to move it even higher up ? IE.
Unconditionally at the beginning of set_pte_filter ?

Also, if that doesn't help, can you try putting one in
set_access_flags_filter() just below ?

(Beware that there's two different versions of both functions, only the
first one is compiled/used on 8xx).

It's going to be hard for me to get that "right" since I don't really
know what's going on with the core here, but I suppose if we get it
moving along with extra tlb invalidations, that should be "good enough"
until somebody who really knows what's going on comes up with possibly
a better fix.

Cheers,
Ben.
