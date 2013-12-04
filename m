Return-Path: <clg@fr.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp10.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 17FDD2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2013 03:50:07 +1100 (EST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Wed, 4 Dec 2013 16:50:03 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id D4A652190059
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Dec 2013 16:50:00 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rB4GnmLf66912372
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Dec 2013 16:49:48 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rB4Go024016367
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Dec 2013 09:50:00 -0700
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH v3 2/2] offb: add palette hack for little endian
Date: Wed,  4 Dec 2013 17:49:52 +0100
Message-Id: <1386175792-31822-2-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1386175792-31822-1-git-send-email-clg@fr.ibm.com>
References: <1386175792-31822-1-git-send-email-clg@fr.ibm.com>
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

The pseudo palette color entries need to be ajusted for little
endian.

This patch byteswaps the values in the pseudo palette depending
on the host endian order and the screen depth.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---

Tested on powerpc, little endian and big endian, for 8, 15, 16 and 32 
bpp using the qemu std vga device, with and without foreign endian 
support. I did pull my hair out :) 

The foreign endian support needs some more work to be sure the logic 
behind fb_be_math() is not broken. 

The palette used for the logo would need a similar fix.

Thanks,




 drivers/video/offb.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/video/offb.c b/drivers/video/offb.c
index 43a0a52fc527..7d44d669d5b6 100644
--- a/drivers/video/offb.c
+++ b/drivers/video/offb.c
@@ -91,6 +91,15 @@ extern boot_infos_t *boot_infos;
 #define AVIVO_DC_LUTB_WHITE_OFFSET_GREEN        0x6cd4
 #define AVIVO_DC_LUTB_WHITE_OFFSET_RED          0x6cd8
 
+#define FB_RIGHT_POS(p, bpp)         (fb_be_math(p) ? 0 : (32 - (bpp)))
+
+static inline u32 offb_cmap_byteswap(struct fb_info *info, u32 value)
+{
+	u32 bpp = info->var.bits_per_pixel;
+
+	return cpu_to_be32(value) >> FB_RIGHT_POS(info, bpp);
+}
+
     /*
      *  Set a single color register. The values supplied are already
      *  rounded down to the hardware's capabilities (according to the
@@ -120,7 +129,7 @@ static int offb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 			mask <<= info->var.transp.offset;
 			value |= mask;
 		}
-		pal[regno] = value;
+		pal[regno] = offb_cmap_byteswap(info, value);
 		return 0;
 	}
 
-- 
1.7.10.4
