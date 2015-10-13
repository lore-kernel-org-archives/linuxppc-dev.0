Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F3E721A0919
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 02:46:26 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Tue, 13 Oct 2015 09:46:24 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 772713E4004F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 09:46:22 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t9DFj5QM11862462
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 08:45:05 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9DFkKUV028845
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 09:46:22 -0600
Date: Tue, 13 Oct 2015 08:46:29 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v3 0/6] atomics: powerpc: Implement
 relaxed/acquire/release variants of some atomics
Message-ID: <20151013154628.GQ3910@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1444659246-24769-1-git-send-email-boqun.feng@gmail.com>
 <20151013122713.GS3604@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151013122713.GS3604@twins.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 13, 2015 at 02:27:13PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 12, 2015 at 10:14:00PM +0800, Boqun Feng wrote:
> 
> > The patchset consists of 6 parts:
> > 
> > 1.	Make xchg, cmpxchg and their atomic_ versions a full barrier
> > 
> > 2.	Add trivial tests for the new variants in lib/atomic64_test.c
> > 
> > 3.	Allow architectures to define their own __atomic_op_*() helpers
> > 	to build other variants based on relaxed.
> > 
> > 4.	Implement atomic{,64}_{add,sub,inc,dec}_return_* variants
> > 
> > 5.	Implement xchg_* and atomic{,64}_xchg_* variants
> > 
> > 6.	Implement cmpxchg_* atomic{,64}_cmpxchg_* variants
> > 
> > 
> > This patchset is based on current locking/core branch of the tip tree
> > and all patches are built and boot tested for little endian pseries, and
> > also tested by 0day.
> 
> I don't see any immediate problems with this series at this point. Will,
> Paul?

Every time I have gotten ready to take a close look, someone has pointed
out a problem, and I have deferred until the next version.  Looks like
I should take a close look at Boqun's next version regardless.  ;-)

							Thanx, Paul
