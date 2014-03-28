Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D1DE01400A0
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2014 13:36:44 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Fri, 28 Mar 2014 12:36:43 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7DE8C2BB0047
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2014 13:36:41 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2S2aRqM54591564
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2014 13:36:27 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2S2ae8c015012
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2014 13:36:40 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/7] powerpc/prom: early_init_dt_scan_cpus() updates cpu
 features only once
Date: Fri, 28 Mar 2014 13:36:28 +1100
Message-Id: <1395974192-820-3-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1395974192-820-1-git-send-email-benh@kernel.crashing.org>
References: <1395974192-820-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All our cpu feature updates were done for every CPU in the device-tree,
thus overwriting the cputable bits over and over again. Instead do them
only for the boot CPU.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/prom.c | 52 +++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index f1002b1..7270ca1 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -346,33 +346,34 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 #endif
 	}
 
-	if (found >= 0) {
-		DBG("boot cpu: logical %d physical %d\n", found,
-			be32_to_cpu(intserv[found_thread]));
-		boot_cpuid = found;
-		set_hard_smp_processor_id(found,
-			be32_to_cpu(intserv[found_thread]));
+	/* Not the boot CPU */
+	if (found < 0)
+		return 0;
 
-		/*
-		 * PAPR defines "logical" PVR values for cpus that
-		 * meet various levels of the architecture:
-		 * 0x0f000001	Architecture version 2.04
-		 * 0x0f000002	Architecture version 2.05
-		 * If the cpu-version property in the cpu node contains
-		 * such a value, we call identify_cpu again with the
-		 * logical PVR value in order to use the cpu feature
-		 * bits appropriate for the architecture level.
-		 *
-		 * A POWER6 partition in "POWER6 architected" mode
-		 * uses the 0x0f000002 PVR value; in POWER5+ mode
-		 * it uses 0x0f000001.
-		 */
-		prop = of_get_flat_dt_prop(node, "cpu-version", NULL);
-		if (prop && (be32_to_cpup(prop) & 0xff000000) == 0x0f000000)
-			identify_cpu(0, be32_to_cpup(prop));
+	DBG("boot cpu: logical %d physical %d\n", found,
+	    be32_to_cpu(intserv[found_thread]));
+	boot_cpuid = found;
+	set_hard_smp_processor_id(found, be32_to_cpu(intserv[found_thread]));
 
-		identical_pvr_fixup(node);
-	}
+	/*
+	 * PAPR defines "logical" PVR values for cpus that
+	 * meet various levels of the architecture:
+	 * 0x0f000001	Architecture version 2.04
+	 * 0x0f000002	Architecture version 2.05
+	 * If the cpu-version property in the cpu node contains
+	 * such a value, we call identify_cpu again with the
+	 * logical PVR value in order to use the cpu feature
+	 * bits appropriate for the architecture level.
+	 *
+	 * A POWER6 partition in "POWER6 architected" mode
+	 * uses the 0x0f000002 PVR value; in POWER5+ mode
+	 * it uses 0x0f000001.
+	 */
+	prop = of_get_flat_dt_prop(node, "cpu-version", NULL);
+	if (prop && (be32_to_cpup(prop) & 0xff000000) == 0x0f000000)
+		identify_cpu(0, be32_to_cpup(prop));
+
+	identical_pvr_fixup(node);
 
 	check_cpu_feature_properties(node);
 	check_cpu_pa_features(node);
@@ -384,7 +385,6 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	else
 		cur_cpu_spec->cpu_features &= ~CPU_FTR_SMT;
 #endif
-
 	return 0;
 }
 
-- 
1.8.3.2
