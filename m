Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E3AC5B7D05
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2010 18:13:41 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp03.au.ibm.com (8.14.3/8.13.1) with ESMTP id o0S7Ai2Q028477
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2010 18:10:44 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0S78ls8979020
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2010 18:08:47 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0S7DerL015847
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2010 18:13:41 +1100
Date: Thu, 28 Jan 2010 12:43:32 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [RFC:PATCH 00/03] powerpc: Expose BookE debug registers through
	extended ptrace interface
Message-ID: <20100128071332.GB4883@in.ibm.com>
References: <20100124191830.GB14075@in.ibm.com>
	<1264365121.3601.43.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1264365121.3601.43.camel@pasglop>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, linuxppc-dev@ozlabs.org,
	shaggy@linux.vnet.ibm.com, David Gibson <dwg@au1.ibm.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 25, 2010 at 07:32:00AM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2010-01-25 at 00:48 +0530, K.Prasad wrote:
> > 
> > Some of the benefits of using these generic interfaces include:
> > - Interoperability with other users of debug register (such as
> > parallel
> >   kernel requests) i.e. non-exclusive use of debug registers.
> > - Enables debugging/tracing tools such as perf-events and ftrace to
> > make
> >   use of debug registers.
> > - Re-use of common code available in kernel (kernel/hw_breakpoint.c).
> > 
> > Let me know what you think.
> 
> This might have changed but last I looked the "generic" breakpoint
> interface was still too x86-centric and wasn't capable of expressing
> some of the features of the BookE debug register set such as the data
> value compare, the ranged breakpoints, etc...
> 
> I'd rather have this more dedicated and more complete interface merged
> for gdb's sake, and in a second step look at unifying.
> 

While the hw-breakpoint infrastructure is more generic (than
what can be termed x86-centric), it cannot support sophisticated
features like DVC register - atleast in its present form.

My idea was to align the Book-E processor's use of debug registers with
the existing breakpoint framework, and in the process make improvements/
changes to the common framework as necessitated.

It could be done in a two-step process to ease the development and review
process (more on this below).

> I believe that the generic breakpoint infrastructure should not be the
> mid-layer. IE. It cannot be made in any clean shape of form, to express
> all of the subtle features that a given architecture or platform can
> support and as such would always be inferior to a dedicated one.
> 
> I can see the interest in exposing some kind of generic API that
> implements a common subset of breakpoint or watchpoint facilities to
> generic code such as the event tracer. This could be layered on top of
> an arch specific mechanism
> 

Given the diversity of debug register implementation (across
processors), concerns about having a poorly-featured mid-layer is
understandable.

But our design goal is to be as flexible as required to accomodate newer
architectures, while providing them the benefit of using the common
framework - such as register arbitration (existing implementation would
assume mutually exclusive access to debug registers), scheduling and
abstraction through generic interfaces.

> But having the generic mechanism at the core for everybody is another
> attempt of "make everybody look like x86" which I believe in this case
> is sub optimal.
> 

No, it is not! In fact patches that port the framework to PPC64 and S390
have already been posted to the respective communities and are under
review.

> Again, I might have missed some evolutions of the latest versions of
> your infrastructure that would make it good enough to fully bridge the
> gap with our requirements, and I'll let Shaggy decide here what he wants
> to do. But I will not block his current patches neither if he thinks
> that they are good enough as is.
> 

As I mentioned above, the generic framework may need to be extended to
support all features required by processors such as Book-E. Any
feature that is very unique to a given processor and exotic to the
hw-breakpoint framework can be kept outside its purview (and implemented
to support only ptrace with exclusive access to those registers).

Sure, let's wait to hear from Shaggy to know how he'd like to proceed. 

Thanks,
K.Prasad
