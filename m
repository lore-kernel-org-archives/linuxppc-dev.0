Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rf3gK3CgqzDqnx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 21:37:01 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5SBTBYD090163
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 07:36:58 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23sp3j4dfb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 07:36:58 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Tue, 28 Jun 2016 21:36:55 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8FEE03578056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 21:36:53 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5SBarJh4456706
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 21:36:53 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5SBaqZe002823
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 21:36:53 +1000
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, acme@kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: anton@ozlabs.org, mpe@ellerman.id.au, ananth@in.ibm.com, dja@axtens.net,
 naveen.n.rao@linux.vnet.ibm.com,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH 0/4] perf annotate: Enable cross arch annotate
Date: Tue, 28 Jun 2016 17:06:43 +0530
Message-Id: <1467113807-29571-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
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

Changes in [PATCH] vs [RFC]
  - Removed global var 'arch__ins' and pass arch info till ins__find

Naveen N. Rao (1):
  perf annotate: add powerpc support

Ravi Bangoria (3):
  perf: Utility function to fetch arch
  perf annotate: Enable cross arch annotate
  perf annotate: Define macro for arch names

 tools/perf/arch/common.c           |  36 +++----
 tools/perf/arch/common.h           |  11 +++
 tools/perf/builtin-top.c           |   2 +-
 tools/perf/ui/browsers/annotate.c  |   3 +-
 tools/perf/ui/gtk/annotate.c       |   2 +-
 tools/perf/util/annotate.c         | 198 ++++++++++++++++++++++++++++---------
 tools/perf/util/annotate.h         |   5 +-
 tools/perf/util/evsel.c            |   7 ++
 tools/perf/util/evsel.h            |   2 +
 tools/perf/util/unwind-libunwind.c |   4 +-
 10 files changed, 198 insertions(+), 72 deletions(-)

--
2.5.5
