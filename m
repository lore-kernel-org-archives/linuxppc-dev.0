Return-Path: <yao.jin@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzkZX709KzDqHg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 12:49:56 +1000 (AEST)
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org,
 Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 0/5] perf report: Show branch type
Date: Fri,  7 Apr 2017 18:47:41 +0800
Message-Id: <1491562066-7472-1-git-send-email-yao.jin@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v2:
---
1. Use 4 bits in perf_branch_entry to record branch type.

2. Pull out some common branch types from FAR_BRANCH. Now the branch
   types defined in perf_event.h:

PERF_BR_NONE      : unknown
PERF_BR_JCC_FWD   : conditional forward jump
PERF_BR_JCC_BWD   : conditional backward jump
PERF_BR_JMP       : jump
PERF_BR_IND_JMP   : indirect jump
PERF_BR_CALL      : call
PERF_BR_IND_CALL  : indirect call
PERF_BR_RET       : return
PERF_BR_SYSCALL   : syscall
PERF_BR_SYSRET    : syscall return
PERF_BR_IRQ       : hw interrupt/trap/fault
PERF_BR_INT       : sw interrupt
PERF_BR_IRET      : return from interrupt
PERF_BR_FAR_BRANCH: others not generic far branch type

3. Use 2 bits in perf_branch_entry for a "cross" metrics checking
   for branch cross 4K or 2M area. It's an approximate computing
   for checking if the branch cross 4K page or 2MB page.

For example:

perf record -g --branch-filter any,save_type <command>

perf report --stdio

     JCC forward:  27.7%
    JCC backward:   9.8%
             JMP:   0.0%
         IND_JMP:   6.5%
            CALL:  26.6%
        IND_CALL:   0.0%
             RET:  29.3%
            IRET:   0.0%
        CROSS_4K:   0.0%
        CROSS_2M:  14.3%

perf report --branch-history --stdio --no-children

    -23.60%--main div.c:42 (RET cycles:2)
             compute_flag div.c:28 (RET cycles:2)
             compute_flag div.c:27 (RET CROSS_2M cycles:1)
             rand rand.c:28 (RET CROSS_2M cycles:1)
             rand rand.c:28 (RET cycles:1)
             __random random.c:298 (RET cycles:1)
             __random random.c:297 (JCC forward cycles:1)
             __random random.c:295 (JCC forward cycles:1)
             __random random.c:295 (JCC forward cycles:1)
             __random random.c:295 (JCC forward cycles:1)
             __random random.c:295 (RET cycles:9)

Changed:
  perf/core: Define the common branch type classification
  perf/x86/intel: Record branch type
  perf report: Show branch type statistics for stdio mode
  perf report: Show branch type in callchain entry

Not changed:
  perf record: Create a new option save_type in --branch-filter

v1:
---
It is often useful to know the branch types while analyzing branch
data. For example, a call is very different from a conditional branch.

Currently we have to look it up in binary while the binary may later
not be available and even the binary is available but user has to take
some time. It is very useful for user to check it directly in perf
report.

Perf already has support for disassembling the branch instruction
to get the branch type.

The patch series records the branch type and show the branch type with
other LBR information in callchain entry via perf report. The patch
series also adds the branch type summary at the end of
perf report --stdio.

To keep consistent on kernel and userspace and make the classification
more common, the patch adds the common branch type classification
in perf_event.h.

The common branch types are:

 JCC forward: Conditional forward jump
JCC backward: Conditional backward jump
         JMP: Jump imm
     IND_JMP: Jump reg/mem
        CALL: Call imm
    IND_CALL: Call reg/mem
         RET: Ret
  FAR_BRANCH: SYSCALL/SYSRET, IRQ, IRET, TSX Abort

An example:

1. Record branch type (new option "save_type")

perf record -g --branch-filter any,save_type <command>

2. Show the branch type statistics at the end of perf report --stdio

perf report --stdio

     JCC forward:  34.0%
    JCC backward:   3.6%
             JMP:   0.0%
         IND_JMP:   6.5%
            CALL:  26.6%
        IND_CALL:   0.0%
             RET:  29.3%
      FAR_BRANCH:   0.0%

3. Show branch type in callchain entry

perf report --branch-history --stdio --no-children

    --23.91%--main div.c:42 (RET cycles:2)
              compute_flag div.c:28 (RET cycles:2)
              compute_flag div.c:27 (RET cycles:1)
              rand rand.c:28 (RET cycles:1)
              rand rand.c:28 (RET cycles:1)
              __random random.c:298 (RET cycles:1)
              __random random.c:297 (JCC forward cycles:1)
              __random random.c:295 (JCC forward cycles:1)
              __random random.c:295 (JCC forward cycles:1)
              __random random.c:295 (JCC forward cycles:1)
              __random random.c:295 (RET cycles:9)

Jin Yao (5):
  perf/core: Define the common branch type classification
  perf/x86/intel: Record branch type
  perf record: Create a new option save_type in --branch-filter
  perf report: Show branch type statistics for stdio mode
  perf report: Show branch type in callchain entry

 arch/x86/events/intel/lbr.c              | 106 ++++++++++++++-
 include/uapi/linux/perf_event.h          |  37 +++++-
 tools/include/uapi/linux/perf_event.h    |  37 +++++-
 tools/perf/Documentation/perf-record.txt |   1 +
 tools/perf/builtin-report.c              | 212 +++++++++++++++++++++++++++++
 tools/perf/util/callchain.c              | 221 ++++++++++++++++++++++---------
 tools/perf/util/callchain.h              |  20 +++
 tools/perf/util/event.h                  |   4 +-
 tools/perf/util/hist.c                   |   5 +-
 tools/perf/util/parse-branch-options.c   |   1 +
 10 files changed, 577 insertions(+), 67 deletions(-)

-- 
2.7.4
