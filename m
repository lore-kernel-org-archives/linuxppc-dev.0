Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id EF446DDF11
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 03:01:16 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id n7so546521wag.13
	for <linuxppc-dev@ozlabs.org>; Mon, 05 May 2008 10:01:14 -0700 (PDT)
Message-ID: <9e4733910805051001h2c02fd57yb246091af8bf5a7d@mail.gmail.com>
Date: Mon, 5 May 2008 13:01:14 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Sascha Hauer" <s.hauer@pengutronix.de>
Subject: Re: [PATCH] add Phytec pcm030 board support
In-Reply-To: <20080425134805.GP6692@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080425134805.GP6692@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Did this get fixed somehow? I used to need this to boot a pcm030.

diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
index 272872d..c982adc 100644
--- a/fs/jffs2/scan.c
+++ b/fs/jffs2/scan.c
@@ -16,6 +16,7 @@
 #include <linux/pagemap.h>
 #include <linux/crc32.h>
 #include <linux/compiler.h>
+#include <asm/io.h>
 #include "nodelist.h"
 #include "summary.h"
 #include "debug.h"
@@ -505,7 +506,7 @@ static int jffs2_scan_eraseblock (struct
jffs2_sb_info *c, struct jffs2_eraseblo
                                        sumptr = kmalloc(sumlen, GFP_KERNEL);
                                        if (!sumptr)
                                                return -ENOMEM;
-                                       memcpy(sumptr + sumlen -
buf_len, buf + buf_size - buf_len, buf_len);
+                                       memcpy_fromio(sumptr + sumlen
- buf_len, buf + buf_size - buf_len, buf_len);
                                }
                                if (buf_len < sumlen) {
                                        /* Need to read more so that
the entire summary node is present */
@@ -1035,7 +1036,7 @@ static int jffs2_scan_dirent_node(struct
jffs2_sb_info *c, struct jffs2_eraseblo
        if (!fd) {
                return -ENOMEM;
        }
-       memcpy(&fd->name, rd->name, checkedlen);
+       memcpy_fromio(&fd->name, rd->name, checkedlen);
        fd->name[checkedlen] = 0;

        crc = crc32(0, fd->name, rd->nsize);
~

-- 
Jon Smirl
jonsmirl@gmail.com
