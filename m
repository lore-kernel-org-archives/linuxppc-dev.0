Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3scvW274XgzDsd8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 15:26:06 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8J5NHOF139309
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 01:26:05 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25hxp093je-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 01:26:04 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Sun, 18 Sep 2016 23:26:04 -0600
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 waiman.long@hpe.com, xinhui.pan@linux.vnet.ibm.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH v7 0/6] Implement qspinlock/pv-qspinlock on ppc
Date: Mon, 19 Sep 2016 05:23:51 -0400
Message-Id: <1474277037-15200-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,
  this is the fairlock patchset. You can apply them and build successfully.
patches are based on 4.8-rc4.
  qspinlock can avoid waiter starved issue. It has about the same speed in
single-thread and it can be much faster in high contention situations
especially when the spinlock is embedded within the data structure to be
protected.

v6 -> v7:
	rebase onto 4.8-rc4
no changelog anymore, sorry for that. I hope there is a very careful review.

Todo:
	we can save one function call overhead. As we can use feature-fixup to patch
the binary code. Currently there is pv_lock_ops->lock(lock) and ->unlock(lock) to acquire/release the lock.

some benchmark result below

perf bench
these numbers are ops per sec, So the higher the better.
*******************************************
on pSeries with 32 vcpus, 32Gb memory, pHyp.
------------------------------------------------------------------------------------
	test case		| pv-qspinlock  |  qspinlock 	| current-spinlock
------------------------------------------------------------------------------------
futex hash			| 618572	| 552332	| 553788
futex lock-pi			| 364		| 364		| 364
sched pipe			| 78984		| 76060		| 81454
------------------------------------------------------------------------------------

unix bench:
these numbers are scores, So the higher the better.
************************************************
on PowerNV with 16 cores(cpus) (smt off), 32Gb memory:
-------------
pv-qspinlock and qspinlock have very similar results because pv-qspinlock use native version
which is only having one callback overhead
------------------------------------------------------------------------------------
	test case		| pv-qspinlock and qspinlock | current-spinlock
------------------------------------------------------------------------------------
Execl Throughput                               761.1             761.4
File Copy 1024 bufsize 2000 maxblocks         1259.8            1286.6
File Copy 256 bufsize 500 maxblocks            782.2             790.3
File Copy 4096 bufsize 8000 maxblocks         2741.5            2817.4
Pipe Throughput                               1063.2            1036.7
Pipe-based Context Switching                   284.7             281.1
Process Creation                               679.6             649.1
Shell Scripts (1 concurrent)                  1933.2            1922.9
Shell Scripts (8 concurrent)                  5003.3            4899.8
System Call Overhead                           900.6             896.8
                                             ==========================
System Benchmarks Index Score                 1139.3 	 	 1133.0
--------------------------------------------------------------------------- ---------

*******************************************
on pSeries with 32 vcpus, 32Gb memory, pHyp.
------------------------------------------------------------------------------------
	test case		|	pv-qspinlock |	qspinlock | current-spinlock
------------------------------------------------------------------------------------
Execl Throughput                             877.1         891.2         872.8
File Copy 1024 bufsize 2000 maxblocks       1390.4        1399.2        1395.0
File Copy 256 bufsize 500 maxblocks          882.4         889.5         881.8
File Copy 4096 bufsize 8000 maxblocks       3112.3        3113.4        3121.7
Pipe Throughput                             1095.8        1162.6        1158.5
Pipe-based Context Switching                 194.9         192.7         200.7
Process Creation                             518.4         526.4         509.1
Shell Scripts (1 concurrent)                1401.9        1413.9        1402.2
Shell Scripts (8 concurrent)                3215.6        3246.6        3229.1
System Call Overhead                         833.2         892.4         888.1
                                          ====================================
System Benchmarks Index Score               1033.7        1052.5        1047.8
------------------------------------------------------------------------------------

******************************************
on pSeries with 32 vcpus, 16Gb memory, KVM.
------------------------------------------------------------------------------------
	test case		|	pv-qspinlock |	qspinlock | current-spinlock
------------------------------------------------------------------------------------
Execl Throughput                             497.4        518.7         497.8
File Copy 1024 bufsize 2000 maxblocks       1368.8       1390.1        1343.3
File Copy 256 bufsize 500 maxblocks          857.7        859.8         831.4
File Copy 4096 bufsize 8000 maxblocks       2851.7       2838.1        2785.5
Pipe Throughput                             1221.9       1265.3        1250.4
Pipe-based Context Switching                 529.8        578.1         564.2
Process Creation                             408.4        421.6         287.6
Shell Scripts (1 concurrent)                1201.8       1215.3        1185.8
Shell Scripts (8 concurrent)                3758.4       3799.3        3878.9
System Call Overhead                        1008.3       1122.6        1134.2
                                          =====================================
System Benchmarks Index Score               1072.0       1108.9        1050.6
------------------------------------------------------------------------------------


Pan Xinhui (6):
  pv-qspinlock: use cmpxchg_release in __pv_queued_spin_unlock
  powerpc/qspinlock: powerpc support qspinlock
  powerpc: pseries/Kconfig: Add qspinlock build config
  powerpc: lib/locks.c: Add cpu yield/wake helper function
  powerpc/pv-qspinlock: powerpc support pv-qspinlock
  powerpc: pSeries: Add pv-qspinlock build config/make

 arch/powerpc/include/asm/qspinlock.h               |  93 +++++++++++++
 arch/powerpc/include/asm/qspinlock_paravirt.h      |  36 +++++
 .../powerpc/include/asm/qspinlock_paravirt_types.h |  13 ++
 arch/powerpc/include/asm/spinlock.h                |  35 +++--
 arch/powerpc/include/asm/spinlock_types.h          |   4 +
 arch/powerpc/kernel/Makefile                       |   1 +
 arch/powerpc/kernel/paravirt.c                     | 153 +++++++++++++++++++++
 arch/powerpc/lib/locks.c                           | 122 ++++++++++++++++
 arch/powerpc/platforms/pseries/Kconfig             |   9 ++
 arch/powerpc/platforms/pseries/setup.c             |   5 +
 kernel/locking/qspinlock_paravirt.h                |   2 +-
 11 files changed, 459 insertions(+), 14 deletions(-)
 create mode 100644 arch/powerpc/include/asm/qspinlock.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt_types.h
 create mode 100644 arch/powerpc/kernel/paravirt.c

-- 
2.4.11
