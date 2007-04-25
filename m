Return-Path: <mgreer@mvista.com>
Date: Wed, 25 Apr 2007 14:16:35 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: Add dt_xlate_addr() to bootwrapper
Message-ID: <20070425211635.GA12040@mag.az.mvista.com>
References: <20070413202343.GA552@mag.az.mvista.com>
	<20070413222551.GA8258@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070413222551.GA8258@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 13, 2007 at 05:25:51PM -0500, Scott Wood wrote:
> On Fri, Apr 13, 2007 at 01:23:43PM -0700, Mark A. Greer wrote:

> This causes it to use the caller-provided buffer to read the ranges
> property, which may not be large enough in the case of dt_xlate_addr().
> ...
>

Scott, how about this?  If you like it, please give me an "Acked-by:" line
and I'll submit it with some other patches I'm prep'ing.

Thanks,

Mark
---

[PATCH] powerpc: Add dt_xlate_addr() to bootwrapper

From: "Mark A. Greer" <mgreer@mvista.com>

dt_xlate_reg() looks up the 'reg' property in the specified node
to get the address and size to translate.  Add dt_xlate_addr()
which is passed in the address and size to translate.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

 devtree.c |   45 ++++++++++++++++++++++++++++++++-------------
 ops.h     |    4 ++--
 2 files changed, 34 insertions(+), 15 deletions(-)

Index: powerpc/arch/powerpc/boot/devtree.c
===================================================================
--- powerpc.orig/arch/powerpc/boot/devtree.c
+++ powerpc/arch/powerpc/boot/devtree.c
@@ -205,16 +205,17 @@ static int find_range(u32 *reg, u32 *ran
  * In particular, PCI is not supported.  Also, only the beginning of the
  * reg block is tracked; size is ignored except in ranges.
  */
-int dt_xlate_reg(void *node, int res, unsigned long *addr,
-                 unsigned long *size)
+static u32 dt_xlate_buf[MAX_ADDR_CELLS * MAX_RANGES * 3];
+
+static int dt_xlate(void *node, int res, int buflen, unsigned long *addr,
+		unsigned long *size)
 {
 	u32 last_addr[MAX_ADDR_CELLS];
 	u32 this_addr[MAX_ADDR_CELLS];
-	u32 buf[MAX_ADDR_CELLS * MAX_RANGES * 3];
 	void *parent;
 	u64 ret_addr, ret_size;
 	u32 naddr, nsize, prev_naddr;
-	int buflen, offset;
+	int offset;
 
 	parent = get_parent(node);
 	if (!parent)
@@ -225,18 +226,17 @@ int dt_xlate_reg(void *node, int res, un
 	if (nsize > 2)
 		return 0;
 
-	buflen = getprop(node, "reg", buf, sizeof(buf)) / 4;
 	offset = (naddr + nsize) * res;
 
 	if (buflen < offset + naddr + nsize)
 		return 0;
 
-	copy_val(last_addr, buf + offset, naddr);
+	copy_val(last_addr, dt_xlate_buf + offset, naddr);
 
-	ret_size = buf[offset + naddr];
+	ret_size = dt_xlate_buf[offset + naddr];
 	if (nsize == 2) {
 		ret_size <<= 32;
-		ret_size |= buf[offset + naddr + 1];
+		ret_size |= dt_xlate_buf[offset + naddr + 1];
 	}
 
 	while ((node = get_parent(node))) {
@@ -244,24 +244,25 @@ int dt_xlate_reg(void *node, int res, un
 
 		get_reg_format(node, &naddr, &nsize);
 
-		buflen = getprop(node, "ranges", buf, sizeof(buf));
+		buflen = getprop(node, "ranges", dt_xlate_buf,
+				sizeof(dt_xlate_buf));
 		if (buflen < 0)
 			continue;
-		if (buflen > sizeof(buf))
+		if (buflen > sizeof(dt_xlate_buf))
 			return 0;
 
-		offset = find_range(last_addr, buf, prev_naddr,
+		offset = find_range(last_addr, dt_xlate_buf, prev_naddr,
 		                    naddr, nsize, buflen / 4);
 
 		if (offset < 0)
 			return 0;
 
-		copy_val(this_addr, buf + offset, prev_naddr);
+		copy_val(this_addr, dt_xlate_buf + offset, prev_naddr);
 
 		if (!sub_reg(last_addr, this_addr))
 			return 0;
 
-		copy_val(this_addr, buf + offset + prev_naddr, naddr);
+		copy_val(this_addr, dt_xlate_buf + offset + prev_naddr, naddr);
 
 		if (!add_reg(last_addr, this_addr))
 			return 0;
@@ -287,3 +288,21 @@ int dt_xlate_reg(void *node, int res, un
 
 	return 1;
 }
+
+int dt_xlate_reg(void *node, int res, unsigned long *addr, unsigned long *size)
+{
+	int buflen;
+
+	buflen = getprop(node, "reg", dt_xlate_buf, sizeof(dt_xlate_buf)) / 4;
+	return dt_xlate(node, res, buflen, addr, size);
+}
+
+int dt_xlate_addr(void *node, u32 *buf, int buflen, unsigned long *xlated_addr)
+{
+
+	if (buflen > sizeof(dt_xlate_buf))
+		return 0;
+
+	memcpy(dt_xlate_buf, buf, buflen);
+	return dt_xlate(node, 0, buflen / 4, xlated_addr, NULL);
+}
Index: powerpc/arch/powerpc/boot/ops.h
===================================================================
--- powerpc.orig/arch/powerpc/boot/ops.h
+++ powerpc/arch/powerpc/boot/ops.h
@@ -82,8 +82,8 @@ int ns16550_console_init(void *devp, str
 void *simple_alloc_init(char *base, unsigned long heap_size,
 			unsigned long granularity, unsigned long max_allocs);
 extern void flush_cache(void *, unsigned long);
-int dt_xlate_reg(void *node, int res, unsigned long *addr,
-                 unsigned long *size);
+int dt_xlate_reg(void *node, int res, unsigned long *addr, unsigned long *size);
+int dt_xlate_addr(void *node, u32 *buf, int buflen, unsigned long *xlated_addr);
 
 static inline void *finddevice(const char *name)
 {
