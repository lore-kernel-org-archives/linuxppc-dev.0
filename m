Return-Path: <wg@denx.de>
Message-Id: <20090331124036.204185953@denx.de>
Date: Tue, 31 Mar 2009 14:37:34 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
To: linuxppc-dev@ozlabs.org,
 Wolfgang Grandegger <wg@grandegger.com>
Subject: [PATCH 7/8] Re: [PATCH 1/2] NAND: Add support for oob size 128
References: <20090331123727.853787299@denx.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, devicetree-discuss@ozlabs.org,
	David Woodhouse <dwmw2@infradead.org>,
	Sebastian Siewior <bigeasy@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Wolfgang Grandegger | 2009-03-25 11:48:37 [+0100]:

>Signed-off-by: Ilya Yanok <yanok@emcraft.com>
>Acked-by: Wolfgang Grandegger <wg@grandegger.com>

You seem to forgot a few bits (subpage_sft & max page size). I had this
patch in my tree like for ever and forgot post it here. I did however
merge the mtd-utils bits allready :)

From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 12 Dec 2007 17:27:03 +0100
Subject: [PATCH 7/8] [PATCH] [MTD] Add support for 4k pages.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Siewior <bigeasy@linutronix.de>
---
 drivers/mtd/nand/nand_base.c |   18 ++++++++++++++++++
 include/linux/mtd/nand.h     |    4 ++--
 2 files changed, 20 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/mtd/nand/nand_base.c
===================================================================
--- linux-2.6.orig/drivers/mtd/nand/nand_base.c	2009-03-30 12:47:55.673721571 +0200
+++ linux-2.6/drivers/mtd/nand/nand_base.c	2009-03-30 12:48:07.896719130 +0200
@@ -82,6 +82,20 @@
 		 .length = 38}}
 };
 
+static struct nand_ecclayout nand_oob_128 = {
+	.eccbytes = 48,
+	.eccpos = {
+		   80, 81, 82, 83, 84, 85, 86, 87,
+		   88, 89, 90, 91, 92, 93, 94, 95,
+		   96, 97, 98, 99, 100, 101, 102, 103,
+		   104, 105, 106, 107, 108, 109, 110, 111,
+		   112, 113, 114, 115, 116, 117, 118, 119,
+		   120, 121, 122, 123, 124, 125, 126, 127},
+	.oobfree = {
+		{.offset = 2,
+		 .length = 78}}
+};
+
 static int nand_get_device(struct nand_chip *chip, struct mtd_info *mtd,
 			   int new_state);
 
@@ -2555,6 +2569,9 @@
 		case 64:
 			chip->ecc.layout = &nand_oob_64;
 			break;
+		case 128:
+			chip->ecc.layout = &nand_oob_128;
+			break;
 		default:
 			printk(KERN_WARNING "No oob scheme defined for "
 			       "oobsize %d\n", mtd->oobsize);
@@ -2676,6 +2693,7 @@
 			break;
 		case 4:
 		case 8:
+		case 16:
 			mtd->subpage_sft = 2;
 			break;
 		}
Index: linux-2.6/include/linux/mtd/nand.h
===================================================================
--- linux-2.6.orig/include/linux/mtd/nand.h	2009-03-30 12:47:55.673721571 +0200
+++ linux-2.6/include/linux/mtd/nand.h	2009-03-30 12:48:07.910718894 +0200
@@ -43,8 +43,8 @@
  * is supported now. If you add a chip with bigger oobsize/page
  * adjust this accordingly.
  */
-#define NAND_MAX_OOBSIZE	64
-#define NAND_MAX_PAGESIZE	2048
+#define NAND_MAX_OOBSIZE	128
+#define NAND_MAX_PAGESIZE	4096
 
 /*
  * Constants for hardware specific CLE/ALE/NCE function
