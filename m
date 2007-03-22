Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CD445DDFB0
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 06:49:23 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l2MJnIfY002153
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 12:49:19 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l2MJnIVE024984
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 14:49:18 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l2MJTMlG004501
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 14:29:22 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 68618AEFC9
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 14:49:17 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l2MJnHMN031975
	for linuxppc-dev@ozlabs.org; Thu, 22 Mar 2007 14:49:17 -0500
Date: Thu, 22 Mar 2007 14:49:17 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/6] bootwrapper: Add dt_xlate_reg(),
	and use it to find serial registers.
Message-ID: <20070322194917.GA31965@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070322194627.GA31926@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

dt_xlate_reg() uses the ranges properties of a node's parentage to find
the absolute physical address of the node's registers.

The ns16550 driver uses this when no virtual-reg property is found.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
This version's a little smaller, simpler, and more correct than the last
one.

 arch/powerpc/boot/devtree.c |  178 +++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/ns16550.c |    9 ++-
 arch/powerpc/boot/ops.h     |    2 +
 3 files changed, 187 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/devtree.c b/arch/powerpc/boot/devtree.c
index 708cade..23492d7 100644
--- a/arch/powerpc/boot/devtree.c
+++ b/arch/powerpc/boot/devtree.c
@@ -109,3 +109,181 @@ void __dt_fixup_mac_addresses(u32 startindex, ...)
 	}
 	va_end(ap);
 }
+
+#define MAX_ADDR_CELLS 4
+#define MAX_RANGES 8
+
+static void get_reg_format(void *node, u32 *naddr, u32 *nsize)
+{
+	if (getprop(node, "#address-cells", naddr, 4) != 4)
+		*naddr = 2;
+	if (getprop(node, "#size-cells", nsize, 4) != 4)
+		*nsize = 1;
+}
+
+static void copy_val(u32 *dest, u32 *src, int naddr)
+{
+	memset(dest, 0, (MAX_ADDR_CELLS - naddr) * 4);
+	memcpy(dest, src, naddr * 4);
+}
+
+static int sub_reg(u32 *reg, u32 *sub)
+{
+	int i, borrow = 0;
+
+	for (i = 0; i < MAX_ADDR_CELLS; i++) {
+		int prev_borrow = borrow;
+		borrow = reg[i] < sub[i] + prev_borrow;
+		reg[i] -= sub[i] + prev_borrow;
+	}
+
+	return !borrow;
+}
+
+static int add_reg(u32 *reg, u32 *add)
+{
+	int i, carry = 0;
+
+	for (i = 0; i < MAX_ADDR_CELLS; i++) {
+		u64 tmp = (u64)reg[i] + add[i] + carry;
+		carry = tmp >> 32;
+		reg[i] = (u32)tmp;
+	}
+
+	return !carry;
+}
+
+/* It is assumed that if the first byte of reg fits in a
+ * range, then the whole reg block fits.
+ */
+static int compare_reg(u32 *reg, u32 *range, u32 *rangesize)
+{
+	int i;
+	u32 end;
+
+	for (i = 0; i < MAX_ADDR_CELLS; i++) {
+		if (reg[i] < range[i])
+			return 0;
+		if (reg[i] > range[i])
+			break;
+	}
+
+	for (i = 0; i < MAX_ADDR_CELLS; i++) {
+		end = range[i] + rangesize[i];
+
+		if (reg[i] < end)
+			break;
+		if (reg[i] > end)
+			return 0;
+	}
+
+	return reg[i] != end;
+}
+
+/* reg must be MAX_ADDR_CELLS */
+static int find_range(u32 *reg, u32 *ranges, int nregaddr,
+                      int naddr, int nsize, int buflen)
+{
+	int nrange = nregaddr + naddr + nsize;
+	int i;
+
+	for (i = 0; i + nrange <= buflen; i += nrange) {
+		u32 range_addr[MAX_ADDR_CELLS];
+		u32 range_size[MAX_ADDR_CELLS];
+
+		copy_val(range_addr, ranges + i, naddr);
+		copy_val(range_size, ranges + i + nregaddr + naddr, nsize);
+
+		if (compare_reg(reg, range_addr, range_size))
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
+int dt_xlate_reg(void *node, int res, unsigned long *addr,
+                 unsigned long *size)
+{
+	u32 last_addr[MAX_ADDR_CELLS];
+	u32 this_addr[MAX_ADDR_CELLS];
+	u32 buf[MAX_ADDR_CELLS * MAX_RANGES * 3];
+	void *parent;
+	u64 ret_addr, ret_size;
+	u32 naddr, nsize, prev_naddr;
+	int buflen, offset;
+
+	parent = get_parent(node);
+	if (!parent)
+		return 0;
+
+	get_reg_format(parent, &naddr, &nsize);
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
+	copy_val(last_addr, buf + offset, naddr);
+
+	ret_size = buf[offset + naddr];
+	if (nsize == 2) {
+		ret_size <<= 32;
+		ret_size |= buf[offset + naddr + 1];
+	}
+
+	while ((node = get_parent(node))) {
+		prev_naddr = naddr;
+
+		get_reg_format(node, &naddr, &nsize);
+
+		buflen = getprop(node, "ranges", buf, sizeof(buf));
+		if (buflen < 0)
+			continue;
+		if (buflen > sizeof(buf))
+			return 0;
+
+		offset = find_range(last_addr, buf, prev_naddr,
+		                    naddr, nsize, buflen / 4);
+
+		if (offset < 0)
+			return 0;
+
+		copy_val(this_addr, buf + offset, prev_naddr);
+
+		if (!sub_reg(last_addr, this_addr))
+			return 0;
+
+		copy_val(this_addr, buf + offset + prev_naddr, naddr);
+
+		if (!add_reg(last_addr, this_addr))
+			return 0;
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
index 1ffe72e..f8f1b2f 100644
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
+		if (!dt_xlate_reg(devp, 0, &reg_phys, NULL))
+			return -1;
+
+		reg_base = (void *)reg_phys;
+	}
 
 	n = getprop(devp, "reg-shift", &reg_shift, sizeof(reg_shift));
 	if (n != sizeof(reg_shift))
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 8008d61..fbd9030 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -82,6 +82,8 @@ int ns16550_console_init(void *devp, struct serial_console_data *scdp);
 void *simple_alloc_init(char *base, u32 heap_size, u32 granularity,
 		u32 max_allocs);
 extern void flush_cache(void *, unsigned long);
+int dt_xlate_reg(void *node, int res, unsigned long *addr,
+                 unsigned long *size);
 
 static inline void *finddevice(const char *name)
 {
-- 
1.5.0.3
