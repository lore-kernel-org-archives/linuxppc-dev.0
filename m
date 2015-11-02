Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DEF31A03CB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 07:25:05 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 2 Nov 2015 15:25:03 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 77D8738C8051
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2015 15:25:00 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA2KP0NP55640192
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Nov 2015 20:25:00 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA2KOxwh027364
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Nov 2015 15:25:00 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, mingo@redhat.com,
 Jiri Olsa <jolsa@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] powerpc/perf: Rename some Power8 events
Date: Mon,  2 Nov 2015 12:22:24 -0800
Message-Id: <1446495745-24001-4-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1446495745-24001-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1446495745-24001-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rename following events to be consistent with the specs.
	PM_L1_PREF to PM_LSU_L1_PREF
	PM_PPC_CMPL to PM_INST_CMPL

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power8-events-list.h | 2 +-
 arch/powerpc/perf/power8-pmu.c         | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/perf/power8-events-list.h b/arch/powerpc/perf/power8-events-list.h
index 3262e26..69b1a25 100644
--- a/arch/powerpc/perf/power8-events-list.h
+++ b/arch/powerpc/perf/power8-events-list.h
@@ -21,7 +21,7 @@ EVENT(PM_BR_MPRED_CMPL,				0x400f6)
 EVENT(PM_LD_REF_L1,				0x100ee)
 EVENT(PM_LD_MISS_L1,				0x3e054)
 EVENT(PM_ST_MISS_L1,				0x300f0)
-EVENT(PM_L1_PREF,				0x0d8b8)
+EVENT(PM_LSU_L1_PREF,				0x0d8b8)
 EVENT(PM_INST_FROM_L1,				0x04080)
 EVENT(PM_L1_ICACHE_MISS,			0x200fd)
 EVENT(PM_L1_DEMAND_WRITE,			0x0408c)
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 11848af..b453eb9 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -552,11 +552,11 @@ static int power8_get_alternatives(u64 event, unsigned int flags, u64 alt[])
 			case 0x600f4:	/* PM_RUN_CYC */
 				alt[j++] = 0x1e;
 				break;
-			case 0x2:	/* PM_PPC_CMPL */
+			case 0x2:	/* PM_INST_CMPL */
 				alt[j++] = 0x500fa;	/* PM_RUN_INST_CMPL */
 				break;
 			case 0x500fa:	/* PM_RUN_INST_CMPL */
-				alt[j++] = 0x2;	/* PM_PPC_CMPL */
+				alt[j++] = 0x2;	/* PM_INST_CMPL */
 				break;
 			}
 		}
@@ -709,7 +709,7 @@ static int power8_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
 			[ C(RESULT_MISS)   ] = PM_ST_MISS_L1,
 		},
 		[ C(OP_PREFETCH) ] = {
-			[ C(RESULT_ACCESS) ] = PM_L1_PREF,
+			[ C(RESULT_ACCESS) ] = PM_LSU_L1_PREF,
 			[ C(RESULT_MISS)   ] = 0,
 		},
 	},
-- 
2.5.3
