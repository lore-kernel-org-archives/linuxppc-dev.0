Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EAB8B2C00F9
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Nov 2013 21:07:58 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Mon, 4 Nov 2013 03:07:56 -0700
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id D63021FF001B
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Nov 2013 03:07:39 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rA4A7sp0302658
 for <linuxppc-dev@ozlabs.org>; Mon, 4 Nov 2013 03:07:54 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 rA4AAj7O019807
 for <linuxppc-dev@ozlabs.org>; Mon, 4 Nov 2013 03:10:45 -0700
Date: Mon, 4 Nov 2013 02:00:43 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: perf events ring buffer memory barrier on powerpc
Message-ID: <20131104100042.GK3947@linux.vnet.ibm.com>
References: <20131030092725.GL4126@linux.vnet.ibm.com>
 <OFC6B7100E.31C6B190-ON42257C14.004841C6-42257C14.004A0EA6@il.ibm.com>
 <20131031043258.GQ4126@linux.vnet.ibm.com>
 <20131031090457.GU19466@laptop.lan>
 <20131031150756.GB4067@linux.vnet.ibm.com>
 <20131031151955.GY19466@laptop.lan>
 <20131101092814.GG4067@linux.vnet.ibm.com>
 <20131101103017.GF19466@laptop.lan>
 <20131102152048.GI4067@linux.vnet.ibm.com>
 <20131104090744.GE10651@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131104090744.GE10651@twins.programming.kicks-ass.net>
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

On Mon, Nov 04, 2013 at 10:07:44AM +0100, Peter Zijlstra wrote:
> On Sat, Nov 02, 2013 at 08:20:48AM -0700, Paul E. McKenney wrote:
> > On Fri, Nov 01, 2013 at 11:30:17AM +0100, Peter Zijlstra wrote:
> > > Furthermore there's a gazillion parallel userspace programs.
> > 
> > Most of which have very unaggressive concurrency designs.
> 
> pthread_mutex_t A, B;
> 
> char data_A[x];
> int  counter_B = 1;
> 
> void funA(void)
> {
> 	pthread_mutex_lock(&A);
> 	memset(data_A, 0, sizeof(data_A));
> 	pthread_mutex_unlock(&A);
> }
> 
> void funB(void)
> {
> 	pthread_mutex_lock(&B);
> 	counter_B++;
> 	pthread_mutex_unlock(&B);
> }
> 
> void funC(void)
> {
> 	pthread_mutex_lock(&B)
> 	printf("%d\n", counter_B);
> 	pthread_mutex_unlock(&B);
> }
> 
> Then run: funA, funB, funC concurrently, and end with a funC.
> 
> Then explain to userman than his unaggressive program can return:
> 0
> 1
> 
> Because the memset() thought it might be a cute idea to overwrite
> counter_B and fix it up 'later'. Which if I understood you right is
> valid in C/C++ :-(
> 
> Not that any actual memset implementation exhibiting this trait wouldn't
> be shot on the spot.

Even without such a malicious memcpy() implementation I must still explain
about false sharing when the developer notices that the unaggressive
program isn't running as fast as expected.

> > > > By marking "ptr" as atomic, thus telling the compiler not to mess with it.
> > > > And thus requiring that all accesses to it be decorated, which in the
> > > > case of RCU could be buried in the RCU accessors.
> > > 
> > > This seems contradictory; marking it atomic would look like:
> > > 
> > > struct foo {
> > > 	unsigned long value;
> > > 	__atomic void *ptr;
> > > 	unsigned long value1;
> > > };
> > > 
> > > Clearly we cannot hide this definition in accessors, because then
> > > accesses to value* won't see the annotation.
> > 
> > #define __rcu __atomic
> 
> Yeah, except we don't use __rcu all that consistently; in fact I don't
> know if I ever added it.

There are more than 300 of them in the kernel.  Plus sparse can be
convinced to yell at you if you don't use them.  So lack of __rcu could
be fixed without too much trouble.

The C/C++11 need to annotate functions that take arguments or return
values taken from rcu_dereference() is another story.  But the compilers
have to get significantly more aggressive or developers have to be doing
unusual things that result in rcu_dereference() returning something whose
value the compiler can predict exactly.

							Thanx, Paul
