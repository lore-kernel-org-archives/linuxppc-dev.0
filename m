Return-Path: <BATV+c584780a7cfe22ed9f83+4427+infradead.org+acme@casper.srs.infradead.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F04BF1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 02:42:15 +1100 (AEDT)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 227F21402B4
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 02:42:15 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/1] perf tools: Fix build break on powerpc due to
 sample_reg_masks
Date: Wed,  7 Oct 2015 12:42:03 -0300
Message-Id: <1444232523-20638-2-git-send-email-acme@kernel.org>
In-Reply-To: <1444232523-20638-1-git-send-email-acme@kernel.org>
References: <1444232523-20638-1-git-send-email-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

perf_regs.c does not get built on Powerpc as CONFIG_PERF_REGS is false.
So the weak definition for 'sample_regs_masks' doesn't get picked up.

Adding perf_regs.o to util/Build unconditionally, exposes a redefinition
error for 'perf_reg_value()' function (due to the static inline version
in util/perf_regs.h). So use #ifdef HAVE_PERF_REGS_SUPPORT' around that
function.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: linuxppc-dev@ozlabs.org
Link: http://lkml.kernel.org/r/20150930182836.GA27858@us.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build       | 2 +-
 tools/perf/util/perf_regs.c | 2 ++
 tools/perf/util/perf_regs.h | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 349bc96ca1fe..e5f18a288b74 100644
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
index 885e8ac83997..6b8eb13e14e4 100644
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
index 2984dcc54d67..679d6e493962 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -2,6 +2,7 @@
 #define __PERF_REGS_H
 
 #include <linux/types.h>
+#include <linux/compiler.h>
 
 struct regs_dump;
 
-- 
2.1.0
