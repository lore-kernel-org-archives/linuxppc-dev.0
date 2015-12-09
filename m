Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D2A821A101F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 17:18:47 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 8 Dec 2015 23:18:45 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 464273E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 23:18:43 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB96IhRT22675466
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Dec 2015 23:18:43 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB96Igxn012343
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Dec 2015 23:18:42 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: [PATCH v2 3/3] powerpc/powernv: remove FW_FEATURE_OPALv3 and just use
 FW_FEATURE_OPAL
Date: Wed,  9 Dec 2015 17:18:20 +1100
Message-Id: <1449641900-22089-4-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1449641900-22089-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <1449641900-22089-1-git-send-email-stewart@linux.vnet.ibm.com>
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

Long ago, only in the lab, there was OPALv1 and OPALv2. Now there is
just OPALv3, with nobody ever expecting anything on pre-OPALv3 to
be cared about or supported by mainline kernels.

So, let's remove FW_FEATURE_OPALv3 and instead use FW_FEATURE_OPAL
exclusively.

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/firmware.h          |  3 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c |  4 +-
 arch/powerpc/platforms/powernv/idle.c        |  2 +-
 arch/powerpc/platforms/powernv/opal-xscom.c  |  2 +-
 arch/powerpc/platforms/powernv/opal.c        | 25 +++++-----
 arch/powerpc/platforms/powernv/pci-ioda.c    |  2 +-
 arch/powerpc/platforms/powernv/setup.c       |  8 +--
 arch/powerpc/platforms/powernv/smp.c         | 74 ++++++++++++----------------
 drivers/cpufreq/powernv-cpufreq.c            |  2 +-
 drivers/cpuidle/cpuidle-powernv.c            |  2 +-
 10 files changed, 54 insertions(+), 70 deletions(-)

diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index 50af5e5ea86f..b0629249778b 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -51,7 +51,6 @@
 #define FW_FEATURE_BEST_ENERGY	ASM_CONST(0x0000000080000000)
 #define FW_FEATURE_TYPE1_AFFINITY ASM_CONST(0x0000000100000000)
 #define FW_FEATURE_PRRN		ASM_CONST(0x0000000200000000)
-#define FW_FEATURE_OPALv3	ASM_CONST(0x0000000400000000)
 
 #ifndef __ASSEMBLY__
 
