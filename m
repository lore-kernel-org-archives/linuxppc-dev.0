Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rm1y65WxFzDr5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 14:40:30 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u684dqmH123593
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jul 2016 00:40:28 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2415xnpdus-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Jul 2016 00:40:27 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Fri, 8 Jul 2016 14:40:25 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3E4342CE805D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 14:40:23 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u684eN2P6423016
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jul 2016 14:40:23 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u684eMHt010368
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jul 2016 14:40:23 +1000
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, acme@kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: anton@ozlabs.org, mpe@ellerman.id.au, ananth@in.ibm.com, dja@axtens.net,
 naveen.n.rao@linux.vnet.ibm.com, ravi.bangoria@linux.vnet.ibm.com,
 David.Laight@ACULAB.COM, rmk+kernel@arm.linux.org.uk
Subject: [PATCH v4 0/3] perf annotate: Enable cross arch annotate
Date: Fri,  8 Jul 2016 10:10:10 +0530
Message-Id: <1467952813-5797-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Perf can currently only support code navigation (branches and calls) in
annotate when run on the same architecture where perf.data was recorded.
But cross arch annotate is not supported.

This patchset enables cross arch annotate. Currently I've used x86
and arm instructions which are already available and adding support
for powerpc as well. Adding support for other arch will be easy.

I've created this patch on top of acme/perf/core. And tested it with
x86 and powerpc only.

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

Changes in v4:
  - powerpc: Added support for branch instructions that includes 'ctr'
  - __maybe_unused was misplaced at few location. Corrected it.
  - Moved position of v3 last patch that define macro for each arch name

v3 link: https://lkml.org/lkml/2016/6/30/99

Naveen N. Rao (1):
  perf annotate: add powerpc support

Ravi Bangoria (2):
  perf: Define macro for normalized arch names
  perf annotate: Enable cross arch annotate

 tools/perf/arch/common.c           |  36 ++---
 tools/perf/arch/common.h           |  11 ++
 tools/perf/builtin-top.c           |   2 +-
 tools/perf/ui/browsers/annotate.c  |   3 +-
 tools/perf/ui/gtk/annotate.c       |   2 +-
 tools/perf/util/annotate.c         | 273 ++++++++++++++++++++++++++++++-------
 tools/perf/util/annotate.h         |   6 +-
 tools/perf/util/unwind-libunwind.c |   4 +-
 8 files changed, 265 insertions(+), 72 deletions(-)

--
2.5.5
