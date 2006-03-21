Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 21 Mar 2006 20:46:09 +1100
Subject: [PATCH 9/11] powerpc: iseries: Add /system-id, /model and /compatible
In-Reply-To: <1142934351.193140.181086235013.qpush@concordia>
Message-Id: <20060321094638.7A28D67BC1@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add /system-id, /model and /compatible to the iSeries device tree.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/iseries/setup.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+)

Index: to-merge/arch/powerpc/platforms/iseries/setup.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/setup.c
+++ to-merge/arch/powerpc/platforms/iseries/setup.c
@@ -50,6 +50,7 @@
 #include <asm/iseries/hv_call_xm.h>
 #include <asm/iseries/it_lp_queue.h>
 #include <asm/iseries/mf.h>
+#include <asm/iseries/it_exp_vpd_panel.h>
 #include <asm/iseries/hv_lp_event.h>
 #include <asm/iseries/lpar_map.h>
 #include <asm/udbg.h>
@@ -888,6 +889,24 @@ void dt_cpus(struct iseries_flat_dt *dt)
 	dt_end_node(dt);
 }
 
+void dt_model(struct iseries_flat_dt *dt)
+{
+	char buf[16] = "IBM,";
+
+	/* "IBM," + mfgId[2:3] + systemSerial[1:5] */
+	strne2a(buf + 4, xItExtVpdPanel.mfgID + 2, 2);
+	strne2a(buf + 6, xItExtVpdPanel.systemSerial + 1, 5);
+	buf[11] = '\0';
+	dt_prop_str(dt, "system-id", buf);
+
+	/* "IBM," + machineType[0:4] */
+	strne2a(buf + 4, xItExtVpdPanel.machineType, 4);
+	buf[8] = '\0';
+	dt_prop_str(dt, "model", buf);
+
+	dt_prop_str(dt, "compatible", "IBM,iSeries");
+}
+
 void build_flat_dt(struct iseries_flat_dt *dt, unsigned long phys_mem_size)
 {
 	u64 tmp[2];
@@ -898,6 +917,7 @@ void build_flat_dt(struct iseries_flat_d
 
 	dt_prop_u32(dt, "#address-cells", 2);
 	dt_prop_u32(dt, "#size-cells", 2);
+	dt_model(dt);
 
 	/* /memory */
 	dt_start_node(dt, "memory@0");
