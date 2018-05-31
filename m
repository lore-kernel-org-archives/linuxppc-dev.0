Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xBq23QBtzDr30
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 12:53:18 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4V2nD4k032849
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 22:53:16 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ja6bj4b5p-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 22:53:16 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Thu, 31 May 2018 03:53:13 +0100
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: stewart@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com, mpe@ellerman.id.au,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH] [SCHEME 1] Add support for new idle device tree format
Date: Thu, 31 May 2018 08:23:04 +0530
Message-Id: <1527735184-24465-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds support for new device-tree format for idle state
description.

Previously if a older kernel runs on a newer firmware, it may enable
all available states irrespective of its capability of handling it.
New device tree format adds a compatible flag, so that only kernel
which has the capability to handle the version of stop state will enable
it.

Older kernel will still see stop0 and stop0_lite in older format and we
will depricate it after some time.

Idea is to bump up the version in firmware if we find a bug or
regression in stop states. A fix will be provided in linux which would
now know about the bumped up version of stop states, where as kernel
without fixes would ignore the states.

New idle state device tree format :
       power-mgt {
            ...
        ibm,enabled-stop-levels = <0xec000000>;
        ibm,cpu-idle-state-psscr-mask = <0x0 0x3003ff 0x0 0x3003ff>;
        ibm,cpu-idle-state-latencies-ns = <0x3e8 0x7d0>;
        ibm,cpu-idle-state-psscr = <0x0 0x330 0x0 0x300330>;
        ibm,cpu-idle-state-flags = <0x100000 0x101000>;
        ibm,cpu-idle-state-residency-ns = <0x2710 0x4e20>;
        ibm,idle-states {
                phandle = <0xff>;
                    stop4 {
                        flags = <0x207000>;
                        compatible = "ibm,cpuidle-state-v1";
                        psscr-mask = <0x0 0x3003ff>;
                        handle = <0x102>;
                        latency-ns = <0x186a0>;
                        residency-ns = <0x989680>;
                        psscr = <0x0 0x300374>;
                 };

                    ...
                    stop11 {
                        ...
                        compatible = "ibm,cpuoffline-state-v1";
                        ...

           };
           };

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/idle.c | 70 ++++++++++++++++++++++++++++++-----
 drivers/cpuidle/cpuidle-powernv.c     | 26 ++++++++++++-
 2 files changed, 85 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 1f12ab1..074381d 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -623,17 +623,19 @@ int validate_psscr_val_mask(u64 *psscr_val, u64 *psscr_mask, u32 flags)
  * Returns 0 on success
  */
 static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
-					int dt_idle_states)
+					int dt_idle_states, int additional_states)
 {
 	u64 *psscr_val = NULL;
 	u64 *psscr_mask = NULL;
 	u32 *residency_ns = NULL;
 	u64 max_residency_ns = 0;
-	int rc = 0, i;
-
-	psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val), GFP_KERNEL);
-	psscr_mask = kcalloc(dt_idle_states, sizeof(*psscr_mask), GFP_KERNEL);
-	residency_ns = kcalloc(dt_idle_states, sizeof(*residency_ns),
+	int rc = 0, i, orig_dt_idle_states;
+	struct device_node *dt_node;
+	orig_dt_idle_states = dt_idle_states;
+	/* TODO: remove ugliness of using additional_states count*/
+	psscr_val = kcalloc(dt_idle_states+additional_states, sizeof(*psscr_val), GFP_KERNEL);
+	psscr_mask = kcalloc(dt_idle_states+additional_states, sizeof(*psscr_mask), GFP_KERNEL);
+	residency_ns = kcalloc(dt_idle_states+additional_states, sizeof(*residency_ns),
 			       GFP_KERNEL);
 
 	if (!psscr_val || !psscr_mask || !residency_ns) {
@@ -664,7 +666,37 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 		rc = -1;
 		goto out;
 	}
+	for_each_compatible_node( dt_node, NULL, "ibm,cpuoffline-state_v1" ) {
+		printk("Found a state\n");
+		rc = of_property_read_u32(dt_node, "residency-ns" , &(residency_ns[dt_idle_states]));
+		if (rc)
+			printk("error reading residency rc= %d\n",rc);
+		rc = of_property_read_u64(dt_node, "psscr-mask" , &(psscr_mask[dt_idle_states]));
+		if (rc)
+			printk("error reading psscr-mask rc= %d\n",rc);
+		rc = of_property_read_u64(dt_node, "psscr" , &(psscr_val[dt_idle_states]));
+		if (rc)
+			printk("error reading psscr rc= %d\n",rc);
+		dt_idle_states++;
+	}
+	/* Fall back if no cpuoffline state found */
+	if ( orig_dt_idle_states == dt_idle_states) {
 
+		for_each_compatible_node( dt_node, NULL, "ibm,cpuidle-state_v1" ) {
+			printk("Found a state\n");
+			rc = of_property_read_u32(dt_node, "residency-ns" , &(residency_ns[dt_idle_states]));
+			if (rc)
+				printk("error reading residency rc= %d\n",rc);
+			rc = of_property_read_u64(dt_node, "psscr-mask" , &(psscr_mask[dt_idle_states]));
+			if (rc)
+				printk("error reading psscr-mask rc= %d\n",rc);
+			rc = of_property_read_u64(dt_node, "psscr" , &(psscr_val[dt_idle_states]));
+			if (rc)
+				printk("error reading psscr rc= %d\n",rc);
+			dt_idle_states++;
+		}
+	}
+	
 	/*
 	 * Set pnv_first_deep_stop_state, pnv_deepest_stop_psscr_{val,mask},
 	 * and the pnv_default_stop_{val,mask}.
@@ -740,10 +772,11 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
  */
 static void __init pnv_probe_idle_states(void)
 {
-	struct device_node *np;
+	struct device_node *np,*dt_node;
 	int dt_idle_states;
 	u32 *flags = NULL;
-	int i;
+	int i,rc;
+	int additional_states=0;
 
 	np = of_find_node_by_path("/ibm,opal/power-mgt");
 	if (!np) {
@@ -765,12 +798,29 @@ static void __init pnv_probe_idle_states(void)
 		goto out;
 	}
 
+
+	for_each_compatible_node( dt_node, NULL, "ibm,cpuidle-state-v1" ) {
+
+		i = dt_idle_states + additional_states;
+		rc = of_property_read_u32(dt_node, "flags" , &(flags[i]));
+		if (rc)
+			printk("error reading flags rc= %d\n",rc);
+		additional_states++;
+	}
+	for_each_compatible_node( dt_node, NULL, "ibm,cpuoffline-state-v1" ) {
+
+		i = dt_idle_states + additional_states;
+		rc = of_property_read_u32(dt_node, "flags" , &(flags[i]));
+		if (rc)
+			printk("error reading flags rc= %d\n",rc);
+		additional_states++;
+	}
 	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
-		if (pnv_power9_idle_init(np, flags, dt_idle_states))
+		if (pnv_power9_idle_init(np, flags, dt_idle_states,additional_states))
 			goto out;
 	}
 
-	for (i = 0; i < dt_idle_states; i++)
+	for (i = 0; i < dt_idle_states+additional_states; i++)
 		supported_cpuidle_states |= flags[i];
 
 out:
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 1a8234e..e06181f 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -241,7 +241,7 @@ static inline int validate_dt_prop_sizes(const char *prop1, int prop1_len,
 extern u32 pnv_get_supported_cpuidle_states(void);
 static int powernv_add_idle_states(void)
 {
-	struct device_node *power_mgt;
+	struct device_node *power_mgt,*dt_node;
 	int nr_idle_states = 1; /* Snooze */
 	int dt_idle_states, count;
 	u32 latency_ns[CPUIDLE_STATE_MAX];
@@ -365,6 +365,30 @@ static int powernv_add_idle_states(void)
 						residency_ns, dt_idle_states);
 	}
 
+	/* Support new dt format for idle states */
+	for_each_compatible_node( dt_node, NULL, "ibm,cpuidle-state-v1" ) {
+		printk("Found a state\n");
+		rc = of_property_read_string(dt_node, "name" , &(names[dt_idle_states]));
+		if (rc)
+			printk("error reading names rc= %d\n",rc);
+		rc = of_property_read_u32(dt_node, "residency-ns" , &(residency_ns[dt_idle_states]));
+		if (rc)
+			printk("error reading residency rc= %d\n",rc);
+		rc = of_property_read_u32(dt_node, "latency-ns" , &(latency_ns[dt_idle_states]));
+		if (rc)
+			printk("error reading latency rc= %d\n",rc);
+		rc = of_property_read_u32(dt_node, "flags" , &(flags[dt_idle_states]));
+		if (rc)
+			printk("error reading flags rc= %d\n",rc);
+		rc = of_property_read_u64(dt_node, "psscr-mask" , &(psscr_mask[dt_idle_states]));
+		if (rc)
+			printk("error reading psscr-mask rc= %d\n",rc);
+		rc = of_property_read_u64(dt_node, "psscr" , &(psscr_val[dt_idle_states]));
+		if (rc)
+			printk("error reading psscr rc= %d\n",rc);
+		dt_idle_states++;
+	}
+
 	for (i = 0; i < dt_idle_states; i++) {
 		unsigned int exit_latency, target_residency;
 		bool stops_timebase = false;
-- 
2.5.5
