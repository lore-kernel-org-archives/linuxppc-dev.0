Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 072392C021C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 16:55:50 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r7T6tjMP011111
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 01:55:46 -0500
Message-ID: <1377759345.4028.24.camel@pasglop>
Subject: [PATCH] powerpc/scom: Change scom_read() and scom_write() to return
 errors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 29 Aug 2013 16:55:45 +1000
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

scom_read() now returns the read value via a pointer argument and
both functions return an int error code

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/scom.h       | 23 +++++++++++++++++------
 arch/powerpc/platforms/wsp/scom_smp.c | 18 +++++++++++++-----
 arch/powerpc/platforms/wsp/scom_wsp.c | 12 ++++++++----
 arch/powerpc/platforms/wsp/wsp.c      | 13 +++++++------
 arch/powerpc/sysdev/scom.c            |  3 +--
 5 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/scom.h b/arch/powerpc/include/asm/scom.h
index 0cabfd7..07dcdcf 100644
--- a/arch/powerpc/include/asm/scom.h
+++ b/arch/powerpc/include/asm/scom.h
@@ -54,8 +54,8 @@ struct scom_controller {
 	scom_map_t (*map)(struct device_node *ctrl_dev, u64 reg, u64 count);
 	void (*unmap)(scom_map_t map);
 
-	u64 (*read)(scom_map_t map, u32 reg);
-	void (*write)(scom_map_t map, u32 reg, u64 value);
+	int (*read)(scom_map_t map, u32 reg, u64 *value);
+	int (*write)(scom_map_t map, u32 reg, u64 value);
 };
 
 extern const struct scom_controller *scom_controller;
@@ -133,10 +133,18 @@ static inline void scom_unmap(scom_map_t map)
  * scom_read - Read a SCOM register
  * @map: Result of scom_map
  * @reg: Register index within that map
+ * @value: Updated with the value read
+ *
+ * Returns 0 (success) or a negative error code
  */
-static inline u64 scom_read(scom_map_t map, u32 reg)
+static inline int scom_read(scom_map_t map, u32 reg, u64 *value)
 {
-	return scom_controller->read(map, reg);
+	int rc;
+
+	rc = scom_controller->read(map, reg, value);
+	if (rc)
+		*value = 0xfffffffffffffffful;
+	return rc;
 }
 
 /**
@@ -144,12 +152,15 @@ static inline u64 scom_read(scom_map_t map, u32 reg)
  * @map: Result of scom_map
  * @reg: Register index within that map
  * @value: Value to write
+ *
+ * Returns 0 (success) or a negative error code
  */
-static inline void scom_write(scom_map_t map, u32 reg, u64 value)
+static inline int scom_write(scom_map_t map, u32 reg, u64 value)
 {
-	scom_controller->write(map, reg, value);
+	return scom_controller->write(map, reg, value);
 }
 
+
 #endif /* CONFIG_PPC_SCOM */
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/platforms/wsp/scom_smp.c b/arch/powerpc/platforms/wsp/scom_smp.c
index b56b70a..268bc89 100644
--- a/arch/powerpc/platforms/wsp/scom_smp.c
+++ b/arch/powerpc/platforms/wsp/scom_smp.c
@@ -116,7 +116,14 @@ static int a2_scom_ram(scom_map_t scom, int thread, u32 insn, int extmask)
 
 	scom_write(scom, SCOM_RAMIC, cmd);
 
