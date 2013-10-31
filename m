Return-Path: <clg@fr.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp11.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4E67C2C03BB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 20:36:53 +1100 (EST)
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Thu, 31 Oct 2013 09:36:48 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2DE09219006E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 09:36:44 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9V9aVY842467570
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 09:36:31 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9V9ahmq031265
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 03:36:43 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH v2] offb: make the screen properties endian safe
Date: Thu, 31 Oct 2013 10:36:32 +0100
Message-Id: <1383212192-3622-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1383185307.5117.74.camel@pasglop>
References: <1383185307.5117.74.camel@pasglop>
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

Changes in v2:

 - replaced be32_to_cpu() by be32_to_cpup() 
 - fixed setcolreg ops 

 drivers/video/offb.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/offb.c b/drivers/video/offb.c
index 0c4f343..68e8415 100644
--- a/drivers/video/offb.c
+++ b/drivers/video/offb.c
@@ -120,7 +120,7 @@ static int offb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 			mask <<= info->var.transp.offset;
 			value |= mask;
 		}
-		pal[regno] = value;
+		pal[regno] = cpu_to_be32(value);
 		return 0;
 	}
 
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
