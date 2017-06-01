Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdkcX5QdlzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jun 2017 20:49:32 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v51AmghF007669
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 06:49:27 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2atfv7n476-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Jun 2017 06:49:27 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 1 Jun 2017 20:49:24 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v51AnE1o57999422
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 20:49:22 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v51Amnuu026779
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 20:48:50 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/4] ftrace/kprobe fixes
Date: Thu,  1 Jun 2017 16:18:14 +0530
Message-Id: <cover.1496309487.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is v2 of some of the patches from:
https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg117777.html

The first two patches should probably go to -stable. The others can go
into v4.12.

Thanks,
Naveen

Naveen N. Rao (4):
  powerpc/kprobes: Pause function_graph tracing during jprobes handling
  powerpc/ftrace: Pass the correct stack pointer for
    DYNAMIC_FTRACE_WITH_REGS
  powerpc/kprobes_on_ftrace: Skip livepatch_handler() for jprobes
  powerpc/xmon: Disable ftrace while in xmon

 arch/powerpc/include/asm/kprobes.h             |  1 +
 arch/powerpc/kernel/kprobes.c                  | 17 +++++++++
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 52 ++++++++++++++++++++------
 arch/powerpc/xmon/xmon.c                       |  5 +++
 4 files changed, 63 insertions(+), 12 deletions(-)

-- 
2.12.2
