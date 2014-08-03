Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47D381A005A
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Aug 2014 19:24:16 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Sun, 3 Aug 2014 19:24:14 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 270922BB0023
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Aug 2014 19:24:12 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s73971vv55967764
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Aug 2014 19:07:02 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s739OAmP027876
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Aug 2014 19:24:10 +1000
Subject: [PATCH] powerpc/cpufreq: Add pr_warn() on OPAL firmware failures
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Michael Ellerman <michaele@au1.ibm.com>
Date: Sun, 03 Aug 2014 14:54:05 +0530
Message-ID: <20140803092158.20134.68818.stgit@drishya>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cpufreq depends on platform firmware to implement PStates.  In case of
platform firmware failure, cpufreq should not panic host kernel with
BUG_ON().  Less severe pr_warn() will suffice.

Add firmware_has_feature(FW_FEATURE_OPALv3) check to
skip probing for device-tree on non-powernv platforms.

Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
---
 Tested on powernv and pseries platforms with v3.16-rc7 kernel.

 drivers/cpufreq/powernv-cpufreq.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index bb1d08d..379c083 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -28,6 +28,7 @@
 #include <linux/of.h>
 
 #include <asm/cputhreads.h>
+#include <asm/firmware.h>
 #include <asm/reg.h>
 #include <asm/smp.h> /* Required for cpu_sibling_mask() in UP configs */
 
@@ -98,7 +99,11 @@ static int init_powernv_pstates(void)
 		return -ENODEV;
 	}
 
-	WARN_ON(len_ids != len_freqs);
+	if (len_ids != len_freqs) {
+		pr_warn("Entries in ibm,pstate-ids and "
+			"ibm,pstate-frequencies-mhz does not match\n");
+	}
+
 	nr_pstates = min(len_ids, len_freqs) / sizeof(u32);
 	if (!nr_pstates) {
 		pr_warn("No PStates found\n");
@@ -131,7 +136,12 @@ static unsigned int pstate_id_to_freq(int pstate_id)
 	int i;
 
 	i = powernv_pstate_info.max - pstate_id;
-	BUG_ON(i >= powernv_pstate_info.nr_pstates || i < 0);
+	if (i >= powernv_pstate_info.nr_pstates || i < 0) {
+		pr_warn("PState id %d outside of PState table, "
+			"reporting nominal id %d instead\n",
+			pstate_id, powernv_pstate_info.nominal);
+		i = powernv_pstate_info.max - powernv_pstate_info.nominal;
+	}
 
 	return powernv_freqs[i].frequency;
 }
@@ -321,6 +331,10 @@ static int __init powernv_cpufreq_init(void)
 {
 	int rc = 0;
 
+	/* Don't probe on pseries (guest) platforms */
+	if (!firmware_has_feature(FW_FEATURE_OPALv3))
+		return -ENODEV;
+
 	/* Discover pstates from device tree and init */
 	rc = init_powernv_pstates();
 	if (rc) {
