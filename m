Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w31Zp1vgMzDqQH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:16:34 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3CBDh6j056090
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 07:16:32 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29sgmj7nk3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 07:16:32 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 12 Apr 2017 21:15:24 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3CBFEZU26738778
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:15:22 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3CBEjXu031839
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:14:46 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 0/2] powerpc: split ftrace bits into a separate
Date: Wed, 12 Apr 2017 16:44:24 +0530
Message-Id: <cover.1491995484.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v3:
https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg114669.html

For v4, this has been rebased on top of powerpc/next as well as the
KPROBES_ON_FTRACE series. No other changes.

- Naveen

Naveen N. Rao (2):
  powerpc: split ftrace bits into a separate file
  powerpc: ftrace_64: split further based on -mprofile-kernel

 arch/powerpc/kernel/Makefile                   |   9 +-
 arch/powerpc/kernel/entry_32.S                 | 107 -------
 arch/powerpc/kernel/entry_64.S                 | 379 -------------------------
 arch/powerpc/kernel/trace/Makefile             |  29 ++
 arch/powerpc/kernel/{ => trace}/ftrace.c       |   0
 arch/powerpc/kernel/trace/ftrace_32.S          | 118 ++++++++
 arch/powerpc/kernel/trace/ftrace_64.S          |  85 ++++++
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 272 ++++++++++++++++++
 arch/powerpc/kernel/trace/ftrace_64_pg.S       |  69 +++++
 arch/powerpc/kernel/{ => trace}/trace_clock.c  |   0
 10 files changed, 574 insertions(+), 494 deletions(-)
 create mode 100644 arch/powerpc/kernel/trace/Makefile
 rename arch/powerpc/kernel/{ => trace}/ftrace.c (100%)
 create mode 100644 arch/powerpc/kernel/trace/ftrace_32.S
 create mode 100644 arch/powerpc/kernel/trace/ftrace_64.S
 create mode 100644 arch/powerpc/kernel/trace/ftrace_64_mprofile.S
 create mode 100644 arch/powerpc/kernel/trace/ftrace_64_pg.S
 rename arch/powerpc/kernel/{ => trace}/trace_clock.c (100%)

-- 
2.12.1
