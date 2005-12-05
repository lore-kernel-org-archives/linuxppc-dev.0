Return-Path: <pantelis.antoniou@gmail.com>
Received: from uproxy.gmail.com (uproxy.gmail.com [66.249.92.193])
	by ozlabs.org (Postfix) with ESMTP id 7BF4D68875
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Dec 2005 08:10:50 +1100 (EST)
Received: by uproxy.gmail.com with SMTP id m2so24979uge
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 05 Dec 2005 13:10:48 -0800 (PST)
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Dan Malek <dan@embeddededge.com>, linuxppc-embedded@ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 5 Dec 2005 23:19:01 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200512052319.05395.pantelis.antoniou@gmail.com>
Subject: [PATCH] STXXTC: Delete commented out code.
Reply-To: pantelis.antoniou@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

STXXTC: Deleted commented out code. Ugh.

---
commit 3c8f5b1e6edbe76619011e505e009aad6df0bd91
tree eb1769cf2e0c2095a5d51d28f489e4b3aa44773c
parent fac9bbd80d8f8ab3c6af5a417f804dbf8537c700
author Pantelis Antoniou <pantelis.antoniou@gmail.com> Mon, 05 Dec 2005 23:15:03 +0200
committer Pantelis Antoniou <pantelis.antoniou@gmail.com> Mon, 05 Dec 2005 23:15:03 +0200

 arch/ppc/platforms/stxxtc_setup.c |   11 -------
 drivers/mtd/maps/stxxtc_nor.c     |   58 -------------------------------------
 2 files changed, 0 insertions(+), 69 deletions(-)

diff --git a/arch/ppc/platforms/stxxtc_setup.c b/arch/ppc/platforms/stxxtc_setup.c
--- a/arch/ppc/platforms/stxxtc_setup.c
+++ b/arch/ppc/platforms/stxxtc_setup.c
@@ -30,17 +30,6 @@
 
 /***********************************************************************/
 
-#ifdef CONFIG_FW_ENV
-#include <syslib/fw_env.h>
-
-static const char *ro_vars[] = {
-	"ethaddr", "eth1addr", "adsladdr", "serial#", "usbaddr", "usb1addr", "ver", "board",
-	NULL
-};
-#endif
-
-/***********************************************************************/
-
 static spinlock_t port_spinlock;
 
 unsigned long pin_lock(void)
diff --git a/drivers/mtd/maps/stxxtc_nor.c b/drivers/mtd/maps/stxxtc_nor.c
--- a/drivers/mtd/maps/stxxtc_nor.c
+++ b/drivers/mtd/maps/stxxtc_nor.c
@@ -114,8 +114,6 @@ static struct stxxtc_nor_info info[NR_CH
 	}
 };
 
-#if 1
-
 int __init init_stxxtc_nor(void)
 {
 	struct stxxtc_nor_info *ni;
@@ -262,62 +260,6 @@ static void __exit cleanup_stxxtc_nor(vo
 
 }
 
-#else
-
-int __init init_stxxtc_nor(void)
-{
-	int err = 0;
-	static const char *probes[] = { "cfi_probe", NULL };
-	const char **sv, *s;
-
-	stxxtc_map.virt = (void __iomem *)ioremap(WINDOW_ADDR, WINDOW_SIZE);
-	if (!stxxtc_map.virt) {
-		printk("stxxtc_nor: Failed to ioremap\n");
-		err = -ENXIO;
-		goto out;
-	}
-	simple_map_init(&stxxtc_map);
-
-	sv = probes;
-	while ((s = *sv++) != NULL) {
-		stxxtc_mtd = do_map_probe(s, &stxxtc_map);
-		if (stxxtc_mtd != NULL)
-			break;
-	}
-
-	if (!stxxtc_mtd) {
-		printk(KERN_NOTICE "stxxtc_nor: probe failed flash device: %x at %x\n", WINDOW_SIZE, WINDOW_ADDR);
-		err = -ENXIO;
-		goto out_unmap;
-	}
-
-	stxxtc_mtd->owner = THIS_MODULE;
-	add_mtd_partitions(stxxtc_mtd, pi, NUM_PARTITIONS);
-
-	return 0;
-
-out_unmap:
-	iounmap((void *)stxxtc_map.virt);
-out:
-
-	return err;
-}
-
-static void __exit cleanup_stxxtc_nor(void)
-{
-	if (stxxtc_mtd) {
-		del_mtd_partitions(stxxtc_mtd);
-		map_destroy(stxxtc_mtd);
-		stxxtc_mtd = 0;
-	}
-	if (stxxtc_map.virt) {
-		iounmap(stxxtc_map.virt);
-		stxxtc_map.virt = 0;
-	}
-}
-
-#endif
-
 module_init(init_stxxtc_nor);
 module_exit(cleanup_stxxtc_nor);
 


 
!-------------------------------------------------------------flip-
