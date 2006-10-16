Return-Path: <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: New DCR access methods
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 17:44:58 +1000
Message-Id: <1160984698.22522.60.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds new dcr_map/dcr_read/dcr_write accessors for DCRs that
can be used by drivers to transparently address either native DCRs or
memory mapped DCRs. The implementation for memory mapped DCRs is done
after the binding being currently worked on for SLOF and the Axon
chipset. This patch enables it for the cell native platform

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-cell/include/asm-powerpc/dcr.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-powerpc/dcr.h	2006-10-16 16:42:32.000000000 +1000
@@ -0,0 +1,42 @@
+/*
+ * (c) Copyright 2006 Benjamin Herrenschmidt, IBM Corp.
+ *                    <benh@kernel.crashing.org>
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
+#ifdef CONFIG_PPC_DCR_NATIVE
+#include <asm/dcr-native.h>
+#else
+#include <asm/dcr-mmio.h>
+#endif
+
+/*
+ * On CONFIG_PPC_MERGE, we have additional helpers to read the DCR
+ * base from the device-tree
+ */
+#ifdef CONFIG_PPC_MERGE
+extern unsigned int dcr_resource_start(struct device_node *np,
+				       unsigned int index);
+extern unsigned int dcr_resource_len(struct device_node *np,
+				     unsigned int index);
+#endif /* CONFIG_PPC_MERGE */
+
+#endif /* __KERNEL__ */
+#endif /* _ASM_POWERPC_DCR_H */
Index: linux-cell/arch/powerpc/Kconfig
===================================================================
--- linux-cell.orig/arch/powerpc/Kconfig	2006-10-16 15:05:04.000000000 +1000
+++ linux-cell/arch/powerpc/Kconfig	2006-10-16 17:20:38.000000000 +1000
@@ -160,9 +160,11 @@ config PPC_86xx
 
 config 40x
 	bool "AMCC 40x"
+	select PPC_DCR_NATIVE
 
 config 44x
 	bool "AMCC 44x"
+	select PPC_DCR_NATIVE
 
 config 8xx
 	bool "Freescale 8xx"
@@ -208,6 +210,19 @@ config PPC_FPU
 	bool
 	default y if PPC64
 
+config PPC_DCR_NATIVE
+	bool
+	default n
+
+config PPC_DCR_MMIO
+	bool
+	default n
+
+config PPC_DCR
+	bool
+	depends on PPC_DCR_NATIVE || PPC_DCR_MMIO
+	default y
+
 config BOOKE
 	bool
 	depends on E200 || E500
@@ -445,6 +460,7 @@ config PPC_CELL
 config PPC_CELL_NATIVE
 	bool
 	select PPC_CELL
+	select PPC_DCR_MMIO
 	default n
 
 config PPC_IBM_CELL_BLADE
Index: linux-cell/include/asm-powerpc/dcr-mmio.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-powerpc/dcr-mmio.h	2006-10-16 17:20:37.000000000 +1000
@@ -0,0 +1,51 @@
+/*
+ * (c) Copyright 2006 Benjamin Herrenschmidt, IBM Corp.
+ *                    <benh@kernel.crashing.org>
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
+#ifndef _ASM_POWERPC_DCR_MMIO_H
+#define _ASM_POWERPC_DCR_MMIO_H
+#ifdef __KERNEL__
+
+#include <asm/io.h>
+
+typedef struct { void __iomem *token; unsigned int stride; } dcr_host_t;
+
+#define DCR_MAP_OK(host)	((host).token != NULL)
+
+extern dcr_host_t dcr_map(struct device_node *dev, unsigned int dcr_n,
+			  unsigned int dcr_c);
+extern void dcr_unmap(dcr_host_t host, unsigned int dcr_n, unsigned int dcr_c);
+
+static inline u32 dcr_read(dcr_host_t host, unsigned int dcr_n)
+{
+	return in_be32(host.token + dcr_n * host.stride);
+}
+
+static inline void dcr_write(dcr_host_t host, unsigned int dcr_n, u32 value)
+{
+	out_be32(host.token + dcr_n * host.stride, value);
+}
+
+extern u64 of_translate_dcr_address(struct device_node *dev,
+				    unsigned int dcr_n,
+				    unsigned int *stride);
+
+#endif /* __KERNEL__ */
+#endif /* _ASM_POWERPC_DCR_MMIO_H */
+
+
Index: linux-cell/include/asm-powerpc/dcr-native.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-powerpc/dcr-native.h	2006-10-16 15:05:06.000000000 +1000
@@ -0,0 +1,39 @@
+/*
+ * (c) Copyright 2006 Benjamin Herrenschmidt, IBM Corp.
+ *                    <benh@kernel.crashing.org>
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
+#ifndef _ASM_POWERPC_DCR_NATIVE_H
+#define _ASM_POWERPC_DCR_NATIVE_H
+#ifdef __KERNEL__
+
+#include <asm/reg.h>
+
+typedef struct {} dcr_host_t;
+
+#define DCR_MAP_OK(host)	(1)
+
+#define dcr_map(dev, dcr_n, dcr_c)	{}
+#define dcr_unmap(host, dcr_n, dcr_c)	{}
+#define dcr_read(host, dcr_n)		mfdcr(dcr_n)
+#define dcr_write(host, dcr_n, value)	mtdcr(dcr_n, value)
+
+
+#endif /* __KERNEL__ */
+#endif /* _ASM_POWERPC_DCR_NATIVE_H */
+
+
Index: linux-cell/arch/ppc/Kconfig
===================================================================
--- linux-cell.orig/arch/ppc/Kconfig	2006-10-16 15:05:04.000000000 +1000
+++ linux-cell/arch/ppc/Kconfig	2006-10-16 15:05:06.000000000 +1000
@@ -77,9 +77,11 @@ config 6xx
 
 config 40x
 	bool "40x"
