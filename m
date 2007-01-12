Return-Path: <ebony.zhu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 1EDA2DDE07
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 16:20:38 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l0C5KbuI010331
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 22:20:37 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0C5KWQE014041
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 23:20:34 -0600 (CST)
To: paulus@samba.org
Subject: [patch][1/5] powerpc: Add the implementations to handle SPFP
	instruction exceptions
From: ebony.zhu@freescale.com
Message-ID: <ZCH01EXM20P1A83xiDd000006f4@zch01exm20.fsl.freescale.net>
Date: 12 Jan 2007 13:20:31 +0800
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the implementations to handle SPFP instruction exceptions
complying with IEEE-754.

Signed-off-by:Ebony Zhu <ebony.zhu@freescale.com>
---
 arch/powerpc/math-emu/efsabs.c   |   32 ++++++++++++++++++++
 arch/powerpc/math-emu/efsadd.c   |   51 ++++++++++++++++++++++++++++++++
 arch/powerpc/math-emu/efscfd.c   |   52 +++++++++++++++++++++++++++++++++
 arch/powerpc/math-emu/efscmpeq.c |   60 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/math-emu/efscmpgt.c |   60 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/math-emu/efscmplt.c |   60 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/math-emu/efsctsf.c  |   44 ++++++++++++++++++++++++++++
 arch/powerpc/math-emu/efsctsi.c  |   41 ++++++++++++++++++++++++++
 arch/powerpc/math-emu/efsctsiz.c |   41 ++++++++++++++++++++++++++
 arch/powerpc/math-emu/efsctuf.c  |   43 +++++++++++++++++++++++++++
 arch/powerpc/math-emu/efsctui.c  |   41 ++++++++++++++++++++++++++
 arch/powerpc/math-emu/efsctuiz.c |   41 ++++++++++++++++++++++++++
 arch/powerpc/math-emu/efsdiv.c   |   51 ++++++++++++++++++++++++++++++++
 arch/powerpc/math-emu/efsmul.c   |   55 +++++++++++++++++++++++++++++++++++
 arch/powerpc/math-emu/efsnabs.c  |   32 ++++++++++++++++++++
 arch/powerpc/math-emu/efsneg.c   |   32 ++++++++++++++++++++
 arch/powerpc/math-emu/efssub.c   |   54 ++++++++++++++++++++++++++++++++++
 17 files changed, 790 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/math-emu/efsabs.c b/arch/powerpc/math-emu/efsabs.c
