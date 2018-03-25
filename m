Return-Path: <Yuri.Norov@cavium.com>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03on0056.outbound.protection.outlook.com [104.47.40.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408Rs86BNczF1xk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 06:18:52 +1100 (AEDT)
Date: Sun, 25 Mar 2018 22:18:27 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Chris Metcalf <cmetcalf@mellanox.com>, Christopher Lameter <cl@linux.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Mark Rutland <mark.rutland@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rcu: declare rcu_eqs_special_set() in public header
Message-ID: <20180325191827.jgf2eunlyznp2h7w@yury-thinkpad>
References: <20180325175004.28162-1-ynorov@caviumnetworks.com>
 <20180325175004.28162-2-ynorov@caviumnetworks.com>
 <20180325191243.GH3675@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180325191243.GH3675@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Mar 25, 2018 at 12:12:43PM -0700, Paul E. McKenney wrote:
> On Sun, Mar 25, 2018 at 08:50:03PM +0300, Yury Norov wrote:
> > rcu_eqs_special_set() is declared only in internal header
> > kernel/rcu/tree.h and stubbed in include/linux/rcutiny.h.
> > 
> > This patch declares rcu_eqs_special_set() in include/linux/rcutree.h, so
> > it can be used in non-rcu kernel code.
> > 
> > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > ---
> >  include/linux/rcutree.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> > index fd996cdf1833..448f20f27396 100644
> > --- a/include/linux/rcutree.h
> > +++ b/include/linux/rcutree.h
> > @@ -74,6 +74,7 @@ static inline void synchronize_rcu_bh_expedited(void)
> >  void rcu_barrier(void);
> >  void rcu_barrier_bh(void);
> >  void rcu_barrier_sched(void);
> > +bool rcu_eqs_special_set(int cpu);
> >  unsigned long get_state_synchronize_rcu(void);
> >  void cond_synchronize_rcu(unsigned long oldstate);
> >  unsigned long get_state_synchronize_sched(void);
> 
> Good point, a bit hard to use otherwise.  ;-)
> 
> I removed the declaration from rcutree.h and updated the commit log as
> follows.  Does it look OK?
 
Of course.

Thanks,
Yury
 
> ------------------------------------------------------------------------
> 
> commit 4497105b718a819072d48a675916d9d200b5327f
> Author: Yury Norov <ynorov@caviumnetworks.com>
> Date:   Sun Mar 25 20:50:03 2018 +0300
> 
>     rcu: Declare rcu_eqs_special_set() in public header
>     
>     Because rcu_eqs_special_set() is declared only in internal header
>     kernel/rcu/tree.h and stubbed in include/linux/rcutiny.h, it is
>     inaccessible outside of the RCU implementation.  This patch therefore
>     moves the  rcu_eqs_special_set() declaration to include/linux/rcutree.h,
>     which allows it to be used in non-rcu kernel code.
>     
>     Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> index fd996cdf1833..448f20f27396 100644
> --- a/include/linux/rcutree.h
> +++ b/include/linux/rcutree.h
> @@ -74,6 +74,7 @@ static inline void synchronize_rcu_bh_expedited(void)
>  void rcu_barrier(void);
>  void rcu_barrier_bh(void);
>  void rcu_barrier_sched(void);
> +bool rcu_eqs_special_set(int cpu);
>  unsigned long get_state_synchronize_rcu(void);
>  void cond_synchronize_rcu(unsigned long oldstate);
>  unsigned long get_state_synchronize_sched(void);
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 59ad0e23c722..d5f617aaa744 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -415,7 +415,6 @@ extern struct rcu_state rcu_preempt_state;
>  #endif /* #ifdef CONFIG_PREEMPT_RCU */
>  
>  int rcu_dynticks_snap(struct rcu_dynticks *rdtp);
> -bool rcu_eqs_special_set(int cpu);
>  
>  #ifdef CONFIG_RCU_BOOST
>  DECLARE_PER_CPU(unsigned int, rcu_cpu_kthread_status);
