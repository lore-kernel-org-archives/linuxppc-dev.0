Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rg8QP4dF1zDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 16:14:36 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5U6ECM9010916
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 02:14:35 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23usub94q5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 02:14:34 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Thu, 30 Jun 2016 16:14:31 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 528552CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 16:14:29 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5U6ET9C11272648
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 16:14:29 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5U6ESsX022240
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 16:14:29 +1000
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, acme@kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: anton@ozlabs.org, mpe@ellerman.id.au, ananth@in.ibm.com, dja@axtens.net,
 naveen.n.rao@linux.vnet.ibm.com, ravi.bangoria@linux.vnet.ibm.com,
 David.Laight@ACULAB.COM
Subject: [PATCH v3 0/4]  perf annotate: Enable cross arch annotate
Date: Thu, 30 Jun 2016 11:44:18 +0530
Message-Id: <1467267262-4589-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
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

Example:

  Record on powerpc:
  $ ./perf record -a

  Report -> Annotate on x86:
  $ ./perf report -i perf.data.powerpc --vmlinux vmlinux.powerpc

Changes in v3:
  - Optimized patch that enables annotate on powerpc
  - Corrected one memory leak

v2 link: https://lkml.org/lkml/2016/6/29/278

Naveen N. Rao (1):
  perf annotate: add powerpc support

Ravi Bangoria (4):
  perf: Utility function to fetch arch
  perf annotate: Enable cross arch annotate
  perf: Define macro for normalized arch names

 tools/perf/arch/common.c           |  36 ++---
 tools/perf/arch/common.h           |  11 ++
 tools/perf/builtin-top.c           |   2 +-
 tools/perf/ui/browsers/annotate.c  |   3 +-
 tools/perf/ui/gtk/annotate.c       |   2 +-
 tools/perf/util/annotate.c         | 260 ++++++++++++++++++++++++++++++-------
 tools/perf/util/annotate.h         |   5 +-
 tools/perf/util/evsel.c            |   7 +
 tools/perf/util/evsel.h            |   2 +
 tools/perf/util/unwind-libunwind.c |   4 +-
 10 files changed, 260 insertions(+), 72 deletions(-)

--
2.5.5
