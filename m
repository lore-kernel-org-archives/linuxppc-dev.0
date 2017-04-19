Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7MM522D9zDqB9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 22:51:29 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3JCnYl6122915
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 08:51:22 -0400
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29wqpvp56b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 08:51:21 -0400
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 19 Apr 2017 18:21:18 +0530
Received: from d28av07.in.ibm.com (d28av07.in.ibm.com [9.184.220.146])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3JCpGHE12517476
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 18:21:16 +0530
Received: from d28av07.in.ibm.com (localhost [127.0.0.1])
 by d28av07.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3JCpFbP026728
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 18:21:16 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] powerpc: a few kprobe fixes and refactoring
Date: Wed, 19 Apr 2017 18:20:59 +0530
Message-Id: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v2:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1375870.html

v3 changes:
- Patch 3/5 in the previous series ("powerpc: introduce a new helper to
  obtain function entry points") has been dropped from this series and
  will instead be posted as part of the KPROBES_ON_FTRACE patchset.
- Patch 5/5 in the previous series ("powerpc: kprobes: emulate
  instructions on kprobe handler re-entry") has been split into two
  patches as recommended by Masami. They represent patches 6/7 and 7/7
  in this series.
- Patches 3/7 and 4/7 are new in this series to address review comments
  from David Laight.


- Naveen


Naveen N. Rao (7):
  kprobes: convert kprobe_lookup_name() to a function
  powerpc: kprobes: fix handling of function offsets on ABIv2
  kprobes: validate the symbol name length
  powerpc: kprobes: use safer string functions in kprobe_lookup_name()
  powerpc: kprobes: factor out code to emulate instruction into a helper
  powerpc: kprobes: emulate instructions on kprobe handler re-entry
  powerpc: kprobes: remove duplicate saving of msr

 arch/powerpc/include/asm/kprobes.h |  53 -----------------
 arch/powerpc/kernel/kprobes.c      | 118 ++++++++++++++++++++++++++++++-------
 arch/powerpc/kernel/optprobes.c    |   4 +-
 include/linux/kprobes.h            |   2 +
 kernel/kprobes.c                   |  45 ++++++++++----
 kernel/trace/trace_kprobe.c        |   4 ++
 6 files changed, 137 insertions(+), 89 deletions(-)

-- 
2.12.1
