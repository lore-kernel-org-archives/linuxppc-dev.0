Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 426JC214rgzDrTP
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2018 23:27:25 +1000 (AEST)
Message-Id: <a70172863fa7d3c138f788b18d36524bd45b0a73.1536326078.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] perf: enum overflow in uapi/linux/perf_event.h
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  7 Sep 2018 13:27:19 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PPC32, enums are 32 bits, so __PERF_SAMPLE_CALLCHAIN_EARLY is
out of scope. The following sparse warning is encountered:

  CHECK   arch/powerpc/kernel/process.c
./include/uapi/linux/perf_event.h:147:56: warning: cast truncates bits from constant value (8000000000000000 becomes 0)

This patch changes it to a #define

Fixes: 6cbc304f2f360 ("perf/x86/intel: Fix unwind errors from PEBS entries (mk-II)")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 include/uapi/linux/perf_event.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index eeb787b1c53c..27c7842bc86a 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -143,10 +143,10 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
 
 	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
-
-	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63,
 };
 
+#define __PERF_SAMPLE_CALLCHAIN_EARLY		(1ULL << 63)
+
 /*
  * values to program into branch_sample_type when PERF_SAMPLE_BRANCH is set
  *
-- 
2.13.3
