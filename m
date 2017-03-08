Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdRTb06BczDqYR
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 19:27:14 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2889EFx007150
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Mar 2017 03:27:12 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 292cb9vut8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Mar 2017 03:27:11 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 8 Mar 2017 18:27:09 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v288QvkZ48955434
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Mar 2017 19:27:05 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v288QXA4007756
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Mar 2017 19:26:33 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v5 0/5] kretprobe fixes
Date: Wed,  8 Mar 2017 13:56:05 +0530
Message-Id: <cover.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that I've been carried back in (ugh!), please find the remaining
patches from the earlier series (*) here. Patches 1-4 are the same as in
v4. Patch 5 in the previous series was dropped and the previous patch 6
has been updated accordingly.

- Naveen

(*) https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1347013.html

--
Naveen N. Rao (5):
  trace/kprobes: fix check for kretprobe offset within function entry
  powerpc: kretprobes: override default function entry offset
  perf: probe: factor out the ftrace README scanning
  perf: kretprobes: offset from reloc_sym if kernel supports it
  perf: powerpc: choose local entry point with kretprobes

 arch/powerpc/kernel/kprobes.c               |  9 ++++
 include/linux/kprobes.h                     |  1 +
 kernel/kprobes.c                            | 40 +++++++++------
 kernel/trace/trace_kprobe.c                 |  2 +-
 tools/perf/arch/powerpc/util/sym-handling.c | 14 ++++--
 tools/perf/util/probe-event.c               | 12 ++---
 tools/perf/util/probe-file.c                | 77 ++++++++++++++++-------------
 tools/perf/util/probe-file.h                |  1 +
 8 files changed, 97 insertions(+), 59 deletions(-)

-- 
2.11.1
