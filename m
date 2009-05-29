Return-Path: <roland@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 25DE9DDF91
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 17:54:02 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: Add PTRACE_SINGLEBLOCK support
In-Reply-To: Benjamin Herrenschmidt's message of  Friday,
	29 May 2009 17:26:38 +1000 <20090529072644.7797ADDF84@ozlabs.org>
References: <20090529072644.7797ADDF84@ozlabs.org>
Message-Id: <20090529075354.853FBFC2BD@magilla.sf.frob.com>
Date: Fri, 29 May 2009 00:53:54 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The BookE variant is superior in some ways as it allows to know where
> you come from on branches. But that also means that the semantics exposed
> to user space would not be consistent which is BAD (tm).

If it were me I would start with a simpler patch that doesn't implement it
at all on BookE, and arch_has_block_step() yields 0 on those configs.
Later on when someone using BookE asks for it, revisit the complexity.
But that doesn't mean you shouldn't just go with what you've done now.

The reality is that there is no user expectation established one way or
another yet.  For a long time only ia64 had PTRACE_SINGLEBLOCK and for not
too many kernel versions has x86 had it too.  There aren't yet other
established uses of user_enable_block_step() so as to have an expectation
of what the semantics are.

arch_has_block_step() by itself does not indicate the details.  If there
is something more generic that starts to use this and thus cares to know
exactly what "block step" means, then we can figure it out.  My first
inclination is to have arch code provide only what is most natural and
simple on the given CPU and just have more-specific arch macros/inlines
saying what the behavior is (before branch or after branch, and whether
also before non-taken branches, are the only two bits of variance I can
think of).  Then whatever generic thing is built on this can test those
and cope.  i.e., a non-arch layer would be responsible for deciding that
doing an immediate single-step was the useful thing to do for this CPU's
flavor of block-step.

But I don't feel at all strongly that you shouldn't just roll it into
the arch code as you have done.  It's up to you--and really it's just
pending this getting exercised for any real-world purpose to see what
one really wants.  (Chances are such things would get done on x86 first,
where they might take advantage of several flavors of branch
source/target recording features.  So seeing what of all that some
actual tool used in practice might inform one's looking into what
analogues or subsets powerpc chips have to offer.)


Thanks,
Roland
