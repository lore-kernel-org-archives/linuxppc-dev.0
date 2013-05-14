Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 761992C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 15:54:13 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r4E5s8bM030241
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 00:54:09 -0500
Message-ID: <1368510848.31689.14.camel@pasglop>
Subject: [PATCH 2/2] powerpc/powernv: Fix starting of secondary CPUs on
 OPALv2 and v3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 14 May 2013 15:54:08 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current code fails to handle kexec on OPALv2. This fixes it
and adds code to improve the situation on OPALv3 where we can
query the CPU status from the firmware and decide what to do
based on that.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/smp.c |   62 ++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 6a3ecca..88c9459 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -71,18 +71,68 @@ int pnv_smp_kick_cpu(int nr)
 
 	BUG_ON(nr < 0 || nr >= NR_CPUS);
 
-	/* On OPAL v2 the CPU are still spinning inside OPAL itself,
-	 * get them back now
+	/*
+	 * If we already started or OPALv2 is not supported, we just
+	 * kick the CPU via the PACA
 	 */
-	if (!paca[nr].cpu_start && firmware_has_feature(FW_FEATURE_OPALv2)) {
-		pr_devel("OPAL: Starting CPU %d (HW 0x%x)...\n", nr, pcpu);
-		rc = opal_start_cpu(pcpu, start_here);
+	if (paca[nr].cpu_start || !firmware_has_feature(FW_FEATURE_OPALv2))
+		goto kick;
+
+	/*
+	 * At this point, the CPU can either be spinning on the way in
+	 * from kexec or be inside OPAL waiting to be started for the
+	 * first time. OPAL v3 allows us to query OPAL to know if it
+	 * has the CPUs, so we do that
+	 */
+	if (firmware_has_feature(FW_FEATURE_OPALv3)) {
+		uint8_t status;
+
+		rc = opal_query_cpu_status(pcpu, &status);
 		if (rc != OPAL_SUCCESS) {
-			pr_warn("OPAL Error %ld starting CPU %d\n",
+			pr_warn("OPAL Error %ld querying CPU %d state\n",
 				rc, nr);
 			return -ENODEV;
 		}
+
+		/*
+		 * Already started, just kick it, probably coming from
+		 * kexec and spinning
+		 */
+		if (status == OPAL_THREAD_STARTED)
+			goto kick;
+
+		/*
+		 * Available/inactive, let's kick it
+		 */
+		if (status == OPAL_THREAD_INACTIVE) {
+			pr_devel("OPAL: Starting CPU %d (HW 0x%x)...\n",
+				 nr, pcpu);
+			rc = opal_start_cpu(pcpu, start_here);
+			if (rc != OPAL_SUCCESS) {
+				pr_warn("OPAL Error %ld starting CPU %d\n",
+					rc, nr);
+				return -ENODEV;
+			}
+		} else {
+			/*
+			 * An unavailable CPU (or any other unknown status)
+			 * shouldn't be started. It should also
+			 * not be in the possible map but currently it can
+			 * happen
+			 */
+			pr_devel("OPAL: CPU %d (HW 0x%x) is unavailable"
+				 " (status %d)...\n", nr, pcpu, status);
+			return -ENODEV;
+		}
+	} else {
+		/*
+		 * On OPAL v2, we just kick it and hope for the best,
+		 * we must not test the error from opal_start_cpu() or
+		 * we would fail to get CPUs from kexec.
+		 */
+		opal_start_cpu(pcpu, start_here);
 	}
+ kick:
 	return smp_generic_kick_cpu(nr);
 }
 
