Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r88dd5400zDqCW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 17:50:45 +1000 (AEST)
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Tue, 17 May 2016 13:20:42 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 6FC5EE005E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 13:23:51 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4H7od3G31326298
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 13:20:40 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4H7oWnx016651
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 13:20:39 +0530
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 waiman.long@hpe.com, mnipxh@163.com, boqun.feng@gmail.com,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v3 0/6] powerpc use pv-qpsinlock instead of spinlock
Date: Tue, 17 May 2016 15:49:41 +0800
Message-Id: <1463471387-5115-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

change fome v1:
	separate into 6 pathes from one patch
	some minor code changes.

benchmark test results are below.
run 3 tests on pseries IBM,8408-E8E with 32cpus, 64GB memory
perf bench futex hash
perf bench futex lock-pi
perf record -advRT || perf bench sched messaging -g 1000 || perf report

summary:
_____test________________spinlcok______________pv-qspinlcok_____
|futex hash	|	556370 ops	|	629634 ops	|
|futex lock-pi	|	362 ops		|	367 ops		|
|workloads	|	23%		|	13%		|

details:

spinlock:
test 1)
# Running futex/hash benchmark...
Run summary [PID 9962]: 32 threads, each operating on 1024 [private] futexes for 10 secs.
Averaged 556370 operations/sec (+- 0.61%), total secs = 10

test 2)
# Running futex/lock-pi benchmark...
Run summary [PID 9962]: 32 threads doing pi lock/unlock pairing for 10 secs.
Averaged 362 operations/sec (+- 0.00%), total secs = 10

test 3)
perf bench sched messaging -g 1000
perf record -avdRT and perf report
# Samples: 2M of event 'cycles:ppp'
# Event count (approx.): 2045582241213
#
# Overhead  Command          Shared Object        Symbol
# ........  ...............  ...................  ........................................................
#
    22.96%  sched-messaging  [kernel.kallsyms]    [k] _raw_spin_lock_irqsave
    19.76%  sched-messaging  [kernel.kallsyms]    [k] __spin_yield
     2.09%  sched-messaging  [kernel.kallsyms]    [k] __slab_free
     2.07%  sched-messaging  [kernel.kallsyms]    [k] unix_stream_read_generic


pv-qspinlock:

test 1)
# Running futex/hash benchmark...
Run summary [PID 3219]: 32 threads, each operating on 1024 [private] futexes for 10 secs.
Averaged 629634 operations/sec (+- 0.38%), total secs = 10

test 2)
# Running futex/lock-pi benchmark...
Run summary [PID 3219]: 32 threads doing pi lock/unlock pairing for 10 secs.
Averaged 367 operations/sec (+- 0.00%), total secs = 10

test 3)
perf bench sched messaging -g 1000
perf record -avdRT and perf report
# Samples: 1M of event 'cycles:ppp'
# Event count (approx.): 1250040606393
#
# Overhead  Command          Shared Object                   Symbol
# ........  ...............  ..............................  ........................................................
#
     9.87%  sched-messaging  [kernel.vmlinux]                [k] __pv_queued_spin_lock_slowpath
     3.66%  sched-messaging  [kernel.vmlinux]                [k] __pv_queued_spin_unlock
     3.37%  sched-messaging  [kernel.vmlinux]                [k] __slab_free
     3.06%  sched-messaging  [kernel.vmlinux]                [k] unix_stream_read_generic


Pan Xinhui (6):
  qspinlock: powerpc support qspinlock
  powerpc: pseries/Kconfig: qspinlock build config
  powerpc: lib/locks.c: cpu yield/wake helper function
  pv-qspinlock: powerpc support pv-qspinlock
  pv-qspinlock: use cmpxchg_release in __pv_queued_spin_unlock
  powerpc: pseries: pv-qspinlock build config/make

 arch/powerpc/include/asm/qspinlock.h               | 39 +++++++++++++++++++
 arch/powerpc/include/asm/qspinlock_paravirt.h      | 38 +++++++++++++++++++
 .../powerpc/include/asm/qspinlock_paravirt_types.h | 13 +++++++
 arch/powerpc/include/asm/spinlock.h                | 31 +++++++++------
 arch/powerpc/include/asm/spinlock_types.h          |  4 ++
 arch/powerpc/kernel/Makefile                       |  1 +
 arch/powerpc/kernel/paravirt.c                     | 44 ++++++++++++++++++++++
 arch/powerpc/lib/locks.c                           | 36 ++++++++++++++++++
 arch/powerpc/platforms/pseries/Kconfig             |  9 +++++
 arch/powerpc/platforms/pseries/setup.c             |  5 +++
 kernel/locking/qspinlock_paravirt.h                |  2 +-
 11 files changed, 209 insertions(+), 13 deletions(-)
 create mode 100644 arch/powerpc/include/asm/qspinlock.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt_types.h
 create mode 100644 arch/powerpc/kernel/paravirt.c

-- 
1.9.1
