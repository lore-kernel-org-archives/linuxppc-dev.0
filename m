Return-Path: <yao.jin@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7Dgg04ckzDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 17:50:22 +1000 (AEST)
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org,
 Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 0/7] perf report: Show branch type
Date: Wed, 19 Apr 2017 23:48:07 +0800
Message-Id: <1492616894-3635-1-git-send-email-yao.jin@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v5:
---
   Mainly the v5 patch series are updated according to
   comments from Jiri Olsa <jolsa@redhat.com>.

   The kernel part doesn't have functional change. It just
   solve the merge issue.

   In userspace, the functions of branch type counting and
   branch type name resolving are moved to the new files: 
   util/branch.c, util/branch.h.

   And refactor the branch info printing code for better
   maintenance.

Not changed (or just fix merge issue):
  perf/core: Define the common branch type classification
  perf/x86/intel: Record branch type
  perf record: Create a new option save_type in --branch-filter

New patches:
  perf report: Refactor the branch info printing code
  perf util: Create branch.c/.h for common branch functions

Changed:
  perf report: Show branch type statistics for stdio mode
  perf report: Show branch type in callchain entry

v4:
---
1. Describe the major changes in patch description.
   Thanks for Peter Zijlstra's reminding. 

2. Initialize branch type to 0 in intel_pmu_lbr_read_32 and
   intel_pmu_lbr_read_64. Remove the invalid else code in
   intel_pmu_lbr_filter. 

v3:
---
1. Move the JCC forward/backward and cross page computing from
   kernel to userspace.

2. Use lookup table to replace original switch/case processing.

Changed:
  perf/core: Define the common branch type classification
  perf/x86/intel: Record branch type
  perf report: Show branch type statistics for stdio mode
  perf report: Show branch type in callchain entry

Not changed:
  perf record: Create a new option save_type in --branch-filter

v2:
---
1. Use 4 bits in perf_branch_entry to record branch type.

2. Pull out some common branch types from FAR_BRANCH. Now the branch
   types defined in perf_event.h:

Jin Yao (7):
  perf/core: Define the common branch type classification
  perf/x86/intel: Record branch type
  perf record: Create a new option save_type in --branch-filter
  perf report: Refactor the branch info printing code
  perf util: Create branch.c/.h for common branch functions
  perf report: Show branch type statistics for stdio mode
  perf report: Show branch type in callchain entry

 arch/x86/events/intel/lbr.c              |  53 ++++++++-
 include/uapi/linux/perf_event.h          |  29 ++++-
 tools/include/uapi/linux/perf_event.h    |  29 ++++-
 tools/perf/Documentation/perf-record.txt |   1 +
 tools/perf/builtin-report.c              |  69 +++++++++++
 tools/perf/util/Build                    |   1 +
 tools/perf/util/branch.c                 |  63 ++++++++++
 tools/perf/util/branch.h                 |  23 ++++
 tools/perf/util/callchain.c              | 194 ++++++++++++++++++++-----------
 tools/perf/util/callchain.h              |   5 +-
 tools/perf/util/event.h                  |   3 +-
 tools/perf/util/hist.c                   |   5 +-
 tools/perf/util/machine.c                |  26 +++--
 tools/perf/util/parse-branch-options.c   |   1 +
 14 files changed, 415 insertions(+), 87 deletions(-)
 create mode 100644 tools/perf/util/branch.c
 create mode 100644 tools/perf/util/branch.h

-- 
2.7.4
