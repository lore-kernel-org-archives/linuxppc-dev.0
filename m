Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNGLJ0MDxzDrJS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 13:50:47 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v733mfu7046412
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 23:50:45 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c3t2jp4d3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 23:50:45 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 3 Aug 2017 13:50:42 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v733oWit23593062
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Aug 2017 13:50:40 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v733o7wN015635
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Aug 2017 13:50:07 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, anton@samba.org, paulus@samba.org,
 npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v9 00/14]powerpc: "paca->soft_enabled" based local atomic
 operation implementation
Date: Thu,  3 Aug 2017 09:19:04 +0530
Message-Id: <1501732158-19009-1-git-send-email-maddy@linux.vnet.ibm.com>
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
rewinding the address pointor from an array. This make the slow path
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
        powerpc_local_irq_pmu_save(flags)
        load
        ..
        store
        powerpc_local_irq_pmu_restore(flags)
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

_inc                    38              10
_add                    38              10
_read                   4               4
_add_return             38              10

Currently only asm/local.h has been rewritten, and also
the entire change is tested only in PPC64 (pseries guest)
and PPC64 LE host. Have only compile tested ppc64e_*.

First five are the clean up patches which lays the foundation
to make things easier. Fifth patch in the patchset reverse the
current soft_enabled logic and commit message details the reason and
need for this change. Six and seventh patch refactor's the __EXPECTION_PROLOG_1
code to support addition of a new parameter to MASKABLE_* macros. New parameter
will give the possible mask for the interrupt. Rest of the patches are
to add support for maskable PMI and implementation of local_t using powerpc_local_irq_pmu_*().

Changelog v8:
 - Rearranged series.
 - Updated the comments
 - Fixed a hang in embedded version (thanks to mpe)
 - Added couple of more cleanup patches to the series
 - Updated commit messages.

Changelog v7:
1)Missed first patch in the series

Changelog v6:
1)Moved the renaming of soft_enabled to soft_disable_mask patch earlier in the series.
2)Added code to hardwire "softe" value in pt_regs for userspace to be always 1
3)rebased to latest upstream.

Changelog v5:
1)Fixed the check in hard_irq_disable() macro for soft_disabled_mask

Changelog v4:
1)split the __SOFT_ENABLED logic check from patch 7 and merged to soft_enabled
logic reversing patch.
2)Made changes to commit messages
3)Added a new IRQ_DISBALE_MASK_ALL to include supported disabled mask bits. 

Changelog v3:
1)Made suggest to commit messages
2)Added a new patch (patch 12) to rename the soft_enabled to soft_disabled_mask

Changelog v2:
Rebased to latest upstream

Changelog v1:
1)squashed patches 1/2 together and 8/9/10 together for readability
2)Created a separate patch for the kconfig changes
3)Moved the new mask value commit to patch 11.
4)Renamed local_irq_pmu_*() to powerpc_irq_pmu_*() to avoid
  namespaces matches with generic kernel local_irq*() functions
5)Renamed __EXCEPTION_PROLOG_1 macro to MASKABLE_EXCEPTION_PROLOG_1 macro
6)Made changes to commit messages
7)Add more comments to codes

Changelog RFC v5:
1)Implemented new set of soft_enabled manipulation functions
2)rewritten arch_local_irq_* functions to use the new soft_enabled_*()
3)Add WARN_ON to identify invalid soft_enabled transitions
4)Added powerpc_local_irq_pmu_save() and powerpc_local_irq_pmu_restore() to
  support masking of irqs (with PMI).
5)Added local_irq_pmu_*()s macros with trace_hardirqs_on|off() to match
  include/linux/irqflags.h

Changelog RFC v4:
1)Fix build breaks in in ppc64e_defconfig compilation
2)Merged PMI replay code with the exception vector changes patch
3)Renamed the new API to set PMI mask bit as suggested
4)Modified the current arch_local_save and new API function call to
  "OR" and store the value to ->soft_enabled instead of just store.
5)Updated the check in the arch_local_irq_restore() to alway check for
  greather than or zero to _LINUX mask bit.
6)Updated the commit messages.

Changelog RFC v3:
1)Squashed PMI masked interrupt patch and replay patch together
2)Have created a new patch which includes a new Kconfig and set_irq_set_mask()
3)Fixed the compilation issue with IRQ_DISABLE_MASK_* macros in book3e_*

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

Madhavan Srinivasan (14):
  powerpc: Add #defs for paca->soft_enabled flags
  powerpc: move set_soft_enabled() and rename
  powerpc: Use soft_enabled_set api to update paca->soft_enabled
  powerpc: Add soft_enabled manipulation functions
  powerpc/irq: Cleanup hard_irq_disable() macro
  powerpc/irq: Fix arch_local_irq_disable() in book3s
  powerpc: Modify soft_enable from flag to mask
  powerpc: Rename soft_enabled to soft_disable_mask
  powerpc: Avoid using EXCEPTION_PROLOG_1 macro in MASKABLE_*
  powerpc: Add support to take additional parameter in MASKABLE_* macro
  Add support to mask perf interrupts and replay them
  powerpc:Add new kconfig IRQ_DEBUG_SUPPORT
  powerpc: Add new set of soft_disable_mask_ functions
  powerpc: rewrite local_t using soft_irq

 arch/powerpc/Kconfig                     |   4 +
 arch/powerpc/include/asm/exception-64s.h |  99 +++++++++------
 arch/powerpc/include/asm/head-64.h       |  40 +++---
 arch/powerpc/include/asm/hw_irq.h        | 120 ++++++++++++++++--
 arch/powerpc/include/asm/irqflags.h      |   8 +-
 arch/powerpc/include/asm/kvm_ppc.h       |   2 +-
 arch/powerpc/include/asm/local.h         | 201 +++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/paca.h          |   2 +-
 arch/powerpc/kernel/asm-offsets.c        |   2 +-
 arch/powerpc/kernel/entry_64.S           |  28 +++--
 arch/powerpc/kernel/exceptions-64e.S     |  10 +-
 arch/powerpc/kernel/exceptions-64s.S     |  38 +++---
 arch/powerpc/kernel/head_64.S            |   5 +-
 arch/powerpc/kernel/idle_book3e.S        |   3 +-
 arch/powerpc/kernel/idle_power4.S        |   3 +-
 arch/powerpc/kernel/irq.c                |  47 ++++++--
 arch/powerpc/kernel/process.c            |   3 +-
 arch/powerpc/kernel/ptrace.c             |  10 ++
 arch/powerpc/kernel/setup_64.c           |   5 +-
 arch/powerpc/kernel/signal_32.c          |   8 ++
 arch/powerpc/kernel/signal_64.c          |   3 +
 arch/powerpc/kernel/time.c               |   6 +-
 arch/powerpc/mm/hugetlbpage.c            |   2 +-
 arch/powerpc/perf/core-book3s.c          |   2 +-
 arch/powerpc/xmon/xmon.c                 |   4 +-
 25 files changed, 521 insertions(+), 134 deletions(-)

-- 
2.7.4
