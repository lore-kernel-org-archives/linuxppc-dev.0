Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rL2hX44ftzDqvs
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 19:57:32 +1000 (AEST)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Thu, 2 Jun 2016 03:27:19 -0600
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 waiman.long@hpe.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v5 0/6] powerPC/pSeries use pv-qpsinlock as the default
 spinlock implemention
Date: Thu,  2 Jun 2016 17:26:24 +0800
Message-Id: <1464859590-5292-2-git-send-email-xinhui.pan@linux.vnet.ibm.com>
In-Reply-To: <1464859590-5292-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1464859590-5292-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

change from v4:
	BUG FIX. thanks boqun reporting this issue.
	struct  __qspinlock has different layout in bigendian mahcine.
	native_queued_spin_unlock() may write value to a wrong address. now fix it.
	sorry for not even doing a test on bigendian machine before!!!

change from v3:
	a big change in [PATCH v4 4/6] pv-qspinlock: powerpc support pv-qspinlock
	no other patch changed.
	and the patch cover letter tilte has changed as only pseries may need use pv-qspinlock, not all powerpc.

	1) __pv_wait will not return until *ptr != val as Waiman gives me a tip.
	2) support lock holder serching by storing cpu number into a hash table(implemented as an array)
	This is because lock_stealing hit too much, up to 10%~20% of all the successful lock(), and avoid
	vcpu slices bounce.
	
change from v2:
	__spin_yeild_cpu() will yield slices to lpar if target cpu is running.
	remove unnecessary rmb() in __spin_yield/wake_cpu.
	__pv_wait() will check the *ptr == val.
	some commit message change

change fome v1:
	separate into 6 pathes from one patch
	some minor code changes.

I do several tests on pseries IBM,8408-E8E with 32cpus, 64GB memory, kernel 4.6
benchmark test results are below.

2 perf tests:
perf bench futex hash
perf bench futex lock-pi

_____test________________spinlcok______________pv-qspinlcok_____
|futex hash	|	528572 ops	|	573238 ops	|
|futex lock-pi	|	354 ops		|	352 ops		|

scheduler test:
Test how many loops of schedule() can finish within 10 seconds on all cpus.

_____test________________spinlcok______________pv-qspinlcok_____
|schedule() loops|	340890082 	|	331730973	|

kernel compiling test:
build a default linux kernel image to see how long it took

_____test________________spinlcok______________pv-qspinlcok_____
| compiling takes|	22m 		|	22m		|

some notes:
the performace is as good as current spinlock's. in some case better while some cases worse.
But in some other tests(not listed here), we verify the two spinlock's workloads by perf record&report.
pv-qspinlock is light-weight than current spinlock.
This patch series depends on 2 patches:
[patch]powerpc: Implement {cmp}xchg for u8 and u16
[patch]locking/pvqspinlock: Add lock holder CPU argument to pv_wait() from Waiman

Some other patches in Waiman's "locking/pvqspinlock: Fix missed PV wakeup & support PPC" are not applied for now.

Pan Xinhui (6):
  qspinlock: powerpc support qspinlock
  powerpc: pseries/Kconfig: Add qspinlock build config
  powerpc: lib/locks.c: Add cpu yield/wake helper function
  pv-qspinlock: powerpc support pv-qspinlock
  pv-qspinlock: use cmpxchg_release in __pv_queued_spin_unlock
  powerpc: pseries: Add pv-qspinlock build config/make

 arch/powerpc/include/asm/qspinlock.h               |  41 +++++++
 arch/powerpc/include/asm/qspinlock_paravirt.h      |  38 +++++++
 .../powerpc/include/asm/qspinlock_paravirt_types.h |  13 +++
 arch/powerpc/include/asm/spinlock.h                |  31 ++++--
 arch/powerpc/include/asm/spinlock_types.h          |   4 +
 arch/powerpc/kernel/Makefile                       |   1 +
 arch/powerpc/kernel/paravirt.c                     | 121 +++++++++++++++++++++
 arch/powerpc/lib/locks.c                           |  37 +++++++
 arch/powerpc/platforms/pseries/Kconfig             |   9 ++
 arch/powerpc/platforms/pseries/setup.c             |   5 +
 kernel/locking/qspinlock_paravirt.h                |   2 +-
 11 files changed, 289 insertions(+), 13 deletions(-)
 create mode 100644 arch/powerpc/include/asm/qspinlock.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt_types.h
 create mode 100644 arch/powerpc/kernel/paravirt.c

-- 
2.4.11
