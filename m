Return-Path: <clg@fr.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp13.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 466F32C0369
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 03:19:33 +1100 (EST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Wed, 30 Oct 2013 16:19:30 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id CA92F219040E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 16:14:18 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9UGE6Dv49021008
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 16:14:06 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9UGEICg030345
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 10:14:18 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] offb: make the screen properties endian safe
Date: Wed, 30 Oct 2013 17:14:07 +0100
Message-Id: <1383149647-15500-1-git-send-email-clg@fr.ibm.com>
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

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 drivers/video/offb.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/offb.c b/drivers/video/offb.c
index 0c4f343..c1cf591 100644
--- a/drivers/video/offb.c
+++ b/drivers/video/offb.c
@@ -536,7 +536,7 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
 	unsigned int flags, rsize, addr_prop = 0;
 	unsigned long max_size = 0;
 	u64 rstart, address = OF_BAD_ADDR;
-	const u32 *pp, *addrp, *up;
+	const __be32 *pp, *addrp, *up;
 	u64 asize;
 	int foreign_endian = 0;
 
@@ -552,25 +552,25 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
 	if (pp == NULL)
 		pp = of_get_property(dp, "depth", &len);
 	if (pp && len == sizeof(u32))
-		depth = *pp;
+		depth = be32_to_cpu(*pp);
 
 	pp = of_get_property(dp, "linux,bootx-width", &len);
 	if (pp == NULL)
 		pp = of_get_property(dp, "width", &len);
 	if (pp && len == sizeof(u32))
-		width = *pp;
+		width = be32_to_cpu(*pp);
 
 	pp = of_get_property(dp, "linux,bootx-height", &len);
 	if (pp == NULL)
 		pp = of_get_property(dp, "height", &len);
 	if (pp && len == sizeof(u32))
-		height = *pp;
+		height = be32_to_cpu(*pp);
 
 	pp = of_get_property(dp, "linux,bootx-linebytes", &len);
 	if (pp == NULL)
 		pp = of_get_property(dp, "linebytes", &len);
 	if (pp && len == sizeof(u32) && (*pp != 0xffffffffu))
-		pitch = *pp;
+		pitch = be32_to_cpu(*pp);
 	else
 		pitch = width * ((depth + 7) / 8);
 
-- 
1.7.10.4
