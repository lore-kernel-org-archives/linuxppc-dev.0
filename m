Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rF4xB3V3MzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 18:21:18 +1000 (AEST)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Wed, 25 May 2016 18:21:16 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 16DFA2BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 18:21:04 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4P8KroL58720400
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 18:20:53 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4P8JxDR014667
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 18:20:00 +1000
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 jeremy@goop.org, chrisw@sous-sol.org, akataria@vmware.com,
 rusty@rustcorp.com.au, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v3 0/6] powerpc use pv-qpsinlock as the default spinlock
 implemention
Date: Wed, 25 May 2016 16:18:03 +0800
Message-Id: <1464164289-6124-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

change from v2:
	__spin_yeild_cpu() will yield slices to lpar if target cpu is running.
	remove unnecessary rmb() in __spin_yield/wake_cpu.
	__pv_wait() will check the *ptr == val.
	some commit message change

change fome v1:
	separate into 6 pathes from one patch
	some minor code changes.

I do several tests on pseries IBM,8408-E8E with 32cpus, 64GB memory.
benchmark test results are below.

2 perf tests:
perf bench futex hash
perf bench futex lock-pi

_____test________________spinlcok______________pv-qspinlcok_____
|futex hash	|	556370 ops	|	629634 ops	|
|futex lock-pi	|	362 ops		|	367 ops		|

scheduler test:
Test how many loops of schedule() can finish within 10 seconds on all cpus.

_____test________________spinlcok______________pv-qspinlcok_____
|schedule() loops|	322811921 	|	311449290	|

kernel compiling test:
build a linux kernel image to see how long it took

_____test________________spinlcok______________pv-qspinlcok_____
| compiling takes|	22m 		|	22m		|

Pan Xinhui (6):
  qspinlock: powerpc support qspinlock
  powerpc: pseries/Kconfig: Add qspinlock build config
  powerpc: lib/locks.c: Add cpu yield/wake helper function
  pv-qspinlock: powerpc support pv-qspinlock
  pv-qspinlock: use cmpxchg_release in __pv_queued_spin_unlock
  powerpc: pseries: Add pv-qspinlock build config/make

 arch/powerpc/include/asm/qspinlock.h               | 39 +++++++++++++++++++
 arch/powerpc/include/asm/qspinlock_paravirt.h      | 38 ++++++++++++++++++
 .../powerpc/include/asm/qspinlock_paravirt_types.h | 13 +++++++
 arch/powerpc/include/asm/spinlock.h                | 31 +++++++++------
 arch/powerpc/include/asm/spinlock_types.h          |  4 ++
 arch/powerpc/kernel/Makefile                       |  1 +
 arch/powerpc/kernel/paravirt.c                     | 45 ++++++++++++++++++++++
 arch/powerpc/lib/locks.c                           | 37 ++++++++++++++++++
 arch/powerpc/platforms/pseries/Kconfig             |  9 +++++
 arch/powerpc/platforms/pseries/setup.c             |  5 +++
 kernel/locking/qspinlock_paravirt.h                |  2 +-
 11 files changed, 211 insertions(+), 13 deletions(-)
 create mode 100644 arch/powerpc/include/asm/qspinlock.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt_types.h
 create mode 100644 arch/powerpc/kernel/paravirt.c

-- 
1.9.1
