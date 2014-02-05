Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 123FE2C0040
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Feb 2014 19:07:47 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 5 Feb 2014 18:07:45 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 463A32BB0058
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Feb 2014 19:07:43 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s157mE7A4194692
 for <linuxppc-dev@ozlabs.org>; Wed, 5 Feb 2014 18:48:14 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1587f8M010395
 for <linuxppc-dev@ozlabs.org>; Wed, 5 Feb 2014 19:07:42 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [V5 01/11] powerpc, perf: Re-arrange BHRB processing
Date: Wed,  5 Feb 2014 13:36:12 +0530
Message-Id: <1391587582-32028-2-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1391587582-32028-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1391587582-32028-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, ak@linux.intel.com, eranian@google.com,
 michael@ellerman.id.au, acme@ghostprotocols.net, sukadev@linux.vnet.ibm.com,
 mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch cleans up some existing indentation problem and
re-organizes the BHRB processing code with an helper function
named `update_branch_entry` making it more readable. This patch
does not change any functionality.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c | 102 ++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 29b89e8..8a44dc1 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -400,11 +400,21 @@ static __u64 power_pmu_bhrb_to(u64 addr)
 	return target - (unsigned long)&instr + addr;
 }
 
+/* Update individual branch entry */
+void update_branch_entry(struct cpu_hw_events *cpuhw, int u_index, u64 from, u64 to, int pred)
+{
+	cpuhw->bhrb_entries[u_index].from = from;
+	cpuhw->bhrb_entries[u_index].to = to;
+	cpuhw->bhrb_entries[u_index].mispred = pred;
+	cpuhw->bhrb_entries[u_index].predicted = ~pred;
+	return;
+}
+
 /* Processing BHRB entries */
 void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
 {
 	u64 val;
-	u64 addr;
+	u64 addr, tmp;
 	int r_index, u_index, pred;
 
 	r_index = 0;
@@ -415,62 +425,54 @@ void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
 		if (!val)
 			/* Terminal marker: End of valid BHRB entries */
 			break;
-		else {
-			addr = val & BHRB_EA;
-			pred = val & BHRB_PREDICTION;
 
-			if (!addr)
-				/* invalid entry */
-				continue;
+		addr = val & BHRB_EA;
+		pred = val & BHRB_PREDICTION;
 
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
+		if (val & BHRB_TARGET) {
+			/* Target branches use two entries
+			 * (ie. computed gotos/XL form)
 			 */
+			tmp = addr;
 
+			/* Get from address in next entry */
+			val = read_bhrb(r_index++);
+			addr = val & BHRB_EA;
 			if (val & BHRB_TARGET) {
-				/* Target branches use two entries
-				 * (ie. computed gotos/XL form)
-				 */
-				cpuhw->bhrb_entries[u_index].to = addr;
-				cpuhw->bhrb_entries[u_index].mispred = pred;
-				cpuhw->bhrb_entries[u_index].predicted = ~pred;
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
-				cpuhw->bhrb_entries[u_index].mispred = pred;
-				cpuhw->bhrb_entries[u_index].predicted = ~pred;
+				/* Shouldn't have two targets in a
+				   row.. Reset index and try again */
+				r_index--;
+				addr = 0;
 			}
-			u_index++;
-
+			update_branch_entry(cpuhw, u_index, addr, tmp, pred);
+		} else {
+			/* Branches to immediate field
+			   (ie I or B form) */
+			tmp = power_pmu_bhrb_to(addr);
+			update_branch_entry(cpuhw, u_index, addr, tmp, pred);
 		}
+		u_index++;
 	}
 	cpuhw->bhrb_stack.nr = u_index;
 	return;
-- 
1.7.11.7
