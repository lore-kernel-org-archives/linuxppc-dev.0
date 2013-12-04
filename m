Return-Path: <clg@fr.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp13.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6898D2C0367
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2013 03:51:21 +1100 (EST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Wed, 4 Dec 2013 16:51:18 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1B1562190023
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Dec 2013 16:51:15 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rB4Gnme737879884
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Dec 2013 16:49:48 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rB4GnxxC015306
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Dec 2013 09:50:00 -0700
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH v3 1/2] offb: little endian fixes
Date: Wed,  4 Dec 2013 17:49:51 +0100
Message-Id: <1386175792-31822-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1385240643.4882.133.camel@pasglop>
References: <1385240643.4882.133.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The "screen" properties : depth, width, height, linebytes need
to be converted to the host endian order when read from the device
tree.

The offb_init_palette_hacks() routine also made assumption on the
host endian order.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---

Changes in v3:

 - fixed offb_init_palette_hacks()

Changes in v2:

 - replaced be32_to_cpu() by be32_to_cpup()

 drivers/video/offb.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/video/offb.c b/drivers/video/offb.c
index 9dbea2223401..43a0a52fc527 100644
--- a/drivers/video/offb.c
+++ b/drivers/video/offb.c
@@ -301,7 +301,7 @@ static struct fb_ops offb_ops = {
 static void __iomem *offb_map_reg(struct device_node *np, int index,
 				  unsigned long offset, unsigned long size)
 {
-	const u32 *addrp;
+	const __be32 *addrp;
 	u64 asize, taddr;
 	unsigned int flags;
 
@@ -369,7 +369,11 @@ static void offb_init_palette_hacks(struct fb_info *info, struct device_node *dp
 		}
 		of_node_put(pciparent);
 	} else if (dp && of_device_is_compatible(dp, "qemu,std-vga")) {
-		const u32 io_of_addr[3] = { 0x01000000, 0x0, 0x0 };
+#ifdef __BIG_ENDIAN
+		const __be32 io_of_addr[3] = { 0x01000000, 0x0, 0x0 };
+#else
+		const __be32 io_of_addr[3] = { 0x00000001, 0x0, 0x0 };
+#endif
 		u64 io_addr = of_translate_address(dp, io_of_addr);
 		if (io_addr != OF_BAD_ADDR) {
 			par->cmap_adr = ioremap(io_addr + 0x3c8, 2);
@@ -535,7 +539,7 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
 	unsigned int flags, rsize, addr_prop = 0;
 	unsigned long max_size = 0;
 	u64 rstart, address = OF_BAD_ADDR;
-	const u32 *pp, *addrp, *up;
+	const __be32 *pp, *addrp, *up;
 	u64 asize;
 	int foreign_endian = 0;
 
@@ -551,25 +555,25 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
 	if (pp == NULL)
 		pp = of_get_property(dp, "depth", &len);
 	if (pp && len == sizeof(u32))
-		depth = *pp;
+		depth = be32_to_cpup(pp);
 
 	pp = of_get_property(dp, "linux,bootx-width", &len);
 	if (pp == NULL)
 		pp = of_get_property(dp, "width", &len);
 	if (pp && len == sizeof(u32))
-		width = *pp;
+		width = be32_to_cpup(pp);
 
 	pp = of_get_property(dp, "linux,bootx-height", &len);
 	if (pp == NULL)
 		pp = of_get_property(dp, "height", &len);
 	if (pp && len == sizeof(u32))
-		height = *pp;
+		height = be32_to_cpup(pp);
 
 	pp = of_get_property(dp, "linux,bootx-linebytes", &len);
 	if (pp == NULL)
 		pp = of_get_property(dp, "linebytes", &len);
 	if (pp && len == sizeof(u32) && (*pp != 0xffffffffu))
-		pitch = *pp;
+		pitch = be32_to_cpup(pp);
 	else
 		pitch = width * ((depth + 7) / 8);
 
-- 
1.7.10.4
