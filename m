Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4A4A82C00E7
 for <linuxppc-dev@ozlabs.org>; Mon,  6 May 2013 19:07:14 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 6 May 2013 14:30:38 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 516D91258023
 for <linuxppc-dev@ozlabs.org>; Mon,  6 May 2013 14:38:53 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r469701I66977900
 for <linuxppc-dev@ozlabs.org>; Mon, 6 May 2013 14:37:00 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r46976JO005230
 for <linuxppc-dev@ozlabs.org>; Mon, 6 May 2013 19:07:07 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc,
 perf: Fix processing conditions for invalid BHRB entries
Date: Mon,  6 May 2013 14:36:46 +0530
Message-Id: <1367831206-16331-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fixing some conditions during BHRB entry processing.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 09db68d..1de2756 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1481,25 +1481,25 @@ void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
 			target = val & BHRB_TARGET;
 
 			/* Probable Missed entry: Not applicable for POWER8 */
-			if ((addr == 0) && (target == 0) && (pred == 1)) {
+			if ((addr == 0) && (!target) && pred) {
 				r_index++;
 				continue;
 			}
 
 			/* Real Missed entry: Power8 based missed entry */
-			if ((addr == 0) && (target == 1) && (pred == 1)) {
+			if ((addr == 0) && target && pred) {
 				r_index++;
 				continue;
 			}
 
 			/* Reserved condition: Not a valid entry  */
-			if ((addr == 0) && (target == 1) && (pred == 0)) {
+			if ((addr == 0) && target && (!pred)) {
 				r_index++;
 				continue;
 			}
 
 			/* Is a target address */
-			if (val & BHRB_TARGET) {
+			if (target) {
 				/* First address cannot be a target address */
 				if (r_index == 0) {
 					r_index++;
-- 
1.7.11.7
