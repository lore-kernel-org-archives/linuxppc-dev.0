Return-Path: <magnus.damm@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.199])
	by ozlabs.org (Postfix) with ESMTP id E966C2BDB5
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Dec 2004 12:14:44 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 49so380524wri
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Dec 2004 17:14:42 -0800 (PST)
Message-ID: <aec7e5c30412131714327a7c3f@mail.gmail.com>
Date: Tue, 14 Dec 2004 02:14:42 +0100
From: Magnus Damm <magnus.damm@gmail.com>
To: linuxppc-dev@ozlabs.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_2009_21549458.1102986882585"
Subject: [PATCH] drivers/ide/ppc/pmac.c - CONFIG_BLK_DEV_IDEDMA_PMAC
Reply-To: Magnus Damm <magnus.damm@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_2009_21549458.1102986882585
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

The file drivers/ide/ppc/pmac.c in vanilla 2.6.9 and 2.6.10-rc3 will
not compile with some configurations, the attached patch contains the
following fixes:

- Make sure pmac.c compiles with CONFIG_BLK_DEV_IDEDMA_PMAC unset.
- CONFIG_BLK_DEV_IDEDMA_PMAC needs CONFIG_BLK_DEV_IDEDMA_PCI.
- Removes the default value of CONFIG_BLK_DEV_IDEPCI due to recursive deps.

Thanks,

/ magnus

------=_Part_2009_21549458.1102986882585
Content-Type: application/octet-stream; name=linux-2.6.10-rc3-ide_pmac.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linux-2.6.10-rc3-ide_pmac.patch"

diff -urN linux-2.6.10-rc3/drivers/ide/Kconfig linux-2.6.10-rc3-ide_pmac/drivers/ide/Kconfig
--- linux-2.6.10-rc3/drivers/ide/Kconfig	2004-12-13 23:38:32.000000000 +0100
+++ linux-2.6.10-rc3-ide_pmac/drivers/ide/Kconfig	2004-12-14 01:22:19.000000000 +0100
@@ -325,7 +325,6 @@
 
 config BLK_DEV_IDEPCI
 	bool "PCI IDE chipset support" if PCI
-	default BLK_DEV_IDEDMA_PMAC if PPC_PMAC && BLK_DEV_IDEDMA_PMAC
 	help
 	  Say Y here for PCI systems which use IDE drive(s).
 	  This option helps the IDE driver to automatically detect and
@@ -758,7 +757,7 @@
 
 config BLK_DEV_IDEDMA_PMAC
 	bool "PowerMac IDE DMA support"
-	depends on BLK_DEV_IDE_PMAC
+	depends on BLK_DEV_IDE_PMAC && BLK_DEV_IDEDMA_PCI
 	help
 	  This option allows the driver for the built-in IDE controller on
 	  Power Macintoshes and PowerBooks to use DMA (direct memory access)
diff -urN linux-2.6.10-rc3/drivers/ide/ppc/pmac.c linux-2.6.10-rc3-ide_pmac/drivers/ide/ppc/pmac.c
--- linux-2.6.10-rc3/drivers/ide/ppc/pmac.c	2004-12-13 23:38:33.000000000 +0100
+++ linux-2.6.10-rc3-ide_pmac/drivers/ide/ppc/pmac.c	2004-12-14 01:13:50.000000000 +0100
@@ -276,6 +276,8 @@
     {   0, 90,   30 }	/*      4 */
 };
 
+#endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
+
 /* UniNorth 2 ATA/100 timings */
 struct kauai_timing {
 	int	cycle_time;
@@ -297,6 +299,8 @@
 	{ 120	, 0x04000148 }
 };
 
+#ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
+
 static struct kauai_timing	kauai_mdma_timings[] __pmacdata =
 {
 	{ 1260	, 0x00fff000 },
@@ -322,6 +326,11 @@
 	{ 0	, 0 },
 };
 
+static void pmac_ide_setup_dma(pmac_ide_hwif_t *pmif, ide_hwif_t *hwif);
+static int pmac_ide_build_dmatable(ide_drive_t *drive, struct request *rq);
+
+#endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
+
 static inline u32
 kauai_lookup_timing(struct kauai_timing* table, int cycle_time)
 {
@@ -350,14 +359,11 @@
  */
 #define IDE_WAKEUP_DELAY	(1*HZ)
 
-static void pmac_ide_setup_dma(pmac_ide_hwif_t *pmif, ide_hwif_t *hwif);
-static int pmac_ide_build_dmatable(ide_drive_t *drive, struct request *rq);
 static int pmac_ide_tune_chipset(ide_drive_t *drive, u8 speed);
 static void pmac_ide_tuneproc(ide_drive_t *drive, u8 pio);
 static void pmac_ide_selectproc(ide_drive_t *drive);
 static void pmac_ide_kauai_selectproc(ide_drive_t *drive);
 
-#endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
 
 /*
  * Below is the code for blinking the laptop LED along with hard
@@ -1343,12 +1349,16 @@
 		/* The inteface is released to the common IDE layer */
 		dev_set_drvdata(&mdev->ofdev.dev, NULL);
 		iounmap(base);
+#ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 		if (pmif->dma_regs)
 			iounmap(pmif->dma_regs);
+#endif
 		memset(pmif, 0, sizeof(*pmif));
 		macio_release_resource(mdev, 0);
+#ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 		if (pmif->dma_regs)
 			macio_release_resource(mdev, 1);
+#endif
 	}
 
 	return rc;

------=_Part_2009_21549458.1102986882585--
