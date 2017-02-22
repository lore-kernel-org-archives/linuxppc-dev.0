Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSzP51TQ0zDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 00:54:00 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1MDnCpa138026
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 08:53:58 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28s9xgdxgf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 08:53:58 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 22 Feb 2017 19:23:55 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id D4DBC3940062
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:23:53 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1MDqopI15138944
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:22:50 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1MDrqHm024495
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:23:53 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/5] kretprobe fixes
Date: Wed, 22 Feb 2017 19:23:36 +0530
Message-Id: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm including all patches (generic and powerpc changes) in
this series as suggested by Masami.

v1 patches:
https://marc.info/?l=linux-kernel&m=148718276424380
https://marc.info/?l=linux-kernel&m=148723314105453&w=2

Patches 1 and 2 are the same as v1.
Patch 3 is updated to include a line in ftrace README.
Patch 4 is new.
Patch 5 is updated to consider ftrace README.


Thanks,
Naveen

Naveen N. Rao (5):
  kretprobes: ensure probe location is at function entry
  powerpc: kretprobes: override default function entry offset
  trace/kprobes: allow return probes with offsets and absolute addresses
  perf: kretprobes: offset from reloc_sym if kernel supports it
  perf: powerpc: choose local entry point with kretprobes

 arch/powerpc/kernel/kprobes.c               |  9 ++++++
 include/linux/kprobes.h                     |  1 +
 kernel/kprobes.c                            | 13 ++++++++
 kernel/trace/trace.c                        |  1 +
 kernel/trace/trace_kprobe.c                 |  8 -----
 tools/perf/arch/powerpc/util/sym-handling.c |  9 +++---
 tools/perf/util/probe-event.c               | 47 ++++++++++++++++++++++++-----
 tools/perf/util/probe-event.h               |  2 ++
 8 files changed, 71 insertions(+), 19 deletions(-)

-- 
2.11.0
