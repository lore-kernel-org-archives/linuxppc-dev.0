Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 767EB2C00A8
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Nov 2013 20:08:12 +1100 (EST)
Date: Mon, 4 Nov 2013 10:07:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: perf events ring buffer memory barrier on powerpc
Message-ID: <20131104090744.GE10651@twins.programming.kicks-ass.net>
References: <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131030092725.GL4126@linux.vnet.ibm.com>
 <OFC6B7100E.31C6B190-ON42257C14.004841C6-42257C14.004A0EA6@il.ibm.com>
 <20131031043258.GQ4126@linux.vnet.ibm.com>
 <20131031090457.GU19466@laptop.lan>
 <20131031150756.GB4067@linux.vnet.ibm.com>
 <20131031151955.GY19466@laptop.lan>
 <20131101092814.GG4067@linux.vnet.ibm.com>
 <20131101103017.GF19466@laptop.lan>
 <20131102152048.GI4067@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131102152048.GI4067@linux.vnet.ibm.com>
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

On Sat, Nov 02, 2013 at 08:20:48AM -0700, Paul E. McKenney wrote:
> On Fri, Nov 01, 2013 at 11:30:17AM +0100, Peter Zijlstra wrote:
> > Furthermore there's a gazillion parallel userspace programs.
> 
> Most of which have very unaggressive concurrency designs.

pthread_mutex_t A, B;

char data_A[x];
int  counter_B = 1;

void funA(void)
{
	pthread_mutex_lock(&A);
	memset(data_A, 0, sizeof(data_A));
	pthread_mutex_unlock(&A);
}

void funB(void)
{
	pthread_mutex_lock(&B);
	counter_B++;
	pthread_mutex_unlock(&B);
}

void funC(void)
{
	pthread_mutex_lock(&B)
	printf("%d\n", counter_B);
	pthread_mutex_unlock(&B);
}

Then run: funA, funB, funC concurrently, and end with a funC.

Then explain to userman than his unaggressive program can return:
0
1

Because the memset() thought it might be a cute idea to overwrite
counter_B and fix it up 'later'. Which if I understood you right is
valid in C/C++ :-(

Not that any actual memset implementation exhibiting this trait wouldn't
be shot on the spot.

> > > By marking "ptr" as atomic, thus telling the compiler not to mess with it.
> > > And thus requiring that all accesses to it be decorated, which in the
> > > case of RCU could be buried in the RCU accessors.
> > 
> > This seems contradictory; marking it atomic would look like:
> > 
> > struct foo {
> > 	unsigned long value;
> > 	__atomic void *ptr;
> > 	unsigned long value1;
> > };
> > 
> > Clearly we cannot hide this definition in accessors, because then
> > accesses to value* won't see the annotation.
> 
> #define __rcu __atomic

Yeah, except we don't use __rcu all that consistently; in fact I don't
know if I ever added it.
