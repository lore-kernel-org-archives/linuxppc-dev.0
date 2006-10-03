Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4660C67C18
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 16:05:08 +1000 (EST)
Subject: [PATCH] powerpc: Generic DCR access
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 16:04:38 +1000
Message-Id: <1159855478.5482.46.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This defines new "generic" access functions for DCRs that can be used
both on platforms with hardware DCR support (4xx processors) and
platforms where the DCRs are memory mapped. The 4xx versions are
implemented inline. The memory mapped versions will be implemented
separately as platforms support for them gets added.

From: Shaun Wetzstein <shaun@us.ibm.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-cell/include/asm-powerpc/dcr.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-powerpc/dcr.h	2006-09-22 13:25:58.000000000 +1000
@@ -0,0 +1,56 @@
+/*
+ *   Copyright (c) International Business Machines Corp., 2006
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef _ASM_POWERPC_DCR_H
+#define _ASM_POWERPC_DCR_H
+#ifdef __KERNEL__
+
+#include <asm/of_device.h>
+
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+inline void *dcr_find_controller(struct device_node *node)
+
+{
+	return NULL;
+}
+
+#include <asm/reg.h>
+
+inline u32 dcr_read(void *, int dcr_n)
+{
+	return mfdcr(dcr_n);
+}
+
+inline void dcr_write(void *, int dcr_n, u32 value)
+{
+	mtdcr(dcr_n, value);
+}
+#else /* for systems without mtdcr/mfdcr */
+
+/*
+    given a DCR based device node, search up the dt for the
+    "owning" dcr controller node and return its token
+*/
+extern void *dcr_find_controller(struct device_node *);
+
+extern u32 dcr_read(void *, int);
+extern void dcr_write(void *, int, u32);
+#endif
+
+#endif /* __KERNEL__ */
+#endif /* _ASM_POWERPC_DCR_H */
Index: linux-cell/arch/powerpc/Kconfig
===================================================================
--- linux-cell.orig/arch/powerpc/Kconfig	2006-09-22 13:25:56.000000000 +1000
+++ linux-cell/arch/powerpc/Kconfig	2006-09-22 13:30:25.000000000 +1000
@@ -160,9 +160,11 @@ config PPC_86xx
 
 config 40x
 	bool "AMCC 40x"
+	select PPC_DCR
 
 config 44x
 	bool "AMCC 44x"
+	select PPC_DCR
 
 config 8xx
 	bool "Freescale 8xx"
@@ -424,6 +426,7 @@ config PPC_CELL
 config PPC_CELL_NATIVE
 	bool
 	select PPC_CELL
+	select PPC_DCR
 	default n
 
 config PPC_IBM_CELL_BLADE
@@ -476,6 +479,10 @@ config MPIC_BROKEN_U3
 	depends on PPC_MAPLE
 	default y
 
+config PPC_DCR
+	bool
+	default n
+
 config IBMVIO
 	depends on PPC_PSERIES || PPC_ISERIES
 	bool
