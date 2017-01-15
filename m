Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v1WDK3JQmzDqHZ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Jan 2017 20:25:04 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0F9NnjP094913
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Jan 2017 04:25:02 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27yjxrdtkv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Jan 2017 04:25:02 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Sun, 15 Jan 2017 02:25:01 -0700
Date: Sun, 15 Jan 2017 01:24:54 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
 akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
 josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
 rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
 dvhart@linux.intel.com, fweisbec@gmail.com, oleg@redhat.com,
 bobby.prani@gmail.com, will.deacon@arm.com,
 boqun.feng@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH tip/core/rcu 2/3] srcu: Force full grace-period ordering
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170114091941.GA22961@linux.vnet.ibm.com>
 <1484385601-23379-2-git-send-email-paulmck@linux.vnet.ibm.com>
 <20170114093550.GB14970@gmail.com>
 <20170114195417.GW5238@linux.vnet.ibm.com>
 <20170114214159.GA7098@linux.vnet.ibm.com>
 <20170115071123.GB26581@gmail.com>
 <20170115074034.GE5238@linux.vnet.ibm.com>
 <20170115075711.GA19506@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170115075711.GA19506@gmail.com>
Message-Id: <20170115092454.GF5238@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jan 15, 2017 at 08:57:11AM +0100, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Sun, Jan 15, 2017 at 08:11:23AM +0100, Ingo Molnar wrote:
> > > 
> > > * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> > > 
> > > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > > index 357b32aaea48..5fdfe874229e 100644
> > > > --- a/include/linux/rcupdate.h
> > > > +++ b/include/linux/rcupdate.h
> > > > @@ -1175,11 +1175,11 @@ do { \
> > > >   * if the UNLOCK and LOCK are executed by the same CPU or if the
> > > >   * UNLOCK and LOCK operate on the same lock variable.
> > > >   */
> > > > -#ifdef CONFIG_PPC
> > > > +#ifdef CONFIG_ARCH_WEAK_RELACQ
> > > >  #define smp_mb__after_unlock_lock()	smp_mb()  /* Full ordering for lock. */
> > > > -#else /* #ifdef CONFIG_PPC */
> > > > +#else /* #ifdef CONFIG_ARCH_WEAK_RELACQ */
> > > >  #define smp_mb__after_unlock_lock()	do { } while (0)
> > > > -#endif /* #else #ifdef CONFIG_PPC */
> > > > +#endif /* #else #ifdef CONFIG_ARCH_WEAK_RELACQ */
> > > >  
> > > >  
> > > 
> > > So at the risk of sounding totally pedantic, why not structure it like the 
> > > existing smp_mb__before/after*() primitives in barrier.h?
> > > 
> > > That allows asm-generic/barrier.h to pick up the definition - for example in the 
> > > case of smp_acquire__after_ctrl_dep() we do:
> > > 
> > >  #ifndef smp_acquire__after_ctrl_dep
> > >  #define smp_acquire__after_ctrl_dep()           smp_rmb()
> > >  #endif
> > > 
> > > Which allows Tile to relax it:
> > > 
> > >   arch/tile/include/asm/barrier.h:#define smp_acquire__after_ctrl_dep()   barrier()
> > > 
> > > I.e. I'd move the API definition out of rcupdate.h and into barrier.h - even 
> > > though tree-RCU is the only user of this barrier type.
> > 
> > I wouldn't have any problem with that, however, some time back it was
> > moved into RCU because (you guessed it!) RCU is the only user.  ;-)
> 
> Indeed ...
> 
> [sounds of rummaging around in the Git tree]
> 
> I found this commit of yours from ancient history (more than a year ago!):
> 
>   commit 12d560f4ea87030667438a169912380be00cea4b
>   Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>   Date:   Tue Jul 14 18:35:23 2015 -0700
> 
>     rcu,locking: Privatize smp_mb__after_unlock_lock()
>     
>     RCU is the only thing that uses smp_mb__after_unlock_lock(), and is
>     likely the only thing that ever will use it, so this commit makes this
>     macro private to RCU.
>     
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>     Cc: Will Deacon <will.deacon@arm.com>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>     Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
> 
> So I concur and I'm fine with your patch - or with the status quo code as well.

I already have the patch queued, so how about I keep it if I get an ack
from the powerpc guys and drop it otherwise?

							Thanx, Paul
