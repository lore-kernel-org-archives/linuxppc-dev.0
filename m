Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 4125p75MXZzF33n
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 12:24:31 +1000 (AEST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>
Message-Id: <6337cdd06d5ea5828c4917ccbfd0125bb8a52cb9.1528423341.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1528423341.git.fthain@telegraphics.com.au>
References: <cover.1528423341.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 02/12] macintosh/via-pmu: Add missing mmio accessors
Date: Thu,  7 Jun 2018 22:24:28 -0400 (EDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add missing in_8() accessors to init_pmu() and pmu_sr_intr().

This fixes several sparse warnings:
drivers/macintosh/via-pmu.c:536:29: warning: dereference of noderef expression
drivers/macintosh/via-pmu.c:537:33: warning: dereference of noderef expression
drivers/macintosh/via-pmu.c:1455:17: warning: dereference of noderef expression
drivers/macintosh/via-pmu.c:1456:69: warning: dereference of noderef expression

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/macintosh/via-pmu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index fd3c5640d586..74065ea410bd 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -532,8 +532,9 @@ init_pmu(void)
 	int timeout;
 	struct adb_request req;
 
-	out_8(&via[B], via[B] | TREQ);			/* negate TREQ */
-	out_8(&via[DIRB], (via[DIRB] | TREQ) & ~TACK);	/* TACK in, TREQ out */
+	/* Negate TREQ. Set TACK to input and TREQ to output. */
+	out_8(&via[B], in_8(&via[B]) | TREQ);
+	out_8(&via[DIRB], (in_8(&via[DIRB]) | TREQ) & ~TACK);
 
 	pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, pmu_intr_mask);
 	timeout =  100000;
@@ -1455,8 +1456,8 @@ pmu_sr_intr(void)
 	struct adb_request *req;
 	int bite = 0;
 
-	if (via[B] & TREQ) {
-		printk(KERN_ERR "PMU: spurious SR intr (%x)\n", via[B]);
+	if (in_8(&via[B]) & TREQ) {
+		printk(KERN_ERR "PMU: spurious SR intr (%x)\n", in_8(&via[B]));
 		out_8(&via[IFR], SR_INT);
 		return NULL;
 	}
-- 
2.16.4
