Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BFA51A013E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 15:45:49 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 26 Nov 2015 23:45:46 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 262DDC9003C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 23:33:54 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAR4ji0F20906184
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 04:45:44 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAR4jhRg023236
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 23:45:43 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: [PATCH 4/4] powerpc/powernv: remove logic for pre-OPALv3 firmware
Date: Fri, 27 Nov 2015 15:45:26 +1100
Message-Id: <1448599526-31073-5-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1448599526-31073-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <1448599526-31073-1-git-send-email-stewart@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There was already a check for OPALv3, so we just remove the if/else
check and go for it.

OPAL pre-v3 no longer exists. Anywhere.

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/smp.c | 68 +++++++++++++++---------------------
 1 file changed, 29 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 9b968a315103..e04d2d4da948 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -61,6 +61,7 @@ static int pnv_smp_kick_cpu(int nr)
 	unsigned long start_here =
 			__pa(ppc_function_entry(generic_secondary_smp_init));
 	long rc;
+	uint8_t status;
 
 	BUG_ON(nr < 0 || nr >= NR_CPUS);
 
@@ -77,53 +78,42 @@ static int pnv_smp_kick_cpu(int nr)
 	 * first time. OPAL v3 allows us to query OPAL to know if it
 	 * has the CPUs, so we do that
 	 */
-	if (firmware_has_feature(FW_FEATURE_OPALv3)) {
-		uint8_t status;
+	rc = opal_query_cpu_status(pcpu, &status);
+	if (rc != OPAL_SUCCESS) {
+		pr_warn("OPAL Error %ld querying CPU %d state\n",
+			rc, nr);
+		return -ENODEV;
+	}
+
+	/*
+	 * Already started, just kick it, probably coming from
+	 * kexec and spinning
+	 */
+	if (status == OPAL_THREAD_STARTED)
+		goto kick;
 
-		rc = opal_query_cpu_status(pcpu, &status);
+	/*
+	 * Available/inactive, let's kick it
+	 */
+	if (status == OPAL_THREAD_INACTIVE) {
+		pr_devel("OPAL: Starting CPU %d (HW 0x%x)...\n",
+			 nr, pcpu);
+		rc = opal_start_cpu(pcpu, start_here);
 		if (rc != OPAL_SUCCESS) {
-			pr_warn("OPAL Error %ld querying CPU %d state\n",
+			pr_warn("OPAL Error %ld starting CPU %d\n",
 				rc, nr);
 			return -ENODEV;
 		}
-
-		/*
-		 * Already started, just kick it, probably coming from
-		 * kexec and spinning
-		 */
-		if (status == OPAL_THREAD_STARTED)
-			goto kick;
-
-		/*
-		 * Available/inactive, let's kick it
-		 */
-		if (status == OPAL_THREAD_INACTIVE) {
-			pr_devel("OPAL: Starting CPU %d (HW 0x%x)...\n",
-				 nr, pcpu);
-			rc = opal_start_cpu(pcpu, start_here);
-			if (rc != OPAL_SUCCESS) {
-				pr_warn("OPAL Error %ld starting CPU %d\n",
-					rc, nr);
-				return -ENODEV;
-			}
-		} else {
-			/*
-			 * An unavailable CPU (or any other unknown status)
-			 * shouldn't be started. It should also
-			 * not be in the possible map but currently it can
-			 * happen
-			 */
-			pr_devel("OPAL: CPU %d (HW 0x%x) is unavailable"
-				 " (status %d)...\n", nr, pcpu, status);
-			return -ENODEV;
-		}
 	} else {
 		/*
-		 * On OPAL v2, we just kick it and hope for the best,
-		 * we must not test the error from opal_start_cpu() or
-		 * we would fail to get CPUs from kexec.
+		 * An unavailable CPU (or any other unknown status)
+		 * shouldn't be started. It should also
+		 * not be in the possible map but currently it can
+		 * happen
 		 */
-		opal_start_cpu(pcpu, start_here);
+		pr_devel("OPAL: CPU %d (HW 0x%x) is unavailable"
+			 " (status %d)...\n", nr, pcpu, status);
+		return -ENODEV;
 	}
  kick:
 	return smp_generic_kick_cpu(nr);
-- 
2.1.4
