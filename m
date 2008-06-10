Return-Path: <bunk@kernel.org>
Received: from smtp4.pp.htv.fi (smtp4.pp.htv.fi [213.243.153.38])
	by ozlabs.org (Postfix) with ESMTP id 4C96CDE218
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 03:49:12 +1000 (EST)
Date: Tue, 10 Jun 2008 20:47:45 +0300
From: Adrian Bunk <bunk@kernel.org>
To: paulus@samba.org, benh@kernel.crashing.org
Subject: [2.6 patch] drivers/macintosh/mediabay.c build fix
Message-ID: <20080610174745.GE11685@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes the following build error with CONFIG_BLK_DEV_IDE_PMAC=n:

<--  snip  -->

...
  CC      drivers/macintosh/mediabay.o
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/macintosh/mediabay.c: In function 'check_media_bay':
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/macintosh/mediabay.c:428: error: 'struct media_bay_info' has no member named 'cd_index'
make[3]: *** [drivers/macintosh/mediabay.o] Error 1

<--  snip  -->

Reported-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 drivers/macintosh/mediabay.c   |    4 ++--
 include/asm-powerpc/mediabay.h |   12 ++++++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

e644eb541d73b1fe13550506398d725a536c6aef diff --git a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.c
index 82add26..7d406ef 100644
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -84,7 +84,7 @@ struct media_bay_info {
 	int				cd_irq;
 	int				cd_retry;
 #endif
-#if defined(CONFIG_BLK_DEV_IDE_PMAC) || defined(CONFIG_MAC_FLOPPY)
+#if defined(CONFIG_BLK_DEV_IDE_PMAC)
 	int 				cd_index;
 #endif
 };
@@ -417,6 +417,7 @@ static void poll_media_bay(struct media_bay_info* bay)
 	}
 }
 
+#ifdef CONFIG_BLK_DEV_IDE_PMAC
 int check_media_bay(struct device_node *which_bay, int what)
 {
 	int	i;
@@ -432,7 +433,6 @@ int check_media_bay(struct device_node *which_bay, int what)
 }
 EXPORT_SYMBOL(check_media_bay);
 
-#ifdef CONFIG_BLK_DEV_IDE_PMAC
 int check_media_bay_by_base(unsigned long base, int what)
 {
 	int	i;
diff --git a/include/asm-powerpc/mediabay.h b/include/asm-powerpc/mediabay.h
index df111c3..b2efb33 100644
--- a/include/asm-powerpc/mediabay.h
+++ b/include/asm-powerpc/mediabay.h
@@ -17,8 +17,6 @@
 #define MB_POWER	6	/* media bay contains a Power device (???) */
 #define MB_NO		7	/* media bay contains nothing */
 
-int check_media_bay(struct device_node *which_bay, int what);
-
 /* Number of bays in the machine or 0 */
 extern int media_bay_count;
 
@@ -29,6 +27,16 @@ int check_media_bay_by_base(unsigned long base, int what);
 /* called by IDE PMAC host driver to register IDE controller for media bay */
 int media_bay_set_ide_infos(struct device_node *which_bay, unsigned long base,
 			    int irq, ide_hwif_t *hwif);
+
+int check_media_bay(struct device_node *which_bay, int what);
+
+#else
+
+static inline int check_media_bay(struct device_node *which_bay, int what)
+{
+	return -ENODEV;
+}
+
 #endif
 
 #endif /* __KERNEL__ */
