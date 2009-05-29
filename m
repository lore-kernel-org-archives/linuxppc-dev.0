Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 91536DDE03
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 19:03:10 +1000 (EST)
Subject: Re: [RFC/PATCH] powerpc: Add PTRACE_SINGLEBLOCK support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland McGrath <roland@redhat.com>
In-Reply-To: <20090529075354.853FBFC2BD@magilla.sf.frob.com>
References: <20090529072644.7797ADDF84@ozlabs.org>
	<20090529075354.853FBFC2BD@magilla.sf.frob.com>
Content-Type: text/plain
Date: Fri, 29 May 2009 19:03:02 +1000
Message-Id: <1243587782.17903.49.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-05-29 at 00:53 -0700, Roland McGrath wrote:
> > The BookE variant is superior in some ways as it allows to know where
> > you come from on branches. But that also means that the semantics exposed
> > to user space would not be consistent which is BAD (tm).
> 
> If it were me I would start with a simpler patch that doesn't implement it
> at all on BookE, and arch_has_block_step() yields 0 on those configs.
> Later on when someone using BookE asks for it, revisit the complexity.
> But that doesn't mean you shouldn't just go with what you've done now.

Well, the trick to do an additional single step on BookE to mimmic
server is about 3 lines of code :-) And it seems to work just fine, we
wrote a small test app that forks and the parent blocksteps the children
which does a few useless things we put in there, we get the same results
on server and 440.

So I wouldn't bother -removing- it

> The reality is that there is no user expectation established one way or
> another yet.  For a long time only ia64 had PTRACE_SINGLEBLOCK and for not
> too many kernel versions has x86 had it too.  There aren't yet other
> established uses of user_enable_block_step() so as to have an expectation
> of what the semantics are.

Allright, but it would suck for it to have different semantics on
powerpc depending on the processor you're on. So I think we need
to settle on one semantic for powerpc, and if we want to make the
BookE special one available to userspace, we can do so via a
different call.

> arch_has_block_step() by itself does not indicate the details.  If there
> is something more generic that starts to use this and thus cares to know
> exactly what "block step" means, then we can figure it out.  My first
> inclination is to have arch code provide only what is most natural and
> simple on the given CPU and just have more-specific arch macros/inlines
> saying what the behavior is (before branch or after branch, and whether
> also before non-taken branches, are the only two bits of variance I can
> think of).  Then whatever generic thing is built on this can test those
> and cope.  i.e., a non-arch layer would be responsible for deciding that
> doing an immediate single-step was the useful thing to do for this CPU's
> flavor of block-step.

I agree to some extent but I dislike if the call behaves differently
within a single arch. Don't you agree ?

For example, BookE doesn't have a DABR for data breakpoint, it has
another facility (DACs). However, we do "emulate" the DABR using one
of the DACs to provide that consistency.

Now we do have WIP patches to add more advanced BookE features (direct
access to the DACs, IACs and DVCs (data compare on watchpoints) etc...)
and so at some point we'll provide those more advanced APIs, I suppose
we can roll the BookE "specific" variant of blockstep in there too,
and keep the base API provide server-like semantics that are identical
on BookE and server.

> But I don't feel at all strongly that you shouldn't just roll it into
> the arch code as you have done.  It's up to you--and really it's just
> pending this getting exercised for any real-world purpose to see what
> one really wants.  (Chances are such things would get done on x86 first,
> where they might take advantage of several flavors of branch
> source/target recording features.  So seeing what of all that some
> actual tool used in practice might inform one's looking into what
> analogues or subsets powerpc chips have to offer.)

Ok. I think I'll go with that patch then for now. I'll also look at the
WIP stuff for advanced BookE support and see if we can fold the BookE
variant of blockstep in there too for userspace that cares about it.

Cheers,
Ben.

> 
> Thanks,
> Roland
