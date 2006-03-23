Return-Path: <paulmck@us.ibm.com>
Date: Thu, 23 Mar 2006 14:26:45 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] Document Linux's memory barriers [try #5]
Message-ID: <20060323222645.GA1298@us.ibm.com>
References: <20060316231723.GB1323@us.ibm.com>
	<16835.1141936162@warthog.cambridge.redhat.com>
	<18351.1142432599@warthog.cambridge.redhat.com>
	<895.1143138867@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <895.1143138867@warthog.cambridge.redhat.com>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	torvalds@osdl.org, davem@redhat.com, linuxppc64-dev@ozlabs.org
Reply-To: paulmck@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 23, 2006 at 06:34:27PM +0000, David Howells wrote:
> Paul E. McKenney <paulmck@us.ibm.com> wrote:
> 
> > smp_mb__before_atomic_dec() and friends as well?
> 
> These seem to be something Sparc64 related; or, at least, Sparc64 seems to do
> something weird with them.
> 
> What are these meant to achieve anyway? They seems to just be barrier() on a
> lot of systems, even SMP ones.

On architectures such as x86 where atomic_dec() implies an smp_mb(),
they do nothing.  On other architectures, they supply whatever memory
barrier is required.

So, on x86:

	smp_mb();
	atomic_dec(&my_atomic_counter);

would result in -two- atomic instructions, but the smp_mb() would be
absolutely required on CPUs with weaker memory-consistency models.
So your choice is to (1) be inefficient on x86 or (2) be unsafe on
weak-memory-consistency systems.  What we can do instead is:

	smp_mb__before_atomic_dec();
	atomic_dec(&my_atomic_counter);

This allows x86 to generate efficient code -and- allows weak-memory
machines (e.g., Alpha, MIPS, PA-RISC(!), ppc, s390, SPARC64) to generate
safe code.

						Thanx, Paul
