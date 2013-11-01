Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E59012C00BD
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Nov 2013 21:30:32 +1100 (EST)
Date: Fri, 1 Nov 2013 11:30:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: perf events ring buffer memory barrier on powerpc
Message-ID: <20131101103017.GF19466@laptop.lan>
References: <20131028163418.GD4126@linux.vnet.ibm.com>
 <20131028201735.GA15629@redhat.com>
 <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131030092725.GL4126@linux.vnet.ibm.com>
 <OFC6B7100E.31C6B190-ON42257C14.004841C6-42257C14.004A0EA6@il.ibm.com>
 <20131031043258.GQ4126@linux.vnet.ibm.com>
 <20131031090457.GU19466@laptop.lan>
 <20131031150756.GB4067@linux.vnet.ibm.com>
 <20131031151955.GY19466@laptop.lan>
 <20131101092814.GG4067@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131101092814.GG4067@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 LKML <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Victor Kaplansky <VICTORK@il.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 01, 2013 at 02:28:14AM -0700, Paul E. McKenney wrote:
> > This is a completely untenable position.
> 
> Indeed it is!
> 
> C/C++ never was intended to be used for parallel programming, 

And yet pretty much all kernels ever written for SMP systems are written
in it; what drugs are those people smoking?

Furthermore there's a gazillion parallel userspace programs.

> and this is
> but one of the problems that can arise when we nevertheless use it for
> parallel programming.  As compilers get smarter (for some definition of
> "smarter") and as more systems have special-purpose hardware (such as
> vector units) that are visible to the compiler, we can expect more of
> this kind of trouble.
> 
> This was one of many reasons that I decided to help with the C/C++11
> effort, whatever anyone might think about the results.

Well, I applaud your efforts, but given the results I think the C/C++
people are all completely insane.

> > How do the C/C++ people propose to deal with this?
> 
> By marking "ptr" as atomic, thus telling the compiler not to mess with it.
> And thus requiring that all accesses to it be decorated, which in the
> case of RCU could be buried in the RCU accessors.

This seems contradictory; marking it atomic would look like:

struct foo {
	unsigned long value;
	__atomic void *ptr;
	unsigned long value1;
};

Clearly we cannot hide this definition in accessors, because then
accesses to value* won't see the annotation.

That said; mandating we mark all 'shared' data with __atomic is
completely untenable and is not backwards compatible.

To be safe we must assume all data shared unless indicated otherwise.
