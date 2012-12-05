Return-Path: <RAT063@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D66E42C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2012 09:33:15 +1100 (EST)
From: Chris Freehill <chrisf@freescale.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/perf: Add stalled-cycles events
Date: Wed, 5 Dec 2012 16:32:46 -0600
Message-ID: <1354746766-29662-1-git-send-email-chrisf@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org, paulus@au.ibm.com,
 chrisf@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Support for stalled-cycles-frontend and stalled-cycles-backend is
added for e500-based processors. 

The following mappings are used:

stalled-cycles-frontend or idle-cycles-frontend:
Com:18 Cycles decode stalled

stalled-cycles-backend or idle-cycles-backend
Com:19 cycles issue stalled

Signed-off-by: Chris Freehill <chrisf@freescale.com>
---
 arch/powerpc/perf/e500-pmu.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/perf/e500-pmu.c b/arch/powerpc/perf/e500-pmu.c
index cb2e294..fb66492 100644
--- a/arch/powerpc/perf/e500-pmu.c
+++ b/arch/powerpc/perf/e500-pmu.c
@@ -24,6 +24,8 @@ static int e500_generic_events[] = {
 	[PERF_COUNT_HW_CACHE_MISSES] = 41, /* Data L1 cache reloads */
 	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 12,
 	[PERF_COUNT_HW_BRANCH_MISSES] = 15,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = 18,
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] = 19,
 };
 
 #define C(x)	PERF_COUNT_HW_CACHE_##x
-- 
1.7.9.5
