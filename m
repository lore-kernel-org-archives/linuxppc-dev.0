Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJMhK1MDDzDqCf
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 14:37:37 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v444XtA9088411
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 00:37:24 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a7ux4k96h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 00:37:24 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 4 May 2017 14:37:21 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v444bACH1311160
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 14:37:18 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v444ajHh008694
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 14:36:46 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/8] powerpc: Various fixes and enhancements for kprobes and
 ftrace
Date: Thu,  4 May 2017 10:06:13 +0530
Message-Id: <cover.1493831558.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Reposting this as I missed copying the distribution list in my
previous posting. For those who were copied previously, sorry for the spam]

This series initially started out as a fix for a single bug I found:
kernel Oops when jprobes is used with the function_graph tracer. Though
that particular bug turned out to be a solved problem on other
architectures (as seen in patch 1), my investigation revealed quite a
few other bugs as well as scope for optimizing our ftrace handlers.

This series includes all the fixes and enhancements I have made so far.
There are a few more bugs and fixes that I will be coding up and sending
across in a day or two.

This series has been run through ftrace selftests.

- Naveen

Naveen N. Rao (8):
  powerpc/kprobes: Pause function_graph tracing during jprobes handling
  powerpc/ftrace: Pass the correct stack pointer for
    DYNAMIC_FTRACE_WITH_REGS
  powerpc/ftrace: Remove redundant saving of LR in ftrace[_graph]_caller
  powerpc/kprobes_on_ftrace: Skip livepatch_handler() for jprobes
  powerpc/ftrace: Eliminate duplicate stack setup for
    ftrace_graph_caller()
  powerpc/ftrace: Add support for HAVE_FUNCTION_GRAPH_FP_TEST for
    -mprofile-kernel
  powerpc/livepatch: Clarify location of mcount call site
  powerpc/xmon: Disable function_graph tracing while in xmon

 arch/powerpc/include/asm/asm-prototypes.h      |   3 +-
 arch/powerpc/include/asm/ftrace.h              |   3 +
 arch/powerpc/include/asm/livepatch.h           |   4 +-
 arch/powerpc/kernel/kprobes.c                  |  15 +++-
 arch/powerpc/kernel/trace/ftrace.c             |   4 +-
 arch/powerpc/kernel/trace/ftrace_64.S          |   1 +
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 105 +++++++++++--------------
 arch/powerpc/xmon/xmon.c                       |   3 +
 8 files changed, 70 insertions(+), 68 deletions(-)

-- 
2.12.2
