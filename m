Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CB316DDF6F
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:33:12 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6I1X7Dq018479
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:33:07 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1X6ut001170
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:33:06 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I18P0r007835
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:08:25 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id B4811AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:33:05 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1X5c6015271
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:33:05 -0500
Date: Tue, 17 Jul 2007 20:33:05 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/61] bootwrapper: dt_xlate_range() bugfixes
Message-ID: <20070718013305.GG15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

1. The check whether ranges fits in the buffer was using elements rather
than bytes.
2. Empty ranges were not properly treated as transparent, and missing
ranges were treated as transparent.
3. The loop terminated when translating from the root rather than to.  Once
bug #2 was fixed, it failed due to a missing ranges in the root node.
4. In decoding the ranges property, the #size-cells used was that of
the parent, not the child.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/devtree.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/devtree.c b/arch/powerpc/boot/devtree.c
index 3465d3f..f33c00b 100644
--- a/arch/powerpc/boot/devtree.c
+++ b/arch/powerpc/boot/devtree.c
@@ -219,7 +219,7 @@ static int dt_xlate(void *node, int res, int reglen, unsigned long *addr,
 	u32 this_addr[MAX_ADDR_CELLS];
 	void *parent;
 	u64 ret_addr, ret_size;
-	u32 naddr, nsize, prev_naddr;
+	u32 naddr, nsize, prev_naddr, prev_nsize;
 	int buflen, offset;
 
 	parent = get_parent(node);
@@ -234,7 +234,7 @@ static int dt_xlate(void *node, int res, int reglen, unsigned long *addr,
 	offset = (naddr + nsize) * res;
 
 	if (reglen < offset + naddr + nsize ||
-	    sizeof(dt_xlate_buf) < offset + naddr + nsize)
+	    sizeof(dt_xlate_buf) < (offset + naddr + nsize) * 4)
 		return 0;
 
 	copy_val(last_addr, dt_xlate_buf + offset, naddr);
@@ -245,20 +245,26 @@ static int dt_xlate(void *node, int res, int reglen, unsigned long *addr,
 		ret_size |= dt_xlate_buf[offset + naddr + 1];
 	}
 
-	while ((node = get_parent(node))) {
+	for (;;) {
 		prev_naddr = naddr;
+		prev_nsize = nsize;
+		node = parent;
 
-		get_reg_format(node, &naddr, &nsize);
+		parent = get_parent(node);
+		if (!parent)
+			break;
+
+		get_reg_format(parent, &naddr, &nsize);
 
 		buflen = getprop(node, "ranges", dt_xlate_buf,
 				sizeof(dt_xlate_buf));
-		if (buflen < 0)
+		if (buflen == 0)
 			continue;
-		if (buflen > sizeof(dt_xlate_buf))
+		if (buflen < 0 || buflen > sizeof(dt_xlate_buf))
 			return 0;
 
 		offset = find_range(last_addr, dt_xlate_buf, prev_naddr,
-		                    naddr, nsize, buflen / 4);
+		                    naddr, prev_nsize, buflen / 4);
 
 		if (offset < 0)
 			return 0;
-- 
1.5.0.3
