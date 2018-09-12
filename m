Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429XFC4Yb2zF3D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 05:40:30 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8CJYXMM105456
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 15:40:28 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mf7btmhbs-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 15:40:27 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Wed, 12 Sep 2018 13:40:27 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, paulus@ozlabs.org, gromero@linux.vnet.ibm.com,
 mpe@ellerman.id.au, ldufour@linux.vnet.ibm.com
Subject: [RFC PATCH 00/11] New TM Model
Date: Wed, 12 Sep 2018 16:40:08 -0300
Message-Id: <1536781219-13938-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset for the hardware transactional memory (TM) subsystem aims to
avoid spending a lot of time on TM suspended mode in kernel space. It basically
changes where the reclaim/recheckpoint will be executed.

Once a CPU enters in transactional state it uses a footprint area to track
down the load/stores performed in transaction so it can be verified later
to decide if a conflict happened due to some change done in that state. If
a transaction is active in userspace and there is an exception that takes
the CPU to the kernel space the CPU moves the transaction to suspended
state but does not discard the footprint area.

POWER9 has a known problem[1][2] and does not have enough room in
footprint area for several transactions to be suspended at the same time
on concurrent CPUs leading to CPU stalls.

This patchset aims to reclaim the checkpointed footprint as soon as the
kernel is invoked, in the beginning of the exception handlers, thus freeing
room to other CPUs enter in suspended mode, avoiding too many CPUs in suspended
state that can cause the CPUs to stall. The same mechanism is done on kernel
exit, doing a recheckpoint as late as possible (which will reload the
checkpointed state into CPU's room) at the exception return.

The way to achieve this goal is creating a macro (TM_KERNEL_ENTRY) which
will check if userspace was in an active transaction just after getting
into kernel and reclaiming if that's the case. Thus all exception handlers
will call this macro as soon as possible.

All exceptions should reclaim (if necessary) at this stage and only
recheckpoint if the task is tagged as TIF_RESTORE_TM (i.e. was in
transactional state before being interrupted), which will be done at
ret_from_except_lite().

Ideally all reclaims will happen at the exception entrance, however during
the recheckpoint process another exception can hit the CPU which might
cause the current thread to be rescheduled, thus there is another reclaim
point to be considered at __switch_to().

Hence, by allowing the CPU to be in suspended state for only a brief period
it's possible to cope with the TM hardware limitations like the current
problem on the new POWER9.

This patchset was tested in different scenarios using different test
suites, as the kernel selftests and htm-torture[3], in the following
configuration:

 * POWER8/pseries LE and BE
 * POWER8/powernv LE
 * POWER9/powernv LE hosting KVM guests running TM tests

This patchset is based on initial work done by Cyril Bur:
    https://patchwork.ozlabs.org/cover/875341/

Regards,
Breno

[1] Documentation/powerpc/transactional_memory.txt
[2] commit 4bb3c7a0208fc13ca70598efd109901a7cd45ae7
[3] https://github.com/leitao/htm_torture/

Breno Leitao (11):
  powerpc/tm: Reclaim transaction on kernel entry
  powerpc/tm: Reclaim on unavailable exception
  powerpc/tm: Recheckpoint when exiting from kernel
  powerpc/tm: Always set TIF_RESTORE_TM on reclaim
  powerpc/tm: Function that updates the failure code
  powerpc/tm: Refactor the __switch_to_tm code
  powerpc/tm: Do not recheckpoint at sigreturn
  powerpc/tm: Do not reclaim on ptrace
  powerpc/tm: Do not restore default DSCR
  powerpc/tm: Set failure summary
  selftests/powerpc: Adapt the test

 arch/powerpc/include/asm/exception-64s.h      |  46 +++++
 arch/powerpc/kernel/entry_64.S                |  10 +
 arch/powerpc/kernel/exceptions-64s.S          |  15 +-
 arch/powerpc/kernel/process.c                 | 185 +++++++++---------
 arch/powerpc/kernel/ptrace.c                  |  10 +-
 arch/powerpc/kernel/signal_32.c               |  25 +--
 arch/powerpc/kernel/signal_64.c               |  17 +-
 arch/powerpc/kernel/tm.S                      |   4 -
 arch/powerpc/kernel/traps.c                   |  16 +-
 .../testing/selftests/powerpc/tm/tm-syscall.c |   6 -
 10 files changed, 178 insertions(+), 156 deletions(-)

-- 
2.19.0
