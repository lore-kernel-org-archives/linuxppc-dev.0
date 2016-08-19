Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFs3D45HjzDr5M
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 15:29:28 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7J5Sfoj079995
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 01:29:26 -0400
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24wqk501am-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 01:29:25 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Fri, 19 Aug 2016 10:59:22 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 633661258060
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 11:02:33 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7J5TI0d29819102
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 10:59:18 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7J5TAZ8000355
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 10:59:17 +0530
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com,
 treeze.taeung@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
 markus@trippelsdorf.de, chris.ryder@arm.com, pawel.moll@arm.com,
 mhiramat@kernel.org, rmk+kernel@arm.linux.org.uk, jolsa@kernel.org,
 mpe@ellerman.id.au, hemant@linux.vnet.ibm.com, namhyung@kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v5 0/7] perf: Cross arch annotate + few miscellaneous fixes
Date: Fri, 19 Aug 2016 10:58:59 +0530
Message-Id: <1471584546-11080-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
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
Few instructions were defined under #if __arm__ which I've used as a
table for arm. But I'm not sure whether instruction defined outside of
that also contains arm instructions. Apart from that, 'call__parse()'
and 'move__parse()' contains #ifdef __arm__ directive. I've changed it
to  if (!strcmp(norm_arch, arm)). I don't have a arm machine to test
these changes.

Example:

  Record on powerpc:
  $ ./perf record -a

  Report -> Annotate on x86:
  $ ./perf report -i perf.data.powerpc --vmlinux vmlinux.powerpc

Changes in v5:
  - Replaced symbol__annotate with symbol__disassemble.
  - Removed hacks for jump and call instructions like bctr and bctrl
    respectively from generic patch that enables support for powerpc
    and made separate patch for that.
  - v4 was not annotating powerpc 'btar' instruction. Included that.
  - Added few generic fixes.

v4 link:
  https://lkml.org/lkml/2016/7/8/10

Naveen N. Rao (1):
  perf annotate: Add support for powerpc

Ravi Bangoria (6):
  perf: Define macro for normalized arch names
  perf annotate: Add cross arch annotate support
  perf annotate: Do not ignore call instruction with indirect target
  perf annotate: Show raw form for jump instruction with indirect
    target
  perf annotate: Support jump instruction with target as second operand
  perf annotate: Fix jump target outside of function address range

 tools/perf/arch/common.c           |  36 ++---
 tools/perf/arch/common.h           |  11 ++
 tools/perf/builtin-top.c           |   2 +-
 tools/perf/ui/browsers/annotate.c  |   8 +-
 tools/perf/ui/gtk/annotate.c       |   2 +-
 tools/perf/util/annotate.c         | 276 +++++++++++++++++++++++++++++--------
 tools/perf/util/annotate.h         |  10 +-
 tools/perf/util/unwind-libunwind.c |   4 +-
 8 files changed, 262 insertions(+), 87 deletions(-)

-- 
2.5.5
