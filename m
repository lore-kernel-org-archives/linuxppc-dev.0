Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sG3355LMdzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 23:00:01 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7JCxGl7050031
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 08:59:59 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24wwebdypt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 08:59:59 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Fri, 19 Aug 2016 22:59:57 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0AE433578053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 22:59:54 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7JCxsF516777282
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 22:59:54 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7JCxpMe018114
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 22:59:53 +1000
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com,
 treeze.taeung@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
 markus@trippelsdorf.de, chris.ryder@arm.com, pawel.moll@arm.com,
 mhiramat@kernel.org, rmk+kernel@arm.linux.org.uk, jolsa@kernel.org,
 mpe@ellerman.id.au, hemant@linux.vnet.ibm.com, namhyung@kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v6 0/7] perf: Cross arch annotate + few miscellaneous fixes
Date: Fri, 19 Aug 2016 18:29:31 +0530
Message-Id: <1471611578-11255-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently Perf annotate support code navigation (branches and calls)
only when run on the same architecture where perf.data was recorded.
But, for example, record on powerpc server and annotate on client's
x86 desktop is not supported.

This patchset enables cross arch annotate. Currently I've used x86
and arm instructions which are already available and added support
for powerpc.

Additionally this patch series also contains few other related fixes.

Patches are prepared on top of acme/perf/core and tested it with x86
and powerpc only.

Note for arm:
I don't have arm test machine. As suggested by Russell in one of the
review comment, I've copied all instructions from default table to
arm table. This way it want break tool on arm but cleanup is needed
for x86 specific instructions added in arm table.

Example:

  Record on powerpc:
  $ ./perf record -a

  Report -> Annotate on x86:
  $ ./perf report -i perf.data.powerpc --vmlinux vmlinux.powerpc

Changes in v6:
  - Instead of adding only those instructions defined in #ifdef __arm__,
    add all instructions from default table to arm table.

v5 link:
  https://lkml.org/lkml/2016/8/19/35

Naveen N. Rao (1):
  perf annotate: Add support for powerpc

Ravi Bangoria (6):
  perf: Define macro for normalized arch names
  perf annotate: Add cross arch annotate support
  perf annotate: Do not ignore call instruction with indirect target
  perf annotate: Show raw form for jump instruction with indirect target
  perf annotate: Support jump instruction with target as second operand
  perf annotate: Fix jump target outside of function address range

 tools/perf/arch/common.c           |  36 ++--
 tools/perf/arch/common.h           |  11 ++
 tools/perf/builtin-top.c           |   2 +-
 tools/perf/ui/browsers/annotate.c  |   8 +-
 tools/perf/ui/gtk/annotate.c       |   2 +-
 tools/perf/util/annotate.c         | 330 +++++++++++++++++++++++++++++++------
 tools/perf/util/annotate.h         |  10 +-
 tools/perf/util/unwind-libunwind.c |   4 +-
 8 files changed, 327 insertions(+), 76 deletions(-)

-- 
2.5.5
