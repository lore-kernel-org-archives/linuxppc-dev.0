Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7MNp1ny6zDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 22:52:58 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3JCnDWs012569
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 08:52:46 -0400
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29x0wyau3w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 08:52:46 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 19 Apr 2017 18:22:41 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3JCqcG715925436
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 18:22:38 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3JCqb2i020169
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 18:22:38 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] powerpc: add support for KPROBES_ON_FTRACE
Date: Wed, 19 Apr 2017 18:22:22 +0530
Message-Id: <cover.1492605029.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v3:
https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg116800.html

For v4, patch 5/6 is new and has been moved into this series. It has
also been updated to use strlcat() instead of strncat(). No other
changes.

Also, though patch 3/6 is generic, it needs to be carried in this
series as we crash on powerpc without that patch.


- Naveen


Masami Hiramatsu (1):
  kprobes: Skip preparing optprobe if the probe is ftrace-based

Naveen N. Rao (5):
  powerpc: ftrace: minor cleanup
  powerpc: ftrace: restore LR from pt_regs
  powerpc: kprobes: add support for KPROBES_ON_FTRACE
  powerpc: introduce a new helper to obtain function entry points
  powerpc: kprobes: prefer ftrace when probing function entry

 .../debug/kprobes-on-ftrace/arch-support.txt       |   2 +-
 arch/powerpc/Kconfig                               |   1 +
 arch/powerpc/include/asm/code-patching.h           |  37 ++++++++
 arch/powerpc/include/asm/kprobes.h                 |  10 ++
 arch/powerpc/kernel/Makefile                       |   3 +
 arch/powerpc/kernel/entry_64.S                     |  19 ++--
 arch/powerpc/kernel/kprobes-ftrace.c               | 104 +++++++++++++++++++++
 arch/powerpc/kernel/kprobes.c                      |  25 ++++-
 arch/powerpc/kernel/optprobes.c                    |   6 +-
 kernel/kprobes.c                                   |  11 ++-
 10 files changed, 199 insertions(+), 19 deletions(-)
 create mode 100644 arch/powerpc/kernel/kprobes-ftrace.c

-- 
2.12.1