+	select PPC_DCR_NATIVE
 
 config 44x
 	bool "44x"
+	select PPC_DCR_NATIVE
 
 config 8xx
 	bool "8xx"
@@ -95,6 +97,15 @@ endchoice
 config PPC_FPU
 	bool
 
+config PPC_DCR_NATIVE
+	bool
+	default n
+
+config PPC_DCR
+	bool
+	depends on PPC_DCR_NATIVE
+	default y
+
 config BOOKE
 	bool
 	depends on E200 || E500
Index: linux-cell/arch/powerpc/kernel/Makefile
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/Makefile	2006-10-16 15:05:04.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/Makefile	2006-10-16 15:05:06.000000000 +1000
@@ -60,6 +60,7 @@ obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_PPC_UDBG_16550)	+= legacy_serial.o udbg_16550.o
+
 module-$(CONFIG_PPC64)		+= module_64.o
 obj-$(CONFIG_MODULES)		+= $(module-y)
 
Index: linux-cell/arch/powerpc/sysdev/Makefile
===================================================================
--- linux-cell.orig/arch/powerpc/sysdev/Makefile	2006-10-16 15:05:04.000000000 +1000
+++ linux-cell/arch/powerpc/sysdev/Makefile	2006-10-16 15:05:06.000000000 +1000
@@ -5,8 +5,7 @@ endif
 obj-$(CONFIG_MPIC)		+= mpic.o
 obj-$(CONFIG_PPC_INDIRECT_PCI)	+= indirect_pci.o
 obj-$(CONFIG_PPC_MPC106)	+= grackle.o
-obj-$(CONFIG_BOOKE)		+= dcr.o
-obj-$(CONFIG_40x)		+= dcr.o
+obj-$(CONFIG_PPC_DCR)		+= dcr.o dcr-low.o
 obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
