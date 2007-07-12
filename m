Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2B3CADE290
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 05:13:11 +1000 (EST)
Date: Thu, 12 Jul 2007 14:13:04 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 4/4] Add 6xx-style HID0_SLEEP support.
Message-ID: <20070712191304.GC31381@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070712191205.GA31358@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/6xx-pm.S |   52 ++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/Makefile |    4 +++
 include/asm-powerpc/mpc6xx.h |    6 +++++
 3 files changed, 62 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/sysdev/6xx-pm.S
 create mode 100644 include/asm-powerpc/mpc6xx.h

diff --git a/arch/powerpc/sysdev/6xx-pm.S b/arch/powerpc/sysdev/6xx-pm.S
new file mode 100644
index 0000000..976ee07
--- /dev/null
+++ b/arch/powerpc/sysdev/6xx-pm.S
@@ -0,0 +1,52 @@
+/*
+ * Enter and leave sleep state on chips with 6xx-style HID0
+ * power management bits.
+ *
+ * Author: Scott Wood <scottwood@freescale.com>
+ *
+ * Copyright (c) 2006-2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <asm/ppc_asm.h>
+#include <asm/reg.h>
+#include <asm/thread_info.h>
+#include <asm/asm-offsets.h>
+
+_GLOBAL(mpc6xx_enter_sleep)
+	mflr	r4
+
+	mfspr	r5, SPRN_HID0
+	rlwinm	r5, r5, 0, ~(HID0_DOZE | HID0_NAP)
+	oris	r5, r5, HID0_SLEEP@h
+	mtspr	SPRN_HID0, r5
+	isync
+
+	lis	r5, ret_from_sleep@h
+	ori	r5, r5, ret_from_sleep@l
+	mtlr	r5
+
+	rlwinm	r5, r1, 0, 0, 31-THREAD_SHIFT
+	lwz	r6, TI_LOCAL_FLAGS(r5)
+	ori	r6, r6, _TLF_NAPPING
+	stw	r6, TI_LOCAL_FLAGS(r5)
+
+	mfmsr	r5
+	ori	r5, r5, MSR_EE
+	oris	r5, r5, MSR_POW@h
+	sync
+	mtmsr	r5
+	isync
+
+1:	b	1b
+
+ret_from_sleep:
+	mfspr	r5, SPRN_HID0
+	rlwinm	r5, r5, 0, ~HID0_SLEEP
+	mtspr	SPRN_HID0, r5
+
+	mtlr	r4
+	blr
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 7d8ac1b..fdc2a28 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -35,3 +35,7 @@ obj-$(CONFIG_CPM2)		+= cpm2_common.o cpm2_pic.o
 obj-$(CONFIG_8xx)		+= mpc8xx_pic.o commproc.o
 obj-$(CONFIG_UCODE_PATCH)	+= micropatch.o
 endif
+
+ifeq ($(CONFIG_PM),y)
+obj-$(CONFIG_6xx)		+= 6xx-pm.o
+endif
diff --git a/include/asm-powerpc/mpc6xx.h b/include/asm-powerpc/mpc6xx.h
new file mode 100644
index 0000000..01a33ed
--- /dev/null
+++ b/include/asm-powerpc/mpc6xx.h
@@ -0,0 +1,6 @@
+#ifndef __ASM_POWERPC_MPC6xx_H
+#define __ASM_POWERPC_MPC6xx_H
+
+void mpc6xx_enter_sleep(void);
+
+#endif
-- 
1.5.0.3
