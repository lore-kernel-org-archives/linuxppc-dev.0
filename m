Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id AA5A9679E1
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Apr 2006 14:21:53 +1000 (EST)
Date: Sat, 29 Apr 2006 23:20:59 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: please pull powerpc.git 'merge' branch
Message-ID: <20060430042059.GO5518@pb15.lixom.net>
References: <17491.1134.565353.149941@cargo.ozlabs.ibm.com>
	<20060429151936.GM5518@pb15.lixom.net>
	<17491.64254.653743.367039@cargo.ozlabs.ibm.com>
	<71339D1F-CAF1-4FF0-A1A3-1A74B8984F05@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <71339D1F-CAF1-4FF0-A1A3-1A74B8984F05@kernel.crashing.org>
From: Olof Johansson <olof@lixom.net>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, torvalds@osdl.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Apr 30, 2006 at 05:12:57AM +0200, Segher Boessenkool wrote:
> >>Previously we've said implementation instead of specification
> >>("PPC_FEATURE_POWER5_PLUS" etc). That's better than saying base
> >>architecture version, since there are parts of the arch that might or
> >>might not be implemented (i.e. optional features, etc).
> >
> >We now have the AT_PLATFORM string, which we didn't have when we added
> >the POWER5_PLUS etc. features.  That specifies which particular
> >implementation we are on quite precisely.  We don't want to have a bit
> >for every single implementation or we'll run out of bits.
> >
> >The ARCH_2_05 bit means all the non-optional bits of the 2.05
> >architecture.  If there are optional features in the architecture, we
> >have separate bits for them.  For example, we don't have separate
> >bits for POWER4 and for 970; instead we have a HAS_ALTIVEC bit, and
> >for 970 we set both POWER4 and HAS_ALTIVEC.  So the POWER4 bit is
> >really a "2.00 architecture version" bit.
> 
> Except that the 970 at least is actually version 2.01.

Are there any userspace-visible differences between 2.00 and 2.01?

> Sounds
> like names are better than bare numbers -- you showed yourself that
> numbers like this are confusing, but you also say that a cpu name
> really means an arch version (which isn't so bad -- there generally
> is only one "main" CPU per arch version anyway, and people generally
> know what is compatible to what).

It's actually about an even tradeoff between the two. We run the risk
of running out of bits eventually no matter what, and as long as it's
blindingly clear and well stated that it does not imply any optional
features, then it doesn't matter. This puts the burden on userspace
developers to know which features are optional, not just what works on
their POWER6 lab machine, etc.

> So please rename ARCH_2_05 to the name of the first CPU that implements
> architecture 2.05?

We already have SMT, ICACHE_SNOOP and ALTIVEC feature bits, so it probably
makes sense to stay in the ARCH_2_05 direction. Unfortunately it might
be tricky to rename the old defines now due to userland exposure.

I guess Cell breaks all this logic though. Which PPC base version does
it implement?


-Olof
