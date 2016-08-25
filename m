Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKZ6y5NmnzDrcc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 16:30:34 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7P6SLdb113775
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 02:30:32 -0400
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 250q1p95sk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 02:30:32 -0400
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 25 Aug 2016 12:00:26 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 433F9394005C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 12:00:24 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7P6UOlM35651688
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 12:00:24 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7P6UGHF030619
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 12:00:23 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [RFC PATCH v3 00/12] powerpc: "paca->soft_enabled" based local atomic
 operation implementation
Date: Thu, 25 Aug 2016 11:59:51 +0530
Message-Id: <1472106603-23336-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Local atomic operations are fast and highly reentrant per CPU counters.
Used for percpu variable updates. Local atomic operations only guarantee
variable modification atomicity wrt the CPU which owns the data and
these needs to be executed in a preemption safe way.

Here is the design of the patchset. Since local_* operations
are only need to be atomic to interrupts (IIUC), we have two options.
Either replay the "op" if interrupted or replay the interrupt after
the "op". Initial patchset posted was based on implementing local_* operation
based on CR5 which replay's the "op". Patchset had issues in case of
rewinding the address pointor from an array. This make the slow patch
really slow. Since CR5 based implementation proposed using __ex_table to find
the rewind address, this rasied concerns about size of __ex_table and vmlinux.

https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-December/123115.html

But this patchset uses Benjamin Herrenschmidt suggestion of using
arch_local_irq_disable() to soft_disable interrupts (including PMIs).
After finishing the "op", arch_local_irq_restore() called and correspondingly
interrupts are replayed if any occured.

Current paca->soft_enabled logic is reserved and MASKABLE_EXCEPTION_* macros
are extended to support this feature.

patch re-write the current local_* functions to use arch_local_irq_disbale.
Base flow for each function is

 {
        soft_irq_set_mask()
        load
        ..
        store
        arch_local_irq_restore()
 }

Reason for the approach is that, currently l[w/d]arx/st[w/d]cx.
instruction pair is used for local_* operations, which are heavy
on cycle count and they dont support a local variant. So to
see whether the new implementation helps, used a modified
version of Rusty's benchmark code on local_t.

https://lkml.org/lkml/2008/12/16/450

Modifications to Rusty's benchmark code:
 - Executed only local_t test

Here are the values with the patch.

Time in ns per iteration

Local_t         Without Patch           With Patch

_inc                    28              8
_add                    28              8
_read                   3               3
_add_return             28              7

Currently only asm/local.h has been rewrite, and also
the entire change is tested only in PPC64 (pseries guest)
and PPC64 LE host.

First four are the clean up patches which lays the foundation
to make things easier. Fifth patch in the patchset reverse the
current soft_enabled logic and commit message details the reason and
need for this change. Sixth and seventh patch refactor's the __EXPECTION_PROLOG_1
code to support addition of a new parameter to MASKABLE_* macros. New parameter
will give the possible mask for the interrupt. Rest of the patches are 
to add support for maskable PMI and implementation of local_t using arch_local_irq_*().

Since the patchset is experimental, changes made are focused on pseries and
powernv platforms only. Would really like to know comments for
this approach before extending to other powerpc platforms.

Changelog RFC v2:
1)Renamed IRQ_DISABLE_LEVEL_* to IRQ_DISABLE_MASK_* and made logic changes
  to treat soft_enabled as a mask and not a flag or level.
2)Added a new Kconfig variable to support a WARN_ON
3)Refactored patchset for eaiser review.
4)Made changes to commit messages.
5)Made changes for BOOK3E version

Changelog RFC v1:

1)Commit messages are improved.
2)Renamed the arch_local_irq_disable_var to soft_irq_set_level as suggested
3)Renamed the LAZY_INTERRUPT* macro to IRQ_DISABLE_LEVEL_* as suggested
4)Extended the MASKABLE_EXCEPTION* macros to support additional parameter.
5)Each MASKABLE_EXCEPTION_* macro will carry a "mask_level"
6)Logic to decide on jump to maskable_handler in SOFTEN_TEST is now based on
  "mask_level"
7)__EXCEPTION_PROLOG_1 is factored out to support "mask_level" parameter.
  This reduced the code changes needed for supporting "mask_level" parameters.

Madhavan Srinivasan (12):
  powerpc: Add #defs for paca->soft_enabled flags
  powerpc: Cleanup to use IRQ_DISABLE_MASK_* macros for
    paca->soft_enabled update
  powerpc: move set_soft_enabled()
  powerpc: Use set_soft_enabled api to update paca->soft_enabled
  powerpc: reverse the soft_enable logic
  powerpc: Avoid using EXCEPTION_PROLOG_1 macro in MASKABLE_*
  powerpc: Add new _EXCEPTION_PROLOG_1 macro
  powerpc: Introduce new mask bit for soft_enabled
  powerpc: Add "bitmask" paramater to MASKABLE_* macros
  powerpc: Add support to mask perf interrupts
  powerpc: Support to replay PMIs
  powerpc: rewrite local_t using soft_irq

 arch/powerpc/Kconfig                     |   4 ++
 arch/powerpc/include/asm/exception-64s.h | 103 +++++++++++++++++++++----------
 arch/powerpc/include/asm/hw_irq.h        |  46 +++++++++++---
 arch/powerpc/include/asm/irqflags.h      |   8 +--
 arch/powerpc/include/asm/kvm_ppc.h       |   2 +-
 arch/powerpc/include/asm/local.h         |  91 ++++++++++++++++++---------
 arch/powerpc/kernel/entry_64.S           |  24 ++++---
 arch/powerpc/kernel/exceptions-64e.S     |   8 +--
 arch/powerpc/kernel/exceptions-64s.S     |  42 ++++++++-----
 arch/powerpc/kernel/head_64.S            |   5 +-
 arch/powerpc/kernel/idle_book3e.S        |   2 +-
 arch/powerpc/kernel/idle_power4.S        |   3 +-
 arch/powerpc/kernel/irq.c                |  27 ++++----
 arch/powerpc/kernel/process.c            |   3 +-
 arch/powerpc/kernel/setup_64.c           |   5 +-
 arch/powerpc/kernel/time.c               |   4 +-
 arch/powerpc/mm/hugetlbpage.c            |   2 +-
 arch/powerpc/perf/core-book3s.c          |   2 +-
 18 files changed, 256 insertions(+), 125 deletions(-)

-- 
2.7.4
