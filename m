Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w295Q4jFRzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 11:51:38 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3B1mgQ2092861
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 21:51:30 -0400
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29rm8x3fgb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 21:51:29 -0400
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 11 Apr 2017 07:21:26 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3B1pOnm16842770
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 07:21:24 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3B1pLqF029645
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 07:21:23 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, sukadev@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, alexander.shishkin@linux.intel.com,
 wangnan0@huawei.com, ast@kernel.org, eranian@google.com,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v3 0/6] powerpc/perf: Export memory hierarchy level
Date: Tue, 11 Apr 2017 07:21:04 +0530
Message-Id: <1491875470-17904-1-git-send-email-maddy@linux.vnet.ibm.com>
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

Changelog v3:
-Removed is_load_store() and merged the same to get_memdata_src callback
-Added a check to update OP_LOAD or OP_STORE in data_src->val

Changelog v2:
-Updated the commit messages
-Fixed isa207_find_source() to consider all the possible sier[ldst] values.

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
 arch/powerpc/perf/isa207-common.c            | 82 ++++++++++++++++++++++++++++
 arch/powerpc/perf/isa207-common.h            | 26 ++++++++-
 arch/powerpc/perf/power8-events-list.h       |  6 ++
 arch/powerpc/perf/power8-pmu.c               |  4 ++
 arch/powerpc/perf/power9-pmu.c               |  2 +
 include/uapi/linux/perf_event.h              | 16 ++++++
 tools/include/uapi/linux/perf_event.h        | 16 ++++++
 9 files changed, 162 insertions(+), 1 deletion(-)

-- 
2.7.4
