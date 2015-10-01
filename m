Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 20AD91A010C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 01:12:26 +1000 (AEST)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 1 Oct 2015 09:12:24 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 40EF03E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 09:12:22 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t91FB9Fe3277116
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Oct 2015 08:11:09 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t91FCJJ8011622
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Oct 2015 09:12:21 -0600
Date: Thu, 1 Oct 2015 08:12:19 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC v2 5/7] powerpc: atomic: Implement cmpxchg{,64}_* and
 atomic{,64}_cmpxchg_* variants
Message-ID: <20151001151219.GD4043@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
 <1442418575-12297-6-git-send-email-boqun.feng@gmail.com>
 <20151001122715.GQ2881@worktop.programming.kicks-ass.net>
 <20151001123626.GB3281@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151001123626.GB3281@worktop.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 01, 2015 at 02:36:26PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 01, 2015 at 02:27:15PM +0200, Peter Zijlstra wrote:
> > On Wed, Sep 16, 2015 at 11:49:33PM +0800, Boqun Feng wrote:
> > > Unlike other atomic operation variants, cmpxchg{,64}_acquire and
> > > atomic{,64}_cmpxchg_acquire don't have acquire semantics if the cmp part
> > > fails, so we need to implement these using assembly.
> > 
> > I think that is actually expected and documented. That is, a cmpxchg
> > only implies barriers on success. See:
> > 
> >   ed2de9f74ecb ("locking/Documentation: Clarify failed cmpxchg() memory ordering semantics")
> 
> Also:
> 
> 654672d4ba1a6 (Will Deacon     2015-08-06 17:54:37 +0100  28)  * store portion of the operation. Note that a failed cmpxchg_acquire
> 654672d4ba1a6 (Will Deacon     2015-08-06 17:54:37 +0100  29)  * does -not- imply any memory ordering constraints.

What C11 does is to allow the developer to specify different orderings
on success and failure.  But it is no harder to supply a barrier (if
needed) on the failure path, right?

							Thanx, Paul
