Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcGct2SF3zDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 21:44:30 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v26AT08g088703
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 05:44:19 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28ys1sacpc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Mar 2017 05:44:19 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 6 Mar 2017 20:44:16 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 453272CE802D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 21:44:14 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v26Ai6E444367998
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 21:44:14 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v26AhemI029952
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 21:43:40 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v2 0/6] powerpc/perf: Export memory hierarchy level
Date: Mon,  6 Mar 2017 16:13:07 +0530
Message-Id: <1488796993-25495-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Power8/Power9 Perforence Monitoring Unit (PMU) supports
different sampling modes (SM) such as Random Instruction
Sampling (RIS), Random Load/Store Facility Sampling (RLS)
and Random Branch Sampling (RBS). Sample mode RLS updates
Sampled Instruction Event Register [SIER] bits with memory
hierarchy information for a cache reload. Patchset exports
the hierarchy information to the user via the perf_mem_data_src
object from SIER.

Patchset is a rebase of the work posted previously with minor
updates to it.

https://lkml.org/lkml/2015/6/11/92

Changelog v1:
- Fixed author-ship for the first patch and added suka's "Signed-off-by:".

Madhavan Srinivasan (5):
  powerpc/perf: Export memory hierarchy info to user space
  powerpc/perf: Support to export MMCRA[TEC*] field to userspace
  powerpc/perf: Support to export SIERs bit in Power8
  powerpc/perf: Support to export SIERs bit in Power9
  powerpc/perf: Add Power8 mem_access event to sysfs

Sukadev Bhattiprolu (1):
  powerpc/perf: Define big-endian version of perf_mem_data_src

 arch/powerpc/include/asm/perf_event_server.h |  3 +
 arch/powerpc/perf/core-book3s.c              |  8 +++
 arch/powerpc/perf/isa207-common.c            | 86 ++++++++++++++++++++++++++++
 arch/powerpc/perf/isa207-common.h            | 26 ++++++++-
 arch/powerpc/perf/power8-events-list.h       |  6 ++
 arch/powerpc/perf/power8-pmu.c               |  4 ++
 arch/powerpc/perf/power9-pmu.c               |  2 +
 include/uapi/linux/perf_event.h              | 16 ++++++
 tools/include/uapi/linux/perf_event.h        | 16 ++++++
 9 files changed, 166 insertions(+), 1 deletion(-)

-- 
2.7.4
