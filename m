Return-Path: <rsa@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2E706DEC37
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Aug 2008 03:44:17 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7MHi7RH006742
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 13:44:07 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7MHi7Ci222264
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 13:44:07 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7MHi7xv012426
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 13:44:07 -0400
Subject: Re: libfreevec benchmarks
From: "Ryan S. Arnold" <rsa@us.ibm.com>
To: Konstantinos Margaritis <markos@codex.gr>
In-Reply-To: <200808211909.16852.markos@codex.gr>
References: <200808211909.16852.markos@codex.gr>
Content-Type: text/plain
Date: Fri, 22 Aug 2008 12:44:07 -0500
Message-Id: <1219427047.7917.38.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: rsa@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-08-21 at 19:09 +0300, Konstantinos Margaritis wrote:
> Benh suggested that I made this more known, and in particular to this list, so 
> I send this mail in hope that some people might be interested. In particular, 
> I ran the following benchmarks against libfreevec/glibc:
> 
> http://www.freevec.org/content/libfreevec_104_benchmarks_updated

Nice results.

> libfreevec has reached a very stable point, where me and a couple of others 
> (the OpenSuse PowerPC port developer being one) have been using it for weeks 
> (personally I've been using it for months), using the LD_PRELOAD mechanism (as 
> explained here: 
> http://www.freevec.org/content/howto_using_libfreevec_using_ld_preload).
> The OpenSuse guys even consider using it by default on the ppc port even, but 
> that's not final of course.
> 
> glibc integration _might_ happen if glibc developers change their attitude (my 
> mails have been mostly ignored).

Konstantinos,

Do you have FSF (Free Software Foundation) copyright assignment yet?

How've you implemented the optimizations?

Vector insns are allowed in the PowerPC code in GLIBC if guarded by
PPC_FEATURE_HAS_ALTIVEC (look at setjmp/_longjmp).

The use of unguarded vector code is allowed in --with-cpu powerpc-cpu
override directories for cpus that support altivec/VMX.

Optimizations for individual architectures should follow the powerpc-cpu
precedent for providing these routines, e.g.

sysdeps/powerpc/powerpc32/power6/memcpy.S
sysdeps/powerpc/powerpc64/power6/memcpy.S

I believe that optimizations for the G5 processor would go into the
existing 970 directories:

sysdeps/powerpc/powerpc32/970
sysdeps/powerpc/powerpc64/970

Today, if glibc is configure with --with-cpu=970 it will actually
default to the power optimizations for the string routines, as indicated
by the sysdeps/powerpc/powerpc[32|64]/970/Implies files.  It'd be worth
verifying that your baseline glibc runs are against existing optimized
versions of glibc.  If they're not then this is a fault of the distro
you're testing on.

I'm not aware of the status of some of the embedded PowerPC processors
with-regard to powerpc-cpu optimizations.

Our research found that for some tasks on some PowerPC processors the
expense of reserving the floating point pipeline for vector operations
exceeds the benefit of using vector insns for the task.

In these cases we tend to optimize based on pipeline characteristics
rather than using the vector facility.

Generally our optimizations tend to favor data an average of 12 bytes
with 1000 byte max.  We also favor aligned data and use the existing
implementation as a model as a baseline for where we try to keep
unaligned data performance from dropping below.

> Last, I've also been working on a libm rewrite, though this will take some 
> time still. I've reimplemented most math functions at the algorithm level, eg. 
> so far, most functions achieve 50%-200% speed increase at full IEEE754 
> accuracy (mathematically proven, soon to be published online) without using 
> Altivec yet, just by choosing a different approximation method (Taylor 
> approximation is pretty dumb if you ask me anyway).

This research would be a good candidate for selectively replacing some
of the existing libm functionality.  Do these results hold for all
permutations of long double support?  Do they hold for x86/x86_64 as
well as PowerPC?  I would suggest against a massive patch to libc-alpha
and would instead recommend selective, individual replacement of
fundamental routines to start with accompanied by exhaustive profile
data.  You have to show that you're dedicated to maintenance of these
routines and you can't overwhelm the reviewers with massive patches.

Any submission to GLIBC is going to require that you and your code
follow the GLIBC process or it'll probably be ignored.  You can engage
me directly via CC and I can help you understand how to integrate the
code but I can't give you a free pass or do the work for you.

The new libc-help mailing list was also created as a place for people to
learn the process and get the patches in a state where they're ready to
be submitted to libc-alpha.

Regards,
Ryan S. Arnold
IBM Linux Technology Center
Linux Toolchain Development
