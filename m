Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6AB861A0D33
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 17:45:18 +1100 (AEDT)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 2 Feb 2015 23:45:16 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 0571719D803F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Feb 2015 23:36:24 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t136hpxW29687888
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Feb 2015 23:43:51 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t136i3df007269
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Feb 2015 23:44:04 -0700
Subject: [PATCH] arch/cpuidle-powernv: Avoid endianness conversions while
 parsing DT
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Date: Tue, 03 Feb 2015 12:13:44 +0530
Message-ID: <20150203064327.13766.88453.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We currently read the information about idle states from the DT
so as to find out the cpu idle states supported by the platform.
Use those APIs to read from the DT that can avoid endianness
conversions of the property values.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---

 arch/powerpc/platforms/powernv/setup.c |   35 ++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index d2de7d5..39d1971 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -409,37 +409,39 @@ static int __init pnv_init_idle_states(void)
 {
 	struct device_node *power_mgt;
 	int dt_idle_states;
-	const __be32 *idle_state_flags;
-	u32 len_flags, flags;
+	u32 *flags;
 	int i;
 
 	supported_cpuidle_states = 0;
 
 	if (cpuidle_disable != IDLE_NO_OVERRIDE)
-		return 0;
+		goto out;
 
 	if (!firmware_has_feature(FW_FEATURE_OPALv3))
-		return 0;
+		goto out;
 
 	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
 	if (!power_mgt) {
 		pr_warn("opal: PowerMgmt Node not found\n");
-		return 0;
+		goto out;
+	}
+	dt_idle_states = of_property_count_u32_elems(power_mgt,
+			"ibm,cpu-idle-state-flags");
+	if (dt_idle_states < 0) {
+		pr_warn("cpuidle-powernv: no idle states found in the DT\n");
+		goto out;
 	}
 
-	idle_state_flags = of_get_property(power_mgt,
-			"ibm,cpu-idle-state-flags", &len_flags);
-	if (!idle_state_flags) {
-		pr_warn("DT-PowerMgmt: missing ibm,cpu-idle-state-flags\n");
-		return 0;
+	flags = kzalloc(sizeof(*flags) * dt_idle_states, GFP_KERNEL);
+	if (of_property_read_u32_array(power_mgt,
+			"ibm,cpu-idle-state-flags", flags, dt_idle_states)) {
+		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-flags in DT\n");
+		goto out_free;
 	}
 
-	dt_idle_states = len_flags / sizeof(u32);
+	for (i = 0; i < dt_idle_states; i++)
+		supported_cpuidle_states |= flags[i];
 
-	for (i = 0; i < dt_idle_states; i++) {
-		flags = be32_to_cpu(idle_state_flags[i]);
-		supported_cpuidle_states |= flags;
-	}
 	if (!(supported_cpuidle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
 		patch_instruction(
 			(unsigned int *)pnv_fastsleep_workaround_at_entry,
@@ -449,6 +451,9 @@ static int __init pnv_init_idle_states(void)
 			PPC_INST_NOP);
 	}
 	pnv_alloc_idle_core_states();
+out_free:
+	kfree(flags);
+out:
 	return 0;
 }
 
