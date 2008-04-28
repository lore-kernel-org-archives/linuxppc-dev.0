Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 96AEBDE194
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 01:37:58 +1000 (EST)
Date: Mon, 28 Apr 2008 17:38:13 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/7] Add 6xx-style HID0_SLEEP support.
In-Reply-To: <Pine.LNX.4.64.0804281714000.7897@axis700.grange>
Message-ID: <Pine.LNX.4.64.0804281719070.7897@axis700.grange>
References: <Pine.LNX.4.64.0804281714000.7897@axis700.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linux-pm@lists.linux-foundation.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/powerpc/sysdev/6xx-suspend.S |   52 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/Makefile      |    4 +++
 include/asm-powerpc/mpc6xx.h      |    6 ++++
 3 files changed, 62 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/sysdev/6xx-suspend.S
 create mode 100644 include/asm-powerpc/mpc6xx.h

diff --git a/arch/powerpc/sysdev/6xx-suspend.S b/arch/powerpc/sysdev/6xx-suspend.S
new file mode 100644
index 0000000..21cda08
--- /dev/null
+++ b/arch/powerpc/sysdev/6xx-suspend.S
@@ -0,0 +1,52 @@
+/*
+ * Enter and leave sleep state on chips with 6xx-style HID0
+ * power management bits, which don't leave sleep state via reset.
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
+_GLOBAL(mpc6xx_enter_standby)
+	mflr	r4
+
+	mfspr	r5, SPRN_HID0
+	rlwinm	r5, r5, 0, ~(HID0_DOZE | HID0_NAP)
+	oris	r5, r5, HID0_SLEEP@h
+	mtspr	SPRN_HID0, r5
+	isync
+
+	lis	r5, ret_from_standby@h
+	ori	r5, r5, ret_from_standby@l
+	mtlr	r5
+
+	rlwinm	r5, r1, 0, 0, 31-THREAD_SHIFT
+	lwz	r6, TI_LOCAL_FLAGS(r5)
+	ori	r6, r6, _TLF_SLEEPING
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
+ret_from_standby:
+	mfspr	r5, SPRN_HID0
+	rlwinm	r5, r5, 0, ~HID0_SLEEP
+	mtspr	SPRN_HID0, r5
+
+	mtlr	r4
+	blr
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 99a77d7..df2b885 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -37,3 +37,7 @@ obj-$(CONFIG_PPC_DCR)		+= dcr.o
 obj-$(CONFIG_8xx)		+= mpc8xx_pic.o cpm1.o
 obj-$(CONFIG_UCODE_PATCH)	+= micropatch.o
 endif
+
+ifeq ($(CONFIG_SUSPEND),y)
+obj-$(CONFIG_6xx)		+= 6xx-suspend.o
+endif
diff --git a/include/asm-powerpc/mpc6xx.h b/include/asm-powerpc/mpc6xx.h
new file mode 100644
index 0000000..effc229
--- /dev/null
+++ b/include/asm-powerpc/mpc6xx.h
@@ -0,0 +1,6 @@
+#ifndef __ASM_POWERPC_MPC6xx_H
+#define __ASM_POWERPC_MPC6xx_H
+
+void mpc6xx_enter_standby(void);
+
+#endif
-- 
1.5.3.7
