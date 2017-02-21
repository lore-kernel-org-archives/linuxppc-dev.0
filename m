Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSVH263KhzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 06:02:06 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1LIhUhr038983
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 14:02:02 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28rp4pfmxk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 14:02:02 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 22 Feb 2017 05:01:59 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B447C2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 06:01:56 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1LJ1mkj22675710
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 06:01:56 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1LJ1OJD010764
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 06:01:24 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 0/2] powerpc: split ftrace bits into separate files
Date: Wed, 22 Feb 2017 00:31:00 +0530
Message-Id: <cover.1487702678.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v2: https://patchwork.ozlabs.org/patch/697787/

Michael,
Sorry this took as long as it did, but here's a take at v3. This series
conflicts with the KPROBES_ON_FTRACE patchset, but I'm posting this so
as to get feedback. I will rework these patches as needed.

Thanks,
Naveen

Naveen N. Rao (2):
  powerpc: split ftrace bits into a separate file
  powerpc: ftrace_64: split further based on -mprofile-kernel

 arch/powerpc/kernel/Makefile                   |   9 +-
 arch/powerpc/kernel/entry_32.S                 | 107 -------
 arch/powerpc/kernel/entry_64.S                 | 380 -------------------------
 arch/powerpc/kernel/trace/Makefile             |  29 ++
 arch/powerpc/kernel/{ => trace}/ftrace.c       |   0
 arch/powerpc/kernel/trace/ftrace_32.S          | 118 ++++++++
 arch/powerpc/kernel/trace/ftrace_64.S          |  85 ++++++
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 274 ++++++++++++++++++
 arch/powerpc/kernel/trace/ftrace_64_pg.S       |  68 +++++
 arch/powerpc/kernel/{ => trace}/trace_clock.c  |   0
 10 files changed, 575 insertions(+), 495 deletions(-)
 create mode 100644 arch/powerpc/kernel/trace/Makefile
 rename arch/powerpc/kernel/{ => trace}/ftrace.c (100%)
 create mode 100644 arch/powerpc/kernel/trace/ftrace_32.S
 create mode 100644 arch/powerpc/kernel/trace/ftrace_64.S
 create mode 100644 arch/powerpc/kernel/trace/ftrace_64_mprofile.S
 create mode 100644 arch/powerpc/kernel/trace/ftrace_64_pg.S
 rename arch/powerpc/kernel/{ => trace}/trace_clock.c (100%)

-- 
2.11.0
