Return-Path: <benh@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A06151007D1
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jan 2010 07:32:04 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp02.au.ibm.com (8.14.3/8.13.1) with ESMTP id o0OKT5ka001002
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jan 2010 07:29:05 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0OKW3J81355940
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jan 2010 07:32:03 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0OKW2mJ011121
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jan 2010 07:32:03 +1100
Subject: Re: [RFC:PATCH 00/03] powerpc: Expose BookE debug registers
	through extended ptrace interface
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: prasad@linux.vnet.ibm.com
In-Reply-To: <20100124191830.GB14075@in.ibm.com>
References: <20100124191830.GB14075@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 25 Jan 2010 07:32:00 +1100
Message-ID: <1264365121.3601.43.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <dwg@au1.ibm.com>,
	shaggy@linux.vnet.ibm.com, Frederic Weisbecker <fweisbec@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-01-25 at 00:48 +0530, K.Prasad wrote:
> 
> Some of the benefits of using these generic interfaces include:
> - Interoperability with other users of debug register (such as
> parallel
>   kernel requests) i.e. non-exclusive use of debug registers.
> - Enables debugging/tracing tools such as perf-events and ftrace to
> make
>   use of debug registers.
> - Re-use of common code available in kernel (kernel/hw_breakpoint.c).
> 
> Let me know what you think.

This might have changed but last I looked the "generic" breakpoint
interface was still too x86-centric and wasn't capable of expressing
some of the features of the BookE debug register set such as the data
value compare, the ranged breakpoints, etc...

I'd rather have this more dedicated and more complete interface merged
for gdb's sake, and in a second step look at unifying.

I believe that the generic breakpoint infrastructure should not be the
mid-layer. IE. It cannot be made in any clean shape of form, to express
all of the subtle features that a given architecture or platform can
support and as such would always be inferior to a dedicated one.

I can see the interest in exposing some kind of generic API that
implements a common subset of breakpoint or watchpoint facilities to
generic code such as the event tracer. This could be layered on top of
an arch specific mechanism

But having the generic mechanism at the core for everybody is another
attempt of "make everybody look like x86" which I believe in this case
is sub optimal.

Again, I might have missed some evolutions of the latest versions of
your infrastructure that would make it good enough to fully bridge the
gap with our requirements, and I'll let Shaggy decide here what he wants
to do. But I will not block his current patches neither if he thinks
that they are good enough as is.

Cheers,
Ben.