@@ -69,7 +68,7 @@ enum {
 		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
 		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN,
 	FW_FEATURE_PSERIES_ALWAYS = 0,
-	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL | FW_FEATURE_OPALv3,
+	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL,
 	FW_FEATURE_POWERNV_ALWAYS = 0,
 	FW_FEATURE_PS3_POSSIBLE = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
 	FW_FEATURE_PS3_ALWAYS = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index e1c90725522a..5f152b95ca0c 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -48,8 +48,8 @@ static int pnv_eeh_init(void)
 	struct pci_controller *hose;
 	struct pnv_phb *phb;
 
-	if (!firmware_has_feature(FW_FEATURE_OPALv3)) {
-		pr_warn("%s: OPALv3 is required !\n",
+	if (!firmware_has_feature(FW_FEATURE_OPAL)) {
+		pr_warn("%s: OPAL is required !\n",
 			__func__);
 		return -EINVAL;
 	}
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 59d735d2e5c0..15bfbcd5debc 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -242,7 +242,7 @@ static int __init pnv_init_idle_states(void)
 	if (cpuidle_disable != IDLE_NO_OVERRIDE)
 		goto out;
 
-	if (!firmware_has_feature(FW_FEATURE_OPALv3))
+	if (!firmware_has_feature(FW_FEATURE_OPAL))
 		goto out;
 
 	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
diff --git a/arch/powerpc/platforms/powernv/opal-xscom.c b/arch/powerpc/platforms/powernv/opal-xscom.c
index 7634d1c62299..d0ac535cf5d7 100644
--- a/arch/powerpc/platforms/powernv/opal-xscom.c
+++ b/arch/powerpc/platforms/powernv/opal-xscom.c
@@ -126,7 +126,7 @@ static const struct scom_controller opal_scom_controller = {
 
 static int opal_xscom_init(void)
 {
-	if (firmware_has_feature(FW_FEATURE_OPALv3))
+	if (firmware_has_feature(FW_FEATURE_OPAL))
 		scom_init(&opal_scom_controller);
 	return 0;
 }
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 5ce51d9b4ca6..aad0033d65d1 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -98,10 +98,9 @@ int __init early_init_dt_scan_opal(unsigned long node,
 	pr_debug("OPAL Entry = 0x%llx (sizep=%p runtimesz=%d)\n",
 		 opal.size, sizep, runtimesz);
 
-	powerpc_firmware_features |= FW_FEATURE_OPAL;
 	if (of_flat_dt_is_compatible(node, "ibm,opal-v3")) {
-		powerpc_firmware_features |= FW_FEATURE_OPALv3;
-		pr_info("OPAL V3 detected !\n");
+		powerpc_firmware_features |= FW_FEATURE_OPAL;
+		pr_info("OPAL detected !\n");
 	} else {
 		panic("OPAL != V3 detected, no longer supported.\n");
 	}
@@ -348,17 +347,15 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 	 * enough room and be done with it
 	 */
 	spin_lock_irqsave(&opal_write_lock, flags);
-	if (firmware_has_feature(FW_FEATURE_OPALv3)) {
-		rc = opal_console_write_buffer_space(vtermno, &olen);
-		len = be64_to_cpu(olen);
-		if (rc || len < total_len) {
-			spin_unlock_irqrestore(&opal_write_lock, flags);
-			/* Closed -> drop characters */
-			if (rc)
-				return total_len;
-			opal_poll_events(NULL);
-			return -EAGAIN;
-		}
+	rc = opal_console_write_buffer_space(vtermno, &olen);
+	len = be64_to_cpu(olen);
+	if (rc || len < total_len) {
+		spin_unlock_irqrestore(&opal_write_lock, flags);
+		/* Closed -> drop characters */
+		if (rc)
+			return total_len;
+		opal_poll_events(NULL);
+		return -EAGAIN;
 	}
 
 	/* We still try to handle partial completions, though they
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 414fd1a00fda..cdd5fa942aed 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -344,7 +344,7 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
 		return;
 	}
 
-	if (!firmware_has_feature(FW_FEATURE_OPALv3)) {
+	if (!firmware_has_feature(FW_FEATURE_OPAL)) {
 		pr_info("  Firmware too old to support M64 window\n");
 		return;
 	}
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 54583fc417be..1acb0c72d923 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -90,8 +90,8 @@ static void pnv_show_cpuinfo(struct seq_file *m)
 	if (root)
 		model = of_get_property(root, "model", NULL);
 	seq_printf(m, "machine\t\t: PowerNV %s\n", model);
-	if (firmware_has_feature(FW_FEATURE_OPALv3))
-		seq_printf(m, "firmware\t: OPAL v3\n");
+	if (firmware_has_feature(FW_FEATURE_OPAL))
+		seq_printf(m, "firmware\t: OPAL\n");
 	else
 		seq_printf(m, "firmware\t: BML\n");
 	of_node_put(root);
@@ -220,9 +220,9 @@ static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)
 {
 	xics_kexec_teardown_cpu(secondary);
 
-	/* On OPAL v3, we return all CPUs to firmware */
+	/* On OPAL, we return all CPUs to firmware */
 
-	if (!firmware_has_feature(FW_FEATURE_OPALv3))
+	if (!firmware_has_feature(FW_FEATURE_OPAL))
 		return;
 
 	if (secondary) {
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 9b968a315103..ad7b1a3dbed0 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -61,14 +61,15 @@ static int pnv_smp_kick_cpu(int nr)
 	unsigned long start_here =
 			__pa(ppc_function_entry(generic_secondary_smp_init));
 	long rc;
+	uint8_t status;
 
 	BUG_ON(nr < 0 || nr >= NR_CPUS);
 
 	/*
-	 * If we already started or OPALv3 is not supported, we just
+	 * If we already started or OPAL is not supported, we just
 	 * kick the CPU via the PACA
 	 */
-	if (paca[nr].cpu_start || !firmware_has_feature(FW_FEATURE_OPALv3))
+	if (paca[nr].cpu_start || !firmware_has_feature(FW_FEATURE_OPAL))
 		goto kick;
 
 	/*
@@ -77,55 +78,42 @@ static int pnv_smp_kick_cpu(int nr)
 	 * first time. OPAL v3 allows us to query OPAL to know if it
 	 * has the CPUs, so we do that
 	 */
-	if (firmware_has_feature(FW_FEATURE_OPALv3)) {
-		uint8_t status;
-
-		rc = opal_query_cpu_status(pcpu, &status);
-		if (rc != OPAL_SUCCESS) {
-			pr_warn("OPAL Error %ld querying CPU %d state\n",
-				rc, nr);
-			return -ENODEV;
-		}
+	rc = opal_query_cpu_status(pcpu, &status);
+	if (rc != OPAL_SUCCESS) {
+		pr_warn("OPAL Error %ld querying CPU %d state\n", rc, nr);
+		return -ENODEV;
+	}
 
-		/*
-		 * Already started, just kick it, probably coming from
-		 * kexec and spinning
-		 */
-		if (status == OPAL_THREAD_STARTED)
-			goto kick;
+	/*
+	 * Already started, just kick it, probably coming from
+	 * kexec and spinning
+	 */
+	if (status == OPAL_THREAD_STARTED)
+		goto kick;
 
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
+	/*
+	 * Available/inactive, let's kick it
+	 */
+	if (status == OPAL_THREAD_INACTIVE) {
+		pr_devel("OPAL: Starting CPU %d (HW 0x%x)...\n", nr, pcpu);
+		rc = opal_start_cpu(pcpu, start_here);
+		if (rc != OPAL_SUCCESS) {
+			pr_warn("OPAL Error %ld starting CPU %d\n", rc, nr);
 			return -ENODEV;
 		}
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
- kick:
+
+kick:
 	return smp_generic_kick_cpu(nr);
 }
 
diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index cb501386eb6e..547890fd9572 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -586,7 +586,7 @@ static int __init powernv_cpufreq_init(void)
 	int rc = 0;
 
 	/* Don't probe on pseries (guest) platforms */
-	if (!firmware_has_feature(FW_FEATURE_OPALv3))
+	if (!firmware_has_feature(FW_FEATURE_OPAL))
 		return -ENODEV;
 
 	/* Discover pstates from device tree and init */
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 845bafcfa792..e12dc30d8864 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -264,7 +264,7 @@ static int powernv_idle_probe(void)
 	if (cpuidle_disable != IDLE_NO_OVERRIDE)
 		return -ENODEV;
 
-	if (firmware_has_feature(FW_FEATURE_OPALv3)) {
+	if (firmware_has_feature(FW_FEATURE_OPAL)) {
 		cpuidle_state_table = powernv_states;
 		/* Device tree can indicate more idle states */
 		max_idle_state = powernv_add_idle_states();
-- 
2.1.4
