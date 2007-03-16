Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 16FF3DDF0A
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 04:28:02 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l2GHRwNI014011
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 10:27:59 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2GHRwBB019226
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:27:58 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l2GH8Gro001311
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:08:17 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 79B9CAEFC9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:27:57 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l2GHRv09029802
	for linuxppc-dev@ozlabs.org; Fri, 16 Mar 2007 12:27:57 -0500
Date: Fri, 16 Mar 2007 12:27:57 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/17] bootwrapper: Add xlate_reg(),
	and use it to find serial registers.
Message-ID: <20070316172757.GC29784@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

xlate_reg() uses the ranges properties of a node's parentage to find the
absolute physical address of the node's registers.

The ns16550 driver uses this when no virtual-reg property is found.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
This is the same as the previous xlate_reg patch; it's included
in this patchset because it must be applied after the dt_ops
patch and before the dt_set_memory patch.

 arch/powerpc/boot/Makefile  |    2 +-
 arch/powerpc/boot/devtree.c |  207 +++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/ns16550.c |    9 ++-
 arch/powerpc/boot/ops.h     |    1 +
 4 files changed, 216 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/boot/devtree.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index b1fc029..55da383 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -42,7 +42,7 @@ $(addprefix $(obj)/,$(zlib) main.o): $(addprefix $(obj)/,$(zliblinuxheader)) \
 
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
-		gunzip_util.c $(zlib)
+		gunzip_util.c devtree.c $(zlib)
 src-plat := of.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
