Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xz74M6s9SzDqjC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 19:10:43 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8M998JG128326
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 05:10:41 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2d4wt25drb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 05:10:40 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 22 Sep 2017 19:10:37 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8M9AYCr37814402
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 19:10:34 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8M9AYdq020336
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 19:10:34 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/6] powerpc/kprobes: More fixes
Date: Fri, 22 Sep 2017 14:40:23 +0530
Message-Id: <cover.1505934128.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is v2 of the patches posted at:
http://lkml.kernel.org/r/2bc413d679c563d3ee338c318066777318577ab2.1505336870.git.naveen.n.rao@linux.vnet.ibm.com

Changes:
- No changes in patch 1, 4 and 5.
- Comment updated in patch 2, as suggested by Masami.
- Patch 3 has changes to explicitly call out detection of jprobe in 
  ftrace_caller() and that this is only for KPROBES_ON_FTRACE.

- Naveen

Naveen N. Rao (6):
  powerpc/kprobes: Some cosmetic updates to try_to_emulate()
  powerpc/kprobes: Do not suppress instruction emulation if a single run
    failed
  powerpc/kprobes: Clean up jprobe detection in livepatch handler
  powerpc/kprobes: Fix warnings from __this_cpu_read() on preempt
    kernels
  powerpc/jprobes: Disable preemption when triggered through ftrace
  powerpc/jprobes: Validate break handler invocation as being due to a
    jprobe_return()

 arch/powerpc/include/asm/kprobes.h             |  2 +-
 arch/powerpc/kernel/kprobes-ftrace.c           | 30 ++++++++++++++---
 arch/powerpc/kernel/kprobes.c                  | 45 ++++++++++++++------------
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |  4 +--
 4 files changed, 53 insertions(+), 28 deletions(-)

-- 
2.14.1
