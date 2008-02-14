Return-Path: <bzolnier@gmail.com>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.177])
	by ozlabs.org (Postfix) with ESMTP id D59EDDDE06
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 11:22:05 +1100 (EST)
Received: by ik-out-1112.google.com with SMTP id b32so178778ika.1
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 16:22:01 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Date: Thu, 14 Feb 2008 01:36:28 +0100
Message-Id: <20080214003628.12879.96439.sendpatchset@localhost.localdomain>
In-Reply-To: <20080214003621.12879.33868.sendpatchset@localhost.localdomain>
References: <20080214003621.12879.33868.sendpatchset@localhost.localdomain>
Subject: [PATCH 01/11] ide-pmac: remove dead code
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove unused pmac_ide_{check_base,get_irq}() and pmac_find_ide_boot(),
then remove no longer needed ide_majors[] and pmac_ide_count.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ppc/pmac.c |   47 -----------------------------------------------
 1 file changed, 47 deletions(-)

Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -80,7 +80,6 @@ typedef struct pmac_ide_hwif {
 } pmac_ide_hwif_t;
 
 static pmac_ide_hwif_t pmac_ide[MAX_HWIFS];
-static int pmac_ide_count;
 
 enum {
 	controller_ohare,	/* OHare based */
@@ -893,52 +892,6 @@ pmac_ide_get_base(int index)
 	return pmac_ide[index].regbase;
 }
 
-int
-pmac_ide_check_base(unsigned long base)
-{
-	int ix;
-	
- 	for (ix = 0; ix < MAX_HWIFS; ++ix)
-		if (base == pmac_ide[ix].regbase)
-			return ix;
-	return -1;
-}
-
-int
-pmac_ide_get_irq(unsigned long base)
-{
-	int ix;
-
-	for (ix = 0; ix < MAX_HWIFS; ++ix)
-		if (base == pmac_ide[ix].regbase)
-			return pmac_ide[ix].irq;
-	return 0;
-}
-
-static int ide_majors[] = { 3, 22, 33, 34, 56, 57 };
-
-dev_t __init
-pmac_find_ide_boot(char *bootdevice, int n)
-{
-	int i;
-	
-	/*
-	 * Look through the list of IDE interfaces for this one.
-	 */
-	for (i = 0; i < pmac_ide_count; ++i) {
-		char *name;
-		if (!pmac_ide[i].node || !pmac_ide[i].node->full_name)
-			continue;
-		name = pmac_ide[i].node->full_name;
-		if (memcmp(name, bootdevice, n) == 0 && name[n] == 0) {
-			/* XXX should cope with the 2nd drive as well... */
-			return MKDEV(ide_majors[i], 0);
-		}
-	}
-
-	return 0;
-}
-
 /* Suspend call back, should be called after the child devices
  * have actually been suspended
  */
