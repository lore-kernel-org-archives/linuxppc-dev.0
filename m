Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BEB161A001F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Sep 2014 04:31:15 +1000 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 5 Sep 2014 12:31:13 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 9E0F119D8039
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 12:30:58 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s85IVBqX18874496
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Sep 2014 20:31:11 +0200
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s85IZZbU011534
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Sep 2014 12:35:36 -0600
Date: Fri, 5 Sep 2014 11:31:09 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Michael Cree <mcree@orcon.net.nz>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Hurley <peter@hurleysoftware.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Laight <David.Laight@ACULAB.COM>, Jakub Jelinek <jakub@redhat.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Tony Luck <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Oleg Nesterov <oleg@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Miroslav Franc <mfranc@redhat.com>,
 Richard Henderson <rth@twiddle.net>, linux-alpha@vger.kernel.org
Subject: Re: bit fields && data tearing
Message-ID: <20140905183109.GA5497@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20140712181328.GA8738@redhat.com>
 <54079B70.4050200@hurleysoftware.com>
 <1409785893.30640.118.camel@pasglop>
 <063D6719AE5E284EB5DD2968C1650D6D17487172@AcuExch.aculab.com>
 <1409824374.4246.62.camel@pasglop> <5408E458.3@zytor.com>
 <54090AF4.7060406@hurleysoftware.com> <54091B30.2090509@zytor.com>
 <20140905081648.GB5281@omega>
 <20140905180950.GU5001@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140905180950.GU5001@linux.vnet.ibm.com>
Cc: peterz@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 05, 2014 at 11:09:50AM -0700, Paul E. McKenney wrote:
> On Fri, Sep 05, 2014 at 08:16:48PM +1200, Michael Cree wrote:
> > On Thu, Sep 04, 2014 at 07:08:48PM -0700, H. Peter Anvin wrote:
> > > On 09/04/2014 05:59 PM, Peter Hurley wrote:
> > > > I have no idea how prevalent the ev56 is compared to the ev5.
> > > > Still we're talking about a chip that came out in 1996.
> > > 
> > > Ah yes, I stand corrected.  According to Wikipedia, the affected CPUs
> > > were all the 2106x CPUs (EV4, EV45, LCA4, LCA45) plus the 21164 with no
> > > suffix (EV5).  However, we're still talking about museum pieces here.
> > 
> > Yes, that is correct, EV56 is the first Alpha CPU to have the byte-word
> > extension (BWX) CPU instructions.
> > 
> > It would not worry me if the kernel decided to assume atomic aligned
> > scalar accesses for all arches, thus terminating support for Alphas
> > without BWX.
> > 
> > The X server, ever since the libpciaccess change, does not work on
> > Alphas without BWX.
> > 
> > Debian Alpha (pretty much up to date at Debian-Ports) is still compiled
> > for all Alphas, i.e., without BWX.  The last attempt to start compiling
> > Debian Alpha with BWX, about three years ago when Alpha was kicked out
> > to Debian-Ports resulted in a couple or so complaints so got nowhere.
> > It's frustrating supporting the lowest common demoninator as many of
> > the bugs specific to Alpha can be resolved by recompiling with the BWX.
> > The kernel no longer supporting Alphas without BWX might just be the
> > incentive we need to switch Debian Alpha to compiling with BWX.
> 
> Very good, then I update my patch as follows.  Thoughts?

And, while I am at it, fix smp_load_acquire() and smp_store_release()
to allow single-byte and double-byte accesses.  (Adding Peter Zijlstra
on CC.)

							Thanx, Paul

------------------------------------------------------------------------

compiler: Allow 1- and 2-byte smp_load_acquire() and smp_store_release()

CPUs without single-byte and double-byte loads and stores place some
"interesting" requirements on concurrent code.  For example (adapted
from Peter Hurley's test code), suppose we have the following structure:
    
    	struct foo {
    		spinlock_t lock1;
    		spinlock_t lock2;
    		char a; /* Protected by lock1. */
    		char b; /* Protected by lock2. */
    	};
    	struct foo *foop;
    
Of course, it is common (and good) practice to place data protected
by different locks in separate cache lines.  However, if the locks are
rarely acquired (for example, only in rare error cases), and there are
a great many instances of the data structure, then memory footprint can
trump false-sharing concerns, so that it can be better to place them in
the same cache cache line as above.

But if the CPU does not support single-byte loads and stores, a store
to foop->a will do a non-atomic read-modify-write operation on foop->b,
which will come as a nasty surprise to someone holding foop->lock2.  So we
now require CPUs to support single-byte and double-byte loads and stores.
Therefore, this commit adjusts the definition of __native_word() to allow
these sizes to be used by smp_load_acquire() and smp_store_release().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index d5ad7b1118fc..934a834ab9f9 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -311,7 +311,7 @@ void ftrace_likely_update(struct ftrace_branch_data *f, int val, int expect);
 
 /* Is this type a native word size -- useful for atomic operations */
 #ifndef __native_word
-# define __native_word(t) (sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
+# define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
 #endif
 
 /* Compile time object size, -1 for unknown */
