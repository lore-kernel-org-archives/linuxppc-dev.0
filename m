Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 632AD1A0E7B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 22:11:23 +1000 (AEST)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A731D1402A8
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2015 22:11:22 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 15 Jun 2015 17:41:20 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id BE2FF1258060
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2015 17:43:50 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5FCBAlA17891502
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2015 17:41:11 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5FBD3JI024991
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2015 16:43:04 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: dja@axtens.net, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com,
 mikey@neuling.org
Subject: [PATCH V9 05/13] powerpc,
 perf: Change name & type of 'pred' in power_pmu_bhrb_read
Date: Mon, 15 Jun 2015 17:41:00 +0530
Message-Id: <1434370268-19056-6-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1434370268-19056-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1434370268-19056-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Branch record attributes 'mispred' and 'predicted' are single bit
fields as defined in the perf ABI. Hence the data type of the field
'pred' used during BHRB processing should be changed from integer
to bool. This patch also changes the name of the variable from 'pred'
to 'mispred' making the logical inversion process more meaningful
and readable.

Reported-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 892340e..a7be394 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -417,7 +417,8 @@ static void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
 {
 	u64 val;
 	u64 addr;
-	int r_index, u_index, pred;
+	int r_index, u_index;
+	bool mispred;
 
 	r_index = 0;
 	u_index = 0;
@@ -429,7 +430,7 @@ static void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
 			break;
 		else {
 			addr = val & BHRB_EA;
-			pred = val & BHRB_PREDICTION;
+			mispred = val & BHRB_PREDICTION;
 
 			if (!addr)
 				/* invalid entry */
@@ -457,8 +458,9 @@ static void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
 				 * (ie. computed gotos/XL form)
 				 */
 				cpuhw->bhrb_entries[u_index].to = addr;
-				cpuhw->bhrb_entries[u_index].mispred = pred;
-				cpuhw->bhrb_entries[u_index].predicted = ~pred;
+				cpuhw->bhrb_entries[u_index].mispred = mispred;
+				cpuhw->bhrb_entries[u_index].predicted =
+								~mispred;
 
 				/* Get from address in next entry */
 				val = read_bhrb(r_index++);
@@ -478,8 +480,9 @@ static void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
 				cpuhw->bhrb_entries[u_index].from = addr;
 				cpuhw->bhrb_entries[u_index].to =
 					power_pmu_bhrb_to(addr);
-				cpuhw->bhrb_entries[u_index].mispred = pred;
-				cpuhw->bhrb_entries[u_index].predicted = ~pred;
+				cpuhw->bhrb_entries[u_index].mispred = mispred;
+				cpuhw->bhrb_entries[u_index].predicted =
+								~mispred;
 			}
 			u_index++;
 
-- 
2.1.0
