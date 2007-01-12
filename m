Return-Path: <ebony.zhu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 5DAE1DDEA3
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 16:27:48 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l0C5RgG7029188
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 22:27:42 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0C5RceT016173
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 23:27:39 -0600 (CST)
To: paulus@samba.org
Subject: [patch][3/5] powerpc: Add the implementations to handle Vector SPFP
	instructions exceptions
From: ebony.zhu@freescale.com
Message-ID: <ZCH01EXM202d3gwhDCv000006f6@zch01exm20.fsl.freescale.net>
Date: 12 Jan 2007 13:27:37 +0800
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the implementations to handle Vector SPFP instructions exceptions
complying with IEEE-754.

Signed-off-by:Ebony Zhu <ebony.zhu@freescale.com>
---
 arch/powerpc/math-emu/evfsabs.c   |   33 ++++++++++++++++++
 arch/powerpc/math-emu/evfsadd.c   |   62 ++++++++++++++++++++++++++++++++++
 arch/powerpc/math-emu/evfscmpeq.c |   68 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/math-emu/evfscmpgt.c |   68 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/math-emu/evfscmplt.c |   68 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/math-emu/evfsctsf.c  |   38 +++++++++++++++++++++
 arch/powerpc/math-emu/evfsctsi.c  |   46 +++++++++++++++++++++++++
 arch/powerpc/math-emu/evfsctsiz.c |   46 +++++++++++++++++++++++++
 arch/powerpc/math-emu/evfsctuf.c  |   39 +++++++++++++++++++++
 arch/powerpc/math-emu/evfsctui.c  |   46 +++++++++++++++++++++++++
 arch/powerpc/math-emu/evfsctuiz.c |   46 +++++++++++++++++++++++++
 arch/powerpc/math-emu/evfsdiv.c   |   62 ++++++++++++++++++++++++++++++++++
 arch/powerpc/math-emu/evfsmul.c   |   68 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/math-emu/evfsnabs.c  |   33 ++++++++++++++++++
 arch/powerpc/math-emu/evfsneg.c   |   33 ++++++++++++++++++
 arch/powerpc/math-emu/evfssub.c   |   67 ++++++++++++++++++++++++++++++++++++
 16 files changed, 823 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/math-emu/evfsabs.c b/arch/powerpc/math-emu/evfsabs.c
