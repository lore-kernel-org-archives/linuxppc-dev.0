Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc,
 perf: Fix processing conditions for invalid BHRB entries
In-reply-to: <1367831206-16331-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1367831206-16331-1-git-send-email-khandual@linux.vnet.ibm.com>
Date: Mon, 06 May 2013 21:11:45 +1000
Message-ID: <24261.1367838705@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:

> Fixing some conditions during BHRB entry processing.

I think we can simplify this a lot more... something like the below.

Also, this marks the "to" address as all 1s, which is better poison
value since it's possible to branch to/from 0x0.

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index c627843..d410d65 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1463,65 +1463,45 @@ void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
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
+		val = read_bhrb(r_index++);
 
 		/* Terminal marker: End of valid BHRB entries */
-		if (val == 0) {
+		if (!val) {
 			break;
 		} else {
 			/* BHRB field break up */
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
-
-			/* Real Missed entry: Power8 based missed entry */
-			if ((addr == 0) && (target == 1) && (pred == 1)) {
-				r_index++;
-				continue;
-			}
 
-			/* Reserved condition: Not a valid entry  */
-			if ((addr == 0) && (target == 1) && (pred == 0)) {
-				r_index++;
-				continue;
-			}
-
-			/* Is a target address */
 			if (val & BHRB_TARGET) {
 				/* First address cannot be a target address */
-				if (r_index == 0) {
-					r_index++;
+				if (r_index == 0)
 					continue;
-				}
 
 				/* Update target address for the previous entry */
 				cpuhw->bhrb_entries[u_index - 1].to = addr;
 				cpuhw->bhrb_entries[u_index - 1].mispred = pred;
 				cpuhw->bhrb_entries[u_index - 1].predicted = ~pred;
-
-				/* Dont increment u_index */
-				r_index++;
 			} else {
 				/* Update address, flags for current entry */
 				cpuhw->bhrb_entries[u_index].from = addr;
+				cpuhw->bhrb_entries[u_index].to =
+					0xffffffffffffffff;
 				cpuhw->bhrb_entries[u_index].mispred = pred;
 				cpuhw->bhrb_entries[u_index].predicted = ~pred;
 
 				/* Successfully popullated one entry */
 				u_index++;
-				r_index++;
 			}
 		}
 	}
