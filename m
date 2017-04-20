Return-Path: <michaele@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7l5t0ydDzDqG1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 13:41:21 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3K3d7aX146637
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 23:41:19 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29x753vh0d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 23:41:19 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <michaele@au1.ibm.com>;
 Thu, 20 Apr 2017 13:41:16 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3K3f6sU26476638
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 13:41:14 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3K3eajS008717
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 13:40:37 +1000
From: Michael Ellerman <michaele@au1.ibm.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, "paulus@samba.org" <paulus@samba.org>,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 pbonzini@redhat.com
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
 akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
 josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
 rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
 fweisbec@gmail.com, oleg@redhat.com, bobby.prani@gmail.com,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: powerpc KVM build break in linux-next (was Re: [PATCH tip/core/rcu
 40/40] srcu: Parallelize callback handling)
In-Reply-To: <1492018825-25634-40-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20170412174003.GA23207@linux.vnet.ibm.com>
 <1492018825-25634-40-git-send-email-paulmck@linux.vnet.ibm.com>
Date: Thu, 20 Apr 2017 13:40:13 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <871ssn692a.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:

> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index f2b3bd6c6bc2..0400e211aa44 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -24,25 +24,75 @@
...
> +/*
> + * Per-SRCU-domain structure, similar in function to rcu_state.
> + */
>  struct srcu_struct {
> -	unsigned long completed;
> -	unsigned long srcu_gp_seq;
> -	atomic_t srcu_exp_cnt;
> -	struct srcu_array __percpu *per_cpu_ref;
> -	spinlock_t queue_lock; /* protect ->srcu_cblist */
> -	struct rcu_segcblist srcu_cblist;
> +	struct srcu_node node[NUM_RCU_NODES];	/* Combining tree. */
> +	struct srcu_node *level[RCU_NUM_LVLS + 1];
> +						/* First node at each level. */
> +	struct mutex srcu_cb_mutex;		/* Serialize CB preparation. */
> +	spinlock_t gp_lock;			/* protect ->srcu_cblist */
> +	struct mutex srcu_gp_mutex;		/* Serialize GP work. */
> +	unsigned int srcu_idx;			/* Current rdr array element. */
> +	unsigned long srcu_gp_seq;		/* Grace-period seq #. */
> +	unsigned long srcu_gp_seq_needed;	/* Latest gp_seq needed. */
> +	atomic_t srcu_exp_cnt;			/* # ongoing expedited GPs. */
> +	struct srcu_data __percpu *sda;		/* Per-CPU srcu_data array. */
> +	unsigned long srcu_barrier_seq;		/* srcu_barrier seq #. */
> +	struct mutex srcu_barrier_mutex;	/* Serialize barrier ops. */
> +	struct completion srcu_barrier_completion;
> +						/* Awaken barrier rq at end. */
> +	atomic_t srcu_barrier_cpu_cnt;		/* # CPUs not yet posting a */
> +						/*  callback for the barrier */
> +						/*  operation. */

This change seems to have had the non-obvious effect of breaking the
powerpc KVM build.

Because struct kvm contains two srcu_structs which are located
before the kvm_arch struct, the increase in size of srcu_struct has
caused the offset from the start of struct kvm to kvm_arch to be too big
for some of our asm.

struct kvm {
	spinlock_t mmu_lock;
	struct mutex slots_lock;
	struct mm_struct *mm; /* userspace tied to this vm */
	struct kvm_memslots *memslots[KVM_ADDRESS_SPACE_NUM];
	struct srcu_struct srcu;
	struct srcu_struct irq_srcu;
        ...
	struct kvm_arch arch;


Example error:
  arch/powerpc/kvm/book3s_hv_rmhandlers.S:617: Error: operand out of range (0x000000000000b328 is not between 0xffffffffffff8000 and 0x0000000000007fff)

Where line 617 is:
  lwz	r7,KVM_LPID(r9)

And the KVM_LPID constant comes from asm-offsets.s. The diff of old vs
new is:

  -->KVM_LPID 17752 offsetof(struct kvm, arch.lpid)	 #
  +->KVM_LPID 45864 offsetof(struct kvm, arch.lpid)	 #


We can probably just fix it by changing the asm to keep the address of
kvm_arch in a register, and then offset from that.

cheers
