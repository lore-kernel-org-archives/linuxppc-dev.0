Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CCCCE2C0141
 for <linuxppc-dev@ozlabs.org>; Sun,  3 Nov 2013 15:04:40 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Sat, 2 Nov 2013 22:04:37 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 03FD919D8045
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Nov 2013 22:04:31 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rA344YjG238618
 for <linuxppc-dev@ozlabs.org>; Sat, 2 Nov 2013 22:04:34 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 rA347PYN002010
 for <linuxppc-dev@ozlabs.org>; Sat, 2 Nov 2013 22:07:26 -0600
Date: Sat, 2 Nov 2013 08:20:48 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: perf events ring buffer memory barrier on powerpc
Message-ID: <20131102152048.GI4067@linux.vnet.ibm.com>
References: <20131028201735.GA15629@redhat.com>
 <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131030092725.GL4126@linux.vnet.ibm.com>
 <OFC6B7100E.31C6B190-ON42257C14.004841C6-42257C14.004A0EA6@il.ibm.com>
 <20131031043258.GQ4126@linux.vnet.ibm.com>
 <20131031090457.GU19466@laptop.lan>
 <20131031150756.GB4067@linux.vnet.ibm.com>
 <20131031151955.GY19466@laptop.lan>
 <20131101092814.GG4067@linux.vnet.ibm.com>
 <20131101103017.GF19466@laptop.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131101103017.GF19466@laptop.lan>
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 LKML <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Victor Kaplansky <VICTORK@il.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 01, 2013 at 11:30:17AM +0100, Peter Zijlstra wrote:
> On Fri, Nov 01, 2013 at 02:28:14AM -0700, Paul E. McKenney wrote:
> > > This is a completely untenable position.
> > 
> > Indeed it is!
> > 
> > C/C++ never was intended to be used for parallel programming, 
> 
> And yet pretty much all kernels ever written for SMP systems are written
> in it; what drugs are those people smoking?

There was a time when I wished that the C/C++ standards people had added
concurrency to the language 30 years ago, but I eventually realized that
any attempt at that time would have been totally broken.

> Furthermore there's a gazillion parallel userspace programs.

Most of which have very unaggressive concurrency designs.

> > and this is
> > but one of the problems that can arise when we nevertheless use it for
> > parallel programming.  As compilers get smarter (for some definition of
> > "smarter") and as more systems have special-purpose hardware (such as
> > vector units) that are visible to the compiler, we can expect more of
> > this kind of trouble.
> > 
> > This was one of many reasons that I decided to help with the C/C++11
> > effort, whatever anyone might think about the results.
> 
> Well, I applaud your efforts, but given the results I think the C/C++
> people are all completely insane.

If it makes you feel any better, they have the same opinion of all of
us who use C/C++ for concurrency given that the standard provides no
guarantee.

> > > How do the C/C++ people propose to deal with this?
> > 
> > By marking "ptr" as atomic, thus telling the compiler not to mess with it.
> > And thus requiring that all accesses to it be decorated, which in the
> > case of RCU could be buried in the RCU accessors.
> 
> This seems contradictory; marking it atomic would look like:
> 
> struct foo {
> 	unsigned long value;
> 	__atomic void *ptr;
> 	unsigned long value1;
> };
> 
> Clearly we cannot hide this definition in accessors, because then
> accesses to value* won't see the annotation.

#define __rcu __atomic

Though there are probably placement restrictions for __atomic that
current use of __rcu doesn't pay attention to.

> That said; mandating we mark all 'shared' data with __atomic is
> completely untenable and is not backwards compatible.
> 
> To be safe we must assume all data shared unless indicated otherwise.

Something similar to the compiler directives forcing twos-complement
interpretation of signed overflow could be attractive.  Not sure what
it would do to code generation, though.

							Thanx, Paul
