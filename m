Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 90ACF1A022E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 04:30:29 +1000 (AEST)
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C4A3C14029C
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2015 04:30:28 +1000 (AEST)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 24 Sep 2015 12:30:26 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 6F69B1FF0042
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2015 12:21:33 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t8OITEh87406008
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2015 11:29:14 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8OIUN86017373
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2015 12:30:24 -0600
Date: Thu, 24 Sep 2015 11:28:19 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Subject: [PATCH] perf: Fix build break on powerpc due to sample_reg_masks
Message-ID: <20150924182817.GA11058@us.ibm.com>
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


>From d1171a4c34c6100ec8b663ddb803dd69ef3fb7ce Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Thu, 24 Sep 2015 17:53:49 -0400
Subject: [PATCH] perf: Fix build break on powerpc due to sample_reg_masks

perf_regs.c does not get built on Powerpc as CONFIG_PERF_REGS is false.
So the weak definition for 'sample_regs_masks' doesn't get picked up.

Adding perf_regs.o to util/Build unconditionally, exposes a redefinition
error for 'perf_reg_value()' function (due to the static inline version
in util/perf_regs.h). So use #ifdef HAVE_PERF_REGS_SUPPORT' around that
function.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/perf/util/Build       | 2 +-
 tools/perf/util/perf_regs.c | 2 ++
 tools/perf/util/perf_regs.h | 4 ++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 349bc96..e5f18a2 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -17,6 +17,7 @@ libperf-y += levenshtein.o
 libperf-y += llvm-utils.o
 libperf-y += parse-options.o
 libperf-y += parse-events.o
+libperf-y += perf_regs.o
 libperf-y += path.o
 libperf-y += rbtree.o
 libperf-y += bitmap.o
@@ -103,7 +104,6 @@ libperf-$(CONFIG_LIBBABELTRACE) += data-convert-bt.o
 
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
index 2984dcc..8dbdfeb 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -3,6 +3,10 @@
 
 #include <linux/types.h>
 
+#ifndef __maybe_unused
+#define __maybe_unused __attribute__((unused))
+#endif
+
 struct regs_dump;
 
 struct sample_reg {
-- 
1.8.3.1
