Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szMtw3zVfzDt0Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 17:47:20 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9J6huwN063592
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 02:47:18 -0400
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
 by mx0b-001b2d01.pphosted.com with ESMTP id 265y7sa2mk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 02:47:17 -0400
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Wed, 19 Oct 2016 07:47:15 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id E7CE717D8056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 07:49:24 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9J6lDpi9371992
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 06:47:13 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9J6lAt7014710
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 00:47:13 -0600
Subject: Re: [PATCH v4 0/5] implement vcpu preempted check
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org
References: <1476872416-42752-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
 will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com,
 pbonzini@redhat.com, bsingharora@gmail.com, boqun.feng@gmail.com
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 19 Oct 2016 08:47:09 +0200
MIME-Version: 1.0
In-Reply-To: <1476872416-42752-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <e3fd1bd3-c57d-f0b0-68c4-ecd450d1ad32@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/19/2016 12:20 PM, Pan Xinhui wrote:
> change from v3:
> 	add x86 vcpu preempted check patch

If you want you could add the s390 patch that I provided for your last version.
I also gave my Acked-by for all previous patches.



> change from v2:
> 	no code change, fix typos, update some comments
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
> 18.09%  sched-messaging  [kernel.vmlinux]  [k] osq_lock
> 12.28%  sched-messaging  [kernel.vmlinux]  [k] rwsem_spin_on_owner
>  5.27%  sched-messaging  [kernel.vmlinux]  [k] mutex_unlock
>  3.89%  sched-messaging  [kernel.vmlinux]  [k] wait_consider_task
>  3.64%  sched-messaging  [kernel.vmlinux]  [k] _raw_write_lock_irq
>  3.41%  sched-messaging  [kernel.vmlinux]  [k] mutex_spin_on_owner.is
>  2.49%  sched-messaging  [kernel.vmlinux]  [k] system_call
> 
> We introduce interface bool vcpu_is_preempted(int cpu) and use it in some spin
> loops of osq_lock, rwsem_spin_on_owner and mutex_spin_on_owner.
> These spin_on_onwer variant also cause rcu stall before we apply this patch set
> 
> We also have observed some performace improvements.
> 
> PPC test result:
> 
> 1 copy - 0.94%
> 2 copy - 7.17%
> 4 copy - 11.9%
> 8 copy -  3.04%
> 16 copy - 15.11%
> 
> details below:
> Without patch:
> 
> 1 copy - File Write 4096 bufsize 8000 maxblocks      2188223.0 KBps  (30.0 s, 1 samples)
> 2 copy - File Write 4096 bufsize 8000 maxblocks      1804433.0 KBps  (30.0 s, 1 samples)
> 4 copy - File Write 4096 bufsize 8000 maxblocks      1237257.0 KBps  (30.0 s, 1 samples)
> 8 copy - File Write 4096 bufsize 8000 maxblocks      1032658.0 KBps  (30.0 s, 1 samples)
> 16 copy - File Write 4096 bufsize 8000 maxblocks       768000.0 KBps  (30.1 s, 1 samples)
> 
> With patch: 
> 
> 1 copy - File Write 4096 bufsize 8000 maxblocks      2209189.0 KBps  (30.0 s, 1 samples)
> 2 copy - File Write 4096 bufsize 8000 maxblocks      1943816.0 KBps  (30.0 s, 1 samples)
> 4 copy - File Write 4096 bufsize 8000 maxblocks      1405591.0 KBps  (30.0 s, 1 samples)
> 8 copy - File Write 4096 bufsize 8000 maxblocks      1065080.0 KBps  (30.0 s, 1 samples)
> 16 copy - File Write 4096 bufsize 8000 maxblocks       904762.0 KBps  (30.0 s, 1 samples)
> 
> X86 test result:
> 	test-case			after-patch	  before-patch
> Execl Throughput                       |    18307.9 lps  |    11701.6 lps 
> File Copy 1024 bufsize 2000 maxblocks  |  1352407.3 KBps |   790418.9 KBps
> File Copy 256 bufsize 500 maxblocks    |   367555.6 KBps |   222867.7 KBps
> File Copy 4096 bufsize 8000 maxblocks  |  3675649.7 KBps |  1780614.4 KBps
> Pipe Throughput                        | 11872208.7 lps  | 11855628.9 lps 
> Pipe-based Context Switching           |  1495126.5 lps  |  1490533.9 lps 
> Process Creation                       |    29881.2 lps  |    28572.8 lps 
> Shell Scripts (1 concurrent)           |    23224.3 lpm  |    22607.4 lpm 
> Shell Scripts (8 concurrent)           |     3531.4 lpm  |     3211.9 lpm 
> System Call Overhead                   | 10385653.0 lps  | 10419979.0 lps 
> 
> Pan Xinhui (5):
>   kernel/sched: introduce vcpu preempted check interface
>   locking/osq: Drop the overload of osq_lock()
>   kernel/locking: Drop the overload of {mutex,rwsem}_spin_on_owner
>   powerpc/spinlock: support vcpu preempted check
>   x86, kvm: support vcpu preempted check
> 
>  arch/powerpc/include/asm/spinlock.h   |  8 ++++++++
>  arch/x86/include/asm/paravirt_types.h |  6 ++++++
>  arch/x86/include/asm/spinlock.h       |  8 ++++++++
>  arch/x86/include/uapi/asm/kvm_para.h  |  3 ++-
>  arch/x86/kernel/kvm.c                 | 11 +++++++++++
>  arch/x86/kernel/paravirt.c            | 11 +++++++++++
>  arch/x86/kvm/x86.c                    | 12 ++++++++++++
>  include/linux/sched.h                 | 12 ++++++++++++
>  kernel/locking/mutex.c                | 15 +++++++++++++--
>  kernel/locking/osq_lock.c             | 10 +++++++++-
>  kernel/locking/rwsem-xadd.c           | 16 +++++++++++++---
>  11 files changed, 105 insertions(+), 7 deletions(-)
> 