new file mode 100644
index 0000000..d56acc0
--- /dev/null
+++ b/arch/powerpc/math-emu/efsabs.c
@@ -0,0 +1,32 @@
+/*
+ * arch/powerpc/math-emu/efsabs.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efsabs"
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
+efsabs(u32 *rD, u32 *rA)
+{
+	rD[0] = rA[0] & 0x7fffffff;
+
+#ifdef DEBUG
+	printk("%s: D %p, A %p: ", __FUNCTION__, rD, rA);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/efsadd.c b/arch/powerpc/math-emu/efsadd.c
new file mode 100644
index 0000000..fbf28a6
--- /dev/null
+++ b/arch/powerpc/math-emu/efsadd.c
@@ -0,0 +1,51 @@
+/*
+ * arch/powerpc/math-emu/efsadd.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efsadd"
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
+efsadd(void *rD, void *rA, void *rB)
+{
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(R);
+	int ret = 0;
+
+#ifdef DEBUG
+	printk("%s: %p %p %p\n", __FUNCTION__, rD, rA, rB);
+#endif
+
+	__FP_UNPACK_S(A, rA);
+	__FP_UNPACK_S(B, rB);
+
+#ifdef DEBUG
+	printk("A: %ld %lu %ld (%ld)\n", A_s, A_f, A_e, A_c);
+	printk("B: %ld %lu %ld (%ld)\n", B_s, B_f, B_e, B_c);
+#endif
+
+	FP_ADD_S(R, A, B);
+
+#ifdef DEBUG
+	printk("D: %ld %lu %ld (%ld)\n", R_s, R_f, R_e, R_c);
+#endif
+
+	return (ret | __FP_PACK_S(rD, R));
+}
diff --git a/arch/powerpc/math-emu/efscfd.c b/arch/powerpc/math-emu/efscfd.c
new file mode 100644
index 0000000..7429e30
--- /dev/null
+++ b/arch/powerpc/math-emu/efscfd.c
@@ -0,0 +1,52 @@
+/*
+ * arch/powerpc/math-emu/efscfd.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efscfd"
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
+efscfd(void *rD, u64 *rB)
+{
+	FP_DECL_D(B);
+	FP_DECL_S(R);
+	int ret;
+	u32 tmp;
+	tmp = rB[0] >> 32;
+	rB[0] = rB[0] <<32 | tmp;
+
+#ifdef DEBUG
+	printk("%s: S %p, ea %p\n", __FUNCTION__, rD, rB);
+#endif
+
+	__FP_UNPACK_D(B, rB);
+
+#ifdef DEBUG
+	printk("B: %ld %lu %lu %ld (%ld)\n", B_s, B_f1, B_f0, B_e, B_c);
+#endif
+
+	FP_CONV(S, D, 1, 2, R, B);
+
+#ifdef DEBUG
+	printk("R: %ld %lu %ld (%ld)\n", R_s, R_f, R_e, R_c);
+#endif
+
+	return (ret | __FP_PACK_S(rD, R));
+}
diff --git a/arch/powerpc/math-emu/efscmpeq.c b/arch/powerpc/math-emu/efscmpeq.c
new file mode 100644
index 0000000..cbbb583
--- /dev/null
+++ b/arch/powerpc/math-emu/efscmpeq.c
@@ -0,0 +1,60 @@
+/*
+ * arch/powerpc/math-emu/efscmpeq.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efscmpeq"
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
+efscmpeq(u32 *ccr, int crD, void *rA, void *rB)
+{
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	long cmp;
+	int ret = 0;
+
+#ifdef DEBUG
+	printk("%s: %p (%08x) %d %p %p\n", __FUNCTION__, ccr, *ccr, crD, rA, rB);
+#endif
+
+	__FP_UNPACK_S(A, rA);
+	__FP_UNPACK_S(B, rB);
+
+#ifdef DEBUG
+	printk("A: %ld %lu %ld (%ld)\n", A_s, A_f, A_e, A_c);
+	printk("B: %ld %lu %ld (%ld)\n", B_s, B_f, B_e, B_c);
+#endif
+
+	FP_CMP_S(cmp, A, B, 2);
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
diff --git a/arch/powerpc/math-emu/efscmpgt.c b/arch/powerpc/math-emu/efscmpgt.c
new file mode 100644
index 0000000..dce60fc
--- /dev/null
+++ b/arch/powerpc/math-emu/efscmpgt.c
@@ -0,0 +1,60 @@
+/*
+ * arch/powerpc/math-emu/efscmpgt.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efscmpgt"
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
+efscmpgt(u32 *ccr, int crD, void *rA, void *rB)
+{
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	long cmp;
+	int ret = 0;
+
+#ifdef DEBUG
+	printk("%s: %p (%08x) %d %p %p\n", __FUNCTION__, ccr, *ccr, crD, rA, rB);
+#endif
+
+	__FP_UNPACK_S(A, rA);
+	__FP_UNPACK_S(B, rB);
+
+#ifdef DEBUG
+	printk("A: %ld %lu %ld (%ld)\n", A_s, A_f, A_e, A_c);
+	printk("B: %ld %lu %ld (%ld)\n", B_s, B_f, B_e, B_c);
+#endif
+
+	FP_CMP_S(cmp, A, B, 2);
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
diff --git a/arch/powerpc/math-emu/efscmplt.c b/arch/powerpc/math-emu/efscmplt.c
new file mode 100644
index 0000000..54991b1
--- /dev/null
+++ b/arch/powerpc/math-emu/efscmplt.c
@@ -0,0 +1,60 @@
+/*
+ * arch/powerpc/math-emu/efscmplt.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efscmplt"
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
+efscmplt(u32 *ccr, int crD, void *rA, void *rB)
+{
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	long cmp;
+	int ret = 0;
+
+#ifdef DEBUG
+	printk("%s: %p (%08x) %d %p %p\n", __FUNCTION__, ccr, *ccr, crD, rA, rB);
+#endif
+
+	__FP_UNPACK_S(A, rA);
+	__FP_UNPACK_S(B, rB);
+
+#ifdef DEBUG
+	printk("A: %ld %lu %ld (%ld)\n", A_s, A_f, A_e, A_c);
+	printk("B: %ld %lu %ld (%ld)\n", B_s, B_f, B_e, B_c);
+#endif
+
+	FP_CMP_S(cmp, A, B, 2);
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
diff --git a/arch/powerpc/math-emu/efsctsf.c b/arch/powerpc/math-emu/efsctsf.c
new file mode 100644
index 0000000..9c8ce23
--- /dev/null
+++ b/arch/powerpc/math-emu/efsctsf.c
@@ -0,0 +1,44 @@
+/*
+ * arch/powerpc/math-emu/efsctsf.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efsctsf"
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
+efsctsf(u32 *rD, u32 *rB)
+{
+	if (!((rB[0] >> 23) == 0xff && ((rB[0] & 0x7fffff) > 0))) {/* Not an NaN */
+		if (((rB[0] >> 23) & 0xff) == 0 ) { /* rB is Denorm */
+			rD[0] = 0x0;
+		} else if ((rB[0] >> 31) == 0) { /* rB is positive normal */
+			rD[0] = 0x7fffffff;
+		} else { /* rB is negative normal */
+			rD[0] = 0x80000000;
+		}
+	} else { /* rB is NaN */
+		rD[0] = 0x0;
+	}
+#ifdef DEBUG
+	printk("%s: D %p, B %p: ", __FUNCTION__, rD, rB);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/efsctsi.c b/arch/powerpc/math-emu/efsctsi.c
new file mode 100644
index 0000000..b25113e
--- /dev/null
+++ b/arch/powerpc/math-emu/efsctsi.c
@@ -0,0 +1,41 @@
+/*
+ * arch/powerpc/math-emu/efsctsi.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efsctsi"
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
+efsctsi(u32 *rD, void *rB)
+{
+	FP_DECL_S(B);
+	unsigned int r;
+
+	__FP_UNPACK_S(B, rB);
+	_FP_ROUND(1, B);
+	FP_TO_INT_S(r, B, 32, 1);
+	rD[0] = r;
+
+#ifdef DEBUG
+	printk("%s: D %p, B %p: ", __FUNCTION__, rD, rB);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/efsctsiz.c b/arch/powerpc/math-emu/efsctsiz.c
new file mode 100644
index 0000000..aa46f18
--- /dev/null
+++ b/arch/powerpc/math-emu/efsctsiz.c
@@ -0,0 +1,41 @@
+/*
+ * arch/powerpc/math-emu/efsctsiz.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efsctsiz"
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
+efsctsiz(u32 *rD, void *rB)
+{
+	FP_DECL_S(B);
+	unsigned int r;
+
+	__FP_UNPACK_S(B, rB);
+	_FP_ROUND_ZERO(1, B);
+	FP_TO_INT_S(r, B, 32, 1);
+	rD[0] = r;
+
+#ifdef DEBUG
+	printk("%s: D %p, B %p: ", __FUNCTION__, rD, rB);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/efsctuf.c b/arch/powerpc/math-emu/efsctuf.c
new file mode 100644
index 0000000..a7db080
--- /dev/null
+++ b/arch/powerpc/math-emu/efsctuf.c
@@ -0,0 +1,43 @@
+/*
+ * arch/powerpc/math-emu/efsctuf.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efsctuf"
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
+efsctuf(u32 *rD, u32 *rB)
+{
+        if (!((rB[0] >> 23) == 0xff && ((rB[0] & 0x7fffff) > 0 )) /* Not an NaN */
+	    && (rB[0] >> 31) == 0) { /* rB is positive */
+		if (((rB[0] >> 23) & 0xff) == 0 ) { /* rB is Denorm */
+			rD[0] = 0x0;
+		} else { /* rB is normal */
+			rD[0] = 0xffffffff;
+		}
+        } else { /* rB < 0 or rB is NaN */
+		rD[0] = 0x0;
+	}
+#ifdef DEBUG
+	printk("%s: D %p, B %p: ", __FUNCTION__, rD, rB);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/efsctui.c b/arch/powerpc/math-emu/efsctui.c
new file mode 100644
index 0000000..4e6a802
--- /dev/null
+++ b/arch/powerpc/math-emu/efsctui.c
@@ -0,0 +1,41 @@
+/*
+ * arch/powerpc/math-emu/efsctui.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efsctui"
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
+efsctui(u32 *rD, void *rB)
+{
+	FP_DECL_S(B);
+	unsigned int r;
+
+	__FP_UNPACK_S(B, rB);
+	_FP_ROUND(1, B);
+	FP_TO_INT_S(r, B, 32, 0);
+	rD[0] = r;
+
+#ifdef DEBUG
+	printk("%s: D %p, B %p: ", __FUNCTION__, rD, rB);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/efsctuiz.c b/arch/powerpc/math-emu/efsctuiz.c
new file mode 100644
index 0000000..f016ab0
--- /dev/null
+++ b/arch/powerpc/math-emu/efsctuiz.c
@@ -0,0 +1,41 @@
+/*
+ * arch/powerpc/math-emu/efsctuiz.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efsctuiz"
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
+efsctuiz(u32 *rD, void *rB)
+{
+	FP_DECL_S(B);
+	unsigned int r;
+
+	__FP_UNPACK_S(B, rB);
+	_FP_ROUND_ZERO(1, B);
+	FP_TO_INT_S(r, B, 32, 0);
+	rD[0] = r;
+
+#ifdef DEBUG
+	printk("%s: D %p, B %p: ", __FUNCTION__, rD, rB);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/efsdiv.c b/arch/powerpc/math-emu/efsdiv.c
new file mode 100644
index 0000000..682293b
--- /dev/null
+++ b/arch/powerpc/math-emu/efsdiv.c
@@ -0,0 +1,51 @@
+/*
+ * arch/powerpc/math-emu/efsdiv.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efsdiv"
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
+efsdiv(void *rD, void *rA, void *rB)
+{
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(R);
+	int ret = 0;
+
+#ifdef DEBUG
+	printk("%s: %p %p %p\n", __FUNCTION__, rD, rA, rB);
+#endif
+
+	__FP_UNPACK_S(A, rA);
+	__FP_UNPACK_S(B, rB);
+
+#ifdef DEBUG
+	printk("A: %ld %lu %ld (%ld)\n", A_s, A_f, A_e, A_c);
+	printk("B: %ld %lu %ld (%ld)\n", B_s, B_f, B_e, B_c);
+#endif
+
+	FP_DIV_S(R, A, B);
+
+#ifdef DEBUG
+	printk("D: %ld %lu %ld (%ld)\n", R_s, R_f, R_e, R_c);
+#endif
+
+	return (ret | __FP_PACK_S(rD, R));
+}
diff --git a/arch/powerpc/math-emu/efsmul.c b/arch/powerpc/math-emu/efsmul.c
new file mode 100644
index 0000000..e812ce7
--- /dev/null
+++ b/arch/powerpc/math-emu/efsmul.c
@@ -0,0 +1,55 @@
+/*
+ * arch/powerpc/math-emu/efsmul.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efsmul"
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
+efsmul(void *rD, void *rA, void *rB)
+{
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(R);
+	int ret = 0;
+
+#ifdef DEBUG
+	printk("%s: %p %p %p\n", __FUNCTION__, rD, rA, rB);
+#endif
+
+	__FP_UNPACK_S(A, rA);
+	__FP_UNPACK_S(B, rB);
+
+#ifdef DEBUG
+        printk("A: %ld %lu %ld (%ld) [%08lx %lx]\n",
+               A_s, A_f, A_e, A_c, A_f, A_e + 127);
+        printk("B: %ld %lu %ld (%ld) [%08lx %lx]\n",
+               B_s, B_f, B_e, B_c, B_f, B_e + 127);
+#endif
+	
+	FP_MUL_S(R, A, B);
+
+#ifdef DEBUG
+	printk("D: %ld %lu %ld (%ld) [%08lx %lx]\n",
+	       R_s, R_f, R_e, R_c, R_f, R_e + 127);
+#endif
+
+	return (ret | __FP_PACK_S(rD, R));
+}
+
diff --git a/arch/powerpc/math-emu/efsnabs.c b/arch/powerpc/math-emu/efsnabs.c
new file mode 100644
index 0000000..95b9d77
--- /dev/null
+++ b/arch/powerpc/math-emu/efsnabs.c
@@ -0,0 +1,32 @@
+/*
+ * arch/powerpc/math-emu/efsnabs.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efsnabs"
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
+efsnabs(u32 *rD, u32 *rA)
+{
+	rD[0] = rA[0] | 0x80000000;
+
+#ifdef DEBUG
+	printk("%s: D %p, A %p: ", __FUNCTION__, rD, rA);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/efsneg.c b/arch/powerpc/math-emu/efsneg.c
new file mode 100644
index 0000000..6ff343d
--- /dev/null
+++ b/arch/powerpc/math-emu/efsneg.c
@@ -0,0 +1,32 @@
+/*
+ * arch/powerpc/math-emu/efsneg.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efsneg"
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
+efsneg(u32 *rD, u32 *rA)
+{
+	rD[0] = rA[0] ^ 0x80000000;
+
+#ifdef DEBUG
+	printk("%s: D %p, A %p: ", __FUNCTION__, rD, rA);
+	printk("\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/efssub.c b/arch/powerpc/math-emu/efssub.c
new file mode 100644
index 0000000..15675b9
--- /dev/null
+++ b/arch/powerpc/math-emu/efssub.c
@@ -0,0 +1,54 @@
+/*
+ * arch/powerpc/math-emu/efssub.c
+ * 
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
+ * 
+ * Author: Ebony Zhu, ebony.zhu@freescale.com
+ * 
+ * Description:
+ * This file is the implementation of SPE instruction "efssub"
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
+efssub(void *rD, void *rA, void *rB)
+{
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(R);
+	int ret = 0;
+
+#ifdef DEBUG
+	printk("%s: %p %p %p\n", __FUNCTION__, rD, rA, rB);
+#endif
+
+	__FP_UNPACK_S(A, rA);
+	__FP_UNPACK_S(B, rB);
+
+#ifdef DEBUG
+	printk("A: %ld %lu %ld (%ld)\n", A_s, A_f, A_e, A_c);
+	printk("B: %ld %lu %ld (%ld)\n", B_s, B_f, B_e, B_c);
+#endif
+
+	if (B_c != FP_CLS_NAN)
+		B_s ^= 1;
+
+	FP_ADD_S(R, A, B);
+
+#ifdef DEBUG
+	printk("D: %ld %lu %ld (%ld)\n", R_s, R_f, R_e, R_c);
+#endif
+
+	return (ret | __FP_PACK_S(rD, R));
+}
-- 
1.4.0
