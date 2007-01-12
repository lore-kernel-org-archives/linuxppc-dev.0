Return-Path: <ebony.zhu@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id C056BDDE2B
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 16:25:50 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l0C5PnM1005000
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 22:25:49 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l0C5Pk0H026131
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 23:25:47 -0600 (CST)
To: paulus@samba.org
Subject: [patch][2/5] powerpc: Add the implementations to handle DPFP
	instruction exceptions
From: ebony.zhu@freescale.com
Message-ID: <ZCH01EXM20hFOWd8T40000006f5@zch01exm20.fsl.freescale.net>
Date: 12 Jan 2007 13:25:45 +0800
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the implementations to handle DPFP instruction exceptions
complying with IEEE-754.

Signed-off-by:Ebony Zhu <ebony.zhu@freescale.com>
---
 arch/powerpc/math-emu/efdcfs.c    |   46 ++++++++++++++++++++++++++++
 arch/powerpc/math-emu/efdcmpeq.c  |   60 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/math-emu/efdcmpgt.c  |   60 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/math-emu/efdcmplt.c  |   60 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/math-emu/efdctsf.c   |   45 ++++++++++++++++++++++++++++
 arch/powerpc/math-emu/efdctsi.c   |   42 ++++++++++++++++++++++++++
 arch/powerpc/math-emu/efdctsidz.c |   44 +++++++++++++++++++++++++++
 arch/powerpc/math-emu/efdctsiz.c  |   42 ++++++++++++++++++++++++++
 arch/powerpc/math-emu/efdctuf.c   |   44 +++++++++++++++++++++++++++
 arch/powerpc/math-emu/efdctui.c   |   42 ++++++++++++++++++++++++++
 arch/powerpc/math-emu/efdctuidz.c |   43 +++++++++++++++++++++++++++
 arch/powerpc/math-emu/efdctuiz.c  |   42 ++++++++++++++++++++++++++
 arch/powerpc/math-emu/efdnabs.c   |   34 +++++++++++++++++++++
 13 files changed, 604 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/math-emu/efdcfs.c b/arch/powerpc/math-emu/efdcfs.c
