Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 04EF11A05FA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 04:31:45 +1000 (AEST)
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4695E14010F
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Oct 2015 04:31:44 +1000 (AEST)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 30 Sep 2015 12:31:42 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 0B4031FF002D
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 12:22:49 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8UIUaC63211712
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 11:30:44 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8UIV6cT032287
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 12:31:07 -0600
Date: Wed, 30 Sep 2015 11:28:36 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>
Cc: eranian@google.com, naveen.n.rao@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH v2] perf: Fix build break on powerpc due to sample_reg_masks
Message-ID: <20150930182836.GA27858@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From e29aeeee7236122c4d807ec9ebc721b5d7d75c8d Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Thu, 24 Sep 2015 17:53:49 -0400
Subject: [PATCH v2] perf: Fix build break on powerpc due to sample_reg_masks

perf_regs.c does not get built on Powerpc as CONFIG_PERF_REGS is false.
So the weak definition for 'sample_regs_masks' doesn't get picked up.

Adding perf_regs.o to util/Build unconditionally, exposes a redefinition
error for 'perf_reg_value()' function (due to the static inline version
in util/perf_regs.h). So use #ifdef HAVE_PERF_REGS_SUPPORT' around that
function.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog[v2]
	- [Jiri Olsa] include <linux/compiler.h> for __maybe_unused
---
 tools/perf/util/Build       | 2 +-
 tools/perf/util/perf_regs.c | 2 ++
 tools/perf/util/perf_regs.h | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 4bc7a9a..9217119 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -18,6 +18,7 @@ libperf-y += levenshtein.o
 libperf-y += llvm-utils.o
 libperf-y += parse-options.o
 libperf-y += parse-events.o
+libperf-y += perf_regs.o
 libperf-y += path.o
 libperf-y += rbtree.o
 libperf-y += bitmap.o
@@ -104,7 +105,6 @@ libperf-$(CONFIG_LIBBABELTRACE) += data-convert-bt.o
 
 libperf-y += scripting-engines/
 
-libperf-$(CONFIG_PERF_REGS) += perf_regs.o
 libperf-$(CONFIG_ZLIB) += zlib.o
 libperf-$(CONFIG_LZMA) += lzma.o
 
diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index 885e8ac..6b8eb13 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -6,6 +6,7 @@ const struct sample_reg __weak sample_reg_masks[] = {
 	SMPL_REG_END
 };
 
+#ifdef HAVE_PERF_REGS_SUPPORT
 int perf_reg_value(u64 *valp, struct regs_dump *regs, int id)
 {
 	int i, idx = 0;
@@ -29,3 +30,4 @@ out:
 	*valp = regs->cache_regs[id];
 	return 0;
 }
+#endif
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index 2984dcc..679d6e4 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -2,6 +2,7 @@
 #define __PERF_REGS_H
 
 #include <linux/types.h>
+#include <linux/compiler.h>
 
 struct regs_dump;
 
-- 
1.8.3.1