-	while (!((val = scom_read(scom, SCOM_RAMC)) & mask)) {
+	for (;;) {
+		if (scom_read(scom, SCOM_RAMC, &val) != 0) {
+			pr_err("SCOM error on instruction 0x%08x, thread %d\n",
+			       insn, thread);
+			return -1;
+		}
+		if (val & mask)
+			break;
 		pr_devel("Waiting on RAMC = 0x%llx\n", val);
 		if (++n == 3) {
 			pr_err("RAMC timeout on instruction 0x%08x, thread %d\n",
@@ -151,9 +158,7 @@ static int a2_scom_getgpr(scom_map_t scom, int thread, int gpr, int alt,
 	if (rc)
 		return rc;
 
-	*out_gpr = scom_read(scom, SCOM_RAMD);
-
-	return 0;
+	return scom_read(scom, SCOM_RAMD, out_gpr);
 }
 
 static int a2_scom_getspr(scom_map_t scom, int thread, int spr, u64 *out_spr)
@@ -353,7 +358,10 @@ int a2_scom_startup_cpu(unsigned int lcpu, int thr_idx, struct device_node *np)
 
 	pr_devel("Bringing up CPU%d using SCOM...\n", lcpu);
 
-	pccr0 = scom_read(scom, SCOM_PCCR0);
+	if (scom_read(scom, SCOM_PCCR0, &pccr0) != 0) {
+		printk(KERN_ERR "XSCOM failure readng PCCR0 on CPU%d\n", lcpu);
+		return -1;
+	}
 	scom_write(scom, SCOM_PCCR0, pccr0 | SCOM_PCCR0_ENABLE_DEBUG |
 				     SCOM_PCCR0_ENABLE_RAM);
 
diff --git a/arch/powerpc/platforms/wsp/scom_wsp.c b/arch/powerpc/platforms/wsp/scom_wsp.c
index 4052e22..54172c4 100644
--- a/arch/powerpc/platforms/wsp/scom_wsp.c
+++ b/arch/powerpc/platforms/wsp/scom_wsp.c
@@ -50,18 +50,22 @@ static void wsp_scom_unmap(scom_map_t map)
 	iounmap((void *)map);
 }
 
-static u64 wsp_scom_read(scom_map_t map, u32 reg)
+static int wsp_scom_read(scom_map_t map, u32 reg, u64 *value)
 {
 	u64 __iomem *addr = (u64 __iomem *)map;
 
-	return in_be64(addr + reg);
+	*value = in_be64(addr + reg);
+
+	return 0;
 }
 
-static void wsp_scom_write(scom_map_t map, u32 reg, u64 value)
+static int wsp_scom_write(scom_map_t map, u32 reg, u64 value)
 {
 	u64 __iomem *addr = (u64 __iomem *)map;
 
-	return out_be64(addr + reg, value);
+	out_be64(addr + reg, value);
+
+	return 0;
 }
 
 static const struct scom_controller wsp_scom_controller = {
diff --git a/arch/powerpc/platforms/wsp/wsp.c b/arch/powerpc/platforms/wsp/wsp.c
index d25cc96..ddb6efe 100644
--- a/arch/powerpc/platforms/wsp/wsp.c
+++ b/arch/powerpc/platforms/wsp/wsp.c
@@ -89,6 +89,7 @@ void wsp_halt(void)
 	struct device_node *dn;
 	struct device_node *mine;
 	struct device_node *me;
+	int rc;
 
 	me = of_get_cpu_node(smp_processor_id(), NULL);
 	mine = scom_find_parent(me);
@@ -101,15 +102,15 @@ void wsp_halt(void)
 
 		/* read-modify-write it so the HW probe does not get
 		 * confused */
-		val = scom_read(m, 0);
-		val |= 1;
-		scom_write(m, 0, val);
+		rc = scom_read(m, 0, &val);
+		if (rc == 0)
+			scom_write(m, 0, val | 1);
 		scom_unmap(m);
 	}
 	m = scom_map(mine, 0, 1);
-	val = scom_read(m, 0);
-	val |= 1;
-	scom_write(m, 0, val);
+	rc = scom_read(m, 0, &val);
+	if (rc == 0)
+		scom_write(m, 0, val | 1);
 	/* should never return */
 	scom_unmap(m);
 }
diff --git a/arch/powerpc/sysdev/scom.c b/arch/powerpc/sysdev/scom.c
index 9193e12..10f1d9e 100644
--- a/arch/powerpc/sysdev/scom.c
+++ b/arch/powerpc/sysdev/scom.c
@@ -137,8 +137,7 @@ static int scom_val_get(void *data, u64 *val)
 	if (!scom_map_ok(ent->map))
 		return -EFAULT;
 
-	*val = scom_read(ent->map, 0);
-	return 0;
+	return scom_read(ent->map, 0, val);
 }
 DEFINE_SIMPLE_ATTRIBUTE(scom_val_fops, scom_val_get, scom_val_set,
 			"0x%llx\n");