new file mode 100644
index 0000000..145951d
--- /dev/null
+++ b/arch/powerpc/math-emu/efdcfs.c
@@ -0,0 +1,46 @@
+/*
+ * arch/powerpc/math-emu/efdcfs.c
+ *
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ *
+ * Description:
+ * This file is the implementation of SPE instruction "efdcfs"
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
+#include "double.h"
+#include "single.h"
+
+int
+efdcfs(void *rD, u32 *rB)
+{
+	FP_DECL_S(B);
+	FP_DECL_D(R);
+	int ret;
+	rB[0]=rB[1];
+
+	__FP_UNPACK_S(B, rB);
+
+#ifdef DEBUG
+	printk("B: %ld %lu %ld (%ld)\n", B_s, B_f, B_e, B_c);
+#endif
+
+	FP_CONV(D, S, 2, 1, R, B);
+
+#ifdef DEBUG
+	printk("R: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
+#endif
+	
+	return (ret | __FP_PACK_D(rD, R));
+}
diff --git a/arch/powerpc/math-emu/efdcmpeq.c b/arch/powerpc/math-emu/efdcmpeq.c
new file mode 100644
index 0000000..459fbc0
--- /dev/null
+++ b/arch/powerpc/math-emu/efdcmpeq.c
@@ -0,0 +1,60 @@
+/*
+ * arch/powerpc/math-emu/efdcmpeq.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efdcmpeq"
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
+#include "double.h"
+
+int
+efdcmpeq(u32 *ccr, int crD, void *rA, void *rB)
+{
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	long cmp;
+	int ret = 0;
+
+#ifdef DEBUG
+	printk("%s: %p (%08x) %d %p %p\n", __FUNCTION__, ccr, *ccr, crD, rA, rB);
+#endif
+
+	__FP_UNPACK_D(A, rA);
+	__FP_UNPACK_D(B, rB);
+
+#ifdef DEBUG
+	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
+	printk("B: %ld %lu %lu %ld (%ld)\n", B_s, B_f1, B_f0, B_e, B_c);
+#endif
+
+	FP_CMP_D(cmp, A, B, 2);
+	
+	if (cmp == 0) {
+		cmp = 0x4;
+	} else {
+		cmp = 0;
+	}
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
diff --git a/arch/powerpc/math-emu/efdcmpgt.c b/arch/powerpc/math-emu/efdcmpgt.c
new file mode 100644
index 0000000..e1a779b
--- /dev/null
+++ b/arch/powerpc/math-emu/efdcmpgt.c
@@ -0,0 +1,60 @@
+/*
+ * arch/powerpc/math-emu/efdcmpgt.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efdcmpgt"
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
+#include "double.h"
+
+int
+efdcmpgt(u32 *ccr, int crD, void *rA, void *rB)
+{
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	long cmp;
+	int ret = 0;
+
+#ifdef DEBUG
+	printk("%s: %p (%08x) %d %p %p\n", __FUNCTION__, ccr, *ccr, crD, rA, rB);
+#endif
+
+	__FP_UNPACK_D(A, rA);
+	__FP_UNPACK_D(B, rB);
+
+#ifdef DEBUG
+	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
+	printk("B: %ld %lu %lu %ld (%ld)\n", B_s, B_f1, B_f0, B_e, B_c);
+#endif
+
+	FP_CMP_D(cmp, A, B, 2);
+	
+	if (cmp == 1) {
+		cmp = 0x4;
+	} else {
+		cmp = 0;
+	}
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
diff --git a/arch/powerpc/math-emu/efdcmplt.c b/arch/powerpc/math-emu/efdcmplt.c
new file mode 100644
index 0000000..1ae37f0
--- /dev/null
+++ b/arch/powerpc/math-emu/efdcmplt.c
@@ -0,0 +1,60 @@
+/*
+ * arch/powerpc/math-emu/efdcmplt.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efdcmplt"
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
+#include "double.h"
+
+int
+efdcmplt(u32 *ccr, int crD, void *rA, void *rB)
+{
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	long cmp;
+	int ret = 0;
+
+#ifdef DEBUG
+	printk("%s: %p (%08x) %d %p %p\n", __FUNCTION__, ccr, *ccr, crD, rA, rB);
+#endif
+
+	__FP_UNPACK_D(A, rA);
+	__FP_UNPACK_D(B, rB);
+
+#ifdef DEBUG
+	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
+	printk("B: %ld %lu %lu %ld (%ld)\n", B_s, B_f1, B_f0, B_e, B_c);
+#endif
+
+	FP_CMP_D(cmp, A, B, 2);
+	
+	if (cmp == -1) {
+		cmp = 0x4;
+	} else {
+		cmp = 0;
+	}
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
diff --git a/arch/powerpc/math-emu/efdctsf.c b/arch/powerpc/math-emu/efdctsf.c
new file mode 100644
index 0000000..753df7f
--- /dev/null
+++ b/arch/powerpc/math-emu/efdctsf.c
@@ -0,0 +1,45 @@
+/*
+ * arch/powerpc/math-emu/efdctsf.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efdctsf"
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
+#include "double.h"
+
+int
+efdctsf(u32 *rD, u32 *rB)
+{
+	if (!((rB[0] >> 20) == 0x7ff && ((rB[0] & 0xfffff) > 0 || (rB[1] > 0)))) {/* Not an NaN */
+		if (((rB[0] >> 20) & 0x7ff) == 0 ) { /* rB is Denorm */
+			rD[1] = 0x0;
+		} else if ((rB[0] >> 31) == 0) { /* rB is positive normal */
+			rD[1] = 0x7fffffff;
+		} else { /* rB is negative normal */
+			rD[1] = 0x80000000;
+		}
+	} else { /* rB is NaN */
+		rD[1] = 0x0;	
+	}
+#ifdef DEBUG
+	printk("%s: D %p, B %p: ", __FUNCTION__, rD, rB);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/efdctsi.c b/arch/powerpc/math-emu/efdctsi.c
new file mode 100644
index 0000000..5a22418
--- /dev/null
+++ b/arch/powerpc/math-emu/efdctsi.c
@@ -0,0 +1,42 @@
+/*
+ * arch/powerpc/math-emu/efdctsi.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efdctsi.c"
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
+#include "double.h"
+
+int
+efdctsi(u32 *rD, void *rB)
+{
+	FP_DECL_D(B);
+	unsigned int r;
+
+	__FP_UNPACK_D(B, rB);
+	_FP_ROUND(2, B);
+	FP_TO_INT_D(r, B, 32, 1);
+	rD[1] = r;
+
+#ifdef DEBUG
+	printk("%s: D %p, B %p: ", __FUNCTION__, rD, rB);
+	dump_double(rD);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/efdctsidz.c b/arch/powerpc/math-emu/efdctsidz.c
new file mode 100644
index 0000000..5f2ae76
--- /dev/null
+++ b/arch/powerpc/math-emu/efdctsidz.c
@@ -0,0 +1,44 @@
+/*
+ * arch/powerpc/math-emu/efdctsidz.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efdctsidz"
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
+#include "double.h"
+
+int
+efdctsidz(u32 *rD, void *rB)
+{
+	FP_DECL_D(B);
+	u32 spefscr;
+	u64 r;
+
+	__FP_UNPACK_D(B, rB);
+	_FP_ROUND_ZERO(2, B);
+	FP_TO_INT_D(r, B, 64, 1);
+	rD[1] = r;
+	rD[0] = r >> 32;
+
+#ifdef DEBUG
+	printk("%s: D %p, B %p: ", __FUNCTION__, rD, rB);
+	dump_double(rD);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/efdctsiz.c b/arch/powerpc/math-emu/efdctsiz.c
new file mode 100644
index 0000000..8b99f08
--- /dev/null
+++ b/arch/powerpc/math-emu/efdctsiz.c
@@ -0,0 +1,42 @@
+/*
+ * arch/powerpc/math-emu/efdctsiz.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efdctsiz"
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
+#include "double.h"
+
+int
+efdctsiz(u32 *rD, void *rB)
+{
+	FP_DECL_D(B);
+	unsigned int r;
+
+	__FP_UNPACK_D(B, rB);
+	_FP_ROUND_ZERO(2, B);
+	FP_TO_INT_D(r, B, 32, 1);
+	rD[1] = r;
+
+#ifdef DEBUG
+	printk("%s: D %p, B %p: ", __FUNCTION__, rD, rB);
+	dump_double(rD);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/efdctuf.c b/arch/powerpc/math-emu/efdctuf.c
new file mode 100644
index 0000000..6583f79
--- /dev/null
+++ b/arch/powerpc/math-emu/efdctuf.c
@@ -0,0 +1,44 @@
+/*
+ * arch/powerpc/math-emu/efdctuf.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efdctuf"
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
+#include "double.h"
+
+int
+efdctuf(u32 *rD, u32 *rB)
+{
+	if (!((rB[0] >> 20) == 0x7ff && ((rB[0] & 0xfffff) > 0 || (rB[1] > 0))) /* Not an NaN */
+	    && (rB[0] >> 31) == 0) { /* rB is positive */
+		if (((rB[0] >> 20) & 0x7ff) == 0 ) { /* rB is Denorm */
+			rD[1] = 0x0;
+		} else { /* rB is normal */
+			rD[1] = 0xffffffff;
+		}
+	} else { /* rB < 0 or rB is NaN */
+		rD[1] = 0x0;	
+	}
+#ifdef DEBUG
+	printk("%s: D %p, B %p: ", __FUNCTION__, rD, rB);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/efdctui.c b/arch/powerpc/math-emu/efdctui.c
new file mode 100644
index 0000000..8d327d7
--- /dev/null
+++ b/arch/powerpc/math-emu/efdctui.c
@@ -0,0 +1,42 @@
+/*
+ * arch/powerpc/math-emu/efdctui.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efdctui"
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
+#include "double.h"
+
+int
+efdctui(u32 *rD, void *rB)
+{
+	FP_DECL_D(B);
+	unsigned int r;
+
+	__FP_UNPACK_D(B, rB);
+	_FP_ROUND(2, B);
+	FP_TO_INT_D(r, B, 32, 0);
+	rD[1] = r;
+
+#ifdef DEBUG
+	printk("%s: D %p, B %p: ", __FUNCTION__, rD, rB);
+	dump_double(rD);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/efdctuidz.c b/arch/powerpc/math-emu/efdctuidz.c
new file mode 100644
index 0000000..be912ee
--- /dev/null
+++ b/arch/powerpc/math-emu/efdctuidz.c
@@ -0,0 +1,43 @@
+/*
+ * arch/powerpc/math-emu/efdctuidz.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efdctuidz"
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
+#include "double.h"
+
+int
+efdctuidz(u32 *rD, void *rB)
+{
+	FP_DECL_D(B);
+	u64 r;
+
+	__FP_UNPACK_D(B, rB);
+	_FP_ROUND_ZERO(2, B);
+	FP_TO_INT_D(r, B, 64, 0);
+	rD[1] = r;
+	rD[0] = r >> 32;
+
+#ifdef DEBUG
+	printk("%s: D %p, B %p: ", __FUNCTION__, rD, rB);
+	dump_double(rD);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/efdctuiz.c b/arch/powerpc/math-emu/efdctuiz.c
new file mode 100644
index 0000000..b39faf6
--- /dev/null
+++ b/arch/powerpc/math-emu/efdctuiz.c
@@ -0,0 +1,42 @@
+/*
+ * arch/powerpc/math-emu/efdctuiz.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efdctuiz"
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
+#include "double.h"
+
+int
+efdctuiz(u32 *rD, void *rB)
+{
+	FP_DECL_D(B);
+	unsigned int r;
+
+	__FP_UNPACK_D(B, rB);
+	_FP_ROUND_ZERO(2, B);
+	FP_TO_INT_D(r, B, 32, 0);
+	rD[1] = r;
+
+#ifdef DEBUG
+	printk("%s: D %p, B %p: ", __FUNCTION__, rD, rB);
+	dump_double(rD);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/efdnabs.c b/arch/powerpc/math-emu/efdnabs.c
new file mode 100644
index 0000000..f80341d
--- /dev/null
+++ b/arch/powerpc/math-emu/efdnabs.c
@@ -0,0 +1,34 @@
+/*
+ * arch/powerpc/math-emu/efdnabs.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efdnabs"
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
+efdnabs(u32 *rD, u32 *rA)
+{
+	rD[0] = rA[0] | 0x80000000;
+	rD[1] = rA[1];
+
+#ifdef DEBUG
+	printk("%s: D %p, A %p: ", __FUNCTION__, rD, rA);
+	dump_double(rD);
+	printk("\n");
+#endif
+
+	return 0;
+}
-- 
1.4.0
