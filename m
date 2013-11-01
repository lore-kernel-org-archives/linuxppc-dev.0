Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 66A682C010C
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Nov 2013 20:28:23 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 1 Nov 2013 05:28:20 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 8BF9AC90044
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Nov 2013 05:28:16 -0400 (EDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rA19SHJ71507672
 for <linuxppc-dev@ozlabs.org>; Fri, 1 Nov 2013 09:28:17 GMT
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 rA19V7he011591
 for <linuxppc-dev@ozlabs.org>; Fri, 1 Nov 2013 03:31:08 -0600
Date: Fri, 1 Nov 2013 02:28:14 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: perf events ring buffer memory barrier on powerpc
Message-ID: <20131101092814.GG4067@linux.vnet.ibm.com>
References: <20131028132634.GO19466@laptop.lan>
 <20131028163418.GD4126@linux.vnet.ibm.com>
 <20131028201735.GA15629@redhat.com>
 <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131030092725.GL4126@linux.vnet.ibm.com>
 <OFC6B7100E.31C6B190-ON42257C14.004841C6-42257C14.004A0EA6@il.ibm.com>
 <20131031043258.GQ4126@linux.vnet.ibm.com>
 <20131031090457.GU19466@laptop.lan>
 <20131031150756.GB4067@linux.vnet.ibm.com>
 <20131031151955.GY19466@laptop.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131031151955.GY19466@laptop.lan>
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

On Thu, Oct 31, 2013 at 04:19:55PM +0100, Peter Zijlstra wrote:
> On Thu, Oct 31, 2013 at 08:07:56AM -0700, Paul E. McKenney wrote:
> > On Thu, Oct 31, 2013 at 10:04:57AM +0100, Peter Zijlstra wrote:
> > > On Wed, Oct 30, 2013 at 09:32:58PM -0700, Paul E. McKenney wrote:
> > > > Before C/C++11, the closest thing to such a prohibition is use of
> > > > volatile, for example, ACCESS_ONCE().  Even in C/C++11, you have to
> > > > use atomics to get anything resembing this prohibition.
> > > > 
> > > > If you just use normal variables, the compiler is within its rights
> > > > to transform something like the following:
> > > > 
> > > > 	if (a)
> > > > 		b = 1;
> > > > 	else
> > > > 		b = 42;
> > > > 
> > > > Into:
> > > > 
> > > > 	b = 42;
> > > > 	if (a)
> > > > 		b = 1;
> > > > 
> > > > Many other similar transformations are permitted.  Some are used to all
> > > > vector instructions to be used -- the compiler can do a write with an
> > > > overly wide vector instruction, then clean up the clobbered variables
> > > > later, if it wishes.  Again, if the variables are not marked volatile,
> > > > or, in C/C++11, atomic.
> > > 
> > > While I've heard you tell this story before, my mind keeps boggling how
> > > we've been able to use shared memory at all, all these years.
> > > 
> > > It seems to me stuff should have broken left, right and center if
> > > compilers were really aggressive about this.
> > 
> > Sometimes having stupid compilers is a good thing.  But they really are
> > getting more aggressive.
> 
> But surely we cannot go mark all data structures lodged in shared memory
> as volatile, that's insane.
> 
> I'm sure you're quite worried about this as well. Suppose we have:
> 
> struct foo {
> 	unsigned long value;
> 	void *ptr;
> 	unsigned long value1;
> };
> 
> And our ptr member is RCU managed. Then while the assignment using:
> rcu_assign_ptr() will use the volatile cast, what stops the compiler
> from wrecking ptr while writing either of the value* members and
> 'fixing' her up after?

Nothing at all!

We can reduce the probability by putting the pointer at one end or the
other, so that if the compiler uses (say) vector instructions to aggregate
individual assignments to the other fields, it will be less likely to hit
"ptr".  But yes, this is ugly and it would be really hard to get all
this right, and would often conflict with cache-locality needs.

> This is a completely untenable position.

Indeed it is!

C/C++ never was intended to be used for parallel programming, and this is
but one of the problems that can arise when we nevertheless use it for
parallel programming.  As compilers get smarter (for some definition of
"smarter") and as more systems have special-purpose hardware (such as
vector units) that are visible to the compiler, we can expect more of
this kind of trouble.

This was one of many reasons that I decided to help with the C/C++11
effort, whatever anyone might think about the results.

> How do the C/C++ people propose to deal with this?

By marking "ptr" as atomic, thus telling the compiler not to mess with it.
And thus requiring that all accesses to it be decorated, which in the
case of RCU could be buried in the RCU accessors.

							Thanx, Paul