Index: linux-cell/arch/powerpc/sysdev/dcr-low.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/arch/powerpc/sysdev/dcr-low.S	2006-10-16 15:05:06.000000000 +1000
@@ -0,0 +1,39 @@
+/*
+ * "Indirect" DCR access
+ *
+ * Copyright (c) 2004 Eugene Surovegin <ebs@ebshome.net>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under  the terms of  the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <asm/ppc_asm.h>
+#include <asm/processor.h>
+
+#define DCR_ACCESS_PROLOG(table) \
+	rlwinm  r3,r3,4,18,27;   \
+	lis     r5,table@h;      \
+	ori     r5,r5,table@l;   \
+	add     r3,r3,r5;        \
+	mtctr   r3;              \
+	bctr
+
+_GLOBAL(__mfdcr)
+	DCR_ACCESS_PROLOG(__mfdcr_table)
+
+_GLOBAL(__mtdcr)
+	DCR_ACCESS_PROLOG(__mtdcr_table)
+
+__mfdcr_table:
+	mfdcr  r3,0; blr
+__mtdcr_table:
+	mtdcr  0,r4; blr
+
+dcr     = 1
+        .rept   1023
+	mfdcr   r3,dcr; blr
+	mtdcr   dcr,r4; blr
+	dcr     = dcr + 1
+	.endr
Index: linux-cell/arch/powerpc/sysdev/dcr.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/arch/powerpc/sysdev/dcr.c	2006-10-16 17:21:01.000000000 +1000
@@ -0,0 +1,134 @@
+/*
+ * (c) Copyright 2006 Benjamin Herrenschmidt, IBM Corp.
+ *                    <benh@kernel.crashing.org>
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
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <asm/prom.h>
+#include <asm/dcr.h>
+
+unsigned int dcr_resource_start(struct device_node *np, unsigned int index)
+{
+	unsigned int ds;
+	const u32 *dr = get_property(np, "dcr-reg", &ds);
+
+	if (dr == NULL || ds & 1 || index >= (ds / 8))
+		return -EINVAL;
+
+	return dr[index * 2];
+}
+
+unsigned int dcr_resource_len(struct device_node *np, unsigned int index)
+{
+	unsigned int ds;
+	const u32 *dr = get_property(np, "dcr-reg", &ds);
+
+	if (dr == NULL || ds & 1 || index >= (ds / 8))
+		return -EINVAL;
+
+	return dr[index * 2 + 1];
+}
+
+#ifndef CONFIG_PPC_DCR_NATIVE
+
+static struct device_node * find_dcr_parent(struct device_node * node)
+{
+	struct device_node *par, *tmp;
+	const u32 *p;
+
+	for (par = of_node_get(node); par;) {
+		if (get_property(par, "dcr-controller", NULL))
+		    break;
+		p = get_property(par, "dcr-parent", NULL);
+		tmp = par;
+		if (p == NULL)
+			par = of_get_parent(par);
+		else
+			par = of_find_node_by_phandle(*p);
+		of_node_put(tmp);
+	}
+	return par;
+}
+
+u64 of_translate_dcr_address(struct device_node *dev,
+			     unsigned int dcr_n,
+			     unsigned int *stride)
+{
+	struct device_node *dp;
+	const u32 *p;
+	u64 ret;
+
+	dp = find_dcr_parent(dev);
+	if (dp == NULL)
+		return OF_BAD_ADDR;
+
+	/* Stride is not properly defined yet, default to 0x10 for Axon */
+	p = get_property(dp, "dcr-mmio-stride", NULL);
+	*stride = (p == NULL) ? 0x10 : *p;
+
+	/* XXX FIXME: Which property name is to use of the 2 following ? */
+	p = get_property(dp, "dcr-mmio-range", NULL);
+	if (p == NULL)
+		p = get_property(dp, "dcr-mmio-space", NULL);
+	if (p == NULL)
+		return OF_BAD_ADDR;
+
+	/* Maybe could do some better range checking here */
+	ret = of_translate_address(dp, p);
+	if (ret != OF_BAD_ADDR)
+		ret += (u64)(*stride) * (u64)dcr_n;
+	return ret;
+}
+
+dcr_host_t dcr_map(struct device_node *dev, unsigned int dcr_n,
+		   unsigned int dcr_c)
+{
+	dcr_host_t ret = { .token = NULL, .stride = 0 };
+	u64 addr;
+
+	pr_debug("dcr_map(%s, 0x%x, 0x%x)\n",
+		 dev->full_name, dcr_n, dcr_c);
+
+	addr = of_translate_dcr_address(dev, dcr_n, &ret.stride);
+	pr_debug("translates to addr: 0x%lx, stride: 0x%x\n",
+		 addr, ret.stride);
+	if (addr == OF_BAD_ADDR)
+		return ret;
+	pr_debug("mapping 0x%x bytes\n", dcr_c * ret.stride);
+	ret.token = ioremap(addr, dcr_c * ret.stride);
+	if (ret.token == NULL)
+		return ret;
+	pr_debug("mapped at 0x%p -> base is 0x%p\n",
+		 ret.token, ret.token - dcr_n * ret.stride);
+	ret.token -= dcr_n * ret.stride;
+	return ret;
+}
+
+void dcr_unmap(dcr_host_t host, unsigned int dcr_n, unsigned int dcr_c)
+{
+	dcr_host_t h = host;
+
+	if (h.token == NULL)
+		return;
+	h.token -= dcr_n * h.stride;
+	iounmap(h.token);
+	h.token = NULL;
+}
+
+#endif /* !defined(CONFIG_PPC_DCR_NATIVE) */
