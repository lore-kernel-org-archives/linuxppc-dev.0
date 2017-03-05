Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vbdGw4Bv7zDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Mar 2017 20:41:44 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v259cUtG144729
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Mar 2017 04:41:33 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 290bhkpxdu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Mar 2017 04:41:32 -0500
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sun, 5 Mar 2017 15:11:30 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id B4AC8E0040
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Mar 2017 15:13:15 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v259fRgO7929864
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Mar 2017 15:11:27 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v259fQZv014527
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Mar 2017 15:11:27 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 0/6] powerpc/perf: Export memory hierarchy level
Date: Sun,  5 Mar 2017 15:11:11 +0530
Message-Id: <1488706877-28604-1-git-send-email-maddy@linux.vnet.ibm.com>
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

Madhavan Srinivasan (6):
  powerpc/perf: Define big-endian version of perf_mem_data_src
  powerpc/perf: Export memory hierarchy info to user space
  powerpc/perf: Support to export MMCRA[TEC*] field to userspace
  powerpc/perf: Support to export SIERs bit in Power8
  powerpc/perf: Support to export SIERs bit in Power9
  powerpc/perf: Add Power8 mem_access event to sysfs

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
