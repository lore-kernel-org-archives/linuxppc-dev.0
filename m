Return-Path: <mgreer@mvista.com>
Date: Fri, 13 Apr 2007 13:23:43 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Add dt_xlate_addr() to bootwrapper
Message-ID: <20070413202343.GA552@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

dt_xlate_reg() looks up the 'reg' property in the specified node
to get the address and size to translate.  Add dt_xlate_addr()
which is passed in the address and size to translate.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

Scott, would you please 'Acked-by:' or NACK this?  Thanks.

 devtree.c |   31 +++++++++++++------------------
 ops.h     |   23 +++++++++++++++++++++--
 2 files changed, 34 insertions(+), 20 deletions(-)
---

diff --git a/arch/powerpc/boot/devtree.c b/arch/powerpc/boot/devtree.c
index 23492d7..11b542d 100644
--- a/arch/powerpc/boot/devtree.c
+++ b/arch/powerpc/boot/devtree.c
@@ -110,9 +110,6 @@ void __dt_fixup_mac_addresses(u32 startindex, ...)
 	va_end(ap);
 }
 
-#define MAX_ADDR_CELLS 4
-#define MAX_RANGES 8
-
 static void get_reg_format(void *node, u32 *naddr, u32 *nsize)
 {
 	if (getprop(node, "#address-cells", naddr, 4) != 4)
@@ -123,7 +120,7 @@ static void get_reg_format(void *node, u32 *naddr, u32 *nsize)
 
 static void copy_val(u32 *dest, u32 *src, int naddr)
 {
-	memset(dest, 0, (MAX_ADDR_CELLS - naddr) * 4);
+	memset(dest, 0, (DT_MAX_ADDR_CELLS - naddr) * 4);
 	memcpy(dest, src, naddr * 4);
 }
 
@@ -131,7 +128,7 @@ static int sub_reg(u32 *reg, u32 *sub)
 {
 	int i, borrow = 0;
 
-	for (i = 0; i < MAX_ADDR_CELLS; i++) {
+	for (i = 0; i < DT_MAX_ADDR_CELLS; i++) {
 		int prev_borrow = borrow;
 		borrow = reg[i] < sub[i] + prev_borrow;
 		reg[i] -= sub[i] + prev_borrow;
@@ -144,7 +141,7 @@ static int add_reg(u32 *reg, u32 *add)
 {
 	int i, carry = 0;
 
-	for (i = 0; i < MAX_ADDR_CELLS; i++) {
+	for (i = 0; i < DT_MAX_ADDR_CELLS; i++) {
 		u64 tmp = (u64)reg[i] + add[i] + carry;
 		carry = tmp >> 32;
 		reg[i] = (u32)tmp;
@@ -161,14 +158,14 @@ static int compare_reg(u32 *reg, u32 *range, u32 *rangesize)
 	int i;
 	u32 end;
 
-	for (i = 0; i < MAX_ADDR_CELLS; i++) {
+	for (i = 0; i < DT_MAX_ADDR_CELLS; i++) {
 		if (reg[i] < range[i])
 			return 0;
 		if (reg[i] > range[i])
 			break;
 	}
 
-	for (i = 0; i < MAX_ADDR_CELLS; i++) {
+	for (i = 0; i < DT_MAX_ADDR_CELLS; i++) {
 		end = range[i] + rangesize[i];
 
 		if (reg[i] < end)
@@ -180,7 +177,7 @@ static int compare_reg(u32 *reg, u32 *range, u32 *rangesize)
 	return reg[i] != end;
 }
 
-/* reg must be MAX_ADDR_CELLS */
+/* reg must be DT_MAX_ADDR_CELLS */
 static int find_range(u32 *reg, u32 *ranges, int nregaddr,
                       int naddr, int nsize, int buflen)
 {
@@ -188,8 +185,8 @@ static int find_range(u32 *reg, u32 *ranges, int nregaddr,
 	int i;
 
 	for (i = 0; i + nrange <= buflen; i += nrange) {
-		u32 range_addr[MAX_ADDR_CELLS];
-		u32 range_size[MAX_ADDR_CELLS];
+		u32 range_addr[DT_MAX_ADDR_CELLS];
+		u32 range_size[DT_MAX_ADDR_CELLS];
 
 		copy_val(range_addr, ranges + i, naddr);
 		copy_val(range_size, ranges + i + nregaddr + naddr, nsize);
@@ -205,16 +202,15 @@ static int find_range(u32 *reg, u32 *ranges, int nregaddr,
  * In particular, PCI is not supported.  Also, only the beginning of the
  * reg block is tracked; size is ignored except in ranges.
  */
-int dt_xlate_reg(void *node, int res, unsigned long *addr,
-                 unsigned long *size)
+int dt_xlate(void *node, u32 *buf, int buflen, int res, unsigned long *addr,
+		unsigned long *size)
 {
-	u32 last_addr[MAX_ADDR_CELLS];
-	u32 this_addr[MAX_ADDR_CELLS];
-	u32 buf[MAX_ADDR_CELLS * MAX_RANGES * 3];
+	u32 last_addr[DT_MAX_ADDR_CELLS];
+	u32 this_addr[DT_MAX_ADDR_CELLS];
 	void *parent;
 	u64 ret_addr, ret_size;
 	u32 naddr, nsize, prev_naddr;
-	int buflen, offset;
+	int offset;
 
 	parent = get_parent(node);
 	if (!parent)
@@ -225,7 +221,6 @@ int dt_xlate_reg(void *node, int res, unsigned long *addr,
 	if (nsize > 2)
 		return 0;
 
-	buflen = getprop(node, "reg", buf, sizeof(buf)) / 4;
 	offset = (naddr + nsize) * res;
 
 	if (buflen < offset + naddr + nsize)
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index ee0f9c2..c499ee7 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -82,8 +82,8 @@ int ns16550_console_init(void *devp, struct serial_console_data *scdp);
 void *simple_alloc_init(char *base, u32 heap_size, u32 granularity,
 		u32 max_allocs);
 extern void flush_cache(void *, unsigned long);
-int dt_xlate_reg(void *node, int res, unsigned long *addr,
-                 unsigned long *size);
+int dt_xlate(void *node, u32 *buf, int buflen, int res, unsigned long *addr,
+		unsigned long *size);
 
 static inline void *finddevice(const char *name)
 {
@@ -183,6 +183,25 @@ static inline void exit(void)
 }
 #define fatal(args...) { printf(args); exit(); }
 
+#define DT_MAX_ADDR_CELLS 4
+#define DT_MAX_RANGES 8
+
+static inline int dt_xlate_reg(void *node, int res, unsigned long *addr,
+                 unsigned long *size)
+{
+	u32 buf[DT_MAX_ADDR_CELLS * DT_MAX_RANGES * 3];
+	int buflen;
+
+	buflen = getprop(node, "reg", buf, sizeof(buf)) / 4;
+	return dt_xlate(node, buf, buflen, res, addr, size);
+}
+
+static inline int dt_xlate_addr(void *node, u32 *buf, int buflen,
+		unsigned long *xlated_addr)
+{
+	return dt_xlate(node, buf, buflen, 0, xlated_addr, NULL);
+}
+
 
 #define BSS_STACK(size) \
 	static char _bss_stack[size]; \
