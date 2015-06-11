Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AFBD41A09D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 18:44:09 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 11 Jun 2015 14:14:07 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 1C389125805E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 14:16:37 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5B8i5cB60358680
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 14:14:05 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5B8i4XE017274
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 14:14:04 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sukadev@linux.vnet.ibm.com, eranian@google.com,
 khandual@linux.vnet.ibm.com, rusty@rustcorp.com.au,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Janani <jananive@linux.vnet.ibm.com>
Subject: [PATCH 8/8]powerpc/perf: cleanup in perf_event_print_debug()
Date: Thu, 11 Jun 2015 14:13:37 +0530
Message-Id: <1434012217-9776-9-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1434012217-9776-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1434012217-9776-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Janani <jananive@linux.vnet.ibm.com>

Code cleanup/fix in perf_event_print_debug(). Performance
Monitoring Unit (PMU) registers in the server side
are 64bit long.

Signed-off-by: Janani <jananive@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 4b27caf..36dc23b 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -758,7 +758,7 @@ static void write_pmc(int idx, unsigned long val)
 void perf_event_print_debug(void)
 {
 	unsigned long sdar, sier, flags;
-	u32 pmcs[MAX_HWEVENTS];
+	unsigned long pmcs[MAX_HWEVENTS];
 	int i;
 
 	if (!ppmu->n_counter)
@@ -775,11 +775,11 @@ void perf_event_print_debug(void)
 	for (; i < MAX_HWEVENTS; i++)
 		pmcs[i] = 0xdeadbeef;
 
-	pr_info("PMC1:  %08x PMC2: %08x PMC3: %08x PMC4: %08x\n",
+	pr_info("PMC1:  %016lx PMC2: %016lx PMC3: %016lx PMC4: %016lx\n",
 		 pmcs[0], pmcs[1], pmcs[2], pmcs[3]);
 
 	if (ppmu->n_counter > 4)
-		pr_info("PMC5:  %08x PMC6: %08x PMC7: %08x PMC8: %08x\n",
+		pr_info("PMC5:  %016lx PMC6: %016lx PMC7: %016lx PMC8: %016lx\n",
 			 pmcs[4], pmcs[5], pmcs[6], pmcs[7]);
 
 	pr_info("MMCR0: %016lx MMCR1: %016lx MMCRA: %016lx\n",
-- 
1.9.1
