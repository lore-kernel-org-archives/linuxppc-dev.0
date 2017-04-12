Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w31S91HmqzDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:10:49 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3CB3ohx139817
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 07:10:34 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29scj8rcac-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 07:10:34 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 12 Apr 2017 21:10:30 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3CBAKIu21692666
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:10:28 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3CB9sHS001226
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:09:55 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] powerpc: add support for KPROBES_ON_FTRACE
Date: Wed, 12 Apr 2017 16:39:21 +0530
Message-Id: <cover.1491994965.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v2:
https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg114659.html

For v3, this has only been rebased on top of powerpc/next and carries a
minor change to patch 4/5. No other changes.

Also, though patch 3/5 is generic, it needs to be carried in this
series as we crash on powerpc without that patch.


- Naveen


Masami Hiramatsu (1):
  kprobes: Skip preparing optprobe if the probe is ftrace-based

Naveen N. Rao (4):
  powerpc: ftrace: minor cleanup
  powerpc: ftrace: restore LR from pt_regs
  powerpc: kprobes: add support for KPROBES_ON_FTRACE
  powerpc: kprobes: prefer ftrace when probing function entry

 .../debug/kprobes-on-ftrace/arch-support.txt       |   2 +-
 arch/powerpc/Kconfig                               |   1 +
 arch/powerpc/include/asm/kprobes.h                 |  10 ++
 arch/powerpc/kernel/Makefile                       |   3 +
 arch/powerpc/kernel/entry_64.S                     |  19 ++--
 arch/powerpc/kernel/kprobes-ftrace.c               | 104 +++++++++++++++++++++
 arch/powerpc/kernel/kprobes.c                      |  25 ++++-
 kernel/kprobes.c                                   |  11 ++-
 8 files changed, 159 insertions(+), 16 deletions(-)
 create mode 100644 arch/powerpc/kernel/kprobes-ftrace.c

-- 
2.12.1
