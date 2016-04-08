Return-Path: <zajec5@gmail.com>
Received: from mail-lf0-x229.google.com (mail-lf0-x229.google.com
 [IPv6:2a00:1450:4010:c07::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhH0H3yc7zDq6T
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Apr 2016 21:14:06 +1000 (AEST)
Received: by mail-lf0-x229.google.com with SMTP id g184so76848472lfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Apr 2016 04:14:06 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
 Egor Martovetsky <egor@pasemi.com>, Olof Johansson <olof@lixom.net>,
 Joe Perches <joe@perches.com>,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC PA SEMI PWRFICIENT),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2] mtd: nand: pasemi: switch to pr_* functions
Date: Fri,  8 Apr 2016 13:13:23 +0200
Message-Id: <1460114003-19926-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1460111589-18781-1-git-send-email-zajec5@gmail.com>
References: <1460111589-18781-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

1) Use pr_fmt to keep messages consistent
2) Don't warn if kzalloc fails as it dumps stack on its own
3) Use %pR format for displaying whole resource to avoid:
warning: format ‘%08llx’ expects type ‘long long unsigned int’, but argument 2 has type ‘resource_size_t’

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 drivers/mtd/nand/pasemi_nand.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/pasemi_nand.c b/drivers/mtd/nand/pasemi_nand.c
index 63fcb8c..e8372b4 100644
--- a/drivers/mtd/nand/pasemi_nand.c
+++ b/drivers/mtd/nand/pasemi_nand.c
@@ -22,6 +22,8 @@
 
 #undef DEBUG
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
@@ -112,8 +114,6 @@ static int pasemi_nand_probe(struct platform_device *ofdev)
 	/* Allocate memory for MTD device structure and private data */
 	chip = kzalloc(sizeof(struct nand_chip), GFP_KERNEL);
 	if (!chip) {
-		printk(KERN_WARNING
-		       "Unable to allocate PASEMI NAND MTD device structure\n");
 		err = -ENOMEM;
 		goto out;
 	}
@@ -163,13 +163,12 @@ static int pasemi_nand_probe(struct platform_device *ofdev)
 	}
 
 	if (mtd_device_register(pasemi_nand_mtd, NULL, 0)) {
-		printk(KERN_ERR "pasemi_nand: Unable to register MTD device\n");
+		pr_err("Unable to register MTD device\n");
 		err = -ENODEV;
 		goto out_lpc;
 	}
 
-	printk(KERN_INFO "PA Semi NAND flash at %08llx, control at I/O %x\n",
-	       res.start, lpcctl);
+	pr_info("PA Semi NAND flash at %pR, control at I/O %x\n", &res, lpcctl);
 
 	return 0;
 
-- 
1.8.4.5
