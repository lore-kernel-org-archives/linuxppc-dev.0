Return-Path: <paulus@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A6462B722B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 22:28:19 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9364FDDDA0
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 22:28:19 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19000.57673.618229.523229@cargo.ozlabs.ibm.com>
Date: Wed, 17 Jun 2009 22:27:53 +1000
From: Paul Mackerras <paulus@samba.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 6/6] perf_counter: tools: Makefile tweaks for 64-bit
	powerpc
In-Reply-To: <20090617120831.GB26454@elte.hu>
References: <19000.55404.103840.393470@cargo.ozlabs.ibm.com>
	<19000.55666.866148.559620@cargo.ozlabs.ibm.com>
	<20090617120831.GB26454@elte.hu>
Cc: linuxppc-dev@ozlabs.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ingo Molnar writes:

> ah, it does this:
> 
> /*
>  * This is here because we used to use l64 for 64bit powerpc
>  * and we don't want to impact user mode with our change to ll64
>  * in the kernel.
>  */
> #if defined(__powerpc64__) && !defined(__KERNEL__)
> # include <asm-generic/int-l64.h>
> #else
> # include <asm-generic/int-ll64.h>
> #endif
> 
> That's crappy really.

We were concerned that changing the userland-visible type of __u64
from unsigned long to unsigned long long, etc., would be breaking the
ABI, even if only in a small way - I thought it could possibly change
C++ mangled function names, for instance, and it would cause fresh
compile warnings on existing user code that prints __u64 with %lx,
which has always been the correct thing to do on ppc64.

A counter-argument would be, I guess, that __u64 et al. are purely for
use in describing the kernel/user interface, so we have a little more
latitude than with the type of e.g. u_int64_t.  I dunno.  I don't
recall getting much of an answer from the glibc guys about what they
thought of the idea of changing it.

Anyway, of the 64-bit architectures, alpha, ia64, and mips64 also have
__u64 as unsigned long in userspace, so this issue will still crop up
even if we change it on powerpc.

Paul.
