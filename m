Return-Path: <arnd@arndb.de>
Message-Id: <20061024163815.364550000@arndb.de>
References: <20061024163113.694643000@arndb.de>
Date: Tue, 24 Oct 2006 18:31:21 +0200
From: arnd@arndb.de
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [PATCH 08/16] cell: add shadow registers for pmd_reg
Cc: Kevin Corry <kevcorry@us.ibm.com>, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kevin Corry <kevcorry@us.ibm.com>

Many of the registers in the performance monitoring unit are write-only.
We need to save a "shadow" copy when we write to those registers so we
can retrieve the values if we need them later.

The new cbe_pmd_shadow_regs structure is added to the cbe_regs_map structure
so we have the appropriate per-node copies of these shadow values.

Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/cbe_regs.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/cbe_regs.c
+++ linux-2.6/arch/powerpc/platforms/cell/cbe_regs.c
@@ -30,6 +30,7 @@ static struct cbe_regs_map
 	struct cbe_pmd_regs __iomem *pmd_regs;
 	struct cbe_iic_regs __iomem *iic_regs;
 	struct cbe_mic_tm_regs __iomem *mic_tm_regs;
+	struct cbe_pmd_shadow_regs pmd_shadow_regs;
 } cbe_regs_maps[MAX_CBE];
 static int cbe_regs_map_count;
 
@@ -80,6 +81,22 @@ struct cbe_pmd_regs __iomem *cbe_get_cpu
 }
 EXPORT_SYMBOL_GPL(cbe_get_cpu_pmd_regs);
 
+struct cbe_pmd_shadow_regs *cbe_get_pmd_shadow_regs(struct device_node *np)
+{
+	struct cbe_regs_map *map = cbe_find_map(np);
+	if (map == NULL)
+		return NULL;
+	return &map->pmd_shadow_regs;
+}
+
+struct cbe_pmd_shadow_regs *cbe_get_cpu_pmd_shadow_regs(int cpu)
+{
+	struct cbe_regs_map *map = cbe_thread_map[cpu].regs;
+	if (map == NULL)
+		return NULL;
+	return &map->pmd_shadow_regs;
+}
+
 struct cbe_iic_regs __iomem *cbe_get_iic_regs(struct device_node *np)
 {
 	struct cbe_regs_map *map = cbe_find_map(np);
Index: linux-2.6/arch/powerpc/platforms/cell/cbe_regs.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/cbe_regs.h
+++ linux-2.6/arch/powerpc/platforms/cell/cbe_regs.h
@@ -121,6 +121,41 @@ extern struct cbe_pmd_regs __iomem *cbe_
 extern struct cbe_pmd_regs __iomem *cbe_get_cpu_pmd_regs(int cpu);
 
 /*
+ * PMU shadow registers
+ *
+ * Many of the registers in the performance monitoring unit are write-only,
+ * so we need to save a copy of what we write to those registers.
+ *
+ * The actual data counters are read/write. However, writing to the counters
+ * only takes effect if the PMU is enabled. Otherwise the value is stored in
+ * a hardware latch until the next time the PMU is enabled. So we save a copy
+ * of the counter values if we need to read them back while the PMU is
+ * disabled. The counter_value_in_latch field is a bitmap indicating which
+ * counters currently have a value waiting to be written.
+ */
+
+#define NR_PHYS_CTRS	4
+#define NR_CTRS		(NR_PHYS_CTRS * 2)
+
+struct cbe_pmd_shadow_regs {
+	u32 group_control;
+	u32 debug_bus_control;
+	u32 trace_address;
+	u32 ext_tr_timer;
+	u32 pm_status;
+	u32 pm_control;
+	u32 pm_interval;
+	u32 pm_start_stop;
+	u32 pm07_control[NR_CTRS];
+
+	u32 pm_ctr[NR_PHYS_CTRS];
+	u32 counter_value_in_latch;
+};
+
+extern struct cbe_pmd_shadow_regs *cbe_get_pmd_shadow_regs(struct device_node *np);
+extern struct cbe_pmd_shadow_regs *cbe_get_cpu_pmd_shadow_regs(int cpu);
+
+/*
  *
  * IIC unit register definitions
  *

--
