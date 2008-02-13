Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 6E566DDEFC
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 13:42:38 +1100 (EST)
Date: Wed, 13 Feb 2008 13:40:20 +1100
To: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] FIx compile of swim3 as module
Message-ID: <20080213024019.GX6887@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: Paul Mackerras <paulus@samba.org>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The current pmac32_defconfig fails to build with the following error:

  Building modules, stage 2.
ERROR: "check_media_bay" [drivers/block/swim3.ko] undefined!
WARNING: modpost: Found 23 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=y'
make[2]: *** [__modpost] Error 1

This patch fixes that.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

---

 drivers/block/swim3.c        |    4 ----
 drivers/macintosh/mediabay.c |    2 --
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index b4e462f..730ccea 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -251,10 +251,6 @@ static int floppy_release(struct inode *inode, struct file *filp);
 static int floppy_check_change(struct gendisk *disk);
 static int floppy_revalidate(struct gendisk *disk);
 
-#ifndef CONFIG_PMAC_MEDIABAY
-#define check_media_bay(which, what)	1
-#endif
-
 static void swim3_select(struct floppy_state *fs, int sel)
 {
 	struct swim3 __iomem *sw = fs->swim3;
diff --git a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.c
index 9367882..51a1128 100644
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -416,7 +416,6 @@ static void poll_media_bay(struct media_bay_info* bay)
 	}
 }
 
-#ifdef CONFIG_MAC_FLOPPY
 int check_media_bay(struct device_node *which_bay, int what)
 {
 	int	i;
@@ -431,7 +430,6 @@ int check_media_bay(struct device_node *which_bay, int what)
 	return -ENODEV;
 }
 EXPORT_SYMBOL(check_media_bay);
-#endif /* CONFIG_MAC_FLOPPY */
 
 #ifdef CONFIG_BLK_DEV_IDE_PMAC
 int check_media_bay_by_base(unsigned long base, int what)

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