new file mode 100644
index 0000000..ac45155
--- /dev/null
+++ b/arch/powerpc/math-emu/evfsabs.c
@@ -0,0 +1,33 @@
+/*
+ * arch/powerpc/math-emu/evfsabs.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "evfsabs"
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+
+int
+evfsabs(u32 *rD, u32 *rA)
+{
+	rD[0] = rA[0] & 0x7fffffff;
+	rD[1] = rA[1] & 0x7fffffff;
+
+#ifdef DEBUG
+	printk("%s: D %p, A %p: ", __FUNCTION__, rD, rA);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/evfsadd.c b/arch/powerpc/math-emu/evfsadd.c
new file mode 100644
index 0000000..194815f
--- /dev/null
+++ b/arch/powerpc/math-emu/evfsadd.c
@@ -0,0 +1,62 @@
+/*
+ * arch/powerpc/math-emu/evfsadd.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "evfsadd"
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+
+#include "soft-fp.h"
+#include "single.h"
+
+int
+evfsadd(u64 *rD, u32 *rA, u32 *rB)
+{
+	FP_DECL_S(A0);
+	FP_DECL_S(A1);
+	FP_DECL_S(B0);
+	FP_DECL_S(B1);
+	FP_DECL_S(R0);
+	FP_DECL_S(R1);
+	int ret = 0;
+
+#ifdef DEBUG
+	printk("%s: %p %p %p\n", __FUNCTION__, rD, rA, rB);
+#endif
+
+	__FP_UNPACK_S(A0, rA);
+	rA[0] = rA[1];
+	__FP_UNPACK_S(A1, rA);
+	__FP_UNPACK_S(B0, rB);
+	rB[0] = rB[1];
+	__FP_UNPACK_S(B1, rB);
+
+#ifdef DEBUG
+	printk("A0: %ld %lu %ld (%ld)\n", A0_s, A0_f, A0_e, A0_c);
+	printk("A1: %ld %lu %ld (%ld)\n", A1_s, A1_f, A1_e, A1_c);
+	printk("B0: %ld %lu %ld (%ld)\n", B0_s, B0_f, B0_e, B0_c);	
+	printk("B1: %ld %lu %ld (%ld)\n", B1_s, B1_f, B1_e, B1_c);	
+#endif
+	
+	FP_ADD_S(R0, A0, B0);
+	FP_ADD_S(R1, A1, B1);
+
+#ifdef DEBUG
+	printk("D0: %ld %lu %ld (%ld)\n", R0_s, R0_f, R0_e, R0_c);
+	printk("D1: %ld %lu %ld (%ld)\n", R1_s, R1_f, R1_e, R1_c);
+#endif
+	
+	return (ret | __FP_PACK_S(rD, R0) | __FP_PACK_S(rD+1, R1));
+}
diff --git a/arch/powerpc/math-emu/evfscmpeq.c b/arch/powerpc/math-emu/evfscmpeq.c
new file mode 100644
index 0000000..89f9005
--- /dev/null
+++ b/arch/powerpc/math-emu/evfscmpeq.c
@@ -0,0 +1,68 @@
+/*
+ * arch/powerpc/math-emu/evfscmpeq.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "evfscmpeq"
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+
+#include "soft-fp.h"
+#include "single.h"
+
+int
+evfscmpeq(u32 *ccr, int crD, u32 *rA, u32 *rB)
+{
+	FP_DECL_S(A0);
+	FP_DECL_S(A1);
+	FP_DECL_S(B0);
+	FP_DECL_S(B1);
+	long cmp, cmp0, cmp1, ch, cl;
+	int ret = 0;
+
+#ifdef DEBUG
+	printk("%s: %p (%08x) %d %p %p\n", __FUNCTION__, ccr, *ccr, crD, rA, rB);
+#endif
+
+	__FP_UNPACK_S(A0, rA);
+	rA[0] = rA[1];
+	__FP_UNPACK_S(A1, rA);
+	__FP_UNPACK_S(B0, rB);
+	rB[0] = rB[1];
+	__FP_UNPACK_S(B1, rB);
+
+#ifdef DEBUG
+	printk("A0: %ld %lu %ld (%ld)\n", A0_s, A0_f, A0_e, A0_c);
+	printk("A1: %ld %lu %ld (%ld)\n", A1_s, A1_f, A1_e, A1_c);
+	printk("B0: %ld %lu %ld (%ld)\n", B0_s, B0_f, B0_e, B0_c);
+	printk("B1: %ld %lu %ld (%ld)\n", B1_s, B1_f, B1_e, B1_c);
+#endif
+
+	FP_CMP_S(cmp0, A0, B0, 2);
+	FP_CMP_S(cmp1, A1, B1, 2);
+
+	ch = (cmp0 == 0) ? 1 : 0;
+	cl = (cmp1 == 0) ? 1 : 0;
+	cmp = 0;
+	cmp = (ch << 3) | (cl << 2) | ((ch | cl) << 1) | ((ch & cl) << 0);
+
+	*ccr &= ~(15 << ((7 - crD) << 2));
+	*ccr |= (cmp << ((7 - crD) << 2));
+
+#ifdef DEBUG
+	printk("CR: %08x\n", *ccr);
+#endif
+
+	return ret;
+}
diff --git a/arch/powerpc/math-emu/evfscmpgt.c b/arch/powerpc/math-emu/evfscmpgt.c
new file mode 100644
index 0000000..2f9e006
--- /dev/null
+++ b/arch/powerpc/math-emu/evfscmpgt.c
@@ -0,0 +1,68 @@
+/*
+ * arch/powerpc/math-emu/evfscmpgt.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "evfscmpgt"
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+
+#include "soft-fp.h"
+#include "single.h"
+
+int
+evfscmpgt(u32 *ccr, int crD, u32 *rA, u32 *rB)
+{
+	FP_DECL_S(A0);
+	FP_DECL_S(A1);
+	FP_DECL_S(B0);
+	FP_DECL_S(B1);
+	long cmp, cmp0, cmp1, ch, cl;
+	int ret = 0;
+
+#ifdef DEBUG
+	printk("%s: %p (%08x) %d %p %p\n", __FUNCTION__, ccr, *ccr, crD, rA, rB);
+#endif
+
+	__FP_UNPACK_S(A0, rA);
+	rA[0] = rA[1];
+	__FP_UNPACK_S(A1, rA);
+	__FP_UNPACK_S(B0, rB);
+	rB[0] = rB[1];
+	__FP_UNPACK_S(B1, rB);
+
+#ifdef DEBUG
+	printk("A0: %ld %lu %ld (%ld)\n", A0_s, A0_f, A0_e, A0_c);
+	printk("A1: %ld %lu %ld (%ld)\n", A1_s, A1_f, A1_e, A1_c);
+	printk("B0: %ld %lu %ld (%ld)\n", B0_s, B0_f, B0_e, B0_c);
+	printk("B1: %ld %lu %ld (%ld)\n", B1_s, B1_f, B1_e, B1_c);
+#endif
+
+	FP_CMP_S(cmp0, A0, B0, 2);
+	FP_CMP_S(cmp1, A1, B1, 2);
+
+	ch = (cmp0 == 1) ? 1 : 0;
+	cl = (cmp1 == 1) ? 1 : 0;
+	cmp = 0;
+	cmp = (ch << 3) | (cl << 2) | ((ch | cl) << 1) | ((ch & cl) << 0);
+
+	*ccr &= ~(15 << ((7 - crD) << 2));
+	*ccr |= (cmp << ((7 - crD) << 2));
+
+#ifdef DEBUG
+	printk("CR: %08x\n", *ccr);
+#endif
+
+	return ret;
+}
diff --git a/arch/powerpc/math-emu/evfscmplt.c b/arch/powerpc/math-emu/evfscmplt.c
new file mode 100644
index 0000000..6781ef6
--- /dev/null
+++ b/arch/powerpc/math-emu/evfscmplt.c
@@ -0,0 +1,68 @@
+/*
+ * arch/powerpc/math-emu/evfscmplt.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "evfscmplt"
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+
+#include "soft-fp.h"
+#include "single.h"
+
+int
+evfscmplt(u32 *ccr, int crD, u32 *rA, u32 *rB)
+{
+	FP_DECL_S(A0);
+	FP_DECL_S(A1);
+	FP_DECL_S(B0);
+	FP_DECL_S(B1);
+	long cmp, cmp0, cmp1, ch, cl;
+	int ret = 0;
+
+#ifdef DEBUG
+	printk("%s: %p (%08x) %d %p %p\n", __FUNCTION__, ccr, *ccr, crD, rA, rB);
+#endif
+
+	__FP_UNPACK_S(A0, rA);
+	rA[0] = rA[1];
+	__FP_UNPACK_S(A1, rA);
+	__FP_UNPACK_S(B0, rB);
+	rB[0] = rB[1];
+	__FP_UNPACK_S(B1, rB);
+
+#ifdef DEBUG
+	printk("A0: %ld %lu %ld (%ld)\n", A0_s, A0_f, A0_e, A0_c);
+	printk("A1: %ld %lu %ld (%ld)\n", A1_s, A1_f, A1_e, A1_c);
+	printk("B0: %ld %lu %ld (%ld)\n", B0_s, B0_f, B0_e, B0_c);
+	printk("B1: %ld %lu %ld (%ld)\n", B1_s, B1_f, B1_e, B1_c);
+#endif
+
+	FP_CMP_S(cmp0, A0, B0, 2);
+	FP_CMP_S(cmp1, A1, B1, 2);
+
+	ch = (cmp0 == -1) ? 1 : 0;
+	cl = (cmp1 == -1) ? 1 : 0;
+	cmp = 0;
+	cmp = (ch << 3) | (cl << 2) | ((ch | cl) << 1) | ((ch & cl) << 0);
+
+	*ccr &= ~(15 << ((7 - crD) << 2));
+	*ccr |= (cmp << ((7 - crD) << 2));
+
+#ifdef DEBUG
+	printk("CR: %08x\n", *ccr);
+#endif
+
+	return ret;
+}
diff --git a/arch/powerpc/math-emu/evfsctsf.c b/arch/powerpc/math-emu/evfsctsf.c
new file mode 100644
index 0000000..f514ce3
--- /dev/null
+++ b/arch/powerpc/math-emu/evfsctsf.c
@@ -0,0 +1,38 @@
+/*
+ * arch/powerpc/math-emu/evfsctsf.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "evfsctsf"
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+
+#include "soft-fp.h"
+#include "single.h"
+
+int
+evfsctsf(u32 *rD, u32 *rB)
+{
+	__asm__ __volatile__ ("mtspr 512, %4\n"
+			      "efsctsf %0, %2\n"
+			      "efsctsf %1, %3\n"
+			      : "=r" (rD[0]), "=r" (rD[1])
+                              : "r" (rB[0]), "r" (rB[1]), "r" (0));
+#ifdef DEBUG
+	printk("%s: D %p, B %p: ", __FUNCTION__, rD, rB);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/evfsctsi.c b/arch/powerpc/math-emu/evfsctsi.c
new file mode 100644
index 0000000..bddd38d
--- /dev/null
+++ b/arch/powerpc/math-emu/evfsctsi.c
@@ -0,0 +1,46 @@
+/*
+ * arch/powerpc/math-emu/evfsctsi.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "evfsctsi"
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+
+#include "soft-fp.h"
+#include "single.h"
+
+int
+evfsctsi(u32 *rD, u32 *rB)
+{
+	FP_DECL_S(B0);
+	FP_DECL_S(B1);
+	unsigned int r0, r1;
+
+	__FP_UNPACK_S(B0, rB);
+	__FP_UNPACK_S(B1, rB+1);
+	_FP_ROUND(1, B0);
+	_FP_ROUND(1, B1);
+	FP_TO_INT_S(r0, B0, 32, 1);
+	rD[0] = r0;
+	FP_TO_INT_S(r1, B1, 32, 1);
+	rD[1] = r1;
+
+#ifdef DEBUG
+	printk("%s: D %p, B %p: ", __FUNCTION__, rD, rB);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/evfsctsiz.c b/arch/powerpc/math-emu/evfsctsiz.c
new file mode 100644
index 0000000..ad5958b
--- /dev/null
+++ b/arch/powerpc/math-emu/evfsctsiz.c
@@ -0,0 +1,46 @@
+/*
+ * arch/powerpc/math-emu/evfsctsiz.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "evfsctsiz"
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+
+#include "soft-fp.h"
+#include "single.h"
+
+int
+evfsctsiz(u32 *rD, u32 *rB)
+{
+	FP_DECL_S(B0);
+	FP_DECL_S(B1);
+	unsigned int r0, r1;
+
+	__FP_UNPACK_S(B0, rB);
+	__FP_UNPACK_S(B1, rB+1);
+	_FP_ROUND_ZERO(1, B0);
+	_FP_ROUND_ZERO(1, B1);
+	FP_TO_INT_S(r0, B0, 32, 1);
+	rD[0] = r0;
+	FP_TO_INT_S(r1, B1, 32, 1);
+	rD[1] = r1;
+
+#ifdef DEBUG
+	printk("%s: D %p, B %p: ", __FUNCTION__, rD, rB);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/evfsctuf.c b/arch/powerpc/math-emu/evfsctuf.c
new file mode 100644
index 0000000..3035691
--- /dev/null
+++ b/arch/powerpc/math-emu/evfsctuf.c
@@ -0,0 +1,39 @@
+/*
+ * arch/powerpc/math-emu/evfsctuf.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "evfsctuf"
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+
+#include "soft-fp.h"
+#include "single.h"
+
+int
+evfsctuf(u32 *rD, u32 *rB)
+{
+	__asm__ __volatile__ ("mtspr 512, %4\n"
+			      "efsctuf %0, %2\n"
+			      "efsctuf %1, %3\n"
+			      : "=r" (rD[0]), "=r" (rD[1])
+                              : "r" (rB[0]), "r" (rB[1]), "r" (0));
+
+#ifdef DEBUG
+	printk("%s: D %p, B %p: ", __FUNCTION__, rD, rB);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/evfsctui.c b/arch/powerpc/math-emu/evfsctui.c
new file mode 100644
index 0000000..f2ad843
--- /dev/null
+++ b/arch/powerpc/math-emu/evfsctui.c
@@ -0,0 +1,46 @@
+/*
+ * arch/powerpc/math-emu/evfsctui.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "evfsctui"
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+
+#include "soft-fp.h"
+#include "single.h"
+
+int
+evfsctui(u32 *rD, u32 *rB)
+{
+	FP_DECL_S(B0);
+	FP_DECL_S(B1);
+	unsigned int r0, r1;
+
+	__FP_UNPACK_S(B0, rB);
+	__FP_UNPACK_S(B1, rB+1);
+	_FP_ROUND(1, B0);
+	_FP_ROUND(1, B1);
+	FP_TO_INT_S(r0, B0, 32, 0);
+	rD[0] = r0;
+	FP_TO_INT_S(r1, B1, 32, 0);
+	rD[1] = r1;
+
+#ifdef DEBUG
+	printk("%s: D %p, B %p: ", __FUNCTION__, rD, rB);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/evfsctuiz.c b/arch/powerpc/math-emu/evfsctuiz.c
new file mode 100644
index 0000000..d2d9238
--- /dev/null
+++ b/arch/powerpc/math-emu/evfsctuiz.c
@@ -0,0 +1,46 @@
+/*
+ * arch/powerpc/math-emu/evfsctuiz.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "evfsctuiz"
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+
+#include "soft-fp.h"
+#include "single.h"
+
+int
+evfsctuiz(u32 *rD, u32 *rB)
+{
+	FP_DECL_S(B0);
+	FP_DECL_S(B1);
+	unsigned int r0, r1;
+
+	__FP_UNPACK_S(B0, rB);
+	__FP_UNPACK_S(B1, rB+1);
+	_FP_ROUND_ZERO(1, B0);
+	_FP_ROUND_ZERO(1, B1);
+	FP_TO_INT_S(r0, B0, 32, 0);
+	rD[0] = r0;
+	FP_TO_INT_S(r1, B1, 32, 0);
+	rD[1] = r1;
+
+#ifdef DEBUG
+	printk("%s: D %p, B %p: ", __FUNCTION__, rD, rB);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/evfsdiv.c b/arch/powerpc/math-emu/evfsdiv.c
new file mode 100644
index 0000000..87083bc
--- /dev/null
+++ b/arch/powerpc/math-emu/evfsdiv.c
@@ -0,0 +1,62 @@
+/*
+ * arch/powerpc/math-emu/evfsdiv.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "evfsdiv"
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+
+#include "soft-fp.h"
+#include "single.h"
+
+int
+evfsdiv(u64 *rD, u32 *rA, u32 *rB)
+{
+	FP_DECL_S(A0);
+	FP_DECL_S(A1);
+	FP_DECL_S(B0);
+	FP_DECL_S(B1);
+	FP_DECL_S(R0);
+	FP_DECL_S(R1);
+	int ret = 0;
+
+#ifdef DEBUG
+	printk("%s: %p %p %p\n", __FUNCTION__, rD, rA, rB);
+#endif
+
+	__FP_UNPACK_S(A0, rA);
+	rA[0] = rA[1];
+	__FP_UNPACK_S(A1, rA);
+	__FP_UNPACK_S(B0, rB);
+	rB[0] = rB[1];
+	__FP_UNPACK_S(B1, rB);
+
+#ifdef DEBUG
+	printk("A0: %ld %lu %ld (%ld)\n", A0_s, A0_f, A0_e, A0_c);
+	printk("A1: %ld %lu %ld (%ld)\n", A1_s, A1_f, A1_e, A1_c);
+	printk("B0: %ld %lu %ld (%ld)\n", B0_s, B0_f, B0_e, B0_c);	
+	printk("B1: %ld %lu %ld (%ld)\n", B1_s, B1_f, B1_e, B1_c);	
+#endif
+	
+	FP_DIV_S(R0, A0, B0);
+	FP_DIV_S(R1, A1, B1);
+
+#ifdef DEBUG
+	printk("D0: %ld %lu %ld (%ld)\n", R0_s, R0_f, R0_e, R0_c);
+	printk("D1: %ld %lu %ld (%ld)\n", R1_s, R1_f, R1_e, R1_c);
+#endif
+	
+	return (ret | __FP_PACK_S(rD, R0) | __FP_PACK_S(rD+1, R1));
+}
diff --git a/arch/powerpc/math-emu/evfsmul.c b/arch/powerpc/math-emu/evfsmul.c
new file mode 100644
index 0000000..f570eb7
--- /dev/null
+++ b/arch/powerpc/math-emu/evfsmul.c
@@ -0,0 +1,68 @@
+/*
+ * arch/powerpc/math-emu/evfsmul.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "evfsmul"
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+
+#include "soft-fp.h"
+#include "single.h"
+
+int
+evfsmul(u64 *rD, u32 *rA, u32 *rB)
+{
+	FP_DECL_S(A0);
+	FP_DECL_S(A1);
+	FP_DECL_S(B0);
+	FP_DECL_S(B1);
+	FP_DECL_S(R0);
+	FP_DECL_S(R1);
+	int ret = 0;
+
+#ifdef DEBUG
+	printk("%s: %p %p %p\n", __FUNCTION__, rD, rA, rB);
+#endif
+
+	__FP_UNPACK_S(A0, rA);
+	rA[0] = rA[1];
+	__FP_UNPACK_S(A1, rA);
+	__FP_UNPACK_S(B0, rB);
+	rB[0] = rB[1];
+	__FP_UNPACK_S(B1, rB);
+
+#ifdef DEBUG
+        printk("A0: %ld %lu %ld (%ld) [%08lx %lx]\n",
+               A0_s, A0_f, A0_e, A0_c, A0_f, A0_e + 127);
+        printk("A1: %ld %lu %ld (%ld) [%08lx %lx]\n",
+               A1_s, A1_f, A1_e, A1_c, A1_f, A1_e + 127);
+        printk("B0: %ld %lu %ld (%ld) [%08lx %lx]\n",
+               B0_s, B0_f, B0_e, B0_c, B0_f, B0_e + 127);
+        printk("B1: %ld %lu %ld (%ld) [%08lx %lx]\n",
+               B1_s, B1_f, B1_e, B1_c, B1_f, B1_e + 127);
+#endif
+	
+	FP_MUL_S(R0, A0, B0);
+	FP_MUL_S(R1, A1, B1);
+
+#ifdef DEBUG
+	printk("D0: %ld %lu %ld (%ld) [%08lx %lx]\n",
+	       R0_s, R0_f, R0_e, R0_c, R0_f, R0_e + 127);
+	printk("D1: %ld %lu %ld (%ld) [%08lx %lx]\n",
+	       R1_s, R1_f, R1_e, R1_c, R1_f, R1_e + 127);
+#endif
+	
+	return (ret | __FP_PACK_S(rD, R0) | __FP_PACK_S(rD+1, R1));
+}
diff --git a/arch/powerpc/math-emu/evfsnabs.c b/arch/powerpc/math-emu/evfsnabs.c
new file mode 100644
index 0000000..c43d7ad
--- /dev/null
+++ b/arch/powerpc/math-emu/evfsnabs.c
@@ -0,0 +1,33 @@
+/*
+ * arch/powerpc/math-emu/evfsnabs.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "evfsnabs"
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+
+int
+evfsnabs(u32 *rD, u32 *rA)
+{
+	rD[0] = rA[0] | 0x80000000;
+	rD[1] = rA[1] | 0x80000000;
+
+#ifdef DEBUG
+	printk("%s: D %p, A %p: ", __FUNCTION__, rD, rA);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/evfsneg.c b/arch/powerpc/math-emu/evfsneg.c
new file mode 100644
index 0000000..5274981
--- /dev/null
+++ b/arch/powerpc/math-emu/evfsneg.c
@@ -0,0 +1,33 @@
+/*
+ * arch/powerpc/math-emu/evfsneg.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "evfsneg"
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+
+int
+evfsneg(u32 *rD, u32 *rA)
+{
+	rD[0] = rA[0] ^ 0x80000000;
+	rD[1] = rA[1] ^ 0x80000000;
+
+#ifdef DEBUG
+	printk("%s: D %p, A %p: ", __FUNCTION__, rD, rA);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/evfssub.c b/arch/powerpc/math-emu/evfssub.c
new file mode 100644
index 0000000..afbeff5
--- /dev/null
+++ b/arch/powerpc/math-emu/evfssub.c
@@ -0,0 +1,67 @@
+/*
+ * arch/powerpc/math-emu/evfssub.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "evfssub"
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+
+#include "soft-fp.h"
+#include "single.h"
+
+int
+evfssub(u64 *rD, u32 *rA, u32 *rB)
+{
+	FP_DECL_S(A0);
+	FP_DECL_S(A1);
+	FP_DECL_S(B0);
+	FP_DECL_S(B1);
+	FP_DECL_S(R0);
+	FP_DECL_S(R1);
+	int ret = 0;
+
+#ifdef DEBUG
+	printk("%s: %p %p %p\n", __FUNCTION__, rD, rA, rB);
+#endif
+
+	__FP_UNPACK_S(A0, rA);
+	rA[0] = rA[1];
+	__FP_UNPACK_S(A1, rA);
+	__FP_UNPACK_S(B0, rB);
+	rB[0] = rB[1];
+	__FP_UNPACK_S(B1, rB);
+
+#ifdef DEBUG
+	printk("A0: %ld %lu %ld (%ld)\n", A0_s, A0_f, A0_e, A0_c);
+	printk("A1: %ld %lu %ld (%ld)\n", A1_s, A1_f, A1_e, A1_c);
+	printk("B0: %ld %lu %ld (%ld)\n", B0_s, B0_f, B0_e, B0_c);	
+	printk("B1: %ld %lu %ld (%ld)\n", B1_s, B1_f, B1_e, B1_c);	
+#endif
+
+	if (B0_c != FP_CLS_NAN)
+		B0_s ^= 1;
+	if (B1_c != FP_CLS_NAN)
+		B1_s ^= 1;
+		
+	FP_ADD_S(R0, A0, B0);
+	FP_ADD_S(R1, A1, B1);
+
+#ifdef DEBUG
+	printk("D0: %ld %lu %ld (%ld)\n", R0_s, R0_f, R0_e, R0_c);
+	printk("D1: %ld %lu %ld (%ld)\n", R1_s, R1_f, R1_e, R1_c);
+#endif
+	
+	return (ret | __FP_PACK_S(rD, R0) | __FP_PACK_S(rD+1, R1));
+}
-- 
1.4.0
