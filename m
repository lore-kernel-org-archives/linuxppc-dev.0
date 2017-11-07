Return-Path: <geert@linux-m68k.org>
Received: from leibniz.telenet-ops.be (leibniz.telenet-ops.be [195.130.137.77])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWWdH0Y2hzDq78
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 01:14:10 +1100 (AEDT)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:13])
 by leibniz.telenet-ops.be (Postfix) with ESMTPS id 3yWWQs5mxYzMqcwy
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 15:05:09 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] fbdev: controlfb: Add missing modes to fix out of bounds
 access
Date: Tue,  7 Nov 2017 15:05:05 +0100
Message-Id: <1510063505-2063-1-git-send-email-geert@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dan's static analysis says:

    drivers/video/fbdev/controlfb.c:560 control_setup()
    error: buffer overflow 'control_mac_modes' 20 <= 21

Indeed, control_mac_modes[] has only 20 elements, while VMODE_MAX is 22,
which may lead to an out of bounds read when parsing vmode commandline
options.

The bug was introduced in v2.4.5.6, when 2 new modes were added to
macmodes.h, but control_mac_modes[] wasn't updated:

https://kernel.opensuse.org/cgit/kernel/diff/include/video/macmodes.h?h=v2.5.2&id=29f279c764808560eaceb88fef36cbc35c529aad

Augment control_mac_modes[] with the two new video modes to fix this.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Compile-tested only.

The 1152x768 mode should be OK.
Given the 1600x1024 mode has a lower dotclock (112 MHz) than the
supported 1280x960 mode, it's probably OK, too.
---
 drivers/video/fbdev/controlfb.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/controlfb.h b/drivers/video/fbdev/controlfb.h
index 6026c60fc1007e00..261522fabdac89ae 100644
--- a/drivers/video/fbdev/controlfb.h
+++ b/drivers/video/fbdev/controlfb.h
@@ -141,5 +141,7 @@ static struct max_cmodes control_mac_modes[] = {
 	{{ 1, 2}},	/* 1152x870, 75Hz */
 	{{ 0, 1}},	/* 1280x960, 75Hz */
 	{{ 0, 1}},	/* 1280x1024, 75Hz */
+	{{ 1, 2}},	/* 1152x768, 60Hz */
+	{{ 0, 1}},	/* 1600x1024, 60Hz */
 };
 
-- 
2.7.4
