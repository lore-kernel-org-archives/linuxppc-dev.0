Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfPGF2TfJzDsgj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 01:50:12 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8LFmosK071675
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 11:50:10 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25khh97pg6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 11:50:09 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Thu, 22 Sep 2016 01:50:06 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8F0712BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 01:50:04 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8LFo40T63373538
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 01:50:04 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8LFo3mQ005984
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 01:50:04 +1000
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, acme@kernel.org, kim.phillips@arm.com
Cc: linuxppc-dev@lists.ozlabs.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, treeze.taeung@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, markus@trippelsdorf.de,
 namhyung@kernel.org, pawel.moll@arm.com, chris.ryder@arm.com,
 jolsa@kernel.org, mhiramat@kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v7 0/6] perf annotate: Cross arch support + few fixes
Date: Wed, 21 Sep 2016 21:17:50 +0530
Message-Id: <1474472876-2706-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
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

This patchset adds supports for that.

Example:

  Record on powerpc:
  $ ./perf record -a

  Report -> Annotate on x86:
  $ ./perf report -i perf.data.powerpc --vmlinux vmlinux.powerpc

Changes in v7:
  - Using string for normalized arch names instread of macros.(i.e.
    removed patch 1/7 of v6)
  - In patch 1/6, make norm_arch as global var instead of passing them
    to each parser.
  - In patch 1/6 and 6/6, little bit change in initializing instruction
    list.
  - patch 4/7 of v6 is already accepted. Removed that in v7.
  - Address other review comments.
  - Added more examples in patch descriptions.

v6 link:
  https://lkml.org/lkml/2016/8/19/411

Kim, I don't have arm test machine. Can you please help me to test
this on arm.


Kim Phillips (1):
  perf annotate: cross arch annotate support fixes for ARM

Naveen N. Rao (1):
  perf annotate: Add support for powerpc

Ravi Bangoria (4):
  perf annotate: Add cross arch annotate support
  perf annotate: Show raw form for jump instruction with indirect target
  perf annotate: Support jump instruction with target as second operand
  perf annotate: Fix jump target outside of function address range

 tools/perf/builtin-top.c          |   2 +-
 tools/perf/ui/browsers/annotate.c |   8 +-
 tools/perf/ui/gtk/annotate.c      |   2 +-
 tools/perf/util/annotate.c        | 259 ++++++++++++++++++++++++++++++++------
 tools/perf/util/annotate.h        |   8 +-
 5 files changed, 232 insertions(+), 47 deletions(-)

-- 
2.5.5
