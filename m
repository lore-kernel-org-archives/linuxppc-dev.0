Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w81HH2jgGzDqKQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 00:20:26 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3KEDluo042264
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 10:20:17 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29xuc9tkhf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 10:20:17 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 20 Apr 2017 10:20:17 -0400
Date: Thu, 20 Apr 2017 07:19:57 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Michael Ellerman <michaele@au1.ibm.com>
Cc: linux-kernel@vger.kernel.org, "paulus@samba.org" <paulus@samba.org>,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 pbonzini@redhat.com, mingo@kernel.org, jiangshanlai@gmail.com,
 dipankar@in.ibm.com, akpm@linux-foundation.org,
 mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
 tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
 dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
 oleg@redhat.com, bobby.prani@gmail.com
Subject: Re: powerpc KVM build break in linux-next (was Re: [PATCH
 tip/core/rcu 40/40] srcu: Parallelize callback handling)
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170412174003.GA23207@linux.vnet.ibm.com>
 <1492018825-25634-40-git-send-email-paulmck@linux.vnet.ibm.com>
 <871ssn692a.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <871ssn692a.fsf@concordia.ellerman.id.au>
Message-Id: <20170420141957.GK3956@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 20, 2017 at 01:40:13PM +1000, Michael Ellerman wrote:
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:
> 
> > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > index f2b3bd6c6bc2..0400e211aa44 100644
> > --- a/include/linux/srcutree.h
> > +++ b/include/linux/srcutree.h
> > @@ -24,25 +24,75 @@
> ...
> > +/*
> > + * Per-SRCU-domain structure, similar in function to rcu_state.
> > + */
> >  struct srcu_struct {
> > -	unsigned long completed;
> > -	unsigned long srcu_gp_seq;
> > -	atomic_t srcu_exp_cnt;
> > -	struct srcu_array __percpu *per_cpu_ref;
> > -	spinlock_t queue_lock; /* protect ->srcu_cblist */
> > -	struct rcu_segcblist srcu_cblist;
> > +	struct srcu_node node[NUM_RCU_NODES];	/* Combining tree. */
> > +	struct srcu_node *level[RCU_NUM_LVLS + 1];
> > +						/* First node at each level. */
> > +	struct mutex srcu_cb_mutex;		/* Serialize CB preparation. */
> > +	spinlock_t gp_lock;			/* protect ->srcu_cblist */
> > +	struct mutex srcu_gp_mutex;		/* Serialize GP work. */
> > +	unsigned int srcu_idx;			/* Current rdr array element. */
> > +	unsigned long srcu_gp_seq;		/* Grace-period seq #. */
> > +	unsigned long srcu_gp_seq_needed;	/* Latest gp_seq needed. */
> > +	atomic_t srcu_exp_cnt;			/* # ongoing expedited GPs. */
> > +	struct srcu_data __percpu *sda;		/* Per-CPU srcu_data array. */
> > +	unsigned long srcu_barrier_seq;		/* srcu_barrier seq #. */
> > +	struct mutex srcu_barrier_mutex;	/* Serialize barrier ops. */
> > +	struct completion srcu_barrier_completion;
> > +						/* Awaken barrier rq at end. */
> > +	atomic_t srcu_barrier_cpu_cnt;		/* # CPUs not yet posting a */
> > +						/*  callback for the barrier */
> > +						/*  operation. */
> 
> This change seems to have had the non-obvious effect of breaking the
> powerpc KVM build.
> 
> Because struct kvm contains two srcu_structs which are located
> before the kvm_arch struct, the increase in size of srcu_struct has
> caused the offset from the start of struct kvm to kvm_arch to be too big
> for some of our asm.
> 
> struct kvm {
> 	spinlock_t mmu_lock;
> 	struct mutex slots_lock;
> 	struct mm_struct *mm; /* userspace tied to this vm */
> 	struct kvm_memslots *memslots[KVM_ADDRESS_SPACE_NUM];
> 	struct srcu_struct srcu;
> 	struct srcu_struct irq_srcu;
>         ...
> 	struct kvm_arch arch;
> 
> 
> Example error:
>   arch/powerpc/kvm/book3s_hv_rmhandlers.S:617: Error: operand out of range (0x000000000000b328 is not between 0xffffffffffff8000 and 0x0000000000007fff)
> 
> Where line 617 is:
>   lwz	r7,KVM_LPID(r9)
> 
> And the KVM_LPID constant comes from asm-offsets.s. The diff of old vs
> new is:
> 
>   -->KVM_LPID 17752 offsetof(struct kvm, arch.lpid)	 #
>   +->KVM_LPID 45864 offsetof(struct kvm, arch.lpid)	 #
> 
> 
> We can probably just fix it by changing the asm to keep the address of
> kvm_arch in a register, and then offset from that.

Ouch!

What do you need from me?

							Thanx, Paul