diff --git a/arch/powerpc/boot/devtree.c b/arch/powerpc/boot/devtree.c
new file mode 100644
index 0000000..9fee6fb
--- /dev/null
+++ b/arch/powerpc/boot/devtree.c
@@ -0,0 +1,207 @@
+/*
+ * Device Tree functions that are semantic, not structural
+ *
+ * Author: Scott Wood <scottwood@freescale.com>
+ *
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "string.h"
+
+#define MAX_ADDR_CELLS 4
+#define MAX_RANGES 8
+
+static int get_reg_format(void *node, u32 *naddr, u32 *nsize)
+{
+	int got_addr = 0, got_size = 0;
+
+	while (node && !(got_addr && got_size)) {
+		if (!got_addr && getprop(node, "#address-cells",
+		                         naddr, 4) == 4)
+			got_addr = 1;
+		if (!got_size && getprop(node, "#size-cells",
+		                         nsize, 4) == 4)
+			got_size = 1;
+
+		node = get_parent(node);
+	}
+
+	if (*naddr <= 0 || *naddr > MAX_ADDR_CELLS ||
+	    *nsize <= 0 || *nsize > *naddr)
+		return 0;
+
+	return got_addr && got_size;
+}
+
+static int sub_reg(u32 *reg, u32 *sub, u32 naddr)
+{
+	int i, borrow = 0;
+
+	for (i = 0; i < naddr; i++) {
+		int prev_borrow = borrow;
+		borrow = reg[i] < sub[i] + prev_borrow;
+		reg[i] -= sub[i] + prev_borrow;
+	}
+
+	return !borrow;
+}
+
+static int add_reg(u32 *reg, u32 *add, u32 naddr, u32 naddr_add)
+{
+	int i, carry = 0;
+	int diff = naddr - naddr_add;
+
+	if (diff < 0) {
+		for (i = 0; i < -diff; i++)
+			if (*add++ != 0)
+				return 0;
+
+		diff = 0;
+	}
+
+	for (i = diff; i < naddr; i++) {
+		u64 tmp = (u64)reg[i] + add[i - diff] + carry;
+		carry = tmp >> 32;
+		reg[i] = (u32)tmp;
+	}
+
+	return !carry;
+}
+
+/* It is assumed that if the first byte of reg fits in a
+ * range, then the whole reg block fits.  It is also assumed
+ * that #size-cells <= #address-cells.
+ */
+static int compare_reg(u32 *reg, u32 *range, u32 *rangesize,
+                       u32 naddr, u32 nsize)
+{
+	int i, sizeoff = naddr - nsize;
+
+	for (i = 0; i < naddr; i++) {
+		if (reg[i] < range[i])
+			return 0;
+		if (reg[i] > range[i])
+			break;
+	}
+
+	for (i = sizeoff; i < naddr; i++) {
+		u32 end = range[i] + rangesize[i - sizeoff];
+
+		if (reg[i] < end)
+			break;
+		if (reg[i] > end)
+			return 0;
+		if (i == naddr && reg[i] == end)
+			return 0;
+	}
+
+	return 1;
+}
+
+static int find_range(u32 *reg, u32 *ranges, int naddr,
+                      int nsize, int nparentaddr, int buflen)
+{
+	int nrange = naddr + nparentaddr + nsize;
+	int i;
+
+	for (i = 0; i + nrange <= buflen; i += nrange) {
+		if (compare_reg(reg, ranges + i,
+		                ranges + i + naddr + nparentaddr,
+		                naddr, nsize))
+			return i;
+	}
+
+	return -1;
+}
+
+/* Currently only generic buses without special encodings are supported.
+ * In particular, PCI is not supported.  Also, only the beginning of the
+ * reg block is tracked; size is ignored except in ranges.
+ */
+int xlate_reg(void *node, int res, unsigned long *addr,
+              unsigned long *size)
+{
+	u32 last_addr[MAX_ADDR_CELLS];
+	u32 buf[MAX_ADDR_CELLS * MAX_RANGES * 3];
+	void *parent;
+	u64 ret_addr, ret_size;
+	u32 naddr, nsize, prev_naddr, prev_nsize;
+	int buflen, offset;
+
+	parent = get_parent(node);
+	if (!parent)
+		return 0;
+
+	if (!get_reg_format(parent, &naddr, &nsize))
+		return 0;
+
+	if (nsize > 2)
+		return 0;
+
+	buflen = getprop(node, "reg", buf, sizeof(buf)) / 4;
+	offset = (naddr + nsize) * res;
+
+	if (buflen < offset + naddr + nsize)
+		return 0;
+
+	memcpy(last_addr, buf + offset, 4 * naddr);
+
+	ret_size = buf[offset + naddr];
+	if (nsize == 2) {
+		ret_size <<= 32;
+		ret_size |= buf[offset + naddr + 1];
+	}
+
+	while ((node = get_parent(node))) {
+		prev_naddr = naddr;
+		prev_nsize = nsize;
+
+		if (!get_reg_format(node, &naddr, &nsize))
+			return 0;
+
+		buflen = getprop(node, "ranges",
+		                        buf, sizeof(buf));
+		if (buflen < 0)
+			continue;
+		if (buflen > sizeof(buf))
+			return 0;
+
+		offset = find_range(last_addr, buf, prev_naddr,
+		                    prev_nsize, naddr, buflen / 4);
+
+		if (offset < 0)
+			return 0;
+
+		if (!sub_reg(last_addr, buf + offset, prev_naddr) ||
+		    !add_reg(buf + offset + prev_naddr, last_addr,
+		             naddr, prev_naddr))
+			return 0;
+
+		memcpy(last_addr, buf + offset + prev_naddr, 4 * naddr);
+	}
+
+	if (naddr > 2)
+		return 0;
+
+	ret_addr = last_addr[0];
+	if (naddr == 2) {
+		ret_addr <<= 32;
+		ret_addr |= last_addr[1];
+	}
+
+	if (sizeof(void *) == 4 &&
+	    (ret_addr >= 0x100000000ULL || ret_size > 0x100000000ULL ||
+	     ret_addr + ret_size > 0x100000000ULL))
+		return 0;
+
+	*addr = ret_addr;
+	if (size)
+		*size = ret_size;
+
+	return 1;
+}
diff --git a/arch/powerpc/boot/ns16550.c b/arch/powerpc/boot/ns16550.c
index 1ffe72e..cce7a11 100644
--- a/arch/powerpc/boot/ns16550.c
+++ b/arch/powerpc/boot/ns16550.c
@@ -55,10 +55,15 @@ static u8 ns16550_tstc(void)
 int ns16550_console_init(void *devp, struct serial_console_data *scdp)
 {
 	int n;
+	unsigned long reg_phys;
 
 	n = getprop(devp, "virtual-reg", &reg_base, sizeof(reg_base));
-	if (n != sizeof(reg_base))
-		return -1;
+	if (n != sizeof(reg_base)) {
+		if (!xlate_reg(devp, 0, &reg_phys, NULL))
+			return -1;
+
+		reg_base = (void *)reg_phys;
+	}
 
 	n = getprop(devp, "reg-shift", &reg_shift, sizeof(reg_shift));
 	if (n != sizeof(reg_shift))
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index dae0e3b..086f844 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -79,6 +79,7 @@ int serial_console_init(void);
 int ns16550_console_init(void *devp, struct serial_console_data *scdp);
 void *simple_alloc_init(char *base, u32 heap_size, u32 granularity,
 		u32 max_allocs);
+int xlate_reg(void *node, int res, unsigned long *addr, unsigned long *size);
 
 
 static inline void *finddevice(const char *name)
-- 
1.5.0.3
