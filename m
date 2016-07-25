Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rykkg5rYjzDrFJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:52:43 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6PEn49L009832
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:52:41 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24c1h4dxw3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:52:40 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 26 Jul 2016 00:52:38 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AA6622BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:52:31 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6PEqV4627459612
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:52:31 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6PEqV09012108
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:52:31 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [RFC PATCH 0/9]powerpc: "paca->soft_enabled" based local atomic
 operation implementation
Date: Mon, 25 Jul 2016 20:22:13 +0530
Message-Id: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
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
the rewind addressr, this rasied concerns about size of __ex_table and vmlinux.

https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-December/123115.html

But this patchset uses Benjamin Herrenschmidt suggestion of using
arch_local_irq_disable_var() to soft_disable interrupts (including PMIs).
After finishing the "op", arch_local_irq_restore() called and correspondingly
interrupts are replayed if any occured.

patch re-write the current local_* functions to use arch_local_irq_disbale.
Base flow for each function is

 {
        arch_local_irq_disable_var(2)
        load
        ..
        store
        arch_local_irq_restore()
 }

Currently only asm/local.h has been rewrite, and also
the entire change is tested only in PPC64 (pseries guest)

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

First four are the clean up patches which lays the foundation
to make things easier. Fifth patch in the patchset reverse the
current soft_enabled logic and commit message details the reason and
need for this change. Sixth patch holds the changes needed
for reversing logic. Rest of the patches are to add support
for maskable PMI and implementation of local_t using arch_local_disable_*().

Since the patchset is experimental, changes made are focused on pseries and
powernv platforms only. Would really like to know comments for
this approach before extending to other powerpc platforms.

Tested the patchset in a
 - pSeries LPAR (with perf record).
	- Ran kernbench with perf record for 24 hours.
	- More testing needed.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Madhavan Srinivasan (9):
  Add #defs for paca->soft_enabled flags
  Cleanup to use LAZY_INTERRUPT_* macros for paca->soft_enabled update
  powerpc: move set_soft_enabled()
  powerpc: Use set_soft_enabled api to update paca->soft_enabled
  powerpc: reverse the soft_enable logic
  powerpc: modify __SOFTEN_TEST to support tri-state soft_enabled flag
  powerpc: Add support to mask perf interrupts
  powerpc: Support to replay PMIs
  powerpc: rewrite local_t using soft_irq

 arch/powerpc/include/asm/exception-64s.h | 24 +++++++--
 arch/powerpc/include/asm/hw_irq.h        | 43 ++++++++++++---
 arch/powerpc/include/asm/irqflags.h      |  8 +--
 arch/powerpc/include/asm/kvm_ppc.h       |  2 +-
 arch/powerpc/include/asm/local.h         | 91 ++++++++++++++++++++++----------
 arch/powerpc/kernel/entry_64.S           | 16 +++---
 arch/powerpc/kernel/exceptions-64s.S     | 27 ++++++++--
 arch/powerpc/kernel/head_64.S            |  3 +-
 arch/powerpc/kernel/idle_power4.S        |  3 +-
 arch/powerpc/kernel/irq.c                | 24 +++++----
 arch/powerpc/kernel/process.c            |  3 +-
 arch/powerpc/kernel/setup_64.c           |  4 ++
 arch/powerpc/kernel/time.c               |  4 +-
 arch/powerpc/mm/hugetlbpage.c            |  2 +-
 arch/powerpc/perf/core-book3s.c          |  2 +-
 15 files changed, 184 insertions(+), 72 deletions(-)

--
2.7.4
