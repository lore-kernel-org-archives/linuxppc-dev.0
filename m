Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sptBC4nttzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 22:01:07 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u95Ax85d015274
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Oct 2016 07:01:04 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25vyg6jj4w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Oct 2016 07:01:04 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Wed, 5 Oct 2016 12:01:00 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3DEE617D8062
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 12:03:04 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u95B0xv515860092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Oct 2016 11:00:59 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u95B0rUt019675
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Oct 2016 05:00:58 -0600
Subject: Re: [PATCH v3 0/4] implement vcpu preempted check
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org
References: <1469101514-49475-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
 will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com,
 pbonzini@redhat.com, bsingharora@gmail.com
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 5 Oct 2016 13:00:51 +0200
MIME-Version: 1.0
In-Reply-To: <1469101514-49475-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <847f7377-61d3-835e-458b-aa9f4f5fcf8c@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/21/2016 01:45 PM, Pan Xinhui wrote:
> change from v2:
> 	no code change, fix typos, update some comments
> 
> change from v1:
> 	a simplier definition of default vcpu_is_preempted
> 	skip mahcine type check on ppc, and add config. remove dedicated macro.
> 	add one patch to drop overload of rwsem_spin_on_owner and mutex_spin_on_owner. 
> 	add more comments
> 	thanks boqun and Peter's suggestion.
> 
> This patch set aims to fix lock holder preemption issues.
> 
> test-case:
> perf record -a perf bench sched messaging -g 400 -p && perf report
> 
> before patch:
> 18.09%  sched-messaging  [kernel.vmlinux]  [k] osq_lock
> 12.28%  sched-messaging  [kernel.vmlinux]  [k] rwsem_spin_on_owner
>  5.27%  sched-messaging  [kernel.vmlinux]  [k] mutex_unlock
>  3.89%  sched-messaging  [kernel.vmlinux]  [k] wait_consider_task
>  3.64%  sched-messaging  [kernel.vmlinux]  [k] _raw_write_lock_irq
>  3.41%  sched-messaging  [kernel.vmlinux]  [k] mutex_spin_on_owner.is
>  2.49%  sched-messaging  [kernel.vmlinux]  [k] system_call
> 
> after patch:
>  9.99%  sched-messaging  [kernel.vmlinux]  [k] mutex_unlock
>  5.28%  sched-messaging  [unknown]         [H] 0xc0000000000768e0
>  4.27%  sched-messaging  [kernel.vmlinux]  [k] __copy_tofrom_user_power7
>  3.77%  sched-messaging  [kernel.vmlinux]  [k] copypage_power7
>  3.24%  sched-messaging  [kernel.vmlinux]  [k] _raw_write_lock_irq
>  3.02%  sched-messaging  [kernel.vmlinux]  [k] system_call
>  2.69%  sched-messaging  [kernel.vmlinux]  [k] wait_consider_task
> 
> We introduce interface bool vcpu_is_preempted(int cpu) and use it in some spin
> loops of osq_lock, rwsem_spin_on_owner and mutex_spin_on_owner.
> These spin_on_onwer variant also cause rcu stall before we apply this patch set
> 
> Pan Xinhui (4):
>   kernel/sched: introduce vcpu preempted check interface
>   powerpc/spinlock: support vcpu preempted check
>   locking/osq: Drop the overhead of osq_lock()
>   kernel/locking: Drop the overhead of {mutex,rwsem}_spin_on_owner
> 
>  arch/powerpc/include/asm/spinlock.h | 18 ++++++++++++++++++
>  include/linux/sched.h               | 12 ++++++++++++
>  kernel/locking/mutex.c              | 15 +++++++++++++--
>  kernel/locking/osq_lock.c           | 10 +++++++++-
>  kernel/locking/rwsem-xadd.c         | 16 +++++++++++++---
>  5 files changed, 65 insertions(+), 6 deletions(-)
> 

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
for the full series. With my patch on top this really improves
some benchmarks for overcommitted KVM guests.
