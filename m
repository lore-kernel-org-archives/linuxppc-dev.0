Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r05sS0H7DzDqGM
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 15:18:03 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 4 May 2016 14:47:43 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4D8D33578057
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 14:47:39 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u444lVeh65405016
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 May 2016 14:47:39 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u444l6KE003055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 May 2016 14:47:06 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, mikey <mikey@neuling.org>,
 <linuxppc-dev@lists.ozlabs.org>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH] cxl: Handle num_of_processes larger than can fit in the SPA
Date: Wed,  4 May 2016 14:46:30 +1000
Message-Id: <1462337190-13230-1-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

num_of_process is a 16 bit field, theoretically allowing an AFU to
support 16K processes, however the scheduled process area currently has
a maximum size of 1MB, which limits the maximum number of processes to
7704.

Some AFUs may not necessarily care what the limit is and just want to be
able to use the maximum by setting the field to 16K. To allow these to
work, detect this situation and use the maximum size for the SPA.

Downgrade the WARN_ON to a dev_warn.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/native.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 387fcbd..b8b547a 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -185,16 +185,25 @@ static int spa_max_procs(int spa_size)
 
 int cxl_alloc_spa(struct cxl_afu *afu)
 {
+	unsigned spa_size;
+
 	/* Work out how many pages to allocate */
 	afu->native->spa_order = 0;
 	do {
 		afu->native->spa_order++;
-		afu->native->spa_size = (1 << afu->native->spa_order) * PAGE_SIZE;
+		spa_size = (1 << afu->native->spa_order) * PAGE_SIZE;
+
+		if (spa_size > 0x100000) {
+			dev_warn(&afu->dev, "num_of_processes too large for the SPA, limiting to %i (0x%x)\n",
+					afu->native->spa_max_procs, afu->native->spa_size);
+			afu->num_procs = afu->native->spa_max_procs;
+			break;
+		}
+
+		afu->native->spa_size = spa_size;
 		afu->native->spa_max_procs = spa_max_procs(afu->native->spa_size);
 	} while (afu->native->spa_max_procs < afu->num_procs);
 
-	WARN_ON(afu->native->spa_size > 0x100000); /* Max size supported by the hardware */
-
 	if (!(afu->native->spa = (struct cxl_process_element *)
 	      __get_free_pages(GFP_KERNEL | __GFP_ZERO, afu->native->spa_order))) {
 		pr_err("cxl_alloc_spa: Unable to allocate scheduled process area\n");
-- 
2.1.4
