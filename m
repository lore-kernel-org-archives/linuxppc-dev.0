Return-Path: <michael@ozlabs.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 13 Jul 2006 17:52:09 +1000
Subject: [PATCH 4/7] iseries: Make ItExtVpdPanel private to iSeries
In-Reply-To: <1152777121.430402.3949688126.qpush@concordia>
Message-Id: <20060713075211.9420667B8F@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

No one outside platforms/iseries needs ItExtVpdPanel anymore, so move
it in there. It used to be needed by lparcfg, and so was exported, but
isn't needed anymore, so unexport it.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/lparcfg.c                     |    1 
 arch/powerpc/platforms/iseries/dt.c               |    2 
 arch/powerpc/platforms/iseries/it_exp_vpd_panel.h |   51 ++++++++++++++++++++++
 arch/powerpc/platforms/iseries/lpardata.c         |    3 -
 include/asm-powerpc/iseries/it_exp_vpd_panel.h    |   51 ----------------------
 5 files changed, 53 insertions(+), 55 deletions(-)

Index: to-merge/arch/powerpc/kernel/lparcfg.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/lparcfg.c
+++ to-merge/arch/powerpc/kernel/lparcfg.c
@@ -32,7 +32,6 @@
 #include <asm/rtas.h>
 #include <asm/system.h>
 #include <asm/time.h>
-#include <asm/iseries/it_exp_vpd_panel.h>
 #include <asm/prom.h>
 #include <asm/vdso_datapage.h>
 
Index: to-merge/arch/powerpc/platforms/iseries/dt.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/dt.c
+++ to-merge/arch/powerpc/platforms/iseries/dt.c
@@ -34,13 +34,13 @@
 #include <asm/iseries/hv_types.h>
 #include <asm/iseries/hv_lp_config.h>
 #include <asm/iseries/hv_call_xm.h>
-#include <asm/iseries/it_exp_vpd_panel.h>
 #include <asm/udbg.h>
 
 #include "processor_vpd.h"
 #include "call_hpt.h"
 #include "call_pci.h"
 #include "pci.h"
+#include "it_exp_vpd_panel.h"
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
Index: to-merge/arch/powerpc/platforms/iseries/it_exp_vpd_panel.h
===================================================================
--- /dev/null
+++ to-merge/arch/powerpc/platforms/iseries/it_exp_vpd_panel.h
@@ -0,0 +1,51 @@
+/*
+ * Copyright (C) 2002  Dave Boutcher IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+#ifndef _PLATFORMS_ISERIES_IT_EXT_VPD_PANEL_H
+#define _PLATFORMS_ISERIES_IT_EXT_VPD_PANEL_H
+
+/*
+ *	This struct maps the panel information
+ *
+ * Warning:
+ *	This data must match the architecture for the panel information
+ */
+
+#include <asm/types.h>
+
+struct ItExtVpdPanel {
+	/* Definition of the Extended Vpd On Panel Data Area */
+	char	systemSerial[8];
+	char	mfgID[4];
+	char	reserved1[24];
+	char	machineType[4];
+	char	systemID[6];
+	char	somUniqueCnt[4];
+	char	serialNumberCount;
+	char	reserved2[7];
+	u16	bbu3;
+	u16	bbu2;
+	u16	bbu1;
+	char	xLocationLabel[8];
+	u8	xRsvd1[6];
+	u16	xFrameId;
+	u8	xRsvd2[48];
+};
+
+extern struct ItExtVpdPanel	xItExtVpdPanel;
+
+#endif /* _PLATFORMS_ISERIES_IT_EXT_VPD_PANEL_H */
Index: to-merge/arch/powerpc/platforms/iseries/lpardata.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/lpardata.c
+++ to-merge/arch/powerpc/platforms/iseries/lpardata.c
@@ -18,7 +18,6 @@
 #include <asm/iseries/it_lp_reg_save.h>
 #include <asm/paca.h>
 #include <asm/iseries/lpar_map.h>
-#include <asm/iseries/it_exp_vpd_panel.h>
 #include <asm/iseries/it_lp_queue.h>
 
 #include "naca.h"
@@ -27,6 +26,7 @@
 #include "ipl_parms.h"
 #include "processor_vpd.h"
 #include "release_data.h"
+#include "it_exp_vpd_panel.h"
 
 /* The HvReleaseData is the root of the information shared between
  * the hypervisor and Linux.
@@ -134,7 +134,6 @@ struct ItIplParmsReal xItIplParmsReal __
 
 /* May be filled in by the hypervisor so cannot end up in the BSS */
 struct ItExtVpdPanel xItExtVpdPanel __attribute__((__section__(".data")));
-EXPORT_SYMBOL(xItExtVpdPanel);
 
 #define maxPhysicalProcessors 32
 
Index: to-merge/include/asm-powerpc/iseries/it_exp_vpd_panel.h
===================================================================
--- to-merge.orig/include/asm-powerpc/iseries/it_exp_vpd_panel.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/*
- * Copyright (C) 2002  Dave Boutcher IBM Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#ifndef _ASM_POWERPC_ISERIES_IT_EXT_VPD_PANEL_H
-#define _ASM_POWERPC_ISERIES_IT_EXT_VPD_PANEL_H
-
-/*
- *	This struct maps the panel information
- *
- * Warning:
- *	This data must match the architecture for the panel information
- */
-
-#include <asm/types.h>
-
-struct ItExtVpdPanel {
-	/* Definition of the Extended Vpd On Panel Data Area */
-	char	systemSerial[8];
-	char	mfgID[4];
-	char	reserved1[24];
-	char	machineType[4];
-	char	systemID[6];
-	char	somUniqueCnt[4];
-	char	serialNumberCount;
-	char	reserved2[7];
-	u16	bbu3;
-	u16	bbu2;
-	u16	bbu1;
-	char	xLocationLabel[8];
-	u8	xRsvd1[6];
-	u16	xFrameId;
-	u8	xRsvd2[48];
-};
-
-extern struct ItExtVpdPanel	xItExtVpdPanel;
-
-#endif /* _ASM_POWERPC_ISERIES_IT_EXT_VPD_PANEL_H */
