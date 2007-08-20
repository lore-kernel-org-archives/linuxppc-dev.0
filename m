Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EDA30DDECD
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 03:39:54 +1000 (EST)
Date: Mon, 20 Aug 2007 12:39:46 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 03/20] bootwrapper: dt_xlate_range() bugfixes
Message-ID: <20070820173946.GB30562@ld0162-tx32.am.freescale.net>
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
index ae8b886..129e6d9 100644
--- a/arch/powerpc/boot/devtree.c
+++ b/arch/powerpc/boot/devtree.c
@@ -218,7 +218,7 @@ static int dt_xlate(void *node, int res, int reglen, unsigned long *addr,
 	u32 this_addr[MAX_ADDR_CELLS];
 	void *parent;
 	u64 ret_addr, ret_size;
-	u32 naddr, nsize, prev_naddr;
+	u32 naddr, nsize, prev_naddr, prev_nsize;
 	int buflen, offset;
 
 	parent = get_parent(node);
@@ -233,7 +233,7 @@ static int dt_xlate(void *node, int res, int reglen, unsigned long *addr,
 	offset = (naddr + nsize) * res;
 
 	if (reglen < offset + naddr + nsize ||
-	    sizeof(dt_xlate_buf) < offset + naddr + nsize)
+	    sizeof(dt_xlate_buf) < (offset + naddr + nsize) * 4)
 		return 0;
 
 	copy_val(last_addr, dt_xlate_buf + offset, naddr);
@@ -244,20 +244,26 @@ static int dt_xlate(void *node, int res, int reglen, unsigned long *addr,
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
