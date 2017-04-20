Return-Path: <yao.jin@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7ll76BWVzDqJl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 14:10:11 +1000 (AEST)
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org,
 Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 3/7] perf record: Create a new option save_type in
 --branch-filter
Date: Thu, 20 Apr 2017 20:07:51 +0800
Message-Id: <1492690075-17243-4-git-send-email-yao.jin@linux.intel.com>
In-Reply-To: <1492690075-17243-1-git-send-email-yao.jin@linux.intel.com>
References: <1492690075-17243-1-git-send-email-yao.jin@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The option indicates the kernel to save branch type during sampling.

One example:
perf record -g --branch-filter any,save_type <command>

Change log
----------

v6: Not changed.

v5: Not changed.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt | 1 +
 tools/perf/util/parse-branch-options.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index ea3789d..e2f5a4f 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -332,6 +332,7 @@ following filters are defined:
 	- no_tx: only when the target is not in a hardware transaction
 	- abort_tx: only when the target is a hardware transaction abort
 	- cond: conditional branches
+	- save_type: save branch type during sampling in case binary is not available later
 
 +
 The option requires at least one branch type among any, any_call, any_ret, ind_call, cond.
diff --git a/tools/perf/util/parse-branch-options.c b/tools/perf/util/parse-branch-options.c
index 38fd115..e71fb5f 100644
--- a/tools/perf/util/parse-branch-options.c
+++ b/tools/perf/util/parse-branch-options.c
@@ -28,6 +28,7 @@ static const struct branch_mode branch_modes[] = {
 	BRANCH_OPT("cond", PERF_SAMPLE_BRANCH_COND),
 	BRANCH_OPT("ind_jmp", PERF_SAMPLE_BRANCH_IND_JUMP),
 	BRANCH_OPT("call", PERF_SAMPLE_BRANCH_CALL),
+	BRANCH_OPT("save_type", PERF_SAMPLE_BRANCH_TYPE_SAVE),
 	BRANCH_END
 };
 
-- 
2.7.4
