Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v7hKW0LjMzDqF7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 21:35:58 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Michael Ellerman' <mpe@ellerman.id.au>, Anton Blanchard
 <anton@samba.org>, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: BUILD_BUG_ON(!__builtin_constant_p(feature)) breaks bcc trace tool
Date: Wed, 25 Jan 2017 10:35:46 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB026DC3C@AcuExch.aculab.com>
References: <20170121120339.1c774b28@kryten>
 <20170121204948.742f89bf@kryten> <87pojd9e5l.fsf@concordia.ellerman.id.au>
In-Reply-To: <87pojd9e5l.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman
> Sent: 24 January 2017 06:16
> Anton Blanchard <anton@samba.org> writes:
> >> We added:
> >>
> >> BUILD_BUG_ON(!__builtin_constant_p(feature))
> >>
> >> to cpu_has_feature() and mmu_has_feature() in order to catch usage
> >> issues (such as cpu_has_feature(cpu_has_feature(X)). Unfortunately
> >> LLVM isn't smart enough to resolve this, and it errors out.
> >>
> >> I work around it in my clang/LLVM builds of the kernel, but I have
> >> just discovered that it causes a lot of issues for the bcc (eBPF)
> >> trace tool (which uses LLVM).
> >>
> >> How should we work around this? Wrap the checks in !clang perhaps?
> >
> > Looks like it's a weakness in LLVM with inlining:
> >
> > #include <assert.h>
> >
> > #if 1
> > static inline void foo(unsigned long x)

Does making this 'const unsigned long x' help?
ISTR that making a slight difference to the instruction patterns
gcc would use.

> > {
> >         assert(__builtin_constant_p(x));
> > }
> > #else
> > #define foo(X) assert(__builtin_constant_p(X))
> > #endif
...
> #define inline		inline		__attribute__((always_inline)) notrace
>=20
> So in fact every inline function is marked always_inline all the time,
> which seems dubious.

I've had to do that in the past to get gcc to inline some small leaf functi=
ons
that were only called once.
(That was for some embedded code where I don't actually want any function c=
alls
at all.)

To my mind 'inline' should mean 'always_inline' since you need to explicitl=
y
stop functions being inlined even when not marked 'inline'.

	David
