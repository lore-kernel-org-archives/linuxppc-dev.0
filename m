Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szdgN0Gz7zDt22
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 04:08:15 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9JH4HVC142723
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 13:08:13 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2668wje48d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 13:08:13 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Wed, 19 Oct 2016 11:08:12 -0600
Subject: Re: [PATCH v4 0/5] implement vcpu preempted check
To: Juergen Gross <jgross@suse.com>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org
References: <1476872416-42752-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <a801cd40-1019-01e2-1013-f04363fc7f31@suse.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
 will.deacon@arm.com, kernellwp@gmail.com, pbonzini@redhat.com,
 bsingharora@gmail.com, boqun.feng@gmail.com, borntraeger@de.ibm.com
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Date: Thu, 20 Oct 2016 01:08:02 +0800
MIME-Version: 1.0
In-Reply-To: <a801cd40-1019-01e2-1013-f04363fc7f31@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <59e0f857-0a5c-929d-98dc-878e97bcfb3c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


在 2016/10/19 23:58, Juergen Gross 写道:
> On 19/10/16 12:20, Pan Xinhui wrote:
>> change from v3:
>> 	add x86 vcpu preempted check patch
>> change from v2:
>> 	no code change, fix typos, update some comments
>> change from v1:
>> 	a simplier definition of default vcpu_is_preempted
>> 	skip mahcine type check on ppc, and add config. remove dedicated macro.
>> 	add one patch to drop overload of rwsem_spin_on_owner and mutex_spin_on_owner.
>> 	add more comments
>> 	thanks boqun and Peter's suggestion.
>>
>> This patch set aims to fix lock holder preemption issues.
>>
>> test-case:
>> perf record -a perf bench sched messaging -g 400 -p && perf report
>>
>> 18.09%  sched-messaging  [kernel.vmlinux]  [k] osq_lock
>> 12.28%  sched-messaging  [kernel.vmlinux]  [k] rwsem_spin_on_owner
>>  5.27%  sched-messaging  [kernel.vmlinux]  [k] mutex_unlock
>>  3.89%  sched-messaging  [kernel.vmlinux]  [k] wait_consider_task
>>  3.64%  sched-messaging  [kernel.vmlinux]  [k] _raw_write_lock_irq
>>  3.41%  sched-messaging  [kernel.vmlinux]  [k] mutex_spin_on_owner.is
>>  2.49%  sched-messaging  [kernel.vmlinux]  [k] system_call
>>
>> We introduce interface bool vcpu_is_preempted(int cpu) and use it in some spin
>> loops of osq_lock, rwsem_spin_on_owner and mutex_spin_on_owner.
>> These spin_on_onwer variant also cause rcu stall before we apply this patch set
>>
>> We also have observed some performace improvements.
>>
>> PPC test result:
>>
>> 1 copy - 0.94%
>> 2 copy - 7.17%
>> 4 copy - 11.9%
>> 8 copy -  3.04%
>> 16 copy - 15.11%
>>
>> details below:
>> Without patch:
>>
>> 1 copy - File Write 4096 bufsize 8000 maxblocks      2188223.0 KBps  (30.0 s, 1 samples)
>> 2 copy - File Write 4096 bufsize 8000 maxblocks      1804433.0 KBps  (30.0 s, 1 samples)
>> 4 copy - File Write 4096 bufsize 8000 maxblocks      1237257.0 KBps  (30.0 s, 1 samples)
>> 8 copy - File Write 4096 bufsize 8000 maxblocks      1032658.0 KBps  (30.0 s, 1 samples)
>> 16 copy - File Write 4096 bufsize 8000 maxblocks       768000.0 KBps  (30.1 s, 1 samples)
>>
>> With patch:
>>
>> 1 copy - File Write 4096 bufsize 8000 maxblocks      2209189.0 KBps  (30.0 s, 1 samples)
>> 2 copy - File Write 4096 bufsize 8000 maxblocks      1943816.0 KBps  (30.0 s, 1 samples)
>> 4 copy - File Write 4096 bufsize 8000 maxblocks      1405591.0 KBps  (30.0 s, 1 samples)
>> 8 copy - File Write 4096 bufsize 8000 maxblocks      1065080.0 KBps  (30.0 s, 1 samples)
>> 16 copy - File Write 4096 bufsize 8000 maxblocks       904762.0 KBps  (30.0 s, 1 samples)
>>
>> X86 test result:
>> 	test-case			after-patch	  before-patch
>> Execl Throughput                       |    18307.9 lps  |    11701.6 lps
>> File Copy 1024 bufsize 2000 maxblocks  |  1352407.3 KBps |   790418.9 KBps
>> File Copy 256 bufsize 500 maxblocks    |   367555.6 KBps |   222867.7 KBps
>> File Copy 4096 bufsize 8000 maxblocks  |  3675649.7 KBps |  1780614.4 KBps
>> Pipe Throughput                        | 11872208.7 lps  | 11855628.9 lps
>> Pipe-based Context Switching           |  1495126.5 lps  |  1490533.9 lps
>> Process Creation                       |    29881.2 lps  |    28572.8 lps
>> Shell Scripts (1 concurrent)           |    23224.3 lpm  |    22607.4 lpm
>> Shell Scripts (8 concurrent)           |     3531.4 lpm  |     3211.9 lpm
>> System Call Overhead                   | 10385653.0 lps  | 10419979.0 lps
>>
>> Pan Xinhui (5):
>>   kernel/sched: introduce vcpu preempted check interface
>>   locking/osq: Drop the overload of osq_lock()
>>   kernel/locking: Drop the overload of {mutex,rwsem}_spin_on_owner
>>   powerpc/spinlock: support vcpu preempted check
>>   x86, kvm: support vcpu preempted check
>
> The attached patch adds Xen support for x86. Please tell me whether you
> want to add this patch to your series or if I should post it when your
> series has been accepted.
>
hi, Juergen
	Your patch is pretty small and nice :) thanks!
I can include your patch into my next patchset after this patchset reviewed. :)


> You can add my
>
> Tested-by: Juergen Gross <jgross@suse.com>
>
> for patches 1-3 and 5 (paravirt parts only).
>

Thanks a lot!

xinhui

>
> Juergen
>
>>
>>  arch/powerpc/include/asm/spinlock.h   |  8 ++++++++
>>  arch/x86/include/asm/paravirt_types.h |  6 ++++++
>>  arch/x86/include/asm/spinlock.h       |  8 ++++++++
>>  arch/x86/include/uapi/asm/kvm_para.h  |  3 ++-
>>  arch/x86/kernel/kvm.c                 | 11 +++++++++++
>>  arch/x86/kernel/paravirt.c            | 11 +++++++++++
>>  arch/x86/kvm/x86.c                    | 12 ++++++++++++
>>  include/linux/sched.h                 | 12 ++++++++++++
>>  kernel/locking/mutex.c                | 15 +++++++++++++--
>>  kernel/locking/osq_lock.c             | 10 +++++++++-
>>  kernel/locking/rwsem-xadd.c           | 16 +++++++++++++---
>>  11 files changed, 105 insertions(+), 7 deletions(-)
>>
>
