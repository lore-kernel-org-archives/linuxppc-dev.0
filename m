Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7EB67DDEC4
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 03:39:56 +1000 (EST)
Date: Mon, 20 Aug 2007 12:39:48 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 04/20] bootwrapper: Add dt_is_compatible().
Message-ID: <20070820173948.GC30562@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This can be used rather than doing a simple strcmp, which will fail to
handle multiple compatible entries.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/devtree.c |   48 +++++++++++++++++++++++++++++-------------
 arch/powerpc/boot/ops.h     |    1 +
 2 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/boot/devtree.c b/arch/powerpc/boot/devtree.c
index 129e6d9..3a18bfe 100644
--- a/arch/powerpc/boot/devtree.c
+++ b/arch/powerpc/boot/devtree.c
@@ -113,7 +113,6 @@ void __dt_fixup_mac_addresses(u32 startindex, ...)
 }
 
 #define MAX_ADDR_CELLS 4
-#define MAX_RANGES 8
 
 static void get_reg_format(void *node, u32 *naddr, u32 *nsize)
 {
@@ -209,7 +208,7 @@ static int find_range(u32 *reg, u32 *ranges, int nregaddr,
  * In particular, PCI is not supported.  Also, only the beginning of the
  * reg block is tracked; size is ignored except in ranges.
  */
-static u32 dt_xlate_buf[MAX_ADDR_CELLS * MAX_RANGES * 3];
+static u32 prop_buf[MAX_PROP_LEN / 4];
 
 static int dt_xlate(void *node, int res, int reglen, unsigned long *addr,
 		unsigned long *size)
@@ -233,15 +232,15 @@ static int dt_xlate(void *node, int res, int reglen, unsigned long *addr,
 	offset = (naddr + nsize) * res;
 
 	if (reglen < offset + naddr + nsize ||
-	    sizeof(dt_xlate_buf) < (offset + naddr + nsize) * 4)
+	    MAX_PROP_LEN < (offset + naddr + nsize) * 4)
 		return 0;
 
-	copy_val(last_addr, dt_xlate_buf + offset, naddr);
+	copy_val(last_addr, prop_buf + offset, naddr);
 
-	ret_size = dt_xlate_buf[offset + naddr];
+	ret_size = prop_buf[offset + naddr];
 	if (nsize == 2) {
 		ret_size <<= 32;
-		ret_size |= dt_xlate_buf[offset + naddr + 1];
+		ret_size |= prop_buf[offset + naddr + 1];
 	}
 
 	for (;;) {
@@ -255,25 +254,25 @@ static int dt_xlate(void *node, int res, int reglen, unsigned long *addr,
 
 		get_reg_format(parent, &naddr, &nsize);
 
-		buflen = getprop(node, "ranges", dt_xlate_buf,
-				sizeof(dt_xlate_buf));
+		buflen = getprop(node, "ranges", prop_buf,
+				sizeof(prop_buf));
 		if (buflen == 0)
 			continue;
-		if (buflen < 0 || buflen > sizeof(dt_xlate_buf))
+		if (buflen < 0 || buflen > sizeof(prop_buf))
 			return 0;
 
-		offset = find_range(last_addr, dt_xlate_buf, prev_naddr,
+		offset = find_range(last_addr, prop_buf, prev_naddr,
 		                    naddr, prev_nsize, buflen / 4);
 
 		if (offset < 0)
 			return 0;
 
-		copy_val(this_addr, dt_xlate_buf + offset, prev_naddr);
+		copy_val(this_addr, prop_buf + offset, prev_naddr);
 
 		if (!sub_reg(last_addr, this_addr))
 			return 0;
 
-		copy_val(this_addr, dt_xlate_buf + offset + prev_naddr, naddr);
+		copy_val(this_addr, prop_buf + offset + prev_naddr, naddr);
 
 		if (!add_reg(last_addr, this_addr, naddr))
 			return 0;
@@ -300,16 +299,35 @@ int dt_xlate_reg(void *node, int res, unsigned long *addr, unsigned long *size)
 {
 	int reglen;
 
-	reglen = getprop(node, "reg", dt_xlate_buf, sizeof(dt_xlate_buf)) / 4;
+	reglen = getprop(node, "reg", prop_buf, sizeof(prop_buf)) / 4;
 	return dt_xlate(node, res, reglen, addr, size);
 }
 
 int dt_xlate_addr(void *node, u32 *buf, int buflen, unsigned long *xlated_addr)
 {
 
-	if (buflen > sizeof(dt_xlate_buf))
+	if (buflen > sizeof(prop_buf))
 		return 0;
 
-	memcpy(dt_xlate_buf, buf, buflen);
+	memcpy(prop_buf, buf, buflen);
 	return dt_xlate(node, 0, buflen / 4, xlated_addr, NULL);
 }
+
+int dt_is_compatible(void *node, const char *compat)
+{
+	char *buf = (char *)prop_buf;
+	int len, pos;
+
+	len = getprop(node, "compatible", buf, MAX_PROP_LEN);
+	if (len < 0)
+		return 0;
+
+	for (pos = 0; pos < len; pos++) {
+		if (!strcmp(buf + pos, compat))
+			return 1;
+
+		pos += strnlen(&buf[pos], len - pos);
+	}
+
+	return 0;
+}
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index aebd6ed..a10bf5a 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -87,6 +87,7 @@ void *simple_alloc_init(char *base, unsigned long heap_size,
 extern void flush_cache(void *, unsigned long);
 int dt_xlate_reg(void *node, int res, unsigned long *addr, unsigned long *size);
 int dt_xlate_addr(void *node, u32 *buf, int buflen, unsigned long *xlated_addr);
+int dt_is_compatible(void *node, const char *compat);
 
 static inline void *finddevice(const char *name)
 {
-- 
1.5.0.3
