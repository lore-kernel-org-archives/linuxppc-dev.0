Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id C5838DE00E
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 05:46:54 +1000 (EST)
Message-Id: <20070423193912.443627233@arndb.de>
References: <20070423193538.576702568@arndb.de>
Date: Mon, 23 Apr 2007 21:35:40 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 02/10] cbe_thermal: clean up computation of temperature
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christian Krafft <krafft@de.ibm.com>
This patch introduces a little function for transforming
register values into temperature.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/cbe_thermal.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/cbe_thermal.c
+++ linux-2.6/arch/powerpc/platforms/cell/cbe_thermal.c
@@ -31,6 +31,11 @@
 #include "cbe_regs.h"
 #include "spu_priv1_mmio.h"
 
+static inline u8 reg_to_temp(u8 reg_value)
+{
+       return ((reg_value & 0x3f) << 1) + 65;
+}
+
 static struct cbe_pmd_regs __iomem *get_pmd_regs(struct sys_device *sysdev)
 {
 	struct spu *spu;
@@ -58,20 +63,14 @@ static u8 spu_read_register_value(struct
 
 static ssize_t spu_show_temp(struct sys_device *sysdev, char *buf)
 {
-	int value;
+	u8 value;
 	struct cbe_pmd_regs __iomem *pmd_regs;
 
 	pmd_regs = get_pmd_regs(sysdev);
 
 	value = spu_read_register_value(sysdev, &pmd_regs->ts_ctsr1);
-	/* clear all other bits */
-	value &= 0x3F;
-	/* temp is stored in steps of 2 degrees */
-	value *= 2;
-	/* base temp is 65 degrees */
-	value += 65;
 
-	return sprintf(buf, "%d\n", (int) value);
+	return sprintf(buf, "%d\n", reg_to_temp(value));
 }
 
 static ssize_t ppe_show_temp(struct sys_device *sysdev, char *buf, int pos)
@@ -82,16 +81,9 @@ static ssize_t ppe_show_temp(struct sys_
 	pmd_regs = cbe_get_cpu_pmd_regs(sysdev->id);
 	value = in_be64(&pmd_regs->ts_ctsr2);
 
-	/* access the corresponding byte */
-	value >>= pos;
-	/* clear all other bits */
-	value &= 0x3F;
-	/* temp is stored in steps of 2 degrees */
-	value *= 2;
-	/* base temp is 65 degrees */
-	value += 65;
+	value = (value >> pos) & 0x3f;
 
-	return sprintf(buf, "%d\n", (int) value);
+	return sprintf(buf, "%d\n", reg_to_temp(value));
 }
 
 

--
