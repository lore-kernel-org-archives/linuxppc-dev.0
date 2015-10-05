Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 72CF21A0226
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Oct 2015 20:59:33 +1100 (AEDT)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CB3AC140D93
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Oct 2015 20:59:31 +1100 (AEDT)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 5 Oct 2015 15:29:29 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 08075394005B
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Oct 2015 15:29:26 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t959xF1C25428044
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Oct 2015 15:29:16 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t959xE3l015333
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Oct 2015 15:29:14 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org, dja@axtens.net
Subject: [PATCH V11 04/10] powerpc/perf: Re organize BHRB processing
Date: Mon,  5 Oct 2015 15:29:06 +0530
Message-Id: <1444039152-3665-5-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1444039152-3665-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1444039152-3665-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch cleans up some existing indentation problem in code and
re organizes the BHRB processing code with an helper function named
'update_branch_entry' making it more readable. This patch does not
change any functionality.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c | 105 ++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 53 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 2c8a0d2..5a6fd9c 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -421,11 +421,19 @@ static __u64 power_pmu_bhrb_to(u64 addr)
 	return target - (unsigned long)&instr + addr;
 }
 
+static inline void insert_branch(struct cpu_hw_events *cpuhw,
+			int index, u64 from, u64 to, bool mispred)
+{
+	cpuhw->bhrb_entries[index].from = from;
+	cpuhw->bhrb_entries[index].to = to;
+	cpuhw->bhrb_entries[index].mispred = mispred;
+	cpuhw->bhrb_entries[index].predicted = !mispred;
+}
+
 /* Processing BHRB entries */
 static void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
 {
-	u64 val;
-	u64 addr;
+	u64 val, addr, to_addr;
 	int r_index, u_index;
 	bool mispred;
 
@@ -437,64 +445,55 @@ static void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
 		if (!val)
 			/* Terminal marker: End of valid BHRB entries */
 			break;
-		else {
-			addr = val & BHRB_EA;
-			mispred = val & BHRB_PREDICTION;
 
-			if (!addr)
-				/* invalid entry */
-				continue;
+		addr = val & BHRB_EA;
+		mispred = val & BHRB_PREDICTION;
 
-			/* Branches are read most recent first (ie. mfbhrb 0 is
-			 * the most recent branch).
-			 * There are two types of valid entries:
-			 * 1) a target entry which is the to address of a
-			 *    computed goto like a blr,bctr,btar.  The next
-			 *    entry read from the bhrb will be branch
-			 *    corresponding to this target (ie. the actual
-			 *    blr/bctr/btar instruction).
-			 * 2) a from address which is an actual branch.  If a
-			 *    target entry proceeds this, then this is the
-			 *    matching branch for that target.  If this is not
-			 *    following a target entry, then this is a branch
-			 *    where the target is given as an immediate field
-			 *    in the instruction (ie. an i or b form branch).
-			 *    In this case we need to read the instruction from
-			 *    memory to determine the target/to address.
+		if (!addr)
+			/* invalid entry */
+			continue;
+
+		/* Branches are read most recent first (ie. mfbhrb 0 is
+		 * the most recent branch).
+		 * There are two types of valid entries:
+		 * 1) a target entry which is the to address of a
+		 *    computed goto like a blr,bctr,btar.  The next
+		 *    entry read from the bhrb will be branch
+		 *    corresponding to this target (ie. the actual
+		 *    blr/bctr/btar instruction).
+		 * 2) a from address which is an actual branch.  If a
+		 *    target entry proceeds this, then this is the
+		 *    matching branch for that target.  If this is not
+		 *    following a target entry, then this is a branch
+		 *    where the target is given as an immediate field
+		 *    in the instruction (ie. an i or b form branch).
+		 *    In this case we need to read the instruction from
+		 *    memory to determine the target/to address.
+		 */
+
+		if (val & BHRB_TARGET) {
+			/* Target branches use two entries
+			 * (ie. computed gotos/XL form)
 			 */
+			to_addr = addr;
 
+			/* Get from address in next entry */
+			val = read_bhrb(r_index++);
+			addr = val & BHRB_EA;
 			if (val & BHRB_TARGET) {
-				/* Target branches use two entries
-				 * (ie. computed gotos/XL form)
-				 */
-				cpuhw->bhrb_entries[u_index].to = addr;
-				cpuhw->bhrb_entries[u_index].mispred = mispred;
-				cpuhw->bhrb_entries[u_index].predicted =
-								~mispred;
-
-				/* Get from address in next entry */
-				val = read_bhrb(r_index++);
-				addr = val & BHRB_EA;
-				if (val & BHRB_TARGET) {
-					/* Shouldn't have two targets in a
-					   row.. Reset index and try again */
-					r_index--;
-					addr = 0;
-				}
-				cpuhw->bhrb_entries[u_index].from = addr;
-			} else {
-				/* Branches to immediate field 
-				   (ie I or B form) */
-				cpuhw->bhrb_entries[u_index].from = addr;
-				cpuhw->bhrb_entries[u_index].to =
-					power_pmu_bhrb_to(addr);
-				cpuhw->bhrb_entries[u_index].mispred = mispred;
-				cpuhw->bhrb_entries[u_index].predicted =
-								~mispred;
+				/* Shouldn't have two targets in a
+				   row.. Reset index and try again */
+				r_index--;
+				addr = 0;
 			}
-			u_index++;
-
+			insert_branch(cpuhw, u_index, addr, to_addr, mispred);
+		} else {
+			/* Branches to immediate field
+			   (ie I or B form) */
+			to_addr = power_pmu_bhrb_to(addr);
+			insert_branch(cpuhw, u_index, addr, to_addr, mispred);
 		}
+		u_index++;
 	}
 	cpuhw->bhrb_stack.nr = u_index;
 	return;
-- 
2.1.0
