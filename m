Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tY29n0pbDzDvhh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 00:13:00 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB6D5Vtb060793
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 08:12:58 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 275qvkc9cx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Dec 2016 08:12:58 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Tue, 6 Dec 2016 23:12:56 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EF7DD3578058
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 00:12:53 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB6DCrTU52494540
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Dec 2016 00:12:53 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB6DCrmX000316
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Dec 2016 00:12:53 +1100
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 longman@redhat.com, xinhui.pan@linux.vnet.ibm.com,
 virtualization@lists.linux-foundation.org, boqun.feng@gmail.com
Subject: [PATCH v9 0/6] Implement qspinlock/pv-qspinlock on ppc
Date: Tue,  6 Dec 2016 13:09:21 -0500
Message-Id: <1481047767-60255-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
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
patches are based on linux-next
  qspinlock can avoid waiter starved issue. It has about the same speed in
single-thread and it can be much faster in high contention situations
especially when the spinlock is embedded within the data structure to be
protected.

v8 -> v9:
	mv qspinlocm config entry to platforms/kconfig
	fix comments and remove unnecessary codes, thanks boqun reviewing.
v7 -> v8:
	add one patch to drop a function call under native qspinlock unlock.
	Enabling qspinlock or not is a complier option now.
	rebase onto linux-next(4.9-rc7)
v6 -> v7:
	rebase onto 4.8-rc4
v1 -> v6:
	too many details. snip. 

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
  powerpc/qspinlock: powerpc support qspinlock
  powerpc: platforms/Kconfig: Add qspinlock build config
  powerpc: lib/locks.c: Add cpu yield/wake helper function
  powerpc/pv-qspinlock: powerpc support pv-qspinlock
  powerpc: pSeries: Add pv-qspinlock build config/make
  powerpc/pv-qspinlock: Optimise native unlock path

 arch/powerpc/include/asm/qspinlock.h               |  93 ++++++++++++
 arch/powerpc/include/asm/qspinlock_paravirt.h      |  52 +++++++
 .../powerpc/include/asm/qspinlock_paravirt_types.h |  13 ++
 arch/powerpc/include/asm/spinlock.h                |  35 +++--
 arch/powerpc/include/asm/spinlock_types.h          |   4 +
 arch/powerpc/kernel/Makefile                       |   1 +
 arch/powerpc/kernel/paravirt.c                     | 157 +++++++++++++++++++++
 arch/powerpc/lib/locks.c                           | 123 ++++++++++++++++
 arch/powerpc/platforms/Kconfig                     |   9 ++
 arch/powerpc/platforms/pseries/Kconfig             |   8 ++
 arch/powerpc/platforms/pseries/setup.c             |   5 +
 11 files changed, 487 insertions(+), 13 deletions(-)
 create mode 100644 arch/powerpc/include/asm/qspinlock.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt_types.h
 create mode 100644 arch/powerpc/kernel/paravirt.c

-- 
2.4.11
