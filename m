Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc/pmu: Fix order of interpreting BHRB target entries
Date: Thu,  9 May 2013 11:46:48 +1000
Message-Id: <1368064009-13255-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <anshuman.khandual@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current Branch History Rolling Buffer (BHRB) code misinterprets the order
of entries in the hardware buffer.  It assumes that a branch target address
will be read _after_ its corresponding branch.  In reality the branch target
comes before (lower mfbhrb entry) it's corresponding branch.

This is a rewrite of the code to take this into account.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/perf/core-book3s.c |   86 ++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 41 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index c627843..2d81372 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1463,66 +1463,70 @@ void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
 {
 	u64 val;
 	u64 addr;
-	int r_index, u_index, target, pred;
+	int r_index, u_index, pred;
 
 	r_index = 0;
 	u_index = 0;
 	while (r_index < ppmu->bhrb_nr) {
 		/* Assembly read function */
-		val = read_bhrb(r_index);
-
-		/* Terminal marker: End of valid BHRB entries */
-		if (val == 0) {
+		val = read_bhrb(r_index++);
+		if (!val)
+			/* Terminal marker: End of valid BHRB entries */
 			break;
-		} else {
-			/* BHRB field break up */
+		else {
 			addr = val & BHRB_EA;
 			pred = val & BHRB_PREDICTION;
-			target = val & BHRB_TARGET;
 
-			/* Probable Missed entry: Not applicable for POWER8 */
-			if ((addr == 0) && (target == 0) && (pred == 1)) {
-				r_index++;
+			if (!addr)
+				/* invalid entry */
 				continue;
-			}
 
-			/* Real Missed entry: Power8 based missed entry */
-			if ((addr == 0) && (target == 1) && (pred == 1)) {
-				r_index++;
-				continue;
-			}
-
-			/* Reserved condition: Not a valid entry  */
-			if ((addr == 0) && (target == 1) && (pred == 0)) {
-				r_index++;
-				continue;
-			}
+			/* Branches are read most recent first (ie. mfbhrb 0 is
+			 * the most recent branch).
+			 * There are two types of valid entries:
+			 * 1) a target entry which is the to address of a
+			 *    computed goto like a blr,bctr,btar.  The next
+			 *    entry read from the bhrb will be branch
+			 *    corresponding to this target (ie. the actual
+			 *    blr/bctr/btar instruction).
+			 * 2) a from address which is an actual branch.  If a
+			 *    target entry proceeds this, then this is the
+			 *    matching branch for that target.  If this is not
+			 *    following a target entry, then this is a branch
+			 *    where the target is given as an immediate field
+			 *    in the instruction (ie. an i or b form branch).
+			 *    In this case we need to read the instruction from
+			 *    memory to determine the target/to address.
+			 */
 
-			/* Is a target address */
 			if (val & BHRB_TARGET) {
-				/* First address cannot be a target address */
-				if (r_index == 0) {
-					r_index++;
-					continue;
-				}
-
-				/* Update target address for the previous entry */
-				cpuhw->bhrb_entries[u_index - 1].to = addr;
-				cpuhw->bhrb_entries[u_index - 1].mispred = pred;
-				cpuhw->bhrb_entries[u_index - 1].predicted = ~pred;
+				/* Target branches use two entries
+				 * (ie. computed gotos/XL form)
+				 */
+				cpuhw->bhrb_entries[u_index].to = addr;
+				cpuhw->bhrb_entries[u_index].mispred = pred;
+				cpuhw->bhrb_entries[u_index].predicted = ~pred;
 
-				/* Dont increment u_index */
-				r_index++;
+				/* Get from address in next entry */
+				val = read_bhrb(r_index++);
+				addr = val & BHRB_EA;
+				if (val & BHRB_TARGET) {
+					/* Shouldn't have two targets in a
+					   row.. Reset index and try again */
+					r_index--;
+					addr = 0;
+				}
+				cpuhw->bhrb_entries[u_index].from = addr;
 			} else {
-				/* Update address, flags for current entry */
+				/* Branches to immediate field 
+				   (ie I or B form) */
 				cpuhw->bhrb_entries[u_index].from = addr;
+				cpuhw->bhrb_entries[u_index].to = 0;
 				cpuhw->bhrb_entries[u_index].mispred = pred;
 				cpuhw->bhrb_entries[u_index].predicted = ~pred;
-
-				/* Successfully popullated one entry */
-				u_index++;
-				r_index++;
 			}
+			u_index++;
+
 		}
 	}
 	cpuhw->bhrb_stack.nr = u_index;
-- 
1.7.10.4
