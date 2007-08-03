Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 49357DDEC6
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2007 02:33:14 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l73GXB8l013239
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 12:33:11 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l73GXBxj218036
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 10:33:11 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l73GXAxG026368
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 10:33:11 -0600
Message-Id: <20070803161710.676644000@linux.vnet.ibm.com>>
References: <20070803160900.069522000@linux.vnet.ibm.com>>
Date: Fri, 03 Aug 2007 11:09:04 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: [patch 04/10] 4xx bootwrapper reworks
In-Reply-To: <20070803160900.069522000@linux.vnet.ibm.com>>
Content-Type: text/plain
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make the fixup_memsize function common for all of 4xx as several chips share
the same SDRAM controller.  Also add functions to reset 40x chips and quiesce
the ethernet.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/boot/44x.h   |    4 ----
 arch/powerpc/boot/4xx.c   |   36 +++++++++++++++++++++++++++++++-----
 arch/powerpc/boot/4xx.h   |   20 ++++++++++++++++++++
 arch/powerpc/boot/dcr.h   |    2 ++
 arch/powerpc/boot/ebony.c |    3 ++-
 5 files changed, 55 insertions(+), 10 deletions(-)

--- linux-2.6.orig/arch/powerpc/boot/44x.h
+++ linux-2.6/arch/powerpc/boot/44x.h
@@ -10,10 +10,6 @@
 #ifndef _PPC_BOOT_44X_H_
 #define _PPC_BOOT_44X_H_
 
-void ibm44x_fixup_memsize(void);
-void ibm4xx_fixup_ebc_ranges(const char *ebc);
-
-void ibm44x_dbcr_reset(void);
 void ebony_init(void *mac0, void *mac1);
 
 #endif /* _PPC_BOOT_44X_H_ */
--- linux-2.6.orig/arch/powerpc/boot/4xx.c
+++ linux-2.6/arch/powerpc/boot/4xx.c
@@ -21,8 +21,8 @@
 #include "reg.h"
 #include "dcr.h"
 
-/* Read the 44x memory controller to get size of system memory. */
-void ibm44x_fixup_memsize(void)
+/* Read the 4xx SDRAM controller to get size of system memory. */
+void ibm4xx_fixup_memsize(void)
 {
 	int i;
 	unsigned long memsize, bank_config;
@@ -39,22 +39,48 @@ void ibm44x_fixup_memsize(void)
 	dt_fixup_memory(0, memsize);
 }
 
-#define SPRN_DBCR0		0x134
-#define   DBCR0_RST_SYSTEM	0x30000000
+#define DBCR0_RST_SYSTEM 0x30000000
 
 void ibm44x_dbcr_reset(void)
 {
 	unsigned long tmp;
 
+	/* DBCR0 on 44x is SPRN 0x134 */
 	asm volatile (
 		"mfspr	%0,%1\n"
 		"oris	%0,%0,%2@h\n"
 		"mtspr	%1,%0"
-		: "=&r"(tmp) : "i"(SPRN_DBCR0), "i"(DBCR0_RST_SYSTEM)
+		: "=&r"(tmp) : "i"(0x134), "i"(DBCR0_RST_SYSTEM)
 		);
 
 }
 
+void ibm40x_dbcr_reset(void)
+{
+	unsigned long tmp;
+
+	/* DBCR0 on 40x is SPRN 0x3F2 */
+	asm volatile (
+		"mfspr	%0,%1\n"
+		"oris	%0,%0,%2@h\n"
+		"mtspr	%1,%0"
+		: "=&r"(tmp) : "i"(0x3F2), "i"(DBCR0_RST_SYSTEM)
+		);
+}
+
+#define EMAC_RESET 0x20000000
+#define MAL_RESET 0x80000000
+void ibm4xx_quiesce_eth(u32 *emac0, u32 *emac1)
+{
+	/* Quiesce the MAL and EMAC(s) since PIBS/OpenBIOS don't do this for us */
+	if (emac0)
+		*emac0 = EMAC_RESET;
+	if (emac1)
+		*emac1 = EMAC_RESET;
+
+	mtdcr(DCRN_MAL0_CFG, MAL_RESET);
+}
+
 /* Read 4xx EBC bus bridge registers to get mappings of the peripheral
  * banks into the OPB address space */
 void ibm4xx_fixup_ebc_ranges(const char *ebc)
--- /dev/null
+++ linux-2.6/arch/powerpc/boot/4xx.h
@@ -0,0 +1,20 @@
+/*
+ * PowerPC 4xx related functions
+ *
+ * Copyright 2007 IBM Corporation.
+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#ifndef _POWERPC_BOOT_4XX_H_
+#define _POWERPC_BOOT_4XX_H_
+
+void ibm4xx_fixup_memsize(void);
+void ibm44x_dbcr_reset(void);
+void ibm40x_dbcr_reset(void);
+void ibm4xx_quiesce_eth(u32 *emac0, u32 *emac1);
+void ibm4xx_fixup_ebc_ranges(const char *ebc);
+
+#endif /* _POWERPC_BOOT_4XX_H_ */
--- linux-2.6.orig/arch/powerpc/boot/dcr.h
+++ linux-2.6/arch/powerpc/boot/dcr.h
@@ -121,4 +121,6 @@ static const unsigned long sdram_bxcr[] 
 #define DCRN_CPC0_MIRQ1					0x0ed
 #define DCRN_CPC0_JTAGID				0x0ef
 
+#define DCRN_MAL0_CFG					0x180
+
 #endif	/* _PPC_BOOT_DCR_H_ */
--- linux-2.6.orig/arch/powerpc/boot/ebony.c
+++ linux-2.6/arch/powerpc/boot/ebony.c
@@ -25,6 +25,7 @@
 #include "ops.h"
 #include "reg.h"
 #include "dcr.h"
+#include "4xx.h"
 #include "44x.h"
 
 extern char _dtb_start[];
@@ -98,7 +99,7 @@ static void ebony_fixups(void)
 	unsigned long sysclk = 33000000;
 
 	ibm440gp_fixup_clocks(sysclk, 6 * 1843200);
-	ibm44x_fixup_memsize();
+	ibm4xx_fixup_memsize();
 	dt_fixup_mac_addresses(ebony_mac0, ebony_mac1);
 	ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
 }

-- 
